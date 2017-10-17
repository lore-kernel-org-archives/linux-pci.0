Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:49102 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759962AbdJQTlS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Oct 2017 15:41:18 -0400
Received: by mail-io0-f174.google.com with SMTP id j17so3538717iod.5
        for <linux-pci@vger.kernel.org>; Tue, 17 Oct 2017 12:41:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <17155956.N7VCkzZpky@aspire.rjw.lan>
References: <3806130.B2KCK0tvef@aspire.rjw.lan> <CAPDyKFrw6-pC3aBF5DrSRftuKv5v-X518oyy5mBt+hzM3EpHzA@mail.gmail.com>
 <17155956.N7VCkzZpky@aspire.rjw.lan>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 17 Oct 2017 21:41:16 +0200
Message-ID: <CAPDyKFrMTSUHP86hnpHius2CDfv-ap4svGg=xgwAiH8pKj9Lvw@mail.gmail.com>
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
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[...]

>>
>> I am not sure I fully understand the goal you have with this series.
>> Can we please try to get that clear before I continue the review.
>
> Quoting from the above:
>
> "This patch series focuses on addressing those problems so as to make it
> easier to reuse callback routines by pointing different callback pointers
> to them in device drivers.  The flags introduced here are to instruct the
> PM core and middle layers (whatever they are) on how the driver wants the
> device to be handled and then the driver has to provide callbacks to match
> these instructions and the rest should be taken care of by the code above it."
>
> I'm not sure what I can explain beyond that. :-)
>
> And the i2c-designware-platdrv and intel-lpss patches show the direction
> I would like to take with that going forward: use the flags to reduce code
> duplication in drivers and between drivers.
>
>> Now, re-using runtime PM callbacks for system sleep, is already
>> happening. We have > 60 users (git grep "pm_runtime_force_suspend")
>
> 60 is a small number relative to the total number of device drivers in
> the tree.  In particular, that scheme is totally unsuitable for PCI drivers
> and how many of them there are?  Surely more than 60.

Sure, those 60 can be converted after some work. I just wanted to
understand your plan for these moving forward.

>
>> deploying this and from a middle layer point of view, all the trivial
>> cases supports this.
>
> These functions are wrong, however, because they attempt to reuse the
> whole callback *path* instead of just reusing driver callbacks.  The
> *only* reason why it all "works" is because there are no middle layer
> callbacks involved in that now.
>
> If you changed them to reuse driver callbacks only today, nothing would break
> AFAICS.

Yes, it would.

First, for example, the amba bus is responsible for the amba bus
clock, but relies on drivers to gate/ungate it during system sleep. In
case the amba drivers don't use the pm_runtime_force_suspend|resume(),
it will explicitly have to start manage the clock during system sleep
themselves. Leading to open coding.

Second, it will introduce a regression in behavior for all users of
pm_runtime_force_suspend|resume(), especially during system resume as
the driver may then end up resuming the device even in case it isn't
needed. I believe I have explained why, also several times by now -
and that's also how far you could take the i2c designware driver at
this point.

That said, I assume the second part may be addressed in this series,
if these drivers convert to use the "driver PM flags", right?

However, what about the first case? Is some open coding needed or your
think the amba driver can instruct the amba bus via the "driver PM
flags"?

>
>> Like the spi bus, i2c bus, amba bus, platform
>> bus, genpd, etc. There are no changes needed to continue to support
>> this option, if you see what I mean.
>
> For the time being, nothing changes in that respect, but eventually I'd
> prefer the pm_runtime_force_* things to go away, frankly.

Okay, thanks for that clear statement!

>
>> So, when you say that re-using runtime PM callbacks for system-wide PM
>> isn't going to happen, can you please elaborate what you mean?
>
> I didn't mean "reusing runtime PM callbacks for system-wide PM" overall, but
> reusing *middle-layer* runtime PM callbacks for system-wide PM.  That is the
> bogus part.

I think we have discussed this several times, but the arguments you
have put forward, explaining *why* haven't yet convinced me.

In principle what you have been saying is that it's a "layering
violation" to use pm_runtime_force_suspend|resume() from driver's
system sleep callbacks, but on the other hand you think using
pm_runtime_get*  and friends is okay!?

That makes little sense to me, because it's the same "layering
violation" that is done for both cases.

Moreover, you have been explaining that re-using runtime PM callbacks
for PCI doesn't work. Then my question is, why should a limitation of
the PCI subsystem put constraints on the behavior for all other
subsystems/middle-layers?

>
> Quoting again:
>
> "If you are a middle layer, your role is basically to do PM for a certain
> group of devices.  Thus you cannot really do the same in ->suspend or
> ->suspend_early and in ->runtime_suspend (because the former generally need to
> take device_may_wakeup() into account and the latter doesn't) and you shouldn't
> really do the same in ->suspend and ->freeze (becuase the latter shouldn't
> change the device's power state) and so on."
>
> I have said for multiple times that re-using *driver* callbacks actually makes
> sense and the series is for doing that easier in general among other things.
>
>> I assume you mean that the PM core won't be involved to support this,
>> but is that it?
>>
>> Do you also mean that *all* users of pm_runtime_force_suspend|resume()
>> must convert to this new thing, using "driver PM flags", so in the end
>> you want to remove pm_runtime_force_suspend|resume()?
>>  - Then if so, you must of course consider all cases for how
>> pm_runtime_force_suspend|resume() are being deployed currently, else
>> existing users can't convert to the "driver PM flags" thing. Have you
>> done that in this series?
>
> Let me turn this around.
>
> The majority of cases in which pm_runtime_force_* are used *should* be
> addressable using the flags introduced here.  Some case in which
> pm_runtime_force_* cannot be used should be addressable by these flags
> as well.

That's sounds really great!

>
> There may be some cases in which pm_runtime_force_* are used that may
> require something more, but I'm not going to worry about that right now.

This approach concerns me, because if we in the end realizes that
pm_runtime_force_suspend|resume() will be too hard to get rid of, then
this series just add yet another generic way of trying to optimize the
system sleep path for runtime PM enabled devices.

So then we would end up having to support the "direct_complete" path,
the "driver PM flags" and cases where
pm_runtime_force_suspend|resume() is used. No, that just isn't good
enough to me. That will just lead to similar scenarios as we had in
the i2c designware driver.

If we decide to go with these new "driver PM flags", I want to make
sure, as long as possible, that we can remove both the
"direct_complete" path support from the PM core as well as removing
the pm_runtime_force_suspend|resume() helpers.

>
> I'll take care of that when I'll be removing pm_runtime_force_*, which I'm
> not doing here.

Of course I am fine with that we postpone doing the actual converting
of drivers etc from this series, although as stated above, let's sure
we *can* do it by using the "driver PM flags".

Kind regards
Uffe
