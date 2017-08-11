Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752724AbdHKRRw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Aug 2017 13:17:52 -0400
Date: Fri, 11 Aug 2017 12:17:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jon Derrick <jonathan.derrick@intel.com>
Cc: linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        David Woodhouse <dwmw2@infradead.org>,
        Keith Busch <keith.busch@intel.com>,
        Scott Bauer <scott.bauer@intel.com>,
        David Fugate <david.fugate@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iommu: prevent VMD child devices from being
 remapping targets
Message-ID: <20170811171750.GC17039@bhelgaas-glaptop.roam.corp.google.com>
References: <20170807195713.10963-1-jonathan.derrick@intel.com>
 <20170807195713.10963-3-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170807195713.10963-3-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 07, 2017 at 01:57:13PM -0600, Jon Derrick wrote:
> VMD child devices must use the VMD endpoint's ID as the DMA source.
> Because of this, there needs to be a way to link the parent VMD
> endpoint's DMAR domain to the VMD child devices' DMAR domain such that
> attaching and detaching child devices modify the endpoint's DMAR mapping
> and prevents early detaching.
> 
> This is outside the scope of VMD, so disable binding child devices to
> prevent unforeseen issues. This functionality may be implemented in the
> future.
> 
> This patch prevents VMD child devices from returning an IOMMU, which
> prevents it from exposing iommu_group sysfs directories and subsequent
> binding by userspace-access drivers such as VFIO.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
>  drivers/iommu/intel-iommu.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 687f18f..651a6cd 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -905,6 +905,11 @@ static struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devf
>  		 * the PF instead to find the IOMMU. */
>  		pf_pdev = pci_physfn(pdev);
>  		dev = &pf_pdev->dev;
> +
> +		/* VMD child devices currently cannot be handled individually */
> +		if (pci_bus_is_vmd(pdev->bus))

Aah, this is the bigger reason why you want a general "is VMD" thing.
But this is still basically x86-specific code (I do see the ia64 in
Kconfig, so I guess maybe ia64 as well).

But pci_bus_is_vmd() doesn't feel like a generally useful concept.  I
see why you need things like this quirk, but it's not clear what
useful things other code could do with pci_bus_is_vmd() because we
don't have a generic concept of how VMD buses are different than other
PCI buses.

> +			return NULL;
> +
>  		segment = pci_domain_nr(pdev->bus);
>  	} else if (has_acpi_companion(dev))
>  		dev = &ACPI_COMPANION(dev)->dev;
> -- 
> 2.9.4
> 
