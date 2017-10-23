Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <3749856.UqA8Ev4sDu@aspire.rjw.lan>
References: <3806130.B2KCK0tvef@aspire.rjw.lan> <3749856.UqA8Ev4sDu@aspire.rjw.lan>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 23 Oct 2017 21:09:04 +0200
Message-ID: <CAPDyKFqHX69BhQk5WezSdCjuNLULYucGFPrsOK6XpktFAMSZng@mail.gmail.com>
Subject: Re: [PATCH 07/12] ACPI / LPSS: Consolidate runtime PM and system
 sleep handling
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
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kevin Hilman <khilman@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 16 October 2017 at 03:29, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Move the LPSS-specific code from acpi_lpss_runtime_suspend()
> and acpi_lpss_runtime_resume() into separate functions,
> acpi_lpss_suspend() and acpi_lpss_resume(), respectively, and
> make acpi_lpss_suspend_late() and acpi_lpss_resume_early() use
> them too in order to unify the runtime PM and system sleep
> handling in the LPSS driver.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>
> This is based on an RFC I posted some time ago
> (https://patchwork.kernel.org/patch/9998147/), which didn't
> receive any comments and it depends on a couple of ACPI device PM
> patches posted recently (https://patchwork.kernel.org/patch/10006457/
> in particular).
>
> It's included in this series, because the next patch won't work without it.
>
> ---
>  drivers/acpi/acpi_lpss.c |   75 ++++++++++++++++++++---------------------------
>  1 file changed, 33 insertions(+), 42 deletions(-)
>
> Index: linux-pm/drivers/acpi/acpi_lpss.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/acpi_lpss.c
> +++ linux-pm/drivers/acpi/acpi_lpss.c
> @@ -716,40 +716,6 @@ static void acpi_lpss_dismiss(struct dev
>         acpi_dev_suspend(dev, false);
>  }
>
> -#ifdef CONFIG_PM_SLEEP
> -static int acpi_lpss_suspend_late(struct device *dev)
> -{
> -       struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
> -       int ret;
> -
> -       ret = pm_generic_suspend_late(dev);
> -       if (ret)
> -               return ret;
> -
> -       if (pdata->dev_desc->flags & LPSS_SAVE_CTX)
> -               acpi_lpss_save_ctx(dev, pdata);
> -
> -       return acpi_dev_suspend(dev, device_may_wakeup(dev));
> -}
> -
> -static int acpi_lpss_resume_early(struct device *dev)
> -{
> -       struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
> -       int ret;
> -
> -       ret = acpi_dev_resume(dev);
> -       if (ret)
> -               return ret;
> -
> -       acpi_lpss_d3_to_d0_delay(pdata);
> -
> -       if (pdata->dev_desc->flags & LPSS_SAVE_CTX)
> -               acpi_lpss_restore_ctx(dev, pdata);
> -
> -       return pm_generic_resume_early(dev);
> -}
> -#endif /* CONFIG_PM_SLEEP */
> -
>  /* IOSF SB for LPSS island */
>  #define LPSS_IOSF_UNIT_LPIOEP          0xA0
>  #define LPSS_IOSF_UNIT_LPIO1           0xAB
> @@ -835,19 +801,15 @@ static void lpss_iosf_exit_d3_state(void
>         mutex_unlock(&lpss_iosf_mutex);
>  }
>
> -static int acpi_lpss_runtime_suspend(struct device *dev)
> +static int acpi_lpss_suspend(struct device *dev, bool wakeup)
>  {
>         struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
>         int ret;
>
> -       ret = pm_generic_runtime_suspend(dev);
> -       if (ret)
> -               return ret;
> -
>         if (pdata->dev_desc->flags & LPSS_SAVE_CTX)
>                 acpi_lpss_save_ctx(dev, pdata);
>
> -       ret = acpi_dev_suspend(dev, true);
> +        ret = acpi_dev_suspend(dev, wakeup);
>
>         /*
>          * This call must be last in the sequence, otherwise PMC will return
> @@ -860,7 +822,7 @@ static int acpi_lpss_runtime_suspend(str
>         return ret;
>  }
>
> -static int acpi_lpss_runtime_resume(struct device *dev)
> +static int acpi_lpss_resume(struct device *dev)
>  {
>         struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
>         int ret;
> @@ -881,7 +843,36 @@ static int acpi_lpss_runtime_resume(stru
>         if (pdata->dev_desc->flags & LPSS_SAVE_CTX)
>                 acpi_lpss_restore_ctx(dev, pdata);
>
> -       return pm_generic_runtime_resume(dev);
> +       return 0;
> +}
> +#ifdef CONFIG_PM_SLEEP
> +static int acpi_lpss_suspend_late(struct device *dev)
> +{
> +       int ret = pm_generic_suspend_late(dev);
> +
> +       return ret ? ret : acpi_lpss_suspend(dev, device_may_wakeup(dev));
> +}
> +
> +static int acpi_lpss_resume_early(struct device *dev)
> +{
> +       int ret = acpi_lpss_resume(dev);
> +
> +       return ret ? ret : pm_generic_resume_early(dev);
> +}
> +#endif /* CONFIG_PM_SLEEP */
> +
> +static int acpi_lpss_runtime_suspend(struct device *dev)
> +{
> +       int ret = pm_generic_runtime_suspend(dev);
> +
> +       return ret ? ret : acpi_lpss_suspend(dev, true);
> +}
> +
> +static int acpi_lpss_runtime_resume(struct device *dev)
> +{
> +       int ret = acpi_lpss_resume(dev);
> +
> +       return ret ? ret : pm_generic_runtime_resume(dev);
>  }
>  #endif /* CONFIG_PM */
>
>
>
