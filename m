Return-Path: <SRS0=VRWy=2B=h08.hostsharing.net=foo00@kernel.org>
Return-Path: <SRS0=VRWy=2B=h08.hostsharing.net=foo00@kernel.org>
Date: Mon, 20 Feb 2017 12:49:28 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Andreas Noever <andreas.noever@gmail.com>, linux-pci@vger.kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Erik Veijola <erik.veijola@linux.intel.com>,
	Ashok Raj <ashok.raj@intel.com>,
	Keith Busch <keith.busch@intel.com>,
	Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH v6 1/8] PCI: Recognize Thunderbolt devices
Message-ID: <20170220114928.GA19834@h08.hostsharing.net>
References: <cover.1486913733.git.lukas@wunner.de>
 <fee5154ef747e34684f316a9edf1ec7f635fd0f8.1486913733.git.lukas@wunner.de>
 <20170217152903.GB10663@bhelgaas-glaptop.roam.corp.google.com>
 <20170218091224.GA1335@wunner.de>
 <20170219042745.GB7668@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170219042745.GB7668@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Sat, Feb 18, 2017 at 10:27:45PM -0600, Bjorn Helgaas wrote:
> On Sat, Feb 18, 2017 at 10:12:24AM +0100, Lukas Wunner wrote:
> > On Fri, Feb 17, 2017 at 09:29:03AM -0600, Bjorn Helgaas wrote:
> > > On Sun, Feb 12, 2017 at 05:07:45PM +0100, Lukas Wunner wrote:
> > > > Detect on device probe whether a PCI device is part of a Thunderbolt
> > > > daisy chain (i.e. it is either part of a Thunderbolt controller or part
> > > > of the hierarchy below a Thunderbolt controller).
> > > 
> > > My problem with this is that "is_thunderbolt" is not well-defined.
> > > The PCI specs lay out the common vocabulary and framework for this
> > > area.  To keep the code maintainable, we need to connect things back
> > > to the specs somehow.
> > > 
> > > For example, it might make sense to have a bit that means "this device
> > > can generate PME from D3hot", because PME and D3hot are part of that
> > > common understanding of how PCI works, and we can use that information
> > > to design the software.
> > > 
> > > An "is_thunderbolt" bit doesn't have any of that context.  It doesn't
> > > say anything about how the device behaves, so I can't evaluate the
> > > code that uses it.
> > 
> > No, this *does* connect back to the spec, the Thunderbolt spec to be
> > specific, except that spec is not available publicly.  (I assume it's
> > available under NDA.)  FWIW the PCI SIG doesn't make its specs freely
> > available either, only to members or for $$$.  As Andreas Noever has
> > pointed out before, there is plenty of precedent for including
> > (reverse-engineered) code in the kernel for stuff that isn't public.
> 
> I'm not objecting to the fact that the Thunderbolt spec is not public.
> What I want to know is specifically how the Thunderbolt bridge behaves
> differently than a plain old PCIe bridge.  I don't even want to know
> *all* the differences.  You're proposing to make the PCI core work a
> slightly differently based on this bit, and in order to maintain that
> in the future, we need to know the details of *why* we need to do
> things differently.

Okay, I think I'm starting to understand what you're driving at.

Thunderbolt tunnels PCIe transparently, so in principle there should be
no difference behaviour-wise.

As far as the PCI core is concerned, I'm only using is_thunderbolt to
whitelist Thunderbolt ports for runtime PM in patch [2/8]. (This just
concerns like a dozen chips whose behaviour is well understood, hence
enabling runtime PM should be safe.)

The other two upcoming use cases merely concern whether a device is on
a Thunderbolt daisy chain (vs. soldered to the mainboard), and to detect
presence of a Thunderbolt controller in the machine (their PCI devices
use PCI_CLASS_SYSTEM_OTHER and PCI_CLASS_BRIDGE_PCI, which is not
sufficiently unique to identify Thunderbolt controllers).

I decided to put the is_thunderbolt flag in struct pci_dev because any
PCI device might end up on a Thunderbolt daisy chain.  The purpose of
the bit is merely to cache that status, it does not signify that the
device suffers from some particular PCI quirk.


> Maybe D3hot means something different, maybe PME works differently,
> maybe hotplug interrupts are signaled differently, I dunno.  If you
> want us to treat these devices differently, we have to know *why* so
> we can tell whether future changes in other areas also need to handle
> them differently.

This all works fine.  Once a Thunderbolt tunnel has been set up, the
hotplug port on the PCIe switch integrated into the Thunderbolt
controller signals "Card present" and "Link up" interrupts.  On surprise
removal of an attached device, the Presence Detect and Link State bits
are cleared and an interrupt is signaled for each of them.

There's a quirk wherein Thunderbolt controllers claim to support Command
Complete interrupts but they never send them, I don't think that's
intentional but rather a hardware bug. The kernel deals gracefully with
that though, no special treatment necessary.


> > > If runtime code needs to know whether any upstream bridge is
> > > Thunderbolt, it can always search up the hierarchy.  I think that
> > > would improve readability because the software model would map more
> > > closely to the hardware situation.
> > 
> > That would be more expensive than just checking a bit that is searched
> > only once and then cached.  We have is_hotplug_bridge for just eight
> > places where we check presence of hotplug capability, why can't we have
> > is_thunderbolt?  Beats me.
> 
> Searching up the tree is more expensive, but it looks like we only
> check it in enumeration-type situations, so I doubt this is a
> performance issue.

In patch [3/8] of v5 of this series, I used the is_thunderbolt bit in
pci_dev_check_d3cold(), which is not only executed during ->probe and
->remove but also whenver the D3cold status of a device is changed via
sysfs.

However I dropped that patch and the remaining use cases are indeed
limited to ->probe paths, so I no longer feel strongly about avoiding
walking up the hierarchy.

The set_pcie_thunderbolt() function in this commit essentially does
two things:  (a) Detect presence of the Thunderbolt VSEC on a device
and (b) walking up the hierarchy to detect whether that VSEC is present
on a parent.

Do you want me to set the is_thunderbolt bit only on devices belonging
to a Thunderbolt controller and use a separate function to walk up the
hierarchy?

Or do you want me to dispose of the is_thunderbolt bit altogether and
use another function to detect presence of the VSEC?  Searching for a
capability can require lots of non-posted transactions, so keeping
is_thunderbolt would seem reasonable to me.

I could probably add these as inlines to include/linux/pci.h, similar
to how acpi_find_root_bridge_handle() in include/linux/pci-acpi.h walks
up the hierarchy.

Thanks,

Lukas
