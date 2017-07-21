Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <4690779.IRjbMOd2yB@aspire.rjw.lan>
References: <3116391.JNS1F4DjTg@aspire.rjw.lan> <4853865.5aRGCM4CdQ@aspire.rjw.lan>
 <4690779.IRjbMOd2yB@aspire.rjw.lan>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 22 Jul 2017 00:43:28 +0300
Message-ID: <CAHp75VfqqzhzTht2YtNdiTd8gLssOr0mZbgLvzbpwcXsxTNW5g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] ACPI / PCI / PM: Rework acpi_pci_propagate_wakeup()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jul 22, 2017 at 12:30 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> The acpi_pci_propagate_wakeup() routine is there to handle cases in
> which PCI bridges (or PCIe ports) are expected to signal wakeup
> for devices below them, but currently it doesn't do that correctly.
>
> The problem is that acpi_pci_propagate_wakeup() uses
> acpi_pm_set_device_wakeup() for bridges and if that routine is
> called for multiple times to disable wakeup for the same device,
> it will disable it on the first invocation and the next calls
> will have no effect (it works analogously when called to enable
> wakeup, but that is not a problem).
>
> Now, say acpi_pci_propagate_wakeup() has been called for two
> different devices under the same bridge and it has called
> acpi_pm_set_device_wakeup() for that bridge each time.  The
> bridge is now enabled to generate wakeup signals.  Next,
> suppose that one of the devices below it resumes and
> acpi_pci_propagate_wakeup() is called to disable wakeup for that
> device.  It will then call acpi_pm_set_device_wakeup() for the bridge
> and that will effectively disable remote wakeup for all devices under
> it even though some of them may still be suspended and remote wakeup
> may be expected to work for them.
>
> To address this (arguably theoretical) issue, allow
> wakeup.enable_count under struct acpi_device to grow beyond 1 in
> certain situations.  In particular, allow that to happen in
> acpi_pci_propagate_wakeup() when wakeup is enabled or disabled
> for PCI bridges, so that wakeup is actually disabled for the
> bridge when all devices under it resume and not when just one
> of them does that.

Thanks  for an update! At least to me it's now looks better.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> -> v2: Rearrange checks in acpi_device_wakeup_enable() to reduce indentation
>           level and possibly save some unnecessary checks for max_count == 1.
>
> ---
>  drivers/acpi/device_pm.c |   46 +++++++++++++++++++++++++++++-----------------
>  drivers/pci/pci-acpi.c   |    4 ++--
>  include/acpi/acpi_bus.h  |   14 ++++++++++++--
>  3 files changed, 43 insertions(+), 21 deletions(-)
>
> Index: linux-pm/drivers/acpi/device_pm.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/device_pm.c
> +++ linux-pm/drivers/acpi/device_pm.c
> @@ -682,19 +682,8 @@ static void acpi_pm_notify_work_func(str
>
>  static DEFINE_MUTEX(acpi_wakeup_lock);
>
> -/**
> - * acpi_device_wakeup_enable - Enable wakeup functionality for device.
> - * @adev: ACPI device to enable wakeup functionality for.
> - * @target_state: State the system is transitioning into.
> - *
> - * Enable the GPE associated with @adev so that it can generate wakeup signals
> - * for the device in response to external (remote) events and enable wakeup
> - * power for it.
> - *
> - * Callers must ensure that @adev is a valid ACPI device node before executing
> - * this function.
> - */
> -static int acpi_device_wakeup_enable(struct acpi_device *adev, u32 target_state)
> +static int __acpi_device_wakeup_enable(struct acpi_device *adev,
> +                                      u32 target_state, int max_count)
>  {
>         struct acpi_device_wakeup *wakeup = &adev->wakeup;
>         acpi_status status;
> @@ -702,9 +691,12 @@ static int acpi_device_wakeup_enable(str
>
>         mutex_lock(&acpi_wakeup_lock);
>
> -       if (wakeup->enable_count > 0)
> +       if (wakeup->enable_count >= max_count)
>                 goto out;
>
> +       if (wakeup->enable_count > 0)
> +               goto inc;
> +
>         error = acpi_enable_wakeup_device_power(adev, target_state);
>         if (error)
>                 goto out;
> @@ -716,6 +708,7 @@ static int acpi_device_wakeup_enable(str
>                 goto out;
>         }
>
> +inc:
>         wakeup->enable_count++;
>
>  out:
> @@ -724,6 +717,23 @@ out:
>  }
>
>  /**
> + * acpi_device_wakeup_enable - Enable wakeup functionality for device.
> + * @adev: ACPI device to enable wakeup functionality for.
> + * @target_state: State the system is transitioning into.
> + *
> + * Enable the GPE associated with @adev so that it can generate wakeup signals
> + * for the device in response to external (remote) events and enable wakeup
> + * power for it.
> + *
> + * Callers must ensure that @adev is a valid ACPI device node before executing
> + * this function.
> + */
> +static int acpi_device_wakeup_enable(struct acpi_device *adev, u32 target_state)
> +{
> +       return __acpi_device_wakeup_enable(adev, target_state, 1);
> +}
> +
> +/**
>   * acpi_device_wakeup_disable - Disable wakeup functionality for device.
>   * @adev: ACPI device to disable wakeup functionality for.
>   *
> @@ -754,8 +764,9 @@ out:
>   * acpi_pm_set_device_wakeup - Enable/disable remote wakeup for given device.
>   * @dev: Device to enable/disable to generate wakeup events.
>   * @enable: Whether to enable or disable the wakeup functionality.
> + * @max_count: Maximum value of the enable reference counter.
>   */
> -int acpi_pm_set_device_wakeup(struct device *dev, bool enable)
> +int __acpi_pm_set_device_wakeup(struct device *dev, bool enable, int max_count)
>  {
>         struct acpi_device *adev;
>         int error;
> @@ -775,13 +786,14 @@ int acpi_pm_set_device_wakeup(struct dev
>                 return 0;
>         }
>
> -       error = acpi_device_wakeup_enable(adev, acpi_target_system_state());
> +       error = __acpi_device_wakeup_enable(adev, acpi_target_system_state(),
> +                                           max_count);
>         if (!error)
>                 dev_dbg(dev, "Wakeup enabled by ACPI\n");
>
>         return error;
>  }
> -EXPORT_SYMBOL(acpi_pm_set_device_wakeup);
> +EXPORT_SYMBOL(__acpi_pm_set_device_wakeup);
>
>  /**
>   * acpi_dev_pm_low_power - Put ACPI device into a low-power state.
> Index: linux-pm/include/acpi/acpi_bus.h
> ===================================================================
> --- linux-pm.orig/include/acpi/acpi_bus.h
> +++ linux-pm/include/acpi/acpi_bus.h
> @@ -605,7 +605,7 @@ acpi_status acpi_add_pm_notifier(struct
>  acpi_status acpi_remove_pm_notifier(struct acpi_device *adev);
>  bool acpi_pm_device_can_wakeup(struct device *dev);
>  int acpi_pm_device_sleep_state(struct device *, int *, int);
> -int acpi_pm_set_device_wakeup(struct device *dev, bool enable);
> +int __acpi_pm_set_device_wakeup(struct device *dev, bool enable, int max_count);
>  #else
>  static inline void acpi_pm_wakeup_event(struct device *dev)
>  {
> @@ -632,12 +632,22 @@ static inline int acpi_pm_device_sleep_s
>         return (m >= ACPI_STATE_D0 && m <= ACPI_STATE_D3_COLD) ?
>                 m : ACPI_STATE_D0;
>  }
> -static inline int acpi_pm_set_device_wakeup(struct device *dev, bool enable)
> +static inline int __acpi_pm_set_device_wakeup(struct device *dev, bool enable, int max_count)
>  {
>         return -ENODEV;
>  }
>  #endif
>
> +static inline int acpi_pm_set_device_wakeup(struct device *dev, bool enable)
> +{
> +       return __acpi_pm_set_device_wakeup(dev, enable, 1);
> +}
> +
> +static inline int acpi_pm_set_bridge_wakeup(struct device *dev, bool enable)
> +{
> +       return __acpi_pm_set_device_wakeup(dev, enable, INT_MAX);
> +}
> +
>  #ifdef CONFIG_ACPI_SLEEP
>  u32 acpi_target_system_state(void);
>  #else
> Index: linux-pm/drivers/pci/pci-acpi.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pci-acpi.c
> +++ linux-pm/drivers/pci/pci-acpi.c
> @@ -573,7 +573,7 @@ static int acpi_pci_propagate_wakeup(str
>  {
>         while (bus->parent) {
>                 if (acpi_pm_device_can_wakeup(&bus->self->dev))
> -                       return acpi_pm_set_device_wakeup(&bus->self->dev, enable);
> +                       return acpi_pm_set_bridge_wakeup(&bus->self->dev, enable);
>
>                 bus = bus->parent;
>         }
> @@ -581,7 +581,7 @@ static int acpi_pci_propagate_wakeup(str
>         /* We have reached the root bus. */
>         if (bus->bridge) {
>                 if (acpi_pm_device_can_wakeup(bus->bridge))
> -                       return acpi_pm_set_device_wakeup(bus->bridge, enable);
> +                       return acpi_pm_set_bridge_wakeup(bus->bridge, enable);
>         }
>         return 0;
>  }
>



-- 
With Best Regards,
Andy Shevchenko
