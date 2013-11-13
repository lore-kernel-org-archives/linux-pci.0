Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:42654 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757569Ab3KMQ3y (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 Nov 2013 11:29:54 -0500
Received: by mail-wg0-f51.google.com with SMTP id m15so656671wgh.6
        for <linux-pci@vger.kernel.org>; Wed, 13 Nov 2013 08:29:53 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	linux-pm@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-usb@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Kevin Hilman <khilman@linaro.org>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: [RFC PATCH] PM / Runtime: Allow to inactivate devices during system suspend
Date: Wed, 13 Nov 2013 17:29:38 +0100
Message-Id: <1384360178-333-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The PM core was preventing devices from going inactive during system
suspend. Remove this constraint and moreover try to inactivate devices
by invoking pm_runtime_idle() before proceeding with device's
suspend_late callbacks.

A great amount of drivers that uses runtime PM will benefit from this.

Drivers that implements some of the system ->suspend* callbacks for the
only reason of making sure the runtime PM resourses gets inactive, can
now solely instead rely on the PM core to handle this.

In the case were drivers needs there runtime resourses to be activated
to be able to handle their system suspend tasks, those can easily just
restore the runtime PM usage count, pm_runtime_put_sync(), once done
with it's suspend operations, which then will inactivate the device.

Cc: Kevin Hilman <khilman@linaro.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

There are a quite long history for how the PM core behaves around this
topic. Changes has been iterated, back for forward, you might even
think that it should have been settled at this point. So, forgive me
for bringing this up, again.

This patch shall obviously not be merged as is, it will cause
regressions for several drivers and subsystems. The intent is instead
to try to follow up on previous discussions to see if we might end up
closer to the sequence, which my RFC PATCH suggests, or if I am just
bothering you completely unnecessary.

---
 drivers/base/power/main.c |   11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index ee039af..670b1d5 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -832,7 +832,7 @@ static void device_complete(struct device *dev, pm_message_t state)
 
 	device_unlock(dev);
 
-	pm_runtime_put(dev);
+	pm_request_idle(dev);
 }
 
 /**
@@ -1004,6 +1004,7 @@ static int device_suspend_late(struct device *dev, pm_message_t state)
 	pm_callback_t callback = NULL;
 	char *info = NULL;
 
+	pm_runtime_idle(dev);
 	__pm_runtime_disable(dev, false);
 
 	if (dev->power.syscore)
@@ -1312,14 +1313,6 @@ static int device_prepare(struct device *dev, pm_message_t state)
 	if (dev->power.syscore)
 		return 0;
 
-	/*
-	 * If a device's parent goes into runtime suspend at the wrong time,
-	 * it won't be possible to resume the device.  To prevent this we
-	 * block runtime suspend here, during the prepare phase, and allow
-	 * it again during the complete phase.
-	 */
-	pm_runtime_get_noresume(dev);
-
 	device_lock(dev);
 
 	dev->power.wakeup_path = device_may_wakeup(dev);
-- 
1.7.9.5

