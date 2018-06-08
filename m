Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753115AbeFHUMd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Jun 2018 16:12:33 -0400
Subject: [PATCH v1 5/9] PCI/portdrv: Squash lookup interfaces into
 portdrv_pci.c
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Oza Pawandeep <poza@codeaurora.org>, linux-kernel@vger.kernel.org
Date: Fri, 08 Jun 2018 15:12:31 -0500
Message-ID: <152848875188.14051.2166609505666979991.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152848853199.14051.12670957565366345798.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152848853199.14051.12670957565366345798.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Squash lookup interfaces into portdrv_pci.c.  No functional change
intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/portdrv_core.c |   69 ---------------------------------------
 drivers/pci/pcie/portdrv_pci.c  |   68 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+), 69 deletions(-)

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 2ef046af08d2..77b1c1ea8885 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -19,75 +19,6 @@
 #include "../pci.h"
 #include "portdrv.h"
 
-struct portdrv_service_data {
-	struct pcie_port_service_driver *drv;
-	struct device *dev;
-	u32 service;
-};
-
-static int find_service_iter(struct device *device, void *data)
-{
-	struct pcie_port_service_driver *service_driver;
-	struct portdrv_service_data *pdrvs;
-	u32 service;
-
-	pdrvs = (struct portdrv_service_data *) data;
-	service = pdrvs->service;
-
-	if (device->bus == &pcie_port_bus_type && device->driver) {
-		service_driver = to_service_driver(device->driver);
-		if (service_driver->service == service) {
-			pdrvs->drv = service_driver;
-			pdrvs->dev = device;
-			return 1;
-		}
-	}
-
-	return 0;
-}
-
-/**
- * pcie_port_find_service - find the service driver
- * @dev: PCI Express port the service is associated with
- * @service: Service to find
- *
- * Find PCI Express port service driver associated with given service
- */
-struct pcie_port_service_driver *pcie_port_find_service(struct pci_dev *dev,
-							u32 service)
-{
-	struct pcie_port_service_driver *drv;
-	struct portdrv_service_data pdrvs;
-
-	pdrvs.drv = NULL;
-	pdrvs.service = service;
-	device_for_each_child(&dev->dev, &pdrvs, find_service_iter);
-
-	drv = pdrvs.drv;
-	return drv;
-}
-
-/**
- * pcie_port_find_device - find the struct device
- * @dev: PCI Express port the service is associated with
- * @service: For the service to find
- *
- * Find the struct device associated with given service on a pci_dev
- */
-struct device *pcie_port_find_device(struct pci_dev *dev,
-				      u32 service)
-{
-	struct device *device;
-	struct portdrv_service_data pdrvs;
-
-	pdrvs.dev = NULL;
-	pdrvs.service = service;
-	device_for_each_child(&dev->dev, &pdrvs, find_service_iter);
-
-	device = pdrvs.dev;
-	return device;
-}
-
 /**
  * pcie_port_probe_service - probe driver for given PCI Express port service
  * @dev: PCI Express port service device to probe against
diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index ab5e3a63981b..b019af97f14e 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -42,6 +42,74 @@ __setup("pcie_ports=", pcie_port_setup);
 
 /* global data */
 
+struct portdrv_service_data {
+	struct pcie_port_service_driver *drv;
+	struct device *dev;
+	u32 service;
+};
+
+static int find_service_iter(struct device *device, void *data)
+{
+	struct pcie_port_service_driver *service_driver;
+	struct portdrv_service_data *pdrvs;
+	u32 service;
+
+	pdrvs = (struct portdrv_service_data *) data;
+	service = pdrvs->service;
+
+	if (device->bus == &pcie_port_bus_type && device->driver) {
+		service_driver = to_service_driver(device->driver);
+		if (service_driver->service == service) {
+			pdrvs->drv = service_driver;
+			pdrvs->dev = device;
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * pcie_port_find_service - find the service driver
+ * @dev: PCI Express port the service is associated with
+ * @service: Service to find
+ *
+ * Find PCI Express port service driver associated with given service
+ */
+struct pcie_port_service_driver *pcie_port_find_service(struct pci_dev *dev,
+							u32 service)
+{
+	struct pcie_port_service_driver *drv;
+	struct portdrv_service_data pdrvs;
+
+	pdrvs.drv = NULL;
+	pdrvs.service = service;
+	device_for_each_child(&dev->dev, &pdrvs, find_service_iter);
+
+	drv = pdrvs.drv;
+	return drv;
+}
+
+/**
+ * pcie_port_find_device - find the struct device
+ * @dev: PCI Express port the service is associated with
+ * @service: For the service to find
+ *
+ * Find the struct device associated with given service on a pci_dev
+ */
+struct device *pcie_port_find_device(struct pci_dev *dev, u32 service)
+{
+	struct device *device;
+	struct portdrv_service_data pdrvs;
+
+	pdrvs.dev = NULL;
+	pdrvs.service = service;
+	device_for_each_child(&dev->dev, &pdrvs, find_service_iter);
+
+	device = pdrvs.dev;
+	return device;
+}
+
 static int pcie_portdrv_restore_config(struct pci_dev *dev)
 {
 	int retval;
