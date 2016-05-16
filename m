Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [RFC PATCH 09/11] drivers: acpi: implement acpi_dma_configure
To: Robin Murphy <robin.murphy@arm.com>,
	Timur Tabi <timur@codeaurora.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <1460654743-7896-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1460654743-7896-10-git-send-email-lorenzo.pieralisi@arm.com>
 <CAOZdJXXtZq6uyE+5sseX7M_6Kq8wFG+37qd5TNSusKj=0gd8zA@mail.gmail.com>
 <5714BA5A.2040008@arm.com> <5739E416.6000501@semihalf.com>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, vikrams@codeaurora.org,
	Marc Zyngier <marc.zyngier@arm.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	lkml <linux-kernel@vger.kernel.org>,
	Will Deacon <will.deacon@arm.com>,
	Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org,
	iommu@lists.linux-foundation.org,
	Hanjun Guo <hanjun.guo@linaro.org>, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jon Masters <jcm@redhat.com>
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <5739E68B.2080907@semihalf.com>
Date: Mon, 16 May 2016 17:26:03 +0200
MIME-Version: 1.0
In-Reply-To: <5739E416.6000501@semihalf.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 16.05.2016 17:15, Tomasz Nowicki wrote:
> On 18.04.2016 12:43, Robin Murphy wrote:
>> On 15/04/16 19:29, Timur Tabi wrote:
>>> On Thu, Apr 14, 2016 at 12:25 PM, Lorenzo Pieralisi
>>> <lorenzo.pieralisi@arm.com> wrote:
>>>> +void acpi_dma_configure(struct device *dev, enum dev_dma_attr attr)
>>>> +{
>>>> +       struct iommu_ops *iommu;
>>>> +
>>>> +       iommu = iort_iommu_configure(dev);
>>>> +
>>>> +       /*
>>>> +        * Assume dma valid range starts at 0 and covers the whole
>>>> +        * coherent_dma_mask.
>>>> +        */
>>>> +       arch_setup_dma_ops(dev, 0, dev->coherent_dma_mask + 1, iommu,
>>>> +                          attr == DEV_DMA_COHERENT);
>>>> +}
>>>
>>> I have a network driver that is impacted by this code, so thank you
>>> for posting this. (See
>>> https://www.mail-archive.com/netdev@vger.kernel.org/msg106249.html).
>>>
>>> One one SOC, the driver needs to set the mask to 32 bits.  On another
>>> SOC, it needs to set it to 64 bits.  On device tree, the driver will
>>> use dma-ranges.
>>
>> That's the wrong way to look at it - the driver isn't _using_
>> dma-ranges, you're merely relying on the OF code setting the _default_
>> DMA mask differently based on the property. If your driver is in the
>> minority of those which actually care about DMA masks, then it should be
>> calling dma_set_mask_and_coherent() appropriately and not relying on the
>> default.
>
> I don't see the clear strategy for setting DMA mask as well.
>
> Lets consider DT boot method example:
> 1. SMMUv2 supports 48bit translation and 1:1 address map
> dma-ranges = <0x0 0x0 0x0 0x0 0x00010000 0x0>;
> and we are adding PCI device:
>
> pci_device_add -> DMA_BIT_MASK(32) by default
>    pci_dma_configure
>      of_dma_configure -> reads dma-ranges and calculates 48bit DMA mask,
> but it picks minimum, we stay with DMA_BIT_MASK(32)
>
> now PCI dev turns out to be e1000e NIC:
> e1000_probe
>    dma_set_mask_and_coherent -> tries to set DMA_BIT_MASK(64)
>      dma_set_mask -> there is no set_dma_mask ops for SMMUv2 so we let

Sorry, there is no .set_dma_mask ops for ARM64 (not SMMUv2)

Tomasz
