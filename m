Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cloudserver094114.home.pl ([79.96.170.134]:44670 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751058AbeACAkp (ORCPT
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
Subject: [PATCH 2/7] PM / core: Direct DPM_FLAG_SMART_SUSPEND optimization
Date: Wed, 03 Jan 2018 01:32:27 +0100
Message-ID: <3712947.JyckaHJdUq@aspire.rjw.lan>
In-Reply-To: <2436726.ykYRzVD45y@aspire.rjw.lan>
References: <7742130.AaJQIxeI1n@aspire.rjw.lan> <2436726.ykYRzVD45y@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make the PM core avoid invoking the "late" and "noirq" system-wide
suspend (or analogous) callbacks provided by device drivers directly
for devices with DPM_FLAG_SMART_SUSPEND set that are in runtime
suspend during the "late" and "noirq" phases of system-wide suspend
(or analogous) transitions.  That is only done for devices without
any middle-layer "late" and "noirq" suspend callbacks (to avoid
confusing the middle layer if there is one).

The underlying observation is that runtime PM is disabled for devices
during the "late" and "noirq" system-wide suspend phases, so if they
remain in runtime suspend from the "late" phase forward, it doesn't
make sense to invoke the "late" and "noirq" callbacks provided by
the drivers for them (arguably, the device is already suspended and
in the right state).  Thus, if the remaining driver suspend callbacks
are to be invoked directly by the core, they can be skipped.

This change really makes it possible for, say, platform device
drivers to re-use runtime PM suspend and resume callbacks by
pointing ->suspend_late and ->resume_early, respectively (and
possibly the analogous hibernation-related callback pointers too),
to them without adding any extra "is the device already suspended?"
type of checks to the callback routines, as long as they will be
invoked directly by the core.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/driver-api/pm/devices.rst |   18 +++---
 drivers/base/power/main.c               |   85 +++++++++++++++++++++++++++++---
 2 files changed, 88 insertions(+), 15 deletions(-)

Index: linux-pm/Documentation/driver-api/pm/devices.rst
===================================================================
--- linux-pm.orig/Documentation/driver-api/pm/devices.rst
+++ linux-pm/Documentation/driver-api/pm/devices.rst
@@ -777,14 +777,16 @@ The driver can indicate that by setting
 runtime suspend at the beginning of the ``suspend_late`` phase of system-wide
 suspend (or in the ``poweroff_late`` phase of hibernation), when runtime PM
 has been disabled for it, under the assumption that its state should not change
-after that point until the system-wide transition is over.  If that happens, the
-driver's system-wide resume callbacks, if present, may still be invoked during
-the subsequent system-wide resume transition and the device's runtime power
-management status may be set to "active" before enabling runtime PM for it,
-so the driver must be prepared to cope with the invocation of its system-wide
-resume callbacks back-to-back with its ``->runtime_suspend`` one (without the
-intervening ``->runtime_resume`` and so on) and the final state of the device
-must reflect the "active" status for runtime PM in that case.
+after that point until the system-wide transition is over (the PM core itself
+does that for devices whose "noirq", "late" and "early" system-wide PM callbacks
+are executed directly by it).  If that happens, the driver's system-wide resume
+callbacks, if present, may still be invoked during the subsequent system-wide
+resume transition and the device's runtime power management status may be set
+to "active" before enabling runtime PM for it, so the driver must be prepared to
+cope with the invocation of its system-wide resume callbacks back-to-back with
+its ``->runtime_suspend`` one (without the intervening ``->runtime_resume`` and
+so on) and the final state of the device must reflect the "active" runtime PM
+status in that case.
 
 During system-wide resume from a sleep state it's easiest to put devices into
 the full-power state, as explained in :file:`Documentation/power/runtime_pm.txt`.
Index: linux-pm/drivers/base/power/main.c
===================================================================
--- linux-pm.orig/drivers/base/power/main.c
+++ linux-pm/drivers/base/power/main.c
@@ -540,6 +540,24 @@ void dev_pm_skip_next_resume_phases(stru
 }
 
 /**
+ * suspend_event - Return a "suspend" message for given "resume" one.
+ * @resume_msg: PM message representing a system-wide resume transition.
+ */
+static pm_message_t suspend_event(pm_message_t resume_msg)
+{
+	switch (resume_msg.event) {
+	case PM_EVENT_RESUME:
+		return PMSG_SUSPEND;
+	case PM_EVENT_THAW:
+	case PM_EVENT_RESTORE:
+		return PMSG_FREEZE;
+	case PM_EVENT_RECOVER:
+		return PMSG_HIBERNATE;
+	}
+	return PMSG_ON;
+}
+
+/**
  * dev_pm_may_skip_resume - System-wide device resume optimization check.
  * @dev: Target device.
  *
@@ -580,6 +598,14 @@ static pm_callback_t dpm_subsys_resume_n
 	return callback;
 }
 
+static pm_callback_t dpm_subsys_suspend_noirq_cb(struct device *dev,
+						 pm_message_t state,
+						 const char **info_p);
+
+static pm_callback_t dpm_subsys_suspend_late_cb(struct device *dev,
+						pm_message_t state,
+						const char **info_p);
+
 /**
  * device_resume_noirq - Execute a "noirq resume" callback for given device.
  * @dev: Device to handle.
@@ -607,13 +633,40 @@ static int device_resume_noirq(struct de
 	dpm_wait_for_superior(dev, async);
 
 	callback = dpm_subsys_resume_noirq_cb(dev, state, &info);
+	if (callback)
+		goto Run;
 
-	if (!callback && dev->driver && dev->driver->pm) {
+	if (dev_pm_smart_suspend_and_suspended(dev)) {
+		pm_message_t suspend_msg = suspend_event(state);
+
+		/*
+		 * If "freeze" callbacks have been skipped during a transition
+		 * related to hibernation, the subsequent "thaw" callbacks must
+		 * be skipped too or bad things may happen.  Otherwise, resume
+		 * callbacks are going to be run for the device, so its runtime
+		 * PM status must be changed to reflect the new state after the
+		 * transition under way.
+		 */
+		if (!dpm_subsys_suspend_late_cb(dev, suspend_msg, NULL) &&
+		    !dpm_subsys_suspend_noirq_cb(dev, suspend_msg, NULL)) {
+			if (state.event == PM_EVENT_THAW) {
+				dev_pm_skip_next_resume_phases(dev);
+				goto Skip;
+			} else {
+				pm_runtime_set_active(dev);
+			}
+		}
+	}
+
+	if (dev->driver && dev->driver->pm) {
 		info = "noirq driver ";
 		callback = pm_noirq_op(dev->driver->pm, state);
 	}
 
+Run:
 	error = dpm_run_callback(callback, dev, state, info);
+
+Skip:
 	dev->power.is_noirq_suspended = false;
 
 	if (dev_pm_may_skip_resume(dev)) {
@@ -628,7 +681,7 @@ static int device_resume_noirq(struct de
 		dev_pm_skip_next_resume_phases(dev);
 	}
 
- Out:
+Out:
 	complete_all(&dev->power.completion);
 	TRACE_RESUME(error);
 	return error;
@@ -1223,18 +1276,26 @@ static int __device_suspend_noirq(struct
 		goto Complete;
 
 	callback = dpm_subsys_suspend_noirq_cb(dev, state, &info);
+	if (callback)
+		goto Run;
 
-	if (!callback && dev->driver && dev->driver->pm) {
+	if (dev_pm_smart_suspend_and_suspended(dev) &&
+	    !dpm_subsys_suspend_late_cb(dev, state, NULL))
+		goto Skip;
+
+	if (dev->driver && dev->driver->pm) {
 		info = "noirq driver ";
 		callback = pm_noirq_op(dev->driver->pm, state);
 	}
 
+Run:
 	error = dpm_run_callback(callback, dev, state, info);
 	if (error) {
 		async_error = error;
 		goto Complete;
 	}
 
+Skip:
 	dev->power.is_noirq_suspended = true;
 
 	if (dev_pm_test_driver_flags(dev, DPM_FLAG_LEAVE_SUSPENDED)) {
@@ -1419,17 +1480,27 @@ static int __device_suspend_late(struct
 		goto Complete;
 
 	callback = dpm_subsys_suspend_late_cb(dev, state, &info);
+	if (callback)
+		goto Run;
 
-	if (!callback && dev->driver && dev->driver->pm) {
+	if (dev_pm_smart_suspend_and_suspended(dev) &&
+	    !dpm_subsys_suspend_noirq_cb(dev, state, NULL))
+		goto Skip;
+
+	if (dev->driver && dev->driver->pm) {
 		info = "late driver ";
 		callback = pm_late_early_op(dev->driver->pm, state);
 	}
 
+Run:
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
