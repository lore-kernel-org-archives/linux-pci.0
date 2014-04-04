Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:36631 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752374AbaDDWns (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 4 Apr 2014 18:43:48 -0400
Received: by mail-ig0-f172.google.com with SMTP id hn18so1543058igb.17
        for <linux-pci@vger.kernel.org>; Fri, 04 Apr 2014 15:43:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1394222924-28886-1-git-send-email-yinghai@kernel.org>
References: <CAE9FiQXzRQ9S0mwwb58R2icBTtHHJ6NMVFMaxEgtVNP9mZVjZw@mail.gmail.com>
 <1394222924-28886-1-git-send-email-yinghai@kernel.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 4 Apr 2014 16:43:27 -0600
Message-ID: <CAErSpo6r16va7oBpaDcTXw0Y0igc=NbXy9G7c27X+P0UM7fh8g@mail.gmail.com>
Subject: Re: [PATCH v7] PCI: Try best to allocate pref mmio 64bit above 4g
To: Yinghai Lu <yinghai@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	Jack Morgenstein <jackm@dev.mellanox.co.il>,
	Amir Vadai <amirv@mellanox.com>,
	Or Gerlitz <ogerlitz@mellanox.com>,
	Eugenia Emantayev <eugenia@mellanox.com>,
	Guo Chao <yan@linux.vnet.ibm.com>, talal@mellanox.com,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 7, 2014 at 1:08 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> When one of children resources does not support MEM_64, MEM_64 for
> bridge get reset, so pull down whole pref resource on the bridge under 4G.
>
> If the bridge support pref mem 64, will only allocate that with pref mem64 to
> children that support it.
> For children resources if they only support pref mem 32, will allocate them
> from non pref mem instead.
>
> If the bridge only support 32bit pref mmio, will still have all children pref
> mmio under that.
>
> -v2: Add release bridge res support with bridge mem res for pref_mem children res.
> -v3: refresh and make it can be applied early before for_each_dev_res patchset.
> -v4: fix non-pref mmio 64bit support found by Guo Chao.
> -v7: repost as ibm's powerpc system work again when
>     1. petiboot boot kernel have this patch.
>     2. or mellanox driver added new .shutdown member.
>     discussion could be found at:
>          http://marc.info/?t=138968064500001&r=1&w=2

I think this fixes some sort of bug, and I suppose if I spent a few
hours decoding the discussion you mention (the 44 message-long
"mlx4_core probe error after applying Yinghai's patch" discussion), I
might be able to figure out what it is.

But maybe somebody who already knows what the bug is can summarize it
for me, and maybe even open a kernel.org bugzilla with a dmesg log as
an example.

I do intend to use this message [1] as a source to help construct a
changelog, but I'd like to also describe a specific problem that is
solved by this patch.  Ideally this would already be in the changelog,
but it's not, so any help in figuring it out would be appreciated.

[1] http://lkml.kernel.org/r/CAErSpo5VWREGptW0MU0wLJUa3h23DXMZPGkdJFMTx5WAGL8J6Q@mail.gmail.com

> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Tested-by: Guo Chao <yan@linux.vnet.ibm.com>
> Tested-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>
> ---
>  drivers/pci/setup-bus.c |  138 ++++++++++++++++++++++++++++++++----------------
>  drivers/pci/setup-res.c |   20 ++++++
>  2 files changed, 111 insertions(+), 47 deletions(-)
>
> Index: linux-2.6/drivers/pci/setup-bus.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/setup-bus.c
> +++ linux-2.6/drivers/pci/setup-bus.c
> @@ -713,12 +713,11 @@ static void pci_bridge_check_ranges(stru
>     bus resource of a given type. Note: we intentionally skip
>     the bus resources which have already been assigned (that is,
>     have non-NULL parent resource). */
> -static struct resource *find_free_bus_resource(struct pci_bus *bus, unsigned long type)
> +static struct resource *find_free_bus_resource(struct pci_bus *bus,
> +                        unsigned long type_mask, unsigned long type)
>  {
>         int i;
>         struct resource *r;
> -       unsigned long type_mask = IORESOURCE_IO | IORESOURCE_MEM |
> -                                 IORESOURCE_PREFETCH;
>
>         pci_bus_for_each_resource(bus, r, i) {
>                 if (r == &ioport_resource || r == &iomem_resource)
> @@ -815,7 +814,8 @@ static void pbus_size_io(struct pci_bus
>                 resource_size_t add_size, struct list_head *realloc_head)
>  {
>         struct pci_dev *dev;
> -       struct resource *b_res = find_free_bus_resource(bus, IORESOURCE_IO);
> +       struct resource *b_res = find_free_bus_resource(bus, IORESOURCE_IO,
> +                                                       IORESOURCE_IO);
>         resource_size_t size = 0, size0 = 0, size1 = 0;
>         resource_size_t children_add_size = 0;
>         resource_size_t min_align, align;
> @@ -915,15 +915,17 @@ static inline resource_size_t calculate_
>   * guarantees that all child resources fit in this size.
>   */
>  static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
> -                        unsigned long type, resource_size_t min_size,
> -                       resource_size_t add_size,
> -                       struct list_head *realloc_head)
> +                        unsigned long type, unsigned long type2,
> +                        unsigned long type3,
> +                        resource_size_t min_size, resource_size_t add_size,
> +                        struct list_head *realloc_head)
>  {
>         struct pci_dev *dev;
>         resource_size_t min_align, align, size, size0, size1;
>         resource_size_t aligns[12];     /* Alignments from 1Mb to 2Gb */
>         int order, max_order;
> -       struct resource *b_res = find_free_bus_resource(bus, type);
> +       struct resource *b_res = find_free_bus_resource(bus,
> +                                        mask | IORESOURCE_PREFETCH, type);
>         unsigned int mem64_mask = 0;
>         resource_size_t children_add_size = 0;
>
> @@ -944,7 +946,9 @@ static int pbus_size_mem(struct pci_bus
>                         struct resource *r = &dev->resource[i];
>                         resource_size_t r_size;
>
> -                       if (r->parent || (r->flags & mask) != type)
> +                       if (r->parent || ((r->flags & mask) != type &&
> +                                         (r->flags & mask) != type2 &&
> +                                         (r->flags & mask) != type3))
>                                 continue;
>                         r_size = resource_size(r);
>  #ifdef CONFIG_PCI_IOV
> @@ -1117,8 +1121,9 @@ void __ref __pci_bus_size_bridges(struct
>                         struct list_head *realloc_head)
>  {
>         struct pci_dev *dev;
> -       unsigned long mask, prefmask;
> +       unsigned long mask, prefmask, type2 = 0, type3 = 0;
>         resource_size_t additional_mem_size = 0, additional_io_size = 0;
> +       struct resource *b_res;
>
>         list_for_each_entry(dev, &bus->devices, bus_list) {
>                 struct pci_bus *b = dev->subordinate;
> @@ -1163,15 +1168,34 @@ void __ref __pci_bus_size_bridges(struct
>                    has already been allocated by arch code, try
>                    non-prefetchable range for both types of PCI memory
>                    resources. */
> +               b_res = &bus->self->resource[PCI_BRIDGE_RESOURCES];
>                 mask = IORESOURCE_MEM;
>                 prefmask = IORESOURCE_MEM | IORESOURCE_PREFETCH;
> -               if (pbus_size_mem(bus, prefmask, prefmask,
> +               if (b_res[2].flags & IORESOURCE_MEM_64) {
> +                       prefmask |= IORESOURCE_MEM_64;
> +                       if (pbus_size_mem(bus, prefmask, prefmask,
> +                                 prefmask, prefmask,
>                                   realloc_head ? 0 : additional_mem_size,
> -                                 additional_mem_size, realloc_head))
> -                       mask = prefmask; /* Success, size non-prefetch only. */
> -               else
> -                       additional_mem_size += additional_mem_size;
> -               pbus_size_mem(bus, mask, IORESOURCE_MEM,
> +                                 additional_mem_size, realloc_head)) {
> +                                       /* Success, size non-pref64 only. */
> +                                       mask = prefmask;
> +                                       type2 = prefmask & ~IORESOURCE_MEM_64;
> +                                       type3 = prefmask & ~IORESOURCE_PREFETCH;
> +                       }
> +               }
> +               if (!type2) {
> +                       prefmask &= ~IORESOURCE_MEM_64;
> +                       if (pbus_size_mem(bus, prefmask, prefmask,
> +                                        prefmask, prefmask,
> +                                        realloc_head ? 0 : additional_mem_size,
> +                                        additional_mem_size, realloc_head)) {
> +                               /* Success, size non-prefetch only. */
> +                               mask = prefmask;
> +                       } else
> +                               additional_mem_size += additional_mem_size;
> +                       type2 = type3 = IORESOURCE_MEM;
> +               }
> +               pbus_size_mem(bus, mask, IORESOURCE_MEM, type2, type3,
>                                 realloc_head ? 0 : additional_mem_size,
>                                 additional_mem_size, realloc_head);
>                 break;
> @@ -1257,42 +1281,66 @@ static void __ref __pci_bridge_assign_re
>  static void pci_bridge_release_resources(struct pci_bus *bus,
>                                           unsigned long type)
>  {
> -       int idx;
> -       bool changed = false;
> -       struct pci_dev *dev;
> +       struct pci_dev *dev = bus->self;
>         struct resource *r;
>         unsigned long type_mask = IORESOURCE_IO | IORESOURCE_MEM |
> -                                 IORESOURCE_PREFETCH;
> +                                 IORESOURCE_PREFETCH | IORESOURCE_MEM_64;
> +       unsigned old_flags = 0;
> +       struct resource *b_res;
> +       int idx = 1;
>
> -       dev = bus->self;
> -       for (idx = PCI_BRIDGE_RESOURCES; idx <= PCI_BRIDGE_RESOURCE_END;
> -            idx++) {
> -               r = &dev->resource[idx];
> -               if ((r->flags & type_mask) != type)
> -                       continue;
> -               if (!r->parent)
> -                       continue;
> -               /*
> -                * if there are children under that, we should release them
> -                *  all
> -                */
> -               release_child_resources(r);
> -               if (!release_resource(r)) {
> -                       dev_printk(KERN_DEBUG, &dev->dev,
> -                                "resource %d %pR released\n", idx, r);
> -                       /* keep the old size */
> -                       r->end = resource_size(r) - 1;
> -                       r->start = 0;
> -                       r->flags = 0;
> -                       changed = true;
> -               }
> -       }
> +       b_res = &dev->resource[PCI_BRIDGE_RESOURCES];
> +
> +       /*
> +        *     1. if there is io port assign fail, will release bridge
> +        *        io port.
> +        *     2. if there is non pref mmio assign fail, release bridge
> +        *        nonpref mmio.
> +        *     3. if there is 64bit pref mmio assign fail, and bridge pref
> +        *        is 64bit, release bridge pref mmio.
> +        *     4. if there is pref mmio assign fail, and bridge pref is
> +        *        32bit mmio, release bridge pref mmio
> +        *     5. if there is pref mmio assign fail, and bridge pref is not
> +        *        assigned, release bridge nonpref mmio.
> +        */
> +       if (type & IORESOURCE_IO)
> +               idx = 0;
> +       else if (!(type & IORESOURCE_PREFETCH))
> +               idx = 1;
> +       else if ((type & IORESOURCE_MEM_64) &&
> +                (b_res[2].flags & IORESOURCE_MEM_64))
> +               idx = 2;
> +       else if (!(b_res[2].flags & IORESOURCE_MEM_64) &&
> +                (b_res[2].flags & IORESOURCE_PREFETCH))
> +               idx = 2;
> +       else
> +               idx = 1;
> +
> +       r = &b_res[idx];
> +
> +       if (!r->parent)
> +               return;
> +
> +       /*
> +        * if there are children under that, we should release them
> +        *  all
> +        */
> +       release_child_resources(r);
> +       if (!release_resource(r)) {
> +               type = old_flags = r->flags & type_mask;
> +               dev_printk(KERN_DEBUG, &dev->dev, "resource %d %pR released\n",
> +                                       PCI_BRIDGE_RESOURCES + idx, r);
> +               /* keep the old size */
> +               r->end = resource_size(r) - 1;
> +               r->start = 0;
> +               r->flags = 0;
>
> -       if (changed) {
>                 /* avoiding touch the one without PREF */
>                 if (type & IORESOURCE_PREFETCH)
>                         type = IORESOURCE_PREFETCH;
>                 __pci_setup_bridge(bus, type);
> +               /* for next child res under same bridge */
> +               r->flags = old_flags;
>         }
>  }
>
> @@ -1471,7 +1519,7 @@ void pci_assign_unassigned_root_bus_reso
>         LIST_HEAD(fail_head);
>         struct pci_dev_resource *fail_res;
>         unsigned long type_mask = IORESOURCE_IO | IORESOURCE_MEM |
> -                                 IORESOURCE_PREFETCH;
> +                                 IORESOURCE_PREFETCH | IORESOURCE_MEM_64;
>         int pci_try_num = 1;
>         enum enable_type enable_local;
>
> Index: linux-2.6/drivers/pci/setup-res.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/setup-res.c
> +++ linux-2.6/drivers/pci/setup-res.c
> @@ -208,15 +208,31 @@ static int __pci_assign_resource(struct
>
>         /* First, try exact prefetching match.. */
>         ret = pci_bus_alloc_resource(bus, res, size, align, min,
> -                                    IORESOURCE_PREFETCH,
> +                                    IORESOURCE_PREFETCH | IORESOURCE_MEM_64,
>                                      pcibios_align_resource, dev);
>
> -       if (ret < 0 && (res->flags & IORESOURCE_PREFETCH)) {
> +       if (ret < 0 &&
> +           (res->flags & (IORESOURCE_PREFETCH | IORESOURCE_MEM_64)) ==
> +            (IORESOURCE_PREFETCH | IORESOURCE_MEM_64)) {
> +               /*
> +                * That failed.
> +                *
> +                * Try below 4g pref
> +                */
> +               ret = pci_bus_alloc_resource(bus, res, size, align, min,
> +                                            IORESOURCE_PREFETCH,
> +                                            pcibios_align_resource, dev);
> +       }
> +
> +       if (ret < 0 &&
> +           (res->flags & (IORESOURCE_PREFETCH | IORESOURCE_MEM_64))) {
>                 /*
>                  * That failed.
>                  *
>                  * But a prefetching area can handle a non-prefetching
>                  * window (it will just not perform as well).
> +                *
> +                * Also can put 64bit under 32bit range. (below 4g).
>                  */
>                 ret = pci_bus_alloc_resource(bus, res, size, align, min, 0,
>                                              pcibios_align_resource, dev);
