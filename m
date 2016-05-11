Return-Path: <robin.murphy@arm.com>
Return-Path: <robin.murphy@arm.com>
Subject: Re: [PATCH v2 1/2] PCI: Add PCI device flag
 PCI_DEV_FLAGS_DMA_ALIAS_ROOT
To: Jayachandran C <jchandra@broadcom.com>
References: <linux-pci@vger.kernel.org>
 <1462700001-30086-1-git-send-email-jchandra@broadcom.com>
 <5730621B.2050503@arm.com>
 <CAKc_7PVAV6uAbEFLWHyh1hngLa1PdJxPzk7bPoppexU1oAJHnw@mail.gmail.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 iommu@lists.linux-foundation.org, Bjorn Helgaas <helgaas@kernel.org>,
 linux-pci@vger.kernel.org
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <573340F9.6050507@arm.com>
Date: Wed, 11 May 2016 15:26:01 +0100
MIME-Version: 1.0
In-Reply-To: <CAKc_7PVAV6uAbEFLWHyh1hngLa1PdJxPzk7bPoppexU1oAJHnw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 11/05/16 07:28, Jayachandran C wrote:
> On Mon, May 9, 2016 at 3:40 PM, Robin Murphy <robin.murphy@arm.com> wrote:
>> On 08/05/16 10:33, Jayachandran C via iommu wrote:
>>>
>>> Add a new flag PCI_DEV_FLAGS_DMA_ALIAS_ROOT to limit the DMA alias
>>> search to go no further than the bridge where the IOMMU is attached.
>>>
>>> This has been added to support Broadcom's Vulcan which has the SMMUv3
>>> and GIC ITS associated with an intermediate bridge in the PCI topology.
>>> Traversing to buses above would hit internal glue bridges which will
>>> change the RID.
>>
>>
>> Can you not just have the relevant callback function detect the relevant
>> node and terminate the walk of its own accord? That's what I was aiming for
>> in this patch for the IOMMU setup:
>>
>> http://article.gmane.org/gmane.linux.kernel.iommu/12456
>>
>> Is there some flaw in that approach I've missed?
>
> Not flaw as such, but:
>   -  We need to support OF as well as ACPI, so the firmware dependent
>     approach will not work. The ACPI code does not exist right now, but
>     there are patches for this in development.
>   - GICv3 ITS also uses the RIDs. I need to replicate the same logic in
>     pci/msi.c and irqchip/irq-gic-v3-its-pci-msi.c for MSI. For IOMMU, I
>     have to update iommu/arm-smmu-v3.c and in other places in iommu
>     code  where pci_for_each_dma_alias is called.
>   - since it is non-standard PCIe topology for the processor, a quirk seemed
>     to be the right way to handle it.
>
> I am still figuring out the right approach here, so comments are welcome.

Oh for sure, I didn't mean to imply that that code is a complete 
ready-made solution, just that in general it seems a fairly 
straightforward thing to handle without touching the PCI core:

- We already have to know whichever parent device has the 
msi-map/iommu-map/IORT table.
- We're aware of that parent at the point we're doing the DMA/MSI 
configuration.
- Therefore those operations already have everything they need for their 
callback to be able to stop when it reaches the relevant parent device. 
Doing it in a firmware-agnostic manner is merely an implementation detail.

Since we'll basically be funnelling both MSI and IOMMU RID translation 
through a common code path, there should only need to be be one place to 
handle the DMA alias walk - with that first cut of my PCI/generic IOMMU 
bindings series I didn't try very hard to refactor things - v2 (probably 
post-merge-window now) will be a bit more thorough, now that I have a 
better idea of what thing should look like

Ignore what arm-smmu-v3.c does, because it's wrong anyway. I need to fix 
that in the next version as well, even if it's just calling out directly 
to of_pci_map_rid rather than a proper of_xlate implementation.

Now what I realise I *have* missed is the alias detection in 
iommu_get_group_for_dev, to which the "known parent device" reasoning 
doesn't apply, and phantom aliasing might well muck things up. Thinking 
further, if these upstream bridges exist but don't affect the outgoing 
RID, then might it make sense to quirk them as transparent? (I have no 
actual objection to this patch, though, and at this point I'm just 
chucking ideas about).

Robin.

> JC.
>
>>
>>> Update the function pci_for_each_dma_alias() to stop when it see a
>>> bridge with this flag set.
>>>
>>> Signed-off-by: Jayachandran C <jchandra@broadcom.com>
>>> ---
>>>
>>> Here is v2 of the patch, the previous discussion is at
>>> http://lists.linuxfoundation.org/pipermail/iommu/2016-February/015668.html
>>>
>>> v1->v2 changes:
>>>    - dropped the BAR quirk (not needed)
>>>    - moved from using the 'skip' flag for some bridges to using
>>>      similar approach to stop the traversal at the bridge with
>>>      PCI_DEV_FLAGS_DMA_ALIAS_ROOT
>>>
>>> Comments and suggestions are welcome
>>>
>>> JC.
>>>
>>>    drivers/pci/search.c | 4 ++++
>>>    include/linux/pci.h  | 2 ++
>>>    2 files changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/pci/search.c b/drivers/pci/search.c
>>> index a20ce7d..3ea9c27 100644
>>> --- a/drivers/pci/search.c
>>> +++ b/drivers/pci/search.c
>>> @@ -56,6 +56,10 @@ int pci_for_each_dma_alias(struct pci_dev *pdev,
>>>
>>>                  tmp = bus->self;
>>>
>>> +               /* stop at bridge where translation unit is associated */
>>> +               if (tmp->dev_flags & PCI_DEV_FLAGS_DMA_ALIAS_ROOT)
>>> +                       return ret;
>>> +
>>>                  /*
>>>                   * PCIe-to-PCI/X bridges alias transactions from
>>> downstream
>>>                   * devices using the subordinate bus number (PCI Express
>>> to
>>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>>> index 932ec74..b6f832b 100644
>>> --- a/include/linux/pci.h
>>> +++ b/include/linux/pci.h
>>> @@ -176,6 +176,8 @@ enum pci_dev_flags {
>>>          PCI_DEV_FLAGS_NO_PM_RESET = (__force pci_dev_flags_t) (1 << 7),
>>>          /* Get VPD from function 0 VPD */
>>>          PCI_DEV_FLAGS_VPD_REF_F0 = (__force pci_dev_flags_t) (1 << 8),
>>> +       /* a non-root bridge where translation occurs, stop alias search
>>> here */
>>> +       PCI_DEV_FLAGS_DMA_ALIAS_ROOT = (__force pci_dev_flags_t) (1 << 9),
>>>    };
>>>
>>>    enum pci_irq_reroute_variant {
>>>
>>
>
