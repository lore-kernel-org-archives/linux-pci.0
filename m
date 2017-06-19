Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4/6] PCI / PM: Simplify device wakeup settings code
Date: Mon, 19 Jun 2017 23:35:34 +0200
Message-ID: <6082855.gb7lhtNroi@aspire.rjw.lan>
In-Reply-To: <12296383.UdE5HVtyng@aspire.rjw.lan>
References: <12296383.UdE5HVtyng@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After previous changes it is not necessary to distinguish between
device wakeup for run time and device wakeup from system sleep states
any more, so rework the PCI device wakeup settings code accordingly.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/pci-acpi.c   |    3 +--
 drivers/pci/pci-driver.c |    2 +-
 drivers/pci/pci.c        |   36 ++++++++++--------------------------
 drivers/pci/pci.h        |    9 ++-------
 include/linux/pci.h      |    9 +--------
 5 files changed, 15 insertions(+), 44 deletions(-)

Index: linux-pm/drivers/pci/pci-acpi.c
===================================================================
--- linux-pm.orig/drivers/pci/pci-acpi.c
+++ linux-pm/drivers/pci/pci-acpi.c
@@ -616,8 +616,7 @@ static const struct pci_platform_pm_ops
 	.set_state = acpi_pci_set_power_state,
 	.get_state = acpi_pci_get_power_state,
 	.choose_state = acpi_pci_choose_state,
-	.sleep_wake = acpi_pci_wakeup,
-	.run_wake = acpi_pci_wakeup,
+	.set_wakeup = acpi_pci_wakeup,
 	.need_resume = acpi_pci_need_resume,
 };
 
Index: linux-pm/drivers/pci/pci.c
===================================================================
--- linux-pm.orig/drivers/pci/pci.c
+++ linux-pm/drivers/pci/pci.c
@@ -574,8 +574,7 @@ static const struct pci_platform_pm_ops
 int pci_set_platform_pm(const struct pci_platform_pm_ops *ops)
 {
 	if (!ops->is_manageable || !ops->set_state  || !ops->get_state ||
-	    !ops->choose_state  || !ops->sleep_wake || !ops->run_wake  ||
-	    !ops->need_resume)
+	    !ops->choose_state  || !ops->set_wakeup || !ops->need_resume)
 		return -EINVAL;
 	pci_platform_pm = ops;
 	return 0;
@@ -603,16 +602,10 @@ static inline pci_power_t platform_pci_c
 			pci_platform_pm->choose_state(dev) : PCI_POWER_ERROR;
 }
 
-static inline int platform_pci_sleep_wake(struct pci_dev *dev, bool enable)
+static inline int platform_pci_set_wakeup(struct pci_dev *dev, bool enable)
 {
 	return pci_platform_pm ?
-			pci_platform_pm->sleep_wake(dev, enable) : -ENODEV;
-}
-
-static inline int platform_pci_run_wake(struct pci_dev *dev, bool enable)
-{
-	return pci_platform_pm ?
-			pci_platform_pm->run_wake(dev, enable) : -ENODEV;
+			pci_platform_pm->set_wakeup(dev, enable) : -ENODEV;
 }
 
 static inline bool platform_pci_need_resume(struct pci_dev *dev)
@@ -1889,10 +1882,9 @@ void pci_pme_active(struct pci_dev *dev,
 EXPORT_SYMBOL(pci_pme_active);
 
 /**
- * __pci_enable_wake - enable PCI device as wakeup event source
+ * pci_enable_wake - enable PCI device as wakeup event source
  * @dev: PCI device affected
  * @state: PCI state from which device will issue wakeup events
- * @runtime: True if the events are to be generated at run time
  * @enable: True to enable event generation; false to disable
  *
  * This enables the device as a wakeup event source, or disables it.
@@ -1908,14 +1900,10 @@ EXPORT_SYMBOL(pci_pme_active);
  * Error code depending on the platform is returned if both the platform and
  * the native mechanism fail to enable the generation of wake-up events
  */
-int __pci_enable_wake(struct pci_dev *dev, pci_power_t state,
-		      bool runtime, bool enable)
+int pci_enable_wake(struct pci_dev *dev, pci_power_t state, bool enable)
 {
 	int ret = 0;
 
-	if (enable && !runtime && !device_may_wakeup(&dev->dev))
-		return -EINVAL;
-
 	/*
 	 * Don't do the same thing twice in a row for one device, but restore
 	 * PME Enable in case it has been updated by config space restoration.
@@ -1938,24 +1926,20 @@ int __pci_enable_wake(struct pci_dev *de
 			pci_pme_active(dev, true);
 		else
 			ret = 1;
-		error = runtime ? platform_pci_run_wake(dev, true) :
-					platform_pci_sleep_wake(dev, true);
+		error = platform_pci_set_wakeup(dev, true);
 		if (ret)
 			ret = error;
 		if (!ret)
 			dev->wakeup_prepared = true;
 	} else {
-		if (runtime)
-			platform_pci_run_wake(dev, false);
-		else
-			platform_pci_sleep_wake(dev, false);
+		platform_pci_set_wakeup(dev, false);
 		pci_pme_active(dev, false);
 		dev->wakeup_prepared = false;
 	}
 
 	return ret;
 }
-EXPORT_SYMBOL(__pci_enable_wake);
+EXPORT_SYMBOL(pci_enable_wake);
 
 /**
  * pci_wake_from_d3 - enable/disable device to wake up from D3_hot or D3_cold
@@ -2097,12 +2081,12 @@ int pci_finish_runtime_suspend(struct pc
 
 	dev->runtime_d3cold = target_state == PCI_D3cold;
 
-	__pci_enable_wake(dev, target_state, true, pci_dev_run_wake(dev));
+	pci_enable_wake(dev, target_state, pci_dev_run_wake(dev));
 
 	error = pci_set_power_state(dev, target_state);
 
 	if (error) {
-		__pci_enable_wake(dev, target_state, true, false);
+		pci_enable_wake(dev, target_state, false);
 		dev->runtime_d3cold = false;
 	}
 
Index: linux-pm/include/linux/pci.h
===================================================================
--- linux-pm.orig/include/linux/pci.h
+++ linux-pm/include/linux/pci.h
@@ -1097,8 +1097,7 @@ int pci_set_power_state(struct pci_dev *
 pci_power_t pci_choose_state(struct pci_dev *dev, pm_message_t state);
 bool pci_pme_capable(struct pci_dev *dev, pci_power_t state);
 void pci_pme_active(struct pci_dev *dev, bool enable);
-int __pci_enable_wake(struct pci_dev *dev, pci_power_t state,
-		      bool runtime, bool enable);
+int pci_enable_wake(struct pci_dev *dev, pci_power_t state, bool enable);
 int pci_wake_from_d3(struct pci_dev *dev, bool enable);
 int pci_prepare_to_sleep(struct pci_dev *dev);
 int pci_back_from_sleep(struct pci_dev *dev);
@@ -1108,12 +1107,6 @@ void pci_pme_wakeup_bus(struct pci_bus *
 void pci_d3cold_enable(struct pci_dev *dev);
 void pci_d3cold_disable(struct pci_dev *dev);
 
-static inline int pci_enable_wake(struct pci_dev *dev, pci_power_t state,
-				  bool enable)
-{
-	return __pci_enable_wake(dev, state, false, enable);
-}
-
 /* PCI Virtual Channel */
 int pci_save_vc_state(struct pci_dev *dev);
 void pci_restore_vc_state(struct pci_dev *dev);
Index: linux-pm/drivers/pci/pci.h
===================================================================
--- linux-pm.orig/drivers/pci/pci.h
+++ linux-pm/drivers/pci/pci.h
@@ -47,11 +47,7 @@ int pci_probe_reset_function(struct pci_
  *                platform; to be used during system-wide transitions from a
  *                sleeping state to the working state and vice versa
  *
- * @sleep_wake: enables/disables the system wake up capability of given device
- *
- * @run_wake: enables/disables the platform to generate run-time wake-up events
- *		for given device (the device's wake-up capability has to be
- *		enabled by @sleep_wake for this feature to work)
+ * @set_wakeup: enables/disables wakeup capability for the device
  *
  * @need_resume: returns 'true' if the given device (which is currently
  *		suspended) needs to be resumed to be configured for system
@@ -65,8 +61,7 @@ struct pci_platform_pm_ops {
 	int (*set_state)(struct pci_dev *dev, pci_power_t state);
 	pci_power_t (*get_state)(struct pci_dev *dev);
 	pci_power_t (*choose_state)(struct pci_dev *dev);
-	int (*sleep_wake)(struct pci_dev *dev, bool enable);
-	int (*run_wake)(struct pci_dev *dev, bool enable);
+	int (*set_wakeup)(struct pci_dev *dev, bool enable);
 	bool (*need_resume)(struct pci_dev *dev);
 };
 
Index: linux-pm/drivers/pci/pci-driver.c
===================================================================
--- linux-pm.orig/drivers/pci/pci-driver.c
+++ linux-pm/drivers/pci/pci-driver.c
@@ -1216,7 +1216,7 @@ static int pci_pm_runtime_resume(struct
 
 	pci_restore_standard_config(pci_dev);
 	pci_fixup_device(pci_fixup_resume_early, pci_dev);
-	__pci_enable_wake(pci_dev, PCI_D0, true, false);
+	pci_enable_wake(pci_dev, PCI_D0, false);
 	pci_fixup_device(pci_fixup_resume, pci_dev);
 
 	rc = pm->runtime_resume(dev);

