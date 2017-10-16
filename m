Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171016070850.GA26934@kroah.com>
References: <3806130.B2KCK0tvef@aspire.rjw.lan> <20171016070850.GA26934@kroah.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 16 Oct 2017 23:50:51 +0200
Message-ID: <CAJZ5v0hDq2K7FUBOPqucXP8dWVkrpWEPkE6Lu=XP1cPA5tm5kQ@mail.gmail.com>
Subject: Re: [PATCH 0/12] PM / sleep: Driver flags for system suspend/resume
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kevin Hilman <khilman@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 16, 2017 at 9:08 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Mon, Oct 16, 2017 at 03:12:35AM +0200, Rafael J. Wysocki wrote:
>> Hi All,
>>
>> Well, this took more time than expected, as I tried to cover everything I had
>> in mind regarding PM flags for drivers.
>>
>> This work was triggered by attempts to fix and optimize PM in the
>> i2c-designware-platdev driver that ended up with adding a couple of
>> flags to the driver's internal data structures for the tracking of
>> device state (https://marc.info/?l=linux-acpi&m=150629646805636&w=2).
>> That approach is sort of suboptimal, though, because other drivers will
>> probably want to do similar things and if all of them need to use internal
>> flags for that, quite a bit of code duplication may ensue at least.
>>
>> That can be avoided in a couple of ways and one of them is to provide a means
>> for drivers to tell the core what to do and to make the core take care of it
>> if told to do so.  Hence, the idea to use driver flags for system-wide PM
>> that was briefly discussed during the LPC in LA last month.
>>
>> One of the flags considered at that time was to possibly cause the core
>> to reuse the runtime PM callback path of a device for system suspend/resume.
>> Admittedly, that idea didn't look too bad to me until I had started to try to
>> implement it and I got to the PCI bus type's hibernation callbacks.  Then, I
>> moved the patch I was working on to /dev/null right away.  I mean it.
>>
>> No, this is not going to happen.  No way.
>>
>> Moreover, that experience made me realize that the whole *idea* of using the
>> runtime PM callback path for system-wide PM was actually totally bogus (sorry
>> Ulf).
>>
>> The whole point of having different callbacks pointers for different types of
>> device transitions is because it may be necessary to do different things in
>> those callbacks in general.  Now, if you consider runtime PM and system
>> suspend/resume *only* and from a driver perspective, then yes, in some cases
>> the same pair of callback routines may be used for all suspend-like and
>> resume-like transitions of the device, but if you add hibernation to the mix,
>> then it is not so clear any more unless the callbacks don't actually do any
>> power management at all, but simply quiesce the device's activity and then
>> activate it again.  Namely, changing power states of devices during the
>> hibernation's "freeze" and "thaw" transitions rarely makes sense at all and
>> the "restore" transition needs to be able to cope with uninitialized devices
>> (in fact, it should be prepared to cope with devices in *any* state), so
>> runtime PM is hardly suitable for them.  Still, if a *driver* choses to not
>> do any real PM in its PM callbacks and leaves that to a middle layer (quite
>> a few drivers do that), then it possibly can use one pair of callbacks in all
>> cases and be happy, but middle layers pretty much have to use different
>> callback routines for different transitions.
>>
>> If you are a middle layer, your role is basically to do PM for a certain
>> group of devices.  Thus you cannot really do the same in ->suspend or
>> ->suspend_early and in ->runtime_suspend (because the former generally need to
>> take device_may_wakeup() into account and the latter doesn't) and you shouldn't
>> really do the same in ->suspend and ->freeze (becuase the latter shouldn't
>> change the device's power state) and so on.  To put it bluntly, trying
>> to use the ->runtime_suspend callback of a middle layer for anything other
>> than runtime suspend is complete and utter nonsense.  At the same time, the
>> ->runtime_resume callback of a middle layer may be reused to some extent,
>> but even that doesn't cover the "thaw" transitions during hibernation.
>>
>> What can work (and this is the only strategy that can work AFAICS) is to
>> point different callback pointers *in* *a* *driver* to the same routine
>> if the driver wants to reuse that code.  That actually will work for PCI
>> and USB drivers today, at least most of the time, but unfortunately there
>> are problems with it for, say, platform devices.
>>
>> The first problem is the requirement to track the status of the device
>> (suspended vs not suspended) in the callbacks, because the system-wide PM
>> code in the PM core doesn't do that.  The runtime PM framework does it, so
>> this means adding some extra code which isn't necessary for runtime PM to
>> the callback routines and that is not particularly nice.
>>
>> The second problem is that, if the driver wants to do anything in its
>> ->suspend callback, it generally has to prevent runtime suspend of the
>> device from taking place in parallel with that, which is quite cumbersome.
>> Usually, that is taken care of by resuming the device from runtime suspend
>> upfront, but generally doing that is wasteful (there may be no real need to
>> resume the device except for the fact that the code is designed this way).
>>
>> On top of the above, there are optimizations to be made, like leaving certain
>> devices in suspend after system resume to avoid wasting time on waiting for
>> them to resume before user space can run again and similar.
>>
>> This patch series focuses on addressing those problems so as to make it
>> easier to reuse callback routines by pointing different callback pointers
>> to them in device drivers.  The flags introduced here are to instruct the
>> PM core and middle layers (whatever they are) on how the driver wants the
>> device to be handled and then the driver has to provide callbacks to match
>> these instructions and the rest should be taken care of by the code above it.
>>
>> The flags are introduced one by one to avoid making too many changes in
>> one go and to allow things to be explained better (hopefully).  They mostly
>> are mutually independent with some clearly documented exceptions.
>>
>> The first three patches in the series are about an issue with the
>> direct-complete optimization introduced some time ago in which some middle
>> layers decide on whether or not to do the optimization without asking the
>> drivers.  And, as it turns out, in some cases the drivers actually know
>> better, so the new flags introduced by these patches are here for these
>> drivers (and the DPM_FLAG_NEVER_SKIP one is really to avoid having to define
>> ->prepare callbacks always returning zero).
>>
>> The really interesting things start to happen in patches [4-9/12] which make it
>> possible to avoid resuming devices from runtime suspend upfront during system
>> suspend at least in some cases (and when direct-complete is not applied to the
>> devices in question), but please refer to the changelogs for details.
>>
>> The i2d-designware-platdev driver is used as the primary example in the series
>> and the patches modifying it are based on some previous changes currently in
>> linux-next AFAICS (the same applies to the intel-lpss driver), but these
>> patches can wait until everything is properly merged.  They are included here
>> mostly as illustration.
>>
>> Overall, the series is based on the linux-next branch of the linux-pm.git tree
>> with some extra patches on top of it and all of the names of new entities
>> introduced in it are negotiable.
>
> Thanks for the great explaination, I was wondering how your proposal
> discussed at Plumbers was going to work out in the end :)
>
> The patch series looks good to me (minor questions already sent on the
> patches),

Cool. :-)

> but what does this mean for drivers?  Do they now have to do a
> lot of work to take advantage of this, like you did for the
> i2d-designware-platdev driver?  Or will things continue to work as-is
> and it's only an opt-in type thing where the bus/driver wants to take
> advantage of it?

It's envisioned as an opt-in thing mostly, except for the flags
introduced by patch [01/12] that may be needed to address existing
issues.

It is not strictly necessary to set any of the other flags, but I
guess some use cases may benefit quite a bit from setting them. :-)

Thanks,
Rafael
