Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:64753 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751098AbaIDETa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Sep 2014 00:19:30 -0400
Received: by mail-pd0-f181.google.com with SMTP id fp1so12760969pdb.40
        for <linux-pci@vger.kernel.org>; Wed, 03 Sep 2014 21:19:30 -0700 (PDT)
Date: Wed, 3 Sep 2014 22:20:14 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guo Chao <yan@linux.vnet.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] pci: Allow very large resource windows
Message-ID: <20140904042014.GF26073@google.com>
References: <CAE9FiQU5Ltu89zmRG0h2aXfXH0oCcTEP=jF7b=zHi=SaOA2rKg@mail.gmail.com>
 <20140703131526.GG28852@google.com>
 <CAE9FiQWPGXMBYmpzyk8cicKZ1ELUZiARkZjr2vvgntmt3bt1jQ@mail.gmail.com>
 <20140703221152.GH28852@google.com>
 <CAE9FiQX69x_YgHihYM-+tahTvbuk6MATBXvm9Rz5kiQ9UpKNPg@mail.gmail.com>
 <CAErSpo4DzJ112NxfjXT=NbXMxNqre_Vo61fS0Mem=MWCz+OvcA@mail.gmail.com>
 <CAE9FiQWUPd4d9DWeiuDqQ=tKKe+5ZofUEw3JViXYs6+9zBG6Sg@mail.gmail.com>
 <CA+55aFwyfaAa3opKsDth7b4RXb7E2_Thb581VWvg9V-GvJCYbg@mail.gmail.com>
 <CAErSpo4GvYgP5zRq0vzFrCGzrYBF9u=KWus8PPNGKpyJVZzYkA@mail.gmail.com>
 <CAE9FiQXCOvgCTiUhTeBYjHQeMA0wNJ7gJDO9mXXUmZSrH90Exw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQXCOvgCTiUhTeBYjHQeMA0wNJ7gJDO9mXXUmZSrH90Exw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 11, 2014 at 06:22:08PM -0700, Yinghai Lu wrote:
> On Fri, Jul 11, 2014 at 11:40 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> > On Fri, Jul 11, 2014 at 12:21 PM, Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> >> On Fri, Jul 11, 2014 at 11:09 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> >>>
> >>> If the BAR have all 0, cpu can not access it as hw will forward access to ram
> >>> controller according to routing table.
> >>
> >> On PC's, yes (also likely with many devices - there are definitely
> >> devices out there were setting the BAR to zero disables it).
> >
> > Ooh, we might trip over this some day on a platform with host bridge
> > address translation that maps to PCI bus address 0.  I don't think we
> > have anything in the allocator that avoids bus address 0 in that case.
> 
> Anyway, I draft RFC one that replace flags = 0 with flags |=
> IORESOURCE_UNSET | IORESOURCE_DISABLEd.

I think we should do something like this patch, but we need to clarify how
we want to use the IORESOURCE flags.

Here's what I think these IORESOURCE flags mean:

  IORESOURCE_MEM        Hardware decodes memory accesses (when enabled)

  IORESOURCE_UNSET      We have not allocated space for this decoder,
                        although the hardware still contains some address

  IORESOURCE_DISABLED   This hardware decoder is disabled, e.g., a bridge
                        window with LIMIT < BASE, or a ROM BAR with its
                        enable bit cleared

For PCI, this would imply:

  - The resource for a standard BAR should never have IORESOURCE_DISABLED
    because it can't be individually disabled.

  - We can turn on PCI_COMMAND_MEMORY only if every IORESOURCE_MEM resource
    has either (IORESOURCE_DISABLED set) or (IORESOURCE_UNSET cleared).

> Let's see how many drivers will fail.
> 
> Yinghai

> Subject: [RFC PATCH] PCI: don't set flags to 0 when assign resource fail
> 
> make flags take IORESOURCE_UNSET | IORESOURCE_DISABLE instead.
> 
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> 
> ---
>  drivers/pci/setup-bus.c |   49 ++++++++++++++++++++++++------------------------
>  drivers/pci/setup-res.c |   11 ++++++++++
>  2 files changed, 36 insertions(+), 24 deletions(-)
> 
> Index: linux-2.6/drivers/pci/setup-bus.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/setup-bus.c
> +++ linux-2.6/drivers/pci/setup-bus.c
> @@ -136,7 +136,8 @@ static void pdev_sort_resources(struct p
>  		if (r->flags & IORESOURCE_PCI_FIXED)
>  			continue;
>  
> -		if (!(r->flags) || r->parent)
> +		if (!(r->flags) || r->parent ||
> +		    (r->flags & IORESOURCE_DISABLED))
>  			continue;
>  
>  		r_align = pci_resource_alignment(dev, r);
> @@ -190,13 +191,6 @@ static void __dev_sort_resources(struct
>  	pdev_sort_resources(dev, head);
>  }
>  
> -static inline void reset_resource(struct resource *res)
> -{
> -	res->start = 0;
> -	res->end = 0;
> -	res->flags = 0;
> -}
> -
>  /**
>   * reassign_resources_sorted() - satisfy any additional resource requests
>   *
> @@ -242,7 +236,7 @@ static void reassign_resources_sorted(st
>  			res->start = add_res->start;
>  			res->end = res->start + add_size - 1;
>  			if (pci_assign_resource(add_res->dev, idx))
> -				reset_resource(res);
> +				res->flags |= IORESOURCE_DISABLED;
>  		} else {
>  			resource_size_t align = add_res->min_align;
>  			res->flags |= add_res->flags &
> @@ -294,7 +288,7 @@ static void assign_requested_resources_s
>  						    0 /* don't care */,
>  						    0 /* don't care */);
>  			}
> -			reset_resource(res);
> +			res->flags |= IORESOURCE_DISABLED;
>  		}
>  	}
>  }
> @@ -547,7 +541,7 @@ static void pci_setup_bridge_io(struct p
>  	/* Set up the top and bottom of the PCI I/O segment for this bus. */
>  	res = bus->resource[0];
>  	pcibios_resource_to_bus(bridge->bus, &region, res);
> -	if (res->flags & IORESOURCE_IO) {
> +	if ((res->flags & IORESOURCE_IO) && !(res->flags & IORESOURCE_UNSET)) {
>  		pci_read_config_word(bridge, PCI_IO_BASE, &l);
>  		io_base_lo = (region.start >> 8) & io_mask;
>  		io_limit_lo = (region.end >> 8) & io_mask;
> @@ -578,7 +572,8 @@ static void pci_setup_bridge_mmio(struct
>  	/* Set up the top and bottom of the PCI Memory segment for this bus. */
>  	res = bus->resource[1];
>  	pcibios_resource_to_bus(bridge->bus, &region, res);
> -	if (res->flags & IORESOURCE_MEM) {
> +	if ((res->flags & IORESOURCE_MEM) &&
> +	    !(res->flags & IORESOURCE_UNSET)) {
>  		l = (region.start >> 16) & 0xfff0;
>  		l |= region.end & 0xfff00000;
>  		dev_info(&bridge->dev, "  bridge window %pR\n", res);
> @@ -604,7 +599,8 @@ static void pci_setup_bridge_mmio_pref(s
>  	bu = lu = 0;
>  	res = bus->resource[2];
>  	pcibios_resource_to_bus(bridge->bus, &region, res);
> -	if (res->flags & IORESOURCE_PREFETCH) {
> +	if ((res->flags & IORESOURCE_PREFETCH) &&
> +	    !(res->flags & IORESOURCE_UNSET)) {
>  		l = (region.start >> 16) & 0xfff0;
>  		l |= region.end & 0xfff00000;
>  		if (res->flags & IORESOURCE_MEM_64) {
> @@ -661,6 +657,7 @@ static void pci_bridge_check_ranges(stru
>  
>  	b_res = &bridge->resource[PCI_BRIDGE_RESOURCES];
>  	b_res[1].flags |= IORESOURCE_MEM;
> +	b_res[1].flags &= ~IORESOURCE_DISABLED;
>  
>  	pci_read_config_word(bridge, PCI_IO_BASE, &io);
>  	if (!io) {
> @@ -668,8 +665,10 @@ static void pci_bridge_check_ranges(stru
>  		pci_read_config_word(bridge, PCI_IO_BASE, &io);
>  		pci_write_config_word(bridge, PCI_IO_BASE, 0x0);
>  	}
> -	if (io)
> +	if (io) {
>  		b_res[0].flags |= IORESOURCE_IO;
> +		b_res[0].flags &= ~IORESOURCE_DISABLED;
> +	}
>  
>  	/*  DECchip 21050 pass 2 errata: the bridge may miss an address
>  	    disconnect boundary by one PCI data phase.
> @@ -686,6 +685,7 @@ static void pci_bridge_check_ranges(stru
>  	}
>  	if (pmem) {
>  		b_res[2].flags |= IORESOURCE_MEM | IORESOURCE_PREFETCH;
> +		b_res[2].flags &= ~IORESOURCE_DISABLED;
>  		if ((pmem & PCI_PREF_RANGE_TYPE_MASK) ==
>  		    PCI_PREF_RANGE_TYPE_64) {
>  			b_res[2].flags |= IORESOURCE_MEM_64;
> @@ -830,8 +830,10 @@ static void pbus_size_io(struct pci_bus
>  			struct resource *r = &dev->resource[i];
>  			unsigned long r_size;
>  
> -			if (r->parent || !(r->flags & IORESOURCE_IO))
> +			if (r->parent || !(r->flags & IORESOURCE_IO) ||
> +			    (r->flags & IORESOURCE_DISABLED))
>  				continue;
> +
>  			r_size = resource_size(r);
>  
>  			if (r_size < 0x400)
> @@ -860,7 +862,7 @@ static void pbus_size_io(struct pci_bus
>  		if (b_res->start || b_res->end)
>  			dev_info(&bus->self->dev, "disabling bridge window %pR to %pR (unused)\n",
>  				 b_res, &bus->busn_res);
> -		b_res->flags = 0;
> +		b_res->flags |= IORESOURCE_UNSET | IORESOURCE_DISABLED;
>  		return;
>  	}
>  
> @@ -947,8 +949,10 @@ static int pbus_size_mem(struct pci_bus
>  
>  			if (r->parent || ((r->flags & mask) != type &&
>  					  (r->flags & mask) != type2 &&
> -					  (r->flags & mask) != type3))
> +					  (r->flags & mask) != type3) ||
> +			    (r->flags & IORESOURCE_DISABLED))
>  				continue;
> +
>  			r_size = resource_size(r);
>  #ifdef CONFIG_PCI_IOV
>  			/* put SRIOV requested res to the optional list */
> @@ -973,7 +977,8 @@ static int pbus_size_mem(struct pci_bus
>  			if (order >= ARRAY_SIZE(aligns)) {
>  				dev_warn(&dev->dev, "disabling BAR %d: %pR (bad alignment %#llx)\n",
>  					 i, r, (unsigned long long) align);
> -				r->flags = 0;
> +				r->flags |= IORESOURCE_UNSET |
> +					    IORESOURCE_DISABLED;
>  				continue;
>  			}
>  			size += r_size;
> @@ -1001,7 +1006,7 @@ static int pbus_size_mem(struct pci_bus
>  		if (b_res->start || b_res->end)
>  			dev_info(&bus->self->dev, "disabling bridge window %pR to %pR (unused)\n",
>  				 b_res, &bus->busn_res);
> -		b_res->flags = 0;
> +		b_res->flags |= IORESOURCE_UNSET | IORESOURCE_DISABLED;
>  		return 0;
>  	}
>  	b_res->start = min_align;
> @@ -1367,7 +1372,7 @@ static void pci_bridge_release_resources
>  		/* keep the old size */
>  		r->end = resource_size(r) - 1;
>  		r->start = 0;
> -		r->flags = 0;
> +		r->flags |= IORESOURCE_UNSET | IORESOURCE_DISABLED;
>  
>  		/* avoiding touch the one without PREF */
>  		if (type & IORESOURCE_PREFETCH)
> @@ -1622,8 +1627,6 @@ again:
>  		res->start = fail_res->start;
>  		res->end = fail_res->end;
>  		res->flags = fail_res->flags;
> -		if (fail_res->dev->subordinate)
> -			res->flags = 0;
>  	}
>  	free_list(&fail_head);
>  
> @@ -1688,8 +1691,6 @@ again:
>  		res->start = fail_res->start;
>  		res->end = fail_res->end;
>  		res->flags = fail_res->flags;
> -		if (fail_res->dev->subordinate)
> -			res->flags = 0;
>  	}
>  	free_list(&fail_head);
>  
> Index: linux-2.6/drivers/pci/setup-res.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/setup-res.c
> +++ linux-2.6/drivers/pci/setup-res.c
> @@ -362,6 +362,17 @@ int pci_enable_resources(struct pci_dev
>  			continue;
>  
>  		if (r->flags & IORESOURCE_UNSET) {
> +			/* bridge BAR could be disabled one by one */
> +			if (dev->subordinate && i >= PCI_BRIDGE_RESOURCES &&
> +						i <= PCI_BRIDGE_RESOURCE_END)
> +				continue;
> +
> +#ifdef CONFIG_PCI_IOV
> +			/* SRIOV ? */
> +			if (i >= PCI_IOV_RESOURCES && i <= PCI_IOV_RESOURCE_END)
> +				continue;
> +#endif
> +
>  			dev_err(&dev->dev, "can't enable device: BAR %d %pR not assigned\n",
>  				i, r);
>  			return -EINVAL;

