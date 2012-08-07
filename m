Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:45314 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751933Ab2HGRPd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 7 Aug 2012 13:15:33 -0400
Date: Tue, 7 Aug 2012 13:15:32 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
cc: Ming Lei <tom.leiming@gmail.com>, <linux-pci@vger.kernel.org>,
	USB list <linux-usb@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>
Subject: Re: Do we need asynchronous pm_runtime_get()? (was: Re: bisected
 regression ...)
In-Reply-To: <201208071428.42575.rjw@sisk.pl>
Message-ID: <Pine.LNX.4.44L0.1208071143170.2400-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 7 Aug 2012, Rafael J. Wysocki wrote:

> > > All those changes (and some of the following ones) are symptoms of a
> > > basic mistake in this approach.
> > 
> > Every time you say something like this (i.e. liks someone who knows better)
> 
> s/liks/like/
> 
> > I kind of feel like being under attach, which I hope is not your intention.
> 
> s/attach/attack/

Sorry; you're right.  It's all too easy to get very arrogant in email 
messages.  I'll try not to attack so strongly in the future.

> > > The idea of this new feature is to
> > > call "func" as soon as we know the device is at full power, no matter
> > > how it got there.
> > 
> > Yes, it is so.

Incidentally, that sentence is the justification for the invariance
condition mentioned later.  power.func should be called as soon as we
know the device is at full power; therefore when the status changes to
RPM_ACTIVE it should be called and then cleared (if it was set), and it
should never get set while the status is RPM_ACTIVE.  Therefore it
should never be true that power.func is set _and_ the status is
RPM_ACTIVE.

> > > That means we should call it near the end of
> > > rpm_resume() (just before the rpm_idle() call), not from within
> > > pm_runtime_work().
> > > 
> > > Doing it this way will be more efficient and (I think) will remove
> > > some races.
> > 
> > Except that func() shouldn't be executed under dev->power.lock, which makes it
> > rather difficult to call it from rpm_resume().  Or at least it seems so.
> > 
> > Moreover, it should be called after we've changed the status to RPM_ACTIVE
> > _and_ dropped the lock.
> 
> So we could drop the lock right before returning, execute func() and acquire
> the lock once again,

Yes; that's what I had in mind.  We already do something similar when 
calling pm_runtime_put(parent).

>  but then func() might be executed by any thread that
> happened to resume the device.  In that case the caller of
> pm_runtime_get_and_call() would have to worry about locks that such threads
> might acquire and it would have to make sure that func() didn't try to acquire
> them too.  That may not be a big deal, but if func() is executed by
> pm_runtime_work(), that issue simply goes away.

But then you have to worry about races between pm_runtime_resume() and
the workqueue.  If the device is resumed by some other thread, it
could be suspended again before "func" is called.

> Then, however, there's another issue: what should happen if
> pm_runtime_get_and_call() finds that it cannot execute func() right away,
> so it queues up resume and the execution of it, in the meantime some other
> thread resumes the device synchronously and pm_runtime_get_and_call() is
> run again.  I think in that case func() should be executed synchronously
> and the one waiting for execution should be canceled.  The alternative
> would be to return -EAGAIN from pm_runtime_get_and_call() and expect the
> caller to cope with that, which isn't too attractive.
> 
> This actually is analogous to the case when pm_runtime_get_and_call()
> sees that power.func is not NULL.  In my experimental patches it returned
> -EAGAIN in that case, but perhaps it's better to replace the existing
> power.func with the new one.  Then, by doing pm_runtime_get_and_call(dev, NULL)
> we can ensure that either the previous func() has run already or it will never
> run, which may be useful.

A good point.  I agree that pm_runtime_get_and_call() should always 
overwrite the existing power.func value.

There are a couple of other issues remaining.

What's the best approach when disable_count > 0?  My feeling is that we
should still rely on power.runtime_status as the best approximation to
the device's state, so we shouldn't call "func" directly unless the
status is already RPM_ACTIVE.  If the status is something else, we
can't queue an async resume request.  So we just set power.func and
return.  Eventually the driver will either call pm_runtime_set_active()
or pm_runtime_enable() followed by pm_runtime_resume(), at which time
we would call power.func.

Also, what should happen when power.runtime_error is set?  The same as
when disable_depth > 0?

You mentioned that pm_runtime_disable() does a resume if there's a 
pending resume request.  I had forgotten about this.  It worries me, 
because subsystems use code sequences like this:

	pm_runtime_disable(dev);
	pm_runtime_set_active(dev);
	pm_runtime_enable(dev);

in their system resume routines (in fact, we advise them to do so in
the Documentation file).  Now, it is unlikely for a resume request to
be pending during system sleep, but it doesn't seem to be impossible.  
When there is such a pending request, the pm_runtime_disable() call
will try to do a runtime resume at a time when the device has just been
restored to full power.  That's not good.

Probably this pattern occurs in few enough places that we could go
through and fix them all.  But how?  Should there be a new function:
pm_adjust_runtime_status_after_system_resume()?

Alan Stern

