Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753006AbeFHUMV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Jun 2018 16:12:21 -0400
Subject: [PATCH v1 3/9] PCI/portdrv: Squash PM-related code into
 portdrv_pci.c
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Oza Pawandeep <poza@codeaurora.org>, linux-kernel@vger.kernel.org
Date: Fri, 08 Jun 2018 15:12:19 -0500
Message-ID: <152848873956.14051.11535152653562634346.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152848853199.14051.12670957565366345798.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152848853199.14051.12670957565366345798.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

pcie_port_device_suspend() and pcie_port_device_resume() were defined in
portdrv_core.c and only used in portdrv_pci.c.  Move them there and make
them static.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/portdrv.h      |    4 ---
 drivers/pci/pcie/portdrv_core.c |   45 ---------------------------------------
 drivers/pci/pcie/portdrv_pci.c  |   43 +++++++++++++++++++++++++++++++++++++
 3 files changed, 43 insertions(+), 49 deletions(-)

diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index 7a2e5f0dfb53..cb2a33ea68a5 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -79,10 +79,6 @@ void pcie_port_service_unregister(struct pcie_port_service_driver *new);
 #define get_descriptor_id(type, service) (((type - 4) << 8) | service)
 
 extern struct bus_type pcie_port_bus_type;
-#ifdef CONFIG_PM
-int pcie_port_device_suspend(struct device *dev);
-int pcie_port_device_resume(struct device *dev);
-#endif
 void pcie_port_device_remove(struct pci_dev *dev);
 int __must_check pcie_port_bus_register(void);
 void pcie_port_bus_unregister(void);
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 747a58d6aaf4..9bcc856738ff 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -25,51 +25,6 @@ struct portdrv_service_data {
 	u32 service;
 };
 
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
index 08c605734d98..1b7855a062ff 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -54,6 +54,49 @@ static int pcie_portdrv_restore_config(struct pci_dev *dev)
 }
 
 #ifdef CONFIG_PM
+static int suspend_iter(struct device *dev, void *data)
+{
+	struct pcie_port_service_driver *service_driver;
+
+	if ((dev->bus == &pcie_port_bus_type) && dev->driver) {
+		service_driver = to_service_driver(dev->driver);
+		if (service_driver->suspend)
+			service_driver->suspend(to_pcie_device(dev));
+	}
+	return 0;
+}
+
+/**
+ * pcie_port_device_suspend - suspend port services associated with a PCIe port
+ * @dev: PCI Express port to handle
+ */
+static int pcie_port_device_suspend(struct device *dev)
+{
+	return device_for_each_child(dev, NULL, suspend_iter);
+}
+
+static int resume_iter(struct device *dev, void *data)
+{
+	struct pcie_port_service_driver *service_driver;
+
+	if ((dev->bus == &pcie_port_bus_type) &&
+	    (dev->driver)) {
+		service_driver = to_service_driver(dev->driver);
+		if (service_driver->resume)
+			service_driver->resume(to_pcie_device(dev));
+	}
+	return 0;
+}
+
+/**
+ * pcie_port_device_resume - resume port services associated with a PCIe port
+ * @dev: PCI Express port to handle
+ */
+static int pcie_port_device_resume(struct device *dev)
+{
+	return device_for_each_child(dev, NULL, resume_iter);
+}
+
 static int pcie_port_runtime_suspend(struct device *dev)
 {
 	return to_pci_dev(dev)->bridge_d3 ? 0 : -EBUSY;
