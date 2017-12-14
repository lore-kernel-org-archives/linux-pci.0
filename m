Return-Path: <SRS0=Jvse=DK=rjwysocki.net=rjw@kernel.org>
Return-Path: <SRS0=Jvse=DK=rjwysocki.net=rjw@kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Bjorn Helgaas <helgaas@kernel.org>, Maarten Lankhorst <dev@mblankhorst.nl>, Michal Hocko <mhocko@kernel.org>, Andy Lutomirski <luto@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Daniel Vetter <daniel.vetter@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: Linux 4.15-rc2: Regression in resume from ACPI S3
Date: Thu, 14 Dec 2017 13:12:20 +0100
Message-ID: <3265333.8krWOQvcRi@aspire.rjw.lan>
In-Reply-To: <alpine.DEB.2.20.1712132211570.1885@nanos>
References: <168050887.sZlTFXWCmO@aspire.rjw.lan> <alpine.DEB.2.20.1712132201380.1885@nanos> <alpine.DEB.2.20.1712132211570.1885@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

On Thursday, December 14, 2017 12:54:05 PM CET Thomas Gleixner wrote:
> On Wed, 13 Dec 2017, Thomas Gleixner wrote:
> > On Wed, 13 Dec 2017, Thomas Gleixner wrote:
> > > On Wed, 13 Dec 2017, Thomas Gleixner wrote:
> > > > On Wed, 13 Dec 2017, Linus Torvalds wrote:
> > > > 
> > > > > On Wed, Dec 13, 2017 at 8:41 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > > > > >
> > > > > > Definitely. That was fragile forever but puzzles me is that I can't figure
> > > > > > out what now causes that spurious interrupt to surface out of the blue.
> > > > > 
> > > > > Perhaps just timing?
> > > > 
> > > > That's what I'm trying to figure out right now, because that is the only
> > > > sensible explanation left. The whole machinery of suspend is exactly the
> > > > same with and without the vector changes. I instrumented all functions
> > > > involved and the picture is the same. I even do not see any fundamental
> > > > timing differences where one would say: That's it.
> > > > 
> > > > What puzzles me even more is that in the range of commits I'm fiddling with
> > > > there is no other change than the vector management stuff and the point
> > > > where it breaks makes no sense at all. The point Maarten bisected it to
> > > > works nicely here, so that might just point to a very subtle timing issue.
> > > 
> > > After doing more debugging on this it turns out that this looks like a
> > > legacy interrupt coming in. The vector number is always 55, which is legacy
> > > IRQ 7 as seen from the PIC. The corresponding IOAPIC interrupt pin is
> > > masked and vector 55 is completely unused.
> > > 
> > > More questions than answers. Still investigating.
> 
> At least that one could be explained by the changes. In the previous
> management scheme the IOAPIC interrupts were always allocated even when the
> interrupt was not in use. The new scheme does not longer do that because
> people complained about the vector waste (16 vectors on each CPU) and it
> got rid of all the special casing of IRQ0-15.
> 
> So the old scheme silently consumed the spurious vector. I added debug code
> to that effect to 4.14 and on that machine IRQ7 is triggered at the same
> point post resume and the core code drops it silently because the interrupt
> is marked masked and no action assigned.
> 
> So the only difference to today is that the new code complains, while the
> old one does an extra mask of the already masked IOAPIC pin and silently
> returns.
> 
> After quite some investigation I found out that its independent of the
> graphics thing. That's a genuine issue on that platform which seems to emit
> random legacy vectors which were never ever used for unknown reasons. I
> verified that both the IOAPIC and the PIC are masked, so they cannot send
> crap. Though it turned out that the silly firmware unmasks the PIC and
> leaves it that way when it returns from suspend. Now there is a race
> whether the kernel resume path manages to mask the PIC again early enough
> before something triggers IRQ7 or not. Adding/removing debug code makes the
> problem come and go. So I really don't worry about that one and rather
> prefer to have the spurious interrupt printed than silently consumed by
> chance.

OK

> Now the graphics issue is a different story. That only happens on
> hibernation after doing the snapshot. There all non boot cpus are onlined
> again and after that the devices are 'thawed'. The following reenable of
> interrupts fails because i915 is not in PCI_D0 state.
> 
> Suspend:
> 
>    irq_migrate_all_off_this_cpu: Mask 125 pci_msi_mask_irq+0x0/0x10
>    __pci_write_msi_msg: 0000:00:02.0 00000000fee0100c 0000412a
>    __pci_write_msi_msg: Not written <- Device not in PCI_D0
>    ....
>    device_pm_callback_start: i915 0000:00:02.0, parent: pci0000:00, noirq bus [resume]
>    pci_pm_resume_noirq <-dpm_run_callback
>    pci_pm_resume_noirq <-dpm_run_callback
>    pci_pm_default_resume_early <-pci_pm_resume_noirq
>    pci_pm_default_resume_early <-pci_pm_resume_noirq
>    __pci_write_msi_msg: 0000:00:02.0 00000000fee0100c 0000412a  <-- Set the new affinity
>    device_pm_callback_end: i915 0000:00:02.0, err=0

So this works, because we power up the device during resume even if it
had been suspended (via runtime PM) before the suspend started.

> Hibernate:
> 
>    irq_migrate_all_off_this_cpu: Mask 125 pci_msi_mask_irq+0x0/0x10
>    __pci_write_msi_msg: 0000:00:02.0 00000000fee0100c 0000412a
>    __pci_write_msi_msg: Not written <- Device not in PCI_D0
>    ....
>    device_pm_callback_start: i915 0000:00:02.0, parent: pci0000:00, noirq bus [thaw]
>    pci_pm_thaw_noirq <-dpm_run_callback
>    __pci_write_msi_msg: 0000:00:02.0 00000000fee0100c 0000412a
>    __pci_write_msi_msg: Not written  <--- Device is not in PCI_D0
>    device_pm_callback_end: i915 0000:00:02.0, err=0

And here we try to leave the device alone which is OK for devices in D0,
but not for suspended ones.

It looks like we need to power up them at the "thaw" time too or at least
I don't see how to address that differently.

> So that code path fails to set the new affinity because at the point where
> the MSI msg should be written the device state is != PCI_D0.
> 
> Now, what's different vs. 4.14:
> 
> The 4.14 code accidentaly had the irq descriptor for this vector still
> populated in the old CPU due to the convoluted way the vector allocation
> worked. I have still to investigate if one of those cases is actually
> leaking the descriptor, which would be a fatal bug.
> 
> But the new code does a proper cleanup and does not repopulate it on the
> offline CPU. So that unearthes the issue. I'm handing that over to the PM
> folks to look at. I got lost in that maze of callbacks.

OK, thanks so much for getting to the bottom of this!

Rafael
