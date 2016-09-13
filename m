Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:51716 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759041AbcIMP0B (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Sep 2016 11:26:01 -0400
Subject: Re: [PATCH v5 07/14] drivers: acpi: iort: add support for ARM SMMU
 platform devices creation
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        iommu@lists.linux-foundation.org
References: <20160909142343.13314-1-lorenzo.pieralisi@arm.com>
 <20160909142343.13314-8-lorenzo.pieralisi@arm.com>
Cc: Hanjun Guo <hanjun.guo@linaro.org>,
        Tomasz Nowicki <tn@semihalf.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Will Deacon <will.deacon@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Jon Masters <jcm@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Nate Watterson <nwatters@codeaurora.org>,
        Prem Mallappa <prem.mallappa@broadcom.com>,
        Dennis Chen <dennis.chen@arm.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <b0de32c2-01a5-2437-daa0-13044526b474@arm.com>
Date: Tue, 13 Sep 2016 16:25:55 +0100
MIME-Version: 1.0
In-Reply-To: <20160909142343.13314-8-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 09/09/16 15:23, Lorenzo Pieralisi wrote:
> In ARM ACPI systems, IOMMU components are specified through static
> IORT table entries. In order to create platform devices for the
> corresponding ARM SMMU components, IORT kernel code should be made
> able to parse IORT table entries and create platform devices
> dynamically.
> 
> This patch adds the generic IORT infrastructure required to create
> platform devices for ARM SMMUs.
> 
> ARM SMMU versions have different resources requirement therefore this
> patch also introduces an IORT specific structure (ie iort_iommu_config)
> that contains hooks (to be defined when the corresponding ARM SMMU
> driver support is added to the kernel) to be used to define the
> platform devices names, init the IOMMUs, count their resources and
> finally initialize them.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Tomasz Nowicki <tn@semihalf.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> ---
>  drivers/acpi/arm64/iort.c | 131 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 131 insertions(+)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index b89b3d3..e0a9b16 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -22,6 +22,7 @@
>  #include <linux/kernel.h>
>  #include <linux/list.h>
>  #include <linux/pci.h>
> +#include <linux/platform_device.h>
>  #include <linux/slab.h>
>  
>  struct iort_its_msi_chip {
> @@ -424,6 +425,135 @@ struct irq_domain *iort_get_device_domain(struct device *dev, u32 req_id)
>  	return irq_find_matching_fwnode(handle, DOMAIN_BUS_PCI_MSI);
>  }
>  
> +struct iort_iommu_config {
> +	const char *name;
> +	int (*iommu_init)(struct acpi_iort_node *node);
> +	bool (*iommu_is_coherent)(struct acpi_iort_node *node);
> +	int (*iommu_count_resources)(struct acpi_iort_node *node);
> +	void (*iommu_init_resources)(struct resource *res,
> +				     struct acpi_iort_node *node);
> +};
> +
> +static __init
> +const struct iort_iommu_config *iort_get_iommu_cfg(struct acpi_iort_node *node)
> +{
> +	return NULL;
> +}
> +
> +/**
> + * iort_add_smmu_platform_device() - Allocate a platform device for SMMU
> + * @fwnode: IORT node associated fwnode handle
> + * @node: Pointer to SMMU ACPI IORT node
> + *
> + * Returns: 0 on success, <0 failure
> + */
> +static int __init iort_add_smmu_platform_device(struct fwnode_handle *fwnode,
> +						struct acpi_iort_node *node)
> +{
> +	struct platform_device *pdev;
> +	struct resource *r;
> +	enum dev_dma_attr attr;
> +	int ret, count;
> +	const struct iort_iommu_config *ops = iort_get_iommu_cfg(node);
> +
> +	if (!ops)
> +		return -ENODEV;
> +
> +	pdev = platform_device_alloc(ops->name, PLATFORM_DEVID_AUTO);
> +	if (!pdev)
> +		return PTR_ERR(pdev);
> +
> +	count = ops->iommu_count_resources(node);
> +
> +	r = kcalloc(count, sizeof(*r), GFP_KERNEL);
> +	if (!r) {
> +		ret = -ENOMEM;
> +		goto dev_put;
> +	}
> +
> +	ops->iommu_init_resources(r, node);
> +
> +	ret = platform_device_add_resources(pdev, r, count);
> +	/*
> +	 * Resources are duplicated in platform_device_add_resources,
> +	 * free their allocated memory
> +	 */
> +	kfree(r);
> +
> +	if (ret)
> +		goto dev_put;
> +
> +	/*
> +	 * Add a copy of IORT node pointer to platform_data to
> +	 * be used to retrieve IORT data information.
> +	 */
> +	ret = platform_device_add_data(pdev, &node, sizeof(node));
> +	if (ret)
> +		goto dev_put;
> +
> +	pdev->dev.dma_mask = kmalloc(sizeof(*pdev->dev.dma_mask), GFP_KERNEL);
> +	if (!pdev->dev.dma_mask) {
> +		ret = -ENOMEM;
> +		goto dev_put;
> +	}

Since this is exclusively for creating SMMUs, and we know they should
never have weird shenanigans going on requiring different masks, I'd be
inclined to just point dev.dma_mask at dev.coherent_dma_mask and be done
with it.

> +
> +	pdev->dev.fwnode = fwnode;
> +
> +	/*
> +	 * Set default dma mask value for the table walker,
> +	 * to be overridden on probing with correct value.
> +	 */
> +	*pdev->dev.dma_mask = DMA_BIT_MASK(32);
> +	pdev->dev.coherent_dma_mask = *pdev->dev.dma_mask;
> +
> +	attr = ops->iommu_is_coherent(node) ?
> +			     DEV_DMA_COHERENT : DEV_DMA_NON_COHERENT;
> +
> +	/* Configure DMA for the page table walker */
> +	acpi_dma_configure(&pdev->dev, attr);

Oh look, some more code which would be simpler if acpi_dma_configure()
set the default mask itself ;)

Robin.

> +
> +	ret = platform_device_add(pdev);
> +	if (ret)
> +		goto dma_deconfigure;
> +
> +	return 0;
> +
> +dma_deconfigure:
> +	acpi_dma_deconfigure(&pdev->dev);
> +	kfree(pdev->dev.dma_mask);
> +
> +dev_put:
> +	platform_device_put(pdev);
> +
> +	return ret;
> +}
> +
> +static acpi_status __init iort_match_iommu_callback(struct acpi_iort_node *node,
> +						    void *context)
> +{
> +	int ret;
> +	struct fwnode_handle *fwnode;
> +
> +	fwnode = iort_get_fwnode(node);
> +
> +	if (!fwnode)
> +		return AE_NOT_FOUND;
> +
> +	ret = iort_add_smmu_platform_device(fwnode, node);
> +	if (ret) {
> +		pr_err("Error in platform device creation\n");
> +		return AE_ERROR;
> +	}
> +
> +	return AE_OK;
> +}
> +
> +static void __init iort_smmu_init(void)
> +{
> +	iort_scan_node(ACPI_IORT_NODE_SMMU, iort_match_iommu_callback, NULL);
> +	iort_scan_node(ACPI_IORT_NODE_SMMU_V3, iort_match_iommu_callback, NULL);
> +}
> +
>  void __init acpi_iort_init(void)
>  {
>  	acpi_status status;
> @@ -436,4 +566,5 @@ void __init acpi_iort_init(void)
>  	}
>  
>  	acpi_probe_device_table(iort);
> +	iort_smmu_init();
>  }
> 

