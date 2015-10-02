Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Daniel Vetter <daniel.vetter@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linux PCI <linux-pci@vger.kernel.org>
Subject: [RFC][PATCH v2 2/2] PM / PCI / ACPI: Kick devices that might have been reset by firmware
Date: Fri, 02 Oct 2015 03:54:52 +0200
Message-ID: <2845319.uTdi8Ml1JD@vostro.rjw.lan>
In-Reply-To: <5472042.4c1h9diL7E@vostro.rjw.lan>
References: <10641052.oOBhM6BU9G@vostro.rjw.lan> <5472042.4c1h9diL7E@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There is a concern that if the platform firmware was involved in
the system resume that's being completed,  some devices might have
been reset by it and if those devices had the power.direct_complete
flag set during the preceding suspend transition, they may stay
in a reset-power-on state indefinitely (until they are runtime-resumed
and then suspended again).  That may not be a big deal from the
individual device's perspective, but if the system is an SoC, it may
be prevented from entering deep SoC-wide low-power states on idle
because of that.

The devices that are most likely to be affected by this issue are
PCI devices and ACPI-enumerated devices using the general ACPI PM
domain, so to prevent it from happening for those devices, force a
runtime resume for them if they have their power.direct_complete
flags set and the platform firmware was involved in the resume
transition currently in progress.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: Do it for devices that are most likely to be affected (PCI and the
ACPI PM domain users) rather than for all devices in the system.

---
 drivers/acpi/acpi_lpss.c         |    2 +-
 drivers/acpi/device_pm.c         |   19 +------------------
 drivers/base/power/generic_ops.c |   23 +++++++++++++++++++++++
 drivers/pci/pci-driver.c         |    2 +-
 include/linux/pm.h               |    2 +-
 5 files changed, 27 insertions(+), 21 deletions(-)

Index: linux-pm/drivers/acpi/device_pm.c
===================================================================
--- linux-pm.orig/drivers/acpi/device_pm.c
+++ linux-pm/drivers/acpi/device_pm.c
@@ -963,23 +963,6 @@ int acpi_subsys_prepare(struct device *d
 EXPORT_SYMBOL_GPL(acpi_subsys_prepare);
 
 /**
- * acpi_subsys_complete - Finalize device's resume during system resume.
- * @dev: Device to handle.
- */
-void acpi_subsys_complete(struct device *dev)
-{
-	pm_generic_complete(dev);
-	/*
-	 * If the device had been runtime-suspended before the system went into
-	 * the sleep state it is going out of and it has never been resumed till
-	 * now, resume it in case the firmware powered it up.
-	 */
-	if (dev->power.direct_complete)
-		pm_request_resume(dev);
-}
-EXPORT_SYMBOL_GPL(acpi_subsys_complete);
-
-/**
  * acpi_subsys_suspend - Run the device driver's suspend callback.
  * @dev: Device to handle.
  *
@@ -1047,7 +1030,7 @@ static struct dev_pm_domain acpi_general
 		.runtime_resume = acpi_subsys_runtime_resume,
 #ifdef CONFIG_PM_SLEEP
 		.prepare = acpi_subsys_prepare,
-		.complete = acpi_subsys_complete,
+		.complete = pm_complete_with_resume_check,
 		.suspend = acpi_subsys_suspend,
 		.suspend_late = acpi_subsys_suspend_late,
 		.resume_early = acpi_subsys_resume_early,
Index: linux-pm/drivers/acpi/acpi_lpss.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpi_lpss.c
+++ linux-pm/drivers/acpi/acpi_lpss.c
@@ -664,7 +664,7 @@ static struct dev_pm_domain acpi_lpss_pm
 #ifdef CONFIG_PM
 #ifdef CONFIG_PM_SLEEP
 		.prepare = acpi_subsys_prepare,
-		.complete = acpi_subsys_complete,
+		.complete = pm_complete_with_resume_check,
 		.suspend = acpi_subsys_suspend,
 		.suspend_late = acpi_lpss_suspend_late,
 		.resume_early = acpi_lpss_resume_early,
Index: linux-pm/drivers/base/power/generic_ops.c
===================================================================
--- linux-pm.orig/drivers/base/power/generic_ops.c
+++ linux-pm/drivers/base/power/generic_ops.c
@@ -9,6 +9,7 @@
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <linux/export.h>
+#include <linux/suspend.h>
 
 #ifdef CONFIG_PM
 /**
@@ -297,4 +298,26 @@ void pm_generic_complete(struct device *
 	if (drv && drv->pm && drv->pm->complete)
 		drv->pm->complete(dev);
 }
+
+/**
+ * pm_complete_with_resume_check - Complete a device power transition.
+ * @dev: Device to handle.
+ *
+ * Complete a device power transition during a system-wide power transition and
+ * optionally schedule a runtime resume of the device if the system resume in
+ * progress has been initated by the platform firmware and the device had its
+ * power.direct_complete flag set.
+ */
+void pm_complete_with_resume_check(struct device *dev)
+{
+	pm_generic_complete(dev);
+	/*
+	 * If the device had been runtime-suspended before the system went into
+	 * the sleep state it is going out of and it has never been resumed till
+	 * now, resume it in case the firmware powered it up.
+	 */
+	if (dev->power.direct_complete && pm_resume_via_firmware())
+		pm_request_resume(dev);
+}
+EXPORT_SYMBOL_GPL(pm_complete_with_resume_check);
 #endif /* CONFIG_PM_SLEEP */
Index: linux-pm/drivers/pci/pci-driver.c
===================================================================
--- linux-pm.orig/drivers/pci/pci-driver.c
+++ linux-pm/drivers/pci/pci-driver.c
@@ -687,7 +687,7 @@ static int pci_pm_prepare(struct device
 static void pci_pm_complete(struct device *dev)
 {
 	pci_dev_complete_resume(to_pci_dev(dev));
-	pm_generic_complete(dev);
+	pm_complete_with_resume_check(dev);
 }
 
 #else /* !CONFIG_PM_SLEEP */
Index: linux-pm/include/linux/pm.h
===================================================================
--- linux-pm.orig/include/linux/pm.h
+++ linux-pm/include/linux/pm.h
@@ -731,7 +731,7 @@ extern int pm_generic_restore(struct dev
 extern int pm_generic_poweroff_noirq(struct device *dev);
 extern int pm_generic_poweroff_late(struct device *dev);
 extern int pm_generic_poweroff(struct device *dev);
-extern void pm_generic_complete(struct device *dev);
+extern void pm_complete_with_resume_check(struct device *dev);
 
 #else /* !CONFIG_PM_SLEEP */
 

