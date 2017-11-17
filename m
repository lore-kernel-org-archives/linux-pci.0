Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2654404.6YT5rmSnae@aspire.rjw.lan>
References: <3806130.B2KCK0tvef@aspire.rjw.lan> <5556673.MXo6XDN1f4@aspire.rjw.lan>
 <CAPDyKFpzSd4zwW_awuxuim0gzyKV5s9dm66X+szsSUKRnBakbA@mail.gmail.com> <2654404.6YT5rmSnae@aspire.rjw.lan>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 17 Nov 2017 07:11:08 +0100
Message-ID: <CAPDyKFo4gE6O=xMoS2Phe0kNgNUGBffy1hxT3iPrY71ieGcumQ@mail.gmail.com>
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

[...]

>> > +++ linux-pm/include/linux/pm.h
>> > @@ -559,6 +559,7 @@ struct pm_subsys_data {
>> >   * NEVER_SKIP: Do not skip system suspend/resume callbacks for the device.
>> >   * SMART_PREPARE: Check the return value of the driver's ->prepare callback.
>> >   * SMART_SUSPEND: No need to resume the device from runtime suspend.
>> > + * LEAVE_SUSPENDED: Avoid resuming the device during system resume if possible.
>> >   *
>> >   * Setting SMART_PREPARE instructs bus types and PM domains which may want
>> >   * system suspend/resume callbacks to be skipped for the device to return 0 from
>> > @@ -572,10 +573,14 @@ struct pm_subsys_data {
>> >   * necessary from the driver's perspective.  It also may cause them to skip
>> >   * invocations of the ->suspend_late and ->suspend_noirq callbacks provided by
>> >   * the driver if they decide to leave the device in runtime suspend.
>> > + *
>> > + * Setting LEAVE_SUSPENDED informs the PM core and middle-layer code that the
>> > + * driver prefers the device to be left in runtime suspend after system resume.
>> >   */
>>
>> Question: Can LEAVE_SUSPENDED and NEVER_SKIP be valid combination? I
>> guess not!? Should we validate for wrong combinations?
>
> Why not?  There's no real overlap between them.

Except that NEVER_SKIP, documentation wise, tells you that your
suspend and resume callbacks will never be skipped. :-)

[...]

>> Second, have you considered setting the default value of
>> dev->power.may_skip_resume to true?
>
> Yes.
>
>> That would means the subsystem
>> instead need to implement an opt-out method. I am thinking that it may
>> not be an issue, since we anyway at this point, don't have drivers
>> using the LEAVE_SUSPENDED flag.
>
> Opt-out doesn't work because of the need to invoke the "noirq" callbacks.

I am not sure I follow that.

Whatever needs to be fixed on the subsystem level, that could be done
before the driver starts using the LEAVE_SUSPENDED flag. No?

>
>> [...]
>>
>> > +However, it may be desirable to leave some devices in runtime suspend after
>> > +system transitions to the working state and device drivers can use the
>> > +``DPM_FLAG_LEAVE_SUSPENDED`` flag to indicate to the PM core (and middle-layer
>> > +code) that this is the case.  Whether or not the devices will actually be left
>> > +in suspend may depend on their state before the given system suspend-resume
>> > +cycle and on the type of the system transition under way.  In particular,
>> > +devices are not left suspended if that transition is a restore from hibernation,
>> > +as device states are not guaranteed to be reflected by the information stored in
>> > +the hibernation image in that case.
>> > +
>> > +The middle-layer code involved in the handling of the device has to indicate to
>> > +the PM core if the device may be left in suspend with the help of its
>> > +:c:member:`power.may_skip_resume` status bit.  That has to happen in the "noirq"
>> > +phase of the preceding system-wide suspend (or analogous) transition.  The
>>
>> Does it have to be managed in the "noirq" phase? Wouldn't be perfectly
>> okay do this in the suspend and suspend_late phases as well?
>
> The wording is slightly misleading I think.
>
> In fact technically may_skip_resume may be set earlier, but the core checks it
> in the "noirq" phase only anyway.

Yeah, okay.

Kind regards
Uffe
