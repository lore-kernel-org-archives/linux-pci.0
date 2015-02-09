Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:42741 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759850AbbBIL1t (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Feb 2015 06:27:49 -0500
Date: Mon, 9 Feb 2015 11:27:39 +0000
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
Subject: Re: [PATCH] of: calculate masks of the device based on dma-range size
Message-ID: <20150209112739.GC16587@e104818-lin.cambridge.arm.com>
References: <1423253720-2785-1-git-send-email-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1423253720-2785-1-git-send-email-m-karicheri2@ti.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 06, 2015 at 03:15:20PM -0500, Murali Karicheri wrote:
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index 314c8a9..44209fa 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -83,17 +83,18 @@ int of_device_add(struct platform_device *ofdev)
>   */
>  void of_dma_configure(struct device *dev, struct device_node *np)
>  {
> -	u64 dma_addr, paddr, size;
> +	u64 dma_addr = 0, paddr, size;
>  	int ret;
>  	bool coherent;
> -	unsigned long offset;
> +	unsigned long offset = 0;
>  	struct iommu_ops *iommu;
>  
>  	/*
>  	 * Set default dma-mask to 32 bit. Drivers are expected to setup
>  	 * the correct supported dma_mask.
>  	 */
> -	dev->coherent_dma_mask = DMA_BIT_MASK(32);
> +	if (!dev->coherent_dma_mask)
> +		dev->coherent_dma_mask = DMA_BIT_MASK(32);
>  
>  	/*
>  	 * Set it to coherent_dma_mask by default if the architecture
> @@ -102,11 +103,14 @@ void of_dma_configure(struct device *dev, struct device_node *np)
>  	if (!dev->dma_mask)
>  		dev->dma_mask = &dev->coherent_dma_mask;
>  
> +	/*
> +	 * Set default size to cover the 32-bit. Drivers are expected to setup
> +	 * the correct size and dma_mask.
> +	 */

Nitpick: drivers don't set up the size, just the mask. We read the size
from DT.

> +	size = 1ULL << 32;
> +
>  	ret = of_dma_get_range(np, &dma_addr, &paddr, &size);
> -	if (ret < 0) {
> -		dma_addr = offset = 0;
> -		size = dev->coherent_dma_mask + 1;

Do you assume that, on error, of_dma_get_range() does not touch any of
the dma_addr/paddr/size? It looks safer to me to leave it as the
original.

> -	} else {
> +	if (!ret) {
>  		offset = PFN_DOWN(paddr - dma_addr);
>  
>  		/*
> @@ -128,6 +132,15 @@ void of_dma_configure(struct device *dev, struct device_node *np)
>  
>  	dev->dma_pfn_offset = offset;
>  
> +	/*
> +	 * Limit coherent and dma mask based on size and default mask
> +	 * set by the driver.
> +	 */
> +	dev->coherent_dma_mask = min(dev->coherent_dma_mask,
> +				     DMA_BIT_MASK(ilog2(dma_addr + size)));

Do we need to cover the case where size is incorrectly set to 0 in the
DT? At least some warning and leaving the mask unchanged.

> +	*dev->dma_mask = min((*dev->dma_mask),
> +			     DMA_BIT_MASK(ilog2(dma_addr + size)));
> +
>  	coherent = of_dma_is_coherent(np);
>  	dev_dbg(dev, "device is%sdma coherent\n",
>  		coherent ? " " : " not ");

-- 
Catalin
