Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:40073 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752991Ab2HBVUm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 2 Aug 2012 17:20:42 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Do we need asynchronous pm_runtime_get()? (was: Re: bisected regression ...)
Date: Thu, 2 Aug 2012 23:26:31 +0200
Cc: linux-pci@vger.kernel.org, USB list <linux-usb@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>
References: <Pine.LNX.4.44L0.1208021546100.1177-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1208021546100.1177-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201208022326.31178.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, August 02, 2012, Alan Stern wrote:
> On Wed, 1 Aug 2012, Rafael J. Wysocki wrote:
> 
> > What I really thought about was to do _get_noresume(), then check if the
> > device is active and if not, queue up a work item (or another delayed
> > execution in process context) that will do pm_runtime_resume() and
> > then access the hardware.
> > 
> > Why do I think it's better than plain pm_runtime_get()?  Because the code
> > path calling pm_runtime_resume() will know that it is safe to access the
> > hardware after it has returned (unless it returns an error code, but
> > that's exceptional).
> > 
> > In contrast, with pm_runtime_get() there is no way to predict when the
> > device is going to be resumed, so if the device happens to be suspended
> > when pm_runtime_get() returns, the driver kind of has to poll it until
> > it becomes active, or use a wait queue woken up from the resume callback,
> > or do all of the processing in the resume callback itself (like in the
> > example you mentioned).  I'm not sure if the expectation that all driver
> > writers will be able to implement any of these options correctly is a realistic
> > one.
> 
> I don't know about that -- the logic involved in doing the processing 
> within the resume callback isn't terribly complicated.  At least, not 
> much more complicated than the logic involved in setting up a custom 
> work routine as you suggest.

That's why I had the idea of pm_request_resume_and_call(dev, func)
described in this message:

http://marc.info/?l=linux-usb&m=134377126804170&w=4

although perheps it would be better to call it something like
pm_runtime_async_resume_and_call(dev, func).

> Anyway with the existing code, driver writers are free to choose 
> whichever approach they prefer.

I wonder how many instances of pm_runtime_get() used in a wrong way there
are in the kernel right now.  I guess I'll sacrifice some time to check
that.

> > > Check out the sample driver code in section 9 of 
> > > Documentation/power/runtime_pm.txt, especially the foo_read_or_write() 
> > > routine.
> > 
> > Well, that shouldn't need the is_suspended flag at all, methinks, and the
> > reason it does need it is because it uses pm_runtime_get().
> 
> Not so.  Consider your scheme.  When starting an I/O request, you call
> pm_runtime_get_noresume() and then check to see if the device is
> active, say by calling pm_runtime_suspended().  Suppose at that moment
> the suspend callback has just finished and has released the private
> spinlock.  The device's status is still RPM_SUSPENDING, so
> pm_runtime_suspended() returns 0 and you try to carry out the I/O.
> 
> To fix this problem you have to synchronize the status checking with
> the suspend/resume operations.  This means the status changes have to
> occur under the protection of the private lock, which means a private
> flag is needed.

What about checking if the status is RPM_ACTIVE under dev->power.lock?
That's what rpm_resume() does, more or less.

> >  Moreover,
> > processing requests in the resume callback is not something I'd recommend
> > to anyone, because that's going to happen when the status of the device
> > is RPM_RESUMING, we're holding a reference on the parent (if there's one) etc.
> 
> I don't see any problem with that.  The parent's child_count will be 
> incremented while the requests are being processed regardless.  And if 
> you've been waiting for the device to resume in order to carry out some 
> processing, within the resume callback is the logical place to do the 
> work.

Unless your _driver_ callback is actually executed from within a PM domain
callback, for example, and something else may be waiting for it to complete,
so your data processing is adding latencies to some other threads.  I'm not
making that up, by the way, that really can happen.

And what if you are a parent waited for by a child to resume so that _it_
can process its data?  Would you still want to process your data in the
resume callback in that case?

> It avoids the overhead of a second context switch.

That may be avoided without processing data from within the resume callback,
although not with the current code.

> > So, it looks like I don't really agree with the example. :-)
> 
> Feel free to add your scheme as a second example in the document.  :-)
> But please don't remove the first example, unless you can find 
> something actually wrong with it.

Well, it should work in general, so it is not functionally wrong.  However,
I wouldn't like to regard it as the best thing we can offer. :-)

> > > While you're changing names around, consider also adding a "_runtime"  
> > > somewhere to:
> > > 
> > > 	pm_children_suspended,
> > > 	pm_schedule_suspend,
> > > 	pm_request_idle,
> > > 	pm_request_resume,
> > > 	pm_request_autosuspend.
> > > 
> > > For example, we could have pm_runtime_idle_async instead of 
> > > pm_request_idle.
> > 
> > Well, these are not as misleading as pm_runtime_get(), at least in principle.
> 
> No, but it would be good to be more consistent about our naming.  
> Making sure all the function names contain "_runtime" would help.
> 
> I suppose we could keep pm_runtime_get_sync as is, and just change
> pm_runtime_get to pm_runtime_get_async (and likewise for _put).  That
> could reduce the confusion during the changeover.

Changing pm_runtime_get() to pm_runtime_get_async() would be an improvement,
although pm_runtime_get_but_do_not_resume_immediately() might even be better.
Or even pm_runtime_get_but_do_not_access_hardware_when_it_returns(). ;-)

I see no reason to have any of those things, though.  Yes, they _may_ be
useful to someone knowing the runtime PM core internals to save a few lines
of code in some places, but generally they lead people to make serious mistakes
that tend to be difficult to debug.  For this very reason pm_runtime_get() is a
bad interface and I wish we hadn't introduced it at all.  Even if we give it
a more descriptive name, it won't be much better.

And note how that doesn't apply to the pm_runtime_put*() family.  After all,
doing pm_runtime_put() instead of pm_runtime_put_sync() will never lead to
accessing registers of a suspended device.

Thanks,
Rafael
