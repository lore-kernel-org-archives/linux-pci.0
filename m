Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:17375 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751397Ab3GXSM6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 24 Jul 2013 14:12:58 -0400
Message-ID: <1374689548.5208.62.camel@ul30vt.home>
Subject: Re: [RFC PATCH v2 1/2] pci: Create PCIe requester ID interface
From: Alex Williamson <alex.williamson@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	"open list:INTEL IOMMU (VT-d)" <iommu@lists.linux-foundation.org>,
	Andrew Cooks <acooks@gmail.com>,
	Don Dutile <ddutile@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>
Date: Wed, 24 Jul 2013 12:12:28 -0600
In-Reply-To: <CAErSpo6bcGCjqdxn-bz_vjo+HsAiOxDu=--mD7veEZ9f7k+gyA@mail.gmail.com>
References: <20130711204439.1701.90503.stgit@bling.home>
	 <20130711210326.1701.56478.stgit@bling.home>
	 <20130723223533.GB19765@google.com> <1374621703.15429.98.camel@ul30vt.home>
	 <CAErSpo6bcGCjqdxn-bz_vjo+HsAiOxDu=--mD7veEZ9f7k+gyA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2013-07-24 at 10:47 -0600, Bjorn Helgaas wrote:
> On Tue, Jul 23, 2013 at 5:21 PM, Alex Williamson
> <alex.williamson@redhat.com> wrote:
> > On Tue, 2013-07-23 at 16:35 -0600, Bjorn Helgaas wrote:
> >> On Thu, Jul 11, 2013 at 03:03:27PM -0600, Alex Williamson wrote:
> >> > This provides interfaces for drivers to discover the visible PCIe
> >> > requester ID for a device, for things like IOMMU setup, and iterate
> >>
> >> IDs (plural)
> >
> > How does a device can't have multiple requester IDs?  Reading below, I'm
> > not sure we're on the same page for the purpose of this patch.
> 
> >> "requestee" doesn't make sense to me.  The "-ee" suffix added to a verb
> >> normally makes a noun that refers to the object of the action.  So
> >> "requestee" sounds like it means something like "target" or "responder,"
> >> but that's not what you mean here.
> >
> > Hmm, ok.  I figured a request-er makes a request on behalf of a
> > request-ee.  Suggestions?
> 
> I would expect a request-er to make a request *to* a request-ee, just
> like a grant-or makes a grant to a grant-ee.  My suggestion is to use
> "requester" consistently for only the originator of a DMA transaction.
>  Any devices above it are by definition "bridges".

But there may not be a bridge, so are we then creating just a revised
pci_find_upstream_pcie_bridge() function?  I think we want to abstract
away caring whether there's a bridge or a well behaved device or a
broken device that requires quirks.

>   As the DMA
> transaction propagates through the fabric, it may be tagged by bridges
> with different requester IDs.
> 
> The requester IDs are needed outside PCI (by IOMMU drivers), but I'm
> not sure the intermediate pci_devs are.

A u16 requester ID doesn't mean much on it's own though, it's not
necessarily even unique.  A requester ID associated with the context of
a pci_dev is unique and gives us a reference point if we need to perform
another operation on that requester ID.

> >> > + * pci_get_visible_pcie_requester - Get requester and requester ID for
> >> > + *                                  @requestee below @bridge
> >> > + * @requestee: requester device
> >> > + * @bridge: upstream bridge (or NULL for root bus)
> >> > + * @requester_id: location to store requester ID or NULL
> >> > + */
> >> > +struct pci_dev *pci_get_visible_pcie_requester(struct pci_dev *requestee,
> >> > +                                          struct pci_dev *bridge,
> >> > +                                          u16 *requester_id)
> >>
> >> I'm not sure it makes sense to return a struct pci_dev here because
> >> there's no requirement that a requester ID correspond to an actual
> >> pci_dev.
> >
> > That's why this function is named get_.._requester instead of requester
> > ID.  I believe there still has to be a struct pci_dev that does the
> > request, but the requester ID for that device may not actually match.
> > So I return both.  In a PCIe-to-PCI bridge case, the pci_dev is the
> > bridge, but the requester ID is either the bridge bus|devfn or
> > subordinate|0 depending on the topology.  If we want to support "ghost
> > functions", we can return the real pci_dev and a ghost requester ID.
> >
> > I think if we used just a requester ID, it ends up being extremely
> > difficult to pass that into anything else since we then have to search
> > again for where that requester ID is rooted.
> 
> Returning both a pci_dev and a requester ID makes it more complicated.
>  At the hardware level, transactions contain only a requester ID, and
> bridges can either drop it, pass it unchanged, or assign a new one.  I
> think the code will be simpler if we just model that.

I'm not convinced.  Patch 2/2 makes use of both the returned pci_dev and
the returned requester ID and it's a huge simplification overall.

> >> > + * pcie_for_each_requester - Call callback @fn on each devices and DMA source
> >> > + *                           from @requestee to the PCIe requester ID visible
> >> > + *                           to @bridge.
> >>
> >> Transactions from a device may appear with one of several requester IDs,
> >> but there's not necessarily an actual pci_dev for each ID, so I think the
> >> caller reads better if it's "...for_each_requester_id()"
> >
> > Wouldn't you expect to pass a requester ID into a function with that
> > name?  I'm pretty sure I had it named that at one point but thought the
> > parameters made more sense this way.  I'll see if I can think of a
> > better name.
> 
> My thought was to pass a pci_dev (the originator of the DMA, which I
> would call the "requester") and a callback.  The callback would accept
> the requester pci_dev (always the same requester device) and a
> requester ID.
> 
> This would call @fn for each possible requester ID for transactions
> from the device.  IOMMU drivers should only need the requester ID to
> manage mappings; they shouldn't need a pci_dev corresponding to any
> intermediate bridges.

This implementation is almost the same with the only change being that
the pci_dev passed to the callback is the one most closely associated
with the requester ID.  For the IOMMU driver, it doesn't matter since
it's only using the requester ID, but why would the callback care about
the original requester?  If it needed to do something device specific,
it's going to care about the closest device to the requester ID.

> >> > +struct pci_dev *pci_get_visible_pcie_requester(struct pci_dev *requestee,
> >> > +                                          struct pci_dev *bridge,
> >> > +                                          u16 *requester_id);
> >>
> >> The structure of this interface implies that there is only one visible
> >> requester ID, but the whole point of this patch is that a transaction from
> >> @requestee may appear with one of several requester IDs.  So which one will
> >> this return?
> >
> > I thought the point of this patch was to have an integrated interface
> > for finding the requester ID and doing something across all devices with
> > that requester ID
> 
> Oh, here's the difference in our understanding.  "Doing something
> across all devices with that requester ID" sounds like identifying the
> set of devices that have to be handled as a group by the IOMMU.
> That's certainly an issue, but I wasn't considering it at all.
> 
> I was only concerned with the question of a single device that
> requires multiple IOMMU mappings because DMA requests might use any of
> several source IDs.  This is mentioned in sec 3.6.1.1 of the VT-d
> spec, i.e., "requests arriving with the source-id in the original
> PCI-X transaction or the source-id provided by the bridge. ...
> software must program multiple context entries, each corresponding to
> the possible set of source-ids."
> 
> My thought was that the IOMMU driver would use
> pcie_for_each_requester_id() and have the callback set up a mapping
> for one requester ID each time it was called.

Which is exactly what pcie_for_each_requester() does, but I try to solve
the problem of a single device that needs multiple context entries the
same as a bridge that masks multiple devices.

> > and thereby remove pci_find_upstream_pcie_bridge(),
> > provide a way to quirk broken PCIe-to-PCI bridge and quirk dma_ops for
> > devices that use the wrong requester ID.  In what case does a device
> > appear to have multiple requester IDs?  We have cases where devices use
> > the wrong requester ID, but AFAIK they only use a single wrong requester
> > ID.
> 
> I think the example in sec 3.6.1.1 answers this, doesn't it?

It does, in summary we have to be prepared that a transaction from a
device behind a PCIe-to-PCI/X bridge may use either the device requester
ID (bus|devfn) or the bridge (subordinate|0) requester ID.  This is why
pcie_for_each_requester() makes sense to me, we iterate across all
requesters that may use the same requester ID.  If we had a
pcie_for_each_requester_id() how would we handle that?  Do we call it
once for the (bus|devfn) requester ID of the device we're trying to map
and then call it again for the (subordinate|0) requester ID of the
bridge?  That's almost how pci_find_upstream_pcie_bridge() is used and
it ends up putting a lot of the logic into the driver.  How do we write
a pcie_for_each_requester_id() function that can uniquely identify a PCI
hierarchy to traverse in the presences of multiple domains?  I have a
hard time seeing how we get away from returning a {pci_dev, requester
ID} pair if we want to be descriptive.  Maybe we create a:

struct pci_requester_id {
	struct pci_dev *dev;
	u16 id;
}

and return that if this is a matter of semantics.  Thanks,

Alex

