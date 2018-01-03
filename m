Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cloudserver094114.home.pl ([79.96.170.134]:44251 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751099AbeACAkp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Jan 2018 19:40:45 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Kevin Hilman <khilman@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 1/7] PM / core: Add helpers for subsystem callback selection
Date: Wed, 03 Jan 2018 01:31:40 +0100
Message-ID: <7022547.IqIDhzI9bf@aspire.rjw.lan>
In-Reply-To: <2436726.ykYRzVD45y@aspire.rjw.lan>
References: <7742130.AaJQIxeI1n@aspire.rjw.lan> <2436726.ykYRzVD45y@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add helper routines to find and return a suitable subsystem callback
during the "noirq" phases of system suspend/resume (or analogous)
transitions as well as during the "late" phase of system suspend and
the "early" phase of system resume (or analogous) transitions.

The helpers will be called from additional sites going forward.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/main.c |  188 +++++++++++++++++++++++++++++++---------------
 1 file changed, 128 insertions(+), 60 deletions(-)

Index: linux-pm/drivers/base/power/main.c
===================================================================
--- linux-pm.orig/drivers/base/power/main.c
+++ linux-pm/drivers/base/power/main.c
@@ -551,6 +551,35 @@ bool dev_pm_may_skip_resume(struct devic
 	return !dev->power.must_resume && pm_transition.event != PM_EVENT_RESTORE;
 }
 
+static pm_callback_t dpm_subsys_resume_noirq_cb(struct device *dev,
+						pm_message_t state,
+						const char **info_p)
+{
+	pm_callback_t callback;
+	const char *info;
+
+	if (dev->pm_domain) {
+		info = "noirq power domain ";
+		callback = pm_noirq_op(&dev->pm_domain->ops, state);
+	} else if (dev->type && dev->type->pm) {
+		info = "noirq type ";
+		callback = pm_noirq_op(dev->type->pm, state);
+	} else if (dev->class && dev->class->pm) {
+		info = "noirq class ";
+		callback = pm_noirq_op(dev->class->pm, state);
+	} else if (dev->bus && dev->bus->pm) {
+		info = "noirq bus ";
+		callback = pm_noirq_op(dev->bus->pm, state);
+	} else {
+		return NULL;
+	}
+
+	if (info_p)
+		*info_p = info;
+
+	return callback;
+}
+
 /**
  * device_resume_noirq - Execute a "noirq resume" callback for given device.
  * @dev: Device to handle.
@@ -562,8 +591,8 @@ bool dev_pm_may_skip_resume(struct devic
  */
 static int device_resume_noirq(struct device *dev, pm_message_t state, bool async)
 {
-	pm_callback_t callback = NULL;
-	const char *info = NULL;
+	pm_callback_t callback;
+	const char *info;
 	int error = 0;
 
 	TRACE_DEVICE(dev);
@@ -577,19 +606,7 @@ static int device_resume_noirq(struct de
 
 	dpm_wait_for_superior(dev, async);
 
-	if (dev->pm_domain) {
-		info = "noirq power domain ";
-		callback = pm_noirq_op(&dev->pm_domain->ops, state);
-	} else if (dev->type && dev->type->pm) {
-		info = "noirq type ";
-		callback = pm_noirq_op(dev->type->pm, state);
-	} else if (dev->class && dev->class->pm) {
-		info = "noirq class ";
-		callback = pm_noirq_op(dev->class->pm, state);
-	} else if (dev->bus && dev->bus->pm) {
-		info = "noirq bus ";
-		callback = pm_noirq_op(dev->bus->pm, state);
-	}
+	callback = dpm_subsys_resume_noirq_cb(dev, state, &info);
 
 	if (!callback && dev->driver && dev->driver->pm) {
 		info = "noirq driver ";
@@ -704,6 +721,35 @@ void dpm_resume_noirq(pm_message_t state
 	dpm_noirq_end();
 }
 
+static pm_callback_t dpm_subsys_resume_early_cb(struct device *dev,
+						pm_message_t state,
+						const char **info_p)
+{
+	pm_callback_t callback;
+	const char *info;
+
+	if (dev->pm_domain) {
+		info = "early power domain ";
+		callback = pm_late_early_op(&dev->pm_domain->ops, state);
+	} else if (dev->type && dev->type->pm) {
+		info = "early type ";
+		callback = pm_late_early_op(dev->type->pm, state);
+	} else if (dev->class && dev->class->pm) {
+		info = "early class ";
+		callback = pm_late_early_op(dev->class->pm, state);
+	} else if (dev->bus && dev->bus->pm) {
+		info = "early bus ";
+		callback = pm_late_early_op(dev->bus->pm, state);
+	} else {
+		return NULL;
+	}
+
+	if (info_p)
+		*info_p = info;
+
+	return callback;
+}
+
 /**
  * device_resume_early - Execute an "early resume" callback for given device.
  * @dev: Device to handle.
@@ -714,8 +760,8 @@ void dpm_resume_noirq(pm_message_t state
  */
 static int device_resume_early(struct device *dev, pm_message_t state, bool async)
 {
-	pm_callback_t callback = NULL;
-	const char *info = NULL;
+	pm_callback_t callback;
+	const char *info;
 	int error = 0;
 
 	TRACE_DEVICE(dev);
@@ -729,19 +775,7 @@ static int device_resume_early(struct de
 
 	dpm_wait_for_superior(dev, async);
 
-	if (dev->pm_domain) {
-		info = "early power domain ";
-		callback = pm_late_early_op(&dev->pm_domain->ops, state);
-	} else if (dev->type && dev->type->pm) {
-		info = "early type ";
-		callback = pm_late_early_op(dev->type->pm, state);
-	} else if (dev->class && dev->class->pm) {
-		info = "early class ";
-		callback = pm_late_early_op(dev->class->pm, state);
-	} else if (dev->bus && dev->bus->pm) {
-		info = "early bus ";
-		callback = pm_late_early_op(dev->bus->pm, state);
-	}
+	callback = dpm_subsys_resume_early_cb(dev, state, &info);
 
 	if (!callback && dev->driver && dev->driver->pm) {
 		info = "early driver ";
@@ -1128,6 +1162,35 @@ static void dpm_superior_set_must_resume
 	device_links_read_unlock(idx);
 }
 
+static pm_callback_t dpm_subsys_suspend_noirq_cb(struct device *dev,
+						 pm_message_t state,
+						 const char **info_p)
+{
+	pm_callback_t callback;
+	const char *info;
+
+	if (dev->pm_domain) {
+		info = "noirq power domain ";
+		callback = pm_noirq_op(&dev->pm_domain->ops, state);
+	} else if (dev->type && dev->type->pm) {
+		info = "noirq type ";
+		callback = pm_noirq_op(dev->type->pm, state);
+	} else if (dev->class && dev->class->pm) {
+		info = "noirq class ";
+		callback = pm_noirq_op(dev->class->pm, state);
+	} else if (dev->bus && dev->bus->pm) {
+		info = "noirq bus ";
+		callback = pm_noirq_op(dev->bus->pm, state);
+	} else {
+		return NULL;
+	}
+
+	if (info_p)
+		*info_p = info;
+
+	return callback;
+}
+
 /**
  * __device_suspend_noirq - Execute a "noirq suspend" callback for given device.
  * @dev: Device to handle.
@@ -1139,8 +1202,8 @@ static void dpm_superior_set_must_resume
  */
 static int __device_suspend_noirq(struct device *dev, pm_message_t state, bool async)
 {
-	pm_callback_t callback = NULL;
-	const char *info = NULL;
+	pm_callback_t callback;
+	const char *info;
 	int error = 0;
 
 	TRACE_DEVICE(dev);
@@ -1159,19 +1222,7 @@ static int __device_suspend_noirq(struct
 	if (dev->power.syscore || dev->power.direct_complete)
 		goto Complete;
 
-	if (dev->pm_domain) {
-		info = "noirq power domain ";
-		callback = pm_noirq_op(&dev->pm_domain->ops, state);
-	} else if (dev->type && dev->type->pm) {
-		info = "noirq type ";
-		callback = pm_noirq_op(dev->type->pm, state);
-	} else if (dev->class && dev->class->pm) {
-		info = "noirq class ";
-		callback = pm_noirq_op(dev->class->pm, state);
-	} else if (dev->bus && dev->bus->pm) {
-		info = "noirq bus ";
-		callback = pm_noirq_op(dev->bus->pm, state);
-	}
+	callback = dpm_subsys_suspend_noirq_cb(dev, state, &info);
 
 	if (!callback && dev->driver && dev->driver->pm) {
 		info = "noirq driver ";
@@ -1306,6 +1357,35 @@ int dpm_suspend_noirq(pm_message_t state
 	return ret;
 }
 
+static pm_callback_t dpm_subsys_suspend_late_cb(struct device *dev,
+						pm_message_t state,
+						const char **info_p)
+{
+	pm_callback_t callback;
+	const char *info;
+
+	if (dev->pm_domain) {
+		info = "late power domain ";
+		callback = pm_late_early_op(&dev->pm_domain->ops, state);
+	} else if (dev->type && dev->type->pm) {
+		info = "late type ";
+		callback = pm_late_early_op(dev->type->pm, state);
+	} else if (dev->class && dev->class->pm) {
+		info = "late class ";
+		callback = pm_late_early_op(dev->class->pm, state);
+	} else if (dev->bus && dev->bus->pm) {
+		info = "late bus ";
+		callback = pm_late_early_op(dev->bus->pm, state);
+	} else {
+		return NULL;
+	}
+
+	if (info_p)
+		*info_p = info;
+
+	return callback;
+}
+
 /**
  * __device_suspend_late - Execute a "late suspend" callback for given device.
  * @dev: Device to handle.
@@ -1316,8 +1396,8 @@ int dpm_suspend_noirq(pm_message_t state
  */
 static int __device_suspend_late(struct device *dev, pm_message_t state, bool async)
 {
-	pm_callback_t callback = NULL;
-	const char *info = NULL;
+	pm_callback_t callback;
+	const char *info;
 	int error = 0;
 
 	TRACE_DEVICE(dev);
@@ -1338,19 +1418,7 @@ static int __device_suspend_late(struct
 	if (dev->power.syscore || dev->power.direct_complete)
 		goto Complete;
 
-	if (dev->pm_domain) {
-		info = "late power domain ";
-		callback = pm_late_early_op(&dev->pm_domain->ops, state);
-	} else if (dev->type && dev->type->pm) {
-		info = "late type ";
-		callback = pm_late_early_op(dev->type->pm, state);
-	} else if (dev->class && dev->class->pm) {
-		info = "late class ";
-		callback = pm_late_early_op(dev->class->pm, state);
-	} else if (dev->bus && dev->bus->pm) {
-		info = "late bus ";
-		callback = pm_late_early_op(dev->bus->pm, state);
-	}
+	callback = dpm_subsys_suspend_late_cb(dev, state, &info);
 
 	if (!callback && dev->driver && dev->driver->pm) {
 		info = "late driver ";
