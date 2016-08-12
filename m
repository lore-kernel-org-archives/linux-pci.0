Return-Path: <rjw@rjwysocki.net>
Return-Path: <rjw@rjwysocki.net>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Lukas Wunner <lukas@wunner.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Andreas Noever <andreas.noever@gmail.com>
Subject: Re: [PATCH v2 10/13] PCI: Avoid going from D3cold to D3hot for system sleep
Date: Sat, 13 Aug 2016 00:37:40 +0200
Message-ID: <19891152.yIUWNRqj8t@vostro.rjw.lan>
In-Reply-To: <2003407.8XLAPPsQTe@vostro.rjw.lan>
References: <cover.1463134231.git.lukas@wunner.de> <20160812161609.GA8060@wunner.de> <2003407.8XLAPPsQTe@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-pci.vger.kernel.org>

On Saturday, August 13, 2016 12:18:26 AM Rafael J. Wysocki wrote:
> On Friday, August 12, 2016 06:16:09 PM Lukas Wunner wrote:
> > On Fri, Aug 12, 2016 at 02:50:04AM +0200, Rafael J. Wysocki wrote:
> > > On Thu, Aug 11, 2016 at 3:20 PM, Lukas Wunner <lukas@wunner.de> wrote:
> > > > So I would like to find a common ground and something you feel
> > > > comfortable to ack. The problem I see with your suggested approach
> > > > of subclassing struct dev_pm_domain in a struct pci_pm_domain is
> > > > that I can easily envision Apple putting some custom methods in the
> > > > DSDT to power a non-PCI device up and down. They're starting to use
> > > > SPI and UART to attach devices in newer machines.
> > > 
> > > Those devices have no standard power state definitions.
> > > 
> > > The problem you have here really is PCI-specific, because you want to
> > > use PCI PM along with the non-standard methods.
> > 
> > If I introduce a struct pci_pm_domain like you suggested, it would mean
> > that *all* PCI devices using dev_pm_domain_set() have to be changed,
> > else the container_of() wouldn't work. The resulting code bloat alone
> > inhibits me from implementing this. Plus, it's a tripwire for anyone
> > wishing to assign a dev_pm_domain to their PCI device.
> > 
> > > > Hence my suggestion to add a flag to struct dev_pm_domain, even
> > > > though at the moment that flag would only be queried by the PCI core.
> > > > I don't care if this is called can_power_off or power_manageable or
> > > > whatever.
> > > 
> > > struct dev_pm_domain is way too generic for that though, as I'm sure
> > > there are users of it where the can_power_off thing wouldn't make any
> > > sense whatever.
> > 
> > That seems like a small tradeoff compared to introducing a struct
> > pci_pm_domain.
> 
> I'm not going to apply any patches addding can_power_off or similar flags to
> struct dev_pm_domain.
> 
> > If you dislike a can_power_off flag in struct dev_pm_domain, that only
> > leaves the option to add a one-liner to pci_target_state(), unless I'm
> > missing something.
> 
> I'm not sure why you are insisting on setting target_state to D3cold
> before taking the platform_pci_power_manageable() branch.  Why don't
> you simply rearrange the routine like
> 
> 	pci_power_t target_state = PCI_D3hot;
> 
> 	if (platform_pci_power_manageable(dev)) {
> 		...
> 		return target_state;
> 	}
> 
> 	if (!dev->pm_cap)
> 		return PCI_D0;
> 
> 	if (dev->current_state == PCI_D3cold)
> 		target_state = PCI_D3cold;
> 
> 	if (device_may_wakeup(&dev->dev)) {
> 		...
> 	}
> 
> 	return target_state;
> 
> And that would be fine by me.
> 
> That said I'm not sure why you want to use pci_target_state() so badly?
> 
> If you are going to use a PM domain, why do you still need that function?
> 
> > BTW there seems to be a contradiction in your statements on wakeup devices:
> > 
> > On Mon, Aug 08, 2016 at 01:32:54AM +0200, Rafael J. Wysocki wrote:
> > > On Sunday, August 07, 2016 11:03:47 AM Lukas Wunner wrote:
> > > > The reasoning is that going from D3cold to D3hot before system sleep
> > > > just never makes sense, no matter if the device got there by standard
> > > > or nonstandard means.
> > >
> > > That may not be true in theory.
> > >
> > > If this is a wakeup device, it may not be able to generate wakeup signals
> > > from D3cold while the system is in the target system state, although it might
> > > be able to generate those signals when the system is in S0 (in the ACPI case).
> > 
> > However earlier you wrote:
> > 
> > On Mon, Jul 18, 2016 at 03:39:15PM +0200, Rafael J. Wysocki wrote:
> > > On Saturday, June 18, 2016 12:14:07 AM Lukas Wunner wrote:
> > > > On Fri, Jun 17, 2016 at 04:09:24PM -0500, Bjorn Helgaas wrote:
> > > > > Is there a reason you don't want to do this check for devices that
> > > > > may wakeup?
> > > >
> > > > Fear of breaking things. It would mean that a device would be left in
> > > > D3cold even though it may not be able to signal wakeup from that power
> > > > state.
> > >
> > > Then it should not be put into D3_cold at run time too if it is wakeup-capable.
> > 
> > So on the one hand, you warn that a wakeup-capable device may have been
> > put into D3cold at runtime but needs to be woken before system sleep
> > because it might otherwise not be able to signal wakeup.
> 
> Yes, so specifically I'm concerned about the pci_target_state() invocation in
> pci_dev_keep_suspended() which is done exactly for this purpose.
> 
> If you apply the "keep it in D3cold if already there" logic to that case, it
> may lead to a wrong decision in theory.  Say the device is in D3cold and
> platform_pci_choose_state() returns D1, but pci_no_d1d2() returns true,
> the device will end up in D3cold, but it may not be able to signal wakeup
> from that state after the system has been suspended.

Of course, I guess you'll say that it may not be able to signal wakeup from
D3hot as well in that case, which is correct. :-)

So I guess the one-liner change in pci_target_state() would be fine if Bjorn
likes it.

Thanks,
Rafael
