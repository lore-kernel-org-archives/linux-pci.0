Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:42124 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753099Ab2HDUyF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sat, 4 Aug 2012 16:54:05 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Do we need asynchronous pm_runtime_get()? (was: Re: bisected regression ...)
Date: Sat, 4 Aug 2012 22:59:56 +0200
Cc: linux-pci@vger.kernel.org, USB list <linux-usb@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>
References: <Pine.LNX.4.44L0.1208041628260.23711-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1208041628260.23711-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201208042259.56573.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Saturday, August 04, 2012, Alan Stern wrote:
> On Sat, 4 Aug 2012, Rafael J. Wysocki wrote:
> 
> > > What happens if a system sleep begins after 
> > > pm_runtime_async_resume_and_call() but before the runtime resume?  When 
> > > the system wakes up, the device will be back at full power without ever 
> > > executing a runtime PM call.  Then how will func get invoked?
> > 
> > The pm_runtime_barrier() at the beginning of __device_suspend() guarantees
> > that if there's a resume request pending at this point, the resume will be
> > carried out.  I think we can modify rpm_resume() to return only after func()
> > is executed, so there shouldn't be a problem with that particular case.
> 
> A resume request can get added to the workqueue after
> __device_suspend() runs, in which case the problem will still exist.

In theory.  But the question is who's going to add that request, since
the driver's (and possibly subsystem's/PM domain's) .suspend() callbacks
will be run by __device_suspend() and we can expect those to ensure
certain level of consistency.

Anyway, today we'll have the same problem with a runtime resume request
queued up during system suspend (after __device_suspend() has run).

> Should pm_runtime_set_active() call func (if such a call is pending)?
> 
> > > What happens if the driver is unbound after
> > > pm_runtime_async_resume_and_call() but before the runtime resume?  The
> > > When the runtime resume occurs, func will be invoked -- and the driver
> > > might not even be in memory any more.
> > 
> > We have no protection against that at the moment, but then there is no
> > guarantee that the driver's runtime PM callbacks won't be run after
> > it's been unbound.
> 
> True.  We have been relying on the subsystem to handle this race, but 
> obviously that's no good if the callback is directly to the driver.  I 
> don't see any way to fix this in the PM core.

Me neither.

> > Perhaps we should run pm_runtime_barrier() before executing .remove()
> > in __device_release_driver()
> 
> We already do pm_runtime_get_sync() and pm_runtime_put_sync().  I'm not 
> sure how necessary those calls really are ...

They are, because some platforms do some unusual things in their platform
bus type notifiers.

> but pm_runtime_barrier() would be redundant.
> 
> >  (and perhaps run pm_runtime_idle() afterwards
> > in case the subsystem or PM domain knows how to power down the device even if
> > there's no driver) and expect .remove() to clean up?
> 
> I can't think of anything wrong with calling pm_runtime_idle() at the
> end of __device_release_driver().

Yeah.

Thanks,
Rafael
