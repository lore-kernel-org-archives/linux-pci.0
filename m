Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41030 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752542AbbJUCf1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 20 Oct 2015 22:35:27 -0400
Date: Tue, 20 Oct 2015 21:35:22 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 03/60] sparc/PCI: Unify pci_register_region()
Message-ID: <20151021023522.GJ8224@localhost>
References: <1444340359-8011-1-git-send-email-yinghai@kernel.org>
 <1444340359-8011-4-git-send-email-yinghai@kernel.org>
 <20151020215714.GI8224@localhost>
 <CAE9FiQVC+r=7NrCvwq9+1XVQD9CGf_3+-4VO9kFPSGqMTR5cBw@mail.gmail.com>
 <CAE9FiQUdKdyipTw3KSVL0Kr1FFvki5Un3NuUuXpw4TXoWi1Tpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQUdKdyipTw3KSVL0Kr1FFvki5Un3NuUuXpw4TXoWi1Tpg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 20, 2015 at 03:30:44PM -0700, Yinghai Lu wrote:
> On Tue, Oct 20, 2015 at 3:16 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> > On Tue, Oct 20, 2015 at 2:57 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >> On Thu, Oct 08, 2015 at 02:38:22PM -0700, Yinghai Lu wrote:
> >>> We register regions for legacy and iommu and all have open code.
> >>>
> >>> Unify them to pci_register_region() and call it accordingly.
> >>>
> >>> +     if (!mem_res->flags)
> >>>               return;
> >>>
> >>> -     p->name = "Video RAM area";
> >>> -     p->start = mem_res->start + 0xa0000UL;
> >>> -     p->end = p->start + 0x1ffffUL;
> >>> -     p->flags = IORESOURCE_BUSY;
> >>> -     request_resource(mem_res, p);
> >>> +     mem_rstart = mem_res->start - offset;
> >>> +     mem_rend = mem_res->end - offset;
> >>
> >> This is essentially doing pcibios_bus_to_resource(), except in an
> >> unnecessarily arch-dependent way.  Can you rework it to use
> >> pcibios_bus_to_resource()?  I think you'll have to do
> >> pci_register_legacy_regions() in pci_scan_one_pbm() instead of in
> >> pci_determine_mem_io_space(), so that you have a struct pci_bus to
> >> use, but your next patch does that anyway.
> >>
> >>>
> >>> -     p = kzalloc(sizeof(*p), GFP_KERNEL);
> >>> -     if (!p)
> >>> +     /* contain checking */
> >>> +     if (!(mem_rstart <= rstart && mem_rend >= rend))
> >>>               return;
> >
> > Difference is here.
> >
> > pcibios_bus_to_resource() would return resource even region is not contained.
> >
> >>> +     res->name = name;
> >>> +     res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
> >>> +     res->start = rstart + offset;
> >>> +     res->end = rend + offset;
> >>> +     conflict = request_resource_conflict(mem_res, res);
> >>> +     if (conflict) {
> >>> +             printk(KERN_DEBUG "PCI: %s can't claim %s %pR: address conflict with %s %pR\n",
> >>> +                     pbm->name, res->name, res, conflict->name, conflict);
> >>> +             kfree(res);
> >>> +     }
> >
> > also we will need to get parent resource to use request_resource_conflict.
> 
> so do you agree following change to pcibios_bus_to_resource() ?
> then we can use __pcibios_bus_resource().

I doubt I would agree with a change like this, but maybe, if you can
explain what's unique about the sparc architecture that would require
a change like this.

> diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
> index 5f4a2e0..6c73327 100644
> --- a/drivers/pci/host-bridge.c
> +++ b/drivers/pci/host-bridge.c
> @@ -70,12 +70,15 @@ static bool region_contains(struct pci_bus_region *region1,
>      return region1->start <= region2->start && region1->end >= region2->end;
>  }
> 
> -void pcibios_bus_to_resource(struct pci_bus *bus, struct resource *res,
> -                 struct pci_bus_region *region)
> +int __pcibios_bus_to_resource(struct pci_bus *bus, struct resource *res,
> +                 struct pci_bus_region *region,
> +                 struct resource **res_ret,
> +                 resource_size *off_ret)
>  {
>      struct pci_host_bridge *bridge = pci_find_host_bridge(bus);
>      struct resource_entry *window;
>      resource_size_t offset = 0;
> +    int found = 0;
> 
>      resource_list_for_each_entry(window, &bridge->windows) {
>          struct pci_bus_region bus_region;
> @@ -88,11 +91,23 @@ void pcibios_bus_to_resource(struct pci_bus *bus,
> struct resource *res,
> 
>          if (region_contains(&bus_region, region)) {
>              offset = window->offset;
> +            if (off_ret)
> +                *off_ret = offset;
> +            if (res_ret)
> +                *res_ret = window->res;
> +            found = 1;
>              break;
>          }
>      }
> 
>      res->start = region->start + offset;
>      res->end = region->end + offset;
> +
> +    return found;
> +}
> +void pcibios_bus_to_resource(struct pci_bus *bus, struct resource *res,
> +                 struct pci_bus_region *region)
> +{
> +    __pcibios_bus_to_resource(bus, res, region, NULL, NULL);
>  }
>  EXPORT_SYMBOL(pcibios_bus_to_resource);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index b54fbf1..bec3eed 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -781,6 +781,10 @@ void pci_fixup_cardbus(struct pci_bus *);
> 
>  void pcibios_resource_to_bus(struct pci_bus *bus, struct
> pci_bus_region *region,
>                   struct resource *res);
> +int __pcibios_bus_to_resource(struct pci_bus *bus, struct resource *res,
> +                  struct pci_bus_region *region,
> +                  struct resource **res_ret,
> +                  resource_size *off_ret);
>  void pcibios_bus_to_resource(struct pci_bus *bus, struct resource *res,
>                   struct pci_bus_region *region);
>  void pcibios_scan_specific_bus(int busn);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
