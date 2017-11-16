Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5556673.MXo6XDN1f4@aspire.rjw.lan>
References: <3806130.B2KCK0tvef@aspire.rjw.lan> <6330680.LdxjlP4uri@aspire.rjw.lan>
 <4184911.zoJM7jZeH4@aspire.rjw.lan> <5556673.MXo6XDN1f4@aspire.rjw.lan>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 16 Nov 2017 16:10:16 +0100
Message-ID: <CAPDyKFpzSd4zwW_awuxuim0gzyKV5s9dm66X+szsSUKRnBakbA@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] PM / core: Add LEAVE_SUSPENDED driver flag
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
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12 November 2017 at 01:37, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Define and document a new driver flag, DPM_FLAG_LEAVE_SUSPENDED, to
> instruct the PM core and middle-layer (bus type, PM domain, etc.)
> code that it is desirable to leave the device in runtime suspend
> after system-wide transitions to the working state (for example,
> the device may be slow to resume and it may be better to avoid
> resuming it right away).
>
> Generally, the middle-layer code involved in the handling of the
> device is expected to indicate to the PM core whether or not the
> device may be left in suspend with the help of the device's
> power.may_skip_resume status bit.  That has to happen in the "noirq"
> phase of the preceding system suspend (or analogous) transition.
> The middle layer is then responsible for handling the device as
> appropriate in its "noirq" resume callback which is executed
> regardless of whether or not the device may be left suspended, but
> the other resume callbacks (except for ->complete) will be skipped
> automatically by the core if the device really can be left in
> suspend.
>
> The additional power.must_resume status bit introduced for the
> implementation of this mechanisn is used internally by the PM core
> to track the requirement to resume the device (which may depend on
> its children etc).
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>
> v2 -> v3: Take dev->power.usage_count when updating power.must_resume in
>           __device_suspend_noirq().
>
> ---
>  Documentation/driver-api/pm/devices.rst |   24 ++++++++++-
>  drivers/base/power/main.c               |   66 +++++++++++++++++++++++++++++---
>  drivers/base/power/runtime.c            |    9 ++--
>  include/linux/pm.h                      |   14 +++++-
>  include/linux/pm_runtime.h              |    9 ++--
>  5 files changed, 104 insertions(+), 18 deletions(-)
>
> Index: linux-pm/include/linux/pm.h
> ===================================================================
> --- linux-pm.orig/include/linux/pm.h
> +++ linux-pm/include/linux/pm.h
> @@ -559,6 +559,7 @@ struct pm_subsys_data {
>   * NEVER_SKIP: Do not skip system suspend/resume callbacks for the device.
>   * SMART_PREPARE: Check the return value of the driver's ->prepare callback.
>   * SMART_SUSPEND: No need to resume the device from runtime suspend.
> + * LEAVE_SUSPENDED: Avoid resuming the device during system resume if possible.
>   *
>   * Setting SMART_PREPARE instructs bus types and PM domains which may want
>   * system suspend/resume callbacks to be skipped for the device to return 0 from
> @@ -572,10 +573,14 @@ struct pm_subsys_data {
>   * necessary from the driver's perspective.  It also may cause them to skip
>   * invocations of the ->suspend_late and ->suspend_noirq callbacks provided by
>   * the driver if they decide to leave the device in runtime suspend.
> + *
> + * Setting LEAVE_SUSPENDED informs the PM core and middle-layer code that the
> + * driver prefers the device to be left in runtime suspend after system resume.
>   */

Question: Can LEAVE_SUSPENDED and NEVER_SKIP be valid combination? I
guess not!? Should we validate for wrong combinations?

[...]

>  /**
>   * __device_suspend_noirq - Execute a "noirq suspend" callback for given device.
>   * @dev: Device to handle.
> @@ -1127,10 +1161,28 @@ static int __device_suspend_noirq(struct
>         }
>
>         error = dpm_run_callback(callback, dev, state, info);
> -       if (!error)
> -               dev->power.is_noirq_suspended = true;
> -       else
> +       if (error) {
>                 async_error = error;
> +               goto Complete;
> +       }
> +
> +       dev->power.is_noirq_suspended = true;
> +
> +       if (dev_pm_test_driver_flags(dev, DPM_FLAG_LEAVE_SUSPENDED)) {
> +               /*
> +                * The only safe strategy here is to require that if the device
> +                * may not be left in suspend, resume callbacks must be invoked
> +                * for it.
> +                */
> +               dev->power.must_resume = dev->power.must_resume ||
> +                                       !dev->power.may_skip_resume ||
> +                                       atomic_read(&dev->power.usage_count);

dev->power.usage_count is always > 0 at this point, meaning that
dev->power.must_resume always becomes true. :-)

You should rather use "atomic_read(&dev->power.usage_count) > 1".

> +       } else {
> +               dev->power.must_resume = true;
> +       }
> +
> +       if (dev->power.must_resume)
> +               dpm_superior_set_must_resume(dev);
>
>  Complete:
>         complete_all(&dev->power.completion);
> @@ -1487,6 +1539,9 @@ static int __device_suspend(struct devic
>                 dev->power.direct_complete = false;
>         }
>
> +       dev->power.may_skip_resume = false;
> +       dev->power.must_resume = false;
> +

First, these assignment could be bypassed if the direct_complete path
is used. Perhaps it's more robust to reset these flags already in
device_prepare().

Second, have you considered setting the default value of
dev->power.may_skip_resume to true? That would means the subsystem
instead need to implement an opt-out method. I am thinking that it may
not be an issue, since we anyway at this point, don't have drivers
using the LEAVE_SUSPENDED flag.

[...]

> +However, it may be desirable to leave some devices in runtime suspend after
> +system transitions to the working state and device drivers can use the
> +``DPM_FLAG_LEAVE_SUSPENDED`` flag to indicate to the PM core (and middle-layer
> +code) that this is the case.  Whether or not the devices will actually be left
> +in suspend may depend on their state before the given system suspend-resume
> +cycle and on the type of the system transition under way.  In particular,
> +devices are not left suspended if that transition is a restore from hibernation,
> +as device states are not guaranteed to be reflected by the information stored in
> +the hibernation image in that case.
> +
> +The middle-layer code involved in the handling of the device has to indicate to
> +the PM core if the device may be left in suspend with the help of its
> +:c:member:`power.may_skip_resume` status bit.  That has to happen in the "noirq"
> +phase of the preceding system-wide suspend (or analogous) transition.  The

Does it have to be managed in the "noirq" phase? Wouldn't be perfectly
okay do this in the suspend and suspend_late phases as well?

> +middle layer is then responsible for handling the device as appropriate in its
> +"noirq" resume callback, which is executed regardless of whether or not the
> +device may be left suspended, but the other resume callbacks (except for
> +``->complete``) will be skipped automatically by the PM core if the device
> +really can be left in suspend.
>

Kind regards
Uffe
