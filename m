Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44505 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965099AbcA0UZZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 27 Jan 2016 15:25:25 -0500
Message-ID: <1453926324.18221.2.camel@redhat.com>
Subject: Re: [PATCH v2 1/2] pci: Add support for multiple DMA aliases
From: Alex Williamson <alex.williamson@redhat.com>
To: "Lawrynowicz, Jacek" <jacek.lawrynowicz@intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	bhelgaas@google.com, dwmw2@infradead.org, jroedel@suse.de
Date: Wed, 27 Jan 2016 13:25:24 -0700
In-Reply-To: <20160127200546.GA16324@jlawryno-MOBL1>
References: <1453825639.26652.45.camel@redhat.com>
	 <1453828335-111522-1-git-send-email-jacek.lawrynowicz@intel.com>
	 <20160126233100.GC26726@localhost> <1453851743.21982.1.camel@redhat.com>
	 <20160127000403.GA3102@localhost> <1453856087.3107.1.camel@redhat.com>
	 <20160127200546.GA16324@jlawryno-MOBL1>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2016-01-27 at 21:05 +0100, Lawrynowicz, Jacek wrote:
> On Tue, Jan 26, 2016 at 05:54:47PM -0700, Alex Williamson wrote:
> > On Tue, 2016-01-26 at 18:04 -0600, Bjorn Helgaas wrote:
> > > On Tue, Jan 26, 2016 at 04:42:23PM -0700, Alex Williamson wrote:
> > > > On Tue, 2016-01-26 at 17:31 -0600, Bjorn Helgaas wrote:
> > > > > > + * aliases are only supported on the same bus, therefore the search
> > > > > >   * space is quite small (especially since we're really only looking at pcie
> > > > > >   * device, and therefore only expect multiple slots on the root complex or
> > > > > >   * downstream switch ports).  It's conceivable though that a pair of
> > > > > > @@ -686,11 +686,8 @@ static struct iommu_group *get_pci_alias_group(struct pci_dev *pdev,
> > > > > >  			continue;
> > > > > >  
> > > > > >  		/* We alias them or they alias us */
> > > > > > -		if (((pdev->dev_flags & PCI_DEV_FLAGS_DMA_ALIAS_DEVFN) &&
> > > > > > -		     pdev->dma_alias_devfn == tmp->devfn) ||
> > > > > > -		    ((tmp->dev_flags & PCI_DEV_FLAGS_DMA_ALIAS_DEVFN) &&
> > > > > > -		     tmp->dma_alias_devfn == pdev->devfn)) {
> > > > > > -
> > > > > > +		if (pci_dma_alias_is_enabled(pdev, tmp->devfn) ||
> > > > > > +		    pci_dma_alias_is_enabled(tmp, pdev->devfn)) {
> > > > >  
> > > > > I was hoping for something that took two pci_dev pointers and returned
> > > > > true if they were aliases of each other, e.g.,
> > > > >  
> > > > >   bool pci_dma_aliases(struct pci_dev *dev1, struct pci_dev *dev2);
> > > >  
> > > > Such a thing could already be created with pci_for_each_dma_alias().
> > >  
> > > Does that mean we could get replace the use of for_each_pci_dev() with some
> > > clever use of pci_for_each_dma_alias()?
> > 
> > Not remotely, but if we're going to have an is-alias function, should it
> > be limited to aliases on the same bus?  What if I call it on a
> > conventional PCI device where everything on the bus is an alias, this
> > implementation of relying only on the bitmap doesn't even work.  Thanks,
> 
> So should I change it to pci_dma_aliases() or leave it?

My complaint is not about the name, but about the scope of the function.
The function get_pci_alias_group() defines the scope to be aliases on
the same bus, so it gets by with only testing dma_alias_devfn on
devices.  You're trying to offload this to a helper function, which is
usually a good thing, but that helper doesn't bring with it the same
limited scope.  Anybody can call that helper, where maybe it's not
appropriate that the scope is so limited.  So if you really just want to
fix get_pci_alias_group() with the equivalent functionality for having
multiple devfn aliases, the helper should be static so that it's not
misinterpreted as a generic helper.  Thanks,

Alex

