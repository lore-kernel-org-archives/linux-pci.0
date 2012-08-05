Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:42565 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754531Ab2HEPUa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 5 Aug 2012 11:20:30 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Do we need asynchronous pm_runtime_get()? (was: Re: bisected regression ...)
Date: Sun, 5 Aug 2012 17:26:22 +0200
Cc: Ming Lei <tom.leiming@gmail.com>, linux-pci@vger.kernel.org,
	USB list <linux-usb@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>
References: <Pine.LNX.4.44L0.1208041806490.23711-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1208041806490.23711-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201208051726.22729.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sunday, August 05, 2012, Alan Stern wrote:
> On Sat, 4 Aug 2012, Rafael J. Wysocki wrote:
> 
> > On Saturday, August 04, 2012, Alan Stern wrote:
> > > On Sat, 4 Aug 2012, Rafael J. Wysocki wrote:
> > > 
> > > > > That wasn't what he meant.  What if the code needs to run in the _same_
> > > > > context as the caller?  For example, with a spinlock held.
> > > > 
> > > > I see.  I think it wouldn't be unreasonable to require that func should take
> > > > all of the necessary locks by itself.
> > > 
> > > But then if func was called directly, because the device was at full
> > > power, it would deadlock trying to acquire a lock the caller already
> > > holds.
> > 
> > I wonder why the caller may want to take any locks beforehand?
> 
> Who knows?  :-)
> 
> The best answer may be for the caller not to hold any locks.  In the
> runtime-PM document's example driver, the lock would be dropped before
> the resume-and-call.
> 
> > > Do you have any better suggestions?
> > 
> > Hmm.  What about pm_runtime_get_and_call(dev, func_sync, func_async), where
> > func_sync() is to be called if the device is already active and func_async()
> > is to be called if it has to be resumed from the workqueue?
> 
> That's a little better but not much.  It would require storing two 
> function pointers in the dev->power structure.

I don't really think we'll need to store func_sync in dev->power.  At least
I don't see a reason to do that at the moment.

I also think that func_sync() would have to be called if runtime PM is
disabled for the given device, so that callers don't have to check that
condition themselves.

What about the appended experimental patch?

Rafael


---
 drivers/base/power/runtime.c |   82 +++++++++++++++++++++++++++++++++++++++----
 include/linux/pm.h           |    1 
 include/linux/pm_runtime.h   |   14 +++++++
 3 files changed, 90 insertions(+), 7 deletions(-)

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
@@ -524,7 +533,9 @@ static int rpm_resume(struct device *dev
 	 * rather than cancelling it now only to restart it again in the near
 	 * future.
 	 */
-	dev->power.request = RPM_REQ_NONE;
+	if (dev->power.request != RPM_REQ_RESUME || !dev->power.func)
+		dev->power.request = RPM_REQ_NONE;
+
 	if (!dev->power.timer_autosuspends)
 		pm_runtime_deactivate_timer(dev);
 
@@ -533,6 +544,12 @@ static int rpm_resume(struct device *dev
 		goto out;
 	}
 
+	if (dev->power.func && (rpmflags & RPM_ASYNC)) {
+		rpm_queue_up_resume(dev);
+		retval = 0;
+		goto out;
+	}
+
 	if (dev->power.runtime_status == RPM_RESUMING
 	    || dev->power.runtime_status == RPM_SUSPENDING) {
 		DEFINE_WAIT(wait);
@@ -591,11 +608,7 @@ static int rpm_resume(struct device *dev
 
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
@@ -691,6 +704,7 @@ static int rpm_resume(struct device *dev
 static void pm_runtime_work(struct work_struct *work)
 {
 	struct device *dev = container_of(work, struct device, power.work);
+	void (*func)(struct device *) = NULL;
 	enum rpm_request req;
 
 	spin_lock_irq(&dev->power.lock);
@@ -715,12 +729,24 @@ static void pm_runtime_work(struct work_
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
@@ -877,6 +903,48 @@ int __pm_runtime_resume(struct device *d
 }
 EXPORT_SYMBOL_GPL(__pm_runtime_resume);
 
+int pm_runtime_get_and_call(struct device *dev, void (*func)(struct device *),
+			     void (*func_async)(struct device *))
+{
+	unsigned long flags;
+	int ret;
+
+	atomic_inc(&dev->power.usage_count);
+
+	spin_lock_irqsave(&dev->power.lock, flags);
+
+	ret = dev->power.runtime_error;
+	if (ret) {
+		func = NULL;
+		goto out;
+	}
+
+	if (dev->power.runtime_status != RPM_ACTIVE
+	    && dev->power.disable_depth == 0)
+		func = NULL;
+
+	if (!func && func_async) {
+		if (dev->power.func) {
+			ret = -EAGAIN;
+			goto out;
+		} else {
+			dev->power.func = func_async;
+		}
+	}
+
+	rpm_resume(dev, RPM_ASYNC);
+
+ out:
+	spin_unlock_irqrestore(&dev->power.lock, flags);
+
+	if (func) {
+		func(dev);
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
@@ -47,6 +47,9 @@ extern void pm_runtime_set_autosuspend_d
 extern unsigned long pm_runtime_autosuspend_expiration(struct device *dev);
 extern void pm_runtime_update_max_time_suspended(struct device *dev,
 						 s64 delta_ns);
+extern int pm_runtime_get_and_call(struct device *dev,
+				   void (*func)(struct device *),
+				   void (*func_async)(struct device *));
 
 static inline bool pm_children_suspended(struct device *dev)
 {
@@ -150,6 +153,17 @@ static inline void pm_runtime_set_autosu
 static inline unsigned long pm_runtime_autosuspend_expiration(
 				struct device *dev) { return 0; }
 
+static inline int pm_runtime_get_and_call(struct device *dev,
+					  void (*func)(struct device *),
+					  void (*func_async)(struct device *))
+{
+	if (func) {
+		func(dev);
+		return 1;
+	}
+	return 0;
+}
+
 #endif /* !CONFIG_PM_RUNTIME */
 
 static inline int pm_runtime_idle(struct device *dev)
