Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-am1on0092.outbound.protection.outlook.com ([157.56.112.92]:1344
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754447AbcFUHeL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jun 2016 03:34:11 -0400
From: Ilya Lesokhin <ilyal@mellanox.com>
To: Alex Williamson <alex.williamson@redhat.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	Noa Osherovich <noaos@mellanox.com>,
	Haggai Eran <haggaie@mellanox.com>,
	Or Gerlitz <ogerlitz@mellanox.com>,
	Liran Liss <liranl@mellanox.com>
Subject: RE: [PATCH v2 0/2] VFIO SRIOV support
Date: Tue, 21 Jun 2016 07:19:14 +0000
Message-ID: <VI1PR0501MB19680B7AF4C02D4FFC5874A9D42B0@VI1PR0501MB1968.eurprd05.prod.outlook.com>
References: <1466338617-43027-1-git-send-email-ilyal@mellanox.com>
 <20160620113728.74ed79f3@ul30vt.home>
In-Reply-To: <20160620113728.74ed79f3@ul30vt.home>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Why is the need for admin privileges not enough to make it safe?
What's the difference between the following?
	1. A PF is assigned to one user and the admin assigns one of it VFs to a different user.
	2. The admin assign the main network interface of the machine to a VM and bring down all the connectivity of the host.

Indeed we don't address clean up, but we didn't see any adverse effect from the VFs remaining probed by the VFIO driver after the VM is shutdown.

Would you be willing to accept this feature under some kconfig option or if it was allowed only for Privileged processes?
I would hate to throw this feature away just because we can't address every corner case.

Thanks,
Ilya

> -----Original Message-----
> From: Alex Williamson [mailto:alex.williamson@redhat.com]
> Sent: Monday, June 20, 2016 8:37 PM
> To: Ilya Lesokhin <ilyal@mellanox.com>
> Cc: kvm@vger.kernel.org; linux-pci@vger.kernel.org; bhelgaas@google.com;
> Noa Osherovich <noaos@mellanox.com>; Haggai Eran
> <haggaie@mellanox.com>; Or Gerlitz <ogerlitz@mellanox.com>; Liran Liss
> <liranl@mellanox.com>
> Subject: Re: [PATCH v2 0/2] VFIO SRIOV support
> 
> On Sun, 19 Jun 2016 15:16:55 +0300
> Ilya Lesokhin <ilyal@mellanox.com> wrote:
> 
> > Changes from V1:
> > 	1. The VF are no longer assigned to PFs iommu group
> > 	2. Add a pci_enable_sriov_with_override API to allow
> > 	enablind sriov without probing the VFs with the
> > 	default driver
> 
> So without the iommu grouping, but with the driver override, VFs are
> created and bound to vfio-pci, and we just hope for the best from there,
> right?  Is that reasonable?  That means that a user can be granted access to a
> PF, which they can use to create VFs, which automatically get bound to vfio-
> pci, but from there anything can happen.  The user doesn't automatically get
> access to them.  Nothing prevents the devices from being unbound from
> vfio-pci and bound to a host driver, though it does require some admin
> intervention.  Nothing prevents a user created VF from being granted to
> another user.
> Shutdown seems dodgy as well, where does vfio-pci guarantee that a user
> created VF is shutdown when the PF is released?  It seems vfio-pci needs to
> gain some management of VFs, not just as a passthrough from the user.  The
> whole idea still seems fragile and questionably a valid thing we should do, to
> me.  Thanks,
> 
> Alex
> 
> 
> > Changes from RFC V2:
> >         1. pci_disable_sriov() is now called from a workqueue
> >         To avoid the situation where a process is blocked
> >         in pci_disable_sriov() wating for itself to relase the VFs.
> >         2. a mutex was added to synchronize calls to
> >         pci_enable_sriov() and pci_disable_sriov()
> >
> > Changes from RFC V1:
> >         Due to the security concern raised in RFC V1, we add two patches
> >         to make sure the VFs belong to the same IOMMU group as
> >         the PF and are probed by VFIO.
> >
> > Today the QEMU hypervisor allows assigning a physical device to a VM,
> > facilitating driver development. However, it does not support enabling
> > SR-IOV by the VM kernel driver. Our goal is to implement such support,
> > allowing developers working on SR-IOV physical function drivers to
> > work inside VMs as well.
> >
> > This patch series implements the kernel side of our solution.  It
> > extends the VFIO driver to support the PCIE SRIOV extended capability
> > with following features:
> > 1. The ability to probe SR-IOV BAR sizes.
> > 2. The ability to enable and disable SR-IOV.
> >
> > This patch series is going to be used by QEMU to expose SR-IOV
> > capabilities to VM. We already have an early prototype based on Knut
> > Omang's patches for SR-IOV[1].
> >
> > Limitations:
> > 1. Per SR-IOV spec section 3.3.12, PFs are required to support 4-KB,
> > 8-KB, 64-KB, 256-KB, 1-MB, and 4-MB page sizes.
> > Unfourtently the kernel currently initializes the System Page Size
> > register once and assumes it doesn't change therefore we cannot allow
> > guests to change this register at will. We currently map both the
> > Supported Page sizes and System Page Size as virtualized and read only in
> violation of the spec.
> > In practice this is not an issue since both the hypervisor and the
> > guest typically select the same System Page Size.
> >
> > [1] https://github.com/knuto/qemu/tree/sriov_patches_v6
> >
> > Ilya Lesokhin (2):
> >   PCI: Extend PCI IOV API
> >   VFIO: Add support for SR-IOV extended capablity
> >
> >  drivers/pci/iov.c                   |  41 +++++--
> >  drivers/vfio/pci/vfio_pci.c         |   1 +
> >  drivers/vfio/pci/vfio_pci_config.c  | 210
> +++++++++++++++++++++++++++++++++---
> >  drivers/vfio/pci/vfio_pci_private.h |   1 +
> >  include/linux/pci.h                 |  13 ++-
> >  5 files changed, 240 insertions(+), 26 deletions(-)
> >

