Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-db3on0097.outbound.protection.outlook.com ([157.55.234.97]:40704
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933814AbbLWKSK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 23 Dec 2015 05:18:10 -0500
From: Ilya Lesokhin <ilyal@mellanox.com>
To: Alex Williamson <alex.williamson@redhat.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
	Noa Osherovich <noaos@mellanox.com>,
	Haggai Eran <haggaie@mellanox.com>,
	Or Gerlitz <ogerlitz@mellanox.com>,
	Liran Liss <liranl@mellanox.com>
Subject: RE: [RFC 0/2] VFIO SRIOV support
Date: Wed, 23 Dec 2015 07:43:57 +0000
Message-ID: <VI1PR05MB1119CACA2E294B58EDB54A9AD4E60@VI1PR05MB1119.eurprd05.prod.outlook.com>
References: <1450791734-3907-1-git-send-email-ilyal@mellanox.com>
 <1450798558.22385.7.camel@redhat.com>
In-Reply-To: <1450798558.22385.7.camel@redhat.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Alex,
Regarding driver_override, as far as I know you can only use it on devices that were already discovered. Since the devices do not exist before the call to pci_enable_sriov(...)
and are already probed after the call  it wouldn't really help us. I would have to unbind them from their default driver and bind them to VFIO like solution a in my original mail.

You are right about the ownership problem and we would like to receive input regarding what is the correct way of solving this. 
But in the meantime I think our solution is quite useful even though if it requires root privileges. We hacked libvirt so that it would run qemu as root and without device cgroup.

In any case, don't you think that assigning those devices to VFIO should be safe? Does the VFIO driver makes any unsafe assumptions on the VF's that might allow a guest to crash the hypervisor?

I am somewhat concerned that the VM  could trigger some backdoor reset while the hypervisor is running pci_enable_sriov(...). But I'm not really sure how to solve it.
I guess you have to either stop the guest entirely to enable sriov or make it privileged.

Regarding having the PF controlled by one user while the other VFs are controlled by other user, I actually think it might be an interesting use case.

Thanks,
Ilya


-----Original Message-----
From: Alex Williamson [mailto:alex.williamson@redhat.com] 
Sent: Tuesday, December 22, 2015 5:36 PM
To: Ilya Lesokhin <ilyal@mellanox.com>; kvm@vger.kernel.org; linux-pci@vger.kernel.org
Cc: bhelgaas@google.com; Noa Osherovich <noaos@mellanox.com>; Haggai Eran <haggaie@mellanox.com>; Or Gerlitz <ogerlitz@mellanox.com>; Liran Liss <liranl@mellanox.com>
Subject: Re: [RFC 0/2] VFIO SRIOV support

On Tue, 2015-12-22 at 15:42 +0200, Ilya Lesokhin wrote:
> Today the QEMU hypervisor allows assigning a physical device to a VM, 
> facilitating driver development. However, it does not support enabling 
> SR-IOV by the VM kernel driver. Our goal is to implement such support, 
> allowing developers working on SR-IOV physical function drivers to 
> work inside VMs as well.
> 
> This patch series implements the kernel side of our solution.  It 
> extends the VFIO driver to support the PCIE SRIOV extended capability 
> with following features:
> 1. The ability to probe SRIOV BAR sizes.
> 2. The ability to enable and disable sriov.
> 
> This patch series is going to be used by QEMU to expose sriov 
> capabilities to VM. We already have an early prototype based on Knut 
> Omang's patches for SRIOV[1].
> 
> Open issues:
> 1. Binding the new VFs to VFIO driver.
> Once the VM enables sriov it expects the new VFs to appear inside the 
> VM.
> To this end we need to bind the new vfs to the VFIO driver and have 
> QEMU grab them. We are currently achieve this goal using:
> echo $vendor $device > /sys/bus/pci/drivers/vfio-pci/new_id
> but we are not happy about this solution as a system might have 
> another device with the same id that is unrelated to our VM.
> Other solution we've considered are:
>  a. Having user space unbind and then bind the VFs to VFIO.
>      Typically resulting in an unnecessary probing of the device.
>  b. Adding a driver argument to pci_enable_sriov(...) and have
>     vfio call pci_enable_sriov with the vfio driver as argument.
>     This solution avoids the unnecessary but is more intrusive.

You could use driver_override for this, but the open issue you haven't listed is the ownership problem, VFs will be in separate iommu groups and therefore create separate vfio groups.  How do those get associated with the user so that we don't have one user controlling the VFs for another user, or worse for the host kernel.  Whatever solution you come up with needs to protect the host kernel, first and foremost.  It's not sufficient to rely on userspace to grab the VFs and sequester them for use only by that user, the host kernel needs to provide that security automatically.  Thanks,

Alex

> 2. How to tell if it is safe to disable SRIOV?
> In the current implementation, a userspace can enable sriov, grab one 
> of the VFs and then call disable sriov without releasing the device.  
> This will result in a deadlock where the user process is stuck inside 
> disable sriov waiting for itself to release the device. Killing the 
> process leaves it in a zombie state.
> We also get a strange warning saying:
> [  181.668492] WARNING: CPU: 22 PID: 3684 at kernel/sched/core.c:7497
> __might_sleep+0x77/0x80()
> [  181.668502] do not call blocking ops when !TASK_RUNNING; state=1 
> set at [<ffffffff810aa193>] prepare_to_wait_event+0x63/0xf0
> 
> 3. How to expose the Supported Page Sizes and System Page Size 
> registers in the SRIOV capability?
> Presently the hypervisor initializes Supported Page Sizes once and 
> assumes it doesn't change therefore we cannot allow user space to 
> change this register at will. The first solution that comes to mind is 
> to expose a device that only supports the page size selected by the 
> hypervisor.
> Unfourtently, Per SR-IOV spec section 3.3.12, PFs are required to 
> support 4-KB, 8-KB, 64-KB, 256-KB, 1-MB, and 4-MB page sizes. We 
> currently map both registers as virtualized and read only and leave 
> user space to worry about this problem.
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

