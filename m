Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:49953 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750843Ab3KMWJJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 Nov 2013 17:09:09 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	linux-pm@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-usb@vger.kernel.org,
	Kevin Hilman <khilman@linaro.org>
Subject: Re: [RFC PATCH] PM / Runtime: Allow to inactivate devices during system suspend
Date: Wed, 13 Nov 2013 23:21:39 +0100
Message-ID: <1733072.0Y6z05AJRJ@vostro.rjw.lan>
In-Reply-To: <Pine.LNX.4.44L0.1311131411120.1424-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1311131411120.1424-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, November 13, 2013 02:16:03 PM Alan Stern wrote:
> On Wed, 13 Nov 2013, Ulf Hansson wrote:
> 
> > The PM core was preventing devices from going inactive during system
> > suspend. Remove this constraint and moreover try to inactivate devices
> > by invoking pm_runtime_idle() before proceeding with device's
> > suspend_late callbacks.
> > 
> > A great amount of drivers that uses runtime PM will benefit from this.
> 
> It's not clear how drivers will benefit.
> 
> > Drivers that implements some of the system ->suspend* callbacks for the
> > only reason of making sure the runtime PM resourses gets inactive, can
> > now solely instead rely on the PM core to handle this.
> 
> Drivers don't have to implement anything special if they want to use
> their runtime routines for system suspend.  All they have to do is set
> the .suspend and .resume method pointers to point to their
> runtime_suspend and runtime_resume routines.

Well, not really.  This doesn't work in general, because the assumptions for
running .suspend() (at any time, with user space frozen) are quite different
from the assumptions for running .runtime_suspend() (when the device is not
in use).  So generally .suspend() and .runtime_suspend() should be different.

That said .runtime_suspend() generally can be the same as .suspend_late()
(and that was the main reason why the latter was introduced in the first
place) and analogously for .runtime_resume() and .reasume_early().

Although there are simple cases in which .suspend() and .runtime_suspend() may
be the same, I'd still recommend to point .suspend_late and .runtime_suspend
to the same routine and leaving .suspend as NULL in those cases too (and
analogously for the resume stuff).

Thanks,
Rafael

