Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:56316 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751091AbdJRWVt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Oct 2017 18:21:49 -0400
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
Date: Thu, 19 Oct 2017 00:12:09 +0200
Message-ID: <4337843.QuD5zygUhU@aspire.rjw.lan>
In-Reply-To: <CAPDyKFozJtSHxxBEFtC+ofJ4XUyQjqUundPs81JATT=WfjXoYA@mail.gmail.com>
References: <3806130.B2KCK0tvef@aspire.rjw.lan> <2890181.vdGMMavi5M@aspire.rjw.lan> <CAPDyKFozJtSHxxBEFtC+ofJ4XUyQjqUundPs81JATT=WfjXoYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, October 18, 2017 4:11:33 PM CEST Ulf Hansson wrote:
> [...]
> 
> >>
> >> The reason why pm_runtime_force_* needs to respects the hierarchy of
> >> the RPM callbacks, is because otherwise it can't safely update the
> >> runtime PM status of the device.
> >
> > I'm not sure I follow this requirement.  Why is that so?
> 
> If the PM domain controls some resources for the device in its RPM
> callbacks and the driver controls some other resources in its RPM
> callbacks - then these resources needs to be managed together.

Right, but that doesn't automatically make it necessary to use runtime PM
callbacks in the middle layer.  Its system-wide PM callbacks may be
suitable for that just fine.

That is, at least in some cases, you can combine ->runtime_suspend from a
driver and ->suspend_late from a middle layer with no problems, for example.

That's why some middle layers allow drivers to point ->suspend_late and
->runtime_suspend to the same routine if they want to reuse that code.

> This follows the behavior of when a regular call to
> pm_runtime_get|put(), triggers the RPM callbacks to be invoked.

But (a) it doesn't have to follow it and (b) in some cases it should not
follow it.
 
> >
> >> And updating the runtime PM status of
> >> the device is required to manage the optimized behavior during system
> >> resume (avoiding to unnecessary resume devices).
> >
> > Well, OK.  The runtime PM status of the device after system resume should
> > better reflect its physical state.
> >
> > [The physical state of the device may not be under the control of the
> > kernel in some cases, like in S3 resume on some systems that reset
> > devices in the firmware and so on, but let's set that aside.]
> >
> > However, for the runtime PM status of the device may still reflect its state
> > if, say, a ->resume_early of the middle layer is called during resume along
> > with a driver's ->runtime_resume.  That still can produce the right state
> > of the device and all depends on the middle layer.
> >
> > On the other hand, as I said before, using a middle-layer ->runtime_suspend
> > during a system sleep transition may be outright incorrect, say if device
> > wakeup settings need to be adjusted by the middle layer (which is the
> > case for some of them).
> >
> > Of course, if the middle layer expects the driver to point its
> > system-wide PM callbacks to pm_runtime_force_*, then that's how it goes,
> > but the drivers working with this particular middle layer generally
> > won't work with other middle layers and may interact incorrectly
> > with parents and/or children using the other middle layers.
> >
> > I guess the problem boils down to having a common set of expectations
> > on the driver side and on the middle layer side allowing different
> > combinations of these to work together.
> 
> Yes!
> 
> >
> >> Besides the AMBA case, I also realized that we are dealing with PM
> >> clocks in the genpd case. For this, genpd relies on the that runtime
> >> PM status of the device properly reflects the state of the HW, during
> >> system-wide PM.
> >>
> >> In other words, if the driver would change the runtime PM status of
> >> the device, without respecting the hierarchy of the runtime PM
> >> callbacks, it would lead to that genpd starts taking wrong decisions
> >> while managing the PM clocks during system-wide PM. So in case you
> >> intend to change pm_runtime_force_* this needs to be addressed too.
> >
> > I've just looked at the genpd code and quite frankly I'm not sure how this
> > works, but I'll figure this out. :-)
> 
> You may think of it as genpd's RPM callback controls some device
> clocks, while the driver control some other device resources (pinctrl
> for example) from its RPM callback.
> 
> These resources needs to managed together, similar to as I described above.

Which, again, doesn't mean that runtime PM callbacks from the middle layer
have to be used for that.

> [...]
> 
> >> Absolutely agree about the different wake-up settings. However, these
> >> issues can be addressed also when using pm_runtime_force_*, at least
> >> in general, but then not for PCI.
> >
> > Well, not for the ACPI PM domain too.
> >
> > In general, not if the wakeup settings are adjusted by the middle layer.
> 
> Correct!
> 
> To use pm_runtime_force* for these cases, one would need some
> additional information exchange between the driver and the
> middle-layer.

Which pretty much defeats the purpose of the wrappers, doesn't it?

> >
> >> Regarding hibernation, honestly that's not really my area of
> >> expertise. Although, I assume the middle-layer and driver can treat
> >> that as a separate case, so if it's not suitable to use
> >> pm_runtime_force* for that case, then they shouldn't do it.
> >
> > Well, agreed.
> >
> > In some simple cases, though, driver callbacks can be reused for hibernation
> > too, so it would be good to have a common way to do that too, IMO.
> 
> Okay, that makes sense!
> 
> >
> >> >
> >> > Also, quite so often other middle layers interact with PCI directly or
> >> > indirectly (eg. a platform device may be a child or a consumer of a PCI
> >> > device) and some optimizations need to take that into account (eg. parents
> >> > generally need to be accessible when their childres are resumed and so on).
> >>
> >> A device's parent becomes informed when changing the runtime PM status
> >> of the device via pm_runtime_force_suspend|resume(), as those calls
> >> pm_runtime_set_suspended|active().
> >
> > This requires the parent driver or middle layer to look at the reference
> > counter and understand it the same way as pm_runtime_force_*.
> >
> >> In case that isn't that sufficient, what else is needed? Perhaps you can
> >> point me to an example so I can understand better?
> >
> > Say you want to leave the parent suspended after system resume, but the
> > child drivers use pm_runtime_force_suspend|resume().  The parent would then
> > need to use pm_runtime_force_suspend|resume() too, no?
> 
> Actually no.
> 
> Currently the other options of "deferring resume" (not using
> pm_runtime_force_*), is either using the "direct_complete" path or
> similar to the approach you took for the i2c designware driver.
>
> Both cases should play nicely in combination of a child being managed
> by pm_runtime_force_*. That's because only when the parent device is
> kept runtime suspended during system suspend, resuming can be
> deferred.

And because the parent remains in runtime suspend late enough in the
system suspend path, its children also are guaranteed to be suspended.

But then all of them need to be left in runtime suspend during system
resume too, which is somewhat restrictive, because some drivers may
want their devices to be resumed then.

[BTW, our current documentation recommends resuming devices during
system resume, actually, and gives a list of reasons why. :-)]

> That means, if the resume of the parent is deferred, so will the also
> the resume of the child.
> 
> >
> >> For a PCI consumer device those will of course have to play by the rules of PCI.
> >>
> >> >
> >> > Moreover, the majority of the "other subsystems/middle-layers" you've talked
> >> > about so far don't provide any PM callbacks to be invoked by pm_runtime_force_*,
> >> > so question is how representative they really are.
> >>
> >> That's the point. We know pm_runtime_force_* works nicely for the
> >> trivial middle-layer cases.
> >
> > In which cases the middle-layer callbacks don't exist, so it's just like
> > reusing driver callbacks directly. :-)
> >
> >> For the more complex cases, we need something additional/different.
> >
> > Something different.
> >
> > But overall, as I said, this is about common expectations.
> >
> > Today, some middle layers expect drivers to point their callback pointers
> > to the same routine in order to resue it (PCI, ACPI bus type), some of them
> > expect pm_runtime_force_suspend|resume() to be used (AMBA, maybe genpd),
> > and some of them have no expectations at all.
> >
> > There needs to be a common ground in that area for drivers to be able to
> > work with different middle layers.
> 
> Yes, reaching that point would be great, we should definitively aim for that!

Indeed.

Thanks,
Rafael
