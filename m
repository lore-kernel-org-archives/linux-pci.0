Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [RFC PATCH 09/11] drivers: acpi: implement acpi_dma_configure
To: Timur Tabi <timur@codeaurora.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <1460654743-7896-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1460654743-7896-10-git-send-email-lorenzo.pieralisi@arm.com>
 <CAOZdJXXtZq6uyE+5sseX7M_6Kq8wFG+37qd5TNSusKj=0gd8zA@mail.gmail.com>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, vikrams@codeaurora.org,
	Marc Zyngier <marc.zyngier@arm.com>,
	Tomasz Nowicki <tn@semihalf.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	lkml <linux-kernel@vger.kernel.org>,
	Will Deacon <will.deacon@arm.com>,
	Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org,
	iommu@lists.linux-foundation.org,
	Hanjun Guo <hanjun.guo@linaro.org>, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jon Masters <jcm@redhat.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <5714BA5A.2040008@arm.com>
Date: Mon, 18 Apr 2016 11:43:38 +0100
MIME-Version: 1.0
In-Reply-To: <CAOZdJXXtZq6uyE+5sseX7M_6Kq8wFG+37qd5TNSusKj=0gd8zA@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 15/04/16 19:29, Timur Tabi wrote:
> On Thu, Apr 14, 2016 at 12:25 PM, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
>> +void acpi_dma_configure(struct device *dev, enum dev_dma_attr attr)
>> +{
>> +       struct iommu_ops *iommu;
>> +
>> +       iommu = iort_iommu_configure(dev);
>> +
>> +       /*
>> +        * Assume dma valid range starts at 0 and covers the whole
>> +        * coherent_dma_mask.
>> +        */
>> +       arch_setup_dma_ops(dev, 0, dev->coherent_dma_mask + 1, iommu,
>> +                          attr == DEV_DMA_COHERENT);
>> +}
>
> I have a network driver that is impacted by this code, so thank you
> for posting this. (See
> https://www.mail-archive.com/netdev@vger.kernel.org/msg106249.html).
>
> One one SOC, the driver needs to set the mask to 32 bits.  On another
> SOC, it needs to set it to 64 bits.  On device tree, the driver will
> use dma-ranges.

That's the wrong way to look at it - the driver isn't _using_ 
dma-ranges, you're merely relying on the OF code setting the _default_ 
DMA mask differently based on the property. If your driver is in the 
minority of those which actually care about DMA masks, then it should be 
calling dma_set_mask_and_coherent() appropriately and not relying on the 
default.

> In your patches, where is coherent_dma_mask initialized?  I found this
> code in add_smmu_platform_device(), but I think this is setting the
> mask for the IOMMU driver, not the individual devices.

Yes, that's for the SMMU itself as a device (i.e. the page table walker) 
- as a handy example of "drivers which actually care about DMA masks", 
it specifically needs to avoid a too-small DMA mask because 
bounce-buffering the page tables tends to make things go horribly wrong.

Robin.

>  Either way, I
> don't understand where the correct value is going to be overridden.
>
> +       /*
> +        * Set default dma mask value for the table walker,
> +        * to be overridden on probing with correct value.
> +        */
> +       *pdev->dev.dma_mask = DMA_BIT_MASK(32);
> +       pdev->dev.coherent_dma_mask = *pdev->dev.dma_mask;
>

