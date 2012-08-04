Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:42080 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752604Ab2HDUCr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sat, 4 Aug 2012 16:02:47 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Do we need asynchronous pm_runtime_get()? (was: Re: bisected regression ...)
Date: Sat, 4 Aug 2012 22:08:38 +0200
Cc: linux-pci@vger.kernel.org, USB list <linux-usb@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>
References: <Pine.LNX.4.44L0.1208031001460.1520-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1208031001460.1520-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201208042208.38784.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, August 03, 2012, Alan Stern wrote:
> On Thu, 2 Aug 2012, Alan Stern wrote:
> 
> > On Thu, 2 Aug 2012, Rafael J. Wysocki wrote:
> > 
> > > > I don't know about that -- the logic involved in doing the processing 
> > > > within the resume callback isn't terribly complicated.  At least, not 
> > > > much more complicated than the logic involved in setting up a custom 
> > > > work routine as you suggest.
> > > 
> > > That's why I had the idea of pm_request_resume_and_call(dev, func)
> > > described in this message:
> > > 
> > > http://marc.info/?l=linux-usb&m=134377126804170&w=4
> > > 
> > > although perheps it would be better to call it something like
> > > pm_runtime_async_resume_and_call(dev, func).
> > 
> > Hmmm.  You'd probably want a version that does a "get" at the same 
> > time.  I suppose you would call func directly if the device was already 
> > resumed, without going through the workqueue?
> > 
> > Yes, I agree this would be a better interface then pm_runtime_get.
> 
> A few problems:

Which are good points. :-)

> What happens if a system sleep begins after 
> pm_runtime_async_resume_and_call() but before the runtime resume?  When 
> the system wakes up, the device will be back at full power without ever 
> executing a runtime PM call.  Then how will func get invoked?

The pm_runtime_barrier() at the beginning of __device_suspend() guarantees
that if there's a resume request pending at this point, the resume will be
carried out.  I think we can modify rpm_resume() to return only after func()
is executed, so there shouldn't be a problem with that particular case.

> What happens if the driver is unbound after
> pm_runtime_async_resume_and_call() but before the runtime resume?  The
> When the runtime resume occurs, func will be invoked -- and the driver
> might not even be in memory any more.

We have no protection against that at the moment, but then there is no
guarantee that the driver's runtime PM callbacks won't be run after
it's been unbound.

Perhaps we should run pm_runtime_barrier() before executing .remove()
in __device_release_driver() (and perhaps run pm_runtime_idle() afterwards
in case the subsystem or PM domain knows how to power down the device even if
there's no driver) and expect .remove() to clean up?

Rafael
