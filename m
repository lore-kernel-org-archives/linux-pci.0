Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:54063 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751764AbdJPBnG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 15 Oct 2017 21:43:06 -0400
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
        Kevin Hilman <khilman@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 04/12] PM / core: Add SMART_SUSPEND driver flag
Date: Mon, 16 Oct 2017 03:29:31 +0200
Message-ID: <2481137.OYGUrPQscL@aspire.rjw.lan>
In-Reply-To: <3806130.B2KCK0tvef@aspire.rjw.lan>
References: <3806130.B2KCK0tvef@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Define and document a SMART_SUSPEND flag to instruct bus types and PM
domains that the system suspend callbacks provided by the driver can
cope with runtime-suspended devices, so from the driver's perspective
it should be safe to leave devices in runtime suspend during system
suspend.

Setting that flag also causes the PM core to skip the "late" and
"noirq" phases of device suspend for devices that remain in runtime
suspend at the beginning of the "late" phase (when runtime PM has
been disabled for them) under the assumption that their state cannot
(and should not) change after that point until the system suspend
transition is complete.  Moreover, the PM core prevents runtime PM
from acting on devices with DPM_FLAG_SMART_SUSPEND during system
resume by setting their runtime PM status to "active" at the end of
the "early" phase (right prior to enabling runtime PM for them).
That allows system resume callbacks to do whatever is necessary to
resume the device without worrying about runtime PM possibly
running in parallel with them.

However, that doesn't apply to transitions involving ->thaw_noirq,
->thaw_early and ->thaw callbacks during hibernation, as they
generally are not expected to change the power states of devices.
Consequently, if a device is in runtime suspend at the beginning
of such a transition, it must stay in runtime suspend until the
"complete" phase of it (since the callbacks may not change its
power state).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/driver-api/pm/devices.rst |   17 ++++++++
 drivers/base/power/main.c               |   63 ++++++++++++++++++++++++++++----
 include/linux/pm.h                      |    9 ++++
 3 files changed, 82 insertions(+), 7 deletions(-)

Index: linux-pm/Documentation/driver-api/pm/devices.rst
===================================================================
--- linux-pm.orig/Documentation/driver-api/pm/devices.rst
+++ linux-pm/Documentation/driver-api/pm/devices.rst
@@ -766,6 +766,23 @@ the state of devices (possibly except fo
 from their ``->prepare`` and ``->suspend`` callbacks (or equivalent) *before*
 invoking device drivers' ``->suspend`` callbacks (or equivalent).
 
+Some bus types and PM domains have a policy to resume all devices from runtime
+suspend upfront in their ``->suspend`` callbacks, but that may not be really
+necessary if the system suspend-resume callbacks provided by the device's
+driver can cope with runtime-suspended devices.  The driver can indicate that
+by setting ``DPM_FLAG_SMART_SUSPEND`` in :c:member:`power.driver_flags` at the
+probe time, by passing it to the :c:func:`dev_pm_set_driver_flags` helper.  That
+also causes the PM core to skip the ``suspend_late`` and ``suspend_noirq``
+phases of device suspend for the device if it remains in runtime suspend at the
+beginning of the ``suspend_late`` phase (when runtime PM has been disabled for
+it) under the assumption that its state cannot (and should not) change after
+that point until the system-wide transition is over.  Moreover, the PM core
+updates the runtime power management status of devices with
+``DPM_FLAG_SMART_SUSPEND`` set to "active" at the end of the ``resume_early``
+phase of device resume (right prior to enabling runtime PM for them) in order
+to prevent runtime PM from acting on them before the ``complete`` phase, which
+means that they should be put into the full-power state before that phase.
+
 During system-wide resume from a sleep state it's easiest to put devices into
 the full-power state, as explained in :file:`Documentation/power/runtime_pm.txt`.
 Refer to that document for more information regarding this particular issue as
Index: linux-pm/include/linux/pm.h
===================================================================
--- linux-pm.orig/include/linux/pm.h
+++ linux-pm/include/linux/pm.h
@@ -558,6 +558,7 @@ struct pm_subsys_data {
  *
  * NEVER_SKIP: Do not skip system suspend/resume callbacks for the device.
  * SMART_PREPARE: Check the return value of the driver's ->prepare callback.
+ * SMART_SUSPEND: No need to resume the device from runtime suspend.
  *
  * Setting SMART_PREPARE instructs bus types and PM domains which may want
  * system suspend/resume callbacks to be skipped for the device to return 0 from
@@ -565,9 +566,17 @@ struct pm_subsys_data {
  * other words, the system suspend/resume callbacks can only be skipped for the
  * device if its driver doesn't object against that).  This flag has no effect
  * if NEVER_SKIP is set.
+ *
+ * Setting SMART_SUSPEND instructs bus types and PM domains which may want to
+ * runtime resume the device upfront during system suspend that doing so is not
+ * necessary from the driver's perspective.  It also causes the PM core to skip
+ * the "late" and "noirq" phases of device suspend for the device if it remains
+ * in runtime suspend at the beginning of the "late" phase (when runtime PM has
+ * been disabled for it).
  */
 #define DPM_FLAG_NEVER_SKIP	BIT(0)
 #define DPM_FLAG_SMART_PREPARE	BIT(1)
+#define DPM_FLAG_SMART_SUSPEND	BIT(2)
 
 struct dev_pm_info {
 	pm_message_t		power_state;
Index: linux-pm/drivers/base/power/main.c
===================================================================
--- linux-pm.orig/drivers/base/power/main.c
+++ linux-pm/drivers/base/power/main.c
@@ -551,6 +551,18 @@ static int device_resume_noirq(struct de
 	if (!dev->power.is_noirq_suspended)
 		goto Out;
 
+	if (dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND) &&
+	    pm_runtime_status_suspended(dev) && (state.event == PM_EVENT_THAW ||
+	    state.event == PM_EVENT_RECOVER)) {
+		/*
+		 * The device has to stay in runtime suspend, because the
+		 * subsequent callbacks may not try to change its power state.
+		 */
+		dev->power.is_suspended = false;
+		dev->power.is_late_suspended = false;
+		goto Skip;
+	}
+
 	dpm_wait_for_superior(dev, async);
 
 	if (dev->pm_domain) {
@@ -573,9 +585,11 @@ static int device_resume_noirq(struct de
 	}
 
 	error = dpm_run_callback(callback, dev, state, info);
+
+Skip:
 	dev->power.is_noirq_suspended = false;
 
- Out:
+Out:
 	complete_all(&dev->power.completion);
 	TRACE_RESUME(error);
 	return error;
@@ -715,6 +729,14 @@ static int device_resume_early(struct de
 	error = dpm_run_callback(callback, dev, state, info);
 	dev->power.is_late_suspended = false;
 
+	/*
+	 * Devices with DPM_FLAG_SMART_SUSPEND may be left in runtime suspend
+	 * during system suspend, so update their runtime PM status to "active"
+	 * to prevent runtime PM from acting on them before device_complete().
+	 */
+	if (dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND))
+		pm_runtime_set_active(dev);
+
  Out:
 	TRACE_RESUME(error);
 
@@ -1107,6 +1129,15 @@ static int __device_suspend_noirq(struct
 	if (dev->power.syscore || dev->power.direct_complete)
 		goto Complete;
 
+	/*
+	 * The state of devices with DPM_FLAG_SMART_SUSPEND set that remain in
+	 * runtime suspend at this point cannot change going forward, so skip
+	 * the callback invocation for them.
+	 */
+	if (dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND) &&
+	    pm_runtime_status_suspended(dev))
+		goto Skip;
+
 	if (dev->pm_domain) {
 		info = "noirq power domain ";
 		callback = pm_noirq_op(&dev->pm_domain->ops, state);
@@ -1127,10 +1158,13 @@ static int __device_suspend_noirq(struct
 	}
 
 	error = dpm_run_callback(callback, dev, state, info);
-	if (!error)
-		dev->power.is_noirq_suspended = true;
-	else
+	if (error) {
 		async_error = error;
+		goto Complete;
+	}
+
+Skip:
+	dev->power.is_noirq_suspended = true;
 
 Complete:
 	complete_all(&dev->power.completion);
@@ -1268,6 +1302,15 @@ static int __device_suspend_late(struct
 	if (dev->power.syscore || dev->power.direct_complete)
 		goto Complete;
 
+	/*
+	 * The state of devices with DPM_FLAG_SMART_SUSPEND set that remain in
+	 * runtime suspend at this point cannot change going forward, so skip
+	 * the callback invocation for them.
+	 */
+	if (dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND) &&
+	    pm_runtime_status_suspended(dev))
+		goto Skip;
+
 	if (dev->pm_domain) {
 		info = "late power domain ";
 		callback = pm_late_early_op(&dev->pm_domain->ops, state);
@@ -1288,10 +1331,13 @@ static int __device_suspend_late(struct
 	}
 
 	error = dpm_run_callback(callback, dev, state, info);
-	if (!error)
-		dev->power.is_late_suspended = true;
-	else
+	if (error) {
 		async_error = error;
+		goto Complete;
+	}
+
+Skip:
+	dev->power.is_late_suspended = true;
 
 Complete:
 	TRACE_SUSPEND(error);
@@ -1652,6 +1698,9 @@ static int device_prepare(struct device
 	if (dev->power.syscore)
 		return 0;
 
+	WARN_ON(dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND) &&
+		!pm_runtime_enabled(dev));
+
 	/*
 	 * If a device's parent goes into runtime suspend at the wrong time,
 	 * it won't be possible to resume the device.  To prevent this we
