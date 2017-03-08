Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:43366 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752170AbdCHKQf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Mar 2017 05:16:35 -0500
Message-ID: <58BFB2DA.2070306@intel.com>
Date: Wed, 08 Mar 2017 15:29:30 +0800
From: Jike Song <jike.song@intel.com>
MIME-Version: 1.0
To: Ilya Lesokhin <ilyal@mellanox.com>
CC: kvm@vger.kernel.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com, alex.williamson@redhat.com,
        noaos@mellanox.com, haggaie@mellanox.com, ogerlitz@mellanox.com,
        liranl@mellanox.com, "You, Lizhen" <lizhen.you@intel.com>
Subject: Re: [PATCH V3 0/3] VFIO SRIOV support
References: <1471505357-78110-1-git-send-email-ilyal@mellanox.com>
In-Reply-To: <1471505357-78110-1-git-send-email-ilyal@mellanox.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 08/18/2016 03:29 PM, Ilya Lesokhin wrote:
> Changes from V2:
>         1. Enabling and disabling SR-IOV is now done
>         through the sysfs interface, requiring
>         admin privileges.
>         2. Since admin privileges are now required
>         to enable SR-IOV most of the the security
>         measures introduced in RFC V2 were removed.
>         Unfortunately we still need a mutex to prevent
>         the VFIO user from changing the number of
>         VFs while enable_sriov is in progress.
> 
> Changes from V1:
>         1. The VF are no longer assigned to PFs iommu group
>         2. Add a pci_enable_sriov_with_override API to allow
>         enablind sriov without probing the VFs with the
>         default driver
> 
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
> Ilya Lesokhin (3):
>   pci: Extend PCI IOV API
>   vfio/pci: Allow control SR-IOV through sysfs interface
>   vfio/pci: Add support for SR-IOV extended capablity
> 
>  drivers/pci/iov.c                   |  41 ++++++++--
>  drivers/vfio/pci/vfio_pci.c         |  43 ++++++++--
>  drivers/vfio/pci/vfio_pci_config.c  | 151 ++++++++++++++++++++++++++++++++----
>  drivers/vfio/pci/vfio_pci_private.h |   2 +
>  include/linux/pci.h                 |  13 +++-
>  5 files changed, 219 insertions(+), 31 deletions(-)
> 

+Lizhen


Hi Ilya,

Sorry for jumping in abruptly. We are also looking forward to have PF
used within a VM, would you please share your next plan with us? Likely
there will be a v4 shortly?


--
Thanks,
Jike
