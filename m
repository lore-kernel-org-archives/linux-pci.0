Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kevin Hilman <khilman@kernel.org>
Subject: [PATCH v2 4/6] PM / core: Add helpers for subsystem callback selection
Date: Wed, 08 Nov 2017 14:37:42 +0100
Message-ID: <1725189.DeftURlZs9@aspire.rjw.lan>
In-Reply-To: <6330680.LdxjlP4uri@aspire.rjw.lan>
References: <3806130.B2KCK0tvef@aspire.rjw.lan> <16592954.7Zo1mAdIIH@aspire.rjw.lan> <6330680.LdxjlP4uri@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add helper routines to find and return a suitable subsystem callback
during the "noirq" phases of system suspend/resume (or analogous)
transitions as well as during the "late" phase of system suspend and
the "early" phase of system resume (or analogous) transitions.

The helpers will be called from additional sites going forward.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/main.c |  196 +++++++++++++++++++++++++++++++---------------
 1 file changed, 136 insertions(+), 60 deletions(-)

Index: linux-pm/drivers/base/power/main.c
===================================================================
--- linux-pm.orig/drivers/base/power/main.c
+++ linux-pm/drivers/base/power/main.c
@@ -525,6 +525,14 @@ static void dpm_watchdog_clear(struct dp
 #define dpm_watchdog_clear(x)
 #endif
 
+static pm_callback_t dpm_subsys_suspend_noirq_cb(struct device *dev,
+						 pm_message_t state,
+						 const char **info_p);
+
+static pm_callback_t dpm_subsys_suspend_late_cb(struct device *dev,
+						pm_message_t state,
+						const char **info_p);
+
 /*------------------------- Resume routines -------------------------*/
 
 /**
@@ -539,6 +547,35 @@ bool dev_pm_may_skip_resume(struct devic
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
@@ -550,8 +587,8 @@ bool dev_pm_may_skip_resume(struct devic
  */
 static int device_resume_noirq(struct device *dev, pm_message_t state, bool async)
 {
-	pm_callback_t callback = NULL;
-	const char *info = NULL;
+	pm_callback_t callback;
+	const char *info;
 	int error = 0;
 
 	TRACE_DEVICE(dev);
@@ -565,19 +602,7 @@ static int device_resume_noirq(struct de
 
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
@@ -686,6 +711,35 @@ void dpm_resume_noirq(pm_message_t state
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
@@ -696,8 +750,8 @@ void dpm_resume_noirq(pm_message_t state
  */
 static int device_resume_early(struct device *dev, pm_message_t state, bool async)
 {
-	pm_callback_t callback = NULL;
-	const char *info = NULL;
+	pm_callback_t callback;
+	const char *info;
 	int error = 0;
 
 	TRACE_DEVICE(dev);
@@ -711,19 +765,7 @@ static int device_resume_early(struct de
 
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
@@ -1110,6 +1152,35 @@ static void dpm_superior_set_must_resume
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
@@ -1121,8 +1192,8 @@ static void dpm_superior_set_must_resume
  */
 static int __device_suspend_noirq(struct device *dev, pm_message_t state, bool async)
 {
-	pm_callback_t callback = NULL;
-	const char *info = NULL;
+	pm_callback_t callback;
+	const char *info;
 	int error = 0;
 
 	TRACE_DEVICE(dev);
@@ -1141,19 +1212,7 @@ static int __device_suspend_noirq(struct
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
@@ -1287,6 +1346,35 @@ int dpm_suspend_noirq(pm_message_t state
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
@@ -1297,8 +1385,8 @@ int dpm_suspend_noirq(pm_message_t state
  */
 static int __device_suspend_late(struct device *dev, pm_message_t state, bool async)
 {
-	pm_callback_t callback = NULL;
-	const char *info = NULL;
+	pm_callback_t callback;
+	const char *info;
 	int error = 0;
 
 	TRACE_DEVICE(dev);
@@ -1319,19 +1407,7 @@ static int __device_suspend_late(struct
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
