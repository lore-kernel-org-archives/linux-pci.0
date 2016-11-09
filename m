Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:56238 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753299AbcKIOoL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Nov 2016 09:44:11 -0500
Subject: Re: [PATCH v7 06/16] drivers: iommu: arm-smmu-v3: convert struct
 device of_node to fwnode usage
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        iommu@lists.linux-foundation.org
References: <20161109141948.19244-1-lorenzo.pieralisi@arm.com>
 <20161109141948.19244-7-lorenzo.pieralisi@arm.com>
Cc: Will Deacon <will.deacon@arm.com>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Tomasz Nowicki <tn@semihalf.com>, Jon Masters <jcm@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Nate Watterson <nwatters@codeaurora.org>,
        Prem Mallappa <prem.mallappa@broadcom.com>,
        Dennis Chen <dennis.chen@arm.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <5d824cfb-6b38-405d-d5f6-96590247efd8@arm.com>
Date: Wed, 9 Nov 2016 14:44:07 +0000
MIME-Version: 1.0
In-Reply-To: <20161109141948.19244-7-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 09/11/16 14:19, Lorenzo Pieralisi wrote:
> Current ARM SMMU v3 driver rely on the struct device.of_node pointer for
> device look-up and iommu_ops retrieval.
> 
> In preparation for ACPI probing enablement, convert the driver to use
> the struct device.fwnode member for device and iommu_ops look-up so that
> the driver infrastructure can be used also on systems that do not
> associate an of_node pointer to a struct device (eg ACPI), making the
> device look-up and iommu_ops retrieval firmware agnostic.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
> Tested-by: Tomasz Nowicki <tn@semihalf.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> ---
>  drivers/iommu/arm-smmu-v3.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index e6f9b2d..fef9f60 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -1723,13 +1723,14 @@ static struct platform_driver arm_smmu_driver;
>  
>  static int arm_smmu_match_node(struct device *dev, void *data)
>  {
> -	return dev->of_node == data;
> +	return dev->fwnode == data;
>  }
>  
> -static struct arm_smmu_device *arm_smmu_get_by_node(struct device_node *np)
> +static
> +struct arm_smmu_device *arm_smmu_get_by_fwnode(struct fwnode_handle *fwnode)
>  {
>  	struct device *dev = driver_find_device(&arm_smmu_driver.driver, NULL,
> -						np, arm_smmu_match_node);
> +						fwnode, arm_smmu_match_node);
>  	put_device(dev);
>  	return dev ? dev_get_drvdata(dev) : NULL;
>  }
> @@ -1765,7 +1766,7 @@ static int arm_smmu_add_device(struct device *dev)
>  		master = fwspec->iommu_priv;
>  		smmu = master->smmu;
>  	} else {
> -		smmu = arm_smmu_get_by_node(to_of_node(fwspec->iommu_fwnode));
> +		smmu = arm_smmu_get_by_fwnode(fwspec->iommu_fwnode);
>  		if (!smmu)
>  			return -ENODEV;
>  		master = kzalloc(sizeof(*master), GFP_KERNEL);
> @@ -2634,7 +2635,8 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
>  		return ret;
>  
>  	/* And we're up. Go go go! */
> -	of_iommu_set_ops(dev->of_node, &arm_smmu_ops);
> +	fwnode_iommu_set_ops(dev->fwnode, &arm_smmu_ops);
> +
>  #ifdef CONFIG_PCI
>  	if (pci_bus_type.iommu_ops != &arm_smmu_ops) {
>  		pci_request_acs();
> 

