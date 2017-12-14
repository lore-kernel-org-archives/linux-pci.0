Return-Path: <SRS0=wdMU=DK=linutronix.de=tglx@kernel.org>
Return-Path: <SRS0=wdMU=DK=linutronix.de=tglx@kernel.org>
Date: Thu, 14 Dec 2017 12:54:05 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: Bjorn Helgaas <helgaas@kernel.org>, Maarten Lankhorst <dev@mblankhorst.nl>,
    Michal Hocko <mhocko@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
    Andy Lutomirski <luto@kernel.org>,
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
    the arch/x86 maintainers <x86@kernel.org>,
    Daniel Vetter <daniel.vetter@intel.com>,
    Bjorn Helgaas <bhelgaas@google.com>,
    "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
    linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: Linux 4.15-rc2: Regression in resume from ACPI S3
In-Reply-To: <alpine.DEB.2.20.1712132201380.1885@nanos>
Message-ID: <alpine.DEB.2.20.1712132211570.1885@nanos>
References: <168050887.sZlTFXWCmO@aspire.rjw.lan> <CA+55aFwsMuHUBQz5kDNwRf17JnasXMWjvmLq5qXGH-694yeq1w@mail.gmail.com> <20171206121452.GA6320@dhcp22.suse.cz> <db81e89d-eee6-868c-dc10-c028f4c4be84@mblankhorst.nl> <alpine.DEB.2.20.1712061344560.1724@nanos>
 <0f1d3d63-fa10-5cef-8014-81753dc60243@mblankhorst.nl> <alpine.DEB.2.20.1712061514420.1724@nanos> <57c8679e-1b88-c9ad-2299-2bea7560b28f@mblankhorst.nl> <alpine.DEB.2.20.1712081129450.1840@nanos> <alpine.DEB.2.20.1712131507160.1885@nanos>
 <20171213162336.GG53955@bhelgaas-glaptop.roam.corp.google.com> <alpine.DEB.2.20.1712131738020.1885@nanos> <CA+55aFw-SZLey5FaQfSLSbDU1sYhoGDrWoOngswkHMFfHW3O6w@mail.gmail.com> <alpine.DEB.2.20.1712131856130.1885@nanos> <alpine.DEB.2.20.1712132149420.1885@nanos>
 <alpine.DEB.2.20.1712132201380.1885@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

On Wed, 13 Dec 2017, Thomas Gleixner wrote:
> On Wed, 13 Dec 2017, Thomas Gleixner wrote:
> > On Wed, 13 Dec 2017, Thomas Gleixner wrote:
> > > On Wed, 13 Dec 2017, Linus Torvalds wrote:
> > > 
> > > > On Wed, Dec 13, 2017 at 8:41 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > > > >
> > > > > Definitely. That was fragile forever but puzzles me is that I can't figure
> > > > > out what now causes that spurious interrupt to surface out of the blue.
> > > > 
> > > > Perhaps just timing?
> > > 
> > > That's what I'm trying to figure out right now, because that is the only
> > > sensible explanation left. The whole machinery of suspend is exactly the
> > > same with and without the vector changes. I instrumented all functions
> > > involved and the picture is the same. I even do not see any fundamental
> > > timing differences where one would say: That's it.
> > > 
> > > What puzzles me even more is that in the range of commits I'm fiddling with
> > > there is no other change than the vector management stuff and the point
> > > where it breaks makes no sense at all. The point Maarten bisected it to
> > > works nicely here, so that might just point to a very subtle timing issue.
> > 
> > After doing more debugging on this it turns out that this looks like a
> > legacy interrupt coming in. The vector number is always 55, which is legacy
> > IRQ 7 as seen from the PIC. The corresponding IOAPIC interrupt pin is
> > masked and vector 55 is completely unused.
> > 
> > More questions than answers. Still investigating.

At least that one could be explained by the changes. In the previous
management scheme the IOAPIC interrupts were always allocated even when the
interrupt was not in use. The new scheme does not longer do that because
people complained about the vector waste (16 vectors on each CPU) and it
got rid of all the special casing of IRQ0-15.

So the old scheme silently consumed the spurious vector. I added debug code
to that effect to 4.14 and on that machine IRQ7 is triggered at the same
point post resume and the core code drops it silently because the interrupt
is marked masked and no action assigned.

So the only difference to today is that the new code complains, while the
old one does an extra mask of the already masked IOAPIC pin and silently
returns.

After quite some investigation I found out that its independent of the
graphics thing. That's a genuine issue on that platform which seems to emit
random legacy vectors which were never ever used for unknown reasons. I
verified that both the IOAPIC and the PIC are masked, so they cannot send
crap. Though it turned out that the silly firmware unmasks the PIC and
leaves it that way when it returns from suspend. Now there is a race
whether the kernel resume path manages to mask the PIC again early enough
before something triggers IRQ7 or not. Adding/removing debug code makes the
problem come and go. So I really don't worry about that one and rather
prefer to have the spurious interrupt printed than silently consumed by
chance.

Now the graphics issue is a different story. That only happens on
hibernation after doing the snapshot. There all non boot cpus are onlined
again and after that the devices are 'thawed'. The following reenable of
interrupts fails because i915 is not in PCI_D0 state.

Suspend:

   irq_migrate_all_off_this_cpu: Mask 125 pci_msi_mask_irq+0x0/0x10
   __pci_write_msi_msg: 0000:00:02.0 00000000fee0100c 0000412a
   __pci_write_msi_msg: Not written <- Device not in PCI_D0
   ....
   device_pm_callback_start: i915 0000:00:02.0, parent: pci0000:00, noirq bus [resume]
   pci_pm_resume_noirq <-dpm_run_callback
   pci_pm_resume_noirq <-dpm_run_callback
   pci_pm_default_resume_early <-pci_pm_resume_noirq
   pci_pm_default_resume_early <-pci_pm_resume_noirq
   __pci_write_msi_msg: 0000:00:02.0 00000000fee0100c 0000412a  <-- Set the new affinity
   device_pm_callback_end: i915 0000:00:02.0, err=0

Hibernate:

   irq_migrate_all_off_this_cpu: Mask 125 pci_msi_mask_irq+0x0/0x10
   __pci_write_msi_msg: 0000:00:02.0 00000000fee0100c 0000412a
   __pci_write_msi_msg: Not written <- Device not in PCI_D0
   ....
   device_pm_callback_start: i915 0000:00:02.0, parent: pci0000:00, noirq bus [thaw]
   pci_pm_thaw_noirq <-dpm_run_callback
   __pci_write_msi_msg: 0000:00:02.0 00000000fee0100c 0000412a
   __pci_write_msi_msg: Not written  <--- Device is not in PCI_D0
   device_pm_callback_end: i915 0000:00:02.0, err=0

So that code path fails to set the new affinity because at the point where
the MSI msg should be written the device state is != PCI_D0.

Now, what's different vs. 4.14:

The 4.14 code accidentaly had the irq descriptor for this vector still
populated in the old CPU due to the convoluted way the vector allocation
worked. I have still to investigate if one of those cases is actually
leaking the descriptor, which would be a fatal bug.

But the new code does a proper cleanup and does not repopulate it on the
offline CPU. So that unearthes the issue. I'm handing that over to the PM
folks to look at. I got lost in that maze of callbacks.

Thanks,

	tglx
