Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:44709 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755937Ab2HFUZK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 6 Aug 2012 16:25:10 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Do we need asynchronous pm_runtime_get()? (was: Re: bisected regression ...)
Date: Mon, 6 Aug 2012 22:30:58 +0200
Cc: Ming Lei <tom.leiming@gmail.com>, linux-pci@vger.kernel.org,
	USB list <linux-usb@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>
References: <Pine.LNX.4.44L0.1208061112230.1649-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1208061112230.1649-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201208062230.58553.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday, August 06, 2012, Alan Stern wrote:
> On Sun, 5 Aug 2012, Rafael J. Wysocki wrote:
[...]
> 
> > What about the appended experimental patch?
> 
> For now, I think it would be best to start with a single func argument.  
> If it turns out that anyone really needs to have two separate
> arguments, the single-argument form can be reimplemented on top of the
> two-argument form easily enough.

All right.

> > @@ -484,6 +484,15 @@ static int rpm_suspend(struct device *de
> >  	goto out;
> >  }
> >  
> > +void rpm_queue_up_resume(struct device *dev)
> > +{
> > +	dev->power.request = RPM_REQ_RESUME;
> > +	if (!dev->power.request_pending) {
> > +		dev->power.request_pending = true;
> > +		queue_work(pm_wq, &dev->power.work);
> > +	}
> > +}
> > +
> >  /**
> >   * rpm_resume - Carry out runtime resume of given device.
> >   * @dev: Device to resume.
> > @@ -524,7 +533,9 @@ static int rpm_resume(struct device *dev
> >  	 * rather than cancelling it now only to restart it again in the near
> >  	 * future.
> >  	 */
> > -	dev->power.request = RPM_REQ_NONE;
> > +	if (dev->power.request != RPM_REQ_RESUME || !dev->power.func)
> > +		dev->power.request = RPM_REQ_NONE;
> > +
> >  	if (!dev->power.timer_autosuspends)
> >  		pm_runtime_deactivate_timer(dev);
> >  
> > @@ -533,6 +544,12 @@ static int rpm_resume(struct device *dev
> >  		goto out;
> >  	}
> >  
> > +	if (dev->power.func && (rpmflags & RPM_ASYNC)) {
> > +		rpm_queue_up_resume(dev);
> > +		retval = 0;
> > +		goto out;
> > +	}
> > +
> >  	if (dev->power.runtime_status == RPM_RESUMING
> >  	    || dev->power.runtime_status == RPM_SUSPENDING) {
> >  		DEFINE_WAIT(wait);
> 
> All those changes (and some of the following ones) are symptoms of a
> basic mistake in this approach.

Every time you say something like this (i.e. liks someone who knows better)
I kind of feel like being under attach, which I hope is not your intention.
Never mind. :-)

Those changes are there for different reasons rather unrelated to the way
func() is being called, so let me explain.

First, rpm_queue_up_resume() is introduced, because the code it contains will
have to be called in two different places.  At least I don't see how to avoid
that without increasing the code complexity too much.

Second, the following change in rpm_resume()

-	dev->power.request = RPM_REQ_NONE;
+	if (dev->power.request != RPM_REQ_RESUME || !dev->power.func)
+		dev->power.request = RPM_REQ_NONE;

is made to prevent rpm_resume() from canceling the execution of func() queued
up by an earlier pm_runtime_get_and_call().  I believe it is necessary.

Finally, this change in rpm_resume():
 
+	if (dev->power.func && (rpmflags & RPM_ASYNC)) {
+		rpm_queue_up_resume(dev);
+		retval = 0;
+		goto out;
+	}

is not strictly necessary if pm_runtime_get_and_call() is modified to run
rpm_queue_up_resume() directly, like in the new version of the patch which is
appended.  This reduces the number of checks overall, so perhaps it's better.

> The idea of this new feature is to
> call "func" as soon as we know the device is at full power, no matter
> how it got there.

Yes, it is so.

> That means we should call it near the end of
> rpm_resume() (just before the rpm_idle() call), not from within
> pm_runtime_work().
> 
> Doing it this way will be more efficient and (I think) will remove
> some races.

Except that func() shouldn't be executed under dev->power.lock, which makes it
rather difficult to call it from rpm_resume().  Or at least it seems so.

Moreover, it should be called after we've changed the status to RPM_ACTIVE
_and_ dropped the lock.

Besides, I'd like to know what races you're referring to (perhaps you're seeing
some more of them than I am).

> > @@ -877,6 +903,48 @@ int __pm_runtime_resume(struct device *d
> >  }
> >  EXPORT_SYMBOL_GPL(__pm_runtime_resume);
> >  
> > +int pm_runtime_get_and_call(struct device *dev, void (*func)(struct device *),
> > +			     void (*func_async)(struct device *))
> > +{
> > +	unsigned long flags;
> > +	int ret;
> > +
> > +	atomic_inc(&dev->power.usage_count);
> > +
> > +	spin_lock_irqsave(&dev->power.lock, flags);
> > +
> > +	ret = dev->power.runtime_error;
> > +	if (ret) {
> > +		func = NULL;
> > +		goto out;
> > +	}
> > +
> > +	if (dev->power.runtime_status != RPM_ACTIVE
> > +	    && dev->power.disable_depth == 0)
> > +		func = NULL;
> > +
> > +	if (!func && func_async) {
> > +		if (dev->power.func) {
> > +			ret = -EAGAIN;
> > +			goto out;
> > +		} else {
> > +			dev->power.func = func_async;
> > +		}
> > +	}
> 
> The logic here is kind of hard to follow.  It will be simpler when
> there's only one "func":
> 
> 	If the status is RPM_ACTIVE or disable_depth > 0 then
> 	call "func" directly.
> 
> 	Otherwise save "func" in dev.power and do an async resume.

Yeah.  But do not run func() under power.lock, right?

> Some more things:
> 
> In __pm_runtime_set_status(), if power.func is set then I think we
> should call it if the new status is ACTIVE.

__pm_runtime_set_status() only works if power.disable_depth > 0, in
which case func() will be called synchronously.  Now, if someone does
pm_runtime_get_and_call() immediately followed by pm_runtime_disable()
(perhaps from a different thread), then __pm_runtime_disable() will
resume the device, so it's better to call func() from there if set,
I think.  And clear power.func afterwards.

> Likwise at the end of rpm_suspend(), if the suspend fails.

The only way by which power.func can be different from NULL at that point
is when the work item queued up by pm_runtime_get_and_call() runs after
rpm_suspend() has changed the status to RPM_SUSPENDING.  However in that
case the rpm_resume(dev, 0) in pm_runtime_work() will wait for the
suspend to complete (or fail) and func() will be run when it returns.

> There should be an invariant: Whenever the status is RPM_ACTIVE,
> power.func must be NULL.

Well, maybe so, but I don't see why right now.

> pm_runtime_barrier() should always clear power.func, even if the 
> rpm_resume() call fails.

Wouldn't it be better to wait for func() to be run?

> The documentation should explain that in some ways, "func" is like a
> workqueue callback routine: Subsystems and drivers have to be careful
> to make sure that it can't be invoked after the device is unbound.  A
> safe way to do this is to call pm_runtime_barrier() from within the
> driver's .remove() routine, after making sure that
> pm_runtime_get_and_call() won't be invoked any more.

Sure.

The appended patch doesn't contain any changes in __pm_runtime_disable()
or pm_runtime_barrier(), but you are right that they are necessary.

Thanks,
Rafael


---
 drivers/base/power/runtime.c |   98 ++++++++++++++++++++++++++++++++++++++-----
 include/linux/pm.h           |    1 
 include/linux/pm_runtime.h   |   11 ++++
 3 files changed, 99 insertions(+), 11 deletions(-)

Index: linux/drivers/base/power/runtime.c
===================================================================
--- linux.orig/drivers/base/power/runtime.c
+++ linux/drivers/base/power/runtime.c
@@ -484,6 +484,15 @@ static int rpm_suspend(struct device *de
 	goto out;
 }
 
+void rpm_queue_up_resume(struct device *dev)
+{
+	dev->power.request = RPM_REQ_RESUME;
+	if (!dev->power.request_pending) {
+		dev->power.request_pending = true;
+		queue_work(pm_wq, &dev->power.work);
+	}
+}
+
 /**
  * rpm_resume - Carry out runtime resume of given device.
  * @dev: Device to resume.
@@ -519,12 +528,18 @@ static int rpm_resume(struct device *dev
 		goto out;
 
 	/*
-	 * Other scheduled or pending requests need to be canceled.  Small
-	 * optimization: If an autosuspend timer is running, leave it running
-	 * rather than cancelling it now only to restart it again in the near
-	 * future.
+	 * Other scheduled or pending requests need to be canceled.  If the
+	 * execution of a function is queued up along with a resume request,
+	 * do not cancel it.
+	 */
+	if (dev->power.request != RPM_REQ_RESUME || !dev->power.func)
+		dev->power.request = RPM_REQ_NONE;
+
+	/*
+	 * Small optimization: If an autosuspend timer is running, leave it
+	 * running rather than cancelling it now only to restart it again in the
+	 * near future.
 	 */
-	dev->power.request = RPM_REQ_NONE;
 	if (!dev->power.timer_autosuspends)
 		pm_runtime_deactivate_timer(dev);
 
@@ -591,11 +606,7 @@ static int rpm_resume(struct device *dev
 
 	/* Carry out an asynchronous or a synchronous resume. */
 	if (rpmflags & RPM_ASYNC) {
-		dev->power.request = RPM_REQ_RESUME;
-		if (!dev->power.request_pending) {
-			dev->power.request_pending = true;
-			queue_work(pm_wq, &dev->power.work);
-		}
+		rpm_queue_up_resume(dev);
 		retval = 0;
 		goto out;
 	}
@@ -691,6 +702,7 @@ static int rpm_resume(struct device *dev
 static void pm_runtime_work(struct work_struct *work)
 {
 	struct device *dev = container_of(work, struct device, power.work);
+	void (*func)(struct device *) = NULL;
 	enum rpm_request req;
 
 	spin_lock_irq(&dev->power.lock);
@@ -715,12 +727,24 @@ static void pm_runtime_work(struct work_
 		rpm_suspend(dev, RPM_NOWAIT | RPM_AUTO);
 		break;
 	case RPM_REQ_RESUME:
-		rpm_resume(dev, RPM_NOWAIT);
+		func = dev->power.func;
+		if (func) {
+			dev->power.func = NULL;
+			pm_runtime_get_noresume(dev);
+			rpm_resume(dev, 0);
+		} else {
+			rpm_resume(dev, RPM_NOWAIT);
+		}
 		break;
 	}
 
  out:
 	spin_unlock_irq(&dev->power.lock);
+
+	if (func) {
+		func(dev);
+		pm_runtime_put(dev);
+	}
 }
 
 /**
@@ -877,6 +901,58 @@ int __pm_runtime_resume(struct device *d
 }
 EXPORT_SYMBOL_GPL(__pm_runtime_resume);
 
+int pm_runtime_get_and_call(struct device *dev, void (*func)(struct device *))
+{
+	unsigned long flags;
+	bool sync = false;
+	int ret;
+
+	atomic_inc(&dev->power.usage_count);
+
+	spin_lock_irqsave(&dev->power.lock, flags);
+
+	ret = dev->power.runtime_error;
+	if (ret)
+		goto out;
+
+	sync = dev->power.runtime_status == RPM_ACTIVE
+		|| dev->power.disable_depth > 0;
+
+	if (!sync) {
+		if (dev->power.func) {
+			ret = -EAGAIN;
+			goto out;
+		} else {
+			dev->power.func = func;
+		}
+	}
+
+	/*
+	 * The approach here is the same as in rpm_suspend(): autosuspend timers
+	 * will be activated shortly anyway, so it is pointless to cancel them
+	 * now.
+	 */
+	if (!dev->power.timer_autosuspends)
+		pm_runtime_deactivate_timer(dev);
+
+	if (sync)
+		dev->power.request = RPM_REQ_NONE;
+	else
+		rpm_queue_up_resume(dev);
+
+ out:
+	spin_unlock_irqrestore(&dev->power.lock, flags);
+
+	if (sync) {
+		if (func)
+			func(dev);
+
+		return 1;
+	}
+
+	return ret;
+}
+
 /**
  * __pm_runtime_set_status - Set runtime PM status of a device.
  * @dev: Device to handle.
Index: linux/include/linux/pm.h
===================================================================
--- linux.orig/include/linux/pm.h
+++ linux/include/linux/pm.h
@@ -547,6 +547,7 @@ struct dev_pm_info {
 	unsigned long		suspended_jiffies;
 	unsigned long		accounting_timestamp;
 	struct dev_pm_qos_request *pq_req;
+	void			(*func)(struct device *);
 #endif
 	struct pm_subsys_data	*subsys_data;  /* Owned by the subsystem. */
 	struct pm_qos_constraints *constraints;
Index: linux/include/linux/pm_runtime.h
===================================================================
--- linux.orig/include/linux/pm_runtime.h
+++ linux/include/linux/pm_runtime.h
@@ -47,6 +47,8 @@ extern void pm_runtime_set_autosuspend_d
 extern unsigned long pm_runtime_autosuspend_expiration(struct device *dev);
 extern void pm_runtime_update_max_time_suspended(struct device *dev,
 						 s64 delta_ns);
+extern int pm_runtime_get_and_call(struct device *dev,
+				   void (*func)(struct device *));
 
 static inline bool pm_children_suspended(struct device *dev)
 {
@@ -150,6 +152,15 @@ static inline void pm_runtime_set_autosu
 static inline unsigned long pm_runtime_autosuspend_expiration(
 				struct device *dev) { return 0; }
 
+static inline int pm_runtime_get_and_call(struct device *dev,
+					  void (*func)(struct device *))
+{
+	if (func)
+		func(dev);
+
+	return 1;
+}
+
 #endif /* !CONFIG_PM_RUNTIME */
 
 static inline int pm_runtime_idle(struct device *dev)

