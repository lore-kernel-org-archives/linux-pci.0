Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Joseph Salisbury <joseph.salisbury@canonical.com>,
        bhelgaas@google.com
Cc: linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        1745646@bugs.launchpad.net,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH] PCI / PM: Check device_may_wakeup() in pci_enable_wake()
Date: Wed, 09 May 2018 00:18:32 +0200
Message-ID: <1823373.ea0yBGqyI6@aspire.rjw.lan>
In-Reply-To: <56a8953c-d833-837c-57d5-fe758d4db02a@canonical.com>
References: <56a8953c-d833-837c-57d5-fe758d4db02a@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit 0847684cfc5f0 (PCI / PM: Simplify device wakeup settings code)
went too far and dropped the device_may_wakeup() check from
pci_enable_wake() which causes wakeup to be enabled during system
suspend, hibernation or shutdown for some PCI devices that are not
allowed by user space to wake up the system from sleep (or power off).

As a result of this excessive power is drawn by some of the affected
systems while in sleep states or off.

Restore the device_may_wakeup() check in pci_enable_wake(), but make
sure that the PCI bus type's runtime suspend callback will not call
device_may_wakeup() which is about system wakeup from sleep and not
about device wakeup from runtime suspend.

Fixes: 0847684cfc5f0 (PCI / PM: Simplify device wakeup settings code)
Reported-by: Joseph Salisbury <joseph.salisbury@canonical.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/pci.c |   29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/pci/pci.c
===================================================================
--- linux-pm.orig/drivers/pci/pci.c
+++ linux-pm/drivers/pci/pci.c
@@ -1910,7 +1910,7 @@ void pci_pme_active(struct pci_dev *dev,
 EXPORT_SYMBOL(pci_pme_active);
 
 /**
- * pci_enable_wake - enable PCI device as wakeup event source
+ * __pci_enable_wake - enable PCI device as wakeup event source
  * @dev: PCI device affected
  * @state: PCI state from which device will issue wakeup events
  * @enable: True to enable event generation; false to disable
@@ -1928,7 +1928,7 @@ EXPORT_SYMBOL(pci_pme_active);
  * Error code depending on the platform is returned if both the platform and
  * the native mechanism fail to enable the generation of wake-up events
  */
-int pci_enable_wake(struct pci_dev *dev, pci_power_t state, bool enable)
+static int __pci_enable_wake(struct pci_dev *dev, pci_power_t state, bool enable)
 {
 	int ret = 0;
 
@@ -1969,6 +1969,23 @@ int pci_enable_wake(struct pci_dev *dev,
 
 	return ret;
 }
+
+/**
+ * pci_enable_wake - change wakeup settings for a PCI device
+ * @pci_dev: Target device
+ * @state: PCI state from which device will issue wakeup events
+ * @enable: Whether or not to enable event generation
+ *
+ * If @enable is set, check device_may_wakeup() for the device before calling
+ * __pci_enable_wake() for it.
+ */
+int pci_enable_wake(struct pci_dev *pci_dev, pci_power_t state, bool enable)
+{
+	if (enable && !device_may_wakeup(&pci_dev->dev))
+		return -EINVAL;
+
+	return __pci_enable_wake(pci_dev, state, enable);
+}
 EXPORT_SYMBOL(pci_enable_wake);
 
 /**
@@ -1981,9 +1998,9 @@ EXPORT_SYMBOL(pci_enable_wake);
  * should not be called twice in a row to enable wake-up due to PCI PM vs ACPI
  * ordering constraints.
  *
- * This function only returns error code if the device is not capable of
- * generating PME# from both D3_hot and D3_cold, and the platform is unable to
- * enable wake-up power for it.
+ * This function only returns error code if the device is not allowed to wake
+ * up the system from sleep or it is not capable of generating PME# from both
+ * D3_hot and D3_cold and the platform is unable to enable wake-up power for it.
  */
 int pci_wake_from_d3(struct pci_dev *dev, bool enable)
 {
@@ -2114,7 +2131,7 @@ int pci_finish_runtime_suspend(struct pc
 
 	dev->runtime_d3cold = target_state == PCI_D3cold;
 
-	pci_enable_wake(dev, target_state, pci_dev_run_wake(dev));
+	__pci_enable_wake(dev, target_state, pci_dev_run_wake(dev));
 
 	error = pci_set_power_state(dev, target_state);
 
