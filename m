Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52170 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751681AbcA0Ays (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 26 Jan 2016 19:54:48 -0500
Message-ID: <1453856087.3107.1.camel@redhat.com>
Subject: Re: [PATCH v2 1/2] pci: Add support for multiple DMA aliases
From: Alex Williamson <alex.williamson@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jacek Lawrynowicz <jacek.lawrynowicz@intel.com>,
	linux-pci@vger.kernel.org, bhelgaas@google.com,
	dwmw2@infradead.org, jroedel@suse.de
Date: Tue, 26 Jan 2016 17:54:47 -0700
In-Reply-To: <20160127000403.GA3102@localhost>
References: <1453825639.26652.45.camel@redhat.com>
	 <1453828335-111522-1-git-send-email-jacek.lawrynowicz@intel.com>
	 <20160126233100.GC26726@localhost> <1453851743.21982.1.camel@redhat.com>
	 <20160127000403.GA3102@localhost>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2016-01-26 at 18:04 -0600, Bjorn Helgaas wrote:
> On Tue, Jan 26, 2016 at 04:42:23PM -0700, Alex Williamson wrote:
> > On Tue, 2016-01-26 at 17:31 -0600, Bjorn Helgaas wrote:
> > > Hi Jacek,
> > >  
> > > When you post updated versions, please post the whole series with a
> > > new version number.  I think there are three postings of [v2 1/2], and
> > > I think they're different.  In any case, it's hard for me to keep them
> > > straight.
> > >  
> > > On Tue, Jan 26, 2016 at 06:12:15PM +0100, Jacek Lawrynowicz wrote:
> > > > This patch solves IOMMU support issues with PCIe non-transparent bridges
> > > > that use Requester ID look-up tables (LUT), e.g. PEX8733. Before exiting
> > > > the bridge, packet's RID is rewritten according to LUT programmed by
> > > > a driver. Modified packets are then passed to a destination bus and
> > > > processed upstream. The problem is that such packets seem to come from
> > > > non-existent nodes that are hidden behind NTB and are not discoverable
> > > > by a destination node, so IOMMU discards them. Adding DMA alias for a
> > > > given LUT entry allows IOMMU to create a proper mapping that enables
> > > > inter-node communication.
> > > >  
> > > > The current DMA alias implementation supports only single alias, so it's
> > > > not possible to connect more than two nodes when IOMMU is enabled. This
> > > > implementation enables all possible aliases on a given bus (256) that
> > > > are stored in a bitset. Alias devfn is directly translated to a bit
> > > > number. The bitset is not allocated for devices that have no need for
> > > > DMA aliases.
> > > >  
> > > > More details can be found in following article:
> > > > http://www.plxtech.com/files/pdf/technical/expresslane/RTC_Enabling%20MulitHostSystemDesigns
> > > > .pdf
> > > >  
> > > > Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@intel.com>
> > > > Acked-By: David Woodhouse <David.Woodhouse@intel.com>
> > > > ---
> > > >  drivers/iommu/iommu.c | 11 ++++-------
> > > >  drivers/pci/pci.c     | 27 +++++++++++++++++++++++++++
> > > >  drivers/pci/pci.h     |  2 ++
> > > >  drivers/pci/probe.c   |  1 +
> > > >  drivers/pci/quirks.c  | 15 ++++++---------
> > > >  drivers/pci/search.c  | 14 +++++++++-----
> > > >  include/linux/pci.h   | 14 +++++++-------
> > > >  7 files changed, 56 insertions(+), 28 deletions(-)
> > > >  
> > > > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > > > index 0e3b009..93a89ed 100644
> > > > --- a/drivers/iommu/iommu.c
> > > > +++ b/drivers/iommu/iommu.c
> > > > @@ -660,8 +660,8 @@ static struct iommu_group *get_pci_function_alias_group(struct pci_dev
> > > > *pdev,
> > > >  }
> > > >  
> > > >  /*
> > > > - * Look for aliases to or from the given device for exisiting groups.  The
> > > > - * dma_alias_devfn only supports aliases on the same bus, therefore the search
> > > > + * Look for aliases to or from the given device for exisiting groups. DMA
> > >  
> > > s/exisiting/existing/  (Not your change, but might as well fix the
> > > typo since you're touching the line anyway.)
> > >  
> > > > + * aliases are only supported on the same bus, therefore the search
> > > >   * space is quite small (especially since we're really only looking at pcie
> > > >   * device, and therefore only expect multiple slots on the root complex or
> > > >   * downstream switch ports).  It's conceivable though that a pair of
> > > > @@ -686,11 +686,8 @@ static struct iommu_group *get_pci_alias_group(struct pci_dev *pdev,
> > > >  			continue;
> > > >  
> > > >  		/* We alias them or they alias us */
> > > > -		if (((pdev->dev_flags & PCI_DEV_FLAGS_DMA_ALIAS_DEVFN) &&
> > > > -		     pdev->dma_alias_devfn == tmp->devfn) ||
> > > > -		    ((tmp->dev_flags & PCI_DEV_FLAGS_DMA_ALIAS_DEVFN) &&
> > > > -		     tmp->dma_alias_devfn == pdev->devfn)) {
> > > > -
> > > > +		if (pci_dma_alias_is_enabled(pdev, tmp->devfn) ||
> > > > +		    pci_dma_alias_is_enabled(tmp, pdev->devfn)) {
> > >  
> > > I was hoping for something that took two pci_dev pointers and returned
> > > true if they were aliases of each other, e.g.,
> > >  
> > >   bool pci_dma_aliases(struct pci_dev *dev1, struct pci_dev *dev2);
> > 
> > Such a thing could already be created with pci_for_each_dma_alias().
> 
> Does that mean we could get replace the use of for_each_pci_dev() with some
> clever use of pci_for_each_dma_alias()?

Not remotely, but if we're going to have an is-alias function, should it
be limited to aliases on the same bus?  What if I call it on a
conventional PCI device where everything on the bus is an alias, this
implementation of relying only on the bitmap doesn't even work.  Thanks,

Alex


