Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 14 Jun 2017 13:10:04 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux USB <linux-usb@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Mario Limonciello <mario_limonciello@dell.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Hans De Goede <hdegoede@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v2 6/8] PCI / PM: Restore PME Enable if skipping wakeup
 setup
Message-ID: <20170614181004.GB20778@bhelgaas-glaptop.roam.corp.google.com>
References: <8918199.uo13RZ8hZk@aspire.rjw.lan>
 <1615075.mBkoKApGGc@aspire.rjw.lan>
 <1667474.rysFhR2k32@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1667474.rysFhR2k32@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 12, 2017 at 10:53:36PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The wakeup_prepared PCI device flag is used for preventing subsequent
> changes of PCI device wakeup settings in the same way (e.g. enabling
> device wakeup twice in a row).
> 
> However, in some cases PME Enable may be updated by things like PCI
> configuration space restoration in the meantime and it may need to be
> set again even though the rest of the settings need not change, so
> modify __pci_enable_wake() to do that when it is about to return
> early.
> 
> Also, it is reasonable to expect that __pci_enable_wake() will always
> clear PME Status when invoked to disable device wakeup, so make it do
> so even if it is going to return early then.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/pci.c |   26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
> 
> Index: linux-pm/drivers/pci/pci.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pci.c
> +++ linux-pm/drivers/pci/pci.c
> @@ -1805,6 +1805,23 @@ static void __pci_pme_active(struct pci_
>  	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, pmcsr);
>  }
>  
> +static void pci_pme_restore(struct pci_dev *dev)
> +{
> +	u16 pmcsr;
> +
> +	if (!dev->pme_support)
> +		return;
> +
> +	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> +	if (dev->wakeup_prepared) {
> +		pmcsr |= PCI_PM_CTRL_PME_ENABLE;
> +	} else {
> +		pmcsr &= ~PCI_PM_CTRL_PME_ENABLE;
> +		pmcsr |= PCI_PM_CTRL_PME_STATUS;
> +	}
> +	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, pmcsr);
> +}
> +
>  /**
>   * pci_pme_active - enable or disable PCI device's PME# function
>   * @dev: PCI device to handle.
> @@ -1899,9 +1916,14 @@ int __pci_enable_wake(struct pci_dev *de
>  	if (enable && !runtime && !device_may_wakeup(&dev->dev))
>  		return -EINVAL;
>  
> -	/* Don't do the same thing twice in a row for one device. */
> -	if (!!enable == !!dev->wakeup_prepared)
> +	/*
> +	 * Don't do the same thing twice in a row for one device, but restore
> +	 * PME Enable in case it has been updated by config space restoration.
> +	 */
> +	if (!!enable == !!dev->wakeup_prepared) {
> +		pci_pme_restore(dev);
>  		return 0;
> +	}
>  
>  	/*
>  	 * According to "PCI System Architecture" 4th ed. by Tom Shanley & Don
> 
