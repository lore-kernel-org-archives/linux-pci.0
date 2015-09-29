Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:55529 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752854AbbI2WmF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Sep 2015 18:42:05 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PCI <linux-pci@vger.kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] PCI / PM: Avoid resuming more devices during system suspend
Date: Wed, 30 Sep 2015 01:10:24 +0200
Message-ID: <1927695.BMWSBQyHBQ@vostro.rjw.lan>
In-Reply-To: <1885084.5xWH6KN36q@vostro.rjw.lan>
References: <1885084.5xWH6KN36q@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit bac2a909a096 (PCI / PM: Avoid resuming PCI devices during
system suspend) introduced a mechanism by which some PCI devices that
were runtime-suspended at the system suspend time might be left in
that state for the duration of the system suspend-resume cycle.
However, it overlooked devices that were marked as capable of waking
up the system just because PME support was detected in their PCI
config space.

Namely, in that case, device_can_wakeup(dev) returns 'true' for the
device and if the device is not configured for system wakeup,
device_may_wakeup(dev) returns 'false' and it will be resumed during
system suspend even though configuring it for system wakeup may not
really make sense at all.

To avoid this problem, simply disable PME for PCI devices that have
not been configured for system wakeup and are runtime-suspended at
the system suspend time for the duration of the suspend-resume cycle.

If the device is in D3cold, its config space is not available and it
shouldn't be written to, but that's only possible if the device
has platform PM support and the platform code is responsible for
checking whether or not the device's configuration is suitable for
system suspend in that case.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: pci_dev_run_wake() doesn't need to be called under the spinlock,
so don't do that.

Also this has been (lightly) tested on Acer Aspire S5 and appears to work.

Thanks,
Rafael

---
 drivers/pci/pci-driver.c |   12 ++++++++
 drivers/pci/pci.c        |   70 +++++++++++++++++++++++++++++++++++++++--------
 drivers/pci/pci.h        |    1 
 3 files changed, 72 insertions(+), 11 deletions(-)

Index: linux-pm/drivers/pci/pci.c
===================================================================
--- linux-pm.orig/drivers/pci/pci.c
+++ linux-pm/drivers/pci/pci.c
@@ -1710,15 +1710,7 @@ static void pci_pme_list_scan(struct wor
 	mutex_unlock(&pci_pme_list_mutex);
 }
 
-/**
- * pci_pme_active - enable or disable PCI device's PME# function
- * @dev: PCI device to handle.
- * @enable: 'true' to enable PME# generation; 'false' to disable it.
- *
- * The caller must verify that the device is capable of generating PME# before
- * calling this function with @enable equal to 'true'.
- */
-void pci_pme_active(struct pci_dev *dev, bool enable)
+static void __pci_pme_active(struct pci_dev *dev, bool enable)
 {
 	u16 pmcsr;
 
@@ -1732,6 +1724,19 @@ void pci_pme_active(struct pci_dev *dev,
 		pmcsr &= ~PCI_PM_CTRL_PME_ENABLE;
 
 	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, pmcsr);
+}
+
+/**
+ * pci_pme_active - enable or disable PCI device's PME# function
+ * @dev: PCI device to handle.
+ * @enable: 'true' to enable PME# generation; 'false' to disable it.
+ *
+ * The caller must verify that the device is capable of generating PME# before
+ * calling this function with @enable equal to 'true'.
+ */
+void pci_pme_active(struct pci_dev *dev, bool enable)
+{
+	__pci_pme_active(dev, enable);
 
 	/*
 	 * PCI (as opposed to PCIe) PME requires that the device have
@@ -2032,17 +2037,60 @@ EXPORT_SYMBOL_GPL(pci_dev_run_wake);
  * reconfigured due to wakeup settings difference between system and runtime
  * suspend and the current power state of it is suitable for the upcoming
  * (system) transition.
+ *
+ * If the device is not configured for system wakeup, disable PME for it before
+ * returning 'true' to prevent it from waking up the system unnecessarily.
  */
 bool pci_dev_keep_suspended(struct pci_dev *pci_dev)
 {
 	struct device *dev = &pci_dev->dev;
 
 	if (!pm_runtime_suspended(dev)
-	    || (device_can_wakeup(dev) && !device_may_wakeup(dev))
+	    || pci_target_state(pci_dev) != pci_dev->current_state
 	    || platform_pci_need_resume(pci_dev))
 		return false;
 
-	return pci_target_state(pci_dev) == pci_dev->current_state;
+	/*
+	 * At this point the device is good to go unless it's been configured
+	 * to generate PME at the runtime suspend time, but it is not supposed
+	 * to wake up the system.  In that case, simply disable PME for it
+	 * (it will have to be re-enabled on exit from system resume).
+	 *
+	 * If the device's power state is D3cold and the platform check above
+	 * hasn't triggered, the device's configuration is suitable and we don't
+	 * need to manipulate it at all.
+	 */
+	spin_lock_irq(&dev->power.lock);
+
+	if (pm_runtime_suspended(dev) && pci_dev->current_state < PCI_D3cold &&
+	    !device_may_wakeup(dev))
+		__pci_pme_active(pci_dev, false);
+
+	spin_unlock_irq(&dev->power.lock);
+	return true;
+}
+
+/**
+ * pci_dev_complete_resume - Finalize resume from system sleep for a device.
+ * @pci_dev: Device to handle.
+ *
+ * If the device is runtime suspended and wakeup-capable, enable PME for it as
+ * it might have been disabled during the prepare phase of system suspend if
+ * the device was not configured for system wakeup.
+ */
+void pci_dev_complete_resume(struct pci_dev *pci_dev)
+{
+	struct device *dev = &pci_dev->dev;
+
+	if (!pci_dev_run_wake(pci_dev))
+		return;
+
+	spin_lock_irq(&dev->power.lock);
+
+	if (pm_runtime_suspended(dev) && pci_dev->current_state < PCI_D3cold)
+		__pci_pme_active(pci_dev, true);
+
+	spin_unlock_irq(&dev->power.lock);
 }
 
 void pci_config_pm_runtime_get(struct pci_dev *pdev)
Index: linux-pm/drivers/pci/pci.h
===================================================================
--- linux-pm.orig/drivers/pci/pci.h
+++ linux-pm/drivers/pci/pci.h
@@ -75,6 +75,7 @@ void pci_disable_enabled_device(struct p
 int pci_finish_runtime_suspend(struct pci_dev *dev);
 int __pci_pme_wakeup(struct pci_dev *dev, void *ign);
 bool pci_dev_keep_suspended(struct pci_dev *dev);
+void pci_dev_complete_resume(struct pci_dev *pci_dev);
 void pci_config_pm_runtime_get(struct pci_dev *dev);
 void pci_config_pm_runtime_put(struct pci_dev *dev);
 void pci_pm_init(struct pci_dev *dev);
Index: linux-pm/drivers/pci/pci-driver.c
===================================================================
--- linux-pm.orig/drivers/pci/pci-driver.c
+++ linux-pm/drivers/pci/pci-driver.c
@@ -684,10 +684,21 @@ static int pci_pm_prepare(struct device
 	return pci_dev_keep_suspended(to_pci_dev(dev));
 }
 
+static void pci_pm_complete(struct device *dev)
+{
+	struct device_driver *drv = dev->driver;
+	struct pci_dev *pci_dev = to_pci_dev(dev);
+
+	pci_dev_complete_resume(pci_dev);
+
+	if (drv && drv->pm && drv->pm->complete)
+		drv->pm->complete(dev);
+}
 
 #else /* !CONFIG_PM_SLEEP */
 
 #define pci_pm_prepare	NULL
+#define pci_pm_complete	NULL
 
 #endif /* !CONFIG_PM_SLEEP */
 
@@ -1218,6 +1229,7 @@ static int pci_pm_runtime_idle(struct de
 
 static const struct dev_pm_ops pci_dev_pm_ops = {
 	.prepare = pci_pm_prepare,
+	.complete = pci_pm_complete,
 	.suspend = pci_pm_suspend,
 	.resume = pci_pm_resume,
 	.freeze = pci_pm_freeze,

