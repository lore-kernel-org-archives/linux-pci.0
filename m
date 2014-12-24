Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:59896 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302AbaLXR0u (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 24 Dec 2014 12:26:50 -0500
Received: by mail-ig0-f179.google.com with SMTP id r2so7220336igi.12
        for <linux-pci@vger.kernel.org>; Wed, 24 Dec 2014 09:26:50 -0800 (PST)
Date: Wed, 24 Dec 2014 10:26:46 -0700
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
Message-ID: <20141224172646.GA19561@google.com>
References: <CAErSpo7pMAL5i2aPGV3u5F178bHeQTtjASckKs9NaUbEGaxv3Q@mail.gmail.com>
 <20141208233855.GA15713@shangw>
 <CAE9FiQXj-vX8TE-8Es83FmJAKDKD_dMNbQkmsaNPyy_nVEag8w@mail.gmail.com>
 <20141220002306.GB30834@google.com>
 <CAE9FiQUU4OoxpV3MNyFdjtmS1nRfD=ziYDDnUmsGy5qj8U3vLg@mail.gmail.com>
 <CAErSpo7JAcLa_2gNkOG+oSHb1cbBXdEa-TVW0=amBptRB8-fNA@mail.gmail.com>
 <CAE9FiQV6nxeMcLQ6YBR_c5tNGGjiKgL+Z4vcGpK21j-14V8SKw@mail.gmail.com>
 <CAE9FiQVggbU5u__0z8p33J9hQ39CtQ-vpQbZyjG-LO9aqN05Lw@mail.gmail.com>
 <20141223214106.GA27291@google.com>
 <CAE9FiQUoA_vz78sEnHtDAmzTJcwL0PdUe9jwLw+H9h3+omq+WA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQUoA_vz78sEnHtDAmzTJcwL0PdUe9jwLw+H9h3+omq+WA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Dec 23, 2014 at 06:29:20PM -0800, Yinghai Lu wrote:
> On Tue, Dec 23, 2014 at 1:41 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> 
> >
> > Can you do this so it clips to any upstream bridge, whether it's a host
> > bridge or a PCI-to-PCI bridge?  It doesn't seem like this has to be
> > specific to host bridge windows -- any device below a PCI-to-PCI bridge has
> > to use address space forwarded by that upstream bridge.
> 
> ok, please check attached v2.
> 
> >
> > I wish this were in generic code.  There's nothing architecture-specific
> > about the problem, but this patch only fixes things on x86.  Can you make a
> > similar change in the corresponding code for other arches, as well?
> 
> ok, later after x86.

OK, how about if we test it on x86, and if it works, you fix the other
arches, and then I'll apply it for all arches at the same time?

We are trying to fix a regression, but I don't think there's any reason to
make the arches diverge for a relatively trivial change like this.

> Thanks
> 
> Yinghai

> Subject: [RFC PATCH -v2] PCI, x86: clip firmware assigned pci bridges under hostbridge
> 
> Some bios put range that is not fully coverred by root bus resources.
> Try to clip them and update them in pci bridge bars.
> 
> -v2: check with upstream bridge instead of host bridge only.
>      also add debug print out.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=85491
> Reported-by: Marek Kordik <kordikmarek@gmail.com>
> Fixes: 5b28541552ef ("PCI: Restrict 64-bit prefetchable bridge windows to 64-bit resources")
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> 
> ---
>  arch/x86/pci/i386.c |   81 +++++++++++++++++++++++++++++++++++++---------------
>  drivers/pci/bus.c   |   35 ++++++++++++++++++++++
>  include/linux/pci.h |    1 
>  3 files changed, 95 insertions(+), 22 deletions(-)
> 
> Index: linux-2.6/arch/x86/pci/i386.c
> ===================================================================
> --- linux-2.6.orig/arch/x86/pci/i386.c
> +++ linux-2.6/arch/x86/pci/i386.c
> @@ -205,28 +205,48 @@ EXPORT_SYMBOL(pcibios_align_resource);
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
> +		int ret;
> +
>  		r = &dev->resource[idx];
>  		if (!r->flags)
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
> +
> +		if (!r->start)
> +			goto clear;
> +
> +		ret = pci_claim_resource(dev, idx);
> +		if (ret >= 0)
> +			continue;
> +
> +		/* try again after clip for pci bridge*/
> +		if ((dev->class >> 8) == PCI_CLASS_BRIDGE_PCI &&
> +		    pci_bus_clip_resource(dev, r)) {
> +			changed = true;
> +			if (pci_claim_resource(dev, idx) >= 0)
> +				continue;
>  		}
> +
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
> @@ -234,8 +254,12 @@ static void pcibios_allocate_bus_resourc
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
> @@ -271,21 +295,34 @@ static void pcibios_allocate_dev_resourc
>  			else
>  				disabled = !(command & PCI_COMMAND_MEMORY);
>  			if (pass == disabled) {
> +				int ret;
> +
>  				dev_dbg(&dev->dev,
>  					"BAR %d: reserving %pr (d=%d, p=%d)\n",
>  					idx, r, disabled, pass);
> -				if (pci_claim_resource(dev, idx) < 0) {
> -					if (r->flags & IORESOURCE_PCI_FIXED) {
> -						dev_info(&dev->dev, "BAR %d %pR is immovable\n",
> +
> +				ret = pci_claim_resource(dev, idx);
> +
> +				if (ret >= 0)
> +					continue;
> +
> +				if (r->flags & IORESOURCE_PCI_FIXED) {
> +					dev_info(&dev->dev, "BAR %d %pR is immovable\n",
>  							 idx, r);
> -					} else {
> -						/* We'll assign a new address later */
> -						pcibios_save_fw_addr(dev,
> -								idx, r->start);
> -						r->end -= r->start;
> -						r->start = 0;
> -					}
> +					continue;
> +				}
> +
> +				/* try again with clip */
> +				if (pci_bus_clip_resource(dev, r)) {
> +					pci_update_resource(dev, idx);
> +					if (pci_claim_resource(dev, idx) >= 0)
> +						continue;
>  				}
> +
> +				/* We'll assign a new address later */
> +				pcibios_save_fw_addr(dev, idx, r->start);
> +				r->end -= r->start;
> +				r->start = 0;
>  			}
>  		}
>  	if (!pass) {
> Index: linux-2.6/include/linux/pci.h
> ===================================================================
> --- linux-2.6.orig/include/linux/pci.h
> +++ linux-2.6/include/linux/pci.h
> @@ -1094,6 +1094,7 @@ void pci_free_resource_list(struct list_
>  void pci_bus_add_resource(struct pci_bus *bus, struct resource *res, unsigned int flags);
>  struct resource *pci_bus_resource_n(const struct pci_bus *bus, int n);
>  void pci_bus_remove_resources(struct pci_bus *bus);
> +bool pci_bus_clip_resource(struct pci_dev *dev, struct resource *res);
>  
>  #define pci_bus_for_each_resource(bus, res, i)				\
>  	for (i = 0;							\
> Index: linux-2.6/drivers/pci/bus.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/bus.c
> +++ linux-2.6/drivers/pci/bus.c
> @@ -228,6 +228,41 @@ int pci_bus_alloc_resource(struct pci_bu
>  }
>  EXPORT_SYMBOL(pci_bus_alloc_resource);
>  
> +bool pci_bus_clip_resource(struct pci_dev *dev, struct resource *res)
> +{
> +	struct pci_bus *bus = dev->bus;
> +	resource_size_t start, end;
> +	struct resource orig_res = *res;
> +	struct resource *r;
> +	int i;
> +
> +	pci_bus_for_each_resource(bus, r, i) {
> +
> +		if (resource_type(res) != resource_type(r))
> +			continue;
> +
> +		start = max(r->start, res->start);
> +		end = min(r->end, res->end);
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
> +		dev_printk(KERN_DEBUG, &dev->dev, "%pR ==> %pR\n",
> +				 &orig_res, res);
> +
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
>  void __weak pcibios_resource_survey_bus(struct pci_bus *bus) { }
>  
>  /**

