Return-Path: <stern+57e13f40@rowland.harvard.edu>
Return-Path: <stern+57e13f40@rowland.harvard.edu>
Date: Thu, 6 Oct 2016 10:42:14 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Lukas Wunner <lukas@wunner.de>
cc: Bjorn Helgaas <helgaas@kernel.org>,
    Mathias Nyman <mathias.nyman@linux.intel.com>,
    Bjorn Helgaas <bhelgaas@google.com>,
    Pierre de Villemereuil <flyos@mailoo.org>,
    Oliver Neukum <oneukum@suse.com>, USB list <linux-usb@vger.kernel.org>,
     <linux-pci@vger.kernel.org>,
    "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: USB hot-plug not working (ASUS TP301UA-C4028T)
In-Reply-To: <20161005204119.GA5961@wunner.de>
Message-ID: <Pine.LNX.4.44L0.1610061029430.1630-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

On Wed, 5 Oct 2016, Lukas Wunner wrote:

> On Wed, Oct 05, 2016 at 01:54:01PM -0500, Bjorn Helgaas wrote:
> > On Wed, Oct 05, 2016 at 10:45:22AM -0400, Alan Stern wrote:
> > > In short, Pierre's USB host controller doesn't send wakeup signals from
> > > runtime suspend, because the firmware limits the runtime-suspend state
> > > to D0 and the controller can't issue PME# from the D0 state.  In this
> > > situation we would prefer to avoid suspending the controller at all,
> > > rather than have it go into runtime suspend and then stop working.
> 
> As Alan has correctly pointed out below, there are PCI devices which
> do not support PME but should still be runtime suspended, e.g. because
> they have some non-standard mechanism to sideband signal wakeup or
> because they can detect when they need to resume even if they're in
> a low-power state.
> 
> AFAIUI, this device should not be runtime suspended at all because it
> doesn't generate a PME interrupt and thus stays suspended forever.

No, as Oliver said, the device can generate a PME# signal.  It just 
can't do so from D0, and the firmware doesn't allow it to go into a 
deeper power-savings state.

> The PCI core doesn't allow runtime PM by default.  Rather it calls
> pm_runtime_forbid() when the device is added (see pci_pm_init(), called
> indirectly from pci_device_add()).  PCI drivers need to explicitly call
> pm_runtime_allow(), typically from their ->probe hook.

No, pm_runtime_allow() is generally called by userspace, via writing 
to the .../power/control file in sysfs.  Most drivers do not use it; it 
is a policy mechanism.  And drivers can't use it to _enforce_ anything, 
since the user can always override the setting.

> If this xHC cannot signal wakeup, it shouldn't allow runtime PM in the
> first place.  Simple as that.
> 
> The USB core has a function usb_enable_autosuspend() which does nothing
> else but call pm_runtime_allow().  This is called in a couple of places,
> I guess the relevant caller here is drivers/usb/core/hub.c:hub_probe().
> I'd suggest to amend that function so that runtime PM isn't allowed
> if the host controller can't signal plug events from pci_target_state().

usb_enable_autosuspend() is intended mainly for use with USB hubs.  
There is a policy decision in the USB stack that runtime PM will by 
default be allowed for hubs but not for other devices.

In any case, usb_enable_autosuspend() can't be used for host
controllers.  A host controller is not a USB device -- in this case it
is a PCI device.

> This approach is better than returning -EBUSY from the ->runtime_suspend
> hook because the PM core doesn't waste CPU cycles by repeatedly calling
> ->runtime_suspend in vain, always getting -EBUSY back.

I still think this belongs in the PCI core -- except for the difficulty
of determining whether a device can use a non-PME method for wakeup
signalling.  If that issue has a good solution then the PCI core could 
call pm_runtime_get_noresume() for devices that are capable of 
generating wakeup signals but not in any D-state that the firmware will 
allow for runtime suspend.

Alan Stern
