Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:56339 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750888AbdKFIJs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Nov 2017 03:09:48 -0500
Received: by mail-it0-f68.google.com with SMTP id r127so4111321itb.5
        for <linux-pci@vger.kernel.org>; Mon, 06 Nov 2017 00:09:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5769060.47kJca3s00@aspire.rjw.lan>
References: <3806130.B2KCK0tvef@aspire.rjw.lan> <16592954.7Zo1mAdIIH@aspire.rjw.lan>
 <5769060.47kJca3s00@aspire.rjw.lan>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 6 Nov 2017 09:09:46 +0100
Message-ID: <CAPDyKFqXqiBzoE3Bo9u9WOo3aVqvEP4s_6oyTFZ_Cy6==DxYug@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] PM / core: Add SMART_SUSPEND driver flag
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
        Kevin Hilman <khilman@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 28 October 2017 at 00:22, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Define and document a SMART_SUSPEND flag to instruct bus types and PM
> domains that the system suspend callbacks provided by the driver can
> cope with runtime-suspended devices, so from the driver's perspective
> it should be safe to leave devices in runtime suspend during system
> suspend.
>
> Setting that flag may also cause middle-layer code (bus types,
> PM domains etc.) to skip invocations of the ->suspend_late and
> ->suspend_noirq callbacks provided by the driver if the device
> is in runtime suspend at the beginning of the "late" phase of
> the system-wide suspend transition, in which case the driver's
> system-wide resume callbacks may be invoked back-to-back with
> its ->runtime_suspend callback, so the driver has to be able to
> cope with that too.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

If not too late:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>
> -> v2: Drop the changes in main.c, as the logic implemented by them
>        previously is now going to be implemented in the PCI bus type
>        and the ACPI PM domain directly.
>
> ---
>  Documentation/driver-api/pm/devices.rst |   20 ++++++++++++++++++++
>  drivers/base/power/main.c               |    3 +++
>  include/linux/pm.h                      |    8 ++++++++
>  3 files changed, 31 insertions(+)
>
> Index: linux-pm/Documentation/driver-api/pm/devices.rst
> ===================================================================
> --- linux-pm.orig/Documentation/driver-api/pm/devices.rst
> +++ linux-pm/Documentation/driver-api/pm/devices.rst
> @@ -766,6 +766,26 @@ the state of devices (possibly except fo
>  from their ``->prepare`` and ``->suspend`` callbacks (or equivalent) *before*
>  invoking device drivers' ``->suspend`` callbacks (or equivalent).
>
> +Some bus types and PM domains have a policy to resume all devices from runtime
> +suspend upfront in their ``->suspend`` callbacks, but that may not be really
> +necessary if the driver of the device can cope with runtime-suspended devices.
> +The driver can indicate that by setting ``DPM_FLAG_SMART_SUSPEND`` in
> +:c:member:`power.driver_flags` at the probe time, by passing it to the
> +:c:func:`dev_pm_set_driver_flags` helper.  That also may cause middle-layer code
> +(bus types, PM domains etc.) to skip the ``->suspend_late`` and
> +``->suspend_noirq`` callbacks provided by the driver if the device remains in
> +runtime suspend at the beginning of the ``suspend_late`` phase of system-wide
> +suspend (or in the ``poweroff_late`` phase of hibernation), when runtime PM
> +has been disabled for it, under the assumption that its state should not change
> +after that point until the system-wide transition is over.  If that happens, the
> +driver's system-wide resume callbacks, if present, may still be invoked during
> +the subsequent system-wide resume transition and the device's runtime power
> +management status may be set to "active" before enabling runtime PM for it,
> +so the driver must be prepared to cope with the invocation of its system-wide
> +resume callbacks back-to-back with its ``->runtime_suspend`` one (without the
> +intervening ``->runtime_resume`` and so on) and the final state of the device
> +must reflect the "active" status for runtime PM in that case.
> +
>  During system-wide resume from a sleep state it's easiest to put devices into
>  the full-power state, as explained in :file:`Documentation/power/runtime_pm.txt`.
>  Refer to that document for more information regarding this particular issue as
> Index: linux-pm/drivers/base/power/main.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/main.c
> +++ linux-pm/drivers/base/power/main.c
> @@ -1652,6 +1652,9 @@ static int device_prepare(struct device
>         if (dev->power.syscore)
>                 return 0;
>
> +       WARN_ON(dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND) &&
> +               !pm_runtime_enabled(dev));
> +
>         /*
>          * If a device's parent goes into runtime suspend at the wrong time,
>          * it won't be possible to resume the device.  To prevent this we
> Index: linux-pm/include/linux/pm.h
> ===================================================================
> --- linux-pm.orig/include/linux/pm.h
> +++ linux-pm/include/linux/pm.h
> @@ -558,6 +558,7 @@ struct pm_subsys_data {
>   *
>   * NEVER_SKIP: Do not skip system suspend/resume callbacks for the device.
>   * SMART_PREPARE: Check the return value of the driver's ->prepare callback.
> + * SMART_SUSPEND: No need to resume the device from runtime suspend.
>   *
>   * Setting SMART_PREPARE instructs bus types and PM domains which may want
>   * system suspend/resume callbacks to be skipped for the device to return 0 from
> @@ -565,9 +566,16 @@ struct pm_subsys_data {
>   * other words, the system suspend/resume callbacks can only be skipped for the
>   * device if its driver doesn't object against that).  This flag has no effect
>   * if NEVER_SKIP is set.
> + *
> + * Setting SMART_SUSPEND instructs bus types and PM domains which may want to
> + * runtime resume the device upfront during system suspend that doing so is not
> + * necessary from the driver's perspective.  It also may cause them to skip
> + * invocations of the ->suspend_late and ->suspend_noirq callbacks provided by
> + * the driver if they decide to leave the device in runtime suspend.
>   */
>  #define DPM_FLAG_NEVER_SKIP    BIT(0)
>  #define DPM_FLAG_SMART_PREPARE BIT(1)
> +#define DPM_FLAG_SMART_SUSPEND BIT(2)
>
>  struct dev_pm_info {
>         pm_message_t            power_state;
>
