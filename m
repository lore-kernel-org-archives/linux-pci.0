Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:51466 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751180AbcKRPoO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Nov 2016 10:44:14 -0500
Date: Fri, 18 Nov 2016 15:44:13 +0000
From: Will Deacon <will.deacon@arm.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: iommu@lists.linux-foundation.org,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Tomasz Nowicki <tn@semihalf.com>, Jon Masters <jcm@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Nate Watterson <nwatters@codeaurora.org>,
        Prem Mallappa <prem.mallappa@broadcom.com>,
        Dennis Chen <dennis.chen@arm.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 10/16] drivers: iommu: arm-smmu-v3: split probe
 functions into DT/generic portions
Message-ID: <20161118154413.GU13470@arm.com>
References: <20161116152936.22955-1-lorenzo.pieralisi@arm.com>
 <20161116152936.22955-11-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161116152936.22955-11-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 16, 2016 at 03:29:30PM +0000, Lorenzo Pieralisi wrote:
> Current ARM SMMUv3 probe functions intermingle HW and DT probing in the
> initialization functions to detect and programme the ARM SMMU v3 driver
> features. In order to allow probing the ARM SMMUv3 with other firmwares
> than DT, this patch splits the ARM SMMUv3 init functions into DT and HW
> specific portions so that other FW interfaces (ie ACPI) can reuse the HW
> probing functions and skip the DT portion accordingly.
> 
> This patch implements no functional change, only code reshuffling.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Acked-by: Will Deacon <will.deacon@arm.com>
> Reviewed-by: Tomasz Nowicki <tn@semihalf.com>
> Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
> Tested-by: Tomasz Nowicki <tn@semihalf.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> ---
>  drivers/iommu/arm-smmu-v3.c | 46 +++++++++++++++++++++++++++++----------------
>  1 file changed, 30 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index e6e1c87..ed563307 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -2381,10 +2381,10 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
>  	return 0;
>  }
>  
> -static int arm_smmu_device_probe(struct arm_smmu_device *smmu)
> +static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
>  {
>  	u32 reg;
> -	bool coherent;
> +	bool coherent = smmu->features & ARM_SMMU_FEAT_COHERENCY;
>  
>  	/* IDR0 */
>  	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR0);
> @@ -2436,13 +2436,9 @@ static int arm_smmu_device_probe(struct arm_smmu_device *smmu)
>  		smmu->features |= ARM_SMMU_FEAT_HYP;
>  
>  	/*
> -	 * The dma-coherent property is used in preference to the ID
> +	 * The coherency feature as set by FW is used in preference to the ID
>  	 * register, but warn on mismatch.
>  	 */
> -	coherent = of_dma_is_coherent(smmu->dev->of_node);
> -	if (coherent)
> -		smmu->features |= ARM_SMMU_FEAT_COHERENCY;
> -
>  	if (!!(reg & IDR0_COHACC) != coherent)
>  		dev_warn(smmu->dev, "IDR0.COHACC overridden by dma-coherent property (%s)\n",
>  			 coherent ? "true" : "false");
> @@ -2563,21 +2559,37 @@ static int arm_smmu_device_probe(struct arm_smmu_device *smmu)
>  	return 0;
>  }
>  
> -static int arm_smmu_device_dt_probe(struct platform_device *pdev)
> +static int arm_smmu_device_dt_probe(struct platform_device *pdev,
> +				    struct arm_smmu_device *smmu,
> +				    bool *bypass)
>  {
> -	int irq, ret;
> -	struct resource *res;
> -	struct arm_smmu_device *smmu;
>  	struct device *dev = &pdev->dev;
> -	bool bypass = true;
>  	u32 cells;
>  
> +	*bypass = true;
> +
>  	if (of_property_read_u32(dev->of_node, "#iommu-cells", &cells))
>  		dev_err(dev, "missing #iommu-cells property\n");
>  	else if (cells != 1)
>  		dev_err(dev, "invalid #iommu-cells value (%d)\n", cells);
>  	else
> -		bypass = false;
> +		*bypass = false;
> +
> +	parse_driver_options(smmu);
> +
> +	if (of_dma_is_coherent(dev->of_node))
> +		smmu->features |= ARM_SMMU_FEAT_COHERENCY;
> +
> +	return 0;

I know you're only moving code here, but the *bypass output parameter
now seems to be redundant with the unconditional return 0. Given that
we only set bypass to true if something went wrong, why don't we return
-ENODEV in those cases, kill the bypass parameter and rework the return
value check in the caller so that, rather than fail the probe, we pass
bypass=true to the reset function?

Will
