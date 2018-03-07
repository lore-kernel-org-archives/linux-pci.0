Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751191AbeCGGNw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Mar 2018 01:13:52 -0500
Subject: [PATCH v1 5/9] PCI/portdrv: Remove pcie_port_bus_type link order
 dependency
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Lukas Wunner <lukas@wunner.de>
Date: Wed, 07 Mar 2018 00:13:51 -0600
Message-ID: <152040323121.240786.5383276983544773869.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152040297576.240786.1532465558381209070.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152040297576.240786.1532465558381209070.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

The pcie_port_bus_type must be registered before drivers that depend on it
can be registered.  Those drivers include:

  pcied_init()                # PCIe native hotplug driver
  aer_service_init()          # AER driver
  dpc_service_init()          # DPC driver
  pcie_pme_service_init()     # PME driver

Previously we registered pcie_port_bus_type from pcie_portdrv_init(), a
device_initcall.  The callers of pcie_port_service_register() (above) are
also device_initcalls.  This is fragile because the device_initcall
ordering depends on link order, which is not explicit.

Register pcie_port_bus_type from pci_driver_init() along with pci_bus_type.
This removes the link order dependency between portdrv and the pciehp, AER,
DPC, and PCIe PME drivers.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci-driver.c       |   45 +++++++++++++++++++++++++++++++-
 drivers/pci/pcie/Makefile      |    2 +
 drivers/pci/pcie/portdrv_bus.c |   56 ----------------------------------------
 drivers/pci/pcie/portdrv_pci.c |   13 +--------
 4 files changed, 46 insertions(+), 70 deletions(-)
 delete mode 100644 drivers/pci/pcie/portdrv_bus.c

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 38ee7c8b4d1a..4db85a0faf34 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/pci.h>
+#include <linux/pcieport_if.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/device.h>
@@ -19,6 +20,7 @@
 #include <linux/suspend.h>
 #include <linux/kexec.h>
 #include "pci.h"
+#include "pcie/portdrv.h"
 
 struct pci_dynid {
 	struct list_head node;
@@ -1553,8 +1555,49 @@ struct bus_type pci_bus_type = {
 };
 EXPORT_SYMBOL(pci_bus_type);
 
+#ifdef CONFIG_PCIEPORTBUS
+static int pcie_port_bus_match(struct device *dev, struct device_driver *drv)
+{
+	struct pcie_device *pciedev;
+	struct pcie_port_service_driver *driver;
+
+	if (drv->bus != &pcie_port_bus_type || dev->bus != &pcie_port_bus_type)
+		return 0;
+
+	pciedev = to_pcie_device(dev);
+	driver = to_service_driver(drv);
+
+	if (driver->service != pciedev->service)
+		return 0;
+
+	if ((driver->port_type != PCIE_ANY_PORT) &&
+	    (driver->port_type != pci_pcie_type(pciedev->port)))
+		return 0;
+
+	return 1;
+}
+
+struct bus_type pcie_port_bus_type = {
+	.name		= "pci_express",
+	.match		= pcie_port_bus_match,
+};
+EXPORT_SYMBOL_GPL(pcie_port_bus_type);
+#endif
+
 static int __init pci_driver_init(void)
 {
-	return bus_register(&pci_bus_type);
+	int ret;
+
+	ret = bus_register(&pci_bus_type);
+	if (ret)
+		return ret;
+
+#ifdef CONFIG_PCIEPORTBUS
+	ret = bus_register(&pcie_port_bus_type);
+	if (ret)
+		return ret;
+#endif
+
+	return 0;
 }
 postcore_initcall(pci_driver_init);
diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
index 223e4c34c29a..e01c10c97b95 100644
--- a/drivers/pci/pcie/Makefile
+++ b/drivers/pci/pcie/Makefile
@@ -6,7 +6,7 @@
 # Build PCI Express ASPM if needed
 obj-$(CONFIG_PCIEASPM)		+= aspm.o
 
-pcieportdrv-y			:= portdrv_core.o portdrv_pci.o portdrv_bus.o
+pcieportdrv-y			:= portdrv_core.o portdrv_pci.o
 pcieportdrv-$(CONFIG_ACPI)	+= portdrv_acpi.o
 
 obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o
diff --git a/drivers/pci/pcie/portdrv_bus.c b/drivers/pci/pcie/portdrv_bus.c
deleted file mode 100644
index f0fba552a0e2..000000000000
--- a/drivers/pci/pcie/portdrv_bus.c
+++ /dev/null
@@ -1,56 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * File:	portdrv_bus.c
- * Purpose:	PCI Express Port Bus Driver's Bus Overloading Functions
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
-
-#include <linux/pcieport_if.h>
-#include "portdrv.h"
-
-static int pcie_port_bus_match(struct device *dev, struct device_driver *drv);
-
-struct bus_type pcie_port_bus_type = {
-	.name		= "pci_express",
-	.match		= pcie_port_bus_match,
-};
-EXPORT_SYMBOL_GPL(pcie_port_bus_type);
-
-static int pcie_port_bus_match(struct device *dev, struct device_driver *drv)
-{
-	struct pcie_device *pciedev;
-	struct pcie_port_service_driver *driver;
-
-	if (drv->bus != &pcie_port_bus_type || dev->bus != &pcie_port_bus_type)
-		return 0;
-
-	pciedev = to_pcie_device(dev);
-	driver = to_service_driver(drv);
-
-	if (driver->service != pciedev->service)
-		return 0;
-
-	if ((driver->port_type != PCIE_ANY_PORT) &&
-	    (driver->port_type != pci_pcie_type(pciedev->port)))
-		return 0;
-
-	return 1;
-}
-
-int pcie_port_bus_register(void)
-{
-	return bus_register(&pcie_port_bus_type);
-}
-
-void pcie_port_bus_unregister(void)
-{
-	bus_unregister(&pcie_port_bus_type);
-}
diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index c08ebd237242..9475886eeb62 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -259,22 +259,11 @@ static const struct dmi_system_id pcie_portdrv_dmi_table[] __initconst = {
 
 static int __init pcie_portdrv_init(void)
 {
-	int retval;
-
 	if (pcie_ports_disabled)
 		return -EACCES;
 
 	dmi_check_system(pcie_portdrv_dmi_table);
 
-	retval = pcie_port_bus_register();
-	if (retval) {
-		printk(KERN_WARNING "PCIE: bus_register error: %d\n", retval);
-		goto out;
-	}
-	retval = pci_register_driver(&pcie_portdriver);
-	if (retval)
-		pcie_port_bus_unregister();
- out:
-	return retval;
+	return pci_register_driver(&pcie_portdriver);
 }
 device_initcall(pcie_portdrv_init);
