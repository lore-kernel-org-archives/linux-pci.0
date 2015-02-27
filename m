Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35898 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752181AbbB0Umk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 27 Feb 2015 15:42:40 -0500
Message-ID: <54F0D688.5090006@ti.com>
Date: Fri, 27 Feb 2015 15:41:44 -0500
From: Murali Karicheri <m-karicheri2@ti.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Will Deacon <will.deacon@arm.com>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v1] of: calculate masks of the device based on dma-range
 size
References: <1423677215-28968-1-git-send-email-m-karicheri2@ti.com> <20150226002033.GR6220@google.com>
In-Reply-To: <20150226002033.GR6220@google.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 02/25/2015 07:20 PM, Bjorn Helgaas wrote:
> [+cc Catalin]
>
> On Wed, Feb 11, 2015 at 12:53:35PM -0500, Murali Karicheri wrote:
>> This patch update of_dma_configure() API to calculate the
>> masks (dma_mask and coherent_dma_mask) based on the dma-range
>> values set in DT for the device. Also limit the mask to lower
>> of the default mask and mask calculated.
>>
>> Cc: Joerg Roedel<joro@8bytes.org>
>> Cc: Grant Likely<grant.likely@linaro.org>
>> Cc: Rob Herring<robh+dt@kernel.org>
>> Cc: Bjorn Helgaas<bhelgaas@google.com>
>> Cc: Will Deacon<will.deacon@arm.com>
>> Cc: Russell King<linux@arm.linux.org.uk>
>> Cc: Arnd Bergmann<arnd@arndb.de>
>> Cc: Suravee Suthikulpanit<Suravee.Suthikulpanit@amd.com>
>>
>> Signed-off-by: Murali Karicheri<m-karicheri2@ti.com>
>
> Applied with Catalin's reviewed-by to pci/iommu for v4.1, thanks!
>
> I agree with Catalin's comment about the "size = 1ULL<<  32" line.
> I don't see how that will make a difference, so I dropped it.  The
> patch I merged is below.  Let me know if you think we do need that
> line or any other tweaks.
>
> Bjorn
>
> commit a5a1dd69080dfcf53bfd6e179f3db68e824aeaae
> Author: Murali Karicheri<m-karicheri2@ti.com>
> Date:   Wed Feb 25 17:21:04 2015 -0600
>
>      of: Calculate device DMA masks based on DT dma-range size
>
>      Calculate the dma_mask and coherent_dma_mask based on the dma-range values
>      set in DT for the device.
>
>      Limit the mask to lower of the default mask and mask calculated.
>
>      Signed-off-by: Murali Karicheri<m-karicheri2@ti.com>
>      Signed-off-by: Bjorn Helgaas<bhelgaas@google.com>
>      Reviewed-by: Catalin Marinas<catalin.marinas@arm.com>
>      CC: Joerg Roedel<joro@8bytes.org>
>      CC: Grant Likely<grant.likely@linaro.org>
>      CC: Rob Herring<robh+dt@kernel.org>
>      CC: Will Deacon<will.deacon@arm.com>
>      CC: Russell King<linux@arm.linux.org.uk>
>      CC: Arnd Bergmann<arnd@arndb.de>
>      CC: Suravee Suthikulpanit<Suravee.Suthikulpanit@amd.com>
>
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index 28e743888402..20c1332a0018 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -90,10 +90,11 @@ void of_dma_configure(struct device *dev, struct device_node *np)
>   	struct iommu_ops *iommu;
>
>   	/*
> -	 * Set default dma-mask to 32 bit.  Drivers are expected to setup
> -	 * the correct supported dma_mask.
> +	 * Set default coherent_dma_mask to 32 bit.  Drivers are expected to
> +	 * setup the correct supported mask.
>   	 */
> -	dev->coherent_dma_mask = DMA_BIT_MASK(32);
> +	if (!dev->coherent_dma_mask)
> +		dev->coherent_dma_mask = DMA_BIT_MASK(32);
>
>   	/*
>   	 * Set it to coherent_dma_mask by default if the architecture
> @@ -128,6 +129,15 @@ void of_dma_configure(struct device *dev, struct device_node *np)
>
>   	dev->dma_pfn_offset = offset;
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
>   	coherent = of_dma_is_coherent(np);
>   	dev_dbg(dev, "device is%sdma coherent\n",
>   		coherent ? " " : " not ");
Bjorn,

Thanks. Looks good to me.

Murali

-- 
Murali Karicheri
Linux Kernel, Texas Instruments
