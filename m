Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751264AbdBSE2N (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 18 Feb 2017 23:28:13 -0500
Date: Sat, 18 Feb 2017 22:27:45 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Andreas Noever <andreas.noever@gmail.com>,
        linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Erik Veijola <erik.veijola@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH v6 1/8] PCI: Recognize Thunderbolt devices
Message-ID: <20170219042745.GB7668@bhelgaas-glaptop.roam.corp.google.com>
References: <cover.1486913733.git.lukas@wunner.de>
 <fee5154ef747e34684f316a9edf1ec7f635fd0f8.1486913733.git.lukas@wunner.de>
 <20170217152903.GB10663@bhelgaas-glaptop.roam.corp.google.com>
 <20170218091224.GA1335@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170218091224.GA1335@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Feb 18, 2017 at 10:12:24AM +0100, Lukas Wunner wrote:
> On Fri, Feb 17, 2017 at 09:29:03AM -0600, Bjorn Helgaas wrote:
> > On Sun, Feb 12, 2017 at 05:07:45PM +0100, Lukas Wunner wrote:
> > > Detect on device probe whether a PCI device is part of a Thunderbolt
> > > daisy chain (i.e. it is either part of a Thunderbolt controller or part
> > > of the hierarchy below a Thunderbolt controller).
> > 
> > My problem with this is that "is_thunderbolt" is not well-defined.
> > The PCI specs lay out the common vocabulary and framework for this
> > area.  To keep the code maintainable, we need to connect things back
> > to the specs somehow.
> > 
> > For example, it might make sense to have a bit that means "this device
> > can generate PME from D3hot", because PME and D3hot are part of that
> > common understanding of how PCI works, and we can use that information
> > to design the software.
> > 
> > An "is_thunderbolt" bit doesn't have any of that context.  It doesn't
> > say anything about how the device behaves, so I can't evaluate the
> > code that uses it.
> 
> No, this *does* connect back to the spec, the Thunderbolt spec to be
> specific, except that spec is not available publicly.  (I assume it's
> available under NDA.)  FWIW the PCI SIG doesn't make its specs freely
> available either, only to members or for $$$.  As Andreas Noever has
> pointed out before, there is plenty of precedent for including
> (reverse-engineered) code in the kernel for stuff that isn't public.

I'm not objecting to the fact that the Thunderbolt spec is not public.
What I want to know is specifically how the Thunderbolt bridge behaves
differently than a plain old PCIe bridge.  I don't even want to know
*all* the differences.  You're proposing to make the PCI core work a
slightly differently based on this bit, and in order to maintain that
in the future, we need to know the details of *why* we need to do
things differently.

Maybe D3hot means something different, maybe PME works differently,
maybe hotplug interrupts are signaled differently, I dunno.  If you
want us to treat these devices differently, we have to know *why* so
we can tell whether future changes in other areas also need to handle
them differently.

This might mean several bits instead of one single "is_thunderbolt"
bit, because there may be several differences that affect different
parts of the PCI core.

> The rationale for this bit is that devices on a Thunderbolt daisy chain
> differ from plain PCIe devices and as such require special treatment.
> 
> Thunderbolt encapsulates PCIe and other protocols such as DisplayPort
> into Thunderbolt packets and tunnels them over a network of Converged I/O
> switches, so what's transmitted on the wire differs significantly from
> plain PCIe.  That should already make the necessity for special treatment
> obvious.  I've named three use cases for the is_thunderbolt bit in the
> commit message of this patch but expect there will be more in the future.
> E.g. Apple has a traffic prioritization mechanism on the Converged I/O
> layer which is afforded to specific devices on the PCIe layer above,
> see US 9,015,384:
> http://pimg-fpiw.uspto.gov/fdd/84/153/090/0.pdf
> 
> 
> > A secondary issue is that I think whatever bit you define here should
> > only be set for the actual Thunderbolt device itself.  The bit will
> > presumably tell us something about how that particular device works.
> 
> I don't quite follow, the bit *does* tell us something about how the
> device works, doesn't it?  That it's situated on a Thunderbolt daisy
> chain, I've clearly spelled that out in the commit message as well as
> in a code comment of this patch.

No, it doesn't actually tell us anything about how it works.  The
commit message tells us some *consequences*, but it doesn't say
anything about the PCIe-level features that *lead* to those
consequences.

That means we can't reason about how Thunderbolt devices will work in
different scenarios or future platforms.

> > This is an enumeration-time thing and could be done either as in this
> > path or as a quirk, since it only affects one device.
> 
> You're contradicting yourself by suggesting to use a quirk here:
> 
> Back in 2014 an Intel engineer tried to add a PCI quirk with a long
> list of Thunderbolt devices and none other than you objected that
> you're "really not happy about checking a list of device IDs to identify
> Thunderbolt devices.  Surely there's a better way, because a list
> like this has to be updated regularly."
> https://patchwork.ozlabs.org/patch/409994/
> 
> The better way you were asking for back then is to probe for presence
> of the Thunderbolt VSEC, which is what this patch does.  Yet you're
> still not happy.  I don't get it.

I was wrong to suggest the possibility of a quirk, sorry.  You're
right: looking for the VSEC is a much better route, and that doesn't
fit well in a quirk because the quirk would have to run for all
devices.

> > If runtime code needs to know whether any upstream bridge is
> > Thunderbolt, it can always search up the hierarchy.  I think that
> > would improve readability because the software model would map more
> > closely to the hardware situation.
> 
> That would be more expensive than just checking a bit that is searched
> only once and then cached.  We have is_hotplug_bridge for just eight
> places where we check presence of hotplug capability, why can't we have
> is_thunderbolt?  Beats me.

Searching up the tree is more expensive, but it looks like we only
check it in enumeration-type situations, so I doubt this is a
performance issue.

is_hotplug_bridge is not quite comparable.  For one thing, it can be
set three ways: when PCI_EXP_SLTCAP contains PCI_EXP_SLTCAP_HPC, by a
quirk, and by acpiphp.  It maybe *should* also be set by other hotplug
drivers.  I don't think it would be practical to make an
is_hotplug_bridge() function to look up all those cases.

Bjorn
