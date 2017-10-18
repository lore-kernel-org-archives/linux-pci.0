Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2890181.vdGMMavi5M@aspire.rjw.lan>
References: <3806130.B2KCK0tvef@aspire.rjw.lan> <1591167.zlNa3zLfmM@aspire.rjw.lan>
 <CAPDyKFqYVjd2zmixQyJ43ZLdXeQZ-7NcLZ66+ci4VT8-q_avPA@mail.gmail.com> <2890181.vdGMMavi5M@aspire.rjw.lan>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 18 Oct 2017 16:11:33 +0200
Message-ID: <CAPDyKFozJtSHxxBEFtC+ofJ4XUyQjqUundPs81JATT=WfjXoYA@mail.gmail.com>
Subject: Re: [PATCH 0/12] PM / sleep: Driver flags for system suspend/resume
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
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[...]

>>
>> The reason why pm_runtime_force_* needs to respects the hierarchy of
>> the RPM callbacks, is because otherwise it can't safely update the
>> runtime PM status of the device.
>
> I'm not sure I follow this requirement.  Why is that so?

If the PM domain controls some resources for the device in its RPM
callbacks and the driver controls some other resources in its RPM
callbacks - then these resources needs to be managed together.

This follows the behavior of when a regular call to
pm_runtime_get|put(), triggers the RPM callbacks to be invoked.

>
>> And updating the runtime PM status of
>> the device is required to manage the optimized behavior during system
>> resume (avoiding to unnecessary resume devices).
>
> Well, OK.  The runtime PM status of the device after system resume should
> better reflect its physical state.
>
> [The physical state of the device may not be under the control of the
> kernel in some cases, like in S3 resume on some systems that reset
> devices in the firmware and so on, but let's set that aside.]
>
> However, for the runtime PM status of the device may still reflect its state
> if, say, a ->resume_early of the middle layer is called during resume along
> with a driver's ->runtime_resume.  That still can produce the right state
> of the device and all depends on the middle layer.
>
> On the other hand, as I said before, using a middle-layer ->runtime_suspend
> during a system sleep transition may be outright incorrect, say if device
> wakeup settings need to be adjusted by the middle layer (which is the
> case for some of them).
>
> Of course, if the middle layer expects the driver to point its
> system-wide PM callbacks to pm_runtime_force_*, then that's how it goes,
> but the drivers working with this particular middle layer generally
> won't work with other middle layers and may interact incorrectly
> with parents and/or children using the other middle layers.
>
> I guess the problem boils down to having a common set of expectations
> on the driver side and on the middle layer side allowing different
> combinations of these to work together.

Yes!

>
>> Besides the AMBA case, I also realized that we are dealing with PM
>> clocks in the genpd case. For this, genpd relies on the that runtime
>> PM status of the device properly reflects the state of the HW, during
>> system-wide PM.
>>
>> In other words, if the driver would change the runtime PM status of
>> the device, without respecting the hierarchy of the runtime PM
>> callbacks, it would lead to that genpd starts taking wrong decisions
>> while managing the PM clocks during system-wide PM. So in case you
>> intend to change pm_runtime_force_* this needs to be addressed too.
>
> I've just looked at the genpd code and quite frankly I'm not sure how this
> works, but I'll figure this out. :-)

You may think of it as genpd's RPM callback controls some device
clocks, while the driver control some other device resources (pinctrl
for example) from its RPM callback.

These resources needs to managed together, similar to as I described above.

[...]

>> Absolutely agree about the different wake-up settings. However, these
>> issues can be addressed also when using pm_runtime_force_*, at least
>> in general, but then not for PCI.
>
> Well, not for the ACPI PM domain too.
>
> In general, not if the wakeup settings are adjusted by the middle layer.

Correct!

To use pm_runtime_force* for these cases, one would need some
additional information exchange between the driver and the
middle-layer.

>
>> Regarding hibernation, honestly that's not really my area of
>> expertise. Although, I assume the middle-layer and driver can treat
>> that as a separate case, so if it's not suitable to use
>> pm_runtime_force* for that case, then they shouldn't do it.
>
> Well, agreed.
>
> In some simple cases, though, driver callbacks can be reused for hibernation
> too, so it would be good to have a common way to do that too, IMO.

Okay, that makes sense!

>
>> >
>> > Also, quite so often other middle layers interact with PCI directly or
>> > indirectly (eg. a platform device may be a child or a consumer of a PCI
>> > device) and some optimizations need to take that into account (eg. parents
>> > generally need to be accessible when their childres are resumed and so on).
>>
>> A device's parent becomes informed when changing the runtime PM status
>> of the device via pm_runtime_force_suspend|resume(), as those calls
>> pm_runtime_set_suspended|active().
>
> This requires the parent driver or middle layer to look at the reference
> counter and understand it the same way as pm_runtime_force_*.
>
>> In case that isn't that sufficient, what else is needed? Perhaps you can
>> point me to an example so I can understand better?
>
> Say you want to leave the parent suspended after system resume, but the
> child drivers use pm_runtime_force_suspend|resume().  The parent would then
> need to use pm_runtime_force_suspend|resume() too, no?

Actually no.

Currently the other options of "deferring resume" (not using
pm_runtime_force_*), is either using the "direct_complete" path or
similar to the approach you took for the i2c designware driver.

Both cases should play nicely in combination of a child being managed
by pm_runtime_force_*. That's because only when the parent device is
kept runtime suspended during system suspend, resuming can be
deferred.

That means, if the resume of the parent is deferred, so will the also
the resume of the child.

>
>> For a PCI consumer device those will of course have to play by the rules of PCI.
>>
>> >
>> > Moreover, the majority of the "other subsystems/middle-layers" you've talked
>> > about so far don't provide any PM callbacks to be invoked by pm_runtime_force_*,
>> > so question is how representative they really are.
>>
>> That's the point. We know pm_runtime_force_* works nicely for the
>> trivial middle-layer cases.
>
> In which cases the middle-layer callbacks don't exist, so it's just like
> reusing driver callbacks directly. :-)
>
>> For the more complex cases, we need something additional/different.
>
> Something different.
>
> But overall, as I said, this is about common expectations.
>
> Today, some middle layers expect drivers to point their callback pointers
> to the same routine in order to resue it (PCI, ACPI bus type), some of them
> expect pm_runtime_force_suspend|resume() to be used (AMBA, maybe genpd),
> and some of them have no expectations at all.
>
> There needs to be a common ground in that area for drivers to be able to
> work with different middle layers.

Yes, reaching that point would be great, we should definitively aim for that!

[...]

Kind regards
Uffe
