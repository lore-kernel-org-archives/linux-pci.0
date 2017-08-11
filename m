Return-Path: <SRS0=4Q29=7N=arm.com=robin.murphy@kernel.org>
Return-Path: <SRS0=4Q29=7N=arm.com=robin.murphy@kernel.org>
Subject: Re: [PATCH 3/3] iommu: prevent VMD child devices from being remapping
 targets
To: Jon Derrick <jonathan.derrick@intel.com>, linux-pci@vger.kernel.org,
 iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>, David Fugate <david.fugate@intel.com>,
 David Woodhouse <dwmw2@infradead.org>, Scott Bauer <scott.bauer@intel.com>
References: <20170807195713.10963-1-jonathan.derrick@intel.com>
 <20170807195713.10963-3-jonathan.derrick@intel.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <fda8e2c5-11da-7189-794c-59a68273e4d8@arm.com>
Date: Fri, 11 Aug 2017 19:25:52 +0100
MIME-Version: 1.0
In-Reply-To: <20170807195713.10963-3-jonathan.derrick@intel.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 07/08/17 20:57, Jon Derrick wrote:
> VMD child devices must use the VMD endpoint's ID as the DMA source.
> Because of this, there needs to be a way to link the parent VMD
> endpoint's DMAR domain to the VMD child devices' DMAR domain such that
> attaching and detaching child devices modify the endpoint's DMAR mapping
> and prevents early detaching.

That sounds like either pci_device_group() needs modifying, or perhaps
that intel-iommu needs its own extended iommu_ops::device_group
implementation, to ensure that VMD child devices get put in the same
group as their parent - if they share requester IDs they can't feasibly
be attached to different domains anyway.

Robin.

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
> +			return NULL;
> +
>  		segment = pci_domain_nr(pdev->bus);
>  	} else if (has_acpi_companion(dev))
>  		dev = &ACPI_COMPANION(dev)->dev;
> 
