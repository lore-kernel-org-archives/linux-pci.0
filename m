Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57400 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753291Ab3KZUVi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Nov 2013 15:21:38 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	linux-usb@vger.kernel.org, Kevin Hilman <khilman@linaro.org>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v2] PM / Sleep: Add pm_generic functions to re-use runtime PM callbacks
Date: Tue, 26 Nov 2013 21:34:26 +0100
Message-ID: <2026361.IiCVpVNYkW@vostro.rjw.lan>
In-Reply-To: <CAPDyKFrS=8_T51hwSo+ONchm49_tj2o-+-H7Uv44ow4izutzfQ@mail.gmail.com>
References: <1385383221-20372-1-git-send-email-ulf.hansson@linaro.org> <5827021.HqYFigfrCJ@vostro.rjw.lan> <CAPDyKFrS=8_T51hwSo+ONchm49_tj2o-+-H7Uv44ow4izutzfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, November 26, 2013 10:48:56 AM Ulf Hansson wrote:
> On 26 November 2013 00:10, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Monday, November 25, 2013 01:40:21 PM Ulf Hansson wrote:
> >> To put devices into low power state during sleep, it sometimes makes
> >> sense at subsystem-level to re-use device's runtime PM callbacks.
> >>
> >> The PM core will at device_suspend_late disable runtime PM, after that
> >> we can safely operate on these callbacks. At suspend_late the device
> >> will be put into low power state by invoking the device's
> >> runtime_suspend callback, unless the runtime status is already
> >> suspended. At resume_early the state is restored by invoking the
> >> device's runtime_resume callback. Soon after the PM core will re-enable
> >> runtime PM before returning from device_resume_early.
> >>
> >> The new pm_generic functions are named pm_generic_suspend_late_runtime
> >> and pm_generic_resume_early_runtime, they are supposed to be used in
> >> pairs.
> >
> > What happens if the subsystem uses the new functions as its late suspend/
> > early resume callbacks, but some of its drivers implement .suspend_late()
> > and .resume_early()?
> 
> Good point. Normally, I think the decision of using these callbacks
> should be taken at the lowest level, in other words in the driver.
> Otherwise the lowest layer of .suspend_late will be by-passed.

I'm not sure what's the point to add them, then.  If the driver has to decide
anyway, it may simply populate its .suspend_late and .resume_early pointers
I think.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
