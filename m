Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:46017 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751690Ab2HGMWt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 7 Aug 2012 08:22:49 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Do we need asynchronous pm_runtime_get()? (was: Re: bisected regression ...)
Date: Tue, 7 Aug 2012 14:28:42 +0200
Cc: Ming Lei <tom.leiming@gmail.com>, linux-pci@vger.kernel.org,
	USB list <linux-usb@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>
References: <Pine.LNX.4.44L0.1208061112230.1649-100000@iolanthe.rowland.org> <201208062230.58553.rjw@sisk.pl>
In-Reply-To: <201208062230.58553.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201208071428.42575.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday, August 06, 2012, Rafael J. Wysocki wrote:
> On Monday, August 06, 2012, Alan Stern wrote:
> > On Sun, 5 Aug 2012, Rafael J. Wysocki wrote:
> [...]
> > 
> > > What about the appended experimental patch?
> > 
> > For now, I think it would be best to start with a single func argument.  
> > If it turns out that anyone really needs to have two separate
> > arguments, the single-argument form can be reimplemented on top of the
> > two-argument form easily enough.
> 
> All right.
> 
> > > @@ -484,6 +484,15 @@ static int rpm_suspend(struct device *de
> > >  	goto out;
> > >  }
> > >  
> > > +void rpm_queue_up_resume(struct device *dev)
> > > +{
> > > +	dev->power.request = RPM_REQ_RESUME;
> > > +	if (!dev->power.request_pending) {
> > > +		dev->power.request_pending = true;
> > > +		queue_work(pm_wq, &dev->power.work);
> > > +	}
> > > +}
> > > +
> > >  /**
> > >   * rpm_resume - Carry out runtime resume of given device.
> > >   * @dev: Device to resume.
> > > @@ -524,7 +533,9 @@ static int rpm_resume(struct device *dev
> > >  	 * rather than cancelling it now only to restart it again in the near
> > >  	 * future.
> > >  	 */
> > > -	dev->power.request = RPM_REQ_NONE;
> > > +	if (dev->power.request != RPM_REQ_RESUME || !dev->power.func)
> > > +		dev->power.request = RPM_REQ_NONE;
> > > +
> > >  	if (!dev->power.timer_autosuspends)
> > >  		pm_runtime_deactivate_timer(dev);
> > >  
> > > @@ -533,6 +544,12 @@ static int rpm_resume(struct device *dev
> > >  		goto out;
> > >  	}
> > >  
> > > +	if (dev->power.func && (rpmflags & RPM_ASYNC)) {
> > > +		rpm_queue_up_resume(dev);
> > > +		retval = 0;
> > > +		goto out;
> > > +	}
> > > +
> > >  	if (dev->power.runtime_status == RPM_RESUMING
> > >  	    || dev->power.runtime_status == RPM_SUSPENDING) {
> > >  		DEFINE_WAIT(wait);
> > 
> > All those changes (and some of the following ones) are symptoms of a
> > basic mistake in this approach.
> 
> Every time you say something like this (i.e. liks someone who knows better)

s/liks/like/

> I kind of feel like being under attach, which I hope is not your intention.

s/attach/attack/

Two typos in one sentence, I guess it could have been worse ...

> Never mind. :-)
> 
> Those changes are there for different reasons rather unrelated to the way
> func() is being called, so let me explain.
> 
> First, rpm_queue_up_resume() is introduced, because the code it contains will
> have to be called in two different places.  At least I don't see how to avoid
> that without increasing the code complexity too much.
> 
> Second, the following change in rpm_resume()
> 
> -	dev->power.request = RPM_REQ_NONE;
> +	if (dev->power.request != RPM_REQ_RESUME || !dev->power.func)
> +		dev->power.request = RPM_REQ_NONE;
> 
> is made to prevent rpm_resume() from canceling the execution of func() queued
> up by an earlier pm_runtime_get_and_call().  I believe it is necessary.
> 
> Finally, this change in rpm_resume():
>  
> +	if (dev->power.func && (rpmflags & RPM_ASYNC)) {
> +		rpm_queue_up_resume(dev);
> +		retval = 0;
> +		goto out;
> +	}
> 
> is not strictly necessary if pm_runtime_get_and_call() is modified to run
> rpm_queue_up_resume() directly, like in the new version of the patch which is
> appended.  This reduces the number of checks overall, so perhaps it's better.
> 
> > The idea of this new feature is to
> > call "func" as soon as we know the device is at full power, no matter
> > how it got there.
> 
> Yes, it is so.
> 
> > That means we should call it near the end of
> > rpm_resume() (just before the rpm_idle() call), not from within
> > pm_runtime_work().
> > 
> > Doing it this way will be more efficient and (I think) will remove
> > some races.
> 
> Except that func() shouldn't be executed under dev->power.lock, which makes it
> rather difficult to call it from rpm_resume().  Or at least it seems so.
> 
> Moreover, it should be called after we've changed the status to RPM_ACTIVE
> _and_ dropped the lock.

So we could drop the lock right before returning, execute func() and acquire
the lock once again, but then func() might be executed by any thread that
happened to resume the device.  In that case the caller of
pm_runtime_get_and_call() would have to worry about locks that such threads
might acquire and it would have to make sure that func() didn't try to acquire
them too.  That may not be a big deal, but if func() is executed by
pm_runtime_work(), that issue simply goes away.

Then, however, there's another issue: what should happen if
pm_runtime_get_and_call() finds that it cannot execute func() right away,
so it queues up resume and the execution of it, in the meantime some other
thread resumes the device synchronously and pm_runtime_get_and_call() is
run again.  I think in that case func() should be executed synchronously
and the one waiting for execution should be canceled.  The alternative
would be to return -EAGAIN from pm_runtime_get_and_call() and expect the
caller to cope with that, which isn't too attractive.

This actually is analogous to the case when pm_runtime_get_and_call()
sees that power.func is not NULL.  In my experimental patches it returned
-EAGAIN in that case, but perhaps it's better to replace the existing
power.func with the new one.  Then, by doing pm_runtime_get_and_call(dev, NULL)
we can ensure that either the previous func() has run already or it will never
run, which may be useful.

Well, I guess I need to prepare a new experimantal patch. :-)

I'll send it in a new thread I think.

Thanks,
Rafael
