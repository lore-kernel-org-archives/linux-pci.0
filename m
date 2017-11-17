Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAPDyKFo4gE6O=xMoS2Phe0kNgNUGBffy1hxT3iPrY71ieGcumQ@mail.gmail.com>
References: <3806130.B2KCK0tvef@aspire.rjw.lan> <5556673.MXo6XDN1f4@aspire.rjw.lan>
 <CAPDyKFpzSd4zwW_awuxuim0gzyKV5s9dm66X+szsSUKRnBakbA@mail.gmail.com>
 <2654404.6YT5rmSnae@aspire.rjw.lan> <CAPDyKFo4gE6O=xMoS2Phe0kNgNUGBffy1hxT3iPrY71ieGcumQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 17 Nov 2017 14:18:55 +0100
Message-ID: <CAJZ5v0ibqqUZ0M1_GKCkGj_E+2DQQMOLAVTyPd7mSJDAypkHjQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] PM / core: Add LEAVE_SUSPENDED driver flag
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

On Fri, Nov 17, 2017 at 7:11 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> [...]
>
>>> > +++ linux-pm/include/linux/pm.h
>>> > @@ -559,6 +559,7 @@ struct pm_subsys_data {
>>> >   * NEVER_SKIP: Do not skip system suspend/resume callbacks for the device.
>>> >   * SMART_PREPARE: Check the return value of the driver's ->prepare callback.
>>> >   * SMART_SUSPEND: No need to resume the device from runtime suspend.
>>> > + * LEAVE_SUSPENDED: Avoid resuming the device during system resume if possible.
>>> >   *
>>> >   * Setting SMART_PREPARE instructs bus types and PM domains which may want
>>> >   * system suspend/resume callbacks to be skipped for the device to return 0 from
>>> > @@ -572,10 +573,14 @@ struct pm_subsys_data {
>>> >   * necessary from the driver's perspective.  It also may cause them to skip
>>> >   * invocations of the ->suspend_late and ->suspend_noirq callbacks provided by
>>> >   * the driver if they decide to leave the device in runtime suspend.
>>> > + *
>>> > + * Setting LEAVE_SUSPENDED informs the PM core and middle-layer code that the
>>> > + * driver prefers the device to be left in runtime suspend after system resume.
>>> >   */
>>>
>>> Question: Can LEAVE_SUSPENDED and NEVER_SKIP be valid combination? I
>>> guess not!? Should we validate for wrong combinations?
>>
>> Why not?  There's no real overlap between them.
>
> Except that NEVER_SKIP, documentation wise, tells you that your
> suspend and resume callbacks will never be skipped. :-)

You mean the comment in pm.h I suppose?  Yes, it isn't precise enough.

The proper documentation in devices.rst is less ambiguous, though. :-)

> [...]
>
>>> Second, have you considered setting the default value of
>>> dev->power.may_skip_resume to true?
>>
>> Yes.
>>
>>> That would means the subsystem
>>> instead need to implement an opt-out method. I am thinking that it may
>>> not be an issue, since we anyway at this point, don't have drivers
>>> using the LEAVE_SUSPENDED flag.
>>
>> Opt-out doesn't work because of the need to invoke the "noirq" callbacks.
>
> I am not sure I follow that.
>
> Whatever needs to be fixed on the subsystem level, that could be done
> before the driver starts using the LEAVE_SUSPENDED flag. No?

That requires a bit of explanation, sorry for being overly concise.

The core calls ->resume_noirq from the middle layer regardless of
whether or not the device will be left suspended, so the
->resume_noirq cannot do arbitrary things to it.  Setting
may_skip_resume by the middle layer tells the core that the middle
layer is ready for that and is going to cooperate.  If may_skip_resume
had been set by default, that piece of information would have been
missing.

Thanks,
Rafael
