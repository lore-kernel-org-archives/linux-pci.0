Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:34870 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755597AbdGKIgQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jul 2017 04:36:16 -0400
Received: by mail-it0-f66.google.com with SMTP id v193so2014158itc.2
        for <linux-pci@vger.kernel.org>; Tue, 11 Jul 2017 01:36:16 -0700 (PDT)
Subject: Re: [PATCH kernel v4 1/6] PCI: Add a new PCI_BUS_FLAGS_MSI_REMAP flag
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        Alex Williamson <alex.williamson@redhat.com>,
        Yongji Xie <elohimes@gmail.com>,
        Eric Auger <eric.auger@redhat.com>,
        Yongji Xie <xyjxie@linux.vnet.ibm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <20170630052436.15212-1-aik@ozlabs.ru>
 <20170630052436.15212-2-aik@ozlabs.ru>
 <CAErSpo6uBEMP_z0EorrKJTXy3SzOz99VqBYP7Cphutz38rEsmA@mail.gmail.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <0b3bc5ee-e00f-fdb1-49d7-97f4a90751f8@ozlabs.ru>
Date: Tue, 11 Jul 2017 18:36:08 +1000
MIME-Version: 1.0
In-Reply-To: <CAErSpo6uBEMP_z0EorrKJTXy3SzOz99VqBYP7Cphutz38rEsmA@mail.gmail.com>
Content-Type: text/plain; charset=koi8-r
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/07/17 05:20, Bjorn Helgaas wrote:
> [+cc linux-pci]
> 
> On Fri, Jun 30, 2017 at 12:24 AM, Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>> From: Yongji Xie <elohimes@gmail.com>
>>
>> We introduce a new pci_bus_flags, PCI_BUS_FLAGS_MSI_REMAP
>> which indicates interrupts of all devices on the bus are
>> managed by the hardware enabling IRQ remapping (intel naming).
>> When the capability is enabled, a given PCI device can only
>> shoot the MSIs assigned for it. In other words, the hardware
>> can protect system from invalid MSIs of the device by checking
>> the target address and data when there is something wrong
>> with MSI part in device or device driver.
> 
> This needs a reference to the spec that describes how this MSI protection works.


How much detail is needed here? For example, what to add to the below?

===
On Intel VT-d [1], there is an Interrupt Remapping Table, one entry per
interrupt, has a source-id (i.e. BDFN) of allowed device.

On AMD IOMMU [2], there is a Device Table, each entry is indexed by
DevideID which is BDFN.

On IBM POWERPC (POWER8) [3], PCI host bridge maintains BFDN-to-PE
translation (PE stands for "partitionable endpoint"), and PE index is used
to look at Interrupt Vector Table (IVT) to identify the interrupt server.
Actually this is not remapping, rather filtering but it still works for the
purpose of this flag.

[1] 9.10 Interrupt Remapping Table Entry (IRTE) for Remapped Interrupts
https://www.intel.com/content/dam/www/public/us/en/documents/product-specifications/vt-directed-io-spec.pdf

[2] "2.2 Data Structures" and "2.2.5 Interrupt Remapping Tables"
https://support.amd.com/TechDocs/48882_IOMMU.pdf

[3] 3.2.4. MSI Design
http://openpowerfoundation.org/wp-content/uploads/resources/IODA2Spec/IODA2WGSpec-1.0.0-20160217.pdf
===

And I did not comment about ARM, should I?

If anyone could check the correctness of the above, that would be great
(thanks in advance :) )


>> The new flag will be set by when the kernel decides that it is safe to
>> do so.
> 
> We also need some clue about how the kernel makes this decision.  That
> clue probably doesn't belong in *this* patch, but I didn't see it
> anywhere.

There are 3 sources:

1. IOMMU driver advertises MSI remapping capability, done by [3/6] and
[4/6], they could make a single patch but I believe they are separated as
they are touching different maintainership areas;

2. MSI controller advertises MSI remapping capability, this is from ARM and
their MSI domains, I am not really familiar with this.

3. Platform code can just know that it is capable of filtering, like PPC64
powernv for IODA2/IODA3 PHB types.

Could be more, probably.


And thanks for the review.

> 
>> With this flag enabled, we can easily know whether it's safe
>> to expose MSI-X tables of PCI BARs to userspace. Some usespace
>> drivers such as VFIO may benefit from this.
>>
>> Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>  include/linux/pci.h | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 8039f9f0ca05..2c6dbb3dd0da 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -200,6 +200,7 @@ enum pci_bus_flags {
>>         PCI_BUS_FLAGS_NO_MSI    = (__force pci_bus_flags_t) 1,
>>         PCI_BUS_FLAGS_NO_MMRBC  = (__force pci_bus_flags_t) 2,
>>         PCI_BUS_FLAGS_NO_AERSID = (__force pci_bus_flags_t) 4,
>> +       PCI_BUS_FLAGS_MSI_REMAP = (__force pci_bus_flags_t) 8,
>>  };
>>
>>  /* These values come from the PCI Express Spec */
>> --
>> 2.11.0
>>


-- 
Alexey
