Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:58952 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753099Ab2HDUmI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 4 Aug 2012 16:42:08 -0400
Date: Sat, 4 Aug 2012 16:42:07 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
cc: linux-pci@vger.kernel.org, USB list <linux-usb@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>
Subject: Re: Do we need asynchronous pm_runtime_get()? (was: Re: bisected
 regression ...)
In-Reply-To: <201208042208.38784.rjw@sisk.pl>
Message-ID: <Pine.LNX.4.44L0.1208041628260.23711-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, 4 Aug 2012, Rafael J. Wysocki wrote:

> > What happens if a system sleep begins after 
> > pm_runtime_async_resume_and_call() but before the runtime resume?  When 
> > the system wakes up, the device will be back at full power without ever 
> > executing a runtime PM call.  Then how will func get invoked?
> 
> The pm_runtime_barrier() at the beginning of __device_suspend() guarantees
> that if there's a resume request pending at this point, the resume will be
> carried out.  I think we can modify rpm_resume() to return only after func()
> is executed, so there shouldn't be a problem with that particular case.

A resume request can get added to the workqueue after
__device_suspend() runs, in which case the problem will still exist.

Should pm_runtime_set_active() call func (if such a call is pending)?

> > What happens if the driver is unbound after
> > pm_runtime_async_resume_and_call() but before the runtime resume?  The
> > When the runtime resume occurs, func will be invoked -- and the driver
> > might not even be in memory any more.
> 
> We have no protection against that at the moment, but then there is no
> guarantee that the driver's runtime PM callbacks won't be run after
> it's been unbound.

True.  We have been relying on the subsystem to handle this race, but 
obviously that's no good if the callback is directly to the driver.  I 
don't see any way to fix this in the PM core.

> Perhaps we should run pm_runtime_barrier() before executing .remove()
> in __device_release_driver()

We already do pm_runtime_get_sync() and pm_runtime_put_sync().  I'm not 
sure how necessary those calls really are ... but pm_runtime_barrier() 
would be redundant.

>  (and perhaps run pm_runtime_idle() afterwards
> in case the subsystem or PM domain knows how to power down the device even if
> there's no driver) and expect .remove() to clean up?

I can't think of anything wrong with calling pm_runtime_idle() at the
end of __device_release_driver().

Alan Stern

