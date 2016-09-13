Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:53512 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755003AbcIMQ3H (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Sep 2016 12:29:07 -0400
Date: Tue, 13 Sep 2016 17:29:25 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux-foundation.org,
        Hanjun Guo <hanjun.guo@linaro.org>,
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
Subject: Re: [PATCH v5 07/14] drivers: acpi: iort: add support for ARM SMMU
 platform devices creation
Message-ID: <20160913162925.GC2436@red-moon>
References: <20160909142343.13314-1-lorenzo.pieralisi@arm.com>
 <20160909142343.13314-8-lorenzo.pieralisi@arm.com>
 <b0de32c2-01a5-2437-daa0-13044526b474@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b0de32c2-01a5-2437-daa0-13044526b474@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 13, 2016 at 04:25:55PM +0100, Robin Murphy wrote:

[...]

> > +/**
> > + * iort_add_smmu_platform_device() - Allocate a platform device for SMMU
> > + * @fwnode: IORT node associated fwnode handle
> > + * @node: Pointer to SMMU ACPI IORT node
> > + *
> > + * Returns: 0 on success, <0 failure
> > + */
> > +static int __init iort_add_smmu_platform_device(struct fwnode_handle *fwnode,
> > +						struct acpi_iort_node *node)
> > +{
> > +	struct platform_device *pdev;
> > +	struct resource *r;
> > +	enum dev_dma_attr attr;
> > +	int ret, count;
> > +	const struct iort_iommu_config *ops = iort_get_iommu_cfg(node);
> > +
> > +	if (!ops)
> > +		return -ENODEV;
> > +
> > +	pdev = platform_device_alloc(ops->name, PLATFORM_DEVID_AUTO);
> > +	if (!pdev)
> > +		return PTR_ERR(pdev);
> > +
> > +	count = ops->iommu_count_resources(node);
> > +
> > +	r = kcalloc(count, sizeof(*r), GFP_KERNEL);
> > +	if (!r) {
> > +		ret = -ENOMEM;
> > +		goto dev_put;
> > +	}
> > +
> > +	ops->iommu_init_resources(r, node);
> > +
> > +	ret = platform_device_add_resources(pdev, r, count);
> > +	/*
> > +	 * Resources are duplicated in platform_device_add_resources,
> > +	 * free their allocated memory
> > +	 */
> > +	kfree(r);
> > +
> > +	if (ret)
> > +		goto dev_put;
> > +
> > +	/*
> > +	 * Add a copy of IORT node pointer to platform_data to
> > +	 * be used to retrieve IORT data information.
> > +	 */
> > +	ret = platform_device_add_data(pdev, &node, sizeof(node));
> > +	if (ret)
> > +		goto dev_put;
> > +
> > +	pdev->dev.dma_mask = kmalloc(sizeof(*pdev->dev.dma_mask), GFP_KERNEL);
> > +	if (!pdev->dev.dma_mask) {
> > +		ret = -ENOMEM;
> > +		goto dev_put;
> > +	}
> 
> Since this is exclusively for creating SMMUs, and we know they should
> never have weird shenanigans going on requiring different masks, I'd be
> inclined to just point dev.dma_mask at dev.coherent_dma_mask and be done
> with it.

That sounds reasonable yes, I will do.

> > +
> > +	pdev->dev.fwnode = fwnode;
> > +
> > +	/*
> > +	 * Set default dma mask value for the table walker,
> > +	 * to be overridden on probing with correct value.
> > +	 */
> > +	*pdev->dev.dma_mask = DMA_BIT_MASK(32);
> > +	pdev->dev.coherent_dma_mask = *pdev->dev.dma_mask;
> > +
> > +	attr = ops->iommu_is_coherent(node) ?
> > +			     DEV_DMA_COHERENT : DEV_DMA_NON_COHERENT;
> > +
> > +	/* Configure DMA for the page table walker */
> > +	acpi_dma_configure(&pdev->dev, attr);
> 
> Oh look, some more code which would be simpler if acpi_dma_configure()
> set the default mask itself ;)

Eheh I have no objections, apart from the effect that change can
have on non-ARM probing paths, it could also help remove some code
from ACPI core while at it.

Thanks !
Lorenzo

> 
> Robin.
> 
> > +
> > +	ret = platform_device_add(pdev);
> > +	if (ret)
> > +		goto dma_deconfigure;
> > +
> > +	return 0;
> > +
> > +dma_deconfigure:
> > +	acpi_dma_deconfigure(&pdev->dev);
> > +	kfree(pdev->dev.dma_mask);
> > +
> > +dev_put:
> > +	platform_device_put(pdev);
> > +
> > +	return ret;
> > +}
> > +
> > +static acpi_status __init iort_match_iommu_callback(struct acpi_iort_node *node,
> > +						    void *context)
> > +{
> > +	int ret;
> > +	struct fwnode_handle *fwnode;
> > +
> > +	fwnode = iort_get_fwnode(node);
> > +
> > +	if (!fwnode)
> > +		return AE_NOT_FOUND;
> > +
> > +	ret = iort_add_smmu_platform_device(fwnode, node);
> > +	if (ret) {
> > +		pr_err("Error in platform device creation\n");
> > +		return AE_ERROR;
> > +	}
> > +
> > +	return AE_OK;
> > +}
> > +
> > +static void __init iort_smmu_init(void)
> > +{
> > +	iort_scan_node(ACPI_IORT_NODE_SMMU, iort_match_iommu_callback, NULL);
> > +	iort_scan_node(ACPI_IORT_NODE_SMMU_V3, iort_match_iommu_callback, NULL);
> > +}
> > +
> >  void __init acpi_iort_init(void)
> >  {
> >  	acpi_status status;
> > @@ -436,4 +566,5 @@ void __init acpi_iort_init(void)
> >  	}
> >  
> >  	acpi_probe_device_table(iort);
> > +	iort_smmu_init();
> >  }
> > 
> 
