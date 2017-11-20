Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:35817 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751158AbdKTNm1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Nov 2017 08:42:27 -0500
Received: by mail-it0-f66.google.com with SMTP id u132so11820221ita.0
        for <linux-pci@vger.kernel.org>; Mon, 20 Nov 2017 05:42:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5730411.DndCTChqpV@aspire.rjw.lan>
References: <3806130.B2KCK0tvef@aspire.rjw.lan> <4184911.zoJM7jZeH4@aspire.rjw.lan>
 <1917233.X2U0QN21my@aspire.rjw.lan> <5730411.DndCTChqpV@aspire.rjw.lan>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 20 Nov 2017 14:42:26 +0100
Message-ID: <CAPDyKFq0HGm7h_OFOwd5sRz+3_ZseNFTC-fi8c2qJVW4ZkOaHA@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] PM / core: Direct handling of DPM_FLAG_LEAVE_SUSPENDED
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

On 18 November 2017 at 15:41, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Make the PM core handle DPM_FLAG_LEAVE_SUSPENDED directly for
> devices whose "noirq", "late" and "early" driver callbacks are
> invoked directly by it.

This indicates that your target for this particular change isn't
ACPI/PCI, but instead this aims to be a more generic solution to be
able to optimize the resume path for devices.

Assuming, this is the case, I don't think this is good enough as I
pointed out [1] earlier. Simply because it isn't as flexible as is
required - to really be able cover generic cases.

>
> Namely, make it skip all of the system-wide resume callbacks for
> such devices with DPM_FLAG_LEAVE_SUSPENDED set if they are in
> runtime suspend during the "noirq" phase of system-wide suspend
> (or analogous) transitions or the system transition under way is
> a proper suspend (rather than anything related to hibernation) and
> the device's wakeup settings are compatible with runtime PM (that
> is, the device cannot generate wakeup signals at all or it is
> allowed to wake up the system from sleep).

As I pointed out by submitting another patch [2], device_may_wakeup()
doesn't really tell whether the wakeup is configured as "in-band" or
"out-of-band". That knowledge is known by the driver and the subsystem
layer - and for that reason I don't think the PM core shall base
generic decisions like this on it.

No comments on the code, so far. :-)

Kind regards
Uffe

[1]
https://www.spinics.net/lists/linux-pci/msg66502.html
[2]
https://patchwork.kernel.org/patch/10056323/

>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> v3 -> v4: Rebase on the v4 of patch [1/6], add a forward declaration of
>           dpm_subsys_suspend_late_cb() dropped from the [4/6].
>
> v2 -> v3: Rebase on the v3 of patch [1/6].
>
> ---
>  Documentation/driver-api/pm/devices.rst |    9 +++++
>  drivers/base/power/main.c               |   51 ++++++++++++++++++++++++++++----
>  2 files changed, 55 insertions(+), 5 deletions(-)
>
> Index: linux-pm/drivers/base/power/main.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/main.c
> +++ linux-pm/drivers/base/power/main.c
> @@ -525,6 +525,10 @@ static void dpm_watchdog_clear(struct dp
>  #define dpm_watchdog_clear(x)
>  #endif
>
> +static pm_callback_t dpm_subsys_suspend_late_cb(struct device *dev,
> +                                               pm_message_t state,
> +                                               const char **info_p);
> +
>  /*------------------------- Resume routines -------------------------*/
>
>  /**
> @@ -581,6 +585,7 @@ static int device_resume_noirq(struct de
>  {
>         pm_callback_t callback;
>         const char *info;
> +       bool skip_resume;
>         int error = 0;
>
>         TRACE_DEVICE(dev);
> @@ -594,17 +599,27 @@ static int device_resume_noirq(struct de
>
>         dpm_wait_for_superior(dev, async);
>
> +       skip_resume = dev_pm_may_skip_resume(dev);
> +
>         callback = dpm_subsys_resume_noirq_cb(dev, state, &info);
> +       if (callback)
> +               goto Run;
> +
> +       if (skip_resume)
> +               goto Skip;
>
>         if (!callback && dev->driver && dev->driver->pm) {
>                 info = "noirq driver ";
>                 callback = pm_noirq_op(dev->driver->pm, state);
>         }
>
> +Run:
>         error = dpm_run_callback(callback, dev, state, info);
> +
> +Skip:
>         dev->power.is_noirq_suspended = false;
>
> -       if (dev_pm_may_skip_resume(dev)) {
> +       if (skip_resume) {
>                 /*
>                  * The device is going to be left in suspend, but it might not
>                  * have been in runtime suspend before the system suspended, so
> @@ -617,7 +632,7 @@ static int device_resume_noirq(struct de
>                 dev->power.is_suspended = false;
>         }
>
> - Out:
> +Out:
>         complete_all(&dev->power.completion);
>         TRACE_RESUME(error);
>         return error;
> @@ -1193,6 +1208,7 @@ static int __device_suspend_noirq(struct
>  {
>         pm_callback_t callback;
>         const char *info;
> +       bool direct_cb = false;
>         int error = 0;
>
>         TRACE_DEVICE(dev);
> @@ -1212,12 +1228,17 @@ static int __device_suspend_noirq(struct
>                 goto Complete;
>
>         callback = dpm_subsys_suspend_noirq_cb(dev, state, &info);
> +       if (callback)
> +               goto Run;
>
> -       if (!callback && dev->driver && dev->driver->pm) {
> +       direct_cb = true;
> +
> +       if (dev->driver && dev->driver->pm) {
>                 info = "noirq driver ";
>                 callback = pm_noirq_op(dev->driver->pm, state);
>         }
>
> +Run:
>         error = dpm_run_callback(callback, dev, state, info);
>         if (error) {
>                 async_error = error;
> @@ -1227,13 +1248,33 @@ static int __device_suspend_noirq(struct
>         dev->power.is_noirq_suspended = true;
>
>         if (dev_pm_test_driver_flags(dev, DPM_FLAG_LEAVE_SUSPENDED)) {
> +               pm_message_t resume_msg = resume_event(state);
> +               bool skip_resume;
> +
> +               if (direct_cb &&
> +                   !dpm_subsys_suspend_late_cb(dev, state, NULL) &&
> +                   !dpm_subsys_resume_early_cb(dev, resume_msg, NULL) &&
> +                   !dpm_subsys_resume_noirq_cb(dev, resume_msg, NULL)) {
> +                       /*
> +                        * If all of the device driver's "noirq", "late" and
> +                        * "early" callbacks are invoked directly by the core,
> +                        * the decision to allow the device to stay in suspend
> +                        * can be based on its current runtime PM status and its
> +                        * wakeup settings.
> +                        */
> +                       skip_resume = pm_runtime_status_suspended(dev) ||
> +                               (resume_msg.event == PM_EVENT_RESUME &&
> +                                (!device_can_wakeup(dev) ||
> +                                 device_may_wakeup(dev)));
> +               } else {
> +                       skip_resume = dev->power.may_skip_resume;
> +               }
>                 /*
>                  * The only safe strategy here is to require that if the device
>                  * may not be left in suspend, resume callbacks must be invoked
>                  * for it.
>                  */
> -               dev->power.must_resume = dev->power.must_resume ||
> -                                       !dev->power.may_skip_resume ||
> +               dev->power.must_resume = dev->power.must_resume || !skip_resume ||
>                                         atomic_read(&dev->power.usage_count) > 1;
>         } else {
>                 dev->power.must_resume = true;
> Index: linux-pm/Documentation/driver-api/pm/devices.rst
> ===================================================================
> --- linux-pm.orig/Documentation/driver-api/pm/devices.rst
> +++ linux-pm/Documentation/driver-api/pm/devices.rst
> @@ -814,3 +814,12 @@ middle layer is then responsible for han
>  whether or not the device is left suspended, but the other resume callbacks
>  (except for ``->complete``) will be skipped automatically by the PM core if the
>  device really can be left in suspend.
> +
> +For devices whose "noirq", "late" and "early" driver callbacks are invoked
> +directly by the PM core, all of the system-wide resume callbacks are skipped if
> +``DPM_FLAG_LEAVE_SUSPENDED`` is set and the device is in runtime suspend during
> +the ``suspend_noirq`` (or analogous) phase or the transition under way is a
> +proper system suspend (rather than anything related to hibernation) and the
> +device's wakeup settings are suitable for runtime PM (that is, it cannot
> +generate wakeup signals at all or it is allowed to wake up the system from
> +sleep).
>
