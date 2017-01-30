Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Sricharan" <sricharan@codeaurora.org>
To: "'Robin Murphy'" <robin.murphy@arm.com>,
        "'Tomasz Nowicki'" <tn@semihalf.com>, <will.deacon@arm.com>,
        <joro@8bytes.org>, <lorenzo.pieralisi@arm.com>,
        <iommu@lists.linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <m.szyprowski@samsung.com>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>
References: <1485188293-20263-1-git-send-email-sricharan@codeaurora.org> <1485188293-20263-2-git-send-email-sricharan@codeaurora.org> <4388779a-0e83-fadc-83f4-98c46c88d42e@semihalf.com> <c7bad124-d9f2-0ddf-168f-0b1950d3e1ed@arm.com> <009901d278c7$34fee230$9efca690$@codeaurora.org> <d27f04da-7d34-9640-1639-790d0732ed93@arm.com>
In-Reply-To: <d27f04da-7d34-9640-1639-790d0732ed93@arm.com>
Subject: RE: [PATCH V7 01/11] iommu/of: Refactor of_iommu_configure() for error handling
Date: Mon, 30 Jan 2017 12:30:11 +0530
Message-ID: <003601d27ac6$84866840$8d9338c0$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Robin,

>> [..]
>>
>>>>> +const struct iommu_ops *of_iommu_configure(struct device *dev,
>>>>> +                       struct device_node *master_np)
>>>>> +{
>>>>> +    const struct iommu_ops *ops;
>>>>> +
>>>>> +    if (!master_np)
>>>>> +        return NULL;
>>>>> +
>>>>> +    if (dev_is_pci(dev))
>>>>> +        ops = of_pci_iommu_init(to_pci_dev(dev), master_np);
>>>>
>>>> I gave the whole patch set a try on ThunderX. really_probe() is failing
>>>> on dma_configure()->of_pci_iommu_init() for each PCI device.
>>>
>>> When you say "failing", do you mean cleanly, or with a crash? I've
>>> managed to hit __of_match_node() dereferencing NULL from
>>> of_iommu_xlate() in a horribly complicated chain of events, which I'm
>>> trying to figure out now, and I wonder if the two might be related.
>>
>> Sorry that there is crash still. __of_match_node seems to checking
>> for NULL arguments , feels like some invalid pointer was passed in.
>> Is there any particular sequence to try for this ?
>
>Ah, I did figure it out - it wasn't actually a NULL dereference, but an
>unmapped address. Turns out __iommu_of_table is in initdata, so any
>driver probing after init, connected to an unprobed IOMMU (in this case
>disabled in DT), trips over trying to match the now-freed table. I'm
>working on the fix - technically the bug's in my patch (#2) anyway ;)
>

Ok, thanks for bringing this out. There is also an issue that
Sinan has mentioned while testing the ACPI hotplug path, probably
its related to the above, not sure. I will try to check more on that
in the meanwhile. Then, taking your fix and fixing the hotplug case
i will do one more repost.

Regards,
 Sricharan

