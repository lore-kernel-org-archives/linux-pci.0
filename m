Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:40920 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757510Ab3HAWI1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 1 Aug 2013 18:08:27 -0400
Received: by mail-ob0-f181.google.com with SMTP id dn14so4933055obc.40
        for <linux-pci@vger.kernel.org>; Thu, 01 Aug 2013 15:08:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1375137140.2642.349.camel@ul30vt.home>
References: <20130711204439.1701.90503.stgit@bling.home> <20130711210326.1701.56478.stgit@bling.home>
 <20130723223533.GB19765@google.com> <1374621703.15429.98.camel@ul30vt.home>
 <CAErSpo6bcGCjqdxn-bz_vjo+HsAiOxDu=--mD7veEZ9f7k+gyA@mail.gmail.com>
 <1374689548.5208.62.camel@ul30vt.home> <20130724232427.GA9272@google.com>
 <1374775016.2642.116.camel@ul30vt.home> <20130726215435.GB20021@google.com>
 <1375113975.2642.208.camel@ul30vt.home> <CAErSpo7pfCtTm5Cq=VixPTKMpM4VQpDr+ZmS5qMw32z6ABu0xQ@mail.gmail.com>
 <1375137140.2642.349.camel@ul30vt.home>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 1 Aug 2013 16:08:06 -0600
Message-ID: <CAErSpo5+-r3qMca1_Kvt3jJ6OP6Q7--4VmTo3fWJ0y4CPewgEQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/2] pci: Create PCIe requester ID interface
To: Alex Williamson <alex.williamson@redhat.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	"open list:INTEL IOMMU (VT-d)" <iommu@lists.linux-foundation.org>,
	Andrew Cooks <acooks@gmail.com>,
	Don Dutile <ddutile@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 29, 2013 at 4:32 PM, Alex Williamson
<alex.williamson@redhat.com> wrote:
> On Mon, 2013-07-29 at 15:02 -0600, Bjorn Helgaas wrote:
>> On Mon, Jul 29, 2013 at 10:06 AM, Alex Williamson
>> <alex.williamson@redhat.com> wrote:
>> > On Fri, 2013-07-26 at 15:54 -0600, Bjorn Helgaas wrote:
>> >> On Thu, Jul 25, 2013 at 11:56:56AM -0600, Alex Williamson wrote:
>>
>> >> The "most closely associated device" idea seems confusing to
>> >> describe and think about.  I think you want to use it as part of
>> >> grouping devices into domains.  But I think we should attack that
>> >> problem separately.  For grouping or isolation questions, we have
>> >> to pay attention to things like ACS, which are not relevant for
>> >> mapping.
>> >
>> > We are only touch isolation insofar as providing an interface for a
>> > driver to determine the point in the PCI topology where the requester ID
>> > is rooted.  Yes, grouping can make use of that, but I object to the idea
>> > that we're approaching some slippery slope of rolling multiple concepts
>> > into this patch.  What I'm proposing here is strictly a requester ID
>> > interface.  I believe that providing a way for a caller to determine
>> > that two devices have a requester ID rooted at the same point in the PCI
>> > topology is directly relevant to that interface.
>> >
>> > pci_find_upstream_pcie_bridge() attempts to do this same thing.
>> > Unfortunately, the interface is convoluted, it doesn't handle quirks,
>> > and it requires a great deal of work by the caller to then walk the
>> > topology and create requester IDs at each step.  This also indicates
>> > that at each step, the requester ID is associated with some pci_dev.
>> > Providing a pci_dev is simply showing our work and providing context to
>> > the requester ID (ie. here's the requester ID and the step along the
>> > path from which it was derived.  Here's your top level requester ID and
>> > the point in the topology where it's based).
>>
>> What does the driver *do* with the pci_dev?  If it's not necessary,
>> then showing our work and providing context just complicates the
>> interface and creates opportunities for mistakes.  If we're creating
>> IOMMU mappings, only the requester ID is needed.
>
> It's true, I don't have a use for the pci_dev in
> pci_dev_for_each_requester_id() today.  But I think providing the
> context for a requester ID is valuable information.  Otherwise we have
> to make assumptions about the requester ID.  For example, if I have
> devices in different PCI segments with the same requester ID the
> callback function only knows that those are actually different requester
> IDs from information the caller provides itself in the opaque pointer.
> This is the case with intel-iommu, but why would we design an API that
> requires the caller to provide that kind of context?

The caller already has to provide context, e.g., the domain in which
to create a mapping, anyway via the opaque pointer.  So I would argue
that it's pointless to supply context twice in different ways.

We only have one caller of pci_dev_for_each_requester_id() anyway
(intel-iommu.c).  That seems really strange to me.  All I can assume
is that other IOMMU drivers *should* be doing something like this, but
aren't yet.  Anyway, since we only have one user, why not just provide
the minimum (only the requester ID), and add the pci_dev later if a
requirement for it turns up?

>  I also provide the
> pci_dev because I think both the pci_dev_for_each_requester_id() and
> pci_get_visible_pcie_requester() should provide similar APIs.  There's
> an association of a requester ID to a pci_dev.  Why hide that?

Information hiding is a basic idea of abstraction and encapsulation.
If we don't hide unnecessary information, we end up with unnecessary
dependencies.

>> I think you used get_domain_for_dev() and intel_iommu_add_device() as
>> examples, but as far as I can tell, they use the pci_dev as a way to
>> learn about isolation.  For that purpose, I don't think you want an
>> iterator -- you only want to know about the single pci_dev that's the
>> root of the isolation domain, and requester IDs really aren't
>> relevant.
>
> See get_domain_for_dev() in patch 2/2.  It uses the returned pci_dev to
> know whether the requester ID is rooted upstream or at the device
> itself.  If upstream, it then uses the requester ID to search for an
> existing domain.  The requester ID is relevant here.  If the returned
> pci_dev is the device itself, it proceeds to allocate a domain because
> the code path has already checked whether the device itself belongs to a
> domain.

I guess I got myself confused here.  get_domain_for_dev() uses
pci_get_visible_pcie_requester(), not pci_dev_for_each_requester_id().

>> > (1) pcie_for_each_requester
>> >     (or pci_dev_for_each_requester_id)
>> >
>> > (2) pci_get_visible_pcie_requester
>> >     (or pci_get_visible_pcie_requester_id)
>> >
>> > Note however that (2) does not impose anything about domains or
>> > isolation, it is strictly based on PCI topology.  It's left to the
>> > caller to determine how that translates to IOMMU domains, but the
>> > typical case is trivial.
>>
>> Can you expand on this a little bit?  What's involved in translating
>> the pci_get_visible_pcie_requester() result to an IOMMU domain?  Is
>> there something IOMMU-specific about this?
>
> I try not to make any assumptions about what's required to get from a
> pci_dev/requester ID to a domain.  The IOMMU may only be able to filter
> a subset of the requester ID, for instance what if it has no function
> level visibility, or perhaps only bus level visibility.  intel-iommu has
> full BDF granularity, so it's perhaps the simplest case.
>
>> I assume that for any given PCI device A, there's a subtree of devices
>> that the IOMMU can't distinguish from A, and that this subtree is not
>> IOMMU-specific so it's reasonable to to have a PCI interface to
>> compute it.  An IOMMU driver might want to expand the domain to
>> include more devices, of course, and *that* seems like something to
>> leave to the driver.
>
> Yes, I agree.  We're only trying to determine the PCI bus level
> visibility, anything else is left to the IOMMU driver.
>
>> I'm also assuming that a pci_dev (the root of the subtree) is a good
>> way to identify this set of indistinguishable devices because it's
>> easy to test whether a device B is part of it.  But the requester ID
>> seems redundant in this case because you can just associate an IOMMU
>> domain with the pci_dev.
>
> I don't think we want to assume that an IOMMU driver bases a domain on a
> pci_dev or a BDF.  That's specific to the driver.  The requester ID is
> not redundant though since it depends on topology and quirks.  A given
> pci_dev may have it's own legitimate requester ID or a quirk, where the
> quirk may be specific to the device or architected, like a bridge using
> the (bridge->subordinate->number << 8 | 0) requester ID.
>
>> Where does ACS come into the picture?
>
> ACS determines whether a transaction must necessarily reach the IOMMU
> without being redirected.  Therefore once we figure out the point at
> which we have bus level granularity for a transaction, we look upstream
> to determine if a transaction must necessarily reach the IOMMU.  In the
> case of intel-iommu, IOMMU groups are only dependent on the visibility
> provided by the PCI topology and the isolation guaranteed through ACS,
> but it's up to the IOMMU driver to determine whether there are
> additional constraints.  Thanks,

What code will look for ACS support and enablement?  Do you envision
that being in the IOMMU code or somewhere in PCI?  I was hoping that
the isolation/domain identification stuff could be fairly generic, but
it sounds like that's not the case so I'm guessing the interesting
parts of it will be in IOMMU code.

So I think I'm willing to go along with
pci_get_visible_pcie_requester() returning both a pci_dev and a
requester ID.  Is a single one of each sufficient?  I guess it is -- I
don't see any loops around where you're calling it.

Bjorn
