Return-Path: <keith.busch@intel.com>
Return-Path: <keith.busch@intel.com>
Date: Wed, 17 Aug 2016 19:09:51 -0400
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/2] pci: Add ignore indicator quirk for devices
Message-ID: <20160817230951.GD25146@localhost.localdomain>
References: <1470687542-30155-1-git-send-email-keith.busch@intel.com>
 <1470687542-30155-2-git-send-email-keith.busch@intel.com>
 <20160815174002.GB9790@localhost>
 <20160815192316.GB18083@localhost.localdomain>
 <20160817213745.GE27353@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160817213745.GE27353@localhost>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 17, 2016 at 04:37:45PM -0500, Bjorn Helgaas wrote:
> Usually when I think something is totally stupid, it's because I don't
> know the whole story.  So it might make more sense and lead to a
> better solution if you could tell us more about your intent here.

Definitely. I did not provide all the details because I didn't think
knowing the full context would help toward understanding the function
of the patch, but I see now that skimping on the details did not help
our cause.

This came about from wanting a simple SGPIO-like LED management solution
for PCIe SSDs. The Intel group who made this, not considering the
more broad impact on standarization, chose to reuse the hot plug
serial SMBus in the Intel CPUs (aka VPP) that already carried the Slot
Control register bits out of the CPU.

We would love to have been able to disable the capability present
bits, but the hardware logic that would disable those bits would also
have disabled LED control entirely, and we can't change the hardware
now. We have to rely on software to work around this limitation for this
generation of hardware.

The next generation of these devices will pursue standards compliant
methods by engaging with PCI-SIG and the NVMe-MI standards bodies.
This current generation of devices is the only one set this way that
requires this work-around.

> According to the Linux PCI database, the devices you want to quirk are:
> 
>   2030  Sky Lake-E PCI Express Root Port 1A	
>   2031  Sky Lake-E PCI Express Root Port 1B	
>   2032  Sky Lake-E PCI Express Root Port 1C	
>   2033  Sky Lake-E PCI Express Root Port 1D
>
> 
> So are you saying that on every platform that uses Sky Lake-E, these
> indicators are non-standard in this way?

Yes (more details below), but I may need to refine this to specific
subsystem IDs (clarifying that internally now).

Also, just for future note, the device list that I provided with the quirk
may need to be augmented for other vendor devices that implement it this
way as well.
 
> IBPI looks like it's targeted at storage arrays, since it has states
> for "drive not present", "fail", "rebuild", "hotspare", etc.  Maybe
> there's some sense for Sky Lake-E platforms with directly-attached
> storage.
> 
> But if somebody built a Sky Lake-E platform with one of these Root
> Ports leading to a plain hotplug PCIe slot with regular indicators,
> your quirk would break them, wouldn't it?  Or are you imposing
> constraints on how those Root Ports can be used?

Yes, you totally nailed it on this being for storage.

To go even further, we constrain these to be in Sky Lake's VMD domains. We
do not support using VMD for anything but PCIe storage.

> How does 'ledmon' manage the indicators?  The kernel (pciehp) uses the
> Slot Control register, which is not completely trivial because of the
> Command Completed synchronization required.  I'm hoping ledmon isn't
> going to mess up that synchronization.

We've augmented 'ledmon' with libpci and toggles these indicators very
similar to how 'setpci' can change PCI config registers. It is done only
after the storage device is up and registered, which is well outside
the time when pciehp is actively using the slot control.
 
> How does this work for other OSes?  Are you proposing similar changes
> to Windows?

Aha, the mystery to that part might be clarified knowing this is tied
to VMD.

For other OSes including Windows, the VMD driver does not expose the
domain to the rest of the operating system. These VMD drivers implement
their own pci bus and port service drivers, nvme storage drivers,
and interrupt chaining, so they don't have to worry about anyone using
these devices incorrectly. Those drivers also provide VMD specific
management interfaces (special ioctls, for example) to manage its domain.

For Linux, we did not think it appropriate or upstreamable to
re-write all the drivers and services into a monolithic VMD driver,
then implement new user tooling for things that 'lspci' and 'setpci'
already provide. Instead, we leverage all the existing good code by
implementing VMD as a PCI host-bridge driver. The down side is we have
to get our quirks fixed in generic code.


> What's your plan for backwards compatibility?  Just accept that old
> OSes won't be able to operate the indicators correctly until they're
> patched with this quirk?

You may have surmised this already based on the new details, but I'll
just add that since it's tied to VMD, and that being a very new driver,
backward compatibility is not a concern.

> You must have set that capability bit for some reason.  You don't want
> the OS to consume it, so who *do* you expect to consume it, and how
> (direct PCI config access, lspci, etc.), and what are they supposed to
> do with it?

Just restating what I mentioned above, this is an artifact on how the h/w gates
were wired. Suppressing the capability bit automatically suppresses the
LED control, and we need LED control.

This is being addressed in the next generation to do provide the desired
LED control in a standard compliant manner.
