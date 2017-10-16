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
Subject: [PATCH 08/12] ACPI / PM: Take SMART_SUSPEND driver flag into account
Date: Mon, 16 Oct 2017 03:30:06 +0200
Message-ID: <27437209.Q3JHjOQKcL@aspire.rjw.lan>
In-Reply-To: <3806130.B2KCK0tvef@aspire.rjw.lan>
References: <3806130.B2KCK0tvef@aspire.rjw.lan>
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

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/device_pm.c |   21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

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
@@ -968,9 +969,6 @@ int acpi_subsys_prepare(struct device *d
 	if (!ret && dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_PREPARE))
 		return 0;
 
-	if (!adev || !pm_runtime_suspended(dev))
-		return 0;
-
 	return !acpi_dev_needs_resume(dev, adev);
 }
 EXPORT_SYMBOL_GPL(acpi_subsys_prepare);
@@ -996,12 +994,17 @@ EXPORT_SYMBOL_GPL(acpi_subsys_complete);
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
@@ -1047,7 +1050,9 @@ int acpi_subsys_freeze(struct device *de
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


