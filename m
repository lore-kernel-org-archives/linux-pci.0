Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:58740 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754218Ab3KOLkz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 15 Nov 2013 06:40:55 -0500
Received: by mail-lb0-f174.google.com with SMTP id y6so2627625lbh.33
        for <linux-pci@vger.kernel.org>; Fri, 15 Nov 2013 03:40:54 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	linux-pm@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-usb@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Kevin Hilman <khilman@linaro.org>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: [RFC PATCH 2/2] PM / Runtime: Allow devices to become inactive during system suspend
Date: Fri, 15 Nov 2013 12:40:45 +0100
Message-Id: <1384515645-8696-2-git-send-email-ulf.hansson@linaro.org>
In-Reply-To: <1384515645-8696-1-git-send-email-ulf.hansson@linaro.org>
References: <1384515645-8696-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The PM core was unconditionally preventing devices from being runtime
suspended during system suspend. The reason is that we don't want
asynchronous runtime suspends to happen during system suspend and thus
race with the system suspend process, which some drivers and buses are
not able to handle.

However, for drivers that don't have issues with the races above, are
somewhat suffering from the constraints this cause and then need to
inactivate their devices outside the runtime PM control during system
suspend. In other words, those implements .suspend|suspend_late
callbacks to handle this.

To simplify for these drivers, we add new runtime PM API,
pm_runtime_no_prevent_suspend(), which drivers typically should call
from their probe routines to tell PM core that it must not prevent
runtime suspend during system suspend. Additonally the PM core will
in this case instead invode the pm_runtime_idle just before it shall
disable runtime PM in suspend_late.

Drivers making use if this feature are then able to trigger runtime
suspend with for example a pm_runtime_put_sync from their .suspend
callbacks. Additionally, for drivers that are able to cope with only
runtime PM callbacks, these can rely on the PM core to trigger a
runtime suspend (if the runtime PM usage count doesn't prevent it)
to inactivate their devices during system suspend.

Cc: Kevin Hilman <khilman@linaro.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Some discussion started recently while I posted below patch:
[RFC PATCH] PM / Runtime: Allow to inactivate devices during system suspend

After some thinking I decided to cook another RFC, that might be better
material for discussion. If we decide to go in this direction, the doc
obviously needs some update as well, which is not a part of this RFC yet.

---
 drivers/base/power/main.c    |   13 ++++++++++---
 drivers/base/power/runtime.c |    1 +
 include/linux/pm.h           |    1 +
 include/linux/pm_runtime.h   |   13 +++++++++++++
 4 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 2a1b06a..838ebb6 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -832,7 +832,10 @@ static void device_complete(struct device *dev, pm_message_t state)
 
 	device_unlock(dev);
 
-	pm_runtime_put(dev);
+	if (pm_runtime_suspend_prevented(dev))
+		pm_runtime_put(dev);
+	else
+		pm_request_idle(dev);
 }
 
 /**
@@ -1004,6 +1007,9 @@ static int device_suspend_late(struct device *dev, pm_message_t state)
 	pm_callback_t callback = NULL;
 	char *info = NULL;
 
+	if (!pm_runtime_suspend_prevented(dev))
+		pm_runtime_idle(dev);
+
 	__pm_runtime_disable(dev, false);
 
 	if (dev->power.syscore)
@@ -1318,7 +1324,8 @@ static int device_prepare(struct device *dev, pm_message_t state)
 	 * block runtime suspend here, during the prepare phase, and allow
 	 * it again during the complete phase.
 	 */
-	pm_runtime_get_noresume(dev);
+	if (pm_runtime_suspend_prevented(dev))
+		pm_runtime_get_noresume(dev);
 
 	device_lock(dev);
 
@@ -1350,7 +1357,7 @@ static int device_prepare(struct device *dev, pm_message_t state)
 
 	device_unlock(dev);
 
-	if (error)
+	if (error && pm_runtime_suspend_prevented(dev))
 		pm_runtime_put(dev);
 
 	return error;
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 72e00e6..bdac1e2 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1373,6 +1373,7 @@ void pm_runtime_init(struct device *dev)
 	atomic_set(&dev->power.child_count, 0);
 	pm_suspend_ignore_children(dev, false);
 	dev->power.runtime_auto = true;
+	dev->power.prevent_suspend = true;
 
 	dev->power.request_pending = false;
 	dev->power.request = RPM_REQ_NONE;
diff --git a/include/linux/pm.h b/include/linux/pm.h
index a224c7f..98ef412 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -551,6 +551,7 @@ struct dev_pm_info {
 	unsigned int		use_autosuspend:1;
 	unsigned int		timer_autosuspends:1;
 	unsigned int		memalloc_noio:1;
+	unsigned int		prevent_suspend:1;
 	enum rpm_request	request;
 	enum rpm_status		runtime_status;
 	int			runtime_error;
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 6fa7cea..2b72e30 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -106,6 +106,16 @@ static inline void pm_runtime_mark_last_busy(struct device *dev)
 	ACCESS_ONCE(dev->power.last_busy) = jiffies;
 }
 
+static inline void pm_runtime_no_prevent_suspend(struct device *dev)
+{
+	dev->power.prevent_suspend = false;
+}
+
+static inline bool pm_runtime_suspend_prevented(struct device *dev)
+{
+	return dev->power.prevent_suspend;
+}
+
 #else /* !CONFIG_PM_RUNTIME */
 
 static inline int __pm_runtime_idle(struct device *dev, int rpmflags)
@@ -157,6 +167,9 @@ static inline unsigned long pm_runtime_autosuspend_expiration(
 				struct device *dev) { return 0; }
 static inline void pm_runtime_set_memalloc_noio(struct device *dev,
 						bool enable){}
+static inline void pm_runtime_no_prevent_suspend(struct device *dev) {}
+static inline bool pm_runtime_suspend_prevented(struct device *dev)
+						{ return false; }
 
 #endif /* !CONFIG_PM_RUNTIME */
 
-- 
1.7.9.5

