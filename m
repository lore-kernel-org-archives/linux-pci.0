Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:36596 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932092Ab2HFPsY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 6 Aug 2012 11:48:24 -0400
Date: Mon, 6 Aug 2012 11:48:23 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
cc: Ming Lei <tom.leiming@gmail.com>, <linux-pci@vger.kernel.org>,
	USB list <linux-usb@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>
Subject: Re: Do we need asynchronous pm_runtime_get()? (was: Re: bisected
 regression ...)
In-Reply-To: <201208051726.22729.rjw@sisk.pl>
Message-ID: <Pine.LNX.4.44L0.1208061112230.1649-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, 5 Aug 2012, Rafael J. Wysocki wrote:

> I don't really think we'll need to store func_sync in dev->power.  At least
> I don't see a reason to do that at the moment.

You're right; I wasn't thinking straight.

> I also think that func_sync() would have to be called if runtime PM is
> disabled for the given device, so that callers don't have to check that
> condition themselves.

Yes.

> What about the appended experimental patch?

For now, I think it would be best to start with a single func argument.  
If it turns out that anyone really needs to have two separate
arguments, the single-argument form can be reimplemented on top of the
two-argument form easily enough.

> @@ -484,6 +484,15 @@ static int rpm_suspend(struct device *de
>  	goto out;
>  }
>  
> +void rpm_queue_up_resume(struct device *dev)
> +{
> +	dev->power.request = RPM_REQ_RESUME;
> +	if (!dev->power.request_pending) {
> +		dev->power.request_pending = true;
> +		queue_work(pm_wq, &dev->power.work);
> +	}
> +}
> +
>  /**
>   * rpm_resume - Carry out runtime resume of given device.
>   * @dev: Device to resume.
> @@ -524,7 +533,9 @@ static int rpm_resume(struct device *dev
>  	 * rather than cancelling it now only to restart it again in the near
>  	 * future.
>  	 */
> -	dev->power.request = RPM_REQ_NONE;
> +	if (dev->power.request != RPM_REQ_RESUME || !dev->power.func)
> +		dev->power.request = RPM_REQ_NONE;
> +
>  	if (!dev->power.timer_autosuspends)
>  		pm_runtime_deactivate_timer(dev);
>  
> @@ -533,6 +544,12 @@ static int rpm_resume(struct device *dev
>  		goto out;
>  	}
>  
> +	if (dev->power.func && (rpmflags & RPM_ASYNC)) {
> +		rpm_queue_up_resume(dev);
> +		retval = 0;
> +		goto out;
> +	}
> +
>  	if (dev->power.runtime_status == RPM_RESUMING
>  	    || dev->power.runtime_status == RPM_SUSPENDING) {
>  		DEFINE_WAIT(wait);

All those changes (and some of the following ones) are symptoms of a
basic mistake in this approach.  The idea of this new feature is to
call "func" as soon as we know the device is at full power, no matter
how it got there.  That means we should call it near the end of
rpm_resume() (just before the rpm_idle() call), not from within
pm_runtime_work().

Doing it this way will be more efficient and (I think) will remove
some races.

> @@ -877,6 +903,48 @@ int __pm_runtime_resume(struct device *d
>  }
>  EXPORT_SYMBOL_GPL(__pm_runtime_resume);
>  
> +int pm_runtime_get_and_call(struct device *dev, void (*func)(struct device *),
> +			     void (*func_async)(struct device *))
> +{
> +	unsigned long flags;
> +	int ret;
> +
> +	atomic_inc(&dev->power.usage_count);
> +
> +	spin_lock_irqsave(&dev->power.lock, flags);
> +
> +	ret = dev->power.runtime_error;
> +	if (ret) {
> +		func = NULL;
> +		goto out;
> +	}
> +
> +	if (dev->power.runtime_status != RPM_ACTIVE
> +	    && dev->power.disable_depth == 0)
> +		func = NULL;
> +
> +	if (!func && func_async) {
> +		if (dev->power.func) {
> +			ret = -EAGAIN;
> +			goto out;
> +		} else {
> +			dev->power.func = func_async;
> +		}
> +	}

The logic here is kind of hard to follow.  It will be simpler when
there's only one "func":

	If the status is RPM_ACTIVE or disable_depth > 0 then
	call "func" directly.

	Otherwise save "func" in dev.power and do an async resume.

Some more things:

In __pm_runtime_set_status(), if power.func is set then I think we
should call it if the new status is ACTIVE.  Likwise at the end of
rpm_suspend(), if the suspend fails.  There should be an invariant:
Whenever the status is RPM_ACTIVE, power.func must be NULL.

pm_runtime_barrier() should always clear power.func, even if the 
rpm_resume() call fails.

The documentation should explain that in some ways, "func" is like a
workqueue callback routine: Subsystems and drivers have to be careful
to make sure that it can't be invoked after the device is unbound.  A
safe way to do this is to call pm_runtime_barrier() from within the
driver's .remove() routine, after making sure that
pm_runtime_get_and_call() won't be invoked any more.

Alan Stern

