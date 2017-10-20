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
Date: Fri, 20 Oct 2017 03:19:09 +0200
Message-ID: <4041983.hUlLtGrCgL@aspire.rjw.lan>
In-Reply-To: <CAPDyKFqq9_ZbPFYn22s+6sxtxePWgnd0GJNodeqkCKF2+QkrNA@mail.gmail.com>
References: <3806130.B2KCK0tvef@aspire.rjw.lan> <4337843.QuD5zygUhU@aspire.rjw.lan> <CAPDyKFqq9_ZbPFYn22s+6sxtxePWgnd0GJNodeqkCKF2+QkrNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, October 19, 2017 2:21:07 PM CEST Ulf Hansson wrote:
> On 19 October 2017 at 00:12, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Wednesday, October 18, 2017 4:11:33 PM CEST Ulf Hansson wrote:
> >> [...]
> >>
> >> >>
> >> >> The reason why pm_runtime_force_* needs to respects the hierarchy of
> >> >> the RPM callbacks, is because otherwise it can't safely update the
> >> >> runtime PM status of the device.
> >> >
> >> > I'm not sure I follow this requirement.  Why is that so?
> >>
> >> If the PM domain controls some resources for the device in its RPM
> >> callbacks and the driver controls some other resources in its RPM
> >> callbacks - then these resources needs to be managed together.
> >
> > Right, but that doesn't automatically make it necessary to use runtime PM
> > callbacks in the middle layer.  Its system-wide PM callbacks may be
> > suitable for that just fine.
> >
> > That is, at least in some cases, you can combine ->runtime_suspend from a
> > driver and ->suspend_late from a middle layer with no problems, for example.
> >
> > That's why some middle layers allow drivers to point ->suspend_late and
> > ->runtime_suspend to the same routine if they want to reuse that code.
> >
> >> This follows the behavior of when a regular call to
> >> pm_runtime_get|put(), triggers the RPM callbacks to be invoked.
> >
> > But (a) it doesn't have to follow it and (b) in some cases it should not
> > follow it.
> 
> Of course you don't explicitly *have to* respect the hierarchy of the
> RPM callbacks in pm_runtime_force_*.
> 
> However, changing that would require some additional information
> exchange between the driver and the middle-layer/PM domain, as to
> instruct the middle-layer/PM domain of what to do during system-wide
> PM. Especially in cases when the driver deals with wakeup, as in those
> cases the instructions may change dynamically.

Well, if wakeup matters, drivers can't simply point their PM callbacks
to pm_runtime_force_* anyway.

If the driver itself deals with wakeups, it clearly needs different callback
routines for system-wide PM and for runtime PM, so it can't reuse its runtime
PM callbacks at all then.

If the middle layer deals with wakeups, different callbacks are needed at
that level and so pm_runtime_force_* are unsuitable too.

Really, invoking runtime PM callbacks from the middle layer in
pm_runtime_force_* is a not a idea at all and there's no general requirement
for it whatever.

> [...]
> 
> >> > In general, not if the wakeup settings are adjusted by the middle layer.
> >>
> >> Correct!
> >>
> >> To use pm_runtime_force* for these cases, one would need some
> >> additional information exchange between the driver and the
> >> middle-layer.
> >
> > Which pretty much defeats the purpose of the wrappers, doesn't it?
> 
> Well, no matter if the wrappers are used or not, we need some kind of
> information exchange between the driver and the middle-layers/PM
> domains.

Right.

But if that information is exchanged, then why use wrappers *in* *addition*
to that?

> Anyway, me personally think it's too early to conclude that using the
> wrappers may not be useful going forward. At this point, they clearly
> helps trivial cases to remain being trivial.

I'm not sure about that really.  So far I've seen more complexity resulting
from using them than being avoided by using them, but I guess the beauty is
in the eye of the beholder. :-)

> >
> >> >
> >> >> Regarding hibernation, honestly that's not really my area of
> >> >> expertise. Although, I assume the middle-layer and driver can treat
> >> >> that as a separate case, so if it's not suitable to use
> >> >> pm_runtime_force* for that case, then they shouldn't do it.
> >> >
> >> > Well, agreed.
> >> >
> >> > In some simple cases, though, driver callbacks can be reused for hibernation
> >> > too, so it would be good to have a common way to do that too, IMO.
> >>
> >> Okay, that makes sense!
> >>
> >> >
> >> >> >
> >> >> > Also, quite so often other middle layers interact with PCI directly or
> >> >> > indirectly (eg. a platform device may be a child or a consumer of a PCI
> >> >> > device) and some optimizations need to take that into account (eg. parents
> >> >> > generally need to be accessible when their childres are resumed and so on).
> >> >>
> >> >> A device's parent becomes informed when changing the runtime PM status
> >> >> of the device via pm_runtime_force_suspend|resume(), as those calls
> >> >> pm_runtime_set_suspended|active().
> >> >
> >> > This requires the parent driver or middle layer to look at the reference
> >> > counter and understand it the same way as pm_runtime_force_*.
> >> >
> >> >> In case that isn't that sufficient, what else is needed? Perhaps you can
> >> >> point me to an example so I can understand better?
> >> >
> >> > Say you want to leave the parent suspended after system resume, but the
> >> > child drivers use pm_runtime_force_suspend|resume().  The parent would then
> >> > need to use pm_runtime_force_suspend|resume() too, no?
> >>
> >> Actually no.
> >>
> >> Currently the other options of "deferring resume" (not using
> >> pm_runtime_force_*), is either using the "direct_complete" path or
> >> similar to the approach you took for the i2c designware driver.
> >>
> >> Both cases should play nicely in combination of a child being managed
> >> by pm_runtime_force_*. That's because only when the parent device is
> >> kept runtime suspended during system suspend, resuming can be
> >> deferred.
> >
> > And because the parent remains in runtime suspend late enough in the
> > system suspend path, its children also are guaranteed to be suspended.
> 
> Yes.
> 
> >
> > But then all of them need to be left in runtime suspend during system
> > resume too, which is somewhat restrictive, because some drivers may
> > want their devices to be resumed then.
> 
> Actually, this scenario is also addressed when using the pm_runtime_force_*.
> 
> The driver for the child would only need to bump the runtime PM usage
> count (pm_runtime_get_noresume()) before calling
> pm_runtime_force_suspend() at system suspend. That then also
> propagates to the parent, leading to that both the parent and the
> child will be resumed when pm_runtime_force_resume() is called for
> them.
> 
> Of course, if the driver of the parent isn't using pm_runtime_force_,
> we would have to assume that it's always being resumed at system
> resume.

There may be other ways to avoid that, though.

BTW, I don't quite like using the RPM usage counter this way either, if
that hasn't been clear so far.

> As at matter of fact, doesn't this scenario actually indicates that we
> do need to involve the runtime PM core (updating RPM status according
> to the HW state even during system-wide PM) to really get this right.
> It's not enough to only use "driver PM flags"!?

I'm not sure what you are talking about.

For all devices with enabled runtime PM any state produced by system
suspend/resume has to be labeled either as RPM_SUSPENDED or as RPM_ACTIVE.
That has always been the case and hasn't involved any magic.

However, while runtime PM is disabled, the state of the device doesn't
need to be reflected by its RPM status and there's no need to track it then.
Moreover, in some cases it cannot be tracked even, because of the firmare
involvement (and we cannot track the firmware).

Besides, please really look at what happens in the patches I posted and
then we can talk.

> Seems like we need to create a list of all requirements, pitfalls,
> good things vs bad things etc. :-)

We surely need to know what general cases need to be addressed.

> >
> > [BTW, our current documentation recommends resuming devices during
> > system resume, actually, and gives a list of reasons why. :-)]
> 
> Yes, but that too easy and to me not good enough. :-)

But the list of reasons why is kind of valid still.  There may be better
reasons for not doing that, but it really is a tradeoff and drivers
should be able to decide which way they want to go.

IOW, the "leave the device in runtime suspend throughout system
suspend" optimization doesn't have to be bundled with the "leave the
device in suspend throughout and after system resume" one.

Thanks,
Rafael

