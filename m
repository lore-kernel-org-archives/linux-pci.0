Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrbnLjBzY3yE1OyXOpG3--K+C-1BCWQtyL9S6zQ5cmdhw@mail.gmail.com>
References: <3806130.B2KCK0tvef@aspire.rjw.lan> <16592954.7Zo1mAdIIH@aspire.rjw.lan>
 <6330680.LdxjlP4uri@aspire.rjw.lan> <2932219.eEdIVn6WWf@aspire.rjw.lan> <CAPDyKFrbnLjBzY3yE1OyXOpG3--K+C-1BCWQtyL9S6zQ5cmdhw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 11 Nov 2017 00:45:47 +0100
Message-ID: <CAJZ5v0i4yFGyqAZ6QqG7q1_xNfjMNHkPk3o0WuBvwKFeM2nXeg@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] PM / core: Add LEAVE_SUSPENDED driver flag
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
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

On Fri, Nov 10, 2017 at 10:09 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 8 November 2017 at 14:25, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Define and document a new driver flag, DPM_FLAG_LEAVE_SUSPENDED, to
>> instruct the PM core and middle-layer (bus type, PM domain, etc.)
>> code that it is desirable to leave the device in runtime suspend
>> after system-wide transitions to the working state (for example,
>> the device may be slow to resume and it may be better to avoid
>> resuming it right away).
>>
>> Generally, the middle-layer code involved in the handling of the
>> device is expected to indicate to the PM core whether or not the
>> device may be left in suspend with the help of the device's
>> power.may_skip_resume status bit.  That has to happen in the "noirq"
>> phase of the preceding system suspend (or analogous) transition.
>> The middle layer is then responsible for handling the device as
>> appropriate in its "noirq" resume callback which is executed
>> regardless of whether or not the device may be left suspended, but
>> the other resume callbacks (except for ->complete) will be skipped
>> automatically by the core if the device really can be left in
>> suspend.
>
> I don't understand the reason to why you need to skip invoking resume
> callbacks to achieve this behavior, could you elaborate on that?

The reason why it is done this way is because that takes less code and
is easier (or at least less error-prone, because it avoids repeating
patterns in middle layers).

Note that the callbacks only may be skipped by the core if the middle
layer has set power.skip_resume for the device (or if the core is
handling it in patch [5/6], but that's one more step ahead still).

> Couldn't the PM domain or the middle-layer instead decide what to do?

They still can, the whole thing is a total opt-in.

But to be constructive, do you have any specific examples in mind?

> To me it sounds a bit prone to errors by skipping callbacks from the
> PM core, and I wonder if the general driver author will be able to
> understand how to use this flag properly.

This has nothing to do with general driver authors and I'm not sure
what you mean here and where you are going with this.

> That said, as the series don't include any changes for drivers making
> use of the flag, could please fold in such change as it would provide
> a more complete picture?

I've already done so, see https://patchwork.kernel.org/patch/10007349/

IMHO it's not really useful to drag this stuff (which doesn't change
BTW) along with every iteration of the core patches.

>>
>> The additional power.must_resume status bit introduced for the
>> implementation of this mechanisn is used internally by the PM core
>> to track the requirement to resume the device (which may depend on
>> its children etc).
>
> Yeah, clearly the PM core needs to be involved, because of the need of
> dealing with parent/child relations, however as kind of indicate
> above, couldn't the PM core just set some flag/status bits, which
> instructs the middle-layer and PM domain on what to do? That sounds
> like an easier approach.

No, it is not easier.  And it is backwards.

>>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> ---
>>  Documentation/driver-api/pm/devices.rst |   24 ++++++++++-
>>  drivers/base/power/main.c               |   65 +++++++++++++++++++++++++++++---
>>  include/linux/pm.h                      |   14 +++++-
>>  3 files changed, 93 insertions(+), 10 deletions(-)
>>
>> Index: linux-pm/include/linux/pm.h
>> ===================================================================
>> --- linux-pm.orig/include/linux/pm.h
>> +++ linux-pm/include/linux/pm.h
>> @@ -559,6 +559,7 @@ struct pm_subsys_data {
>>   * NEVER_SKIP: Do not skip system suspend/resume callbacks for the device.
>>   * SMART_PREPARE: Check the return value of the driver's ->prepare callback.
>>   * SMART_SUSPEND: No need to resume the device from runtime suspend.
>> + * LEAVE_SUSPENDED: Avoid resuming the device during system resume if possible.
>>   *
>>   * Setting SMART_PREPARE instructs bus types and PM domains which may want
>>   * system suspend/resume callbacks to be skipped for the device to return 0 from
>> @@ -572,10 +573,14 @@ struct pm_subsys_data {
>>   * necessary from the driver's perspective.  It also may cause them to skip
>>   * invocations of the ->suspend_late and ->suspend_noirq callbacks provided by
>>   * the driver if they decide to leave the device in runtime suspend.
>> + *
>> + * Setting LEAVE_SUSPENDED informs the PM core and middle-layer code that the
>> + * driver prefers the device to be left in runtime suspend after system resume.
>>   */
>> -#define DPM_FLAG_NEVER_SKIP    BIT(0)
>> -#define DPM_FLAG_SMART_PREPARE BIT(1)
>> -#define DPM_FLAG_SMART_SUSPEND BIT(2)
>> +#define DPM_FLAG_NEVER_SKIP            BIT(0)
>> +#define DPM_FLAG_SMART_PREPARE         BIT(1)
>> +#define DPM_FLAG_SMART_SUSPEND         BIT(2)
>> +#define DPM_FLAG_LEAVE_SUSPENDED       BIT(3)
>>
>>  struct dev_pm_info {
>>         pm_message_t            power_state;
>> @@ -597,6 +602,8 @@ struct dev_pm_info {
>>         bool                    wakeup_path:1;
>>         bool                    syscore:1;
>>         bool                    no_pm_callbacks:1;      /* Owned by the PM core */
>> +       unsigned int            must_resume:1;  /* Owned by the PM core */
>> +       unsigned int            may_skip_resume:1;      /* Set by subsystems */
>>  #else
>>         unsigned int            should_wakeup:1;
>>  #endif
>> @@ -765,6 +772,7 @@ extern int pm_generic_poweroff_late(stru
>>  extern int pm_generic_poweroff(struct device *dev);
>>  extern void pm_generic_complete(struct device *dev);
>>
>> +extern bool dev_pm_may_skip_resume(struct device *dev);
>>  extern bool dev_pm_smart_suspend_and_suspended(struct device *dev);
>>
>>  #else /* !CONFIG_PM_SLEEP */
>> Index: linux-pm/drivers/base/power/main.c
>> ===================================================================
>> --- linux-pm.orig/drivers/base/power/main.c
>> +++ linux-pm/drivers/base/power/main.c
>> @@ -528,6 +528,18 @@ static void dpm_watchdog_clear(struct dp
>>  /*------------------------- Resume routines -------------------------*/
>>
>>  /**
>> + * dev_pm_may_skip_resume - System-wide device resume optimization check.
>> + * @dev: Target device.
>> + *
>> + * Checks whether or not the device may be left in suspend after a system-wide
>> + * transition to the working state.
>> + */
>> +bool dev_pm_may_skip_resume(struct device *dev)
>> +{
>> +       return !dev->power.must_resume && pm_transition.event != PM_EVENT_RESTORE;
>> +}
>> +
>> +/**
>>   * device_resume_noirq - Execute a "noirq resume" callback for given device.
>>   * @dev: Device to handle.
>>   * @state: PM transition of the system being carried out.
>> @@ -575,6 +587,12 @@ static int device_resume_noirq(struct de
>>         error = dpm_run_callback(callback, dev, state, info);
>>         dev->power.is_noirq_suspended = false;
>>
>> +       if (dev_pm_may_skip_resume(dev)) {
>> +               pm_runtime_set_suspended(dev);
>
> According to the doc, the DPM_FLAG_LEAVE_SUSPENDED intends to leave
> the device in runtime suspend state during system resume.
> However, here you are actually trying to change its runtime PM state to that.

So the doc needs to be fixed. :-)

But I'm guessing that this just is a misunderstanding and you mean the
phrase "it may be desirable to leave some devices in runtime suspend
after [...]".  Yes, it is talking about "runtime suspend", but
actually "runtime suspend" is the only kind of "suspend" you can leave
a device in after a system transition to the working state.  It never
says that the device must have been suspended before the preceding
system transition into a sleep state started.

> Moreover, you should check the return value from
> pm_runtime_set_suspended().

This is in "noirq", so failures of that are meaningless here.

> Then I wonder, what should you do when it fails here?
>
> Perhaps a better idea is to do this in the noirq suspend phase,
> because it allows you to bail out in case pm_runtime_set_suspended()
> fails.

This doesn't make sense, sorry.

> Another option is to leave this to the middle-layer and PM domain,
> that would make it more flexible and probably also easier for them to
> deal with the error path.

So the middle layer doesn't have to set power.skip_resume.

Just don't set it if you don't like the default handling, but yes, you
will affect others this way.

Thanks,
Rafael
