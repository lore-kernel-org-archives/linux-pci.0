Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v1 6/9] PCI/portdrv: Squash service driver registration into
 portdrv_pci.c
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Oza Pawandeep <poza@codeaurora.org>, linux-kernel@vger.kernel.org
Date: Fri, 08 Jun 2018 15:12:38 -0500
Message-ID: <152848875803.14051.11862886995562549992.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152848853199.14051.12670957565366345798.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152848853199.14051.12670957565366345798.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Squash service driver registration into portdrv_pci.c.  No functional
change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/Makefile       |    2 -
 drivers/pci/pcie/portdrv_core.c |  116 ---------------------------------------
 drivers/pci/pcie/portdrv_pci.c  |   96 ++++++++++++++++++++++++++++++++
 3 files changed, 97 insertions(+), 117 deletions(-)
 delete mode 100644 drivers/pci/pcie/portdrv_core.c

diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
index 03f4e0b3a140..aad431790b1d 100644
--- a/drivers/pci/pcie/Makefile
+++ b/drivers/pci/pcie/Makefile
@@ -2,7 +2,7 @@
 #
 # Makefile for PCI Express features and port driver
 
-pcieportdrv-y			:= portdrv_core.o portdrv_pci.o err.o
+pcieportdrv-y			:= portdrv_pci.o err.o
 
 obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o
 
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
deleted file mode 100644
index 77b1c1ea8885..000000000000
--- a/drivers/pci/pcie/portdrv_core.c
+++ /dev/null
@@ -1,116 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Purpose:	PCI Express Port Bus Driver's Core Functions
- *
- * Copyright (C) 2004 Intel
- * Copyright (C) Tom Long Nguyen (tom.l.nguyen@intel.com)
- */
-
-#include <linux/module.h>
-#include <linux/pci.h>
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/pm.h>
-#include <linux/pm_runtime.h>
-#include <linux/string.h>
-#include <linux/slab.h>
-#include <linux/aer.h>
-
-#include "../pci.h"
-#include "portdrv.h"
-
-/**
- * pcie_port_probe_service - probe driver for given PCI Express port service
- * @dev: PCI Express port service device to probe against
- *
- * If PCI Express port service driver is registered with
- * pcie_port_service_register(), this function will be called by the driver core
- * whenever match is found between the driver and a port service device.
- */
-static int pcie_port_probe_service(struct device *dev)
-{
-	struct pcie_device *pciedev;
-	struct pcie_port_service_driver *driver;
-	int status;
-
-	if (!dev || !dev->driver)
-		return -ENODEV;
-
-	driver = to_service_driver(dev->driver);
-	if (!driver || !driver->probe)
-		return -ENODEV;
-
-	pciedev = to_pcie_device(dev);
-	status = driver->probe(pciedev);
-	if (status)
-		return status;
-
-	get_device(dev);
-	return 0;
-}
-
-/**
- * pcie_port_remove_service - detach driver from given PCI Express port service
- * @dev: PCI Express port service device to handle
- *
- * If PCI Express port service driver is registered with
- * pcie_port_service_register(), this function will be called by the driver core
- * when device_unregister() is called for the port service device associated
- * with the driver.
- */
-static int pcie_port_remove_service(struct device *dev)
-{
-	struct pcie_device *pciedev;
-	struct pcie_port_service_driver *driver;
-
-	if (!dev || !dev->driver)
-		return 0;
-
-	pciedev = to_pcie_device(dev);
-	driver = to_service_driver(dev->driver);
-	if (driver && driver->remove) {
-		driver->remove(pciedev);
-		put_device(dev);
-	}
-	return 0;
-}
-
-/**
- * pcie_port_shutdown_service - shut down given PCI Express port service
- * @dev: PCI Express port service device to handle
- *
- * If PCI Express port service driver is registered with
- * pcie_port_service_register(), this function will be called by the driver core
- * when device_shutdown() is called for the port service device associated
- * with the driver.
- */
-static void pcie_port_shutdown_service(struct device *dev) {}
-
-/**
- * pcie_port_service_register - register PCI Express port service driver
- * @new: PCI Express port service driver to register
- */
-int pcie_port_service_register(struct pcie_port_service_driver *new)
-{
-	if (pcie_ports_disabled)
-		return -ENODEV;
-
-	new->driver.name = new->name;
-	new->driver.bus = &pcie_port_bus_type;
-	new->driver.probe = pcie_port_probe_service;
-	new->driver.remove = pcie_port_remove_service;
-	new->driver.shutdown = pcie_port_shutdown_service;
-
-	return driver_register(&new->driver);
-}
-EXPORT_SYMBOL(pcie_port_service_register);
-
-/**
- * pcie_port_service_unregister - unregister PCI Express port service driver
- * @drv: PCI Express port service driver to unregister
- */
-void pcie_port_service_unregister(struct pcie_port_service_driver *drv)
-{
-	driver_unregister(&drv->driver);
-}
-EXPORT_SYMBOL(pcie_port_service_unregister);
diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index b019af97f14e..1375e91c268f 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -110,6 +110,102 @@ struct device *pcie_port_find_device(struct pci_dev *dev, u32 service)
 	return device;
 }
 
+/**
+ * pcie_port_probe_service - probe driver for given PCI Express port service
+ * @dev: PCI Express port service device to probe against
+ *
+ * If PCI Express port service driver is registered with
+ * pcie_port_service_register(), this function will be called by the driver core
+ * whenever match is found between the driver and a port service device.
+ */
+static int pcie_port_probe_service(struct device *dev)
+{
+	struct pcie_device *pciedev;
+	struct pcie_port_service_driver *driver;
+	int status;
+
+	if (!dev || !dev->driver)
+		return -ENODEV;
+
+	driver = to_service_driver(dev->driver);
+	if (!driver || !driver->probe)
+		return -ENODEV;
+
+	pciedev = to_pcie_device(dev);
+	status = driver->probe(pciedev);
+	if (status)
+		return status;
+
+	get_device(dev);
+	return 0;
+}
+
+/**
+ * pcie_port_remove_service - detach driver from given PCI Express port service
+ * @dev: PCI Express port service device to handle
+ *
+ * If PCI Express port service driver is registered with
+ * pcie_port_service_register(), this function will be called by the driver core
+ * when device_unregister() is called for the port service device associated
+ * with the driver.
+ */
+static int pcie_port_remove_service(struct device *dev)
+{
+	struct pcie_device *pciedev;
+	struct pcie_port_service_driver *driver;
+
+	if (!dev || !dev->driver)
+		return 0;
+
+	pciedev = to_pcie_device(dev);
+	driver = to_service_driver(dev->driver);
+	if (driver && driver->remove) {
+		driver->remove(pciedev);
+		put_device(dev);
+	}
+	return 0;
+}
+
+/**
+ * pcie_port_shutdown_service - shut down given PCI Express port service
+ * @dev: PCI Express port service device to handle
+ *
+ * If PCI Express port service driver is registered with
+ * pcie_port_service_register(), this function will be called by the driver core
+ * when device_shutdown() is called for the port service device associated
+ * with the driver.
+ */
+static void pcie_port_shutdown_service(struct device *dev) {}
+
+/**
+ * pcie_port_service_register - register PCI Express port service driver
+ * @new: PCI Express port service driver to register
+ */
+int pcie_port_service_register(struct pcie_port_service_driver *new)
+{
+	if (pcie_ports_disabled)
+		return -ENODEV;
+
+	new->driver.name = new->name;
+	new->driver.bus = &pcie_port_bus_type;
+	new->driver.probe = pcie_port_probe_service;
+	new->driver.remove = pcie_port_remove_service;
+	new->driver.shutdown = pcie_port_shutdown_service;
+
+	return driver_register(&new->driver);
+}
+EXPORT_SYMBOL(pcie_port_service_register);
+
+/**
+ * pcie_port_service_unregister - unregister PCI Express port service driver
+ * @drv: PCI Express port service driver to unregister
+ */
+void pcie_port_service_unregister(struct pcie_port_service_driver *drv)
+{
+	driver_unregister(&drv->driver);
+}
+EXPORT_SYMBOL(pcie_port_service_unregister);
+
 static int pcie_portdrv_restore_config(struct pci_dev *dev)
 {
 	int retval;
