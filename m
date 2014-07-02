Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:53380 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751547AbaGBWy3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 2 Jul 2014 18:54:29 -0400
Received: by mail-ig0-f172.google.com with SMTP id hn18so7250596igb.17
        for <linux-pci@vger.kernel.org>; Wed, 02 Jul 2014 15:54:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140702210736.GB28852@google.com>
References: <20140611060118.GB3169@yanx>
	<CAE9FiQWe2bf7QbKn9kmZS34a4cMewsdD-9qAELdXs-dEtx70GQ@mail.gmail.com>
	<20140702210736.GB28852@google.com>
Date: Wed, 2 Jul 2014 15:54:29 -0700
Message-ID: <CAE9FiQU5Ltu89zmRG0h2aXfXH0oCcTEP=jF7b=zHi=SaOA2rKg@mail.gmail.com>
Subject: Re: [PATCH] pci: Allow very large resource windows
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Guo Chao <yan@linux.vnet.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 2, 2014 at 2:07 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>
>> Subject: [PATCH -v3] PCI: Fix bus align checking to support more than 8G
>>
>> So add mmio64 mask checking, only allow more than 4G when bridge and all child
>> support 64bit res.  Still keep old 2G checking for other path.
>>
>> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>>
>> ---
>>  drivers/pci/setup-bus.c |   40 ++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 38 insertions(+), 2 deletions(-)
>>
>> Index: linux-2.6/drivers/pci/setup-bus.c
>> ===================================================================
>> --- linux-2.6.orig/drivers/pci/setup-bus.c
>> +++ linux-2.6/drivers/pci/setup-bus.c
>> @@ -928,15 +928,50 @@ static int pbus_size_mem(struct pci_bus
>>  {
>>       struct pci_dev *dev;
>>       resource_size_t min_align, align, size, size0, size1;
>> -     resource_size_t aligns[14];     /* Alignments from 1Mb to 8Gb */
>> +     resource_size_t aligns[44];     /* Alignments from 1Mb to 2^63 */
>>       int order, max_order;
>>       struct resource *b_res = find_free_bus_resource(bus,
>>                                       mask | IORESOURCE_PREFETCH, type);
>>       resource_size_t children_add_size = 0;
>> +     unsigned int mem64_mask;
>>
>>       if (!b_res)
>>               return -ENOSPC;
>>
>> +     mem64_mask = b_res->flags & IORESOURCE_MEM_64;
>> +
>> +     /* kernel does not support 64bit res */
>> +     if (sizeof(resource_size_t) == 4)
>> +             mem64_mask &= ~IORESOURCE_MEM_64;
>> +
>> +     if (!mem64_mask)
>> +             goto mem64_mask_check_done;
>> +
>> +     /* check if mem64 support is supported and needed at first */
>> +     list_for_each_entry(dev, &bus->devices, bus_list) {
>> +             int i;
>> +
>> +             for (i = 0; i < PCI_NUM_RESOURCES; i++) {
>> +                     struct resource *r = &dev->resource[i];
>> +
>> +                     if (r->parent || ((r->flags & mask) != type &&
>> +                                       (r->flags & mask) != type2 &&
>> +                                       (r->flags & mask) != type3))
>> +                             continue;
>> +#ifdef CONFIG_PCI_IOV
>> +                     /* Skip SRIOV checking, as optional res */
>> +                     if (realloc_head && i >= PCI_IOV_RESOURCES &&
>> +                                     i <= PCI_IOV_RESOURCE_END)
>> +                             continue;
>> +#endif
>> +                     mem64_mask &= r->flags & IORESOURCE_MEM_64;
>> +
>> +                     if (!mem64_mask)
>> +                             goto mem64_mask_check_done;
>> +             }
>> +     }
>> +mem64_mask_check_done:
>
> What happens if we increase the size of aligns[], but omit this loop and
> the mem64_mask stuff?  Is mem64_mask just an optimization, so the code
> would still work without it?  If the existing code works for 8GB bars
> (without mem64_mask), when does it break and start requiring mem64_mask?

Yes, you are right. with current version __pci_bus_size_bridges(), we could
get rid of the checking. As child 32bit pref mmio will go underwith
bridge 32bit non-pref mmio.

We only need keep

>> +     mem64_mask = b_res->flags & IORESOURCE_MEM_64;
>> +
>> +     /* kernel does not support 64bit res */
>> +     if (sizeof(resource_size_t) == 4)
>> +             mem64_mask &= ~IORESOURCE_MEM_64;

Let me know if you want me to send new version.

Thanks

Yinghai
