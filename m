Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39416 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753697AbbICKBa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 3 Sep 2015 06:01:30 -0400
Date: Thu, 3 Sep 2015 11:01:29 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: oe5hpm <oe5hpm@gmail.com>,
	"CC: Ralf Baechle" <ralf@linux-mips.org>,
	"CC: James E.J. Bottomley" <jejb@parisc-linux.org>,
	"CC: Michael Ellerman" <mpe@ellerman.id.au>,
	"CC: Richard Henderson" <rth@twiddle.net>,
	"CC: Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
	"CC: David Howells" <dhowells@redhat.com>,
	"CC: Russell King" <linux@arm.linux.org.uk>,
	"CC: Tony Luck" <tony.luck@intel.com>,
	"CC: David S. Miller" <davem@davemloft.net>,
	"CC: Ingo Molnar" <mingo@redhat.com>,
	"CC: Guenter Roeck" <linux@roeck-us.net>,
	"CC: Michal Simek" <monstr@monstr.eu>,
	"CC: Chris Zankel" <chris@zankel.net>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: trouble with PCI: Call pci_read_bridge_bases() from core instead
 of arch code
Message-ID: <20150903100115.GA15308@red-moon>
References: <CAAa04yFQEUJm7Jj1qMT57-LG7ZGtnhNDBe=PpSRa70Mj+XhW-A@mail.gmail.com>
 <20150902174716.GA6305@red-moon>
 <20150902203250.GB829@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150902203250.GB829@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Wed, Sep 02, 2015 at 09:32:50PM +0100, Bjorn Helgaas wrote:
> Hi Lorenzo, thanks for jumping on this!

:) I really want to get to the bottom of this resource allocation
issue.

> On Wed, Sep 02, 2015 at 06:47:16PM +0100, Lorenzo Pieralisi wrote:
> > Hi Hannes,
> >
> > On Wed, Sep 02, 2015 at 10:51:18AM +0100, oe5hpm wrote:
> > > Hi Lorenzo,
> > >
> > > today i tried to boot up the most recent vanilla kernel on my
> > > Freescale i.mx6 board.
> > > I ran into trouble regarding PCI enumeration.
> > >
> > > [    0.431949] imx6q-pcie 1ffc000.pcie: PCI host bridge to bus 0000:00
> > > [    0.431976] pci_bus 0000:00: root bus resource [io  0x1000-0xffff]
> > > [    0.431996] pci_bus 0000:00: root bus resource [mem 0x01000000-0x01efffff]
> > > [    0.432022] pci_bus 0000:00: root bus resource [bus 00-ff]
> > > [    0.433271] PCI: bus0: Fast back to back transfers disabled
> > > [    0.433629] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
> > > [    0.435181] PCI: bus1: Fast back to back transfers disabled
> > > [    0.435564] pci 0000:00:00.0: BAR 0: assigned [mem 0x01000000-0x010fffff]
> > > [    0.435593] pci 0000:00:00.0: BAR 8: no space for [mem size 0x01000000]
> > > [    0.435613] pci 0000:00:00.0: BAR 8: failed to assign [mem size 0x01000000]
> > > [    0.435635] pci 0000:00:00.0: BAR 9: assigned [mem
> > > 0x01100000-0x011fffff pref]
> > > [    0.435655] pci 0000:00:00.0: BAR 6: assigned [mem
> > > 0x01200000-0x0120ffff pref]
> > > [    0.435676] pci 0000:00:00.0: BAR 7: assigned [io  0x1000-0x1fff]
> > > [    0.435705] pci 0000:01:00.0: BAR 2: no space for [mem size 0x00200000]
> > > [    0.435722] pci 0000:01:00.0: BAR 2: failed to assign [mem size 0x00200000]
> > > [    0.435739] pci 0000:01:00.0: BAR 1: no space for [mem size 0x00004000]
> > > [    0.435754] pci 0000:01:00.0: BAR 1: failed to assign [mem size 0x00004000]
> > > [    0.435770] pci 0000:01:00.0: BAR 0: no space for [mem size 0x00000100]
> > > [    0.435786] pci 0000:01:00.0: BAR 0: failed to assign [mem size 0x00000100]
> > > [    0.435804] pci 0000:00:00.0: PCI bridge to [bus 01]
> > > [    0.435826] pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
> > > [    0.435855] pci 0000:00:00.0:   bridge window [mem
> > > 0x01100000-0x011fffff pref]
> > >
> > > there are several fails assigning memory ressources to pci-devices.
> > >
> > > i bisect down this trouble to commit id:
> > > dff22d2054b5dbb1889f20c03959dd0c494fab8c : PCI: Call
> > > pci_read_bridge_bases() from core instead of arch code
> > >
> > > For testing purpose i've reverted this commit on a local branch and
> > > everythings works fine, as before.
> > >
> > > [    0.431976] imx6q-pcie 1ffc000.pcie: PCI host bridge to bus 0000:00
> > > [    0.432004] pci_bus 0000:00: root bus resource [io  0x1000-0xffff]
> > > [    0.432023] pci_bus 0000:00: root bus resource [mem 0x01000000-0x01efffff]
> > > [    0.432047] pci_bus 0000:00: root bus resource [bus 00-ff]
> > > [    0.433302] PCI: bus0: Fast back to back transfers disabled
> > > [    0.435122] PCI: bus1: Fast back to back transfers disabled
> > > [    0.435504] pci 0000:00:00.0: BAR 0: assigned [mem 0x01000000-0x010fffff]
> > > [    0.435535] pci 0000:00:00.0: BAR 8: assigned [mem 0x01100000-0x013fffff]
> > > [    0.435557] pci 0000:00:00.0: BAR 6: assigned [mem
> > > 0x01400000-0x0140ffff pref]
> > > [    0.435585] pci 0000:01:00.0: BAR 2: assigned [mem 0x01200000-0x013fffff]
> > > [    0.435626] pci 0000:01:00.0: BAR 1: assigned [mem 0x01100000-0x01103fff]
> > > [    0.435665] pci 0000:01:00.0: BAR 0: assigned [mem 0x01104000-0x011040ff]
> > > [    0.435703] pci 0000:00:00.0: PCI bridge to [bus 01]
> > > [    0.435728] pci 0000:00:00.0:   bridge window [mem 0x01100000-0x013fffff]
> > >
> > > Further i can break down the failure to "drivers/pci/probe.c" line #924.
> > > If i comment out the "pci_read_bridge_bases(child);" also everything works well.
> > >
> > > I have to confess, that my knowledge about the whole PCI thing in the
> > > kernel is not very deep, so it is not possible for me to figure out
> > > what is going wrong.
> >
> > It looks like a bogus bridge aperture size is causing this to happen,
> > and this prevents reassignment on arm (bridge aperture is too big),
> > which proves that reading the bridge bases without vetting the corresponding
> > resources may break (on platforms that were not reading them before).
> >
> > arm was the only platform not reading the bridge bases, here is an
> > answer why. So, to prevent reverting the commit I put together this
> > patch (to be reworked if we deem it reasonable), subject to discussion
> > (I fear it may end up breaking other arm platforms, I do not have all
> > ARM boards and required host controllers to test, I managed to test it on
> > an iMX6 Sabrelite though).
> >
> > Here, please let me know if it works for you, I will keep on thinking
> > to find the best solution.
> >
> > I will have to do this for arm64 too, comments very welcome.
> >
> > Thanks,
> > Lorenzo
> >
> > -- >8 --
> > Subject: [PATCH] arm: kernel: pci: fixup erroneous PCI bridge apertures
> >
> > Bridge apertures read by core PCI code through pci_read_bridge_bases()
> > might be erroneous (bogus platform setup). If the arch code does not vet
> > the bridge resources (ie by trying to claim them), we can end up in a
> > situation where wrong bridge apertures can prevent resources assignment
> > for downstream devices causing enumeration failures (eg a bridge
> > aperture does not fit in the respective host controller resource window,
> > so it can't be assigned).
> >
> > This patch adds arm arch code that vets bridge resources by trying
> > to claim them, and reset them on claiming failure so that they can
> > be properly reassigned.
> 
> We definitely should not depend on the platform to set up the bridge
> windows.  Do we know what the platform left in the 00:00.0 window
> registers?

Well, I agree but the point here is, by reading the bridge bases
we are initializing the apertures resources and this is causing
issues, we have to have a way to nuke the initialized apertures resources
if they are bogus, more below. I wonder why we want to read the bridge
apertures at all on !PCI_PROBE_ONLY systems.

pci 0000:00:00.0:   bridge window [mem 0x01000000-0x01ffffff]

> I see that bus 01 requires 0x204100 of mem space, which must be
> rounded up to a megabyte boundary, so the window must be at least 3M
> (0x00300000):
> 
>   pci 0000:01:00.0: BAR 2: failed to assign [mem size 0x00200000]
>   pci 0000:01:00.0: BAR 1: failed to assign [mem size 0x00004000]
>   pci 0000:01:00.0: BAR 0: failed to assign [mem size 0x00000100]
> 
> I don't understand the connection with dff22d2054b5 yet.  If we don't
> call pci_read_bridge_bases(), apparently some assign-resources path
> figures out the required size and assigns a 3M window.
> 
> If we *do* call pci_read_bridge_bases(), do we read a bogus 16M window
> size, fail to assign that because the host controller window isn't big
> enough, and then the assign-resources path just gives up?  I assume
> clearing r->flags in your patch is the critical thing?  Is there
> something in assign-resources that checks for r->flags == 0?

You summed it up, but the point here is not about the flags, it is
about the bogus 16M bridge aperture (so r->start and r->end).

While sizing the bridge apertures, the code in pbus_size_mem() checks
the size required by devices and then set-up the bridge aperture.

Now, calculate_memsize() takes as an input the "old" aperture size (16M)
which means that the updated aperture will keep the old aperture
size instead of the one computed from the size of downstream devices
(because the old aperture - read from bridge bases - is larger, see
calculate_memsize()), hence the failure.

If the bridge aperture is reset (ie resource start and end are zeroed)
before sizing the bridge everything is back to normal.

x86 does the same thing I implement in the patch attached, and probably
we have also discovered why Alpha and MIPS were reading bridge bases
on PROBE_ONLY systems only.

> I think it would be ideal if we could someday claim the resource
> immediately, as soon as we read it from a BAR or bridge window, and
> mark it as IORESOURCE_UNSET if claiming it fails.  Then if the
> platform set up reasonable windows, we could use them; if it didn't,
> we could just assign our own.

Well, that's what my patch does and that's what x86 does. I am nervous
about adding this to core PCI code (in particular I am worried about
claiming the bridge windows ie when you say reasonable, it does not
necessarily mean optimal, claiming the bridge apertures can cause
issues in relation to resources allocation IMO since we claim
the aperture before sizing the bridge).

My question is: on !PCI_PROBE_ONLY systems, why do we want to "trust" the
bridge bases (that we want to reassign after sizing bridges *anyway*) ?
I understand on PCI_PROBE_ONLY systems they should be immutable, I would
like to understand why we have to read them on !PCI_PROBE_ONLY systems.

> I'd like to avoid adding things to pcibios_fixup_bus() if possible
> because most of what is done there is arch-independent, and I'd like
> to get the arch-independent stuff into the PCI core.

I agree, but if we move my patch to core code I expect failures owing
to the claiming of the bridge apertures (I am still very very
concerned about claiming the bridge apertures by default).

I do not think there is any other way of *validating* the bridge bases
read from HW, the question is whether we should read them on
!PCI_PROBE_ONLY systems at all, if the answer is yes options are
limited (and I am not entirely happy with my patch, again, claiming
the bridge apertures IMO is a risky business).

Lorenzo

> Bjorn
> 
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > ---
> >  arch/arm/kernel/bios32.c | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >
> > diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
> > index 874e182..ebbe052 100644
> > --- a/arch/arm/kernel/bios32.c
> > +++ b/arch/arm/kernel/bios32.c
> > @@ -282,6 +282,27 @@ static inline int pdev_bad_for_parity(struct pci_dev *dev)
> >
> >  }
> >
> > +static void pcibios_fixup_bridge_resources(struct pci_dev *dev)
> > +{
> > +     int idx;
> > +
> > +     if (!dev->bus)
> > +             return;
> > +
> > +     for (idx = PCI_BRIDGE_RESOURCES; idx < PCI_NUM_RESOURCES; idx++) {
> > +             struct resource *r = &dev->resource[idx];
> > +
> > +             if (!r->flags || r->parent)
> > +                     continue;
> > +
> > +             if (pci_claim_resource(dev, idx)) {
> > +                     r->flags = 0;
> > +                     r->start = 0;
> > +                     r->end = -1;
> > +             }
> > +     }
> > +}
> > +
> >  /*
> >   * pcibios_fixup_bus - Called after each bus is probed,
> >   * but before its children are examined.
> > @@ -352,6 +373,9 @@ void pcibios_fixup_bus(struct pci_bus *bus)
> >                       bus->bridge_ctl |= PCI_BRIDGE_CTL_PARITY;
> >       }
> >
> > +     if (bus->self)
> > +             pcibios_fixup_bridge_resources(bus->self);
> > +
> >       /*
> >        * Report what we did for this bus
> >        */
> > --
> > 1.9.1
> >
> >
> 
