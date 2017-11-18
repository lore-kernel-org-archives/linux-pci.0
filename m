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
Subject: [PATCH v4 2/6] PCI / PM: Support for LEAVE_SUSPENDED driver flag
Date: Sat, 18 Nov 2017 15:33:52 +0100
Message-ID: <3189584.p93WhT6c0L@aspire.rjw.lan>
In-Reply-To: <1917233.X2U0QN21my@aspire.rjw.lan>
References: <3806130.B2KCK0tvef@aspire.rjw.lan> <4184911.zoJM7jZeH4@aspire.rjw.lan> <1917233.X2U0QN21my@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add support for DPM_FLAG_LEAVE_SUSPENDED to the PCI bus type by
making it (a) set the power.may_skip_resume status bit for devices
that, from its perspective, may be left in suspend after system
wakeup from sleep and (b) return early from pci_pm_resume_noirq()
for devices whose remaining resume callbacks during the transition
under way are going to be skipped by the PM core.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---

v3 -> v4: No changes.

v2 -> v3: Add the Acked-by from Bjorn, no changes in the patch.

---
 Documentation/power/pci.txt |   11 +++++++++++
 drivers/pci/pci-driver.c    |   19 +++++++++++++++++--
 2 files changed, 28 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/pci/pci-driver.c
===================================================================
--- linux-pm.orig/drivers/pci/pci-driver.c
+++ linux-pm/drivers/pci/pci-driver.c
@@ -699,7 +699,7 @@ static void pci_pm_complete(struct devic
 	pm_generic_complete(dev);
 
 	/* Resume device if platform firmware has put it in reset-power-on */
-	if (dev->power.direct_complete && pm_resume_via_firmware()) {
+	if (pm_runtime_suspended(dev) && pm_resume_via_firmware()) {
 		pci_power_t pre_sleep_state = pci_dev->current_state;
 
 		pci_update_current_state(pci_dev, pci_dev->current_state);
@@ -783,8 +783,10 @@ static int pci_pm_suspend_noirq(struct d
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
 
-	if (dev_pm_smart_suspend_and_suspended(dev))
+	if (dev_pm_smart_suspend_and_suspended(dev)) {
+		dev->power.may_skip_resume = true;
 		return 0;
+	}
 
 	if (pci_has_legacy_pm_support(pci_dev))
 		return pci_legacy_suspend_late(dev, PMSG_SUSPEND);
@@ -838,6 +840,16 @@ static int pci_pm_suspend_noirq(struct d
 Fixup:
 	pci_fixup_device(pci_fixup_suspend_late, pci_dev);
 
+	/*
+	 * If the target system sleep state is suspend-to-idle, it is sufficient
+	 * to check whether or not the device's wakeup settings are good for
+	 * runtime PM.  Otherwise, the pm_resume_via_firmware() check will cause
+	 * pci_pm_complete() to take care of fixing up the device's state
+	 * anyway, if need be.
+	 */
+	dev->power.may_skip_resume = device_may_wakeup(dev) ||
+					!device_can_wakeup(dev);
+
 	return 0;
 }
 
@@ -847,6 +859,9 @@ static int pci_pm_resume_noirq(struct de
 	struct device_driver *drv = dev->driver;
 	int error = 0;
 
+	if (dev_pm_may_skip_resume(dev))
+		return 0;
+
 	/*
 	 * Devices with DPM_FLAG_SMART_SUSPEND may be left in runtime suspend
 	 * during system suspend, so update their runtime PM status to "active"
Index: linux-pm/Documentation/power/pci.txt
===================================================================
--- linux-pm.orig/Documentation/power/pci.txt
+++ linux-pm/Documentation/power/pci.txt
@@ -994,6 +994,17 @@ into D0 going forward), but if it is in
 the function will set the power.direct_complete flag for it (to make the PM core
 skip the subsequent "thaw" callbacks for it) and return.
 
+Setting the DPM_FLAG_LEAVE_SUSPENDED flag means that the driver prefers the
+device to be left in suspend after system-wide transitions to the working state.
+This flag is checked by the PM core, but the PCI bus type informs the PM core
+which devices may be left in suspend from its perspective (that happens during
+the "noirq" phase of system-wide suspend and analogous transitions) and next it
+uses the dev_pm_may_skip_resume() helper to decide whether or not to return from
+pci_pm_resume_noirq() early, as the PM core will skip the remaining resume
+callbacks for the device during the transition under way and will set its
+runtime PM status to "suspended" if dev_pm_may_skip_resume() returns "true" for
+it.
+
 3.2. Device Runtime Power Management
 ------------------------------------
 In addition to providing device power management callbacks PCI device drivers

