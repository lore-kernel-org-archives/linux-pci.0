Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58532 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751029Ab3K0N7w (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 Nov 2013 08:59:52 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	linux-usb@vger.kernel.org, Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH v2] PM / Sleep: Add pm_generic functions to re-use runtime PM callbacks
Date: Wed, 27 Nov 2013 15:12:40 +0100
Message-ID: <18994672.4q6Ofp2t01@vostro.rjw.lan>
In-Reply-To: <CAPDyKFow3Y7bWAWNxQyrKeHizk0TSoCuPLHD=p_1D=CAYQpm9A@mail.gmail.com>
References: <2026361.IiCVpVNYkW@vostro.rjw.lan> <3028580.oiUVTDjyao@vostro.rjw.lan> <CAPDyKFow3Y7bWAWNxQyrKeHizk0TSoCuPLHD=p_1D=CAYQpm9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, November 27, 2013 10:59:57 AM Ulf Hansson wrote:
> >>
> >> There are already a generic callbacks that does this. Normally the
> >> generic callbacks is used from buses and power domains.
> >>
> >> My new callbacks are intended to be used from the driver, so those are
> >> kind of different from the others in that sense.
> >
> > Hmm.  I see.
> >
> > For that to work, the subsystem's .suspend() and .resume() callbacks will
> > have to be implemented in a special way, because of the unknown runtime PM
> > status of devices while those callbacks are being executed.
> 
> Not sure I understand why you think the runtime PM status is unknown?
> 
> In .suspend the runtime status can still be changed. Since the PM core
> disables runtime PM before invoking .suspend_late and since the PM
> core will keep runtime PM disabled until after the .resume_early has
> been invoked, it will be safe to operate on the runtime PM callbacks
> during this period - if the driver/bus are adopted for it. While the
> .resume callback gets invoked, the runtime status are restored to it's
> previous state, which the bus/driver would expect.
> 
> Do you want me to send a patch for a driver that uses these callbacks?
> I suppose it would clarify how I am thinking...
> 
> > Presumably you think about subsystems that don't implement those callbacks
> > at all?
> 
> If you mean that "drivers" is not a part of the term "subsystem" here,
> then I somewhat agree.
> 
> My view is that it will be mostly drivers that make use of these callbacks.
> 
> Though, I don't think we need to prevent subsystems or power domains
> from using them, they will only have to know what the consequences
> are. :-)
> 
> Maybe there could even be some cases were it actually makes good sense
> of using them for subsystems, even if I yet not have come a cross such
> a case.

We first need to clarify the terminology as that seems to be the source of
the confusion to some extent at least.

When I (or Alan presumably too) say "a subsystem", I mean a bus type, a device
type or a device class as represented by struct bus_type, struct device_type
and struct class, respectively.  So "a subsystem callback" means the specific
callback defined in the given bus type, device type or device class object.
You can think about that as of "subsystem level" if that's easier.  So that's
what we mean when we talk about subsystems, not the whole collection of drivers
and the code above them.

Now, say you have a bus type.  Usually, the bus type's PM callbacks will run
device drivers' PM callbacks.  Quite often they will do things to hardware
in addition to what the drivers do.  But if your driver's .suspend_late()
depends on the runtime PM status of the device, then the bus type's .suspend()
needs to preserve that status.  That is, it cannot do anything to the hardware
that may cause the runtime PM status of the device to become stale.  That makes
the .suspend() somewhat special, doesn't it?

Now I *guess* that your goal is something like "if that device has been
runtime suspended, don't touch it", which is a reasonable goal to have.  I'd
like to implement something like that too, but I think that it needs to be done
differently.

Actually, my idea is to allow the subsystem-level .prepare() callback to let
the core know if the device needs to be handled during the given suspend/resume
cycle.  It may be arranged, for example, so that if the subsystem-level (e.g.
bus type) .prepare() returns a positive number, the core will put the device
into a special list and it won't take it into consideration at all during the
whole cycle.

Why this way?  Because subsystems have much better ways to determine whether
or not it is necessary to access the device during the upcoming system
suspend/resume cycle than the core does.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
