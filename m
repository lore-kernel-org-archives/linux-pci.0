Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:39377 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501AbaLWVlL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 23 Dec 2014 16:41:11 -0500
Received: by mail-ig0-f175.google.com with SMTP id h15so6101171igd.2
        for <linux-pci@vger.kernel.org>; Tue, 23 Dec 2014 13:41:10 -0800 (PST)
Date: Tue, 23 Dec 2014 14:41:06 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Marek =?iso-8859-1?Q?Kord=EDk?= <kordikmarek@gmail.com>,
	Gavin Shan <gwshan@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Alexey Voronkov <zermond@gmail.com>,
	David Airlie <airlied@linux.ie>,
	Alex Deucher <alexdeucher@gmail.com>,
	Richard Yang <weiyang@linux.vnet.ibm.com>
Subject: Re: Regression: bug 85491: radeon 0000:01:00.0: Fatal error during
 GPU init
Message-ID: <20141223214106.GA27291@google.com>
References: <CAErSpo69c6jXOp+nw2sTSU4vgqGufUQNUEGK4_2+6p-qpyE0vQ@mail.gmail.com>
 <1418074683.13358.1.camel@kernel.crashing.org>
 <CAErSpo7pMAL5i2aPGV3u5F178bHeQTtjASckKs9NaUbEGaxv3Q@mail.gmail.com>
 <20141208233855.GA15713@shangw>
 <CAE9FiQXj-vX8TE-8Es83FmJAKDKD_dMNbQkmsaNPyy_nVEag8w@mail.gmail.com>
 <20141220002306.GB30834@google.com>
 <CAE9FiQUU4OoxpV3MNyFdjtmS1nRfD=ziYDDnUmsGy5qj8U3vLg@mail.gmail.com>
 <CAErSpo7JAcLa_2gNkOG+oSHb1cbBXdEa-TVW0=amBptRB8-fNA@mail.gmail.com>
 <CAE9FiQV6nxeMcLQ6YBR_c5tNGGjiKgL+Z4vcGpK21j-14V8SKw@mail.gmail.com>
 <CAE9FiQVggbU5u__0z8p33J9hQ39CtQ-vpQbZyjG-LO9aqN05Lw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQVggbU5u__0z8p33J9hQ39CtQ-vpQbZyjG-LO9aqN05Lw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 22, 2014 at 05:53:55PM -0800, Yinghai Lu wrote:
> On Fri, Dec 19, 2014 at 5:33 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> > On Fri, Dec 19, 2014 at 4:56 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> >>
> >> Marek's case is a little easier because his system is using _CRS.  We
> >> should be able to notice that the Root Port window overlaps the host
> >> bridge window, but isn't contained by it.  In that case, if we merely
> >> trim the Root Port window so it fits, everything will just work.
> >
> > Ok, will check that Monday.
> 
> Please check attached patch that clip bridge resource.
> 
> Marek, can you give it a try on top of v3.18?
> 
> Thanks
> 
> Yinghai

> Subject: [RFC PATCH] PCI, x86: clip firmware assigned pci bridges under hostbridge
> 
> Some bios put range that is not fully coverred by root bus resources.
> Try to clip them and update them in pci bridge bars.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=85491
> Reported-by: Marek Kordik <kordikmarek@gmail.com>
> Fixes: 5b28541552ef ("PCI: Restrict 64-bit prefetchable bridge windows to 64-bit resources")
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> 
> ---
>  arch/x86/pci/i386.c       |   43 +++++++++++++++++++++++++++++++------------
>  drivers/pci/host-bridge.c |   31 +++++++++++++++++++++++++++++++
>  include/linux/pci.h       |    2 ++
>  3 files changed, 64 insertions(+), 12 deletions(-)
> 
> Index: linux-2.6/arch/x86/pci/i386.c
> ===================================================================
> --- linux-2.6.orig/arch/x86/pci/i386.c
> +++ linux-2.6/arch/x86/pci/i386.c
> @@ -205,10 +205,11 @@ EXPORT_SYMBOL(pcibios_align_resource);
>   *	    as well.
>   */
>  
> -static void pcibios_allocate_bridge_resources(struct pci_dev *dev)
> +static bool pcibios_allocate_bridge_resources(struct pci_dev *dev)
>  {
>  	int idx;
>  	struct resource *r;
> +	bool changed = false;
>  
>  	for (idx = PCI_BRIDGE_RESOURCES; idx < PCI_NUM_RESOURCES; idx++) {
>  		r = &dev->resource[idx];
> @@ -216,17 +217,31 @@ static void pcibios_allocate_bridge_reso
>  			continue;
>  		if (r->parent)	/* Already allocated */
>  			continue;
> -		if (!r->start || pci_claim_resource(dev, idx) < 0) {
> -			/*
> -			 * Something is wrong with the region.
> -			 * Invalidate the resource to prevent
> -			 * child resource allocations in this
> -			 * range.
> -			 */
> -			r->start = r->end = 0;
> -			r->flags = 0;
> +		if (!r->start)
> +			goto clear;
> +		if (pci_claim_resource(dev, idx) < 0) {
> +			/* try again after clip for pci bridge*/
> +			if ((dev->class >> 8) == PCI_CLASS_BRIDGE_PCI &&
> +			    pcibios_resource_clip_in_host_bridge(dev->bus, r)) {

Can you do this so it clips to any upstream bridge, whether it's a host
bridge or a PCI-to-PCI bridge?  It doesn't seem like this has to be
specific to host bridge windows -- any device below a PCI-to-PCI bridge has
to use address space forwarded by that upstream bridge.

I wish this were in generic code.  There's nothing architecture-specific
about the problem, but this patch only fixes things on x86.  Can you make a
similar change in the corresponding code for other arches, as well?

> +				changed = true;
> +				if (pci_claim_resource(dev, idx) >= 0)
> +					continue;
> +			}
> +			goto clear;
>  		}
> +		continue;
> +clear:
> +		/*
> +		 * Something is wrong with the region.
> +		 * Invalidate the resource to prevent
> +		 * child resource allocations in this
> +		 * range.
> +		 */
> +		r->start = r->end = 0;
> +		r->flags = 0;
>  	}
> +
> +	return changed;
>  }
>  
>  static void pcibios_allocate_bus_resources(struct pci_bus *bus)
> @@ -234,8 +249,12 @@ static void pcibios_allocate_bus_resourc
>  	struct pci_bus *child;
>  
>  	/* Depth-First Search on bus tree */
> -	if (bus->self)
> -		pcibios_allocate_bridge_resources(bus->self);
> +	if (bus->self) {
> +		bool changed = pcibios_allocate_bridge_resources(bus->self);
> +
> +		if (changed)
> +			pci_setup_bridge(bus);
> +	}
>  	list_for_each_entry(child, &bus->children, node)
>  		pcibios_allocate_bus_resources(child);
>  }
> Index: linux-2.6/drivers/pci/host-bridge.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/host-bridge.c
> +++ linux-2.6/drivers/pci/host-bridge.c
> @@ -31,6 +31,37 @@ void pci_set_host_bridge_release(struct
>  	bridge->release_data = release_data;
>  }
>  
> +bool pcibios_resource_clip_in_host_bridge(struct pci_bus *bus,
> +					  struct resource *res)
> +{
> +	struct pci_host_bridge *bridge = find_pci_host_bridge(bus);
> +	struct pci_host_bridge_window *window;
> +	resource_size_t start, end;
> +
> +	list_for_each_entry(window, &bridge->windows, list) {
> +		if (resource_type(res) != resource_type(window->res))
> +			continue;
> +
> +		start = max(window->res->start, res->start);
> +		end = min(window->res->end, res->end);
> +
> +		/* no overlap ? */
> +		if (start > end)
> +			continue;
> +
> +		if (res->start == start && res->end == end)
> +			return false;
> +
> +		/* changed */
> +		res->start = start;
> +		res->end = end;

I think it'd be useful to emit a diagnostic here so there's a clue in dmesg
about what's going on.

> +		return true;
> +	}
> +
> +	return false;
> +}
> +
>  void pcibios_resource_to_bus(struct pci_bus *bus, struct pci_bus_region *region,
>  			     struct resource *res)
>  {
> Index: linux-2.6/include/linux/pci.h
> ===================================================================
> --- linux-2.6.orig/include/linux/pci.h
> +++ linux-2.6/include/linux/pci.h
> @@ -762,6 +762,8 @@ void pci_fixup_cardbus(struct pci_bus *)
>  
>  /* Generic PCI functions used internally */
>  
> +bool pcibios_resource_clip_in_host_bridge(struct pci_bus *bus,
> +					  struct resource *res);
>  void pcibios_resource_to_bus(struct pci_bus *bus, struct pci_bus_region *region,
>  			     struct resource *res);
>  void pcibios_bus_to_resource(struct pci_bus *bus, struct resource *res,

