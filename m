Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58572 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752162Ab3KSNIa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Nov 2013 08:08:30 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	linux-usb@vger.kernel.org, Kevin Hilman <khilman@linaro.org>
Subject: Re: [RFC PATCH] PM / Runtime: Allow to inactivate devices during system suspend
Date: Tue, 19 Nov 2013 14:21:08 +0100
Message-ID: <7271853.iqRc6SUNTz@vostro.rjw.lan>
In-Reply-To: <CAPDyKFpypLVKiOZEweWMig9LrNHcOpNQnm+J3KJ3KzCDBgkv9A@mail.gmail.com>
References: <CAPDyKFrushEwW7x_VguPjOnP8BuSO=+tD=DxS9J0JQVfYTgOYA@mail.gmail.com> <Pine.LNX.4.44L0.1311181010080.1421-100000@iolanthe.rowland.org> <CAPDyKFpypLVKiOZEweWMig9LrNHcOpNQnm+J3KJ3KzCDBgkv9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, November 19, 2013 01:21:57 PM Ulf Hansson wrote:
> On 18 November 2013 16:17, Alan Stern <stern@rowland.harvard.edu> wrote:
> > On Mon, 18 Nov 2013, Ulf Hansson wrote:
> >
> >> I favour the pm_runtime_no_prevent_suspend API approach, since it
> >> would mean a change in behaviour of the PM core.
> >
> > That's exactly why I don't favor it!  :-)
> 
> I will try my best to convince you then. :-)
> 
> >
> >>  I also think that in
> >> some cases it could make runtime PM better understandable, for those
> >> who are deploying it.
> >
> > I don't see how it would make runtime PM either more or less
> > understandable, since the proposed change affects system PM, not
> > runtime PM.  On the other hand, it would make the Runtime PM
> > documentation more complicated.
> 
> At the moment, system PM is already affecting behaviour of runtime PM
> since it is preventing runtime suspend during system suspend.
> 
> To me and and those driver authors, that don't see the direct need for
> why the PM core behaves like this (because we are not working with PCI
> drivers for example), I would guess this is probably the piece in the
> documentation we have more difficult to understand and adapt to.
> 
> I can point at some examples, were I believe drivers that use runtime
> PM, tries to adapt to the PM core behaviour, but I fear they for too
> many times have got it wrong. Here are some various examples I have
> found, which made me think like this.
> 
> 1.
> Not many are using the .suspend_late callback at all, which should be
> the most proper solution to use.

Yes.

> 2.
> Drivers are using the synchronise pm_runtime_put_sync in their
> .suspend callbacks.
> 
> 3.
> Drivers do "pm_runtime_get_sync" from their .suspend callbacks, but
> don't put the device into inactive state from anywhere as a part of
> the system suspend.
> 
> 4.
> Drivers only handles system suspend tasks from it's .suspend callbacks
> and don't implement .suspend_late, thus the device will not be fully
> inactivated.
> 
> 5.
> Drivers relies on pm_runtime_suspended or worse
> pm_runtime_status_suspend, to check if they shall put their device
> into inactive state from their .suspend callbacks or leave it as is.
> While they put the device into inactive state, the runtime state is
> not properly updated to reflect this. Most important, at this point
> runtime PM has not yet been disabled from the PM core.

All 2 and 5 are bugs in the drviers that should be fixed.  Whether or
not 4 is a bug depends on what the bus type does.

There's one more problem here, which is the expectation that drivers should
be responsible for the entire handling of suspend/resume of their devices.
This is misguided, because it forces the knowledge about particular platforms
into the drivers.  Ideally, the suspend and resume of a device should be
divided into a device-specific part handled by the driver and a bus-specific
or platform-specific part handled by the bus type or a PM domain, respectively.
The driver should only be concerned about the device-specific part.

That applies to both system suspend/resume and runtime PM, though.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
