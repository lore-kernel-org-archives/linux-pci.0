Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.133]:50888 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751858AbcKYJxT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Nov 2016 04:53:19 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Liviu Dudau <liviu.dudau@arm.com>, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 2/4] PCI: Allow driver-specific data in host bridge
Date: Fri, 25 Nov 2016 10:53:12 +0100
Message-ID: <11320589.vngR9yAux7@wuerfel>
In-Reply-To: <20161125072629.GA29326@ulmo.ba.sec>
References: <20160815153647.1075-1-thierry.reding@gmail.com> <26481704.zoJheIBO1p@wuerfel> <20161125072629.GA29326@ulmo.ba.sec>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, November 25, 2016 8:26:29 AM CET Thierry Reding wrote:
> On Mon, Aug 22, 2016 at 04:00:42PM +0200, Arnd Bergmann wrote:
> > On Friday, August 19, 2016 5:55:06 PM CEST Lorenzo Pieralisi wrote:
> > > > 
> > > > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > > > index 93583b389058..ecf543014da3 100644
> > > > --- a/drivers/pci/probe.c
> > > > +++ b/drivers/pci/probe.c
> > > > @@ -521,16 +521,19 @@ static void pci_release_host_bridge_dev(struct device *dev)
> > > >       kfree(bridge);
> > > >  }
> > > >  
> > > > -static struct pci_host_bridge *pci_alloc_host_bridge(void)
> > > > +static struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
> > > >  {
> > > >       struct pci_host_bridge *bridge;
> > > >  
> > > > -     bridge = kzalloc(sizeof(*bridge), GFP_KERNEL);
> > > > +     bridge = kzalloc(sizeof(*bridge) + priv, GFP_KERNEL);
> > > >       if (!bridge)
> > > >               return NULL;
> > > >  
> > > >       INIT_LIST_HEAD(&bridge->windows);
> > > >  
> > > > +     if (priv)
> > > > +             bridge->private = &bridge[1];
> > > 
> > > How about making private a zero length array ?
> > 
> > Right, the member can actually be removed here if we want to, this
> > was just meant as a shorthand so we can avoid the cast or function
> > call in device drivers. I think either way makes sense.
> > 
> > Also, someone commented on a related issue in the previous version, and I
> > recommended to align it to ARCH_SLAB_MINALIGN. This might be done more
> > easily with the zero-length array using
> > 
> > struct pci_host_bridge {
> > 	...
> > 
> > 	unsigned long private[0] __attribute__((aligned(ARCH_SLAB_MINALIGN)));
> > };
> > 
> > Without this, we need a bit more computation, like
> > 	
> > 	bridge = kzalloc(ALIGN(sizeof(*bridge), ARCH_SLAB_MINALIGN) + priv, GFP_KERNEL);
> > 	bridge->private = (void *)bridge + ALIGN(sizeof(*bridge);
> > 
> > or
> > 
> > static inline void *pci_bridge_private(struct pci_host_bridge *bridge)
> > {
> > 	return (void *)bridge + ALIGN(sizeof(*bridge);
> > }
> > static inline struct pci_host_bridge *pci_bridge_from_private(void *priv)
> > {
> > 	return priv - ALIGN(sizeof(*bridge);
> > }
> > 
> > The alignment is needed if the private structure contains any data that
> > we may want to transfer using DMA.
> 
> Looks like I never replied to this, though I seem to remember that I
> did...
> 
> My question is: why would we want the private structure to be aligned?
> Surely if somebody has data in the private structure that needs to be
> transferred using DMA then they need to make sure that that field will
> be properly aligned. Aligning the private structure itself won't ensure
> that, right?

You need both of them. Having the field aligned in the structure when
the structure itself is misaligned will break in surprising ways.

It's possible that we don't ever need this for PCI hosts the way we
do need it for ethernet drivers.
 
> Anyway, it seems like there's very little contentious about this other
> than the minor issue of how to get at the private data. I'd like to make
> progress on this because we're now three generations into 64-bit with
> Tegra and still missing PCI support on all of them.


Yes, that would be good.

	Arnd
