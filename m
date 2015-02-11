Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss-mx-na.arm.com ([217.140.108.86]:43279 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753132AbbBKSsE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Feb 2015 13:48:04 -0500
Date: Wed, 11 Feb 2015 18:47:54 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Murali Karicheri <m-karicheri2@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will.deacon@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH v1] of: calculate masks of the device based on dma-range
 size
Message-ID: <20150211184754.GH9058@e104818-lin.cambridge.arm.com>
References: <1423677215-28968-1-git-send-email-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1423677215-28968-1-git-send-email-m-karicheri2@ti.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 11, 2015 at 12:53:35PM -0500, Murali Karicheri wrote:
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index 314c8a9..167ad2d 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -90,10 +90,11 @@ void of_dma_configure(struct device *dev, struct device_node *np)
>  	struct iommu_ops *iommu;
>  
>  	/*
> -	 * Set default dma-mask to 32 bit. Drivers are expected to setup
> -	 * the correct supported dma_mask.
> +	 * Set default coherent_dma_mask to 32 bit. Drivers are expected to
> +	 * setup the correct supported mask.
>  	 */
> -	dev->coherent_dma_mask = DMA_BIT_MASK(32);
> +	if (!dev->coherent_dma_mask)
> +		dev->coherent_dma_mask = DMA_BIT_MASK(32);
>  
>  	/*
>  	 * Set it to coherent_dma_mask by default if the architecture
> @@ -102,6 +103,11 @@ void of_dma_configure(struct device *dev, struct device_node *np)
>  	if (!dev->dma_mask)
>  		dev->dma_mask = &dev->coherent_dma_mask;
>  
> +	/*
> +	 * Use default size to cover 32 bit. Drivers need to set this in DT
> +	 * to override the same.
> +	 */
> +	size = 1ULL << 32;

I'm not sure this is needed since on error path the original code would
set the size to coherent_dma_mask.

>  	ret = of_dma_get_range(np, &dma_addr, &paddr, &size);
>  	if (ret < 0) {
>  		dma_addr = offset = 0;

Here we already have (not seen in the context):

		size = dev->coherent_dma_mask + 1;

> @@ -128,6 +134,15 @@ void of_dma_configure(struct device *dev, struct device_node *np)
>  
>  	dev->dma_pfn_offset = offset;
>  
> +	/*
> +	 * Limit coherent and dma mask based on size and default mask
> +	 * set by the driver.
> +	 */
> +	dev->coherent_dma_mask = min(dev->coherent_dma_mask,
> +				     DMA_BIT_MASK(ilog2(dma_addr + size)));
> +	*dev->dma_mask = min((*dev->dma_mask),
> +			     DMA_BIT_MASK(ilog2(dma_addr + size)));
> +
>  	coherent = of_dma_is_coherent(np);
>  	dev_dbg(dev, "device is%sdma coherent\n",
>  		coherent ? " " : " not ");

Otherwise it looks fine to me.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
