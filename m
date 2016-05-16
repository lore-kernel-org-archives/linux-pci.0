Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:34746 "EHLO
	mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752719AbcEPPPj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 16 May 2016 11:15:39 -0400
Received: by mail-lf0-f54.google.com with SMTP id m64so117868789lfd.1
        for <linux-pci@vger.kernel.org>; Mon, 16 May 2016 08:15:38 -0700 (PDT)
Subject: Re: [RFC PATCH 09/11] drivers: acpi: implement acpi_dma_configure
To: Robin Murphy <robin.murphy@arm.com>,
	Timur Tabi <timur@codeaurora.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <1460654743-7896-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1460654743-7896-10-git-send-email-lorenzo.pieralisi@arm.com>
 <CAOZdJXXtZq6uyE+5sseX7M_6Kq8wFG+37qd5TNSusKj=0gd8zA@mail.gmail.com>
 <5714BA5A.2040008@arm.com>
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
Message-ID: <5739E416.6000501@semihalf.com>
Date: Mon, 16 May 2016 17:15:34 +0200
MIME-Version: 1.0
In-Reply-To: <5714BA5A.2040008@arm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 18.04.2016 12:43, Robin Murphy wrote:
> On 15/04/16 19:29, Timur Tabi wrote:
>> On Thu, Apr 14, 2016 at 12:25 PM, Lorenzo Pieralisi
>> <lorenzo.pieralisi@arm.com> wrote:
>>> +void acpi_dma_configure(struct device *dev, enum dev_dma_attr attr)
>>> +{
>>> +       struct iommu_ops *iommu;
>>> +
>>> +       iommu = iort_iommu_configure(dev);
>>> +
>>> +       /*
>>> +        * Assume dma valid range starts at 0 and covers the whole
>>> +        * coherent_dma_mask.
>>> +        */
>>> +       arch_setup_dma_ops(dev, 0, dev->coherent_dma_mask + 1, iommu,
>>> +                          attr == DEV_DMA_COHERENT);
>>> +}
>>
>> I have a network driver that is impacted by this code, so thank you
>> for posting this. (See
>> https://www.mail-archive.com/netdev@vger.kernel.org/msg106249.html).
>>
>> One one SOC, the driver needs to set the mask to 32 bits.  On another
>> SOC, it needs to set it to 64 bits.  On device tree, the driver will
>> use dma-ranges.
>
> That's the wrong way to look at it - the driver isn't _using_
> dma-ranges, you're merely relying on the OF code setting the _default_
> DMA mask differently based on the property. If your driver is in the
> minority of those which actually care about DMA masks, then it should be
> calling dma_set_mask_and_coherent() appropriately and not relying on the
> default.

I don't see the clear strategy for setting DMA mask as well.

Lets consider DT boot method example:
1. SMMUv2 supports 48bit translation and 1:1 address map
dma-ranges = <0x0 0x0 0x0 0x0 0x00010000 0x0>;
and we are adding PCI device:

pci_device_add -> DMA_BIT_MASK(32) by default
   pci_dma_configure
     of_dma_configure -> reads dma-ranges and calculates 48bit DMA mask, 
but it picks minimum, we stay with DMA_BIT_MASK(32)

now PCI dev turns out to be e1000e NIC:
e1000_probe
   dma_set_mask_and_coherent -> tries to set DMA_BIT_MASK(64)
     dma_set_mask -> there is no set_dma_mask ops for SMMUv2 so we let 
it be DMA_BIT_MASK(64). From that point on, we let to use memory which 
SMMUv2 cannot work with.

Does lack of set_dma_mask is the only missing thing here?

Thanks,
Tomasz
