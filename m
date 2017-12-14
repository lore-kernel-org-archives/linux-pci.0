Return-Path: <SRS0=wdMU=DK=linutronix.de=tglx@kernel.org>
Return-Path: <SRS0=wdMU=DK=linutronix.de=tglx@kernel.org>
Date: Thu, 14 Dec 2017 16:52:22 +0100 (CET)
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
In-Reply-To: <5115041.vUGA3IjvdM@aspire.rjw.lan>
Message-ID: <alpine.DEB.2.20.1712141648190.4998@nanos>
References: <168050887.sZlTFXWCmO@aspire.rjw.lan> <3265333.8krWOQvcRi@aspire.rjw.lan> <alpine.DEB.2.20.1712141329040.4998@nanos> <5115041.vUGA3IjvdM@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

On Thu, 14 Dec 2017, Rafael J. Wysocki wrote:
> The problem here is that pci_pm_thaw_noirq() calls pci_restore_state() which
> in fact requires the device to be in D0, so the caller should put it into
> D0 instead of trying to "update" its power state.
> 
> [Note that the PCI layer doesn't put devices into low-power states during the
> hibernation's "freeze" transition, but drivers can legitimately do that in
> their "freeze" callbacks which was overlooked in that code and that's what
> i915 does.]
> 
> So IMO what we need is the change below.  I'm going to test it shortly,
> but please give it a go too.

So now this looks more reasonable:

  irq_migrate_all_off_this_cpu: Mask 125 pci_msi_mask_irq+0x0/0x10
  __pci_write_msi_msg: 0000:00:02.0 00000000fee0100c 0000412a 
  __pci_write_msi_msg: Not written
  ...
  device_pm_callback_start: i915 0000:00:02.0, parent: pci0000:00, noirq bus [thaw]
  pci_pm_thaw_noirq <-dpm_run_callback
  __pci_write_msi_msg: 0000:00:02.0 00000000fee0100c 0000412a 
  device_pm_callback_end: i915 0000:00:02.0, err=0
  ...
  resume_irqs: Resume 125
  ...
  irq_handler_entry: irq=125 name=i915

Thanks,

	tglx

> ---
>  drivers/pci/pci-driver.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> Index: linux-pm/drivers/pci/pci-driver.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pci-driver.c
> +++ linux-pm/drivers/pci/pci-driver.c
> @@ -1027,7 +1027,12 @@ static int pci_pm_thaw_noirq(struct devi
>  	if (pci_has_legacy_pm_support(pci_dev))
>  		return pci_legacy_resume_early(dev);
>  
> -	pci_update_current_state(pci_dev, PCI_D0);
> +	/*
> +	 * pci_restore_state() requires the device to be in D0 (because of MSI
> +	 * restoration among other things), so force it into D0 in case the
> +	 * driver's "freeze" callbacks put it into a low-power state directly.
> +	 */
> +	pci_set_power_state(pci_dev, PCI_D0);
>  	pci_restore_state(pci_dev);
>  
>  	if (drv && drv->pm && drv->pm->thaw_noirq)
> 
> 
