Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f44.google.com ([209.85.214.44]:44604 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753273Ab3KYMkd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 25 Nov 2013 07:40:33 -0500
Received: by mail-bk0-f44.google.com with SMTP id d7so1976958bkh.3
        for <linux-pci@vger.kernel.org>; Mon, 25 Nov 2013 04:40:32 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	linux-pm@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-usb@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Kevin Hilman <khilman@linaro.org>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v2] PM / Sleep: Add pm_generic functions to re-use runtime PM callbacks
Date: Mon, 25 Nov 2013 13:40:21 +0100
Message-Id: <1385383221-20372-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

To put devices into low power state during sleep, it sometimes makes
sense at subsystem-level to re-use device's runtime PM callbacks.

The PM core will at device_suspend_late disable runtime PM, after that
we can safely operate on these callbacks. At suspend_late the device
will be put into low power state by invoking the device's
runtime_suspend callback, unless the runtime status is already
suspended. At resume_early the state is restored by invoking the
device's runtime_resume callback. Soon after the PM core will re-enable
runtime PM before returning from device_resume_early.

The new pm_generic functions are named pm_generic_suspend_late_runtime
and pm_generic_resume_early_runtime, they are supposed to be used in
pairs.

Do note that these new generic callbacks will work smothly even with
and without CONFIG_PM_RUNTIME, as long as the runtime PM callbacks are
implemented inside CONFIG_PM instead of CONFIG_PM_RUNTIME.

A special thanks to Alan Stern who came up with this idea.

Cc: Kevin Hilman <khilman@linaro.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/generic_ops.c |   86 ++++++++++++++++++++++++++++++++++++++
 include/linux/pm.h               |    2 +
 2 files changed, 88 insertions(+)

diff --git a/drivers/base/power/generic_ops.c b/drivers/base/power/generic_ops.c
index 5ee030a..3132768 100644
--- a/drivers/base/power/generic_ops.c
+++ b/drivers/base/power/generic_ops.c
@@ -93,6 +93,49 @@ int pm_generic_suspend_late(struct device *dev)
 EXPORT_SYMBOL_GPL(pm_generic_suspend_late);
 
 /**
+ * pm_generic_suspend_late_runtime - Generic suspend_late callback for
+ * subsystems that wants to use runtime_suspend callbacks at suspend_late.
+ * @dev: Device to suspend.
+ */
+int pm_generic_suspend_late_runtime(struct device *dev)
+{
+	int (*callback)(struct device *);
+	int ret = 0;
+
+	/*
+	 * PM core has disabled runtime PM in device_suspend_late, thus we can
+	 * safely check the device's runtime status and decide whether
+	 * additional actions are needed to put the device into low power state.
+	 * If so, we invoke the device's runtime_suspend callback.
+	 * For the !CONFIG_PM_RUNTIME case, pm_runtime_status_suspended() always
+	 * returns false and therefore the runtime_suspend callback will be
+	 * invoked.
+	 */
+	if (pm_runtime_status_suspended(dev))
+		return 0;
+
+	if (dev->pm_domain)
+		callback = dev->pm_domain->ops.runtime_suspend;
+	else if (dev->type && dev->type->pm)
+		callback = dev->type->pm->runtime_suspend;
+	else if (dev->class && dev->class->pm)
+		callback = dev->class->pm->runtime_suspend;
+	else if (dev->bus && dev->bus->pm)
+		callback = dev->bus->pm->runtime_suspend;
+	else
+		callback = NULL;
+
+	if (!callback && dev->driver && dev->driver->pm)
+		callback = dev->driver->pm->runtime_suspend;
+
+	if (callback)
+		ret = callback(dev);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pm_generic_suspend_late_runtime);
+
+/**
  * pm_generic_suspend - Generic suspend callback for subsystems.
  * @dev: Device to suspend.
  */
@@ -237,6 +280,49 @@ int pm_generic_resume_early(struct device *dev)
 EXPORT_SYMBOL_GPL(pm_generic_resume_early);
 
 /**
+ * pm_generic_resume_early_runtime - Generic resume_early callback for
+ * subsystems that wants to use runtime_resume callbacks at resume_early.
+ * @dev: Device to resume.
+ */
+int pm_generic_resume_early_runtime(struct device *dev)
+{
+	int (*callback)(struct device *);
+	int ret = 0;
+
+	/*
+	 * PM core has not yet enabled runtime PM in device_resume_early,
+	 * thus we can safely check the device's runtime status and restore the
+	 * previous state we had in device_suspend_late. If restore is needed
+	 * we invoke the device's runtime_resume callback.
+	 * For the !CONFIG_PM_RUNTIME case, pm_runtime_status_suspended() always
+	 * returns false and therefore the runtime_resume callback will be
+	 * invoked.
+	 */
+	if (pm_runtime_status_suspended(dev))
+		return 0;
+
+	if (dev->pm_domain)
+		callback = dev->pm_domain->ops.runtime_resume;
+	else if (dev->type && dev->type->pm)
+		callback = dev->type->pm->runtime_resume;
+	else if (dev->class && dev->class->pm)
+		callback = dev->class->pm->runtime_resume;
+	else if (dev->bus && dev->bus->pm)
+		callback = dev->bus->pm->runtime_resume;
+	else
+		callback = NULL;
+
+	if (!callback && dev->driver && dev->driver->pm)
+		callback = dev->driver->pm->runtime_resume;
+
+	if (callback)
+		ret = callback(dev);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pm_generic_resume_early_runtime);
+
+/**
  * pm_generic_resume - Generic resume callback for subsystems.
  * @dev: Device to resume.
  */
diff --git a/include/linux/pm.h b/include/linux/pm.h
index a224c7f..5bce0d4 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -656,9 +656,11 @@ extern void dpm_for_each_dev(void *data, void (*fn)(struct device *, void *));
 
 extern int pm_generic_prepare(struct device *dev);
 extern int pm_generic_suspend_late(struct device *dev);
+extern int pm_generic_suspend_late_runtime(struct device *dev);
 extern int pm_generic_suspend_noirq(struct device *dev);
 extern int pm_generic_suspend(struct device *dev);
 extern int pm_generic_resume_early(struct device *dev);
+extern int pm_generic_resume_early_runtime(struct device *dev);
 extern int pm_generic_resume_noirq(struct device *dev);
 extern int pm_generic_resume(struct device *dev);
 extern int pm_generic_freeze_noirq(struct device *dev);
-- 
1.7.9.5

