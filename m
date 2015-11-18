Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH V5 8/9] PCI: OF: Move of_pci_dma_configure() to
 pci_dma_configure()
To: Arnd Bergmann <arnd@arndb.de>, Robin Murphy <robin.murphy@arm.com>
References: <1446072654-5608-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <564B4111.6010805@arm.com> <564C6860.4000002@arm.com>
 <3822315.uJPjk3L2zB@wuerfel>
CC: <bhelgaas@google.com>, <rjw@rjwysocki.net>, <lenb@kernel.org>,
	<catalin.marinas@arm.com>, <will.deacon@arm.com>,
	<thomas.lendacky@amd.com>, <herbert@gondor.apana.org.au>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <hanjun.guo@linaro.org>,
	<davem@davemloft.net>, <linux-arm-kernel@lists.infradead.org>
From: Suravee Suthikulanit <suravee.suthikulpanit@amd.com>
Message-ID: <564C94F0.2090902@amd.com>
Date: Wed, 18 Nov 2015 09:10:40 -0600
MIME-Version: 1.0
In-Reply-To: <3822315.uJPjk3L2zB@wuerfel>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/18/2015 6:41 AM, Arnd Bergmann wrote:
> On Wednesday 18 November 2015 12:00:32 Robin Murphy wrote:
>> On 17/11/15 15:00, Robin Murphy wrote:
>>> On 28/10/15 22:50, Suravee Suthikulpanit wrote:
>>>> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>>>> Acked-by: Rob Herring <robh+dt@kernel.org>
>>>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>>>> Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
>>>> CC: Rafael J. Wysocki <rjw@rjwysocki.net>
>> [...]
>>>> +/**
>>>> + * pci_dma_configure - Setup DMA configuration
>>>> + * @dev: ptr to pci_dev struct of the PCI device
>>>> + *
>>>> + * Function to update PCI devices's DMA configuration using the same
>>>> + * info from the OF node of host bridge's parent (if any).
>>>> + */
>>>> +static void pci_dma_configure(struct pci_dev *dev)
>>>> +{
>>>> +    struct device *bridge = pci_get_host_bridge_device(dev);
>>>> +
>>>> +    if (IS_ENABLED(CONFIG_OF) && dev->dev.of_node) {
>>>
>>> Previously I was seeing of_dma_configure, and thus of_iommu_configure,
>>> called for every PCI device on Juno. The check above now prevents this
>>> happening, since the PCI devices are probed directly from the bus and
>>> don't have OF nodes of their own. They now get left in some
>>> half-configured state where arch_setup_dma_ops isn't called either.
>>
>> Just to follow up on that, Arnd's patch to tidy up dma_get_ops (now
>> queued[1]) makes this even worse, since preventing arch_setup_dma_ops
>> being called means the PCI devices now get the dummy DMA ops which leave
>> the drivers failing to probe at all, IOMMU hacks or not
>
> Ok, glad we found that with my patch then. We really have to
> configure the DMA (offset/size/coherency/iommu) for all devices that might
> be masters, otherwise things can randomly go wrong.
>
> 	ARnd
>
I'm double checking this and will get back ASAP.

Suravee
