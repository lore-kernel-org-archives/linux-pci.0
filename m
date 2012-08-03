Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:55905 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751929Ab2HCCUX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 2 Aug 2012 22:20:23 -0400
Date: Thu, 2 Aug 2012 22:20:22 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
cc: linux-pci@vger.kernel.org, USB list <linux-usb@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>
Subject: Re: Do we need asynchronous pm_runtime_get()? (was: Re: bisected
 regression ...)
In-Reply-To: <201208022326.31178.rjw@sisk.pl>
Message-ID: <Pine.LNX.4.44L0.1208022151450.22991-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2 Aug 2012, Rafael J. Wysocki wrote:

> > I don't know about that -- the logic involved in doing the processing 
> > within the resume callback isn't terribly complicated.  At least, not 
> > much more complicated than the logic involved in setting up a custom 
> > work routine as you suggest.
> 
> That's why I had the idea of pm_request_resume_and_call(dev, func)
> described in this message:
> 
> http://marc.info/?l=linux-usb&m=134377126804170&w=4
> 
> although perheps it would be better to call it something like
> pm_runtime_async_resume_and_call(dev, func).

Hmmm.  You'd probably want a version that does a "get" at the same 
time.  I suppose you would call func directly if the device was already 
resumed, without going through the workqueue?

Yes, I agree this would be a better interface then pm_runtime_get.

> > > Well, that shouldn't need the is_suspended flag at all, methinks, and the
> > > reason it does need it is because it uses pm_runtime_get().
> > 
> > Not so.  Consider your scheme.  When starting an I/O request, you call
> > pm_runtime_get_noresume() and then check to see if the device is
> > active, say by calling pm_runtime_suspended().  Suppose at that moment
> > the suspend callback has just finished and has released the private
> > spinlock.  The device's status is still RPM_SUSPENDING, so
> > pm_runtime_suspended() returns 0 and you try to carry out the I/O.
> > 
> > To fix this problem you have to synchronize the status checking with
> > the suspend/resume operations.  This means the status changes have to
> > occur under the protection of the private lock, which means a private
> > flag is needed.
> 
> What about checking if the status is RPM_ACTIVE under dev->power.lock?
> That's what rpm_resume() does, more or less.

That wouldn't solve the race described above.

> > >  Moreover,
> > > processing requests in the resume callback is not something I'd recommend
> > > to anyone, because that's going to happen when the status of the device
> > > is RPM_RESUMING, we're holding a reference on the parent (if there's one) etc.
> > 
> > I don't see any problem with that.  The parent's child_count will be 
> > incremented while the requests are being processed regardless.  And if 
> > you've been waiting for the device to resume in order to carry out some 
> > processing, within the resume callback is the logical place to do the 
> > work.
> 
> Unless your _driver_ callback is actually executed from within a PM domain
> callback, for example, and something else may be waiting for it to complete,
> so your data processing is adding latencies to some other threads.  I'm not
> making that up, by the way, that really can happen.
> 
> And what if you are a parent waited for by a child to resume so that _it_
> can process its data?  Would you still want to process your data in the
> resume callback in that case?

Okay, those are valid reasons.  (Although a device handling I/O 
requests isn't likely to have a child with its own independent I/O 
handling.)

> > I suppose we could keep pm_runtime_get_sync as is, and just change
> > pm_runtime_get to pm_runtime_get_async (and likewise for _put).  That
> > could reduce the confusion during the changeover.
> 
> Changing pm_runtime_get() to pm_runtime_get_async() would be an improvement,
> although pm_runtime_get_but_do_not_resume_immediately() might even be better.
> Or even pm_runtime_get_but_do_not_access_hardware_when_it_returns(). ;-)
> 
> I see no reason to have any of those things, though.  Yes, they _may_ be
> useful to someone knowing the runtime PM core internals to save a few lines
> of code in some places, but generally they lead people to make serious mistakes
> that tend to be difficult to debug.  For this very reason pm_runtime_get() is a
> bad interface and I wish we hadn't introduced it at all.  Even if we give it
> a more descriptive name, it won't be much better.
> 
> And note how that doesn't apply to the pm_runtime_put*() family.  After all,
> doing pm_runtime_put() instead of pm_runtime_put_sync() will never lead to
> accessing registers of a suspended device.

All right.  But I still think "pm_runtime_put_async" is better than
"pm_runtime_put".  At least it forces people to think about what
they're doing.

Alan Stern

