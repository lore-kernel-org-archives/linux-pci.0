Return-Path: <jayachandran.c@broadcom.com>
Return-Path: <jayachandran.c@broadcom.com>
MIME-Version: 1.0
In-Reply-To: <5730621B.2050503@arm.com>
References: <linux-pci@vger.kernel.org> <1462700001-30086-1-git-send-email-jchandra@broadcom.com>
 <5730621B.2050503@arm.com>
From: Jayachandran C <jchandra@broadcom.com>
Date: Wed, 11 May 2016 11:58:24 +0530
Message-ID: <CAKc_7PVAV6uAbEFLWHyh1hngLa1PdJxPzk7bPoppexU1oAJHnw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PCI: Add PCI device flag PCI_DEV_FLAGS_DMA_ALIAS_ROOT
To: Robin Murphy <robin.murphy@arm.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, iommu@lists.linux-foundation.org,
	Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 9, 2016 at 3:40 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> On 08/05/16 10:33, Jayachandran C via iommu wrote:
>>
>> Add a new flag PCI_DEV_FLAGS_DMA_ALIAS_ROOT to limit the DMA alias
>> search to go no further than the bridge where the IOMMU is attached.
>>
>> This has been added to support Broadcom's Vulcan which has the SMMUv3
>> and GIC ITS associated with an intermediate bridge in the PCI topology.
>> Traversing to buses above would hit internal glue bridges which will
>> change the RID.
>
>
> Can you not just have the relevant callback function detect the relevant
> node and terminate the walk of its own accord? That's what I was aiming for
> in this patch for the IOMMU setup:
>
> http://article.gmane.org/gmane.linux.kernel.iommu/12456
>
> Is there some flaw in that approach I've missed?

Not flaw as such, but:
 -  We need to support OF as well as ACPI, so the firmware dependent
   approach will not work. The ACPI code does not exist right now, but
   there are patches for this in development.
 - GICv3 ITS also uses the RIDs. I need to replicate the same logic in
   pci/msi.c and irqchip/irq-gic-v3-its-pci-msi.c for MSI. For IOMMU, I
   have to update iommu/arm-smmu-v3.c and in other places in iommu
   code  where pci_for_each_dma_alias is called.
 - since it is non-standard PCIe topology for the processor, a quirk seemed
   to be the right way to handle it.

I am still figuring out the right approach here, so comments are welcome.

JC.

>
>> Update the function pci_for_each_dma_alias() to stop when it see a
>> bridge with this flag set.
>>
>> Signed-off-by: Jayachandran C <jchandra@broadcom.com>
>> ---
>>
>> Here is v2 of the patch, the previous discussion is at
>> http://lists.linuxfoundation.org/pipermail/iommu/2016-February/015668.html
>>
>> v1->v2 changes:
>>   - dropped the BAR quirk (not needed)
>>   - moved from using the 'skip' flag for some bridges to using
>>     similar approach to stop the traversal at the bridge with
>>     PCI_DEV_FLAGS_DMA_ALIAS_ROOT
>>
>> Comments and suggestions are welcome
>>
>> JC.
>>
>>   drivers/pci/search.c | 4 ++++
>>   include/linux/pci.h  | 2 ++
>>   2 files changed, 6 insertions(+)
>>
>> diff --git a/drivers/pci/search.c b/drivers/pci/search.c
>> index a20ce7d..3ea9c27 100644
>> --- a/drivers/pci/search.c
>> +++ b/drivers/pci/search.c
>> @@ -56,6 +56,10 @@ int pci_for_each_dma_alias(struct pci_dev *pdev,
>>
>>                 tmp = bus->self;
>>
>> +               /* stop at bridge where translation unit is associated */
>> +               if (tmp->dev_flags & PCI_DEV_FLAGS_DMA_ALIAS_ROOT)
>> +                       return ret;
>> +
>>                 /*
>>                  * PCIe-to-PCI/X bridges alias transactions from
>> downstream
>>                  * devices using the subordinate bus number (PCI Express
>> to
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 932ec74..b6f832b 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -176,6 +176,8 @@ enum pci_dev_flags {
>>         PCI_DEV_FLAGS_NO_PM_RESET = (__force pci_dev_flags_t) (1 << 7),
>>         /* Get VPD from function 0 VPD */
>>         PCI_DEV_FLAGS_VPD_REF_F0 = (__force pci_dev_flags_t) (1 << 8),
>> +       /* a non-root bridge where translation occurs, stop alias search
>> here */
>> +       PCI_DEV_FLAGS_DMA_ALIAS_ROOT = (__force pci_dev_flags_t) (1 << 9),
>>   };
>>
>>   enum pci_irq_reroute_variant {
>>
>
