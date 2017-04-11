Return-Path: <SRS0=hG8h=3T=gmail.com=ddaney.cavm@kernel.org>
Return-Path: <SRS0=hG8h=3T=gmail.com=ddaney.cavm@kernel.org>
Subject: Re: [PATCH v4 0/2] Handle Cavium ThunderX2 PCI topology quirk
To: Bjorn Helgaas <helgaas@kernel.org>,
 Jayachandran C <jnair@caviumnetworks.com>
References: <1491225304-3559-1-git-send-email-jnair@caviumnetworks.com>
 <20170411134407.GB31773@bhelgaas-glaptop.roam.corp.google.com>
Cc: David Daney <david.daney@cavium.com>, linux-pci@vger.kernel.org,
 iommu@lists.linux-foundation.org,
 Alex Williamson <alex.williamson@redhat.com>, Jon Masters <jcm@redhat.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
From: David Daney <ddaney.cavm@gmail.com>
Message-ID: <bdfc225a-7859-926b-6e17-327fb93c02bc@gmail.com>
Date: Tue, 11 Apr 2017 09:01:27 -0700
MIME-Version: 1.0
In-Reply-To: <20170411134407.GB31773@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 04/11/2017 06:44 AM, Bjorn Helgaas wrote:
> [+cc David]
>
> I forgot to mention that I'm also hoping for an ack from David, since
> he's listed as the maintainer of the ThunderX drivers.
>

JC is really leading the development of this particular PCI 
implementation, but I am happy to supply my:

Acked-by: David Daney <david.daney@cavium.com>



> On Mon, Apr 03, 2017 at 01:15:02PM +0000, Jayachandran C wrote:
>> Hi Bjorn, Alex,
>>
>> Sending this again (with a trivial fix to author name), please review.
>> Updated summary below:
>>
>> Here is v4 of the patchset to handle the PCIe topology quirk of Cavium
>> ThunderX2 systems (previously known as Broadcom Vulcan).
>>
>> The earlier discussions on this can be seen at:
>> http://www.spinics.net/lists/linux-pci/msg51001.html
>> https://patchwork.ozlabs.org/patch/582633/ and
>> https://lists.linuxfoundation.org/pipermail/iommu/2016-June/017681.html
>>
>> The earlier discussion on this patchset ended with a suggestion that it
>> may be possible to fix up this quirk by handling the issue in the
>> function argument of pci_for_each_dma_alias(). But at that point we did
>> not have the codebase to make the changes since the full ACPI and OF code
>> for SMMU and GIC ITS was not upstream.
>>
>> Now that the changes are upstream, I tried to fix it in both the SMMU
>> and the GIC ITS code based on this suggestion, the changes needed are at:
>>  https://github.com/jchandra-cavm/linux/commits/rid-xlate-fixup
>>
>> The problems with this approach are:
>>  - of the 14 uses of pci_for_each_dma_alias in the function in the kernel
>>    tree, I have to fixup 6 callers (which is all but one ofthe callers
>>    outside x86)
>>  - 4 of these can be reasonably handled (please see the github repo above),
>>    but the calls in drivers/irqchip/irq-gic-v3-its-pci-msi.c and
>>    drivers/iommu/iommu.c cannot be reasonably fixed up.
>>  - Even without the 2 above two changes I can get it to work for now.
>>    But pci_for_each_dma_alias does not work as expected on this platform
>>    and we have to be aware of that for all future uses of the function.
>>
>> For now, I have ruled out the approach, and I have rebased the earlier
>> patch on to 4.11-rc and submitting again for review. The changes are:
>>
>> v3->v4:
>>  - new address of author
>>
>> v2>v3:
>>  - changed device flag name from PCI_DEV_FLAGS_DMA_ALIAS_ROOT to
>>    PCI_DEV_FLAGS_BRIDGE_XLATE_ROOT
>>  - updated commit message to make the quirk clearer.
>>
>> Let me know your comments and suggestions.
>>
>> Thanks,
>> JC.
>>
>>
>> Jayachandran C (2):
>>   PCI: Add device flag PCI_DEV_FLAGS_BRIDGE_XLATE_ROOT
>>   PCI: quirks: Fix ThunderX2 dma alias handling
>>
>>  drivers/pci/quirks.c | 14 ++++++++++++++
>>  drivers/pci/search.c |  4 ++++
>>  include/linux/pci.h  |  2 ++
>>  3 files changed, 20 insertions(+)
>>
>> --
>> 2.7.4
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
