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
Subject: [PATCH v2 6/6] ACPI / PM: Take SMART_SUSPEND driver flag into account
Date: Sat, 28 Oct 2017 00:30:22 +0200
Message-ID: <2597555.h6MTS7kK60@aspire.rjw.lan>
In-Reply-To: <16592954.7Zo1mAdIIH@aspire.rjw.lan>
References: <3806130.B2KCK0tvef@aspire.rjw.lan> <16592954.7Zo1mAdIIH@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make the ACPI PM domain take DPM_FLAG_SMART_SUSPEND into account in
its system suspend callbacks.

[Note that the pm_runtime_suspended() check in acpi_dev_needs_resume()
is an optimization, because if is not passed, all of the subsequent
checks may be skipped and some of them are much more overhead in
general.]

Also use the observation that if the device is in runtime suspend
at the beginning of the "late" phase of a system-wide suspend-like
transition, its state cannot change going forward (runtime PM is
disabled for it at that time) until the transition is over and the
subsequent system-wide PM callbacks should be skipped for it (as
they generally assume the device to not be suspended), so add
checks for that in acpi_subsys_suspend_late/noirq() and
acpi_subsys_freeze_late/noirq().

Moreover, if acpi_subsys_resume_noirq() is called during the
subsequent system-wide resume transition and if the device was left
in runtime suspend previously, its runtime PM status needs to be
changed to "active" as it is going to be put into the full-power
state going forward, so add a check for that too in there.

In turn, if acpi_subsys_thaw_noirq() runs after the device has been
left in runtime suspend, the subsequent "thaw" callbacks need
to be skipped for it (as they may not work correctly with a
suspended device), so set the power.direct_complete flag for the
device then to make the PM core skip those callbacks.

On top of the above, make the analogous changes in the acpi_lpss
driver that uses the ACPI PM domain callbacks.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

-> v2: Implement the entire handling of DPM_FLAG_SMART_SUSPEND in the ACPI PM
       domain (instead of relying on the core to handle it).  Among other
       things this requires some more callbacks to be provided.

---
 drivers/acpi/acpi_lpss.c |   13 ++++-
 drivers/acpi/device_pm.c |  113 +++++++++++++++++++++++++++++++++++++++++++----
 include/linux/acpi.h     |   10 ++++
 3 files changed, 126 insertions(+), 10 deletions(-)

Index: linux-pm/drivers/acpi/device_pm.c
===================================================================
--- linux-pm.orig/drivers/acpi/device_pm.c
+++ linux-pm/drivers/acpi/device_pm.c
@@ -936,7 +936,8 @@ static bool acpi_dev_needs_resume(struct
 	u32 sys_target = acpi_target_system_state();
 	int ret, state;
 
-	if (device_may_wakeup(dev) != !!adev->wakeup.prepare_count)
+	if (!pm_runtime_suspended(dev) || !adev ||
+	    device_may_wakeup(dev) != !!adev->wakeup.prepare_count)
 		return true;
 
 	if (sys_target == ACPI_STATE_S0)
@@ -970,9 +971,6 @@ int acpi_subsys_prepare(struct device *d
 			return 0;
 	}
 
-	if (!adev || !pm_runtime_suspended(dev))
-		return 0;
-
 	return !acpi_dev_needs_resume(dev, adev);
 }
 EXPORT_SYMBOL_GPL(acpi_subsys_prepare);
@@ -998,12 +996,17 @@ EXPORT_SYMBOL_GPL(acpi_subsys_complete);
  * acpi_subsys_suspend - Run the device driver's suspend callback.
  * @dev: Device to handle.
  *
- * Follow PCI and resume devices suspended at run time before running their
- * system suspend callbacks.
+ * Follow PCI and resume devices from runtime suspend before running their
+ * system suspend callbacks, unless the driver can cope with runtime-suspended
+ * devices during system suspend and there are no ACPI-specific reasons for
+ * resuming them.
  */
 int acpi_subsys_suspend(struct device *dev)
 {
-	pm_runtime_resume(dev);
+	if (!dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND) ||
+	    acpi_dev_needs_resume(dev, ACPI_COMPANION(dev)))
+		pm_runtime_resume(dev);
+
 	return pm_generic_suspend(dev);
 }
 EXPORT_SYMBOL_GPL(acpi_subsys_suspend);
@@ -1017,12 +1020,48 @@ EXPORT_SYMBOL_GPL(acpi_subsys_suspend);
  */
 int acpi_subsys_suspend_late(struct device *dev)
 {
-	int ret = pm_generic_suspend_late(dev);
+	int ret;
+
+	if (dev_pm_smart_suspend_and_suspended(dev))
+		return 0;
+
+	ret = pm_generic_suspend_late(dev);
 	return ret ? ret : acpi_dev_suspend(dev, device_may_wakeup(dev));
 }
 EXPORT_SYMBOL_GPL(acpi_subsys_suspend_late);
 
 /**
+ * acpi_subsys_suspend_noirq - Run the device driver's "noirq" suspend callback.
+ * @dev: Device to suspend.
+ */
+int acpi_subsys_suspend_noirq(struct device *dev)
+{
+	if (dev_pm_smart_suspend_and_suspended(dev))
+		return 0;
+
+	return pm_generic_suspend_noirq(dev);
+}
+EXPORT_SYMBOL_GPL(acpi_subsys_suspend_noirq);
+
+/**
+ * acpi_subsys_resume_noirq - Run the device driver's "noirq" resume callback.
+ * @dev: Device to handle.
+ */
+int acpi_subsys_resume_noirq(struct device *dev)
+{
+	/*
+	 * Devices with DPM_FLAG_SMART_SUSPEND may be left in runtime suspend
+	 * during system suspend, so update their runtime PM status to "active"
+	 * as they will be put into D0 going forward.
+	 */
+	if (dev_pm_smart_suspend_and_suspended(dev))
+		pm_runtime_set_active(dev);
+
+	return pm_generic_resume_noirq(dev);
+}
+EXPORT_SYMBOL_GPL(acpi_subsys_resume_noirq);
+
+/**
  * acpi_subsys_resume_early - Resume device using ACPI.
  * @dev: Device to Resume.
  *
@@ -1049,11 +1088,60 @@ int acpi_subsys_freeze(struct device *de
 	 * runtime-suspended devices should not be touched during freeze/thaw
 	 * transitions.
 	 */
-	pm_runtime_resume(dev);
+	if (!dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND))
+		pm_runtime_resume(dev);
+
 	return pm_generic_freeze(dev);
 }
 EXPORT_SYMBOL_GPL(acpi_subsys_freeze);
 
+/**
+ * acpi_subsys_freeze_late - Run the device driver's "late" freeze callback.
+ * @dev: Device to handle.
+ */
+int acpi_subsys_freeze_late(struct device *dev)
+{
+
+	if (dev_pm_smart_suspend_and_suspended(dev))
+		return 0;
+
+	return pm_generic_freeze_late(dev);
+}
+EXPORT_SYMBOL_GPL(acpi_subsys_freeze_late);
+
+/**
+ * acpi_subsys_freeze_noirq - Run the device driver's "noirq" freeze callback.
+ * @dev: Device to handle.
+ */
+int acpi_subsys_freeze_noirq(struct device *dev)
+{
+
+	if (dev_pm_smart_suspend_and_suspended(dev))
+		return 0;
+
+	return pm_generic_freeze_noirq(dev);
+}
+EXPORT_SYMBOL_GPL(acpi_subsys_freeze_noirq);
+
+/**
+ * acpi_subsys_thaw_noirq - Run the device driver's "noirq" thaw callback.
+ * @dev: Device to handle.
+ */
+int acpi_subsys_thaw_noirq(struct device *dev)
+{
+	/*
+	 * If the device is in runtime suspend, the "thaw" code may not work
+	 * correctly with it, so skip the driver callback and make the PM core
+	 * skip all of the subsequent "thaw" callbacks for the device.
+	 */
+	if (dev_pm_smart_suspend_and_suspended(dev)) {
+		dev->power.direct_complete = true;
+		return 0;
+	}
+
+	return pm_generic_thaw_noirq(dev);
+}
+EXPORT_SYMBOL_GPL(acpi_subsys_thaw_noirq);
 #endif /* CONFIG_PM_SLEEP */
 
 static struct dev_pm_domain acpi_general_pm_domain = {
@@ -1065,10 +1153,17 @@ static struct dev_pm_domain acpi_general
 		.complete = acpi_subsys_complete,
 		.suspend = acpi_subsys_suspend,
 		.suspend_late = acpi_subsys_suspend_late,
+		.suspend_noirq = acpi_subsys_suspend_noirq,
+		.resume_noirq = acpi_subsys_resume_noirq,
 		.resume_early = acpi_subsys_resume_early,
 		.freeze = acpi_subsys_freeze,
+		.freeze_late = acpi_subsys_freeze_late,
+		.freeze_noirq = acpi_subsys_freeze_noirq,
+		.thaw_noirq = acpi_subsys_thaw_noirq,
 		.poweroff = acpi_subsys_suspend,
 		.poweroff_late = acpi_subsys_suspend_late,
+		.poweroff_noirq = acpi_subsys_suspend_noirq,
+		.restore_noirq = acpi_subsys_resume_noirq,
 		.restore_early = acpi_subsys_resume_early,
 #endif
 	},
Index: linux-pm/drivers/acpi/acpi_lpss.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpi_lpss.c
+++ linux-pm/drivers/acpi/acpi_lpss.c
@@ -849,8 +849,12 @@ static int acpi_lpss_resume(struct devic
 #ifdef CONFIG_PM_SLEEP
 static int acpi_lpss_suspend_late(struct device *dev)
 {
-	int ret = pm_generic_suspend_late(dev);
+	int ret;
 
+	if (dev_pm_smart_suspend_and_suspended(dev))
+		return 0;
+
+	ret = pm_generic_suspend_late(dev);
 	return ret ? ret : acpi_lpss_suspend(dev, device_may_wakeup(dev));
 }
 
@@ -889,10 +893,17 @@ static struct dev_pm_domain acpi_lpss_pm
 		.complete = acpi_subsys_complete,
 		.suspend = acpi_subsys_suspend,
 		.suspend_late = acpi_lpss_suspend_late,
+		.suspend_noirq = acpi_subsys_suspend_noirq,
+		.resume_noirq = acpi_subsys_resume_noirq,
 		.resume_early = acpi_lpss_resume_early,
 		.freeze = acpi_subsys_freeze,
+		.freeze_late = acpi_subsys_freeze_late,
+		.freeze_noirq = acpi_subsys_freeze_noirq,
+		.thaw_noirq = acpi_subsys_thaw_noirq,
 		.poweroff = acpi_subsys_suspend,
 		.poweroff_late = acpi_lpss_suspend_late,
+		.poweroff_noirq = acpi_subsys_suspend_noirq,
+		.restore_noirq = acpi_subsys_resume_noirq,
 		.restore_early = acpi_lpss_resume_early,
 #endif
 		.runtime_suspend = acpi_lpss_runtime_suspend,
Index: linux-pm/include/linux/acpi.h
===================================================================
--- linux-pm.orig/include/linux/acpi.h
+++ linux-pm/include/linux/acpi.h
@@ -885,17 +885,27 @@ int acpi_dev_suspend_late(struct device
 int acpi_subsys_prepare(struct device *dev);
 void acpi_subsys_complete(struct device *dev);
 int acpi_subsys_suspend_late(struct device *dev);
+int acpi_subsys_suspend_noirq(struct device *dev);
+int acpi_subsys_resume_noirq(struct device *dev);
 int acpi_subsys_resume_early(struct device *dev);
 int acpi_subsys_suspend(struct device *dev);
 int acpi_subsys_freeze(struct device *dev);
+int acpi_subsys_freeze_late(struct device *dev);
+int acpi_subsys_freeze_noirq(struct device *dev);
+int acpi_subsys_thaw_noirq(struct device *dev);
 #else
 static inline int acpi_dev_resume_early(struct device *dev) { return 0; }
 static inline int acpi_subsys_prepare(struct device *dev) { return 0; }
 static inline void acpi_subsys_complete(struct device *dev) {}
 static inline int acpi_subsys_suspend_late(struct device *dev) { return 0; }
+static inline int acpi_subsys_suspend_noirq(struct device *dev) { return 0; }
+static inline int acpi_subsys_resume_noirq(struct device *dev) { return 0; }
 static inline int acpi_subsys_resume_early(struct device *dev) { return 0; }
 static inline int acpi_subsys_suspend(struct device *dev) { return 0; }
 static inline int acpi_subsys_freeze(struct device *dev) { return 0; }
+static inline int acpi_subsys_freeze_late(struct device *dev) { return 0; }
+static inline int acpi_subsys_freeze_noirq(struct device *dev) { return 0; }
+static inline int acpi_subsys_thaw_noirq(struct device *dev) { return 0; }
 #endif
 
 #ifdef CONFIG_ACPI

