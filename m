Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:54075 "EHLO
	mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566AbcEMLQe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 13 May 2016 07:16:34 -0400
Message-Id: <fe6b28525ac234cb580e3de1897511e21b6b78af.1463134231.git.lukas@wunner.de>
In-Reply-To: <cover.1463134231.git.lukas@wunner.de>
References: <cover.1463134231.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Fri, 13 May 2016 13:15:31 +0200
Subject: [PATCH v2 04/13] PCI: Generalize portdrv pm iterator
To: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Andreas Noever <andreas.noever@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Move ->suspend and ->resume callbacks from portdrv_core.c to
portdrv_pci.c (where ->resume_noirq, ->runtime_suspend, ->runtime_resume
and ->runtime_idle already are), allowing us to drop their prototypes
from portdrv.h.

Replace suspend_iter() and resume_iter() with a single function
generic_iter() with the intention of using it in further pm callbacks.

Rename pcie_port_device_(suspend|resume) to pcie_port_(suspend|resume)
to be consistent with the existing pm callbacks.

Replace the somewhat terse kerneldoc for pcie_port_(suspend|resume) with
a generic documentation which applies to all pm callbacks.

No functional change intended.

(Okay there *is* one functional change, generic_iter() returns the
result of the service driver's callback whereas suspend_iter() and
resume_iter() always returned 0.  That was a bug since we never
propagated errors that occurred in the service driver callbacks back to
the pm core.  The bug never manifested itself because PME's and
Hotplug's pm callbacks always return 0, AER doesn't declare pm callbacks
and VC has no service driver.  So there's no *behavioral* change right
now.)

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/pcie/portdrv.h      |  4 ----
 drivers/pci/pcie/portdrv_core.c | 45 -------------------------------------
 drivers/pci/pcie/portdrv_pci.c  | 49 ++++++++++++++++++++++++++++++++++++-----
 3 files changed, 43 insertions(+), 55 deletions(-)

diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index a0d9973..9f21926 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -22,10 +22,6 @@
 
 extern struct bus_type pcie_port_bus_type;
 int pcie_port_device_register(struct pci_dev *dev);
-#ifdef CONFIG_PM
-int pcie_port_device_suspend(struct device *dev);
-int pcie_port_device_resume(struct device *dev);
-#endif
 void pcie_port_device_remove(struct pci_dev *dev);
 int __must_check pcie_port_bus_register(void);
 void pcie_port_bus_unregister(void);
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 8cd9db8..3621f96 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -414,51 +414,6 @@ error_disable:
 	return status;
 }
 
-#ifdef CONFIG_PM
-static int suspend_iter(struct device *dev, void *data)
-{
-	struct pcie_port_service_driver *service_driver;
-
-	if ((dev->bus == &pcie_port_bus_type) && dev->driver) {
-		service_driver = to_service_driver(dev->driver);
-		if (service_driver->suspend)
-			service_driver->suspend(to_pcie_device(dev));
-	}
-	return 0;
-}
-
-/**
- * pcie_port_device_suspend - suspend port services associated with a PCIe port
- * @dev: PCI Express port to handle
- */
-int pcie_port_device_suspend(struct device *dev)
-{
-	return device_for_each_child(dev, NULL, suspend_iter);
-}
-
-static int resume_iter(struct device *dev, void *data)
-{
-	struct pcie_port_service_driver *service_driver;
-
-	if ((dev->bus == &pcie_port_bus_type) &&
-	    (dev->driver)) {
-		service_driver = to_service_driver(dev->driver);
-		if (service_driver->resume)
-			service_driver->resume(to_pcie_device(dev));
-	}
-	return 0;
-}
-
-/**
- * pcie_port_device_resume - resume port services associated with a PCIe port
- * @dev: PCI Express port to handle
- */
-int pcie_port_device_resume(struct device *dev)
-{
-	return device_for_each_child(dev, NULL, resume_iter);
-}
-#endif /* PM */
-
 static int remove_iter(struct device *dev, void *data)
 {
 	if (dev->bus == &pcie_port_bus_type)
diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index cd41360..acbd1d2 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -79,6 +79,43 @@ static int pcie_portdrv_restore_config(struct pci_dev *dev)
 }
 
 #ifdef CONFIG_PM
+typedef int (*pcie_pm_callback_t)(struct pcie_device *);
+
+static int generic_iter(struct device *dev, void *data)
+{
+	struct pcie_port_service_driver *service_driver;
+	size_t offset = *(size_t *)data;
+	pcie_pm_callback_t cb;
+
+	if ((dev->bus == &pcie_port_bus_type) && dev->driver) {
+		service_driver = to_service_driver(dev->driver);
+		cb = *(pcie_pm_callback_t *)((void *)service_driver + offset);
+		if (cb)
+			return cb(to_pcie_device(dev));
+	}
+	return 0;
+}
+
+/*
+ * The PM callbacks iterate over the port services allocated for the PCIe port
+ * and call down to each of them. Execution is aborted as soon as one of them
+ * returns a non-zero value.
+ *
+ * The return value is 0 if all port services' callbacks returned 0, otherwise
+ * it is the return value of the last callback executed.
+ */
+static int pcie_port_suspend(struct device *dev)
+{
+	size_t o = offsetof(struct pcie_port_service_driver, suspend);
+	return device_for_each_child(dev, &o, generic_iter);
+}
+
+static int pcie_port_resume(struct device *dev)
+{
+	size_t o = offsetof(struct pcie_port_service_driver, resume);
+	return device_for_each_child(dev, &o, generic_iter);
+}
+
 static int pcie_port_resume_noirq(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
@@ -114,12 +151,12 @@ static int pcie_port_runtime_idle(struct device *dev)
 }
 
 static const struct dev_pm_ops pcie_portdrv_pm_ops = {
-	.suspend	= pcie_port_device_suspend,
-	.resume		= pcie_port_device_resume,
-	.freeze		= pcie_port_device_suspend,
-	.thaw		= pcie_port_device_resume,
-	.poweroff	= pcie_port_device_suspend,
-	.restore	= pcie_port_device_resume,
+	.suspend	= pcie_port_suspend,
+	.resume		= pcie_port_resume,
+	.freeze		= pcie_port_suspend,
+	.thaw		= pcie_port_resume,
+	.poweroff	= pcie_port_suspend,
+	.restore	= pcie_port_resume,
 	.resume_noirq	= pcie_port_resume_noirq,
 	.runtime_suspend = pcie_port_runtime_suspend,
 	.runtime_resume	= pcie_port_runtime_resume,
-- 
2.8.1

