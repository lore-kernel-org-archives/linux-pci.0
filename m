Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp09.in.ibm.com ([122.248.162.9]:33436 "EHLO
	e28smtp09.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852Ab3KVHId (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 22 Nov 2013 02:08:33 -0500
Received: from /spool/local
	by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <yan@linux.vnet.ibm.com>;
	Fri, 22 Nov 2013 12:38:30 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by d28dlp02.in.ibm.com (Postfix) with ESMTP id ACE0C394003F
	for <linux-pci@vger.kernel.org>; Fri, 22 Nov 2013 12:38:28 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id rAM78OSP19660872
	for <linux-pci@vger.kernel.org>; Fri, 22 Nov 2013 12:38:24 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
	by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id rAM78QUL021010
	for <linux-pci@vger.kernel.org>; Fri, 22 Nov 2013 12:38:27 +0530
Date: Fri, 22 Nov 2013 15:08:20 +0800
From: Guo Chao <yan@linux.vnet.ibm.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 6/6] PCI: Try to allocate mem64 above 4G at first
Message-ID: <20131122070820.GA15145@yanx>
References: <1384912317-3721-1-git-send-email-yinghai@kernel.org>
 <1384912317-3721-7-git-send-email-yinghai@kernel.org>
 <20131121103021.GA29873@yanx>
 <CAE9FiQXgvaqErd1oiHmt6G8GwbW92C490+0sYyLUMcMFMMNRAg@mail.gmail.com>
 <CA+55aFyM5o39pmFtPOc1VVE5y_SYp1WXtz773cBp3fHrvnzOLQ@mail.gmail.com>
 <CAE9FiQVY6si_3uG6ndbZVOWCY5o8RuXpSLimEo96FVtNC38Dgw@mail.gmail.com>
 <CA+55aFyDSK9fOwicxP3=44-R_tDLgBtm93wVFPrquizO3WJuSQ@mail.gmail.com>
 <CAE9FiQUXgN69frsL4OQKkY-ZZWnA0rgR-MiTpcDqnDq+=NzEGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQUXgN69frsL4OQKkY-ZZWnA0rgR-MiTpcDqnDq+=NzEGg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 21, 2013 at 10:11:27PM -0800, Yinghai Lu wrote:
> On Thu, Nov 21, 2013 at 1:42 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > On Thu, Nov 21, 2013 at 1:34 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> >>
> >> Here are suggestion is:
> >> assume mmio pref: will be use for 64bit pref only, and if the mmio pref
> >> does not support 64bit, we just ignore it.
> >> If devices under that bridge need pref, we will just use range from bridge's
> >> nonpref mmio.
> >
> > Since we always scan devices behind the bus, why don't we take that
> > into account? If we find devices with 32-bit mmio, we try to make the
> > prefetchable one be in the 32-bit range.
> 
> Refresh one old patch, and it will separate 32bit pref and 64bit pref depend
> on the bridge capability.
> 
> | Subject: [PATCH] PCI: Try best to allocate pref mem 64 above 4g
> |
> | When one of children resources does not support MEM_64, MEM_64 for
> | bridge get reset, so pull down whole resource under 4G.
> |
> | We could move those 32bit pref mmio under 32bit non-pref mmio of the bridge.
> |
> | If the bridge support pref mem 64, will only allocate that with pref mem64 to
> | children that support it.
> | For children resources if they only support pref mem 32, will allocate them
> | from non pref mem instead.
> |
> | If the bridge only support 32bit pref mmio, will still have all children pref
> | mmio under that.
> 
> Guo, Can you test it on top of those 6 patches ?
> 

Tested-by: Guo Chao <yan@linux.vnet.ibm.com>

Thanks,
Guo Chao

> Thanks
> 
> Yinghai

> Subject: [PATCH] PCI: Try best to allocate pref mem 64 above 4g
> 
> When one of children resources does not support MEM_64, MEM_64 for
> bridge get reset, so pull down whole resource under 4G.
> 
> We could move those 32bit pref mmio under 32bit non-pref mmio of the bridge.
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
> -v3: refresh and make it can be applied early before for_each_dev_res
> 
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> 
> ---
>  drivers/pci/setup-bus.c |  133 +++++++++++++++++++++++++++++++-----------------
>  drivers/pci/setup-res.c |   14 ++++-
>  2 files changed, 101 insertions(+), 46 deletions(-)
> 
> Index: linux-2.6/drivers/pci/setup-bus.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/setup-bus.c
> +++ linux-2.6/drivers/pci/setup-bus.c
> @@ -711,12 +711,11 @@ static void pci_bridge_check_ranges(stru
>     bus resource of a given type. Note: we intentionally skip
>     the bus resources which have already been assigned (that is,
>     have non-NULL parent resource). */
> -static struct resource *find_free_bus_resource(struct pci_bus *bus, unsigned long type)
> +static struct resource *find_free_bus_resource(struct pci_bus *bus,
> +			 unsigned long type_mask, unsigned long type)
>  {
>  	int i;
>  	struct resource *r;
> -	unsigned long type_mask = IORESOURCE_IO | IORESOURCE_MEM |
> -				  IORESOURCE_PREFETCH;
>  
>  	pci_bus_for_each_resource(bus, r, i) {
>  		if (r == &ioport_resource || r == &iomem_resource)
> @@ -813,7 +812,8 @@ static void pbus_size_io(struct pci_bus
>  		resource_size_t add_size, struct list_head *realloc_head)
>  {
>  	struct pci_dev *dev;
> -	struct resource *b_res = find_free_bus_resource(bus, IORESOURCE_IO);
> +	struct resource *b_res = find_free_bus_resource(bus, IORESOURCE_IO,
> +							IORESOURCE_IO);
>  	resource_size_t size = 0, size0 = 0, size1 = 0;
>  	resource_size_t children_add_size = 0;
>  	resource_size_t min_align, align;
> @@ -913,15 +913,16 @@ static inline resource_size_t calculate_
>   * guarantees that all child resources fit in this size.
>   */
>  static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
> -			 unsigned long type, resource_size_t min_size,
> -			resource_size_t add_size,
> -			struct list_head *realloc_head)
> +			 unsigned long type, unsigned long type2,
> +			 resource_size_t min_size, resource_size_t add_size,
> +			 struct list_head *realloc_head)
>  {
>  	struct pci_dev *dev;
>  	resource_size_t min_align, align, size, size0, size1;
>  	resource_size_t aligns[12];	/* Alignments from 1Mb to 2Gb */
>  	int order, max_order;
> -	struct resource *b_res = find_free_bus_resource(bus, type);
> +	struct resource *b_res = find_free_bus_resource(bus,
> +					 mask | IORESOURCE_PREFETCH, type);
>  	unsigned int mem64_mask = 0;
>  	resource_size_t children_add_size = 0;
>  
> @@ -942,7 +943,8 @@ static int pbus_size_mem(struct pci_bus
>  			struct resource *r = &dev->resource[i];
>  			resource_size_t r_size;
>  
> -			if (r->parent || (r->flags & mask) != type)
> +			if (r->parent || ((r->flags & mask) != type &&
> +					  (r->flags & mask) != type2))
>  				continue;
>  			r_size = resource_size(r);
>  #ifdef CONFIG_PCI_IOV
> @@ -1115,8 +1117,9 @@ void __ref __pci_bus_size_bridges(struct
>  			struct list_head *realloc_head)
>  {
>  	struct pci_dev *dev;
> -	unsigned long mask, prefmask;
> +	unsigned long mask, prefmask, type2 = 0;
>  	resource_size_t additional_mem_size = 0, additional_io_size = 0;
> +	struct resource *b_res;
>  
>  	list_for_each_entry(dev, &bus->devices, bus_list) {
>  		struct pci_bus *b = dev->subordinate;
> @@ -1161,15 +1164,31 @@ void __ref __pci_bus_size_bridges(struct
>  		   has already been allocated by arch code, try
>  		   non-prefetchable range for both types of PCI memory
>  		   resources. */
> +		b_res = &bus->self->resource[PCI_BRIDGE_RESOURCES];
>  		mask = IORESOURCE_MEM;
>  		prefmask = IORESOURCE_MEM | IORESOURCE_PREFETCH;
> -		if (pbus_size_mem(bus, prefmask, prefmask,
> +		if (b_res[2].flags & IORESOURCE_MEM_64) {
> +			prefmask |= IORESOURCE_MEM_64;
> +			if (pbus_size_mem(bus, prefmask, prefmask, prefmask,
>  				  realloc_head ? 0 : additional_mem_size,
> -				  additional_mem_size, realloc_head))
> -			mask = prefmask; /* Success, size non-prefetch only. */
> -		else
> -			additional_mem_size += additional_mem_size;
> -		pbus_size_mem(bus, mask, IORESOURCE_MEM,
> +				  additional_mem_size, realloc_head)) {
> +					/* Success, size non-pref64 only. */
> +					mask = prefmask;
> +					type2 = prefmask & ~IORESOURCE_MEM_64;
> +			}
> +		}
> +		if (!type2) {
> +			prefmask &= ~IORESOURCE_MEM_64;
> +			if (pbus_size_mem(bus, prefmask, prefmask, prefmask,
> +					 realloc_head ? 0 : additional_mem_size,
> +					 additional_mem_size, realloc_head)) {
> +				/* Success, size non-prefetch only. */
> +				mask = prefmask;
> +			} else
> +				additional_mem_size += additional_mem_size;
> +			type2 = IORESOURCE_MEM;
> +		}
> +		pbus_size_mem(bus, mask, IORESOURCE_MEM, type2,
>  				realloc_head ? 0 : additional_mem_size,
>  				additional_mem_size, realloc_head);
>  		break;
> @@ -1255,42 +1274,66 @@ static void __ref __pci_bridge_assign_re
>  static void pci_bridge_release_resources(struct pci_bus *bus,
>  					  unsigned long type)
>  {
> -	int idx;
> -	bool changed = false;
> -	struct pci_dev *dev;
> +	struct pci_dev *dev = bus->self;
>  	struct resource *r;
>  	unsigned long type_mask = IORESOURCE_IO | IORESOURCE_MEM |
> -				  IORESOURCE_PREFETCH;
> +				  IORESOURCE_PREFETCH | IORESOURCE_MEM_64;
> +	unsigned old_flags = 0;
> +	struct resource *b_res;
> +	int idx = 1;
>  
> -	dev = bus->self;
> -	for (idx = PCI_BRIDGE_RESOURCES; idx <= PCI_BRIDGE_RESOURCE_END;
> -	     idx++) {
> -		r = &dev->resource[idx];
> -		if ((r->flags & type_mask) != type)
> -			continue;
> -		if (!r->parent)
> -			continue;
> -		/*
> -		 * if there are children under that, we should release them
> -		 *  all
> -		 */
> -		release_child_resources(r);
> -		if (!release_resource(r)) {
> -			dev_printk(KERN_DEBUG, &dev->dev,
> -				 "resource %d %pR released\n", idx, r);
> -			/* keep the old size */
> -			r->end = resource_size(r) - 1;
> -			r->start = 0;
> -			r->flags = 0;
> -			changed = true;
> -		}
> -	}
> +	b_res = &dev->resource[PCI_BRIDGE_RESOURCES];
> +
> +	/*
> +	 *     1. if there is io port assign fail, will release bridge
> +	 *	  io port.
> +	 *     2. if there is non pref mmio assign fail, release bridge
> +	 *	  nonpref mmio.
> +	 *     3. if there is 64bit pref mmio assign fail, and bridge pref
> +	 *	  is 64bit, release bridge pref mmio.
> +	 *     4. if there is pref mmio assign fail, and bridge pref is
> +	 *	  32bit mmio, release bridge pref mmio
> +	 *     5. if there is pref mmio assign fail, and bridge pref is not
> +	 *	  assigned, release bridge nonpref mmio.
> +	 */
> +	if (type & IORESOURCE_IO)
> +		idx = 0;
> +	else if (!(type & IORESOURCE_PREFETCH))
> +		idx = 1;
> +	else if ((type & IORESOURCE_MEM_64) &&
> +		 (b_res[2].flags & IORESOURCE_MEM_64))
> +		idx = 2;
> +	else if (!(b_res[2].flags & IORESOURCE_MEM_64) &&
> +		 (b_res[2].flags & IORESOURCE_PREFETCH))
> +		idx = 2;
> +	else
> +		idx = 1;
> +
> +	r = &b_res[idx];
> +
> +	if (!r->parent)
> +		return;
> +
> +	/*
> +	 * if there are children under that, we should release them
> +	 *  all
> +	 */
> +	release_child_resources(r);
> +	if (!release_resource(r)) {
> +		type = old_flags = r->flags & type_mask;
> +		dev_printk(KERN_DEBUG, &dev->dev, "resource %d %pR released\n",
> +					PCI_BRIDGE_RESOURCES + idx, r);
> +		/* keep the old size */
> +		r->end = resource_size(r) - 1;
> +		r->start = 0;
> +		r->flags = 0;
>  
> -	if (changed) {
>  		/* avoiding touch the one without PREF */
>  		if (type & IORESOURCE_PREFETCH)
>  			type = IORESOURCE_PREFETCH;
>  		__pci_setup_bridge(bus, type);
> +		/* for next child res under same bridge */
> +		r->flags = old_flags;
>  	}
>  }
>  
> @@ -1469,7 +1512,7 @@ void pci_assign_unassigned_root_bus_reso
>  	LIST_HEAD(fail_head);
>  	struct pci_dev_resource *fail_res;
>  	unsigned long type_mask = IORESOURCE_IO | IORESOURCE_MEM |
> -				  IORESOURCE_PREFETCH;
> +				  IORESOURCE_PREFETCH | IORESOURCE_MEM_64;
>  	int pci_try_num = 1;
>  	enum enable_type enable_local;
>  
> Index: linux-2.6/drivers/pci/setup-res.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/setup-res.c
> +++ linux-2.6/drivers/pci/setup-res.c
> @@ -208,9 +208,21 @@ static int __pci_assign_resource(struct
>  
>  	/* First, try exact prefetching match.. */
>  	ret = pci_bus_alloc_resource(bus, res, size, align, min,
> -				     IORESOURCE_PREFETCH,
> +				     IORESOURCE_PREFETCH | IORESOURCE_MEM_64,
>  				     pcibios_align_resource, dev);
>  
> +	if (ret < 0 &&
> +	    (res->flags & (IORESOURCE_PREFETCH | IORESOURCE_MEM_64))) {
> +		/*
> +		 * That failed.
> +		 *
> +		 * Try below 4g pref
> +		 */
> +		ret = pci_bus_alloc_resource(bus, res, size, align, min,
> +					     IORESOURCE_PREFETCH,
> +					     pcibios_align_resource, dev);
> +	}
> +
>  	if (ret < 0 && (res->flags & IORESOURCE_PREFETCH)) {
>  		/*
>  		 * That failed.

