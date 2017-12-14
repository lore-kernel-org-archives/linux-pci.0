Return-Path: <SRS0=wdMU=DK=linutronix.de=tglx@kernel.org>
Return-Path: <SRS0=wdMU=DK=linutronix.de=tglx@kernel.org>
Date: Thu, 14 Dec 2017 13:30:37 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
cc: Linus Torvalds <torvalds@linux-foundation.org>,
    Bjorn Helgaas <helgaas@kernel.org>, Maarten Lankhorst <dev@mblankhorst.nl>,
    Michal Hocko <mhocko@kernel.org>, Andy Lutomirski <luto@kernel.org>,
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
    the arch/x86 maintainers <x86@kernel.org>,
    Daniel Vetter <daniel.vetter@intel.com>,
    Bjorn Helgaas <bhelgaas@google.com>,
    "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
    linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: Linux 4.15-rc2: Regression in resume from ACPI S3
In-Reply-To: <3265333.8krWOQvcRi@aspire.rjw.lan>
Message-ID: <alpine.DEB.2.20.1712141329040.4998@nanos>
References: <168050887.sZlTFXWCmO@aspire.rjw.lan> <alpine.DEB.2.20.1712132201380.1885@nanos> <alpine.DEB.2.20.1712132211570.1885@nanos> <3265333.8krWOQvcRi@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

On Thu, 14 Dec 2017, Rafael J. Wysocki wrote:
> On Thursday, December 14, 2017 12:54:05 PM CET Thomas Gleixner wrote:
> > Now the graphics issue is a different story. That only happens on
> > hibernation after doing the snapshot. There all non boot cpus are onlined
> > again and after that the devices are 'thawed'. The following reenable of
> > interrupts fails because i915 is not in PCI_D0 state.
> > 
> > Suspend:
> > 
> >    irq_migrate_all_off_this_cpu: Mask 125 pci_msi_mask_irq+0x0/0x10
> >    __pci_write_msi_msg: 0000:00:02.0 00000000fee0100c 0000412a
> >    __pci_write_msi_msg: Not written <- Device not in PCI_D0
> >    ....
> >    device_pm_callback_start: i915 0000:00:02.0, parent: pci0000:00, noirq bus [resume]
> >    pci_pm_resume_noirq <-dpm_run_callback
> >    pci_pm_resume_noirq <-dpm_run_callback
> >    pci_pm_default_resume_early <-pci_pm_resume_noirq
> >    pci_pm_default_resume_early <-pci_pm_resume_noirq
> >    __pci_write_msi_msg: 0000:00:02.0 00000000fee0100c 0000412a  <-- Set the new affinity
> >    device_pm_callback_end: i915 0000:00:02.0, err=0
> 
> So this works, because we power up the device during resume even if it
> had been suspended (via runtime PM) before the suspend started.
> 
> > Hibernate:
> > 
> >    irq_migrate_all_off_this_cpu: Mask 125 pci_msi_mask_irq+0x0/0x10
> >    __pci_write_msi_msg: 0000:00:02.0 00000000fee0100c 0000412a
> >    __pci_write_msi_msg: Not written <- Device not in PCI_D0
> >    ....
> >    device_pm_callback_start: i915 0000:00:02.0, parent: pci0000:00, noirq bus [thaw]
> >    pci_pm_thaw_noirq <-dpm_run_callback
> >    __pci_write_msi_msg: 0000:00:02.0 00000000fee0100c 0000412a
> >    __pci_write_msi_msg: Not written  <--- Device is not in PCI_D0
> >    device_pm_callback_end: i915 0000:00:02.0, err=0
> 
> And here we try to leave the device alone which is OK for devices in D0,
> but not for suspended ones.
> 
> It looks like we need to power up them at the "thaw" time too or at least
> I don't see how to address that differently.

The question is whether the code which brings the device out of D0 should
write the message unconditionally. That would be sufficient I think.

Thanks,

	tglx
