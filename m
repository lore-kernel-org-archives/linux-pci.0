Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54030 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752555AbbLVPgA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 22 Dec 2015 10:36:00 -0500
Message-ID: <1450798558.22385.7.camel@redhat.com>
Subject: Re: [RFC 0/2] VFIO SRIOV support
From: Alex Williamson <alex.williamson@redhat.com>
To: Ilya Lesokhin <ilyal@mellanox.com>, kvm@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, noaos@mellanox.com, haggaie@mellanox.com,
	ogerlitz@mellanox.com, liranl@mellanox.com
Date: Tue, 22 Dec 2015 08:35:58 -0700
In-Reply-To: <1450791734-3907-1-git-send-email-ilyal@mellanox.com>
References: <1450791734-3907-1-git-send-email-ilyal@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2015-12-22 at 15:42 +0200, Ilya Lesokhin wrote:
> Today the QEMU hypervisor allows assigning a physical device to a VM,
> facilitating driver development. However, it does not support
> enabling
> SR-IOV by the VM kernel driver. Our goal is to implement such
> support,
> allowing developers working on SR-IOV physical function drivers to
> work
> inside VMs as well.
> 
> This patch series implements the kernel side of our solution.  It
> extends
> the VFIO driver to support the PCIE SRIOV extended capability with
> following features:
> 1. The ability to probe SRIOV BAR sizes.
> 2. The ability to enable and disable sriov.
> 
> This patch series is going to be used by QEMU to expose sriov
> capabilities
> to VM. We already have an early prototype based on Knut Omang's
> patches for
> SRIOV[1]. 
> 
> Open issues:
> 1. Binding the new VFs to VFIO driver.
> Once the VM enables sriov it expects the new VFs to appear inside the
> VM.
> To this end we need to bind the new vfs to the VFIO driver and have
> QEMU
> grab them. We are currently achieve this goal using:
> echo $vendor $device > /sys/bus/pci/drivers/vfio-pci/new_id
> but we are not happy about this solution as a system might have
> another
> device with the same id that is unrelated to our VM.
> Other solution we've considered are:
>  a. Having user space unbind and then bind the VFs to VFIO.
>      Typically resulting in an unnecessary probing of the device.
>  b. Adding a driver argument to pci_enable_sriov(...) and have
>     vfio call pci_enable_sriov with the vfio driver as argument.
>     This solution avoids the unnecessary but is more intrusive.

You could use driver_override for this, but the open issue you haven't
listed is the ownership problem, VFs will be in separate iommu groups
and therefore create separate vfio groups.  How do those get associated
with the user so that we don't have one user controlling the VFs for
another user, or worse for the host kernel.  Whatever solution you come
up with needs to protect the host kernel, first and foremost.  It's not
sufficient to rely on userspace to grab the VFs and sequester them for
use only by that user, the host kernel needs to provide that security
automatically.  Thanks,

Alex

> 2. How to tell if it is safe to disable SRIOV?
> In the current implementation, a userspace can enable sriov, grab one
> of
> the VFs and then call disable sriov without releasing the
> device.  This
> will result in a deadlock where the user process is stuck inside
> disable
> sriov waiting for itself to release the device. Killing the process
> leaves
> it in a zombie state.
> We also get a strange warning saying:
> [  181.668492] WARNING: CPU: 22 PID: 3684 at kernel/sched/core.c:7497
> __might_sleep+0x77/0x80() 
> [  181.668502] do not call blocking ops when !TASK_RUNNING; state=1
> set at [<ffffffff810aa193>] prepare_to_wait_event+0x63/0xf0
> 
> 3. How to expose the Supported Page Sizes and System Page Size
> registers in
> the SRIOV capability? 
> Presently the hypervisor initializes Supported Page Sizes once and
> assumes
> it doesn't change therefore we cannot allow user space to change this
> register at will. The first solution that comes to mind is to expose
> a
> device that only supports the page size selected by the hypervisor.
> Unfourtently, Per SR-IOV spec section 3.3.12, PFs are required to
> support
> 4-KB, 8-KB, 64-KB, 256-KB, 1-MB, and 4-MB page sizes. We currently
> map both
> registers as virtualized and read only and leave user space to worry
> about
> this problem.
> 
> 4. Other SRIOV capabilities.
> Do we want to hide capabilities we do not support in the SR-IOV
> Capabilities register? or leave it to the userspace application?
> 
> [1] https://github.com/knuto/qemu/tree/sriov_patches_v6
> 
> Ilya Lesokhin (2):
>   PCI: Expose iov_set_numvfs and iov_resource_size for modules.
>   VFIO: Add support for SRIOV extended capablity
> 
>  drivers/pci/iov.c                  |   4 +-
>  drivers/vfio/pci/vfio_pci_config.c | 169
> +++++++++++++++++++++++++++++++++----
>  include/linux/pci.h                |   4 +
>  3 files changed, 159 insertions(+), 18 deletions(-)
> 

