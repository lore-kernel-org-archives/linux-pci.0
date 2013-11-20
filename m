Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:36738 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754191Ab3KTQz4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 20 Nov 2013 11:55:56 -0500
Date: Wed, 20 Nov 2013 11:55:55 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
To: Ulf Hansson <ulf.hansson@linaro.org>
cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	<linux-usb@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>
Subject: Re: [RFC PATCH] PM / Runtime: Allow to inactivate devices during
 system suspend
In-Reply-To: <CAPDyKFopHvAvpb1O__3HoMv2YuhYnVLg5sk+NeRs9tsg8OLSig@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1311201131210.1826-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 20 Nov 2013, Ulf Hansson wrote:

> On 19 November 2013 16:35, Alan Stern <stern@rowland.harvard.edu> wrote:
> > On Tue, 19 Nov 2013, Ulf Hansson wrote:
> >
> >> At the moment, system PM is already affecting behaviour of runtime PM
> >> since it is preventing runtime suspend during system suspend.
> >
> > Sure.  And that behavior is documented.  In any case, it's a bug for
> > drivers to depend on runtime suspend for carrying out a system suspend.
> 
> Why do you say that?

Because, as I have repeated several times during this discussion,
the user can turn off runtime PM at any time by writing "on" to
/sys/.../power/control.  In addition, as Pavel pointed out, runtime PM
might not even be configured.

> A significant amount of drivers should be able to cope with only the
> runtime PM callbacks, if only the PM core have respected the drivers
> in the way my RFC proposes.

Or in the way I proposed.

> In the end, I want to achieve simpler use of runtime PM for drivers.
> As you will see below, a vast amount of drivers has got it wrong and
> to me that indicates we have not fully succeeded in keeping it as
> simple as I think we could have done.

You could simplify runtime PM by not configuring system sleep.  Then
none of these issues would matter.  :-)

But if you want to allow a system to have both runtime PM and system 
PM, some complexity is unavoidable.

> >> To me and and those driver authors, that don't see the direct need for
> >> why the PM core behaves like this (because we are not working with PCI
> >> drivers for example), I would guess this is probably the piece in the
> >> documentation we have more difficult to understand and adapt to.
> >
> > Perhaps you would like to improve the documentation, to explain this
> > point more clearly?
> 
> Sure, but even if documentation would be improved (actually I think it
> is quite good already), I think the behaviour of the PM core is what
> causes the confusion.
> 
> It is obvious to you guys, working with this for a long time and with
> these subsystem that clearly benefit from having the PM core to
> prevent runtime suspend during system suspend. Not so sure this is the
> case for others.

Then this is a perfect point for you to explain more clearly in the 
documentation.  If people are confused by the PM core's behavior, the 
right thing to do is explain the behavior -- not change it.

(In fact, the interaction between runtime suspend and system suspend is 
sufficiently complicated that no matter what the PM core does, it will 
end up confusing some people.)

> >> 1.
> >> Not many are using the .suspend_late callback at all, which should be
> >> the most proper solution to use.
> >
> > That's understandable, since suspend_late is a relatively recent
> > addition to the runtime PM API.  Naturally, drivers that implemented
> > runtime PM before suspend_late was added don't use it.
> 
> Well, it was included in 3.4, soon 1.5 years ago, but still only a
> handful occurrences. That ought to tell us something. :-)

I don't think so.  Go back and find some other features that were added 
to the kernel 1.5 years ago, and see how many places _they_ are used.

> >> 2.
> >> Drivers are using the synchronise pm_runtime_put_sync in their
> >> .suspend callbacks.
> >
> > Which drivers do this?  Although this behavior isn't necessarily a bug,
> > it probably doesn't do what the driver's author expected.
> 
> I think it indicates two things. One, the documentation has likely not
> been thoroughly read by authors. Second, authors are not expecting the
> current behaviour of PM core.
> 
> This is just a subset of drivers I found:
> drivers/pwm/pwm-tiecap.c
> drivers/pwm/pwm-tiehrpwm.c
> arch/arm/mach-omap2/gpmc.c
> drivers/char/hw_random/omap-rng.c
> drivers/crypto/omap-aes.c
> drivers/crypto/omap-sham.c
> drivers/input/keyboard/sh_keysc.c
> drivers/media/platform/davinci/vpif.c
> drivers/media/platform/davinci/vpss.c
> drivers/mtd/devices/elm.c

Okay, I'll take a look at these drivers.

> >> 3.
> >> Drivers do "pm_runtime_get_sync" from their .suspend callbacks, but
> >> don't put the device into inactive state from anywhere as a part of
> >> the system suspend.
> >
> > Again, which drivers?  Perhaps they expect the platform code to put the
> > device into a low-power state.
> 
> Sure, that requires some more deeper analyse, but anyway I found these:
> drivers/mmc/host/mmci.c
> drivers/mmc/host/sdhci-pxav3.c
> drivers/power/bq24190_charger.c

And these.

> >> 4.
> >> Drivers only handles system suspend tasks from it's .suspend callbacks
> >> and don't implement .suspend_late, thus the device will not be fully
> >> inactivated.
> >
> > It's okay not to implement .suspend_late.  If .suspend takes care of
> > everything, .suspend_late won't have work to do.
> 
> I have tried to iron what you say above, not sure I got it completely
> right though:

Sorry, I omitted a word.  I meant that if .suspend takes care of
everything (prevents new I/O requests from being serviced, finishes all
ongoing I/O requests, and puts the device into a low-power state), then
.suspend_late won't need to do any work at all.

> drivers/mfd/arizona-core.c
> drivers/mmc/host/sdhci-s3c.c
> drivers/spi/spi-tegra114.c
> drivers/spi/spi-tegra20-sflash.c
> drivers/tty/serial/8250/8250_dw.c

You must be joking.  There are hundreds of drivers that don't implement
.suspend_late.  Why list just these ones?  (In fact, almost no drivers
_do_ implement it.)

> >> 5.
> >> Drivers relies on pm_runtime_suspended or worse
> >> pm_runtime_status_suspend, to check if they shall put their device
> >> into inactive state from their .suspend callbacks or leave it as is.
> >
> > There's nothing wrong with that (provided there's no risk of a runtime
> > resume occurring concurrently).  It makes sense to have a check like
> > that, so that you don't try to put the device into a low-power state
> > when it already is in low power.
> 
> I am not saying these are bugs, but it kind of indicates that the
> author is not fully aware of how to use runtime PM in system suspend.
> The proper thing to do, should have been to use pm_runtime_disable,
> like the PM core in suspend late, before inactivating the device.
> 
> drivers/ata/libata-core.c
> drivers/gpu/drm/exynos/exynos_drm_ipp.c
> drivers/gpu/drm/exynos/exynos_drm_fimc.c
> drivers/gpu/drm/exynos/exynos_drm_gsc.c
> drivers/gpu/drm/exynos/exynos_drm_rotator.c
> drivers/gpu/drm/exynos/exynos_hdmi.c:
> drivers/dma/sirf-dma.c

Drivers don't necessarily have to call pm_runtime_disable.  They can
have other ways of insuring that no runtime resumes occur at the wrong
time.  For example, it is guaranteed that all user processes will be 
frozen during a system suspend, so no runtime-resume requests can come 
from userspace.

> >> While they put the device into inactive state, the runtime state is
> >> not properly updated to reflect this. Most important, at this point
> >> runtime PM has not yet been disabled from the PM core.
> >
> > The runtime PM status is generally not reliable after a device's
> > .suspend has run.  The .resume routine in the bus, class, or driver is
> > responsible for making sure that the runtime PM status is adjusted to
> > the proper value.  This is the intended behavior, and it is documented.
> 
> Still runtime PM should be disabled (pm_runtime_disable) to handle
> this properly, which is not the case in my examples above.

Not necessarily; see above.

Also, the documentation does explain that drivers should call 
pm_runtime_disable from their .resume callback, as part of adjusting 
the runtime PM status to match the device's actual state.

> >> I should have stated, that I means those scenarios were the wakeup
> >> configuration is decided in runtime and depending on the current
> >> situation. For example depending on what kind of peripheral that is
> >> connected. In this scenario, I think the advantage still stands.
> >
> > In fact, this example shows that using runtime-PM calls to carry out
> > system suspend can be a bad idea.  Here's the reason: Runtime suspend
> > is expected _always_ to enable wakeup (if the hardware supports it).
> 
> Not sure what you mean here, why should runtime suspend always enable
> wakeup? Is that not depending on the current situation?

No, it's not dependent on the situation.  Runtime suspend is always 
supposed to enable wakeup, if the hardware supports it.  This is 
documented as well.

> > But during system suspend, wakeup is supposed to be enabled _only_ if
> > device_may_wakeup() returns true.  Therefore, using a runtime_suspend
> > callback to handle system suspend is likely to end up with an incorrect
> > wakeup setting.
> 
> I don't see how these are in conflict? The idea was that drivers that
> requires it's device to be runtime resumed to be able to have wakeup
> cap set, should just prevent runtime suspend (pm_runtime_get). I might
> have explained this in some badly written English, sorry if I confused
> you. :-)

Here's an example.  Suppose a device is in runtime suspend, with wakeup 
enabled.  Now the whole computer goes into system suspend, and the 
device is _not_ supposed to be enabled for wakeup during system 
suspend.  The driver _should_ power-up the device, disable wakeup, and 
then power the device down again.  (Or something like that.)

But if the driver uses its runtime_suspend method for system suspend, 
then it will merely see that the device is already in low power, so it 
will return without doing anything.  As a result, the device will have 
wakeup enabled even though it shouldn't.

Alan Stern

