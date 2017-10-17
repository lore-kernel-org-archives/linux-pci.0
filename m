Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
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
        Wolfram Sang <wsa@the-dreams.de>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 0/12] PM / sleep: Driver flags for system suspend/resume
Date: Tue, 17 Oct 2017 17:25:43 +0200
Message-ID: <17155956.N7VCkzZpky@aspire.rjw.lan>
In-Reply-To: <CAPDyKFrw6-pC3aBF5DrSRftuKv5v-X518oyy5mBt+hzM3EpHzA@mail.gmail.com>
References: <3806130.B2KCK0tvef@aspire.rjw.lan> <CAPDyKFrw6-pC3aBF5DrSRftuKv5v-X518oyy5mBt+hzM3EpHzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, October 17, 2017 10:36:39 AM CEST Ulf Hansson wrote:
> On 16 October 2017 at 03:12, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > Hi All,
> >
> > Well, this took more time than expected, as I tried to cover everything I had
> > in mind regarding PM flags for drivers.
> >
> > This work was triggered by attempts to fix and optimize PM in the
> > i2c-designware-platdev driver that ended up with adding a couple of
> > flags to the driver's internal data structures for the tracking of
> > device state (https://marc.info/?l=linux-acpi&m=150629646805636&w=2).
> > That approach is sort of suboptimal, though, because other drivers will
> > probably want to do similar things and if all of them need to use internal
> > flags for that, quite a bit of code duplication may ensue at least.
> >
> > That can be avoided in a couple of ways and one of them is to provide a means
> > for drivers to tell the core what to do and to make the core take care of it
> > if told to do so.  Hence, the idea to use driver flags for system-wide PM
> > that was briefly discussed during the LPC in LA last month.
> >
> > One of the flags considered at that time was to possibly cause the core
> > to reuse the runtime PM callback path of a device for system suspend/resume.
> > Admittedly, that idea didn't look too bad to me until I had started to try to
> > implement it and I got to the PCI bus type's hibernation callbacks.  Then, I
> > moved the patch I was working on to /dev/null right away.  I mean it.
> >
> > No, this is not going to happen.  No way.
> >
> > Moreover, that experience made me realize that the whole *idea* of using the
> > runtime PM callback path for system-wide PM was actually totally bogus (sorry
> > Ulf).
> >
> > The whole point of having different callbacks pointers for different types of
> > device transitions is because it may be necessary to do different things in
> > those callbacks in general.  Now, if you consider runtime PM and system
> > suspend/resume *only* and from a driver perspective, then yes, in some cases
> > the same pair of callback routines may be used for all suspend-like and
> > resume-like transitions of the device, but if you add hibernation to the mix,
> > then it is not so clear any more unless the callbacks don't actually do any
> > power management at all, but simply quiesce the device's activity and then
> > activate it again.  Namely, changing power states of devices during the
> > hibernation's "freeze" and "thaw" transitions rarely makes sense at all and
> > the "restore" transition needs to be able to cope with uninitialized devices
> > (in fact, it should be prepared to cope with devices in *any* state), so
> > runtime PM is hardly suitable for them.  Still, if a *driver* choses to not
> > do any real PM in its PM callbacks and leaves that to a middle layer (quite
> > a few drivers do that), then it possibly can use one pair of callbacks in all
> > cases and be happy, but middle layers pretty much have to use different
> > callback routines for different transitions.
> >
> > If you are a middle layer, your role is basically to do PM for a certain
> > group of devices.  Thus you cannot really do the same in ->suspend or
> > ->suspend_early and in ->runtime_suspend (because the former generally need to
> > take device_may_wakeup() into account and the latter doesn't) and you shouldn't
> > really do the same in ->suspend and ->freeze (becuase the latter shouldn't
> > change the device's power state) and so on.  To put it bluntly, trying
> > to use the ->runtime_suspend callback of a middle layer for anything other
> > than runtime suspend is complete and utter nonsense.  At the same time, the
> > ->runtime_resume callback of a middle layer may be reused to some extent,
> > but even that doesn't cover the "thaw" transitions during hibernation.
> >
> > What can work (and this is the only strategy that can work AFAICS) is to
> > point different callback pointers *in* *a* *driver* to the same routine
> > if the driver wants to reuse that code.  That actually will work for PCI
> > and USB drivers today, at least most of the time, but unfortunately there
> > are problems with it for, say, platform devices.
> >
> > The first problem is the requirement to track the status of the device
> > (suspended vs not suspended) in the callbacks, because the system-wide PM
> > code in the PM core doesn't do that.  The runtime PM framework does it, so
> > this means adding some extra code which isn't necessary for runtime PM to
> > the callback routines and that is not particularly nice.
> >
> > The second problem is that, if the driver wants to do anything in its
> > ->suspend callback, it generally has to prevent runtime suspend of the
> > device from taking place in parallel with that, which is quite cumbersome.
> > Usually, that is taken care of by resuming the device from runtime suspend
> > upfront, but generally doing that is wasteful (there may be no real need to
> > resume the device except for the fact that the code is designed this way).
> >
> > On top of the above, there are optimizations to be made, like leaving certain
> > devices in suspend after system resume to avoid wasting time on waiting for
> > them to resume before user space can run again and similar.
> >
> > This patch series focuses on addressing those problems so as to make it
> > easier to reuse callback routines by pointing different callback pointers
> > to them in device drivers.  The flags introduced here are to instruct the
> > PM core and middle layers (whatever they are) on how the driver wants the
> > device to be handled and then the driver has to provide callbacks to match
> > these instructions and the rest should be taken care of by the code above it.
> >
> > The flags are introduced one by one to avoid making too many changes in
> > one go and to allow things to be explained better (hopefully).  They mostly
> > are mutually independent with some clearly documented exceptions.
> >
> > The first three patches in the series are about an issue with the
> > direct-complete optimization introduced some time ago in which some middle
> > layers decide on whether or not to do the optimization without asking the
> > drivers.  And, as it turns out, in some cases the drivers actually know
> > better, so the new flags introduced by these patches are here for these
> > drivers (and the DPM_FLAG_NEVER_SKIP one is really to avoid having to define
> > ->prepare callbacks always returning zero).
> >
> > The really interesting things start to happen in patches [4-9/12] which make it
> > possible to avoid resuming devices from runtime suspend upfront during system
> > suspend at least in some cases (and when direct-complete is not applied to the
> > devices in question), but please refer to the changelogs for details.
> >
> > The i2d-designware-platdev driver is used as the primary example in the series
> > and the patches modifying it are based on some previous changes currently in
> > linux-next AFAICS (the same applies to the intel-lpss driver), but these
> > patches can wait until everything is properly merged.  They are included here
> > mostly as illustration.
> >
> > Overall, the series is based on the linux-next branch of the linux-pm.git tree
> > with some extra patches on top of it and all of the names of new entities
> > introduced in it are negotiable.
> >
> > Thanks,
> > Rafael
> >
> 
> I am not sure I fully understand the goal you have with this series.
> Can we please try to get that clear before I continue the review.

Quoting from the above:

"This patch series focuses on addressing those problems so as to make it
easier to reuse callback routines by pointing different callback pointers
to them in device drivers.  The flags introduced here are to instruct the
PM core and middle layers (whatever they are) on how the driver wants the
device to be handled and then the driver has to provide callbacks to match
these instructions and the rest should be taken care of by the code above it."

I'm not sure what I can explain beyond that. :-)

And the i2c-designware-platdrv and intel-lpss patches show the direction
I would like to take with that going forward: use the flags to reduce code
duplication in drivers and between drivers.

> Now, re-using runtime PM callbacks for system sleep, is already
> happening. We have > 60 users (git grep "pm_runtime_force_suspend")

60 is a small number relative to the total number of device drivers in
the tree.  In particular, that scheme is totally unsuitable for PCI drivers
and how many of them there are?  Surely more than 60.

> deploying this and from a middle layer point of view, all the trivial
> cases supports this.

These functions are wrong, however, because they attempt to reuse the
whole callback *path* instead of just reusing driver callbacks.  The
*only* reason why it all "works" is because there are no middle layer
callbacks involved in that now.

If you changed them to reuse driver callbacks only today, nothing would break
AFAICS.

> Like the spi bus, i2c bus, amba bus, platform
> bus, genpd, etc. There are no changes needed to continue to support
> this option, if you see what I mean.

For the time being, nothing changes in that respect, but eventually I'd
prefer the pm_runtime_force_* things to go away, frankly.

> So, when you say that re-using runtime PM callbacks for system-wide PM
> isn't going to happen, can you please elaborate what you mean?

I didn't mean "reusing runtime PM callbacks for system-wide PM" overall, but
reusing *middle-layer* runtime PM callbacks for system-wide PM.  That is the
bogus part.

Quoting again:

"If you are a middle layer, your role is basically to do PM for a certain
group of devices.  Thus you cannot really do the same in ->suspend or
->suspend_early and in ->runtime_suspend (because the former generally need to
take device_may_wakeup() into account and the latter doesn't) and you shouldn't
really do the same in ->suspend and ->freeze (becuase the latter shouldn't
change the device's power state) and so on."

I have said for multiple times that re-using *driver* callbacks actually makes
sense and the series is for doing that easier in general among other things.

> I assume you mean that the PM core won't be involved to support this,
> but is that it?
> 
> Do you also mean that *all* users of pm_runtime_force_suspend|resume()
> must convert to this new thing, using "driver PM flags", so in the end
> you want to remove pm_runtime_force_suspend|resume()?
>  - Then if so, you must of course consider all cases for how
> pm_runtime_force_suspend|resume() are being deployed currently, else
> existing users can't convert to the "driver PM flags" thing. Have you
> done that in this series?

Let me turn this around.

The majority of cases in which pm_runtime_force_* are used *should* be
addressable using the flags introduced here.  Some case in which
pm_runtime_force_* cannot be used should be addressable by these flags
as well.

There may be some cases in which pm_runtime_force_* are used that may
require something more, but I'm not going to worry about that right now.

I'll take care of that when I'll be removing pm_runtime_force_*, which I'm
not doing here.

Thanks,
Rafael

