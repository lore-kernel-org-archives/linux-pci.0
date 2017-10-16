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
        Kevin Hilman <khilman@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 12/12] PM / core: Add AVOID_RPM driver flag
Date: Mon, 16 Oct 2017 03:32:21 +0200
Message-ID: <2517917.TZ0hdc7mRJ@aspire.rjw.lan>
In-Reply-To: <3806130.B2KCK0tvef@aspire.rjw.lan>
References: <3806130.B2KCK0tvef@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Define and document a new driver flag, DPM_FLAG_AVOID_RPM, to inform
the PM core and middle layer code that the driver has something
significant to do in its ->suspend and/or ->resume callbacks and
runtime PM should be disabled for the device when these callbacks
run.

Setting DPM_FLAG_AVOID_RPM (in addition to DPM_FLAG_SMART_SUSPEND)
causes runtime PM to be disabled for the device before invoking the
driver's ->suspend callback for it and to be enabled again for it
only after the driver's ->resume callback has returned.  In addition
to that, if the device is in runtime suspend right after disabling
runtime PM for it (which means that there was no reason to resume it
from runtime suspend beforehand), the invocation of the ->suspend
callback will be skipped for it and it will be left in runtime
suspend until the "noirq" phase of the subsequent system resume.

If DPM_FLAG_SMART_SUSPEND is not set, DPM_FLAG_AVOID_RPM has no
effect.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/driver-api/pm/devices.rst |   14 ++++++
 Documentation/power/pci.txt             |    9 +++-
 drivers/acpi/device_pm.c                |   24 ++++++++++-
 drivers/base/power/main.c               |   31 ++++++++++++++
 drivers/pci/pci-driver.c                |   69 ++++++++++++++++++++++----------
 include/linux/pm.h                      |   10 ++++
 6 files changed, 134 insertions(+), 23 deletions(-)

Index: linux-pm/include/linux/pm.h
===================================================================
--- linux-pm.orig/include/linux/pm.h
+++ linux-pm/include/linux/pm.h
@@ -560,6 +560,7 @@ struct pm_subsys_data {
  * SMART_PREPARE: Check the return value of the driver's ->prepare callback.
  * SMART_SUSPEND: No need to resume the device from runtime suspend.
  * LEAVE_SUSPENDED: Avoid resuming the device during system resume if possible.
+ * AVOID_RPM: Disable runtime PM and check its status before ->suspend.
  *
  * Setting SMART_PREPARE instructs bus types and PM domains which may want
  * system suspend/resume callbacks to be skipped for the device to return 0 from
@@ -577,11 +578,17 @@ struct pm_subsys_data {
  *
  * Setting LEAVE_SUSPENDED informs the PM core and middle layer code that the
  * driver prefers the device to be left in runtime suspend after system resume.
+ *
+ * Setting AVOID_RPM informs the PM core and middle layer code that the driver
+ * has something significant to do in its ->suspend and/or ->resume callbacks
+ * and runtime PM should be disabled for the device when these callbacks run.
+ * If SMART_SUSPEND is not set, this flag has no effect.
  */
 #define DPM_FLAG_NEVER_SKIP		BIT(0)
 #define DPM_FLAG_SMART_PREPARE		BIT(1)
 #define DPM_FLAG_SMART_SUSPEND		BIT(2)
 #define DPM_FLAG_LEAVE_SUSPENDED	BIT(3)
+#define DPM_FLAG_AVOID_RPM		BIT(4)
 
 struct dev_pm_info {
 	pm_message_t		power_state;
@@ -604,6 +611,7 @@ struct dev_pm_info {
 	bool			syscore:1;
 	bool			no_pm_callbacks:1;	/* Owned by the PM core */
 	unsigned int		must_resume:1;	/* Owned by the PM core */
+	unsigned int		rpm_reenable:1;	/* Do not modify directly */
 #else
 	unsigned int		should_wakeup:1;
 #endif
@@ -741,6 +749,8 @@ extern int dpm_suspend_late(pm_message_t
 extern int dpm_suspend(pm_message_t state);
 extern int dpm_prepare(pm_message_t state);
 
+extern void dpm_disable_runtime_pm_early(struct device *dev);
+
 extern void __suspend_report_result(const char *function, void *fn, int ret);
 
 #define suspend_report_result(fn, ret)					\
Index: linux-pm/drivers/base/power/main.c
===================================================================
--- linux-pm.orig/drivers/base/power/main.c
+++ linux-pm/drivers/base/power/main.c
@@ -906,6 +906,10 @@ static int device_resume(struct device *
  Unlock:
 	device_unlock(dev);
 	dpm_watchdog_clear(&wd);
+	if (dev->power.rpm_reenable) {
+		pm_runtime_enable(dev);
+		dev->power.rpm_reenable = false;
+	}
 
  Complete:
 	complete_all(&dev->power.completion);
@@ -1534,6 +1538,12 @@ static int legacy_suspend(struct device
 	return error;
 }
 
+void dpm_disable_runtime_pm_early(struct device *dev)
+{
+	pm_runtime_disable(dev);
+	dev->power.rpm_reenable = true;
+}
+
 static void dpm_clear_suppliers_direct_complete(struct device *dev)
 {
 	struct device_link *link;
@@ -1636,6 +1646,27 @@ static int __device_suspend(struct devic
 	if (!callback && dev->driver && dev->driver->pm) {
 		info = "driver ";
 		callback = pm_op(dev->driver->pm, state);
+		if (callback &&
+		    dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND) &&
+		    dev_pm_test_driver_flags(dev, DPM_FLAG_AVOID_RPM)) {
+			/*
+			 * Device wakeup is enabled for runtime PM, so if the
+			 * device is not expected to wake up the system from
+			 * sleep, resume it now so that it can be reconfigured.
+			 */
+			if (device_can_wakeup(dev) && !device_may_wakeup(dev))
+				pm_runtime_resume(dev);
+
+			dpm_disable_runtime_pm_early(dev);
+			/*
+			 * If the device is already suspended now, it won't be
+			 * resumed until the subsequent system resume starts and
+			 * there is no need to suspend it again, so simply skip
+			 * the callback for it.
+			 */
+			if (pm_runtime_status_suspended(dev))
+				goto End;
+		}
 	}
 
 	error = dpm_run_callback(callback, dev, state, info);
Index: linux-pm/drivers/pci/pci-driver.c
===================================================================
--- linux-pm.orig/drivers/pci/pci-driver.c
+++ linux-pm/drivers/pci/pci-driver.c
@@ -708,6 +708,39 @@ static void pci_pm_complete(struct devic
 	}
 }
 
+static bool pci_pm_check_suspend(struct device *dev)
+{
+	/*
+	 * PCI devices suspended at run time may need to be resumed at this
+	 * point, because in general it may be necessary to reconfigure them for
+	 * system suspend.  Namely, if the device is expected to wake up the
+	 * system from the sleep state, it may have to be reconfigured for this
+	 * purpose, or if the device is not expected to wake up the system from
+	 * the sleep state, it should be prevented from signaling wakeup events
+	 * going forward.
+	 *
+	 * Also if the driver of the device does not indicate that its system
+	 * suspend callbacks can cope with runtime-suspended devices, it is
+	 * better to resume the device from runtime suspend here.
+	 */
+	if (!dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND) ||
+	    !pci_dev_keep_suspended(to_pci_dev(dev)))
+		pm_runtime_resume(dev);
+
+	if (dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND) &&
+	    dev_pm_test_driver_flags(dev, DPM_FLAG_AVOID_RPM)) {
+		dpm_disable_runtime_pm_early(dev);
+		/*
+		 * If the device is in runtime suspend now, it won't be resumed
+		 * until the subsequent system resume starts and there is no
+		 * need to suspend it again, so let the callers know about that.
+		 */
+		if (pm_runtime_status_suspended(dev))
+			return true;
+	}
+	return false;
+}
+
 #else /* !CONFIG_PM_SLEEP */
 
 #define pci_pm_prepare	NULL
@@ -730,22 +763,8 @@ static int pci_pm_suspend(struct device
 		return 0;
 	}
 
-	/*
-	 * PCI devices suspended at run time may need to be resumed at this
-	 * point, because in general it may be necessary to reconfigure them for
-	 * system suspend.  Namely, if the device is expected to wake up the
-	 * system from the sleep state, it may have to be reconfigured for this
-	 * purpose, or if the device is not expected to wake up the system from
-	 * the sleep state, it should be prevented from signaling wakeup events
-	 * going forward.
-	 *
-	 * Also if the driver of the device does not indicate that its system
-	 * suspend callbacks can cope with runtime-suspended devices, it is
-	 * better to resume the device from runtime suspend here.
-	 */
-	if (!dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND) ||
-	    !pci_dev_keep_suspended(pci_dev))
-		pm_runtime_resume(dev);
+	if (pci_pm_check_suspend(dev))
+		return 0;
 
 	pci_dev->state_saved = false;
 	if (pm->suspend) {
@@ -918,8 +937,18 @@ static int pci_pm_freeze(struct device *
 	 * devices should not be touched during freeze/thaw transitions,
 	 * however.
 	 */
-	if (!dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND))
+	if (!dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND)) {
 		pm_runtime_resume(dev);
+	} else if (dev_pm_test_driver_flags(dev, DPM_FLAG_AVOID_RPM)) {
+		dpm_disable_runtime_pm_early(dev);
+		/*
+		 * If the device is in runtime suspend now, it won't be resumed
+		 * until the subsequent system resume starts and there is no
+		 * need to suspend it again, so simply skip the callback for it.
+		 */
+		if (pm_runtime_status_suspended(dev))
+			return 0;
+	}
 
 	pci_dev->state_saved = false;
 	if (pm->freeze) {
@@ -1020,10 +1049,8 @@ static int pci_pm_poweroff(struct device
 		return 0;
 	}
 
-	/* The reason to do that is the same as in pci_pm_suspend(). */
-	if (!dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND) ||
-	    !pci_dev_keep_suspended(pci_dev))
-		pm_runtime_resume(dev);
+	if (pci_pm_check_suspend(dev))
+		return 0;
 
 	pci_dev->state_saved = false;
 	if (pm->poweroff) {
Index: linux-pm/drivers/acpi/device_pm.c
===================================================================
--- linux-pm.orig/drivers/acpi/device_pm.c
+++ linux-pm/drivers/acpi/device_pm.c
@@ -1005,6 +1005,18 @@ int acpi_subsys_suspend(struct device *d
 	    acpi_dev_needs_resume(dev, ACPI_COMPANION(dev)))
 		pm_runtime_resume(dev);
 
+	if (dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND) &&
+	    dev_pm_test_driver_flags(dev, DPM_FLAG_AVOID_RPM)) {
+		dpm_disable_runtime_pm_early(dev);
+		/*
+		 * If the device is in runtime suspend now, it won't be resumed
+		 * until the subsequent system resume starts and there is no
+		 * need to suspend it again, so let the callers know about that.
+		 */
+		if (pm_runtime_status_suspended(dev))
+			return 0;
+	}
+
 	return pm_generic_suspend(dev);
 }
 EXPORT_SYMBOL_GPL(acpi_subsys_suspend);
@@ -1050,8 +1062,18 @@ int acpi_subsys_freeze(struct device *de
 	 * runtime-suspended devices should not be touched during freeze/thaw
 	 * transitions.
 	 */
-	if (!dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND))
+	if (!dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND)) {
 		pm_runtime_resume(dev);
+	} else if (dev_pm_test_driver_flags(dev, DPM_FLAG_AVOID_RPM)) {
+		dpm_disable_runtime_pm_early(dev);
+		/*
+		 * If the device is in runtime suspend now, it won't be resumed
+		 * until the subsequent system resume starts and there is no
+		 * need to suspend it again, so let the callers know about that.
+		 */
+		if (pm_runtime_status_suspended(dev))
+			return 0;
+	}
 
 	return pm_generic_freeze(dev);
 }
Index: linux-pm/Documentation/driver-api/pm/devices.rst
===================================================================
--- linux-pm.orig/Documentation/driver-api/pm/devices.rst
+++ linux-pm/Documentation/driver-api/pm/devices.rst
@@ -783,6 +783,20 @@ phase of device resume (right prior to e
 to prevent runtime PM from acting on them before the ``complete`` phase, which
 means that they should be put into the full-power state before that phase.
 
+The handling of ``DPM_FLAG_SMART_SUSPEND`` can be extended by setting another
+power management driver flag, ``DPM_FLAG_AVOID_RPM`` (it has no effect without
+``DPM_FLAG_SMART_SUSPEND`` set).  Setting it informs the PM core and middle
+layer code that the driver's ``->suspend`` and/or ``->resume`` callbacks are
+not trivial and need to be run with runtime PM disabled.  Consequently,
+runtime PM is disabled before running the ``->suspend`` callback for devices
+with both ``DPM_FLAG_SMART_SUSPEND`` and ``DPM_FLAG_AVOID_RPM`` set and it is
+enabled again only after the driver's ``->resume`` callback has returned.  In
+addition to that, if the device is in runtime suspend right after disabling
+runtime PM for it (which means that there was no reason to resume it from
+runtime suspend beforehand), the invocation of the ``->suspend`` callback will
+be skipped for it and it will be left in runtime suspend until the ongoing
+system-wide power transition is over.
+
 During system-wide resume from a sleep state it's easiest to put devices into
 the full-power state, as explained in :file:`Documentation/power/runtime_pm.txt`.
 [Refer to that document for more information regarding this particular issue as
Index: linux-pm/Documentation/power/pci.txt
===================================================================
--- linux-pm.orig/Documentation/power/pci.txt
+++ linux-pm/Documentation/power/pci.txt
@@ -984,7 +984,14 @@ The DPM_FLAG_SMART_SUSPEND flag tells th
 perspective the device can be safely left in runtime suspend during system
 suspend.  That causes pci_pm_suspend(), pci_pm_freeze() and pci_pm_poweroff()
 to skip resuming the device from runtime suspend unless there are PCI-specific
-reasons for doing that.
+reasons for doing that.  In addition to that, drivers can use the
+DPM_FLAG_AVOID_RPM flag to inform the PCI bus type that its .suspend() and
+.resume() callbacks need to be run with runtime PM disabled (this flag has no
+effect without DPM_FLAG_SMART_SUSPEND set).  Then, if the device is in runtime
+suspend afrer runtime PM has been disabled for it, which means that there was
+no reason to resume it from runtime suspend beforehand, it won't be resumed
+until the ongoing system transition is over, so the execution of system suspend
+callbacks for it during that transition will be skipped.
 
 3.2. Device Runtime Power Management
 ------------------------------------

