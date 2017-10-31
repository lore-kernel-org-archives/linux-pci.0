Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 31 Oct 2017 17:48:09 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH v2 5/6] PCI / PM: Take SMART_SUSPEND driver flag into
 account
Message-ID: <20171031224809.GA5552@bhelgaas-glaptop.roam.corp.google.com>
References: <3806130.B2KCK0tvef@aspire.rjw.lan>
 <16592954.7Zo1mAdIIH@aspire.rjw.lan>
 <1786526.OJccb5RI6R@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1786526.OJccb5RI6R@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Oct 28, 2017 at 12:27:45AM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Make the PCI bus type take DPM_FLAG_SMART_SUSPEND into account in its
> system-wide PM callbacks and make sure that all code that should not
> run in parallel with pci_pm_runtime_resume() is executed in the "late"
> phases of system suspend, freeze and poweroff transitions.
> 
> [Note that the pm_runtime_suspended() check in pci_dev_keep_suspended()
> is an optimization, because if is not passed, all of the subsequent
> checks may be skipped and some of them are much more overhead in
> general.]
> 
> Also use the observation that if the device is in runtime suspend
> at the beginning of the "late" phase of a system-wide suspend-like
> transition, its state cannot change going forward (runtime PM is
> disabled for it at that time) until the transition is over and the
> subsequent system-wide PM callbacks should be skipped for it (as
> they generally assume the device to not be suspended), so add checks
> for that in pci_pm_suspend_late/noirq(), pci_pm_freeze_late/noirq()
> and pci_pm_poweroff_late/noirq().
> 
> Moreover, if pci_pm_resume_noirq() or pci_pm_restore_noirq() is
> called during the subsequent system-wide resume transition and if
> the device was left in runtime suspend previously, its runtime PM
> status needs to be changed to "active" as it is going to be put
> into the full-power state, so add checks for that too to these
> functions.
> 
> In turn, if pci_pm_thaw_noirq() runs after the device has been
> left in runtime suspend, the subsequent "thaw" callbacks need
> to be skipped for it (as they may not work correctly with a
> suspended device), so set the power.direct_complete flag for the
> device then to make the PM core skip those callbacks.
> 
> In addition to the above add a core helper for checking if
> DPM_FLAG_SMART_SUSPEND is set and the device runtime PM status is
> "suspended" at the same time, which is done quite often in the new
> code (and will be done elsewhere going forward too).
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
> 
> -> v2: Implement the entire handling of DPM_FLAG_SMART_SUSPEND in
>        the PCI bus type (instead of doing that in the core).
> 
> ---
>  Documentation/power/pci.txt |   14 +++++
>  drivers/base/power/main.c   |    6 ++
>  drivers/pci/pci-driver.c    |  103 ++++++++++++++++++++++++++++++++++++--------
>  include/linux/pm.h          |    2 
>  4 files changed, 108 insertions(+), 17 deletions(-)
> 
> Index: linux-pm/drivers/pci/pci-driver.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pci-driver.c
> +++ linux-pm/drivers/pci/pci-driver.c
> @@ -734,18 +734,25 @@ static int pci_pm_suspend(struct device
>  
>  	if (!pm) {
>  		pci_pm_default_suspend(pci_dev);
> -		goto Fixup;
> +		return 0;
>  	}
>  
>  	/*
> -	 * PCI devices suspended at run time need to be resumed at this point,
> -	 * because in general it is necessary to reconfigure them for system
> -	 * suspend.  Namely, if the device is supposed to wake up the system
> -	 * from the sleep state, we may need to reconfigure it for this purpose.
> -	 * In turn, if the device is not supposed to wake up the system from the
> -	 * sleep state, we'll have to prevent it from signaling wake-up.
> +	 * PCI devices suspended at run time may need to be resumed at this
> +	 * point, because in general it may be necessary to reconfigure them for
> +	 * system suspend.  Namely, if the device is expected to wake up the
> +	 * system from the sleep state, it may have to be reconfigured for this
> +	 * purpose, or if the device is not expected to wake up the system from
> +	 * the sleep state, it should be prevented from signaling wakeup events
> +	 * going forward.
> +	 *
> +	 * Also if the driver of the device does not indicate that its system
> +	 * suspend callbacks can cope with runtime-suspended devices, it is
> +	 * better to resume the device from runtime suspend here.
>  	 */
> -	pm_runtime_resume(dev);
> +	if (!dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND) ||
> +	    !pci_dev_keep_suspended(pci_dev))
> +		pm_runtime_resume(dev);
>  
>  	pci_dev->state_saved = false;
>  	if (pm->suspend) {
> @@ -765,17 +772,27 @@ static int pci_pm_suspend(struct device
>  		}
>  	}
>  
> - Fixup:
> -	pci_fixup_device(pci_fixup_suspend, pci_dev);
> -
>  	return 0;
>  }
>  
> +static int pci_pm_suspend_late(struct device *dev)
> +{
> +	if (dev_pm_smart_suspend_and_suspended(dev))
> +		return 0;
> +
> +	pci_fixup_device(pci_fixup_suspend, to_pci_dev(dev));
> +
> +	return pm_generic_suspend_late(dev);
> +}
> +
>  static int pci_pm_suspend_noirq(struct device *dev)
>  {
>  	struct pci_dev *pci_dev = to_pci_dev(dev);
>  	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>  
> +	if (dev_pm_smart_suspend_and_suspended(dev))
> +		return 0;
> +
>  	if (pci_has_legacy_pm_support(pci_dev))
>  		return pci_legacy_suspend_late(dev, PMSG_SUSPEND);
>  
> @@ -834,6 +851,14 @@ static int pci_pm_resume_noirq(struct de
>  	struct device_driver *drv = dev->driver;
>  	int error = 0;
>  
> +	/*
> +	 * Devices with DPM_FLAG_SMART_SUSPEND may be left in runtime suspend
> +	 * during system suspend, so update their runtime PM status to "active"
> +	 * as they are going to be put into D0 shortly.
> +	 */
> +	if (dev_pm_smart_suspend_and_suspended(dev))
> +		pm_runtime_set_active(dev);
> +
>  	pci_pm_default_resume_early(pci_dev);
>  
>  	if (pci_has_legacy_pm_support(pci_dev))
> @@ -876,6 +901,7 @@ static int pci_pm_resume(struct device *
>  #else /* !CONFIG_SUSPEND */
>  
>  #define pci_pm_suspend		NULL
> +#define pci_pm_suspend_late	NULL
>  #define pci_pm_suspend_noirq	NULL
>  #define pci_pm_resume		NULL
>  #define pci_pm_resume_noirq	NULL
> @@ -910,7 +936,8 @@ static int pci_pm_freeze(struct device *
>  	 * devices should not be touched during freeze/thaw transitions,
>  	 * however.
>  	 */
> -	pm_runtime_resume(dev);
> +	if (!dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND))
> +		pm_runtime_resume(dev);
>  
>  	pci_dev->state_saved = false;
>  	if (pm->freeze) {
> @@ -925,11 +952,22 @@ static int pci_pm_freeze(struct device *
>  	return 0;
>  }
>  
> +static int pci_pm_freeze_late(struct device *dev)
> +{
> +	if (dev_pm_smart_suspend_and_suspended(dev))
> +		return 0;
> +
> +	return pm_generic_freeze_late(dev);;
> +}
> +
>  static int pci_pm_freeze_noirq(struct device *dev)
>  {
>  	struct pci_dev *pci_dev = to_pci_dev(dev);
>  	struct device_driver *drv = dev->driver;
>  
> +	if (dev_pm_smart_suspend_and_suspended(dev))
> +		return 0;
> +
>  	if (pci_has_legacy_pm_support(pci_dev))
>  		return pci_legacy_suspend_late(dev, PMSG_FREEZE);
>  
> @@ -959,6 +997,16 @@ static int pci_pm_thaw_noirq(struct devi
>  	struct device_driver *drv = dev->driver;
>  	int error = 0;
>  
> +	/*
> +	 * If the device is in runtime suspend, the code below may not work
> +	 * correctly with it, so skip that code and make the PM core skip all of
> +	 * the subsequent "thaw" callbacks for the device.
> +	 */
> +	if (dev_pm_smart_suspend_and_suspended(dev)) {
> +		dev->power.direct_complete = true;
> +		return 0;
> +	}
> +
>  	if (pcibios_pm_ops.thaw_noirq) {
>  		error = pcibios_pm_ops.thaw_noirq(dev);
>  		if (error)
> @@ -1008,11 +1056,13 @@ static int pci_pm_poweroff(struct device
>  
>  	if (!pm) {
>  		pci_pm_default_suspend(pci_dev);
> -		goto Fixup;
> +		return 0;
>  	}
>  
>  	/* The reason to do that is the same as in pci_pm_suspend(). */
> -	pm_runtime_resume(dev);
> +	if (!dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND) ||
> +	    !pci_dev_keep_suspended(pci_dev))
> +		pm_runtime_resume(dev);
>  
>  	pci_dev->state_saved = false;
>  	if (pm->poweroff) {
> @@ -1024,17 +1074,27 @@ static int pci_pm_poweroff(struct device
>  			return error;
>  	}
>  
> - Fixup:
> -	pci_fixup_device(pci_fixup_suspend, pci_dev);
> -
>  	return 0;
>  }
>  
> +static int pci_pm_poweroff_late(struct device *dev)
> +{
> +	if (dev_pm_smart_suspend_and_suspended(dev))
> +		return 0;
> +
> +	pci_fixup_device(pci_fixup_suspend, to_pci_dev(dev));
> +
> +	return pm_generic_poweroff_late(dev);
> +}
> +
>  static int pci_pm_poweroff_noirq(struct device *dev)
>  {
>  	struct pci_dev *pci_dev = to_pci_dev(dev);
>  	struct device_driver *drv = dev->driver;
>  
> +	if (dev_pm_smart_suspend_and_suspended(dev))
> +		return 0;
> +
>  	if (pci_has_legacy_pm_support(to_pci_dev(dev)))
>  		return pci_legacy_suspend_late(dev, PMSG_HIBERNATE);
>  
> @@ -1076,6 +1136,10 @@ static int pci_pm_restore_noirq(struct d
>  	struct device_driver *drv = dev->driver;
>  	int error = 0;
>  
> +	/* This is analogous to the pci_pm_resume_noirq() case. */
> +	if (dev_pm_smart_suspend_and_suspended(dev))
> +		pm_runtime_set_active(dev);
> +
>  	if (pcibios_pm_ops.restore_noirq) {
>  		error = pcibios_pm_ops.restore_noirq(dev);
>  		if (error)
> @@ -1124,10 +1188,12 @@ static int pci_pm_restore(struct device
>  #else /* !CONFIG_HIBERNATE_CALLBACKS */
>  
>  #define pci_pm_freeze		NULL
> +#define pci_pm_freeze_late	NULL
>  #define pci_pm_freeze_noirq	NULL
>  #define pci_pm_thaw		NULL
>  #define pci_pm_thaw_noirq	NULL
>  #define pci_pm_poweroff		NULL
> +#define pci_pm_poweroff_late	NULL
>  #define pci_pm_poweroff_noirq	NULL
>  #define pci_pm_restore		NULL
>  #define pci_pm_restore_noirq	NULL
> @@ -1243,10 +1309,13 @@ static const struct dev_pm_ops pci_dev_p
>  	.prepare = pci_pm_prepare,
>  	.complete = pci_pm_complete,
>  	.suspend = pci_pm_suspend,
> +	.suspend_late = pci_pm_suspend_late,
>  	.resume = pci_pm_resume,
>  	.freeze = pci_pm_freeze,
> +	.freeze_late = pci_pm_freeze_late,
>  	.thaw = pci_pm_thaw,
>  	.poweroff = pci_pm_poweroff,
> +	.poweroff_late = pci_pm_poweroff_late,
>  	.restore = pci_pm_restore,
>  	.suspend_noirq = pci_pm_suspend_noirq,
>  	.resume_noirq = pci_pm_resume_noirq,
> Index: linux-pm/Documentation/power/pci.txt
> ===================================================================
> --- linux-pm.orig/Documentation/power/pci.txt
> +++ linux-pm/Documentation/power/pci.txt
> @@ -980,6 +980,20 @@ positive value from pci_pm_prepare() if
>  driver of the device returns a positive value.  That allows the driver to opt
>  out from using the direct-complete mechanism dynamically.
>  
> +The DPM_FLAG_SMART_SUSPEND flag tells the PCI bus type that from the driver's
> +perspective the device can be safely left in runtime suspend during system
> +suspend.  That causes pci_pm_suspend(), pci_pm_freeze() and pci_pm_poweroff()
> +to skip resuming the device from runtime suspend unless there are PCI-specific
> +reasons for doing that.  Also, it causes pci_pm_suspend_late/noirq(),
> +pci_pm_freeze_late/noirq() and pci_pm_poweroff_late/noirq() to return early
> +if the device remains in runtime suspend in the beginning of the "late" phase
> +of the system-wide transition under way.  Moreover, if the device is in
> +runtime suspend in pci_pm_resume_noirq() or pci_pm_restore_noirq(), its runtime
> +power management status will be changed to "active" (as it is going to be put
> +into D0 going forward), but if it is in runtime suspend in pci_pm_thaw_noirq(),
> +the function will set the power.direct_complete flag for it (to make the PM core
> +skip the subsequent "thaw" callbacks for it) and return.
> +
>  3.2. Device Runtime Power Management
>  ------------------------------------
>  In addition to providing device power management callbacks PCI device drivers
> Index: linux-pm/drivers/base/power/main.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/main.c
> +++ linux-pm/drivers/base/power/main.c
> @@ -1861,3 +1861,9 @@ void device_pm_check_callbacks(struct de
>  		 !dev->driver->suspend && !dev->driver->resume));
>  	spin_unlock_irq(&dev->power.lock);
>  }
> +
> +bool dev_pm_smart_suspend_and_suspended(struct device *dev)
> +{
> +	return dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND) &&
> +		pm_runtime_status_suspended(dev);
> +}
> Index: linux-pm/include/linux/pm.h
> ===================================================================
> --- linux-pm.orig/include/linux/pm.h
> +++ linux-pm/include/linux/pm.h
> @@ -765,6 +765,8 @@ extern int pm_generic_poweroff_late(stru
>  extern int pm_generic_poweroff(struct device *dev);
>  extern void pm_generic_complete(struct device *dev);
>  
> +extern bool dev_pm_smart_suspend_and_suspended(struct device *dev);
> +
>  #else /* !CONFIG_PM_SLEEP */
>  
>  #define device_pm_lock() do {} while (0)
> 
> 
