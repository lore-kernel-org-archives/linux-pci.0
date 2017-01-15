Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:53485 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751270AbdAOUF3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 15 Jan 2017 15:05:29 -0500
Message-Id: <f8e6ef37e202e1c3c5ec3edc6e44370eb05c9fff.1484486499.git.lukas@wunner.de>
In-Reply-To: <cover.1484486499.git.lukas@wunner.de>
References: <cover.1484486499.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 15 Jan 2017 21:03:45 +0100
Subject: [PATCH v5 4/8] Revert "PM / Runtime: Remove the exported function
 pm_children_suspended()"
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: Andreas Noever <andreas.noever@gmail.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This reverts commit 62006c1702b3b1be0c0726949e0ee0ea2326be9c which
removed pm_children_suspended() because it had only a single caller.
We're about to add a second caller, so establish the status quo ante.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/base/power/runtime.c | 3 +--
 include/linux/pm_runtime.h   | 7 +++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 872eac4cb1df..03293c32793c 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -243,8 +243,7 @@ static int rpm_check_suspend_allowed(struct device *dev)
 		retval = -EACCES;
 	else if (atomic_read(&dev->power.usage_count) > 0)
 		retval = -EAGAIN;
-	else if (!dev->power.ignore_children &&
-			atomic_read(&dev->power.child_count))
+	else if (!pm_children_suspended(dev))
 		retval = -EBUSY;
 
 	/* Pending resume requests take precedence over suspends. */
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index ca4823e675e2..7de2aa5c3692 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -66,6 +66,12 @@ static inline void pm_suspend_ignore_children(struct device *dev, bool enable)
 	dev->power.ignore_children = enable;
 }
 
+static inline bool pm_children_suspended(struct device *dev)
+{
+	return dev->power.ignore_children
+		|| !atomic_read(&dev->power.child_count);
+}
+
 static inline void pm_runtime_get_noresume(struct device *dev)
 {
 	atomic_inc(&dev->power.usage_count);
@@ -161,6 +167,7 @@ static inline void pm_runtime_allow(struct device *dev) {}
 static inline void pm_runtime_forbid(struct device *dev) {}
 
 static inline void pm_suspend_ignore_children(struct device *dev, bool enable) {}
+static inline bool pm_children_suspended(struct device *dev) { return false; }
 static inline void pm_runtime_get_noresume(struct device *dev) {}
 static inline void pm_runtime_put_noidle(struct device *dev) {}
 static inline bool device_run_wake(struct device *dev) { return false; }
-- 
2.11.0

