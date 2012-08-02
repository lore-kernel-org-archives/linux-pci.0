Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:54002 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751744Ab2HBUQm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 2 Aug 2012 16:16:42 -0400
Date: Thu, 2 Aug 2012 16:16:41 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
cc: linux-pci@vger.kernel.org, USB list <linux-usb@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>
Subject: Re: Do we need asynchronous pm_runtime_get()? (was: Re: bisected
 regression ...)
In-Reply-To: <201208012324.01329.rjw@sisk.pl>
Message-ID: <Pine.LNX.4.44L0.1208021546100.1177-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 1 Aug 2012, Rafael J. Wysocki wrote:

> What I really thought about was to do _get_noresume(), then check if the
> device is active and if not, queue up a work item (or another delayed
> execution in process context) that will do pm_runtime_resume() and
> then access the hardware.
> 
> Why do I think it's better than plain pm_runtime_get()?  Because the code
> path calling pm_runtime_resume() will know that it is safe to access the
> hardware after it has returned (unless it returns an error code, but
> that's exceptional).
> 
> In contrast, with pm_runtime_get() there is no way to predict when the
> device is going to be resumed, so if the device happens to be suspended
> when pm_runtime_get() returns, the driver kind of has to poll it until
> it becomes active, or use a wait queue woken up from the resume callback,
> or do all of the processing in the resume callback itself (like in the
> example you mentioned).  I'm not sure if the expectation that all driver
> writers will be able to implement any of these options correctly is a realistic
> one.

I don't know about that -- the logic involved in doing the processing 
within the resume callback isn't terribly complicated.  At least, not 
much more complicated than the logic involved in setting up a custom 
work routine as you suggest.

Anyway with the existing code, driver writers are free to choose 
whichever approach they prefer.

> > Check out the sample driver code in section 9 of 
> > Documentation/power/runtime_pm.txt, especially the foo_read_or_write() 
> > routine.
> 
> Well, that shouldn't need the is_suspended flag at all, methinks, and the
> reason it does need it is because it uses pm_runtime_get().

Not so.  Consider your scheme.  When starting an I/O request, you call
pm_runtime_get_noresume() and then check to see if the device is
active, say by calling pm_runtime_suspended().  Suppose at that moment
the suspend callback has just finished and has released the private
spinlock.  The device's status is still RPM_SUSPENDING, so
pm_runtime_suspended() returns 0 and you try to carry out the I/O.

To fix this problem you have to synchronize the status checking with
the suspend/resume operations.  This means the status changes have to
occur under the protection of the private lock, which means a private
flag is needed.

>  Moreover,
> processing requests in the resume callback is not something I'd recommend
> to anyone, because that's going to happen when the status of the device
> is RPM_RESUMING, we're holding a reference on the parent (if there's one) etc.

I don't see any problem with that.  The parent's child_count will be 
incremented while the requests are being processed regardless.  And if 
you've been waiting for the device to resume in order to carry out some 
processing, within the resume callback is the logical place to do the 
work.  It avoids the overhead of a second context switch.

> So, it looks like I don't really agree with the example. :-)

Feel free to add your scheme as a second example in the document.  :-)
But please don't remove the first example, unless you can find 
something actually wrong with it.

> > While you're changing names around, consider also adding a "_runtime"  
> > somewhere to:
> > 
> > 	pm_children_suspended,
> > 	pm_schedule_suspend,
> > 	pm_request_idle,
> > 	pm_request_resume,
> > 	pm_request_autosuspend.
> > 
> > For example, we could have pm_runtime_idle_async instead of 
> > pm_request_idle.
> 
> Well, these are not as misleading as pm_runtime_get(), at least in principle.

No, but it would be good to be more consistent about our naming.  
Making sure all the function names contain "_runtime" would help.

I suppose we could keep pm_runtime_get_sync as is, and just change
pm_runtime_get to pm_runtime_get_async (and likewise for _put).  That
could reduce the confusion during the changeover.

Alan Stern

