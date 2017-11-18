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
Subject: [PATCH v4 3/6] ACPI / PM: Support for LEAVE_SUSPENDED driver flag in ACPI PM domain
Date: Sat, 18 Nov 2017 15:35:00 +0100
Message-ID: <2293854.5TgyDu2xYr@aspire.rjw.lan>
In-Reply-To: <1917233.X2U0QN21my@aspire.rjw.lan>
References: <3806130.B2KCK0tvef@aspire.rjw.lan> <4184911.zoJM7jZeH4@aspire.rjw.lan> <1917233.X2U0QN21my@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add support for DPM_FLAG_LEAVE_SUSPENDED to the ACPI PM domain by
making it (a) set the power.may_skip_resume status bit for devices
that, from its perspective, may be left in suspend after system
wakeup from sleep and (b) return early from acpi_subsys_resume_noirq()
for devices whose remaining resume callbacks during the transition
under way are going to be skipped by the PM core.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

v2 -> v4: No changes.

---
 drivers/acpi/device_pm.c |   27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/acpi/device_pm.c
===================================================================
--- linux-pm.orig/drivers/acpi/device_pm.c
+++ linux-pm/drivers/acpi/device_pm.c
@@ -990,7 +990,7 @@ void acpi_subsys_complete(struct device
 	 * the sleep state it is going out of and it has never been resumed till
 	 * now, resume it in case the firmware powered it up.
 	 */
-	if (dev->power.direct_complete && pm_resume_via_firmware())
+	if (pm_runtime_suspended(dev) && pm_resume_via_firmware())
 		pm_request_resume(dev);
 }
 EXPORT_SYMBOL_GPL(acpi_subsys_complete);
@@ -1039,10 +1039,28 @@ EXPORT_SYMBOL_GPL(acpi_subsys_suspend_la
  */
 int acpi_subsys_suspend_noirq(struct device *dev)
 {
-	if (dev_pm_smart_suspend_and_suspended(dev))
+	int ret;
+
+	if (dev_pm_smart_suspend_and_suspended(dev)) {
+		dev->power.may_skip_resume = true;
 		return 0;
+	}
 
-	return pm_generic_suspend_noirq(dev);
+	ret = pm_generic_suspend_noirq(dev);
+	if (ret)
+		return ret;
+
+	/*
+	 * If the target system sleep state is suspend-to-idle, it is sufficient
+	 * to check whether or not the device's wakeup settings are good for
+	 * runtime PM.  Otherwise, the pm_resume_via_firmware() check will cause
+	 * acpi_subsys_complete() to take care of fixing up the device's state
+	 * anyway, if need be.
+	 */
+	dev->power.may_skip_resume = device_may_wakeup(dev) ||
+					!device_can_wakeup(dev);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(acpi_subsys_suspend_noirq);
 
@@ -1052,6 +1070,9 @@ EXPORT_SYMBOL_GPL(acpi_subsys_suspend_no
  */
 int acpi_subsys_resume_noirq(struct device *dev)
 {
+	if (dev_pm_may_skip_resume(dev))
+		return 0;
+
 	/*
 	 * Devices with DPM_FLAG_SMART_SUSPEND may be left in runtime suspend
 	 * during system suspend, so update their runtime PM status to "active"

