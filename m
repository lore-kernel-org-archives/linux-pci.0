Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:31718 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757040Ab3GYR5d (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 25 Jul 2013 13:57:33 -0400
Message-ID: <1374775016.2642.116.camel@ul30vt.home>
Subject: Re: [RFC PATCH v2 1/2] pci: Create PCIe requester ID interface
From: Alex Williamson <alex.williamson@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	"open list:INTEL IOMMU (VT-d)" <iommu@lists.linux-foundation.org>,
	Andrew Cooks <acooks@gmail.com>,
	Don Dutile <ddutile@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>
Date: Thu, 25 Jul 2013 11:56:56 -0600
In-Reply-To: <20130724232427.GA9272@google.com>
References: <20130711204439.1701.90503.stgit@bling.home>
	 <20130711210326.1701.56478.stgit@bling.home>
	 <20130723223533.GB19765@google.com> <1374621703.15429.98.camel@ul30vt.home>
	 <CAErSpo6bcGCjqdxn-bz_vjo+HsAiOxDu=--mD7veEZ9f7k+gyA@mail.gmail.com>
	 <1374689548.5208.62.camel@ul30vt.home> <20130724232427.GA9272@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2013-07-24 at 17:24 -0600, Bjorn Helgaas wrote:
> On Wed, Jul 24, 2013 at 12:12:28PM -0600, Alex Williamson wrote:
> > On Wed, 2013-07-24 at 10:47 -0600, Bjorn Helgaas wrote:
> > > On Tue, Jul 23, 2013 at 5:21 PM, Alex Williamson
> > > <alex.williamson@redhat.com> wrote:
> > > > On Tue, 2013-07-23 at 16:35 -0600, Bjorn Helgaas wrote:
> > > >> On Thu, Jul 11, 2013 at 03:03:27PM -0600, Alex Williamson wrote:
> > >   As the DMA
> > > transaction propagates through the fabric, it may be tagged by bridges
> > > with different requester IDs.
> > > 
> > > The requester IDs are needed outside PCI (by IOMMU drivers), but I'm
> > > not sure the intermediate pci_devs are.
> > 
> > A u16 requester ID doesn't mean much on it's own though, it's not
> > necessarily even unique.  A requester ID associated with the context of
> > a pci_dev is unique and gives us a reference point if we need to perform
> > another operation on that requester ID.
> 
> A u16 requester ID better mean something to an IOMMU -- it's all the
> IOMMU can use to look up the correct mapping.  That's why we have to
> give the iterator something to define the scope to iterate over.  The
> same requester ID could mean something totally unrelated in a
> different scope, e.g., below a different IOMMU.

The point I'm trying to make is that a requester ID depends on it's
context (minimally, the PCI segment).  The caller can assume the context
based on the calling parameters or we can provide context in the form of
an associated pci_dev.  I chose the latter path because I prefer
explicit interfaces and it has some usefulness in the intel-iommu
implementation.

For instance, get_domain_for_dev() first looks to see if a pci_dev
already has a domain.  If it doesn't, we want to look to see if there's
an upstream device that would use the same requester ID that already has
a domain.  If our get-requester-ID-for-device function returns only the
requester ID, we don't know if that requester ID is the device we're
searching from or some upstream device.  Therefore we potentially do an
unnecessary search for the domain.

The other user is intel_iommu_add_device() where we're trying to build
IOMMU groups.  Visibility is the first requirement of an IOMMU group.
If the IOMMU cannot distinguish between devices, they must be part of
the same IOMMU group.  Here we want to find the pci_dev that hosts the
requester ID.  I don't even know how we'd implement this with a function
that only returned the requester ID.  Perhaps we'd have to walk upstream
from the device calling the get-requester-ID-for-device function at each
step and noticing when it changed.  That moves significant logic back
into the caller code.

> > > Returning both a pci_dev and a requester ID makes it more complicated.
> > >  At the hardware level, transactions contain only a requester ID, and
> > > bridges can either drop it, pass it unchanged, or assign a new one.  I
> > > think the code will be simpler if we just model that.
> > 
> > I'm not convinced.  Patch 2/2 makes use of both the returned pci_dev and
> > the returned requester ID and it's a huge simplification overall.
> 
> The IOMMU driver makes mappings so DMA from device A can reach a
> buffer.  It needs to know about device A, and it needs to know what
> source IDs might appear on those DMA transactions.  Why would it need
> to know anything about any bridges between A and the IOMMU?

Maybe it doesn't, but it might want to know about the top level bridge
for the examples above and I prefer that we be consistent in providing
both a requester ID and context device.  It's not currently used in the
callback function, but I could imagine it could be.  For instance, what
if there are multiple endpoints downstream of a bridge and the IOMMU
wants to use the bridge pci_dev to track how many routes it's managing
through this bridge.

I think the latter is actually a current bug in intel-iommu as noted by
the XXX in patch 2/2.  iommu_detach_dependent_devices() will tear down
all context entries along a path, but there's no reference counting as
to how many devices are using that path.  Should that reference counting
be associated with the pci_dev?  I suppose the IOMMU could already have
data structures per requester ID or could create them and use an idr for
lookup, but does this interface want to require that?

> > > My thought was to pass a pci_dev (the originator of the DMA, which I
> > > would call the "requester") and a callback.  The callback would accept
> > > the requester pci_dev (always the same requester device) and a
> > > requester ID.
> > > 
> > > This would call @fn for each possible requester ID for transactions
> > > from the device.  IOMMU drivers should only need the requester ID to
> > > manage mappings; they shouldn't need a pci_dev corresponding to any
> > > intermediate bridges.
> > 
> > This implementation is almost the same with the only change being that
> > the pci_dev passed to the callback is the one most closely associated
> > with the requester ID.  For the IOMMU driver, it doesn't matter since
> > it's only using the requester ID, but why would the callback care about
> > the original requester?  If it needed to do something device specific,
> > it's going to care about the closest device to the requester ID.
> 
> If this can be done without passing a pci_dev at all to the callback,
> that would be even better.  If a caller needed the original pci_dev,
> it could always pass it via the "void *data".

Agreed, the original "device A" is the caller's problem if it wants to
know about it, but I think providing full context of a requester ID
(which means a pci_dev) makes sense too.

> I don't see the point of passing a "device closest to the requester
> ID."  What would the IOMMU do with that?  As far as the IOMMU is
> concerned, the requester ID could be an arbitrary number completely
> unrelated to a pci_dev.

Do you have an example of a case where a requester ID doesn't have some
association to a pci_dev?

> > > >> > +struct pci_dev *pci_get_visible_pcie_requester(struct pci_dev *requestee,
> > > >> > +                                          struct pci_dev *bridge,
> > > >> > +                                          u16 *requester_id);
> > > >>
> > > >> The structure of this interface implies that there is only one visible
> > > >> requester ID, but the whole point of this patch is that a transaction from
> > > >> @requestee may appear with one of several requester IDs.  So which one will
> > > >> this return?
> > > >
> > > > I thought the point of this patch was to have an integrated interface
> > > > for finding the requester ID and doing something across all devices with
> > > > that requester ID
> > > 
> > > Oh, here's the difference in our understanding.  "Doing something
> > > across all devices with that requester ID" sounds like identifying the
> > > set of devices that have to be handled as a group by the IOMMU.
> > > That's certainly an issue, but I wasn't considering it at all.
> > > 
> > > I was only concerned with the question of a single device that
> > > requires multiple IOMMU mappings because DMA requests might use any of
> > > several source IDs.  This is mentioned in sec 3.6.1.1 of the VT-d
> > > spec, i.e., "requests arriving with the source-id in the original
> > > PCI-X transaction or the source-id provided by the bridge. ...
> > > software must program multiple context entries, each corresponding to
> > > the possible set of source-ids."
> > > 
> > > My thought was that the IOMMU driver would use
> > > pcie_for_each_requester_id() and have the callback set up a mapping
> > > for one requester ID each time it was called.
> > 
> > Which is exactly what pcie_for_each_requester() does, but I try to solve
> > the problem of a single device that needs multiple context entries the
> > same as a bridge that masks multiple devices.
> 
> I'm not sure I understand your point yet, but I think it's better to
> think of this as computing the set of requester IDs we might see from
> a given device.  If we think of it as finding the set of devices that
> use a given requester ID, then we have to worry about that set being
> modified by hotplug.

Perhaps I'm explain it wrong, I've had to refresh myself on how this all
works since I posted it.  Looking at pcie_for_each_requester() we first
find the requester ID and associated device for the requested device
(yet another users of the associated device part of the interface).  We
then walk up from the requested device to the associated device, calling
the callback on each bridge or dma quirk in between.  So, I was wrong to
indicate that pcie_for_each_requester() does anything across all devices
with the same requester ID.  It traverses all devices and quirks of
devices along the path from the requested device to the device
associated with the requester ID.

> > > > and thereby remove pci_find_upstream_pcie_bridge(),
> > > > provide a way to quirk broken PCIe-to-PCI bridge and quirk dma_ops for
> > > > devices that use the wrong requester ID.  In what case does a device
> > > > appear to have multiple requester IDs?  We have cases where devices use
> > > > the wrong requester ID, but AFAIK they only use a single wrong requester
> > > > ID.
> > > 
> > > I think the example in sec 3.6.1.1 answers this, doesn't it?
> > 
> > It does, in summary we have to be prepared that a transaction from a
> > device behind a PCIe-to-PCI/X bridge may use either the device requester
> > ID (bus|devfn) or the bridge (subordinate|0) requester ID.  This is why
> > pcie_for_each_requester() makes sense to me, we iterate across all
> > requesters that may use the same requester ID.
> 
> Let's say device A and B use the same requester ID because they're
> behind a bridge.  What happens if we map a buffer for A and then
> hot-remove B?  Here's what I think your proposal would do:
> 
>   map buffer for A
>     callback for A
>     callback for B
>   hot-remove B
>   unmap buffer for A
>     callback for A
> 
> We never do an unmap callback for B, so if we did anything while
> mapping, it will never be undone.

So I think I've again lost my context since I posted this, apologies.
pcie_for_each_requester() is implemented to handle the path, not the
subtree.  I believe what pcie_for_each_requester() as written would do
is:

   map buffer for A
     callback for A
   hot-remove B
   unmap buffer for A
     callback for A

Furthermore, if we have:

     -- A
    /
X--Y
    \
     -- B

Where X is the associated device for the requester ID, we'd do:

  map buffer for A
    callback for A
    callback for Y
    callback for X
  hot-remove B
  unmap buffer for A
    callback for A
    callback for Y
    callback for X

That hot-remove though is where I think intel-iommu has a bug as the set
of dependent devices for B includes Y & X, which would then have their
context entries cleared.  That's yet another intel-iommu bug though, not
anything that requires a change to this interface.

> > If we had a
> > pcie_for_each_requester_id() how would we handle that?  Do we call it
> > once for the (bus|devfn) requester ID of the device we're trying to map
> > and then call it again for the (subordinate|0) requester ID of the
> > bridge?  That's almost how pci_find_upstream_pcie_bridge() is used and
> > it ends up putting a lot of the logic into the driver.  
> 
> That *is* what I'm proposing (calling the callback once for each
> possible requester ID that could be seen on DMA from the device).  In
> my opinion, the problem with pci_find_upstream_pcie_bridge() is that
> you only get one device back from it, and the driver has to roll its
> own looping.

I'm not sure if my argument above is still relevant, but what I was
trying to suggest was that the caller would need to make multiple calls,
which puts us in the same boat as the roll-your-own loop with
find_upstream_pcie_bridge.  Of course the callback needs to be called
for each requester ID.

Let me go back to the X-Y-A|B example above to see if I can explain why
pcie_for_each_requester_id() doesn't make sense to me.  Generally a
for_each_foo function should iterate across all things with the same
foo.  So a for_each_requester_id should iterate across all things with
the same requester ID.  If we look at an endpoint device like A, only A
has A's requester ID.  Therefore, why would for_each_requester_id(A)
traverse up to Y?  Y can take ownership and become the requester for A,
but if we were to call for_each_requester_id(Y), wouldn't you expect the
callback to happen on {Y, A, B} since all of those can use that
requester ID?  That makes it a downstream looking for_each callback
which is not really want we want.

As you indicate above, we want an upstream looking function.  If I call
for_each_requester(A), A is obviously a requester for A.  Y can take
ownership of a transaction from A, therefore we must assume Y is a
requester for A.  Same with X.  I believe this is what we want and this
is what the code does.

> > How do we write
> > a pcie_for_each_requester_id() function that can uniquely identify a PCI
> > hierarchy to traverse in the presences of multiple domains?  
> 
> I must be missing something in your question.  If we give
> pcie_for_each_requester_id() the requester pci_dev, that uniquely
> identifies the PCI hierarchy.  Then it's just a question of how far up
> the hierarchy we need to go, and the bridge (or bus) argument tells us
> that.

I think the code actually does what you want, so we're only in
disagreement about the naming and usefulness (appropriate-ness) of
passing a pci_dev associated with a requester ID.  Is that correct?

There are several examples above about the associated device being
useful to the implementation.  It may not be required, but it's only
going to make the caller implement more code on their side not to
provide it.  The for_each_requester_id vs for_each_requester is a matter
of personal taste, but I think for_each_requester actually makes more
sense given the parameters and the upstream vs downstream nature of the
call.  Sorry again for the confusion, I can barely identify my own code
after a couple weeks.  Thanks,

Alex

