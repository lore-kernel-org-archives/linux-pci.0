Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58786 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753416Ab3KVLyK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 22 Nov 2013 06:54:10 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Kevin Hilman <khilman@linaro.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	linux-usb@vger.kernel.org
Subject: Re: [RFC PATCH] PM / Runtime: Allow to inactivate devices during system suspend
Date: Fri, 22 Nov 2013 13:06:51 +0100
Message-ID: <1947470.Tbpb5emIaY@vostro.rjw.lan>
In-Reply-To: <CAPDyKFo9vzCVtMFzZaCjkGosPve72=RbWtLXaSzzX8Wq2O5ptA@mail.gmail.com>
References: <CAPDyKFrJ34oWhPosqqfh-cCpoQnAY9Q90wP7nn60RAh87ZCPAw@mail.gmail.com> <Pine.LNX.4.44L0.1311211046160.1301-100000@iolanthe.rowland.org> <CAPDyKFo9vzCVtMFzZaCjkGosPve72=RbWtLXaSzzX8Wq2O5ptA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, November 22, 2013 09:19:32 AM Ulf Hansson wrote:
> On 21 November 2013 16:54, Alan Stern <stern@rowland.harvard.edu> wrote:
> > On Thu, 21 Nov 2013, Ulf Hansson wrote:
> >
> >> >> As Rafael mentioned, there is bus/pm_domain code that comes into play
> >> >> here, so I'm not sure it's always a bug.
> >> >>
> >> >> IMO, it's not a bug for the driver to depend on runtime PM if the
> >> >> bus/pm_domain is handling the details.
> >> >>
> >> >> On OMAP, we handle all the SoC on-chip devices with a pm_domain since
> >> >> the low-level PM operations that need to happen are bus-level things not
> >> >> device-level things.  Therefore, drivers for these devices can rely
> >> >> entirely on runtime PM, even for system suspend.  The late/early
> >> >> callbacks in the pm_domain can see if the device is runtime suspended
> >> >> already or not and behave accordingly.
> >> >>
> >> >> So, this all *can* work by handling it at the bus/pm_domain level, but
> >> >> as Ulf has mentioned (and I agree) it seems like a clunky workaround
> >> >> because the PM core is preventing it from happening as one might expect.
> >> >
> >> > The problem is that userspace can disable runtime PM at any time by
> >> > writing "on" to /sys/.../power/control.  Once that's done, you can't
> >> > depend on runtime PM to put the device into a low-power state during
> >> > system suspend.
> >> >
> >> > Now, if the bus-level code always takes care of putting the device into
> >> > low power during system suspend, then the driver doesn't have to worry
> >> > about it at all.  That's perfectly fine -- but I would hardly describe
> >> > the situation by saying the driver relies on runtime PM for system
> >> > suspend.
> >>
> >> But they are, since that is exactly what these driver depends on
> >> during system suspend.
> >
> > Not at all.  These drivers rely on the bus-level code's suspend
> > routine to handle system suspend.  They don't rely on runtime PM.
> >
> >>  And since the power domain invokes the runtime
> >> callbacks, normally CONFIG_PM_RUNTIME is needed for the callbacks to
> >> be set up from in the bus/driver.
> >
> > No, it isn't.  You can always write callbacks that get compiled even
> > when CONFIG_PM_RUNTIME isn't enabled.  It's very easy -- all you have
> > to do is change
> >
> >         #ifdef CONFIG_PM_RUNTIME
> >
> > to
> >
> >         #ifdef CONFIG_PM
> 
> You nailed it here! Since you consider this to be allowed from
> dependency point of view, all my problems described would be
> "solvable". :-)
> 
> Regarding the SET_RUNTIME_PM_OPS macro, which today relies on
> CONFIG_PM_RUNTIME should then be moved to CONFIG_PM instead. As
> prerequisites, drivers using this macro, obviously need to implement
> the runtime PM callbacks within CONFIG_PM as well. If that makes sense
> to you as well, I will start working on converting them that needs.

SET_RUNTIME_PM_OPS is intended to be used inside of a struct dev_pm_ops
definition along the lines of UNIVERSAL_DEV_PM_OPS (although the latter
was a mistake, sadly).

So actually what we need is a sane replacement for UNIVERSAL_DEV_PM_OPS
in my opinion.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
