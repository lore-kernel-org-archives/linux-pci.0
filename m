Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:36313 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751307Ab3KSPfr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Nov 2013 10:35:47 -0500
Date: Tue, 19 Nov 2013 10:35:46 -0500 (EST)
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
In-Reply-To: <CAPDyKFpypLVKiOZEweWMig9LrNHcOpNQnm+J3KJ3KzCDBgkv9A@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1311191011470.1145-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 19 Nov 2013, Ulf Hansson wrote:

> At the moment, system PM is already affecting behaviour of runtime PM
> since it is preventing runtime suspend during system suspend.

Sure.  And that behavior is documented.  In any case, it's a bug for 
drivers to depend on runtime suspend for carrying out a system suspend.

> To me and and those driver authors, that don't see the direct need for
> why the PM core behaves like this (because we are not working with PCI
> drivers for example), I would guess this is probably the piece in the
> documentation we have more difficult to understand and adapt to.

Perhaps you would like to improve the documentation, to explain this
point more clearly?

> I can point at some examples, were I believe drivers that use runtime
> PM, tries to adapt to the PM core behaviour, but I fear they for too
> many times have got it wrong. Here are some various examples I have
> found, which made me think like this.
> 
> 1.
> Not many are using the .suspend_late callback at all, which should be
> the most proper solution to use.

That's understandable, since suspend_late is a relatively recent
addition to the runtime PM API.  Naturally, drivers that implemented
runtime PM before suspend_late was added don't use it.

> 2.
> Drivers are using the synchronise pm_runtime_put_sync in their
> .suspend callbacks.

Which drivers do this?  Although this behavior isn't necessarily a bug, 
it probably doesn't do what the driver's author expected.

> 3.
> Drivers do "pm_runtime_get_sync" from their .suspend callbacks, but
> don't put the device into inactive state from anywhere as a part of
> the system suspend.

Again, which drivers?  Perhaps they expect the platform code to put the 
device into a low-power state.

> 4.
> Drivers only handles system suspend tasks from it's .suspend callbacks
> and don't implement .suspend_late, thus the device will not be fully
> inactivated.

It's okay not to implement .suspend_late.  If .suspend takes care of
everything, .suspend_late won't have work to do.

> 5.
> Drivers relies on pm_runtime_suspended or worse
> pm_runtime_status_suspend, to check if they shall put their device
> into inactive state from their .suspend callbacks or leave it as is.

There's nothing wrong with that (provided there's no risk of a runtime
resume occurring concurrently).  It makes sense to have a check like
that, so that you don't try to put the device into a low-power state
when it already is in low power.

> While they put the device into inactive state, the runtime state is
> not properly updated to reflect this. Most important, at this point
> runtime PM has not yet been disabled from the PM core.

The runtime PM status is generally not reliable after a device's
.suspend has run.  The .resume routine in the bus, class, or driver is
responsible for making sure that the runtime PM status is adjusted to 
the proper value.  This is the intended behavior, and it is documented.

> I should have stated, that I means those scenarios were the wakeup
> configuration is decided in runtime and depending on the current
> situation. For example depending on what kind of peripheral that is
> connected. In this scenario, I think the advantage still stands.

In fact, this example shows that using runtime-PM calls to carry out
system suspend can be a bad idea.  Here's the reason: Runtime suspend
is expected _always_ to enable wakeup (if the hardware supports it).  
But during system suspend, wakeup is supposed to be enabled _only_ if
device_may_wakeup() returns true.  Therefore, using a runtime_suspend
callback to handle system suspend is likely to end up with an incorrect
wakeup setting.

Alan Stern

