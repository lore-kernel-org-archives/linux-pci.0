Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:44541 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752684Ab3KUPyB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 21 Nov 2013 10:54:01 -0500
Date: Thu, 21 Nov 2013 10:54:00 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
To: Ulf Hansson <ulf.hansson@linaro.org>
cc: Kevin Hilman <khilman@linaro.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	<linux-usb@vger.kernel.org>
Subject: Re: [RFC PATCH] PM / Runtime: Allow to inactivate devices during
 system suspend
In-Reply-To: <CAPDyKFrJ34oWhPosqqfh-cCpoQnAY9Q90wP7nn60RAh87ZCPAw@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1311211046160.1301-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 21 Nov 2013, Ulf Hansson wrote:

> >> As Rafael mentioned, there is bus/pm_domain code that comes into play
> >> here, so I'm not sure it's always a bug.
> >>
> >> IMO, it's not a bug for the driver to depend on runtime PM if the
> >> bus/pm_domain is handling the details.
> >>
> >> On OMAP, we handle all the SoC on-chip devices with a pm_domain since
> >> the low-level PM operations that need to happen are bus-level things not
> >> device-level things.  Therefore, drivers for these devices can rely
> >> entirely on runtime PM, even for system suspend.  The late/early
> >> callbacks in the pm_domain can see if the device is runtime suspended
> >> already or not and behave accordingly.
> >>
> >> So, this all *can* work by handling it at the bus/pm_domain level, but
> >> as Ulf has mentioned (and I agree) it seems like a clunky workaround
> >> because the PM core is preventing it from happening as one might expect.
> >
> > The problem is that userspace can disable runtime PM at any time by
> > writing "on" to /sys/.../power/control.  Once that's done, you can't
> > depend on runtime PM to put the device into a low-power state during
> > system suspend.
> >
> > Now, if the bus-level code always takes care of putting the device into
> > low power during system suspend, then the driver doesn't have to worry
> > about it at all.  That's perfectly fine -- but I would hardly describe
> > the situation by saying the driver relies on runtime PM for system
> > suspend.
> 
> But they are, since that is exactly what these driver depends on
> during system suspend.

Not at all.  These drivers rely on the bus-level code's suspend 
routine to handle system suspend.  They don't rely on runtime PM.

>  And since the power domain invokes the runtime
> callbacks, normally CONFIG_PM_RUNTIME is needed for the callbacks to
> be set up from in the bus/driver.

No, it isn't.  You can always write callbacks that get compiled even
when CONFIG_PM_RUNTIME isn't enabled.  It's very easy -- all you have
to do is change

	#ifdef CONFIG_PM_RUNTIME

to

	#ifdef CONFIG_PM

> I suppose that the OMAP SoC maintainers were accepting that this
> dependency were allowed to exist, since that was the only solution to
> their problem at that point.
> 
> Today, several years later, we are still indirectly pushing those SoC
> maintainers that faces similar issues, to accept this dependency
> between system suspend and runtime suspend. I see a conflict here. :-)

It's only a misunderstanding.  There is no dependency.


> I started drafting a new RFC according to your suggestion. Soon I
> realized that using such a callback for .suspend_late will make
> drivers/buses system suspend to depend on runtime suspend, (which my
> RFC also has problem with). So I guess this is not a recommended set
> up from the PM maintainers. Wandering in circles... :-)

Same misunderstanding as before.  The drivers merely need to be written 
so that the callbacks are compiled whenever CONFIG_PM is enabled rather 
than CONFIG_PM_RUNTIME.

Alan Stern

