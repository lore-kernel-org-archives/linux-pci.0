Return-Path: <lukas@wunner.de>
Return-Path: <lukas@wunner.de>
Date: Sat, 8 Oct 2016 12:31:40 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Pierre de Villemereuil <flyos@mailoo.org>,
	Oliver Neukum <oneukum@suse.com>,
	USB list <linux-usb@vger.kernel.org>, linux-pci@vger.kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: USB hot-plug not working (ASUS TP301UA-C4028T)
Message-ID: <20161008103140.GA7725@wunner.de>
References: <20161005204119.GA5961@wunner.de>
 <Pine.LNX.4.44L0.1610061029430.1630-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.44L0.1610061029430.1630-100000@iolanthe.rowland.org>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 06, 2016 at 10:42:14AM -0400, Alan Stern wrote:
> On Wed, 5 Oct 2016, Lukas Wunner wrote:
> > On Wed, Oct 05, 2016 at 01:54:01PM -0500, Bjorn Helgaas wrote:
> > > On Wed, Oct 05, 2016 at 10:45:22AM -0400, Alan Stern wrote:
> > > > In short, Pierre's USB host controller doesn't send wakeup signals from
> > > > runtime suspend, because the firmware limits the runtime-suspend state
> > > > to D0 and the controller can't issue PME# from the D0 state.  In this
> > > > situation we would prefer to avoid suspending the controller at all,
> > > > rather than have it go into runtime suspend and then stop working.
> > 
> > As Alan has correctly pointed out below, there are PCI devices which
> > do not support PME but should still be runtime suspended, e.g. because
> > they have some non-standard mechanism to sideband signal wakeup or
> > because they can detect when they need to resume even if they're in
> > a low-power state.
> > 
> > AFAIUI, this device should not be runtime suspended at all because it
> > doesn't generate a PME interrupt and thus stays suspended forever.
> 
> No, as Oliver said, the device can generate a PME# signal.  It just 
> can't do so from D0, and the firmware doesn't allow it to go into a 
> deeper power-savings state.

Okay.

> 
> > The PCI core doesn't allow runtime PM by default.  Rather it calls
> > pm_runtime_forbid() when the device is added (see pci_pm_init(), called
> > indirectly from pci_device_add()).  PCI drivers need to explicitly call
> > pm_runtime_allow(), typically from their ->probe hook.
> 
> No, pm_runtime_allow() is generally called by userspace, via writing 
> to the .../power/control file in sysfs.  Most drivers do not use it; it 
> is a policy mechanism.  And drivers can't use it to _enforce_ anything, 
> since the user can always override the setting.

Okay, I stand corrected.

> 
> > If this xHC cannot signal wakeup, it shouldn't allow runtime PM in the
> > first place.  Simple as that.
> > 
> I still think this belongs in the PCI core -- except for the difficulty
> of determining whether a device can use a non-PME method for wakeup
> signalling.  If that issue has a good solution then the PCI core could 
> call pm_runtime_get_noresume() for devices that are capable of 
> generating wakeup signals but not in any D-state that the firmware will 
> allow for runtime suspend.

The PCI core already calls pm_runtime_get_sync() before invoking the
->probe hook of a driver (see local_pci_probe()).  Drivers need to
explicitly release a runtime ref to allow their device to suspend.
For xhci-pci, this seems to happen in usb_hcd_pci_probe():

	if (pci_dev_run_wake(dev))
		pm_runtime_put_noidle(&dev->dev);

So you could either modify the if-condition if you want to change the
behaviour for XHCI devices only, or if you want to change it in general,
add something like this to pci_dev_run_wake():

	/* PME capable in principle, but not from the intended sleep state */
	if (dev->pme_support && !pci_pme_capable(dev, pci_target_state(dev)))
		return false;

I've briefly looked over the callers of pci_dev_run_wake() and the above
seems safe but you should double-check them.

Best regards,

Lukas
