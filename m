Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2654404.6YT5rmSnae@aspire.rjw.lan>
References: <3806130.B2KCK0tvef@aspire.rjw.lan> <5556673.MXo6XDN1f4@aspire.rjw.lan>
 <CAPDyKFpzSd4zwW_awuxuim0gzyKV5s9dm66X+szsSUKRnBakbA@mail.gmail.com> <2654404.6YT5rmSnae@aspire.rjw.lan>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 17 Nov 2017 13:45:16 +0100
Message-ID: <CAJZ5v0iAC+NoiSs5mMvt37mVtyG+2qp=cap40Ju6y+UG44TJSQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] PM / core: Add LEAVE_SUSPENDED driver flag
To: Ulf Hansson <ulf.hansson@linaro.org>
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
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 17, 2017 at 12:07 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Thursday, November 16, 2017 4:10:16 PM CET Ulf Hansson wrote:
>> On 12 November 2017 at 01:37, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> >
>> > Define and document a new driver flag, DPM_FLAG_LEAVE_SUSPENDED, to
>> > instruct the PM core and middle-layer (bus type, PM domain, etc.)
>> > code that it is desirable to leave the device in runtime suspend
>> > after system-wide transitions to the working state (for example,
>> > the device may be slow to resume and it may be better to avoid
>> > resuming it right away).
>> >
>> > Generally, the middle-layer code involved in the handling of the
>> > device is expected to indicate to the PM core whether or not the
>> > device may be left in suspend with the help of the device's
>> > power.may_skip_resume status bit.  That has to happen in the "noirq"
>> > phase of the preceding system suspend (or analogous) transition.
>> > The middle layer is then responsible for handling the device as
>> > appropriate in its "noirq" resume callback which is executed
>> > regardless of whether or not the device may be left suspended, but
>> > the other resume callbacks (except for ->complete) will be skipped
>> > automatically by the core if the device really can be left in
>> > suspend.
>> >
>> > The additional power.must_resume status bit introduced for the
>> > implementation of this mechanisn is used internally by the PM core
>> > to track the requirement to resume the device (which may depend on
>> > its children etc).
>> >
>> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> > ---
>> >
>> > v2 -> v3: Take dev->power.usage_count when updating power.must_resume in
>> >           __device_suspend_noirq().
>> >
>> > ---

[...]

>> > +       } else {
>> > +               dev->power.must_resume = true;
>> > +       }
>> > +
>> > +       if (dev->power.must_resume)
>> > +               dpm_superior_set_must_resume(dev);
>> >
>> >  Complete:
>> >         complete_all(&dev->power.completion);
>> > @@ -1487,6 +1539,9 @@ static int __device_suspend(struct devic
>> >                 dev->power.direct_complete = false;
>> >         }
>> >
>> > +       dev->power.may_skip_resume = false;
>> > +       dev->power.must_resume = false;
>> > +
>>
>> First, these assignment could be bypassed if the direct_complete path
>> is used. Perhaps it's more robust to reset these flags already in
>> device_prepare().
>
> In the direct-complete case may_skip_resume doesn't matter.
>
> must_resume should be set to "false", however, so that parents of
> direct-complete devices may be left in suspend (in case they don't
> fall under direct-complete themselves), so good catch.

Actually, not really.

must_resume for parents/suppliers is not updated if the device has
direct_complete set and the device's own must_resume doesn't matter
then.

So this part is good as is AFAICS.

Thanks,
Rafael
