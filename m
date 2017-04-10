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
 <b77e3405-f060-bcd5-99f6-7d76f9edf08a@codeaurora.org>
 <58E69831.6010306@gmail.com> <b38312b0-268b-ed86-a5b3-886f86ea13f5@arm.com>
 <58E81D01.8030606@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <c740e7e6-9a36-51fe-c207-980e8e077e94@arm.com>
Date: Mon, 10 Apr 2017 14:25:22 +0100
MIME-Version: 1.0
In-Reply-To: <58E81D01.8030606@gmail.com>
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

On 08/04/17 00:13, Frank Rowand wrote:
> On 04/07/17 07:46, Robin Murphy wrote:
>> On 06/04/17 20:34, Frank Rowand wrote:
>>> On 04/06/17 04:01, Sricharan R wrote:
>>>> Hi Frank,
>>>>
>>>> On 4/6/2017 12:31 PM, Frank Rowand wrote:
>>>>> On 04/04/17 03:18, Sricharan R wrote:
>>>>>> Size of the dma-range is calculated as coherent_dma_mask + 1
>>>>>> and passed to arch_setup_dma_ops further. It overflows when
>>>>>> the coherent_dma_mask is set for full 64 bits 0xFFFFFFFFFFFFFFFF,
>>>>>> resulting in size getting passed as 0 wrongly. Fix this by
>>>>>> passsing in max(mask, mask + 1). Note that in this case
>>>>>> when the mask is set to full 64bits, we will be passing the mask
>>>>>> itself to arch_setup_dma_ops instead of the size. The real fix
>>>>>> for this should be to make arch_setup_dma_ops receive the
>>>>>> mask and handle it, to be done in the future.
>>>>>>
>>>>>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>>>>>> ---
>>>>>>  drivers/of/device.c | 2 +-
>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/of/device.c b/drivers/of/device.c
>>>>>> index c17c19d..c2ae6bb 100644
>>>>>> --- a/drivers/of/device.c
>>>>>> +++ b/drivers/of/device.c
>>>>>> @@ -107,7 +107,7 @@ void of_dma_configure(struct device *dev, struct device_node *np)
>>>>>>      ret = of_dma_get_range(np, &dma_addr, &paddr, &size);
>>>>>>      if (ret < 0) {
>>>>>>          dma_addr = offset = 0;
>>>>>> -        size = dev->coherent_dma_mask + 1;
>>>>>> +        size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);
>>>>>>      } else {
>>>>>>          offset = PFN_DOWN(paddr - dma_addr);
>>>>>>          dev_dbg(dev, "dma_pfn_offset(%#08lx)\n", offset);
>>>>>>
>>>>>
>>>>> NACK.
>>>>>
>>>>> Passing an invalid size to arch_setup_dma_ops() is only part of the problem.
>>>>> size is also used in of_dma_configure() before calling arch_setup_dma_ops():
>>>>>
>>>>>         dev->coherent_dma_mask = min(dev->coherent_dma_mask,
>>>>>                                      DMA_BIT_MASK(ilog2(dma_addr + size)));
>>>>>         *dev->dma_mask = min((*dev->dma_mask),
>>>>>                              DMA_BIT_MASK(ilog2(dma_addr + size)));
>>>>>
>>>>> which would be incorrect for size == 0xffffffffffffffffULL when
>>>>> dma_addr != 0.  So the proposed fix really is not papering over
>>>>> the base problem very well.
>>>>>
>>>>
>>>> Ok, but with your fix for of_dma_get_range and the above fix,
>>>> dma_addr will be '0' when size = 0xffffffffffffffffULL,
>>>> but DMA_BIT_MASK(ilog2(dma_addr + size)) would be wrong though,
>>>> making coherent_dma_mask to be smaller 0x7fffffffffffffffULL.
>>>
>>> Yes, that was my point.  Setting size to 0x7fffffffffffffffULL
>>> affects several places.  Another potential location (based only
>>> on the function header comment, not from reading the code) is
>>> iommu_dma_init_domain().  The header comment says:
>>>
>>>     * @base and @size should be exact multiples of IOMMU page granularity to
>>>     * avoid rounding surprises.
>>
>> That is really only referring to the fact that some of the work done
>> therein involves truncation to PFNs, so anyone passing in non-exact
>> values expecting them to round a particular way may get things off by a
>> page one way or the other. It's not going to have much practical
>> significance for real devices (in particular since size is used more as
>> a sanity check than any kind of actual limit there).
>>
>>> I have not read enough context to really understand of_dma_configure(), but
>>> it seems there is yet another issue in how the error return case from
>>> of_dma_get_range() is handled (with the existing code, as well as if
>>> my patch gets accepted).  An error return value can mean _either_
>>> there is no dma-ranges property _or_ "an other problem occurred".  Should
>>> the "an other problem occurred" case be handled by defaulting size to
>>> a value based on dev->coherent_dma_mask (the current case) or should the
>>> attempt to set up the DMA configuration just fail?
>>
>> There is indeed a lot wrong with of_dma_configure() and
>> arch_setup_dma_ops(), but fixing those is beyond the scope of this
>> series. This is just working around a latent bug in the one specific
>> case where a value is *not* derived from DT. Any DT which worked before
>> still works; any DT which made of_dma_configure() go wrong before still
>> makes of_dma_configure() go wrong exactly the same.
>>
>> Whilst it's not ideal, since a DMA mask basically represents the maximum
>> size of address that that particular device can be given, I can't see it
>> making any practical difference for a full 64-bit DMA mask to be trimmed
>> down to 63 bits upon re-probing - no system is likely to have that many
>> physical address bits anyway, and I don't think any IOMMUs support that
>> large an IOVA space either, so as long as it's still big enough to cover
>> "everything", it'll be OK.
>>
>> Of course, whether DMA_BIT_MASK(ilog2(dma_addr + size)) is the right
>> thing to do in the first place is yet another matter, as there are
>> plenty of cases where it results in something which can't reach the
>> given range at all, but again, this isn't the place. Much as I'm keen to
>> get the behaviour of of_dma_configure() sorted out properly, it doesn't
>> seem reasonable that that should suddenly block this
>> almost-entirely-orthogonal series that various other work has been
>> waiting on for some time now. The WIP patch I have for
>> arch_setup_dma_ops() already touches 3 architectures and 4 other
>> subsystems...
> 
> In a reply to my original NACK email, I just now retracted the NACK,
> but with a requested change for readability.
> 
> I buy your analysis and argument here.  The patch will improve things
> a little, but it will be good to revisit of_dma_configure() in the
> future to further clean things up.

Thanks! As mentioned, I have some patches brewing in this area which
should hopefully help somewhat; I'll try to get them posted this week.

Robin.

> 
> -Frank
> 
>>
>> Robin.
>>
>>>
>>>>
>>>> Regards,
>>>>  Sricharan
>>>>
>>>>> I agree that the proper solution involves passing a mask instead
>>>>> of a size to arch_setup_dma_ops().
>>>>>
>>>>
>>>
>>
>>
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
