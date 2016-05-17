Return-Path: <jayachandran.c@broadcom.com>
Return-Path: <jayachandran.c@broadcom.com>
MIME-Version: 1.0
In-Reply-To: <573340F9.6050507@arm.com>
References: <linux-pci@vger.kernel.org> <1462700001-30086-1-git-send-email-jchandra@broadcom.com>
 <5730621B.2050503@arm.com> <CAKc_7PVAV6uAbEFLWHyh1hngLa1PdJxPzk7bPoppexU1oAJHnw@mail.gmail.com>
 <573340F9.6050507@arm.com>
From: Jayachandran C <jchandra@broadcom.com>
Date: Tue, 17 May 2016 17:25:52 +0530
Message-ID: <CAKc_7PUHvx0VCkVUXDVawDscyqAmNHzonoMWAHTQ=yWF7HVL=A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PCI: Add PCI device flag PCI_DEV_FLAGS_DMA_ALIAS_ROOT
To: Robin Murphy <robin.murphy@arm.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, iommu@lists.linux-foundation.org,
	Bjorn Helgaas <helgaas@kernel.org>, Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 11, 2016 at 7:56 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> On 11/05/16 07:28, Jayachandran C wrote:
>>
>> On Mon, May 9, 2016 at 3:40 PM, Robin Murphy <robin.murphy@arm.com> wrote:
>>>
>>> On 08/05/16 10:33, Jayachandran C via iommu wrote:
>>>>
>>>>
>>>> Add a new flag PCI_DEV_FLAGS_DMA_ALIAS_ROOT to limit the DMA alias
>>>> search to go no further than the bridge where the IOMMU is attached.
>>>>
>>>> This has been added to support Broadcom's Vulcan which has the SMMUv3
>>>> and GIC ITS associated with an intermediate bridge in the PCI topology.
>>>> Traversing to buses above would hit internal glue bridges which will
>>>> change the RID.
>>>
>>>
>>>
>>> Can you not just have the relevant callback function detect the relevant
>>> node and terminate the walk of its own accord? That's what I was aiming
>>> for
>>> in this patch for the IOMMU setup:
>>>
>>> http://article.gmane.org/gmane.linux.kernel.iommu/12456
>>>
>>> Is there some flaw in that approach I've missed?
>>
>>
>> Not flaw as such, but:
>>   -  We need to support OF as well as ACPI, so the firmware dependent
>>     approach will not work. The ACPI code does not exist right now, but
>>     there are patches for this in development.
>>   - GICv3 ITS also uses the RIDs. I need to replicate the same logic in
>>     pci/msi.c and irqchip/irq-gic-v3-its-pci-msi.c for MSI. For IOMMU, I
>>     have to update iommu/arm-smmu-v3.c and in other places in iommu
>>     code  where pci_for_each_dma_alias is called.
>>   - since it is non-standard PCIe topology for the processor, a quirk
>> seemed
>>     to be the right way to handle it.
>>
>> I am still figuring out the right approach here, so comments are welcome.
>
>
> Oh for sure, I didn't mean to imply that that code is a complete ready-made
> solution, just that in general it seems a fairly straightforward thing to
> handle without touching the PCI core:
>
> - We already have to know whichever parent device has the
> msi-map/iommu-map/IORT table.
> - We're aware of that parent at the point we're doing the DMA/MSI
> configuration.
> - Therefore those operations already have everything they need for their
> callback to be able to stop when it reaches the relevant parent device.
> Doing it in a firmware-agnostic manner is merely an implementation detail.
>
> Since we'll basically be funnelling both MSI and IOMMU RID translation
> through a common code path, there should only need to be be one place to
> handle the DMA alias walk - with that first cut of my PCI/generic IOMMU
> bindings series I didn't try very hard to refactor things - v2 (probably
> post-merge-window now) will be a bit more thorough, now that I have a better
> idea of what thing should look like
>
> Ignore what arm-smmu-v3.c does, because it's wrong anyway. I need to fix
> that in the next version as well, even if it's just calling out directly to
> of_pci_map_rid rather than a proper of_xlate implementation.
>
> Now what I realise I *have* missed is the alias detection in
> iommu_get_group_for_dev, to which the "known parent device" reasoning
> doesn't apply, and phantom aliasing might well muck things up. Thinking
> further, if these upstream bridges exist but don't affect the outgoing RID,
> then might it make sense to quirk them as transparent? (I have no actual
> objection to this patch, though, and at this point I'm just chucking ideas
> about).

I had an earlier patch that had a quirk which marked some bridges to
be skipped https://patchwork.ozlabs.org/patch/582633/ which is similar
to the transparent idea. The discussion on that patch seems to indicate
that having a "root" flag may be better.

> Robin.
[...]

JC.
