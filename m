Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 5 Oct 2016 14:32:27 +0200
From: Lukas Wunner <lukas@wunner.de>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Oliver Neukum <oneukum@suse.com>, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        Peter Wu <peter@lekensteyn.nl>,
        Andreas Noever <andreas.noever@gmail.com>
Subject: Re: [PATCH v2 5/5] PCI: Avoid unnecessary resume on shutdown
Message-ID: <20161005123227.GA5855@wunner.de>
References: <cover.1474130360.git.lukas@wunner.de>
 <1474276343.2044.4.camel@suse.com>
 <20160919101402.GA2506@wunner.de>
 <19951801.HyPAFRyVuO@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <19951801.HyPAFRyVuO@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Sep 24, 2016 at 02:50:05AM +0200, Rafael J. Wysocki wrote:
> On Monday, September 19, 2016 12:14:02 PM Lukas Wunner wrote:
> > On Mon, Sep 19, 2016 at 11:12:23AM +0200, Oliver Neukum wrote:
> > > On Sun, 2016-09-18 at 05:39 +0200, Lukas Wunner wrote:
> > > > We currently perform a mandatory runtime resume of all PCI devices
> > > > on ->shutdown.  However it is pointless to wake devices only to
> > > > immediately power them down afterwards.  (Or have the firmware
> > > > reset them, in case of a reboot.)
> > > > 
> > > > It seems there are only two cases when a runtime resume is actually
> > > > necessary:  If the driver has declared a ->shutdown callback or if
> > > > kexec is in progress.
> > > > 
> > > > Constrain resume of a device to these cases and let it slumber
> > > > otherwise, thereby conserving energy and speeding up shutdown.
> > > 
> > > What happens if you get a wakeup event while going down?
> > 
> > Hm, I should probably disable that with
> > 
> > 	__pci_enable_wake(pci_dev, pci_dev->current_state, true, false);
> > 
> 
> What if the user wants, say, WoL to power on the system?

When the PCI device is runtime resumed, the function call above
will be executed by pci_pm_runtime_resume(), so WoL will be disabled
as well.

There are a few drivers which re-enable WoL from their ->shutdown
hook, but that isn't impacted by this patch because the fast path
isn't taken if the driver has a ->shutdown hook.


> But there's another theoretical issue here.
> 
> On systems with ACPI some devices may need to be reconfigured for wakeup
> from S5 even though they have been configured for signaling wakeup while
> in S0.  Those would still need to be resumed.

Hm, why does the device have to be resumed for that?  The ACPI 6.0 spec
says for _DSW:

"This control method can only access Operation Regions that are either
always available while in a system working state or that are available
when the Power Resources referenced by the _PRW object are all ON."

Before _DSW is executed, all power resources are turned on, so whatever
_DSW does, the device should be powered up and accessible.  Does OSPM
really have to runtime resume the device for _DSW?


Another potential issue that crossed my mind is I/O virtualization:
If a PCI device is passed through to a guest VM, the VM may enable
PME, put the device in D3, etc.  If the VM is shut down, can anything
go wrong if the fast path is taken for runtime suspended devices?
(To be fair, if the VM crashes and doesn't shut down passed through
devices orderly, we'd be in the same situation.)  PME would be disabled
as described above, and leaving the device in D3hot should be fine as well.
If the host or another guest VM wants to use the PCI device afterwards,
it will resume it to D0 with pci_enable_device() in the driver's ->probe
hook.  Let me know if you find flaws in this line of thought.

Thanks!

Lukas
