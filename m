Return-Path: <rjw@rjwysocki.net>
Return-Path: <rjw@rjwysocki.net>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Lukas Wunner <lukas@wunner.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Andreas Noever <andreas.noever@gmail.com>
Subject: Re: [PATCH v2 10/13] PCI: Avoid going from D3cold to D3hot for system sleep
Date: Mon, 08 Aug 2016 01:32:54 +0200
Message-ID: <2182119.Z8Tk7onsTO@vostro.rjw.lan>
In-Reply-To: <20160807090347.GA5679@wunner.de>
References: <cover.1463134231.git.lukas@wunner.de> <CAJZ5v0hPbeaUotiFxg_BbkS86HEz=u0ThkdwJju5WyXOuDgd6A@mail.gmail.com> <20160807090347.GA5679@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-pci.vger.kernel.org>

On Sunday, August 07, 2016 11:03:47 AM Lukas Wunner wrote:
> On Thu, Aug 04, 2016 at 05:30:47PM +0200, Rafael J. Wysocki wrote:
> > On Thu, Aug 4, 2016 at 10:14 AM, Lukas Wunner <lukas@wunner.de> wrote:
> > > On Thu, Aug 04, 2016 at 03:07:56AM +0200, Rafael J. Wysocki wrote:
> > >> On Thu, Aug 4, 2016 at 2:45 AM, Lukas Wunner <lukas@wunner.de> wrote:
> > >> > On Thu, Aug 04, 2016 at 01:50:39AM +0200, Rafael J. Wysocki wrote:
> > >> >> On Wed, Aug 3, 2016 at 2:28 PM, Lukas Wunner <lukas@wunner.de> wrote:
> > >> >> > I will update this patch with Bjorn's suggestion to also leave the
> > >> >> > device in D3cold if it is wakeup-capable. The idea is to just change
> > >> >> > the default state in the first line of the function like this:
> > >> >> >
> > >> >> > -       pci_power_t target_state = PCI_D3hot;
> > >> >> > +       pci_power_t target_state =
> > >> >> > +               dev->current_state == PCI_D3cold ? PCI_D3cold : PCI_D3hot;
> > >> >>
> > >> >> That should work (even though it is a little clumsy IMO).
> > >> >
> > >> > Not sure why that is clumsy but happy to use something else if you
> > >> > have a suggestion?
> > >>
> > >> The clumsy thing is that we'd take the target_state as D3cold only if
> > >> the device already was in that state.
> > >>
> > >> Otherwise, we'd take D3hot as the target state for the same device,
> > >> which doesn't seem particularly consistent to me.
> > >>
> > >> Not that I have better ideas ATM, but then the current code works for
> > >> my use cases. :-)
> > >
> > > The goal is to afford direct-complete to devices which are not power-
> > > manageable by the platform but can still be runtime suspended to D3cold.
> > 
> > Well, this is a bit misleading.
> > 
> > According to the PCI spec there are two ways to put a device into
> > D3cold: either by putting its bus into B3 (which for PCIe means
> > turning the link off IIRC) which happens when the bridge goes into
> > D3hot, or through the platform.
> > 
> > You aren't talking about any of those cases, though, so we go outside
> > of the spec here.
> 
> Yes. With Nvidia Optimus / AMD PowerXpress hybrid graphics on non-Macs
> and Thunderbolt on Macs, it could still be argued that D3cold is
> facilitated by the platform, albeit with custom methods instead of _PS3.

So you'd need a custom set of callbacks for that "platform", but that's
only a few devices in the system, so you would also need normal ACPI callbacks
for the rest.

Conceivably, that could be addressed with per-device platform callbacks,
but that is conceptually equivalent to adding a pm_domain pointer to the
devices in question.

> With hybrid graphics on Macs, the discrete GPU is turned off by
> a gmux controller on the LPC bus which is controlled via I/O ports.
> So the ACPI platform isn't involved at all and at least then we're
> in completely nonstandard territory.
> 
> > > Right now we wake those devices up from D3cold to D3hot before going to
> > > sleep, which is a waste of energy and prolongs the suspend sequence
> > > (waking up the Thunderbolt controller takes 2 seconds).
> > 
> > Understood.
> > 
> > > The de facto standard to power manage such devices seems to be with
> > > dev_pm_domain_set(). That's what vga_switcheroo does and I'll move
> > > to that as well for v3 of this series.
> > 
> > OK
> > 
> > > I could add a "bool can_power_off" to struct dev_pm_domain.
> > 
> > I'm not sure if dev_pm_domain is the right level.  The "can_power_off"
> > thing would be sort of specific to your particular use case.
> > 
> > Say you have something like
> > 
> > struct pci_pm_domain {
> >         struct dev_pm_domain pd;
> >         ...
> > };
> > 
> > > Then I could change pci_target_state() like this:
> > >
> > >         pci_power_t target_state = PCI_D3hot;
> > >
> > >         if (platform_pci_power_manageable(dev)) {
> > >                 [...]
> > > +       } else if (dev->dev.pm_domain && dev->dev.pm_domain.can_power_off) {
> > 
> > so you can do something like
> > 
> >           } else if (dev->dev.pm_domain) {
> >                     struct pci_pm_domain *pci_pd =
> > to_pci_pm_domain(dev->dev.pm_domain);
> > 
> >                     ....
> >           } else if [...]
> > 
> > and it may be a bit more PCI-oriented without expanding generic data types.
> > 
> > > +               target_state = PCI_D3cold;
> > >         } else if [...]
> > >
> > > Another idea would be to add a ->choose_state hook to dev_pm_domain,
> > > but that would have to return a PCI-specific power state, so we'd be
> > > in clumsy territory again.
> > 
> > Right.
> > 
> > > Thoughts?
> > 
> > Essentially, the PCI PM code needs to be told that there is a way to
> > put the device into D3cold by non-standard means.  There are a couple
> > of ways to do that (a new flag in struct pci_dev, the above, probably
> > more), but in any case it needs to be clear that this is non-standard
> > IMO.
> 
> The more I think about it, the more I lean towards the one-line change
> at the top of this e-mail, even though you found it clumsy. It's small
> and simple and fixes the problem without overengineering things.

I still would like the default D3cold to only apply if the device has no
platform support, though.

> The reasoning is that going from D3cold to D3hot before system sleep
> just never makes sense, no matter if the device got there by standard
> or nonstandard means.

That may not be true in theory.

If this is a wakeup device, it may not be able to generate wakeup signals
from D3cold while the system is in the target system state, although it might
be able to generate those signals when the system is in S0 (in the ACPI case).

That's why I'd leave the platform support case as is.

> So the default target state should be D3cold if the device is already there,
> and D3hot otherwise. I could perhaps try to make this clearer by adding a
> comment.

A comment would certainly be useful.  In particular, about how the device can
get into D3cold at all if the default is D3cold only when the device is already
there.

Thanks,
Rafael
