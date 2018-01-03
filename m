Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cloudserver094114.home.pl ([79.96.170.134]:53974 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751029AbeACAko (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Jan 2018 19:40:44 -0500
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
Subject: [PATCH 3/7] PM / core: Direct DPM_FLAG_LEAVE_SUSPENDED handling
Date: Wed, 03 Jan 2018 01:33:30 +0100
Message-ID: <9360418.FDUNOb7YBQ@aspire.rjw.lan>
In-Reply-To: <2436726.ykYRzVD45y@aspire.rjw.lan>
References: <7742130.AaJQIxeI1n@aspire.rjw.lan> <2436726.ykYRzVD45y@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make the PM core handle DPM_FLAG_LEAVE_SUSPENDED directly for
devices whose "noirq", "late" and "early" driver callbacks are
invoked directly by it.

Namely, make it skip all of the system-wide resume callbacks for
such devices with DPM_FLAG_LEAVE_SUSPENDED set if (1) they are in
runtime suspend during the "noirq" phase of system-wide suspend
(or analogous) transitions or (2) the system transition under way is
a proper suspend (rather than anything related to hibernation) and
the device's wakeup settings are compatible with runtime PM (that
is, the device cannot generate wakeup signals at all or it is
allowed to wake up the system from sleep).

The underlying observation is that if either (1) or (2) takes place,
it simply is not necessary to invoke any resume callbacks for the
device that can be left in suspend.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/driver-api/pm/devices.rst |    9 +++++
 drivers/base/power/main.c               |   51 +++++++++++++++++++++++++-------
 2 files changed, 49 insertions(+), 11 deletions(-)

Index: linux-pm/Documentation/driver-api/pm/devices.rst
===================================================================
--- linux-pm.orig/Documentation/driver-api/pm/devices.rst
+++ linux-pm/Documentation/driver-api/pm/devices.rst
@@ -816,3 +816,12 @@ appropriate in its "noirq" resume callba
 whether or not the device is left suspended, but the other resume callbacks
 (except for ``->complete``) will be skipped automatically by the PM core if the
 device really can be left in suspend.
+
+For devices whose "noirq", "late" and "early" driver callbacks are invoked
+directly by the PM core, all of the system-wide resume callbacks are skipped if
+``DPM_FLAG_LEAVE_SUSPENDED`` is set and the device is in runtime suspend during
+the ``suspend_noirq`` (or analogous) phase or the transition under way is a
+proper system suspend (rather than anything related to hibernation) and the
+device's wakeup settings are suitable for runtime PM (that is, it cannot
+generate wakeup signals at all or it is allowed to wake up the system from
+sleep).
Index: linux-pm/drivers/base/power/main.c
===================================================================
--- linux-pm.orig/drivers/base/power/main.c
+++ linux-pm/drivers/base/power/main.c
@@ -619,6 +619,7 @@ static int device_resume_noirq(struct de
 {
 	pm_callback_t callback;
 	const char *info;
+	bool skip_resume;
 	int error = 0;
 
 	TRACE_DEVICE(dev);
@@ -632,10 +633,15 @@ static int device_resume_noirq(struct de
 
 	dpm_wait_for_superior(dev, async);
 
+	skip_resume = dev_pm_may_skip_resume(dev);
+
 	callback = dpm_subsys_resume_noirq_cb(dev, state, &info);
 	if (callback)
 		goto Run;
 
+	if (skip_resume)
+		goto Skip;
+
 	if (dev_pm_smart_suspend_and_suspended(dev)) {
 		pm_message_t suspend_msg = suspend_event(state);
 
@@ -650,7 +656,7 @@ static int device_resume_noirq(struct de
 		if (!dpm_subsys_suspend_late_cb(dev, suspend_msg, NULL) &&
 		    !dpm_subsys_suspend_noirq_cb(dev, suspend_msg, NULL)) {
 			if (state.event == PM_EVENT_THAW) {
-				dev_pm_skip_next_resume_phases(dev);
+				skip_resume = true;
 				goto Skip;
 			} else {
 				pm_runtime_set_active(dev);
@@ -669,7 +675,7 @@ Run:
 Skip:
 	dev->power.is_noirq_suspended = false;
 
-	if (dev_pm_may_skip_resume(dev)) {
+	if (skip_resume) {
 		/*
 		 * The device is going to be left in suspend, but it might not
 		 * have been in runtime suspend before the system suspended, so
@@ -1244,6 +1250,32 @@ static pm_callback_t dpm_subsys_suspend_
 	return callback;
 }
 
+static bool device_must_resume(struct device *dev, pm_message_t state,
+			       bool no_subsys_suspend_noirq)
+{
+	pm_message_t resume_msg = resume_event(state);
+
+	/*
+	 * If all of the device driver's "noirq", "late" and "early" callbacks
+	 * are invoked directly by the core, the decision to allow the device to
+	 * stay in suspend can be based on its current runtime PM status and its
+	 * wakeup settings.
+	 */
+	if (no_subsys_suspend_noirq &&
+	    !dpm_subsys_suspend_late_cb(dev, state, NULL) &&
+	    !dpm_subsys_resume_early_cb(dev, resume_msg, NULL) &&
+	    !dpm_subsys_resume_noirq_cb(dev, resume_msg, NULL))
+		return !pm_runtime_status_suspended(dev) &&
+			(resume_msg.event != PM_EVENT_RESUME ||
+			 (device_can_wakeup(dev) && !device_may_wakeup(dev)));
+
+	/*
+	 * The only safe strategy here is to require that if the device may not
+	 * be left in suspend, resume callbacks must be invoked for it.
+	 */
+	return !dev->power.may_skip_resume;
+}
+
 /**
  * __device_suspend_noirq - Execute a "noirq suspend" callback for given device.
  * @dev: Device to handle.
@@ -1257,6 +1289,7 @@ static int __device_suspend_noirq(struct
 {
 	pm_callback_t callback;
 	const char *info;
+	bool no_subsys_cb = false;
 	int error = 0;
 
 	TRACE_DEVICE(dev);
@@ -1279,8 +1312,9 @@ static int __device_suspend_noirq(struct
 	if (callback)
 		goto Run;
 
-	if (dev_pm_smart_suspend_and_suspended(dev) &&
-	    !dpm_subsys_suspend_late_cb(dev, state, NULL))
+	no_subsys_cb = !dpm_subsys_suspend_late_cb(dev, state, NULL);
+
+	if (dev_pm_smart_suspend_and_suspended(dev) && no_subsys_cb)
 		goto Skip;
 
 	if (dev->driver && dev->driver->pm) {
@@ -1299,14 +1333,9 @@ Skip:
 	dev->power.is_noirq_suspended = true;
 
 	if (dev_pm_test_driver_flags(dev, DPM_FLAG_LEAVE_SUSPENDED)) {
-		/*
-		 * The only safe strategy here is to require that if the device
-		 * may not be left in suspend, resume callbacks must be invoked
-		 * for it.
-		 */
 		dev->power.must_resume = dev->power.must_resume ||
-					!dev->power.may_skip_resume ||
-					atomic_read(&dev->power.usage_count) > 1;
+				atomic_read(&dev->power.usage_count) > 1 ||
+				device_must_resume(dev, state, no_subsys_cb);
 	} else {
 		dev->power.must_resume = true;
 	}
