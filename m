Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38722 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753319AbbBKRNx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 11 Feb 2015 12:13:53 -0500
Message-ID: <54DB8DA5.7000204@ti.com>
Date: Wed, 11 Feb 2015 12:13:09 -0500
From: Murali Karicheri <m-karicheri2@ti.com>
MIME-Version: 1.0
To: Catalin Marinas <catalin.marinas@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will.deacon@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH] of: calculate masks of the device based on dma-range
 size
References: <1423253720-2785-1-git-send-email-m-karicheri2@ti.com> <20150209112739.GC16587@e104818-lin.cambridge.arm.com>
In-Reply-To: <20150209112739.GC16587@e104818-lin.cambridge.arm.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 02/09/2015 06:27 AM, Catalin Marinas wrote:
> On Fri, Feb 06, 2015 at 03:15:20PM -0500, Murali Karicheri wrote:
>> diff --git a/drivers/of/device.c b/drivers/of/device.c
>> index 314c8a9..44209fa 100644
>> --- a/drivers/of/device.c
>> +++ b/drivers/of/device.c
>> @@ -83,17 +83,18 @@ int of_device_add(struct platform_device *ofdev)
>>    */
>>   void of_dma_configure(struct device *dev, struct device_node *np)
>>   {
>> -	u64 dma_addr, paddr, size;
>> +	u64 dma_addr = 0, paddr, size;
>>   	int ret;
>>   	bool coherent;
>> -	unsigned long offset;
>> +	unsigned long offset = 0;
>>   	struct iommu_ops *iommu;
>>
>>   	/*
>>   	 * Set default dma-mask to 32 bit. Drivers are expected to setup
>>   	 * the correct supported dma_mask.
>>   	 */
>> -	dev->coherent_dma_mask = DMA_BIT_MASK(32);
>> +	if (!dev->coherent_dma_mask)
>> +		dev->coherent_dma_mask = DMA_BIT_MASK(32);
>>
>>   	/*
>>   	 * Set it to coherent_dma_mask by default if the architecture
>> @@ -102,11 +103,14 @@ void of_dma_configure(struct device *dev, struct device_node *np)
>>   	if (!dev->dma_mask)
>>   		dev->dma_mask =&dev->coherent_dma_mask;
>>
>> +	/*
>> +	 * Set default size to cover the 32-bit. Drivers are expected to setup
>> +	 * the correct size and dma_mask.
>> +	 */
>
> Nitpick: drivers don't set up the size, just the mask. We read the size
> from DT.

Not sure how this came, I will update this.
>
>> +	size = 1ULL<<  32;
>> +
>>   	ret = of_dma_get_range(np,&dma_addr,&paddr,&size);
>> -	if (ret<  0) {
>> -		dma_addr = offset = 0;
>> -		size = dev->coherent_dma_mask + 1;
>
> Do you assume that, on error, of_dma_get_range() does not touch any of
> the dma_addr/paddr/size? It looks safer to me to leave it as the
> original.
I think dma_addr and paddr is both modified on error. So this change 
can't be done. I will revert the logic back to original.
>
>> -	} else {
>> +	if (!ret) {
>>   		offset = PFN_DOWN(paddr - dma_addr);
>>
>>   		/*
>> @@ -128,6 +132,15 @@ void of_dma_configure(struct device *dev, struct device_node *np)
>>
>>   	dev->dma_pfn_offset = offset;
>>
>> +	/*
>> +	 * Limit coherent and dma mask based on size and default mask
>> +	 * set by the driver.
>> +	 */
>> +	dev->coherent_dma_mask = min(dev->coherent_dma_mask,
>> +				     DMA_BIT_MASK(ilog2(dma_addr + size)));
>
> Do we need to cover the case where size is incorrectly set to 0 in the
> DT? At least some warning and leaving the mask unchanged.

The previous series already warn and return if the size is incorrect 
(Patch v6 3/7) and leave the dma mask unchanged. So we don't have to do 
anything in this patch. I will fix the above and re-send.
>
>> +	*dev->dma_mask = min((*dev->dma_mask),
>> +			     DMA_BIT_MASK(ilog2(dma_addr + size)));
>> +
>>   	coherent = of_dma_is_coherent(np);
>>   	dev_dbg(dev, "device is%sdma coherent\n",
>>   		coherent ? " " : " not ");
>


-- 
Murali Karicheri
Linux Kernel, Texas Instruments
