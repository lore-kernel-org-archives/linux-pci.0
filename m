Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:37353 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753656AbcHWOHb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Aug 2016 10:07:31 -0400
Date: Tue, 23 Aug 2016 14:59:07 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thierry Reding <thierry.reding@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Liviu Dudau <liviu.dudau@arm.com>, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 2/4] PCI: Allow driver-specific data in host bridge
Message-ID: <20160823135907.GB9953@red-moon>
References: <20160815153647.1075-1-thierry.reding@gmail.com>
 <20160815153647.1075-2-thierry.reding@gmail.com>
 <20160819165506.GA11823@red-moon>
 <26481704.zoJheIBO1p@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <26481704.zoJheIBO1p@wuerfel>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 22, 2016 at 04:00:42PM +0200, Arnd Bergmann wrote:
> On Friday, August 19, 2016 5:55:06 PM CEST Lorenzo Pieralisi wrote:
> > > 
> > > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > > index 93583b389058..ecf543014da3 100644
> > > --- a/drivers/pci/probe.c
> > > +++ b/drivers/pci/probe.c
> > > @@ -521,16 +521,19 @@ static void pci_release_host_bridge_dev(struct device *dev)
> > >       kfree(bridge);
> > >  }
> > >  
> > > -static struct pci_host_bridge *pci_alloc_host_bridge(void)
> > > +static struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
> > >  {
> > >       struct pci_host_bridge *bridge;
> > >  
> > > -     bridge = kzalloc(sizeof(*bridge), GFP_KERNEL);
> > > +     bridge = kzalloc(sizeof(*bridge) + priv, GFP_KERNEL);
> > >       if (!bridge)
> > >               return NULL;
> > >  
> > >       INIT_LIST_HEAD(&bridge->windows);
> > >  
> > > +     if (priv)
> > > +             bridge->private = &bridge[1];
> > 
> > How about making private a zero length array ?
> 
> Right, the member can actually be removed here if we want to, this
> was just meant as a shorthand so we can avoid the cast or function
> call in device drivers. I think either way makes sense.
> 
> Also, someone commented on a related issue in the previous version, and I
> recommended to align it to ARCH_SLAB_MINALIGN. This might be done more
> easily with the zero-length array using
> 
> struct pci_host_bridge {
> 	...
> 
> 	unsigned long private[0] __attribute__((aligned(ARCH_SLAB_MINALIGN)));
> };

Yes, it looks simpler and I personally prefer it but it is more style
than anything else, I thought it was worth mentioning it though.

Thanks,
Lorenzo

> Without this, we need a bit more computation, like
> 	
> 	bridge = kzalloc(ALIGN(sizeof(*bridge), ARCH_SLAB_MINALIGN) + priv, GFP_KERNEL);
> 	bridge->private = (void *)bridge + ALIGN(sizeof(*bridge);
> 
> or
> 
> static inline void *pci_bridge_private(struct pci_host_bridge *bridge)
> {
> 	return (void *)bridge + ALIGN(sizeof(*bridge);
> }
> static inline struct pci_host_bridge *pci_bridge_from_private(void *priv)
> {
> 	return priv - ALIGN(sizeof(*bridge);
> }
> 
> The alignment is needed if the private structure contains any data that
> we may want to transfer using DMA.
> 
> 	Arnd
> 
