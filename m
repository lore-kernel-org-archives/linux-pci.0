Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:41570 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752340AbaGBVHj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 2 Jul 2014 17:07:39 -0400
Received: by mail-ie0-f170.google.com with SMTP id tr6so10047472ieb.29
        for <linux-pci@vger.kernel.org>; Wed, 02 Jul 2014 14:07:39 -0700 (PDT)
Date: Wed, 2 Jul 2014 15:07:36 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Guo Chao <yan@linux.vnet.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] pci: Allow very large resource windows
Message-ID: <20140702210736.GB28852@google.com>
References: <20140611060118.GB3169@yanx>
 <CAE9FiQWe2bf7QbKn9kmZS34a4cMewsdD-9qAELdXs-dEtx70GQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQWe2bf7QbKn9kmZS34a4cMewsdD-9qAELdXs-dEtx70GQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 11, 2014 at 10:23:35AM -0700, Yinghai Lu wrote:
> On Tue, Jun 10, 2014 at 11:01 PM, Guo Chao <yan@linux.vnet.ibm.com> wrote:
> > Well, that's not enough for our 16G BAR ...
> >
> > I thought Yinghai fixed it permanently last time:
> >
> >         http://permalink.gmane.org/gmane.linux.kernel.pci/29142
> >
> > Are you still working on this, Yinghai?
> 
> Hi Guo,
> 
> Please check updated version on your setup.
> 
> Thanks
> 
> Yinghai

> Subject: [PATCH -v3] PCI: Fix bus align checking to support more than 8G
> 
> So add mmio64 mask checking, only allow more than 4G when bridge and all child
> support 64bit res.  Still keep old 2G checking for other path.
> 
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> 
> ---
>  drivers/pci/setup-bus.c |   40 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 38 insertions(+), 2 deletions(-)
> 
> Index: linux-2.6/drivers/pci/setup-bus.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/setup-bus.c
> +++ linux-2.6/drivers/pci/setup-bus.c
> @@ -928,15 +928,50 @@ static int pbus_size_mem(struct pci_bus
>  {
>  	struct pci_dev *dev;
>  	resource_size_t min_align, align, size, size0, size1;
> -	resource_size_t aligns[14];	/* Alignments from 1Mb to 8Gb */
> +	resource_size_t aligns[44];	/* Alignments from 1Mb to 2^63 */
>  	int order, max_order;
>  	struct resource *b_res = find_free_bus_resource(bus,
>  					mask | IORESOURCE_PREFETCH, type);
>  	resource_size_t children_add_size = 0;
> +	unsigned int mem64_mask;
>  
>  	if (!b_res)
>  		return -ENOSPC;
>  
> +	mem64_mask = b_res->flags & IORESOURCE_MEM_64;
> +
> +	/* kernel does not support 64bit res */
> +	if (sizeof(resource_size_t) == 4)
> +		mem64_mask &= ~IORESOURCE_MEM_64;
> +
> +	if (!mem64_mask)
> +		goto mem64_mask_check_done;
> +
> +	/* check if mem64 support is supported and needed at first */
> +	list_for_each_entry(dev, &bus->devices, bus_list) {
> +		int i;
> +
> +		for (i = 0; i < PCI_NUM_RESOURCES; i++) {
> +			struct resource *r = &dev->resource[i];
> +
> +			if (r->parent || ((r->flags & mask) != type &&
> +					  (r->flags & mask) != type2 &&
> +					  (r->flags & mask) != type3))
> +				continue;
> +#ifdef CONFIG_PCI_IOV
> +			/* Skip SRIOV checking, as optional res */
> +			if (realloc_head && i >= PCI_IOV_RESOURCES &&
> +					i <= PCI_IOV_RESOURCE_END)
> +				continue;
> +#endif
> +			mem64_mask &= r->flags & IORESOURCE_MEM_64;
> +
> +			if (!mem64_mask)
> +				goto mem64_mask_check_done;
> +		}
> +	}
> +mem64_mask_check_done:

What happens if we increase the size of aligns[], but omit this loop and
the mem64_mask stuff?  Is mem64_mask just an optimization, so the code
would still work without it?  If the existing code works for 8GB bars
(without mem64_mask), when does it break and start requiring mem64_mask?

>  	memset(aligns, 0, sizeof(aligns));
>  	max_order = 0;
>  	size = 0;
> @@ -973,7 +1008,8 @@ static int pbus_size_mem(struct pci_bus
>  			order = __ffs(align) - 20;
>  			if (order < 0)
>  				order = 0;
> -			if (order >= ARRAY_SIZE(aligns)) {
> +			if (order >= ARRAY_SIZE(aligns) ||
> +			    (!mem64_mask && order > 11 /* 2Gb */)) {
>  				dev_warn(&dev->dev, "disabling BAR %d: %pR "
>  					 "(bad alignment %#llx)\n", i, r,
>  					 (unsigned long long) align);

