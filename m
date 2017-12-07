Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:44001 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752078AbdLGTow (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Dec 2017 14:44:52 -0500
Received: by mail-it0-f67.google.com with SMTP id u62so17509417ita.2
        for <linux-pci@vger.kernel.org>; Thu, 07 Dec 2017 11:44:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <3600031.yTsliOITBg@aspire.rjw.lan>
References: <3600031.yTsliOITBg@aspire.rjw.lan>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 7 Dec 2017 20:44:51 +0100
Message-ID: <CAPDyKFpyfMTw9vdSDHxarZquSRA9zU9aMdb-pkzhMWKrFGxayw@mail.gmail.com>
Subject: Re: [PATCH] PM / sleep: Avoid excess pm_runtime_enable() calls in device_resume()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 7 December 2017 at 03:26, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Middle-layer code doing suspend-time optimizations for devices with
> the DPM_FLAG_SMART_SUSPEND flag set (currently, the PCI bus type and
> the ACPI PM domain) needs to make the core skip ->thaw_early and
> ->thaw callbacks for those devices in some cases and it sets the
> power.direct_complete flag for them for this purpose.
>
> However, it turns out that setting power.direct_complete outside of
> the PM core is a bad idea as it triggers an excessive invocation of
> pm_runtime_enable() in device_resume().

Do we need to clarify the comment about the flag in pm.h?

Or is "/* Owned by the PM core */" sufficient?

>
> For this reason, provide a helper to clear power.is_late_suspended
> and power.is_suspended to be invoked by the middle-layer code in
> question instead of setting power.direct_complete and make that code
> call the new helper.
>
> Fixes: c4b65157aeef (PCI / PM: Take SMART_SUSPEND driver flag into account)
> Fixes: 05087360fd7a (ACPI / PM: Take SMART_SUSPEND driver flag into account)
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro,org>

Kind regards
Uffe

> ---
>  drivers/acpi/device_pm.c  |    2 +-
>  drivers/base/power/main.c |   15 +++++++++++++++
>  drivers/pci/pci-driver.c  |    2 +-
>  include/linux/pm.h        |    1 +
>  4 files changed, 18 insertions(+), 2 deletions(-)
>
> Index: linux-pm/include/linux/pm.h
> ===================================================================
> --- linux-pm.orig/include/linux/pm.h
> +++ linux-pm/include/linux/pm.h
> @@ -765,6 +765,7 @@ extern int pm_generic_poweroff_late(stru
>  extern int pm_generic_poweroff(struct device *dev);
>  extern void pm_generic_complete(struct device *dev);
>
> +extern void dev_pm_skip_next_resume_phases(struct device *dev);
>  extern bool dev_pm_smart_suspend_and_suspended(struct device *dev);
>
>  #else /* !CONFIG_PM_SLEEP */
> Index: linux-pm/drivers/base/power/main.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/main.c
> +++ linux-pm/drivers/base/power/main.c
> @@ -526,6 +526,21 @@ static void dpm_watchdog_clear(struct dp
>  /*------------------------- Resume routines -------------------------*/
>
>  /**
> + * dev_pm_skip_next_resume_phases - Skip next system resume phases for device.
> + * @dev: Target device.
> + *
> + * Make the core skip the "early resume" and "resume" phases for @dev.
> + *
> + * This function can be called by middle-layer code during the "noirq" phase of
> + * system resume if necessary, but not by device drivers.
> + */
> +void dev_pm_skip_next_resume_phases(struct device *dev)
> +{
> +       dev->power.is_late_suspended = false;
> +       dev->power.is_suspended = false;
> +}
> +
> +/**
>   * device_resume_noirq - Execute a "noirq resume" callback for given device.
>   * @dev: Device to handle.
>   * @state: PM transition of the system being carried out.
> Index: linux-pm/drivers/pci/pci-driver.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pci-driver.c
> +++ linux-pm/drivers/pci/pci-driver.c
> @@ -999,7 +999,7 @@ static int pci_pm_thaw_noirq(struct devi
>          * the subsequent "thaw" callbacks for the device.
>          */
>         if (dev_pm_smart_suspend_and_suspended(dev)) {
> -               dev->power.direct_complete = true;
> +               dev_pm_skip_next_resume_phases(dev);
>                 return 0;
>         }
>
> Index: linux-pm/drivers/acpi/device_pm.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/device_pm.c
> +++ linux-pm/drivers/acpi/device_pm.c
> @@ -1138,7 +1138,7 @@ int acpi_subsys_thaw_noirq(struct device
>          * skip all of the subsequent "thaw" callbacks for the device.
>          */
>         if (dev_pm_smart_suspend_and_suspended(dev)) {
> -               dev->power.direct_complete = true;
> +               dev_pm_skip_next_resume_phases(dev);
>                 return 0;
>         }
>
>
