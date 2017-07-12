Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 12 Jul 2017 14:57:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] PCI / PM: Restore PME Enable after config space
 restoration
Message-ID: <20170712195729.GH14614@bhelgaas-glaptop.roam.corp.google.com>
References: <4782965.eeHMKbM6vL@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4782965.eeHMKbM6vL@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 12, 2017 at 03:05:39AM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit dc15e71eefc7 (PCI / PM: Restore PME Enable if skipping wakeup
> setup) introduced a mechanism by which the PME Enable bit can be
> restored by pci_enable_wake() if dev->wakeup_prepared is set in
> case it has been overwritten by PCI config space restoration.
> 
> However, that commit overlooked the fact that on some systems (Dell
> XPS13 9360 in particular) the AML handling wakeup events checks PME
> Status and PME Enable and it won't trigger a Notify() for devices
> where those bits are not set while it is running.
> 
> That happens during resume from suspend-to-idle when pci_restore_state()
> invoked by pci_pm_default_resume_early() clears PME Enable before the
> wakeup events are processed by AML, effectively causing those wakeup
> events to be ignored.
> 
> Fix this issue by restoring the PME Enable configuration right after
> pci_restore_state() has been called instead of doing that in
> pci_enable_wake().
> 
> Fixes: dc15e71eefc7 (PCI / PM: Restore PME Enable if skipping wakeup setup)
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Since you merged dc15e71eefc7, do you want to merge the fix as well?
Let me know if you'd rather have me take it.

> ---
>  drivers/pci/pci-driver.c |    2 ++
>  drivers/pci/pci.c        |   16 ++++++++--------
>  drivers/pci/pci.h        |    1 +
>  3 files changed, 11 insertions(+), 8 deletions(-)
> 
> Index: linux-pm/drivers/pci/pci-driver.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pci-driver.c
> +++ linux-pm/drivers/pci/pci-driver.c
> @@ -506,6 +506,7 @@ static int pci_restore_standard_config(s
>  	}
>  
>  	pci_restore_state(pci_dev);
> +	pci_pme_restore(pci_dev);
>  	return 0;
>  }
>  
> @@ -517,6 +518,7 @@ static void pci_pm_default_resume_early(
>  {
>  	pci_power_up(pci_dev);
>  	pci_restore_state(pci_dev);
> +	pci_pme_restore(pci_dev);
>  	pci_fixup_device(pci_fixup_resume_early, pci_dev);
>  }
>  
> Index: linux-pm/drivers/pci/pci.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pci.c
> +++ linux-pm/drivers/pci/pci.c
> @@ -1798,7 +1798,11 @@ static void __pci_pme_active(struct pci_
>  	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, pmcsr);
>  }
>  
> -static void pci_pme_restore(struct pci_dev *dev)
> +/**
> + * pci_pme_restore - Restore PME configuration after config space restore.
> + * @dev: PCI device to update.
> + */
> +void pci_pme_restore(struct pci_dev *dev)
>  {
>  	u16 pmcsr;
>  
> @@ -1808,6 +1812,7 @@ static void pci_pme_restore(struct pci_d
>  	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
>  	if (dev->wakeup_prepared) {
>  		pmcsr |= PCI_PM_CTRL_PME_ENABLE;
> +		pmcsr &= ~PCI_PM_CTRL_PME_STATUS;
>  	} else {
>  		pmcsr &= ~PCI_PM_CTRL_PME_ENABLE;
>  		pmcsr |= PCI_PM_CTRL_PME_STATUS;
> @@ -1904,14 +1909,9 @@ int pci_enable_wake(struct pci_dev *dev,
>  {
>  	int ret = 0;
>  
> -	/*
> -	 * Don't do the same thing twice in a row for one device, but restore
> -	 * PME Enable in case it has been updated by config space restoration.
> -	 */
> -	if (!!enable == !!dev->wakeup_prepared) {
> -		pci_pme_restore(dev);
> +	/* Don't do the same thing twice in a row for one device. */
> +	if (!!enable == !!dev->wakeup_prepared)
>  		return 0;
> -	}
>  
>  	/*
>  	 * According to "PCI System Architecture" 4th ed. by Tom Shanley & Don
> Index: linux-pm/drivers/pci/pci.h
> ===================================================================
> --- linux-pm.orig/drivers/pci/pci.h
> +++ linux-pm/drivers/pci/pci.h
> @@ -71,6 +71,7 @@ void pci_power_up(struct pci_dev *dev);
>  void pci_disable_enabled_device(struct pci_dev *dev);
>  int pci_finish_runtime_suspend(struct pci_dev *dev);
>  int __pci_pme_wakeup(struct pci_dev *dev, void *ign);
> +void pci_pme_restore(struct pci_dev *dev);
>  bool pci_dev_keep_suspended(struct pci_dev *dev);
>  void pci_dev_complete_resume(struct pci_dev *pci_dev);
>  void pci_config_pm_runtime_get(struct pci_dev *dev);
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
