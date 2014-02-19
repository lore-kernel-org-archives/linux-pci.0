Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:54676 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904AbaBSAwp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Feb 2014 19:52:45 -0500
Received: by mail-oa0-f49.google.com with SMTP id i7so20165286oag.36
        for <linux-pci@vger.kernel.org>; Tue, 18 Feb 2014 16:52:45 -0800 (PST)
Date: Tue, 18 Feb 2014 17:52:41 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Guo Chao <yan@linux.vnet.ibm.com>,
	Nikhil P Rao <nikhil.rao@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Support huge alignment in pbus_size_mem()
Message-ID: <20140219005241.GE8786@google.com>
References: <20140217045004.GB3230@yanx>
 <CAE9FiQXmWG2RNP-t=U06JUsqkmDm2My5762za8QuwUMZsG+yNg@mail.gmail.com>
 <CAE9FiQWxcBCy+dp-0D2erB83uyyTNKFo5y0sKwiiFxo1xM0Z=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQWxcBCy+dp-0D2erB83uyyTNKFo5y0sKwiiFxo1xM0Z=g@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 17, 2014 at 01:15:15PM -0800, Yinghai Lu wrote:
> On Mon, Feb 17, 2014 at 11:28 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> > On Sun, Feb 16, 2014 at 8:50 PM, Guo Chao <yan@linux.vnet.ibm.com> wrote:
> >> pbus_size_mem() limits resource alignment within 2G. We want to extend
> >> this limit to support a 16G BAR. I found similar effort was tried before:
> >>
> >>         https://lkml.org/lkml/2012/6/21/411
> >>
> >> What's the result? Does anyone come up with an adaptive algorithm?
> >
> > I suggest following changes:
> >
> > From: Nikhil P Rao <nikhil.rao@intel.com>
> > Subject: [PATCH] PCI: Fix bus align checking to support more than 2G
> >
> > current 2G is out of date.
> >
> > -v3: We only need to extend that when 64bit mmio is supported.
> >      So extract mmio64 mask checking, and still keep old 2G checking
> >      for other path.  --- Yinghai
> >
> > Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> >
> > ---
> >  drivers/pci/setup-bus.c |   42 ++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 38 insertions(+), 4 deletions(-)
> >
> > Index: linux-2.6/drivers/pci/setup-bus.c
> > ===================================================================
> > --- linux-2.6.orig/drivers/pci/setup-bus.c
> > +++ linux-2.6/drivers/pci/setup-bus.c
> > @@ -921,7 +921,7 @@ static int pbus_size_mem(struct pci_bus
> >  {
> >      struct pci_dev *dev;
> >      resource_size_t min_align, align, size, size0, size1;
> > -    resource_size_t aligns[12];    /* Alignments from 1Mb to 2Gb */
> > +    resource_size_t aligns[44];    /* Alignments from 1Mb to 2^63 */
> >      int order, max_order;
> >      struct resource *b_res = find_free_bus_resource(bus, type);
> >      unsigned int mem64_mask = 0;
> > @@ -937,6 +937,40 @@ static int pbus_size_mem(struct pci_bus
> >      mem64_mask = b_res->flags & IORESOURCE_MEM_64;
> >      b_res->flags &= ~IORESOURCE_MEM_64;
> >
> > +    /* kernel does not support 64bit */
> > +    if (sizeof(resource_size_t) == 4)
> > +        mem64_mask &=  ~IORESOURCE_MEM_64;
> > +
> > +    if (!(mem64_mask & IORESOURCE_MEM_64))
> > +        goto mem64_mask_check_done;
> > +
> > +    /* check if mem64 support is supported and needed at first */
> > +    list_for_each_entry(dev, &bus->devices, bus_list) {
> > +        int i;
> > +
> > +        for (i = 0; i < PCI_NUM_RESOURCES; i++) {
> > +            struct resource *r = &dev->resource[i];
> > +            resource_size_t r_size;
> > +
> > +            if (r->parent || (r->flags & mask) != type)
> > +                continue;
> > +            r_size = resource_size(r);
> > +#ifdef CONFIG_PCI_IOV
> > +            /* put SRIOV requested res to the optional list */
> > +            if (realloc_head && i >= PCI_IOV_RESOURCES &&
> > +                    i <= PCI_IOV_RESOURCE_END)
> > +                continue;
> > +#endif
> > +            mem64_mask &= r->flags & IORESOURCE_MEM_64;
> > +
> > +            if (!(mem64_mask & IORESOURCE_MEM_64))
> > +                goto mem64_mask_check_done;
> > +
> > +        }
> > +    }

Why did you add the loop above?  Didn't the original loop compute the same
value of mem64_mask as your new loop?

> > +mem64_mask_check_done:
> > +
> >      list_for_each_entry(dev, &bus->devices, bus_list) {
> >          int i;
> >
> > @@ -959,8 +993,9 @@ static int pbus_size_mem(struct pci_bus
> >  #endif
> >              /* For bridges size != alignment */
> >              align = pci_resource_alignment(dev, r);
> > -            order = __ffs(align) - 20;
> > -            if (order > 11) {
> > +            order = __ffs64(align) - 20;
> > +            if (order > ARRAY_SIZE(aligns) ||
> > +                (!(mem64_mask & IORESOURCE_MEM_64) && order > 11) ) {
> 
> ...
> > For 64bit systems, we want to ensure that the align < 1^63, so shouldn't
> > order be checked against 43, instead of ARRAY_SIZE(aligns) ?
> 
> yes, should change to 43.

Can you post an updated patch with this change, please?
