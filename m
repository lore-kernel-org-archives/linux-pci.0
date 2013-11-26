Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:33821 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932544Ab3KZVJp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Nov 2013 16:09:45 -0500
Date: Tue, 26 Nov 2013 16:09:44 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	<linux-usb@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH v2] PM / Sleep: Add pm_generic functions to re-use runtime
 PM callbacks
In-Reply-To: <2026361.IiCVpVNYkW@vostro.rjw.lan>
Message-ID: <Pine.LNX.4.44L0.1311261556480.1359-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 26 Nov 2013, Rafael J. Wysocki wrote:

> On Tuesday, November 26, 2013 10:48:56 AM Ulf Hansson wrote:
> > On 26 November 2013 00:10, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > On Monday, November 25, 2013 01:40:21 PM Ulf Hansson wrote:
> > >> To put devices into low power state during sleep, it sometimes makes
> > >> sense at subsystem-level to re-use device's runtime PM callbacks.

Ulf, please be more careful about the distinction between "device" and 
"driver".  Devices don't have callbacks; drivers do.  You made this 
mistake a few times in the patch description.

> > >> The PM core will at device_suspend_late disable runtime PM, after that
> > >> we can safely operate on these callbacks. At suspend_late the device
> > >> will be put into low power state by invoking the device's
> > >> runtime_suspend callback, unless the runtime status is already
> > >> suspended. At resume_early the state is restored by invoking the
> > >> device's runtime_resume callback. Soon after the PM core will re-enable
> > >> runtime PM before returning from device_resume_early.
> > >>
> > >> The new pm_generic functions are named pm_generic_suspend_late_runtime
> > >> and pm_generic_resume_early_runtime, they are supposed to be used in
> > >> pairs.
> > >
> > > What happens if the subsystem uses the new functions as its late suspend/
> > > early resume callbacks, but some of its drivers implement .suspend_late()
> > > and .resume_early()?

The same thing that happens whenever any PM-related callback is defined
by both the subsystem and the driver: The PM core uses the subsystem's
callback.  (Or the pm_domain's callback, or the type's callback, or the 
class's callback.)

Besides, Ulf specifically assumed at the top of this message that
re-using the runtime-suspend callback makes sense at the subsystem
level.  This must mean it is appropriate for all drivers in the
subsystem.  So why would a driver want to override the subsystem's 
behavior?

> > Good point. Normally, I think the decision of using these callbacks
> > should be taken at the lowest level, in other words in the driver.
> > Otherwise the lowest layer of .suspend_late will be by-passed.
> 
> I'm not sure what's the point to add them, then.  If the driver has to decide
> anyway, it may simply populate its .suspend_late and .resume_early pointers
> I think.

Another possibility is to have the pm_generic_suspend_late_runtime
routine check to see if the driver has defined a suspend_late callback.  
If the driver has its own callback, we could invoke it instead of
invoking the runtime_suspend callback.

However, I'm not sure that doing this would be worthwhile.  And it
would hang in an infinite loop if the driver set its suspend_late
pointer to pm_generic_suspend_late_runtime!

Alan Stern

