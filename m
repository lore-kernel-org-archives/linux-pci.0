Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:5746 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967169AbcA0UFv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 27 Jan 2016 15:05:51 -0500
Date: Wed, 27 Jan 2016 21:05:46 +0100
From: "Lawrynowicz, Jacek" <jacek.lawrynowicz@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	bhelgaas@google.com, dwmw2@infradead.org, jroedel@suse.de
Subject: Re: [PATCH v2 1/2] pci: Add support for multiple DMA aliases
Message-ID: <20160127200546.GA16324@jlawryno-MOBL1>
References: <1453825639.26652.45.camel@redhat.com>
 <1453828335-111522-1-git-send-email-jacek.lawrynowicz@intel.com>
 <20160126233100.GC26726@localhost>
 <1453851743.21982.1.camel@redhat.com>
 <20160127000403.GA3102@localhost>
 <1453856087.3107.1.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1453856087.3107.1.camel@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 26, 2016 at 05:54:47PM -0700, Alex Williamson wrote:
> On Tue, 2016-01-26 at 18:04 -0600, Bjorn Helgaas wrote:
> > On Tue, Jan 26, 2016 at 04:42:23PM -0700, Alex Williamson wrote:
> > > On Tue, 2016-01-26 at 17:31 -0600, Bjorn Helgaas wrote:
> > > > > + * aliases are only supported on the same bus, therefore the search
> > > > >   * space is quite small (especially since we're really only looking at pcie
> > > > >   * device, and therefore only expect multiple slots on the root complex or
> > > > >   * downstream switch ports).  It's conceivable though that a pair of
> > > > > @@ -686,11 +686,8 @@ static struct iommu_group *get_pci_alias_group(struct pci_dev *pdev,
> > > > >  			continue;
> > > > >  
> > > > >  		/* We alias them or they alias us */
> > > > > -		if (((pdev->dev_flags & PCI_DEV_FLAGS_DMA_ALIAS_DEVFN) &&
> > > > > -		     pdev->dma_alias_devfn == tmp->devfn) ||
> > > > > -		    ((tmp->dev_flags & PCI_DEV_FLAGS_DMA_ALIAS_DEVFN) &&
> > > > > -		     tmp->dma_alias_devfn == pdev->devfn)) {
> > > > > -
> > > > > +		if (pci_dma_alias_is_enabled(pdev, tmp->devfn) ||
> > > > > +		    pci_dma_alias_is_enabled(tmp, pdev->devfn)) {
> > > >  
> > > > I was hoping for something that took two pci_dev pointers and returned
> > > > true if they were aliases of each other, e.g.,
> > > >  
> > > >   bool pci_dma_aliases(struct pci_dev *dev1, struct pci_dev *dev2);
> > > 
> > > Such a thing could already be created with pci_for_each_dma_alias().
> > 
> > Does that mean we could get replace the use of for_each_pci_dev() with some
> > clever use of pci_for_each_dma_alias()?
> 
> Not remotely, but if we're going to have an is-alias function, should it
> be limited to aliases on the same bus?  What if I call it on a
> conventional PCI device where everything on the bus is an alias, this
> implementation of relying only on the bitmap doesn't even work.  Thanks,

So should I change it to pci_dma_aliases() or leave it?

Jacek
