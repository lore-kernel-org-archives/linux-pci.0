Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 14 Jun 2017 13:09:43 -0500
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
Subject: Re: [PATCH v2 1/8] ACPI / PM: Run wakeup notify handlers
 synchronously
Message-ID: <20170614180943.GA20778@bhelgaas-glaptop.roam.corp.google.com>
References: <8918199.uo13RZ8hZk@aspire.rjw.lan>
 <1615075.mBkoKApGGc@aspire.rjw.lan>
 <5652844.yCt16F1gBo@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5652844.yCt16F1gBo@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 12, 2017 at 10:48:41PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The work functions provided by the users of acpi_add_pm_notifier()
> should be run synchronously before re-enabling the wakeup GPE in
> case they are used to clear the status and/or disable the wakeup
> signaling at the source.  Otherwise, which is the case currently in
> the PCI bus type code, the same wakeup event may be signaled for
> multiple times while the execution of the work function in response
> to it has already been queued up.
> 
> Fortunately, acpi_add_pm_notifier() is only used by PCI and by
> ACPI device PM code internally, so the change is relatively
> straightforward to make.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/acpi/device_pm.c |   27 +++++++++++----------------
>  drivers/pci/pci-acpi.c   |   17 +++++++----------
>  include/acpi/acpi_bus.h  |    4 ++--
>  3 files changed, 20 insertions(+), 28 deletions(-)
> 
> Index: linux-pm/drivers/acpi/device_pm.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/device_pm.c
> +++ linux-pm/drivers/acpi/device_pm.c
> @@ -400,8 +400,8 @@ static void acpi_pm_notify_handler(acpi_
>  
>  	if (adev->wakeup.flags.notifier_present) {
>  		__pm_wakeup_event(adev->wakeup.ws, 0);
> -		if (adev->wakeup.context.work.func)
> -			queue_pm_work(&adev->wakeup.context.work);
> +		if (adev->wakeup.context.func)
> +			adev->wakeup.context.func(&adev->wakeup.context);
>  	}
>  
>  	mutex_unlock(&acpi_pm_notifier_lock);
> @@ -413,7 +413,7 @@ static void acpi_pm_notify_handler(acpi_
>   * acpi_add_pm_notifier - Register PM notify handler for given ACPI device.
>   * @adev: ACPI device to add the notify handler for.
>   * @dev: Device to generate a wakeup event for while handling the notification.
> - * @work_func: Work function to execute when handling the notification.
> + * @func: Work function to execute when handling the notification.
>   *
>   * NOTE: @adev need not be a run-wake or wakeup device to be a valid source of
>   * PM wakeup events.  For example, wakeup events may be generated for bridges
> @@ -421,11 +421,11 @@ static void acpi_pm_notify_handler(acpi_
>   * bridge itself doesn't have a wakeup GPE associated with it.
>   */
>  acpi_status acpi_add_pm_notifier(struct acpi_device *adev, struct device *dev,
> -				 void (*work_func)(struct work_struct *work))
> +			void (*func)(struct acpi_device_wakeup_context *context))
>  {
>  	acpi_status status = AE_ALREADY_EXISTS;
>  
> -	if (!dev && !work_func)
> +	if (!dev && !func)
>  		return AE_BAD_PARAMETER;
>  
>  	mutex_lock(&acpi_pm_notifier_lock);
> @@ -435,8 +435,7 @@ acpi_status acpi_add_pm_notifier(struct
>  
>  	adev->wakeup.ws = wakeup_source_register(dev_name(&adev->dev));
>  	adev->wakeup.context.dev = dev;
> -	if (work_func)
> -		INIT_WORK(&adev->wakeup.context.work, work_func);
> +	adev->wakeup.context.func = func;
>  
>  	status = acpi_install_notify_handler(adev->handle, ACPI_SYSTEM_NOTIFY,
>  					     acpi_pm_notify_handler, NULL);
> @@ -469,10 +468,7 @@ acpi_status acpi_remove_pm_notifier(stru
>  	if (ACPI_FAILURE(status))
>  		goto out;
>  
> -	if (adev->wakeup.context.work.func) {
> -		cancel_work_sync(&adev->wakeup.context.work);
> -		adev->wakeup.context.work.func = NULL;
> -	}
> +	adev->wakeup.context.func = NULL;
>  	adev->wakeup.context.dev = NULL;
>  	wakeup_source_unregister(adev->wakeup.ws);
>  
> @@ -658,16 +654,15 @@ EXPORT_SYMBOL(acpi_pm_device_sleep_state
>  
>  /**
>   * acpi_pm_notify_work_func - ACPI devices wakeup notification work function.
> - * @work: Work item to handle.
> + * @context: Device wakeup context.
>   */
> -static void acpi_pm_notify_work_func(struct work_struct *work)
> +static void acpi_pm_notify_work_func(struct acpi_device_wakeup_context *context)
>  {
> -	struct device *dev;
> +	struct device *dev = context->dev;
>  
> -	dev = container_of(work, struct acpi_device_wakeup_context, work)->dev;
>  	if (dev) {
>  		pm_wakeup_event(dev, 0);
> -		pm_runtime_resume(dev);
> +		pm_request_resume(dev);
>  	}
>  }
>  
> Index: linux-pm/include/acpi/acpi_bus.h
> ===================================================================
> --- linux-pm.orig/include/acpi/acpi_bus.h
> +++ linux-pm/include/acpi/acpi_bus.h
> @@ -319,7 +319,7 @@ struct acpi_device_wakeup_flags {
>  };
>  
>  struct acpi_device_wakeup_context {
> -	struct work_struct work;
> +	void (*func)(struct acpi_device_wakeup_context *context);
>  	struct device *dev;
>  };
>  
> @@ -599,7 +599,7 @@ static inline bool acpi_device_always_pr
>  
>  #ifdef CONFIG_PM
>  acpi_status acpi_add_pm_notifier(struct acpi_device *adev, struct device *dev,
> -				 void (*work_func)(struct work_struct *work));
> +			void (*func)(struct acpi_device_wakeup_context *context));
>  acpi_status acpi_remove_pm_notifier(struct acpi_device *adev);
>  int acpi_pm_device_sleep_state(struct device *, int *, int);
>  int acpi_pm_device_run_wake(struct device *, bool);
> Index: linux-pm/drivers/pci/pci-acpi.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pci-acpi.c
> +++ linux-pm/drivers/pci/pci-acpi.c
> @@ -395,29 +395,26 @@ bool pciehp_is_native(struct pci_dev *pd
>  
>  /**
>   * pci_acpi_wake_bus - Root bus wakeup notification fork function.
> - * @work: Work item to handle.
> + * @context: Device wakeup context.
>   */
> -static void pci_acpi_wake_bus(struct work_struct *work)
> +static void pci_acpi_wake_bus(struct acpi_device_wakeup_context *context)
>  {
>  	struct acpi_device *adev;
>  	struct acpi_pci_root *root;
>  
> -	adev = container_of(work, struct acpi_device, wakeup.context.work);
> +	adev = container_of(context, struct acpi_device, wakeup.context);
>  	root = acpi_driver_data(adev);
>  	pci_pme_wakeup_bus(root->bus);
>  }
>  
>  /**
>   * pci_acpi_wake_dev - PCI device wakeup notification work function.
> - * @handle: ACPI handle of a device the notification is for.
> - * @work: Work item to handle.
> + * @context: Device wakeup context.
>   */
> -static void pci_acpi_wake_dev(struct work_struct *work)
> +static void pci_acpi_wake_dev(struct acpi_device_wakeup_context *context)
>  {
> -	struct acpi_device_wakeup_context *context;
>  	struct pci_dev *pci_dev;
>  
> -	context = container_of(work, struct acpi_device_wakeup_context, work);
>  	pci_dev = to_pci_dev(context->dev);
>  
>  	if (pci_dev->pme_poll)
> @@ -425,7 +422,7 @@ static void pci_acpi_wake_dev(struct wor
>  
>  	if (pci_dev->current_state == PCI_D3cold) {
>  		pci_wakeup_event(pci_dev);
> -		pm_runtime_resume(&pci_dev->dev);
> +		pm_request_resume(&pci_dev->dev);
>  		return;
>  	}
>  
> @@ -434,7 +431,7 @@ static void pci_acpi_wake_dev(struct wor
>  		pci_check_pme_status(pci_dev);
>  
>  	pci_wakeup_event(pci_dev);
> -	pm_runtime_resume(&pci_dev->dev);
> +	pm_request_resume(&pci_dev->dev);
>  
>  	pci_pme_wakeup_bus(pci_dev->subordinate);
>  }
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
