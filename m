Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:35482 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753503Ab3KNPzc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 14 Nov 2013 10:55:32 -0500
Date: Thu, 14 Nov 2013 10:55:31 -0500 (EST)
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
In-Reply-To: <CAPDyKFozCfPj-gW124cyFSu=ckiL-zVEmEx5tspY-1maO=+6fA@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1311141053060.1439-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 14 Nov 2013, Ulf Hansson wrote:

> > If you want a driver to do the same thing for runtime PM and system
> > suspend/resume, point its .suspend_late() and .runtime_suspend() to the
> > same routine and analogously for .runtime_resume() and .resume_early()
> > (that may not work for PCI, though, because of the _noirq stuff, but that's
> > the PCI bus type issue).
> 
> When your .suspend_late callback gets called, your device may be
> either active or inactive from runtime PM point of view. Just pointing
> the .suspend_late callback to the .runtime_suspend callback, simply
> wont work.
> 
> That would mean we might end up in trying to inactivate an already
> inactivated device, which I doubt is a good thing.:-) Some additional
> code will be needed to track the "runtime state" and to act
> accordingly. This is what drivers already tries to handle as of today,
> though so far mostly from their .suspend callbacks I believe.

You could write a "generic" suspend_late routine that would invoke the 
driver's runtime_suspend routine if the device's runtime PM status was 
RPM_ACTIVE.

> > Of course, the assumption behind .runtime_suspend() and .runtime_resume() is
> > that they will be run when the device is not in use, while system suspend
> > may actually happen when the device *is* in use and .suspend() should take
> > care of that if necessary.  So you may need .suspend() anyway.
> >
> > One important property of system suspend is that it can happen at any time
> > and that's why the .suspend() and .resume() callbacks are needed (and this
> > also means that they can't be the same as .runtime_suspend() and
> > .runtime_resume() in general).
> 
> I see your point and in most cases you are right. But, I am also sure
> that quite many drivers should be able to cope with only runtime PM
> callbacks. I have collected a bunch of examples that I can share, if
> you are interested?

All those drivers should be able to utilize this "generic" suspend_late 
routine.

Alan Stern

