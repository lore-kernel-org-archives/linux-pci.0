Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39367 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932815AbcFTRjh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 20 Jun 2016 13:39:37 -0400
Date: Mon, 20 Jun 2016 11:37:28 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Ilya Lesokhin <ilyal@mellanox.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org,
	bhelgaas@google.com, noaos@mellanox.com, haggaie@mellanox.com,
	ogerlitz@mellanox.com, liranl@mellanox.com
Subject: Re: [PATCH v2 0/2] VFIO SRIOV support
Message-ID: <20160620113728.74ed79f3@ul30vt.home>
In-Reply-To: <1466338617-43027-1-git-send-email-ilyal@mellanox.com>
References: <1466338617-43027-1-git-send-email-ilyal@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, 19 Jun 2016 15:16:55 +0300
Ilya Lesokhin <ilyal@mellanox.com> wrote:

> Changes from V1:
> 	1. The VF are no longer assigned to PFs iommu group
> 	2. Add a pci_enable_sriov_with_override API to allow
> 	enablind sriov without probing the VFs with the
> 	default driver

So without the iommu grouping, but with the driver override, VFs are
created and bound to vfio-pci, and we just hope for the best from
there, right?  Is that reasonable?  That means that a user can be
granted access to a PF, which they can use to create VFs, which
automatically get bound to vfio-pci, but from there anything can
happen.  The user doesn't automatically get access to them.  Nothing
prevents the devices from being unbound from vfio-pci and bound to a
host driver, though it does require some admin intervention.  Nothing
prevents a user created VF from being granted to another user.
Shutdown seems dodgy as well, where does vfio-pci guarantee that a user
created VF is shutdown when the PF is released?  It seems vfio-pci
needs to gain some management of VFs, not just as a passthrough from
the user.  The whole idea still seems fragile and questionably a valid
thing we should do, to me.  Thanks,

Alex

 
> Changes from RFC V2:
>         1. pci_disable_sriov() is now called from a workqueue
>         To avoid the situation where a process is blocked
>         in pci_disable_sriov() wating for itself to relase the VFs.
>         2. a mutex was added to synchronize calls to
>         pci_enable_sriov() and pci_disable_sriov()
> 
> Changes from RFC V1:
>         Due to the security concern raised in RFC V1, we add two patches
>         to make sure the VFs belong to the same IOMMU group as
>         the PF and are probed by VFIO.
> 
> Today the QEMU hypervisor allows assigning a physical device to a VM,
> facilitating driver development. However, it does not support enabling
> SR-IOV by the VM kernel driver. Our goal is to implement such support,
> allowing developers working on SR-IOV physical function drivers to work
> inside VMs as well.
> 
> This patch series implements the kernel side of our solution.  It extends
> the VFIO driver to support the PCIE SRIOV extended capability with
> following features:
> 1. The ability to probe SR-IOV BAR sizes.
> 2. The ability to enable and disable SR-IOV.
> 
> This patch series is going to be used by QEMU to expose SR-IOV capabilities
> to VM. We already have an early prototype based on Knut Omang's patches for
> SR-IOV[1].
> 
> Limitations:
> 1. Per SR-IOV spec section 3.3.12, PFs are required to support
> 4-KB, 8-KB, 64-KB, 256-KB, 1-MB, and 4-MB page sizes.
> Unfourtently the kernel currently initializes the System Page Size register once
> and assumes it doesn't change therefore we cannot allow guests to change this
> register at will. We currently map both the Supported Page sizes and
> System Page Size as virtualized and read only in violation of the spec.
> In practice this is not an issue since both the hypervisor and the
> guest typically select the same System Page Size.
> 
> [1] https://github.com/knuto/qemu/tree/sriov_patches_v6
> 
> Ilya Lesokhin (2):
>   PCI: Extend PCI IOV API
>   VFIO: Add support for SR-IOV extended capablity
> 
>  drivers/pci/iov.c                   |  41 +++++--
>  drivers/vfio/pci/vfio_pci.c         |   1 +
>  drivers/vfio/pci/vfio_pci_config.c  | 210 +++++++++++++++++++++++++++++++++---
>  drivers/vfio/pci/vfio_pci_private.h |   1 +
>  include/linux/pci.h                 |  13 ++-
>  5 files changed, 240 insertions(+), 26 deletions(-)
> 

