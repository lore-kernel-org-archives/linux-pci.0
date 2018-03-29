Return-Path: <SRS0=DJs5=GT=linux.intel.com=mika.westerberg@kernel.org>
Return-Path: <SRS0=DJs5=GT=linux.intel.com=mika.westerberg@kernel.org>
Date: Thu, 29 Mar 2018 14:59:11 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <yehezkel.bernat@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 1/5] PCI: Make sure all bridges reserve at least one
 bus number
Message-ID: <20180329115911.GN2703@lahna.fi.intel.com>
References: <20180226132112.81447-1-mika.westerberg@linux.intel.com>
 <20180226132112.81447-2-mika.westerberg@linux.intel.com>
 <20180327185742.GB7759@bhelgaas-glaptop.roam.corp.google.com>
 <20180328114346.GZ2703@lahna.fi.intel.com>
 <20180328180906.GI7759@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180328180906.GI7759@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 28, 2018 at 01:09:06PM -0500, Bjorn Helgaas wrote:
> On Wed, Mar 28, 2018 at 02:43:46PM +0300, Mika Westerberg wrote:
> > On Tue, Mar 27, 2018 at 01:57:42PM -0500, Bjorn Helgaas wrote:
> > > On Mon, Feb 26, 2018 at 04:21:08PM +0300, Mika Westerberg wrote:
> > > > When distributing extra buses between hotplug bridges we need to make
> > > > sure each bridge reserve at least one bus number, even if there is
> > > > currently nothing connected to it. For instance ACPI hotplug may bring
> > > > in additional devices to non-hotplug bridges later on.
> > > 
> > > I guess you mean ACPI hotplug can add devices below bridges that have
> > > "bridge->is_hotplug_bridge == 0"?  Why don't we set is_hotplug_bridge
> > > in that case?  I do see that acpiphp sets it in *some* cases (see
> > > check_hotplug_bridge()).  Are we missing some case?
> > 
> > We don't know upfront that these ports are going to get devices below
> > them. Only thing that happens in these cases is that we may get ACPI
> > Notify() to the root port leading to these ports.
> 
> Right, it makes sense that we can't tell in advance which devices
> might receive ACPI Notify() events.
> 
> We set "is_hotplug_bridge" in these cases:
> 
>   1. PCIe bridge with PCI_EXP_SLTCAP_HPC (hot-plug capable) bit set.
> 
>      Possibly this could be conditional on CONFIG_HOTPLUG_PCI_PCIE
>      because we can't really handle hotplug anyway if that's not set.
>      The "manual hotplug" scenario where the user initiates a rescan
>      with /sys/bus/pci/rescan or similar might suffer resource
>      problems, but that's sort of a corner case that doesn't feel
>      super important to me.
> 
>   2. acpiphp in check_hotplug_bridge().  bbd34fcdd1b2 ("ACPI / hotplug
>      / PCI: Register all devices under the given bridge") suggests
>      that we treat "all PCI bridges represented in the ACPI namespace
>      are now considered 'hotplug' bridges".  I guess this basically a
>      hint that hotplug is more likely if we have ACPI objects and
>      possibly things like _RMV, _EJx, etc.
> 
>   3. The PLX 6254/HINT HB6 quirk, which I think we can disregard.
> 
> > Also the allocation strategy we use is based on ->is_hotplug_bridge
> > == 1.  Those bridges will be assigned all the remaining bus space
> > and resources. If we somehow set ->is_hotplug_bridge == 1 for these
> > non-hotplug ports it means that we now include those ports also when
> > resources are distributed which defeats the reason why ACPI Notify()
> > is used there in the first place (to preserve bus numbers).
> 
> So as a general rule, can we say that we currently distribute
> resources across bridges that have PCI_EXP_SLTCAP_HPC or are described
> in the ACPI namespace, and we don't reserve anything for other
> bridges?

More like, we distribute remaining resources to downstream bridges if
they have is_hotplug_bridge == 1 (PCI_EXP_SLTCAP_HPC) and need to be
reconfigured (i.e we don't do any resource allocation if the bridge is
already configured by the BIOS).

For other bridges, we only reserve the amount of resources they need for
the devices below them.

> And the point of this patch is that we want to reserve at least one
> bus number for *every* bridge because acpiphp may add something below
> it?

Point is to reserve at least one bus number for non-hotplug bridges that
currently don't have device below them to keep the bus number
distribution code from using those numbers for extension. There is a bug
now that makes it allocate too much if you have non-hotplug bridges
after the hotplug bridge.

The topology is like:

  US ---+--- DS for Thunderbolt NHI
        |
        +--- DS hotplug for extension
        |
        +--- DS for xHCI

Because all the DS ports need to be reconfigured the code in
pci_scan_child_bus_extend() loops over DS bridges but since the DS
leading to XHCI comes after the DS hotplug port it will not be accounted
when extension bus number space is distributed.

> Presumably we should reserve some I/O and MMIO space, too?  Is
> that already covered elsewhere?  Maybe we only need to do this if
> acpiphp is actually compiled in?

AFAICT the resource allocation code in drivers/pci/setup-bus.c makes
sure bridge I/O and MMIO windows reserve at least minimum (4k for I/O,
1M for MMIO).

It is not just acpiphp but could happen when PCIe switch is hotplugged
using native PCIe and has similar configuration (non-hotplug bridges
following hotplug bridges).

> > > > Here is what happens on one system when a Thunderbolt device is plugged in:
> > > > 
> > > >   pci 0000:01:00.0: PCI bridge to [bus 02-39]
> > > >   ...
> > > >   pci_bus 0000:04: [bus 04-39] extended by 0x35
> > > >   pci_bus 0000:04: bus scan returning with max=39
> > > >   pci_bus 0000:04: busn_res: [bus 04-39] end is updated to 39
> > > >   pci 0000:02:02.0: scanning [bus 00-00] behind bridge, pass 1
> > > >   pci_bus 0000:3a: scanning bus
> > > >   pci_bus 0000:3a: bus scan returning with max=3a
> > > >   pci_bus 0000:3a: busn_res: [bus 3a] end is updated to 3a
> > > >   pci_bus 0000:3a: [bus 3a] partially hidden behind bridge 0000:02 [bus 02-39]
> > > >   pci_bus 0000:3a: [bus 3a] partially hidden behind bridge 0000:01 [bus 01-39]
> > > >   pci_bus 0000:02: bus scan returning with max=3a
> > > >   pci_bus 0000:02: busn_res: [bus 02-39] end can not be updated to 3a
> > > > 
> > > > Resulting 'lspci -t' output looks like this:
> > > > 
> > > >   +-1b.0-[01-39]----00.0-[02-3a]--+-00.0-[03]----00.0
> > > >                                   +-01.0-[04-39]--
> > > >                                   \-02.0-[3a]----00.0
> > > > 
> > > > The device behind downstream port at 02:02 is the integrated xHCI (USB 3
> > > > host controller) and is not fully accessible because the hotplug bridge
> > > > is reserving too many bus numbers.
> > > 
> > > Thanks for the details here, but I can't tell what happened before and
> > > was broken, vs. what happens now.  Which is the hotplug bridge?  Which
> > > is the Thunderbolt controller?
> > > 
> > > I guess 02:01.0 must be the bridge consuming too many bus numbers
> > > ([bus 04-39])?
> > 
> > Yes, that's correct.
> > 
> > > And 02:02.0 might be the Thunderbolt controller that wants to use bus
> > > 3a?  But obviously that won't work because 1b.0 doesn't route things
> > > to bus 3a, since it only consumes [bus 01-39].
> > 
> > In fact 02:02 leads to xHCI controller which in this case is
> > inaccessible which means that currently when you plug in USB 3 device to
> > systems with this setup, it won't work.
> > 
> > > (The device behind 02:02.0 is more than just "not fully accessible" --
> > > it's not accessible via config space *at all*.)
> > 
> > Right.
> > 
> > > I guess the 'lspci -t' above must be without this patch, and with this
> > > patch, we'd have
> > > 
> > >   pci 0000:02:00.0: PCI bridge to [bus 03]
> > >   pci 0000:02:01.0: PCI bridge to [bus 04-38]
> > >   pci 0000:02:02.0: PCI bridge to [bus 39]
> > 
> > That's correct.
> > 
> > Do you want me to amend the changelog to include this information as
> > well?
> 
> Yes, please; I think it's very helpful to understand exactly what
> changes as a result of this patch.

OK, I'll add that to the changelog then.

> > > This patch might fix the situation for simple hot-added devices,
> > > but won't we have the same problem again if we hot-add a bridge?
> > > It seems like we need a more comprehensive solution.  I don't mean
> > > we need to go whole hog and reassign everybody's bus numbers
> > > dynamically, but we ought to at least be able to notice the
> > > situation, decline to enable the bridge leading to devices we
> > > can't reach, and give a meaningful error message.
> > 
> > The problem is that you don't know upfront what is going to be
> > hotplugged. Thus it is hard to guess how many buses you want to
> > reserve there. Doing that afterwards is not going to work because of
> > the nature how we do scan and add devices, without rewriting the
> > whole scanning logic.
> 
> That's what I meant about "not going whole hog" -- it's impractical
> right now to solve the general problem.  But we should be clear in
> *this* patch that we're adding a special case to handle a common
> situation: hot-adding a single endpoint.
> 
> And if we encounter the more difficult cases like hot-adding a bridge
> where we don't have resources (bus numbers, I/O, or MMIO) for the
> hierarchy, we can fail with a clear message.  The "partially hidden
> behind bridge" message does not count as clear :)

OK

> > The strategy we use here is the same as Windows does (e.g reserve
> > one bus for these bridges, just in case ACPI Notify() brings in a
> > new device. This is kind of special case used to hotplug TBT and
> > xHCI controller (not bridges). It will not work properly if you
> > hotplug a bridge but at least it works better than just failing
> > miserably.
> 
> The same issue could happen on any system where we use acpiphp, so I
> don't think Thunderbolt is really relevant here, and it's easy to
> confuse things by mentioning it.

This issue can happen regardless whether acpiphp is used or not. I agree
that mentioning Thunderbolt might confuse things.

> IIUC, the problem we're trying to solve here is simply this:
> 
>   A hot-added endpoint is useless unless we can assign a bus number
>   for it.
> 
> I think if this changelog mentioned that fact, what we plan to do
> (assign one bus number for every bridge, and potentially more for
> hotplug bridges), and a simple example of the previous and new bus
> number assignments, that would be about right.

I'll update the changelog to be more clear about what the actual problem
is that we are trying to solve with this patch.

> > The sanity check at the end of pci_scan_bridge_extend() already detects
> > cases where things went wrong:
> > 
> >    pci_bus 0000:3a: [bus 3a] partially hidden behind bridge 0000:02 [bus 02-39]
> >    pci_bus 0000:3a: [bus 3a] partially hidden behind bridge 0000:01 [bus 01-39]
> > 
> > I'm not sure whether we want to add more error prints to confuse users.
> > 
> > (We actually look for these strings in our test automation for native
> >  PCIe hotplug).
> 
> I think we can make things less confusing for users if we improve or
> replace that message.  Maybe something along the lines of "devices
> behind bridge X are unusable because we can't assign a bus number for
> them."
> 
> We can't be very specific about what the new devices *are*, because
> without a bus number, we can't even read their Vendor/Device IDs.
> 
> We should make sure that we don't create pci_devs for any of these
> hidden devices (I suspect this is already the case).

Yes, that's the case already.

> Also, the "Has only triggered on CardBus, fixup is in yenta_socket"
> comment above this block looks obsolete.  We should do some
> archaeology on this and probably remove it, because you're seeing
> this, and I don't think you're using CardBus or yenta_socket.

But since this is a fix, should we do all the cleanup and message
improvement in a separate patch(es) to make sure backporting the actual
fix to stable releases is easy enough?

> > > Nit unrelated to this patch: "bridge 0000:02" is not a bridge, it's a
> > > bus.  Apparently bus 3a is hidden because 1b.0's subordinate bus is
> > > 39.
> > 
> > Indeed.
> > 
> > > > To make sure we don't run out of bus numbers for non-hotplug bridges reserve
> > > > one bus number for them upfront before distributing buses for hotplug bridges.
> > > > 
> > > > Fixes: 1c02ea810065 ("PCI: Distribute available buses to hotplug-capable bridges")
> > > > Reported-by: Mario Limonciello <mario.limonciello@dell.com>
> > > > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > > Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > Cc: stable@vger.kernel.org
> > > > ---
> > > >  drivers/pci/probe.c | 11 ++++++++---
> > > >  1 file changed, 8 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > > > index ef5377438a1e..6cefd47556e3 100644
> > > > --- a/drivers/pci/probe.c
> > > > +++ b/drivers/pci/probe.c
> > > > @@ -2561,7 +2561,10 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
> > > >  	for_each_pci_bridge(dev, bus) {
> > > >  		cmax = max;
> > > >  		max = pci_scan_bridge_extend(bus, dev, max, 0, 0);
> > > > -		used_buses += cmax - max;
> > > > +		/* Reserve one bus for each bridge */
> > > > +		used_buses++;
> > > > +		if (cmax - max > 1)
> > > > +			used_buses += cmax - max - 1;
> > > 
> > > Sorry, this should be trivial, but I'm having a hard time wrapping my
> > > mind around it.
> > 
> > I don't blame you, it is getting quite complex. That's why I added the
> > comments there, hopefully makeing it easier to understand.
> > 
> > > AFAICT, "cmax" is the highest known bus number below this bus, "max"
> > > is the highest bus number below "dev" (one of the bridges on "bus").
> > > 
> > > I assume "used_buses++" accounts for the fact that every enabled
> > > bridge must consume one bus number for its secondary side.
> > 
> > Exactly.
> > 
> > > And I guess "used_buses += cmax - max - 1" adds in the bus numbers
> > > downstream from "dev" (subtracting the one used for its secondary
> > > bus)?
> > 
> > That's also correct.
> > 
> > > pci_scan_bridge_extend() seems to return something related to the
> > > number of bus numbers used below "dev".  Why doesn't *it* account for
> > > the secondary bus number of "dev"?
> > 
> > It returns new "max" i.e maximum subordinate number the bridge occupies.
> > 
> > Reason why we handle this one in pci_scan_child_bus_extend() instead is
> > that we then have the bus number distribution logic pretty much in a
> > single function making it easier to understand what happens (well, it is
> > getting quite complex but I still think it makes sense that way). If you
> > insist, I can move it to pci_scan_bridge_extend() instead.
> 
> I could be wrong, but I think the code would make more sense if all
> the bus number consumption computation were in one place.  It looks
> like pci_scan_bridge_extend() already figures out the [secondary + 1
> .. subordinate] interval, so it seems natural to me to have it figure
> out the entire [secondary .. subordinate] interval.

I looked at how we could move this to pci_scan_bridge_extend() instead
but it turns out not to be so simple afterall. The issue is that
pci_scan_bridge_extend() returns "max", not the number of buses the
bridge consumes. Now, we would need to return max + 1 if the bridge is
matching the criteria (non-hotplug downstream bridge that needs to be
reconfigured) but since we have a loops like this:

       for_each_pci_bridge(dev, bus) {
		..
                max = pci_scan_bridge_extend(bus, dev, max, 0, 0);
        }

       for_each_pci_bridge(dev, bus) {
		..
                max = pci_scan_bridge_extend(bus, dev, max, buses, 1);
       }

In the first pass we end up increasing max by two (on this particular
system) which then shifts starting subordinate bus number of the second
pass by two as well so we would need to account that here spreading the
complexity to two functions instead of just one.

Since this particular patch adds total 5 new lines to fix the problem
and they are contained in a single function, I would rather go with that.

It could be that I'm just missing something obvious, though - this whole
scanning logic is not the most understandable code I've ever
encountered.
