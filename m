Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH V10 06/12] of: device: Fix overflow of coherent_dma_mask
To: Sricharan R <sricharan@codeaurora.org>, robin.murphy@arm.com,
        will.deacon@arm.com, joro@8bytes.org, lorenzo.pieralisi@arm.com,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, m.szyprowski@samsung.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, tn@semihalf.com, hanjun.guo@linaro.org,
        okaya@codeaurora.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        catalin.marinas@arm.com, arnd@arndb.de, linux-arch@vger.kernel.org,
        gregkh@linuxfoundation.org
References: <1489086061-9356-1-git-send-email-sricharan@codeaurora.org>
 <1491301105-5274-1-git-send-email-sricharan@codeaurora.org>
 <1491301105-5274-7-git-send-email-sricharan@codeaurora.org>
 <58E5E7B7.1050400@gmail.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <58E81C63.3020701@gmail.com>
Date: Fri, 7 Apr 2017 16:10:27 -0700
MIME-Version: 1.0
In-Reply-To: <58E5E7B7.1050400@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/06/17 00:01, Frank Rowand wrote:
> On 04/04/17 03:18, Sricharan R wrote:
>> Size of the dma-range is calculated as coherent_dma_mask + 1
>> and passed to arch_setup_dma_ops further. It overflows when
>> the coherent_dma_mask is set for full 64 bits 0xFFFFFFFFFFFFFFFF,
>> resulting in size getting passed as 0 wrongly. Fix this by
>> passsing in max(mask, mask + 1). Note that in this case
>> when the mask is set to full 64bits, we will be passing the mask
>> itself to arch_setup_dma_ops instead of the size. The real fix
>> for this should be to make arch_setup_dma_ops receive the
>> mask and handle it, to be done in the future.
>>
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> ---
>>  drivers/of/device.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/of/device.c b/drivers/of/device.c
>> index c17c19d..c2ae6bb 100644
>> --- a/drivers/of/device.c
>> +++ b/drivers/of/device.c
>> @@ -107,7 +107,7 @@ void of_dma_configure(struct device *dev, struct device_node *np)
>>  	ret = of_dma_get_range(np, &dma_addr, &paddr, &size);
>>  	if (ret < 0) {
>>  		dma_addr = offset = 0;
>> -		size = dev->coherent_dma_mask + 1;
>> +		size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);

NACK withdrawn below.

However, I would prefer a change to this line for readability. Using max() results
in the correct result, but obscures the reason behind the algorithm, where the
intent is to avoid an overflow.  How about something like:

	size = (dev->coherent_dma_mask == 0xffffffffffffffffULL)
		? 0xffffffffffffffffULL : dev->coherent_dma_mask + 1;


>>  	} else {
>>  		offset = PFN_DOWN(paddr - dma_addr);
>>  		dev_dbg(dev, "dma_pfn_offset(%#08lx)\n", offset);
>>
> 
> NACK.
> 
> Passing an invalid size to arch_setup_dma_ops() is only part of the problem.
> size is also used in of_dma_configure() before calling arch_setup_dma_ops():
> 
>         dev->coherent_dma_mask = min(dev->coherent_dma_mask,
>                                      DMA_BIT_MASK(ilog2(dma_addr + size)));
>         *dev->dma_mask = min((*dev->dma_mask),
>                              DMA_BIT_MASK(ilog2(dma_addr + size)));
> 
> which would be incorrect for size == 0xffffffffffffffffULL when
> dma_addr != 0.  So the proposed fix really is not papering over

  ^^^^^^^^^^^^^  This is the flaw in my objection.  When in the
(ret < 0) path, dma_addr is set to zero.  So my worry about dma_addr != 0
is baseless.

I withdraw my NACK because my analysis was flawed.

-Frank

> the base problem very well.
> 
> I agree that the proper solution involves passing a mask instead
> of a size to arch_setup_dma_ops().
> 
> -Frank
> 

