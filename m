Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH V10 06/12] of: device: Fix overflow of coherent_dma_mask
To: Frank Rowand <frowand.list@gmail.com>,
 Sricharan R <sricharan@codeaurora.org>, will.deacon@arm.com,
 joro@8bytes.org, lorenzo.pieralisi@arm.com,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, m.szyprowski@samsung.com,
 bhelgaas@google.com, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
 tn@semihalf.com, hanjun.guo@linaro.org, okaya@codeaurora.org,
 robh+dt@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, sudeep.holla@arm.com, rjw@rjwysocki.net,
 lenb@kernel.org, catalin.marinas@arm.com, arnd@arndb.de,
 linux-arch@vger.kernel.org, gregkh@linuxfoundation.org
References: <1489086061-9356-1-git-send-email-sricharan@codeaurora.org>
 <1491301105-5274-1-git-send-email-sricharan@codeaurora.org>
 <1491301105-5274-7-git-send-email-sricharan@codeaurora.org>
 <58E5E7B7.1050400@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <b081f333-084d-ffa5-635f-f7f1c0232ac3@arm.com>
Date: Thu, 6 Apr 2017 11:24:31 +0100
MIME-Version: 1.0
In-Reply-To: <58E5E7B7.1050400@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 06/04/17 08:01, Frank Rowand wrote:
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
> the base problem very well.

I'm not sure I agree there. Granted, there exist many more problematic
aspects than are dealt with here (I've got more patches cooking to sort
out some of the other issues we have with dma-ranges), but considering
size specifically:

- It is not possible to explicitly specify a range with a size of 2^64
in DT. If someone does specify a size of 0, they've done a silly thing
and should not be surprised that it ends badly.

- It *is* perfectly legitimate for bus code (or a previous device
driver, once we start coming here at probe time) to have set a device's
DMA mask to 0xffffffffffffffffULL. If this code then blindly overflows
and infers an invalid size of 0 from that, breaking things in the
process, that is this code's fault alone. It just so happens that
nothing managed to trigger the latent problem until patch #7 here shakes
up the callsites.

Yes, wacky impossible base + size combinations in DT were a theoretical
problem before, and remain a theoretical problem, but also fall into the
"how did you ever expect this to work?" category. There's certainly
plenty more we can do to improve the DT parsing/validation, but that
still doesn't apply to this path where the information is *not* coming
from the DT at all.

> I agree that the proper solution involves passing a mask instead
> of a size to arch_setup_dma_ops().

Having started writing that patch too, I can tell you it's a big bugger
touching multiple architectures and fixing up various drivers doing
stupid things, hence why I'm happy with this point fix being the lesser
of two evils in terms of not holding up this mostly-orthogonal series.

Robin.

> 
> -Frank
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
