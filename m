Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:48606 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751937AbaGCNP3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 Jul 2014 09:15:29 -0400
Received: by mail-ig0-f180.google.com with SMTP id h18so1440009igc.1
        for <linux-pci@vger.kernel.org>; Thu, 03 Jul 2014 06:15:29 -0700 (PDT)
Date: Thu, 3 Jul 2014 07:15:26 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Guo Chao <yan@linux.vnet.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] pci: Allow very large resource windows
Message-ID: <20140703131526.GG28852@google.com>
References: <20140611060118.GB3169@yanx>
 <CAE9FiQWe2bf7QbKn9kmZS34a4cMewsdD-9qAELdXs-dEtx70GQ@mail.gmail.com>
 <20140702210736.GB28852@google.com>
 <CAE9FiQU5Ltu89zmRG0h2aXfXH0oCcTEP=jF7b=zHi=SaOA2rKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQU5Ltu89zmRG0h2aXfXH0oCcTEP=jF7b=zHi=SaOA2rKg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 02, 2014 at 03:54:29PM -0700, Yinghai Lu wrote:
> On Wed, Jul 2, 2014 at 2:07 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> >
> >> Subject: [PATCH -v3] PCI: Fix bus align checking to support more than 8G
> >>
> >> So add mmio64 mask checking, only allow more than 4G when bridge and all child
> >> support 64bit res.  Still keep old 2G checking for other path.
> >>
> >> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> >>
> >> ---
> >>  drivers/pci/setup-bus.c |   40 ++++++++++++++++++++++++++++++++++++++--
> >>  1 file changed, 38 insertions(+), 2 deletions(-)
> >>
> >> Index: linux-2.6/drivers/pci/setup-bus.c
> >> ===================================================================
> >> --- linux-2.6.orig/drivers/pci/setup-bus.c
> >> +++ linux-2.6/drivers/pci/setup-bus.c
> >> @@ -928,15 +928,50 @@ static int pbus_size_mem(struct pci_bus
> >>  {
> >>       struct pci_dev *dev;
> >>       resource_size_t min_align, align, size, size0, size1;
> >> -     resource_size_t aligns[14];     /* Alignments from 1Mb to 8Gb */
> >> +     resource_size_t aligns[44];     /* Alignments from 1Mb to 2^63 */
> >>       int order, max_order;
> >>       struct resource *b_res = find_free_bus_resource(bus,
> >>                                       mask | IORESOURCE_PREFETCH, type);
> >>       resource_size_t children_add_size = 0;
> >> +     unsigned int mem64_mask;
> >>
> >>       if (!b_res)
> >>               return -ENOSPC;
> >>
> >> +     mem64_mask = b_res->flags & IORESOURCE_MEM_64;
> >> +
> >> +     /* kernel does not support 64bit res */
> >> +     if (sizeof(resource_size_t) == 4)
> >> +             mem64_mask &= ~IORESOURCE_MEM_64;
> >> +
> >> +     if (!mem64_mask)
> >> +             goto mem64_mask_check_done;
> >> +
> >> +     /* check if mem64 support is supported and needed at first */
> >> +     list_for_each_entry(dev, &bus->devices, bus_list) {
> >> +             int i;
> >> +
> >> +             for (i = 0; i < PCI_NUM_RESOURCES; i++) {
> >> +                     struct resource *r = &dev->resource[i];
> >> +
> >> +                     if (r->parent || ((r->flags & mask) != type &&
> >> +                                       (r->flags & mask) != type2 &&
> >> +                                       (r->flags & mask) != type3))
> >> +                             continue;
> >> +#ifdef CONFIG_PCI_IOV
> >> +                     /* Skip SRIOV checking, as optional res */
> >> +                     if (realloc_head && i >= PCI_IOV_RESOURCES &&
> >> +                                     i <= PCI_IOV_RESOURCE_END)
> >> +                             continue;
> >> +#endif
> >> +                     mem64_mask &= r->flags & IORESOURCE_MEM_64;
> >> +
> >> +                     if (!mem64_mask)
> >> +                             goto mem64_mask_check_done;
> >> +             }
> >> +     }
> >> +mem64_mask_check_done:
> >
> > What happens if we increase the size of aligns[], but omit this loop and
> > the mem64_mask stuff?  Is mem64_mask just an optimization, so the code
> > would still work without it?  If the existing code works for 8GB bars
> > (without mem64_mask), when does it break and start requiring mem64_mask?
> 
> Yes, you are right. with current version __pci_bus_size_bridges(), we could
> get rid of the checking. As child 32bit pref mmio will go underwith
> bridge 32bit non-pref mmio.
> 
> We only need keep
> 
> >> +     mem64_mask = b_res->flags & IORESOURCE_MEM_64;
> >> +
> >> +     /* kernel does not support 64bit res */
> >> +     if (sizeof(resource_size_t) == 4)
> >> +             mem64_mask &= ~IORESOURCE_MEM_64;

I think you're fixing two things at once, and they should be split
into two separate patches:

  1) Change aligns[] size to increase support alignment from 8GB to 2^63

     I'm not sure about going all the way to aligns[44].  That array
     by itself puts 352 bytes in the stack frame (240 of which are
     added by this patch), which seems excessive.  I suspect that
     supporting BARs up to 64GB or 128GB would be enough for the
     foreseeable future.

  2) Adding mem64_mask

     I think the idea is that even if we have a 64-bit window, we
     can't use anything above 4GB if we only have 32-bit resources.
     That's true, but I don't think we can enforce that in
     pbus_size_mem() because we're only figuring out how much space is
     needed; we have no idea where that space will be allocated.

And I think there are more problems:

  - I don't think we handle overflow of "size" correctly.  Assume that
    we have BARs of 2GB, 2GB, and 8GB.  If we have 32-bit resources,
    when we add those up, it will overflow and we'll mistakenly think
    we only need 8MB.

  - We shouldn't set "r->flags = 0".  The warning says we're disabling
    the BAR, but this *doesn't* disable the BAR, and in fact, there is
    no way to disable a single BAR.  What we can do is turn off
    PCI_COMMAND_MEMORY to disable all the memory BARs for the device.
    And to do that, we need to keep IORESOURCE_MEM in r->flags so
    pci_enable_resources() can tell that this is a memory BAR.

Bjorn
