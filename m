Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51221 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752912Ab3G2QGy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 29 Jul 2013 12:06:54 -0400
Message-ID: <1375113975.2642.208.camel@ul30vt.home>
Subject: Re: [RFC PATCH v2 1/2] pci: Create PCIe requester ID interface
From: Alex Williamson <alex.williamson@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	"open list:INTEL IOMMU (VT-d)" <iommu@lists.linux-foundation.org>,
	Andrew Cooks <acooks@gmail.com>,
	Don Dutile <ddutile@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>
Date: Mon, 29 Jul 2013 10:06:15 -0600
In-Reply-To: <20130726215435.GB20021@google.com>
References: <20130711204439.1701.90503.stgit@bling.home>
	 <20130711210326.1701.56478.stgit@bling.home>
	 <20130723223533.GB19765@google.com> <1374621703.15429.98.camel@ul30vt.home>
	 <CAErSpo6bcGCjqdxn-bz_vjo+HsAiOxDu=--mD7veEZ9f7k+gyA@mail.gmail.com>
	 <1374689548.5208.62.camel@ul30vt.home> <20130724232427.GA9272@google.com>
	 <1374775016.2642.116.camel@ul30vt.home> <20130726215435.GB20021@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2013-07-26 at 15:54 -0600, Bjorn Helgaas wrote:
> On Thu, Jul 25, 2013 at 11:56:56AM -0600, Alex Williamson wrote:
> > On Wed, 2013-07-24 at 17:24 -0600, Bjorn Helgaas wrote:
> > > On Wed, Jul 24, 2013 at 12:12:28PM -0600, Alex Williamson wrote:
> > > > On Wed, 2013-07-24 at 10:47 -0600, Bjorn Helgaas wrote:
> > > > > On Tue, Jul 23, 2013 at 5:21 PM, Alex Williamson
> > > > > <alex.williamson@redhat.com> wrote:
> > > > > > On Tue, 2013-07-23 at 16:35 -0600, Bjorn Helgaas wrote:
> > > > > >> On Thu, Jul 11, 2013 at 03:03:27PM -0600, Alex Williamson wrote:
> > > > >   As the DMA
> > > > > transaction propagates through the fabric, it may be tagged by bridges
> > > > > with different requester IDs.
> > > > > 
> > > > > The requester IDs are needed outside PCI (by IOMMU drivers), but I'm
> > > > > not sure the intermediate pci_devs are.
> > > > 
> > > > A u16 requester ID doesn't mean much on it's own though, it's not
> > > > necessarily even unique.  A requester ID associated with the context of
> > > > a pci_dev is unique and gives us a reference point if we need to perform
> > > > another operation on that requester ID.
> > > 
> > > A u16 requester ID better mean something to an IOMMU -- it's all the
> > > IOMMU can use to look up the correct mapping.  That's why we have to
> > > give the iterator something to define the scope to iterate over.  The
> > > same requester ID could mean something totally unrelated in a
> > > different scope, e.g., below a different IOMMU.
> > 
> > The point I'm trying to make is that a requester ID depends on it's
> > context (minimally, the PCI segment).  The caller can assume the context
> > based on the calling parameters or we can provide context in the form of
> > an associated pci_dev.  I chose the latter path because I prefer
> > explicit interfaces and it has some usefulness in the intel-iommu
> > implementation.
> > 
> > For instance, get_domain_for_dev() first looks to see if a pci_dev
> > already has a domain.  If it doesn't, we want to look to see if there's
> > an upstream device that would use the same requester ID that already has
> > a domain.  If our get-requester-ID-for-device function returns only the
> > requester ID, we don't know if that requester ID is the device we're
> > searching from or some upstream device.  Therefore we potentially do an
> > unnecessary search for the domain.
> > 
> > The other user is intel_iommu_add_device() where we're trying to build
> > IOMMU groups.  Visibility is the first requirement of an IOMMU group.
> > If the IOMMU cannot distinguish between devices, they must be part of
> > the same IOMMU group.  Here we want to find the pci_dev that hosts the
> > requester ID.  I don't even know how we'd implement this with a function
> > that only returned the requester ID.  Perhaps we'd have to walk upstream
> > from the device calling the get-requester-ID-for-device function at each
> > step and noticing when it changed.  That moves significant logic back
> > into the caller code.
> > ...
> 
> > > I don't see the point of passing a "device closest to the requester
> > > ID."  What would the IOMMU do with that?  As far as the IOMMU is
> > > concerned, the requester ID could be an arbitrary number completely
> > > unrelated to a pci_dev.
> > 
> > Do you have an example of a case where a requester ID doesn't have some
> > association to a pci_dev?
> 
> I think our confusion here is the same as what Don & I have been
> hashing out -- I'm saying a requester ID fabricated by a bridge
> need not correspond to a specific pci_dev, and you probably mean
> that every requester ID is by definition the result of *some* PCI
> device making a DMA request.

Yes

> > ...
> > Furthermore, if we have:
> > 
> >      -- A
> >     /
> > X--Y
> >     \
> >      -- B
> > ... 
> 
> > Let me go back to the X-Y-A|B example above to see if I can explain why
> > pcie_for_each_requester_id() doesn't make sense to me.  Generally a
> > for_each_foo function should iterate across all things with the same
> > foo.  So a for_each_requester_id should iterate across all things with
> > the same requester ID.  
> 
> Hm, that's not the way I think of for_each_FOO() interfaces.  I
> think of it as "execute the body (or callback) for every possible
> FOO", where FOO is different each time.  for_each_pci_dev(),
> pci_bus_for_each_resource(), for_each_zone(), for_each_cpu(), etc.,
> work like that.

Most of these aren't relevant because they iterate over everything.  I
think they only show that if we had a pci_for_each_requester_id() that
it should iterate over every possible PCI requester ID in the system and
the same could be said for pci_for_each_requester().

pci_bus_for_each_resource() is the only one we can build from; for all
resources on a bus.  We want all requester IDs for a pci_dev.  Does that
perhaps mean it should be called pci_dev_for_each_requester_id()?  I'd
be ok with that name, but I think it even more implies that a pci_dev is
associated with a requester ID.

> But the more important question is what arguments we give to the
> callback.  My proposal was to map
> 
>   {pci_dev -> {requester-ID-A, requester-ID-B, ...}}
> 
> Yours is to map
> 
>   {pci_dev -> {{pci_dev-A, requester-ID-A}, {pci_dev-B, requester-ID-B}, ...}}
> 
> i.e., your callback gets both a pci_dev and a requester-ID.  I'm
> trying to figure out how you handle cases where requester-id-A
> doesn't have a corresponding pci_dev-A.  I guess you pass the device
> most closely associated with requester-id-A

Yes

> The "most closely associated device" idea seems confusing to
> describe and think about.  I think you want to use it as part of
> grouping devices into domains.  But I think we should attack that
> problem separately.  For grouping or isolation questions, we have
> to pay attention to things like ACS, which are not relevant for
> mapping.

We are only touch isolation insofar as providing an interface for a
driver to determine the point in the PCI topology where the requester ID
is rooted.  Yes, grouping can make use of that, but I object to the idea
that we're approaching some slippery slope of rolling multiple concepts
into this patch.  What I'm proposing here is strictly a requester ID
interface.  I believe that providing a way for a caller to determine
that two devices have a requester ID rooted at the same point in the PCI
topology is directly relevant to that interface.

pci_find_upstream_pcie_bridge() attempts to do this same thing.
Unfortunately, the interface is convoluted, it doesn't handle quirks,
and it requires a great deal of work by the caller to then walk the
topology and create requester IDs at each step.  This also indicates
that at each step, the requester ID is associated with some pci_dev.
Providing a pci_dev is simply showing our work and providing context to
the requester ID (ie. here's the requester ID and the step along the
path from which it was derived.  Here's your top level requester ID and
the point in the topology where it's based).

> > If we look at an endpoint device like A, only A
> > has A's requester ID.  Therefore, why would for_each_requester_id(A)
> > traverse up to Y?
> 
> Even if A is a PCIe device, we have to traverse upwards to find any
> bridges that might drop A's requester ID or take ownership, e.g., if
> we have this:
> 
>   00:1c.0 PCIe-to-PCI bridge to [bus 01-02]
>   01:00.0 PCI-to-PCIe bridge to [bus 02]
>   02:00.0 PCIe endpoint A
> 
> the IOMMU has to look for requester-ID 0100.

And I believe this patch handles this case correctly; I mentioned this
exact example in the v2 RFC cover letter.  This is another example where
pci_find_upstream_pcie_bridge() will currently fail.

> > Y can take ownership and become the requester for A,
> > but if we were to call for_each_requester_id(Y), wouldn't you expect the
> > callback to happen on {Y, A, B} since all of those can use that
> > requester ID?
> 
> No.  If I call for_each_requester_id(Y), I'm expecting the callback
> to happen for each requester ID that could be used for transactions
> originated by *Y*.  I'm trying to make an IOMMU mapping for use by
> Y, so any devices downstream of Y, e.g., A and B, are irrelevant.

Ok, you think of for_each_requester_id() the same as I think of
for_each_requester().  Can we split the difference and call it
pci_dev_for_each_requester_id()?

> I think a lot of the confusion here is because we're trying to solve
> both two questions at once: (1) what requester-IDs need to be mapped
> to handle DMA from a device, and (2) what devices can't be isolated
> from each other and must be in the same domain.  I think things will
> be simpler if we can deal with those separately.  Even if it ends up
> being more code, at least each piece will be easier to understand by
> itself.

Don't we already have this split in the code?

(1) pcie_for_each_requester
    (or pci_dev_for_each_requester_id)

(2) pci_get_visible_pcie_requester
    (or pci_get_visible_pcie_requester_id)

Note however that (2) does not impose anything about domains or
isolation, it is strictly based on PCI topology.  It's left to the
caller to determine how that translates to IOMMU domains, but the
typical case is trivial.  Thanks,

Alex

