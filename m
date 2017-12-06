Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 6 Dec 2017 11:34:24 -0800
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>,
        linux-kernel@vger.kernel.org, bhelgaas@google.com,
        linux-pm@vger.kernel.org, tony@atomide.com,
        shawn.lin@rock-chips.com, dianders@chromium.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        Len Brown <lenb@kernel.org>
Subject: Re: [RFC PATCH v10 6/7] PCI / PM: Move acpi wakeup code to pci core
Message-ID: <20171206193421.GA143886@google.com>
References: <20171027072612.26565-1-jeffy.chen@rock-chips.com>
 <1894178.xtK0vD2N4H@aspire.rjw.lan>
 <20171114025109.GA43048@google.com>
 <1882670.s3LR2t44nD@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1882670.s3LR2t44nD@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Rafael,

Thanks for the responses, and sorry for some delay. My thoughts are
still a bit scattered on this (and I'm also busy with other things), and
I'd like some feedback on the device tree definitions from someone, if
possible. (I expect you're more familiar with ACPI than with device
tree, but perhaps you or someone else on copy can humor me?)

I'm also not sure I agree with all of your suggestions, though maybe
something "similar" could be OK.

On Wed, Nov 22, 2017 at 01:26:02AM +0100, Rafael J. Wysocki wrote:
> On Tuesday, November 14, 2017 3:51:11 AM CET Brian Norris wrote:
> > On Wed, Nov 08, 2017 at 11:32:20PM +0100, Rafael J. Wysocki wrote:
> > > On Friday, October 27, 2017 9:26:11 AM CET Jeffy Chen wrote:
> > > > Move acpi wakeup code to pci core as pci_set_wakeup(), so that other
> > > > platforms could reuse it.
> > > 
> > > What exactly do you want to reuse?
> > > 
> > > It looks like that's just several lines of code in acpi_pci_wakeup()
> > > and acpi_pci_propagate_wakeup() which invoke ACPI-specific lower-level
> > > functions, so IMO not worth it at all.
> > 
> > The important part he's sharing here is the walking of the tree
> > structure, in which it's possible for some parent along the way to
> > handle wakeup for its children. I'm not sure how valuable nor how
> > reusable that is.
> 
> ACPI very well may be the only case needing to walk the hierarchy for that.

Sure. It does seem like a bit of overkill, on second thought.

> > In this case (the Rockchip platforms Jeffy and I are working on), I
> > think we really want to just support a single WAKE# pin for the whole
> > system, so maybe the complexity isn't needed.
> 
> So unless I know you'll need it, please don't add it.

Sure, arbitrary hierarchy is probably over-engineering. But 1-per-device
is quite reasonable -- even if we don't support it immediately, it would
be nice if it can be added without too much trouble.

> > The spec does describe that there are good reasons for supporting more than
> > 1 WAKE# pin though (e.g., 1 per device), so it doesn't seem really wise to
> > shoehorn oursleves into a single setup.
> 
> One WAKE# pin per device is reasonable enough, but WAKE# is specifically
> defined as out-of-band and "orthogonal" to the PCIe hierarchy.  What you
> need is a way to program WAKE# and (possibly) wakeup power on the given
> platform for each device having a WAKE# pin individually.

So, *don't* define the wakeup in the host bridge?

Or put another way: how would you define a DT description for this?

By the way, it seems pretty ambiguous how we want to handle things like
(a) multiple devices sharing the same WAKE#
(b) systems where a slot is swappable

For (a), the main problem is that if we have to repeat the interrupt
definition in multiple devices, then we have to deal with something like
IRQF_SHARED. That can be done, but it makes it much harder to use the
dedicated wakeirq helpers.

For (b), it's already weird to write device trees for probable PCI
devices; you technically need to redefine the node for the PCI ID of
each device that gets plugged in. So instead, it seems more like maybe
a property of the port?

Or more concretely:

pcie@XXXXXXXX {
	compatible = "rockchip,rk3399-pcie";
	interrupts-extended = ..., <&gpioX Y>;  // the existing
						// proposal, for
						// 'wakeup' in the host
						// bridge
	interrupt-names = ..., "wakeup";

	pcie_port: pcie@0,0 {
		...
		/*
		// This is a possible proposal, to account for (b)?
		interrupts = <Y>;
		interrupt-parent = <&gpioX>;
		interrupt-names = "wakeup";
		*/

		wifi_device: wifi@0,0 {
			compatible = "pci11ab,2b42";
			/*
			// This is the "1-per-device" proposal?
			// But it doesn't work well if the PCI ID
			// changes (e.g., card swap). Probably want to
			// avoid this if possible.
			// Also, it has an awkward conflict with INTx
			// definitions.
			interrupts-extended = <&intX 0>, <&gpioX Y>;
			interrupt-names = "pci", "wakeup";
			*/
			...
		};
	};
};

Does the description at the "port" level seem reasonable? We'd still
have to figure out how to parse this properly of course...

> The main reason why ACPI needs to walk the hierarchy is that on some systems
> the firmware takes over the handling of the native PME mechanism which then is
> taken care of by the AML (and the kernel is not granted control of the
> relevant PCIe registers).  I don't think you'll ever see anything like that
> on non-ACPI systems.

OK.

> > But that can be implemented either via copying the "few" lines of
> > tree-walking logic, or by trying to share them.
> > 
> > > The structure for other platform code may be the same or similar, but
> > > the details will almost certainly be different and I don't think that
> > > having more callback pointers in pci_platform_pm_ops is necessarily better.
> > 
> > I suppose that's reasonable.
> > 
> > > > Also add .setup_dev() / .setup_host_bridge() / .cleanup() platform pm
> > > > ops's callbacks to setup and cleanup pci devices and host bridge for
> > > > wakeup.
> > > 
> > > Why are they needed?
> > 
> > The implementation is in patch 7, if you really needed more info about
> > why, or provide alternatives.
> 
> Well, that's quite questionable.
> 
> At least defining ->dev_wakeup to do device_set_wakeup_capable() doesn't
> really make sense to me.

Hmm, that does seem a little weird, but I believe maybe Jeffy is using
it as a hack for fitting in with the "dedicated IRQ" stuff? It seems
more like you should be able to use something like
dev_pm_enable_wake_irq() / dev_pm_disable_wake_irq() instead though.
That's a question for patch 7 though, not for the general architecture
of these hooks -- we want to do *something* the arm/disarm the wake-IRQ
there.

> > The current set of hooks assumes that there is no state information
> > or
> > initialization needed for tracking actions of these platform PM hooks on
> > a device. For ACPI this works, because devices have "companion"
> > acpi_dev's to handle everything, and the ACPI framework generally
> > prepares GPE's for you, IIUC. For 'pci-mid', the operations happen to be
> > trivial (and arguably wrong -- several are no-ops, where we might expect
> > the platform to tell us whether the operation was actually supported or
> > not).
> > 
> > For device tree, there isn't really a canonical place to store this
> > information, nor to initialize something like wakeup interrupts.
> 
> The only thing you need IMO is ->set_wakeup which also is what ACPI needs
> and that enables or disables wakeup for the device.  It doesn't actually
> have to track anything (other than, possibly, whether or not wakeup has
> been enabled for it already).

Yes, that's technically the only essential thing needed, though it does
make things a little tougher. We still may need to (depending on whether
we decide to define WAKE# in the bridge, the port, or the device) do
some hierarchy walking. I'm also not yet convinced about "where to
initialize" (see comments below).

> And since the core takes care of native PMEs for you, the only thing
> this needs to cover is the WAKE# pin programming AFAICS.

Right.

> The setup part, in turn, in the ACPI case is done via acpi_platform_notify()
> and, analogously, acpi_platform_notify_remove() does the cleanup.  You seem
> to be trying to add something like it via pci_platform_pm_ops, but is it
> really the most suitable place for that?

Well, the global 'platform_notify' and 'platform_notify_remove'
singletons seem even more fragile. Do we really want to take over the
whole system's device registration hooks just to handle something for a
particular bus type? We're not going to be able to write a generic "add"
and "remove" hook for all devices on all Device Tree systems for this
type of feature. It would likely break a lot of sub-devices to start
parsing "wakeup" properties there.

We *could* do something like what it8152 does:

static int it8152_pci_platform_notify(struct device *dev)
{
	if (dev_is_pci(dev)) {
	...
	}
	return 0;
}

but that doesn't look very nice to me. Among other problems, it won't
stack nicely. What if an 'it8152' system wants to use this 'wakeup'
interrupt definition too?

Instead, I think it makes perfect sense to put the DT-centric wakeup
handling all in the same module -- the "Firmware PM callbacks" (struct
pci_platform_pm_ops) -- instead of scattering it around the codebase.

> > Technically, we could shoehorn this into the .set_wakeup() call, but
> > we'd probably rather not do things like request_irq() on every attempt
> > to suspend/resume the system (among other reasons, we'd lose information
> > that we might otherwise track in /proc/ or /sys/).
> > 
> > Or the inverse of the above: where would you suggest initializing or
> > tearing down the wakeirq?
> 
> Again, ACPI does that via acpi_platform_notify()/acpi_platform_notify_remove(),
> so maybe something similar?

I don't like that solution, per the above. (Depending on what "or maybe
something similar" means.)

> In any case, you need a way to associate DT-provided data with PCI devices and,
> ideally, that should be done at the enumeration time.

Yes, but that's what these hooks were allowing; PCI PM firmware hooks
get a chance to do enumeration-time initialization for both bridges and
devices.

> > An alternative could be to include any necessary state into the
> > pci_host_bridge or pci_dev and just inline the setup code into
> > pci.c/remove.c (e.g., pci_register_host_bridge()) and pci-driver.c
> > (pci_device_{probe,remove}()). But I'm not sure that's much more
> > beautiful.
> 
> Well, that's not the way it is done in the ACPI case anyway.

Brian
