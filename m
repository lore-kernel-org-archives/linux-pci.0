Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42667 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758473AbcDHQGg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 8 Apr 2016 12:06:36 -0400
Date: Fri, 8 Apr 2016 11:06:32 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Lawrynowicz, Jacek" <jacek.lawrynowicz@intel.com>,
	Joerg Roedel <jroedel@suse.de>, linux-pci@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: Re: [PATCH v4 3/6] PCI: Add support for multiple DMA aliases
Message-ID: <20160408160632.GF8780@localhost>
References: <20160224193926.7585.10833.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20160224194406.7585.17447.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20160225143841.GA8726@localhost>
 <1457995420.78634.63.camel@infradead.org>
 <20160316004817.GG19974@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20160316004817.GG19974@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 15, 2016 at 07:48:17PM -0500, Bjorn Helgaas wrote:
> On Mon, Mar 14, 2016 at 10:43:40PM +0000, David Woodhouse wrote:
> > On Thu, 2016-02-25 at 08:38 -0600, Bjorn Helgaas wrote:
> > > 
> > > >  /*
> > > > - * Look for aliases to or from the given device for exisiting groups.  The
> > > > - * dma_alias_devfn only supports aliases on the same bus, therefore the search
> > > > + * Look for aliases to or from the given device for existing groups. DMA
> > > > + * aliases are only supported on the same bus, therefore the search
> > > 
> > > I'm trying to reconcile this statement that "DMA aliases are only
> > > supported on the same bus" (which was there even before this patch)
> > > with the fact that pci_for_each_dma_alias() does not have that
> > > limitation.
> > 
> > Doesn't it? You can still only set a DMA alias on the same bus with
> > pci_add_dma_alias(), can't you?
> 
> I guess it's true that PCI_DEV_FLAGS_DMA_ALIAS_DEVFN and the proposed
> pci_add_dma_alias() only add aliases on the same bus.  I was thinking
> about a scenario like this:
> 
>   00:00.0 PCIe-to-PCI bridge to [bus 01]
>   01:01.0 conventional PCI device
> 
> where I think 01:00.0 is a DMA alias for 01:01.0 because the bridge
> takes ownership of DMA transactions from 01:01.0 and assigns a
> Requester ID of 01:00.0 (secondary bus number, device 0, function 0).
> 
> > > >   * space is quite small (especially since we're really only looking at pcie
> > > >   * device, and therefore only expect multiple slots on the root complex or
> > > >   * downstream switch ports).  It's conceivable though that a pair of
> > > > @@ -686,11 +692,8 @@ static struct iommu_group *get_pci_alias_group(struct pci_dev *pdev,
> > > >                       continue;
> > > >  
> > > >               /* We alias them or they alias us */
> > > > -             if (((pdev->dev_flags & PCI_DEV_FLAGS_DMA_ALIAS_DEVFN) &&
> > > > -                  pdev->dma_alias_devfn == tmp->devfn) ||
> > > > -                 ((tmp->dev_flags & PCI_DEV_FLAGS_DMA_ALIAS_DEVFN) &&
> > > > -                  tmp->dma_alias_devfn == pdev->devfn)) {
> > > > -
> > > > +             if (dma_alias_is_enabled(pdev, tmp->devfn) ||
> > > > +                 dma_alias_is_enabled(tmp, pdev->devfn)) {
> > > >                       group = get_pci_alias_group(tmp, devfns);
> > > 
> > > We basically have this:
> > > 
> > >   for_each_pci_dev(tmp) {
> > >     if ()
> > >       group = get_pci_alias_group();
> > >       ...
> > >   }
> > 
> > Strictly, that's:
> > 
> >  for_each_pci_dev(tmp) {
> >    if (pdev is an alias of tmp || tmp is an alias of pdev)
> >      group = get_pci_alias_group();
> >    ...
> >  }
> 
> OK.  
> 
> > > I'm trying to figure out why we don't do something like the following
> > > instead:
> > > 
> > >   callback(struct pci_dev *pdev, u16 alias, void *opaque)
> > >   {
> > >     struct iommu_group *group;
> > > 
> > >     group = get_pci_alias_group();
> > >     if (group)
> > >       return group;
> > > 
> > >     return 0;
> > >   }
> > > 
> > >   pci_for_each_dma_alias(pdev, callback, ...);
> > 
> > And this would be equivalent to
> > 
> >  for_each_pci_dev(tmp) {
> >    if (tmp is an alias of pdev)
> >      group = get_pci_alias_group();
> >    ...
> >  }
> > 
> > The "is an alias of" property is not commutative. Perhaps it should be.
> > But that's hard because in some cases the alias doesn't even *exist* as
> > a real PCI device. It's just that you appear to get DMA transactions
> > from a given source-id.
> 
> Right.  In my example above, 01:00.0 is not a PCI device; it's only a
> Requester ID that is fabricated by the bridge when it forwards DMA
> transactions upstream.
> 
> I think I'm confused because I don't really understand IOMMU groups.
> 
> Let me explain what I think they are and you can correct me when I go
> wrong.  The iommu_group_alloc() comment says "The IOMMU group
> represents the minimum granularity of the IOMMU."  So I suppose the
> IOMMU cannot distinguish between devices in a group.  All the devices
> in the group use the same set of DMA mappings.  Granting device A DMA
> access to a buffer grants the same access to all other members of A's
> IOMMU group.
> 
> That would mean my question was fundamentally backwards.  In
> get_pci_alias_group(A), we're not trying to figure out what all the
> aliases of A are, which is what pci_for_each_dma_alias() does.
> 
> Instead, we're trying to figure out which IOMMU group A belongs to.
> But I still don't quite understand how aliases fit into this.  Let's
> go back to my example and assume we've already put 00:00.0 and 01:01.0
> in IOMMU groups:
> 
>   00:00.0 PCIe-to-PCI bridge to [bus 01]     # in IOMMU group G0
>   01:01.0 conventional PCI device            # in IOMMU group G1
> 
> I assume these devices are in different IOMMU groups because if the
> bridge generated its own DMA, it would use Requester ID 00:00.0, which
> is distinct from the 01:00.0 it would use when forwarding DMAs from
> its secondary side.
> 
> What happens when we add 01:02.0?  I think 01:01.0 and 01:02.0 should
> both end up in IOMMU group G1 because the IOMMU will see only
> Requester ID 01:00.0, so it can't distinguish them.
> 
> When we add 01:02.0, the ops->add_device() ... ops->device_group()
> path calls pci_device_group(01:02.0):
> 
>   pci_device_group(01:02.0)
>     pci_for_each_dma_alias(01:02.0, get_pci_alias_or_group)
>       get_pci_alias_or_group(01:02.0, 01:02.0)   # callback
>         return 0           # 01:02.0 group not set yet
>       get_pci_alias_or_group(00:00.0, 01:00.0)   # callback
>         return 1           # 00:00.0 is in G0
> 
> It seems like we'll assign 01:02.0 to group G0, when I think it should
> be in G1.  Where did I go wrong?

Ping?
