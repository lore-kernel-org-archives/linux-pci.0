Return-Path: <linux-acpi-owner@vger.kernel.org>
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
Subject: [PATCH v4 6/6] PM / core: DPM_FLAG_SMART_SUSPEND optimization
Date: Sat, 18 Nov 2017 15:44:20 +0100
Message-ID: <1873416.HYIif9Jb2q@aspire.rjw.lan>
In-Reply-To: <1917233.X2U0QN21my@aspire.rjw.lan>
References: <3806130.B2KCK0tvef@aspire.rjw.lan> <4184911.zoJM7jZeH4@aspire.rjw.lan> <1917233.X2U0QN21my@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make the PM core avoid invoking the "late" and "noirq" system-wide
suspend (or analogous) callbacks for devices that are in runtime
suspend during the corresponding phases of system-wide suspend
(or analogous) transitions.

The underlying observation is that runtime PM is disabled for
devices during those system-wide suspend phases, so their runtime
PM status should not change going forward and if it has not changed
so far, their state should be compatible with the target system
sleep state.

This change really makes it possible for, say, platform device
drivers to re-use runtime PM suspend and resume callbacks by
pointing ->suspend_late and ->resume_early, respectively (and
possibly the analogous hibernation-related callback pointers too),
to them without adding any extra "is the device already suspended?"
type of checks to the callback routines, as long as they will be
invoked directly by the core.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v3 -> v4: Add a forward declaration of dpm_subsys_suspend_noirq_cb()
          dropped from patch [4/6].

v2 -> v3: No changes.

---
 Documentation/driver-api/pm/devices.rst |   18 ++++----
 drivers/base/power/main.c               |   66 +++++++++++++++++++++++++++++---
 2 files changed, 70 insertions(+), 14 deletions(-)

Index: linux-pm/drivers/base/power/main.c
===================================================================
--- linux-pm.orig/drivers/base/power/main.c
+++ linux-pm/drivers/base/power/main.c
@@ -525,6 +525,10 @@ static void dpm_watchdog_clear(struct dp
 #define dpm_watchdog_clear(x)
 #endif
 
+static pm_callback_t dpm_subsys_suspend_noirq_cb(struct device *dev,
+						 pm_message_t state,
+						 const char **info_p);
+
 static pm_callback_t dpm_subsys_suspend_late_cb(struct device *dev,
 						pm_message_t state,
 						const char **info_p);
@@ -532,6 +536,24 @@ static pm_callback_t dpm_subsys_suspend_
 /*------------------------- Resume routines -------------------------*/
 
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
@@ -605,6 +627,25 @@ static int device_resume_noirq(struct de
 	if (callback)
 		goto Run;
 
+	if (dev_pm_smart_suspend_and_suspended(dev)) {
+		pm_message_t suspend_msg = suspend_event(state);
+
+		/*
+		 * If "freeze" callbacks have been skipped during a transition
+		 * related to hibernation, the subsequent "thaw" callbacks must
+		 * be skipped too or bad things may happen.  Otherwise, if the
+		 * device is to be resumed, its runtime PM status must be
+		 * changed to reflect the new configuration.
+		 */
+		if (!dpm_subsys_suspend_late_cb(dev, suspend_msg, NULL) &&
+		    !dpm_subsys_suspend_noirq_cb(dev, suspend_msg, NULL)) {
+			if (state.event == PM_EVENT_THAW)
+				skip_resume = true;
+			else if (!skip_resume)
+				pm_runtime_set_active(dev);
+		}
+	}
+
 	if (skip_resume)
 		goto Skip;
 
@@ -1231,7 +1272,10 @@ static int __device_suspend_noirq(struct
 	if (callback)
 		goto Run;
 
-	direct_cb = true;
+	direct_cb = !dpm_subsys_suspend_late_cb(dev, state, NULL);
+
+	if (dev_pm_smart_suspend_and_suspended(dev) && direct_cb)
+		goto Skip;
 
 	if (dev->driver && dev->driver->pm) {
 		info = "noirq driver ";
@@ -1245,6 +1289,7 @@ Run:
 		goto Complete;
 	}
 
+Skip:
 	dev->power.is_noirq_suspended = true;
 
 	if (dev_pm_test_driver_flags(dev, DPM_FLAG_LEAVE_SUSPENDED)) {
@@ -1252,7 +1297,6 @@ Run:
 		bool skip_resume;
 
 		if (direct_cb &&
-		    !dpm_subsys_suspend_late_cb(dev, state, NULL) &&
 		    !dpm_subsys_resume_early_cb(dev, resume_msg, NULL) &&
 		    !dpm_subsys_resume_noirq_cb(dev, resume_msg, NULL)) {
 			/*
@@ -1449,17 +1493,27 @@ static int __device_suspend_late(struct
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
+so on) and the final state of the device must reflect the "active" status for
+runtime PM in that case.
 
 During system-wide resume from a sleep state it's easiest to put devices into
 the full-power state, as explained in :file:`Documentation/power/runtime_pm.txt`.

