Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v1 4/9] PCI/portdrv: Squash device removal code into
 portdrv_pci.c
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Oza Pawandeep <poza@codeaurora.org>, linux-kernel@vger.kernel.org
Date: Fri, 08 Jun 2018 15:12:25 -0500
Message-ID: <152848874571.14051.17371000358965533938.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152848853199.14051.12670957565366345798.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152848853199.14051.12670957565366345798.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Move device removal code next to its caller in portdrv_pci.c.  No
functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/portdrv.h      |    1 -
 drivers/pci/pcie/portdrv_core.c |   21 ---------------------
 drivers/pci/pcie/portdrv_pci.c  |   21 +++++++++++++++++++++
 3 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index cb2a33ea68a5..ab3631a61347 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -79,7 +79,6 @@ void pcie_port_service_unregister(struct pcie_port_service_driver *new);
 #define get_descriptor_id(type, service) (((type - 4) << 8) | service)
 
 extern struct bus_type pcie_port_bus_type;
-void pcie_port_device_remove(struct pci_dev *dev);
 int __must_check pcie_port_bus_register(void);
 void pcie_port_bus_unregister(void);
 
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 9bcc856738ff..2ef046af08d2 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -25,13 +25,6 @@ struct portdrv_service_data {
 	u32 service;
 };
 
-static int remove_iter(struct device *dev, void *data)
-{
-	if (dev->bus == &pcie_port_bus_type)
-		device_unregister(dev);
-	return 0;
-}
-
 static int find_service_iter(struct device *device, void *data)
 {
 	struct pcie_port_service_driver *service_driver;
@@ -95,20 +88,6 @@ struct device *pcie_port_find_device(struct pci_dev *dev,
 	return device;
 }
 
-/**
- * pcie_port_device_remove - unregister PCI Express port service devices
- * @dev: PCI Express port the service devices to unregister are associated with
- *
- * Remove PCI Express port service devices associated with given port and
- * disable MSI-X or MSI for the port.
- */
-void pcie_port_device_remove(struct pci_dev *dev)
-{
-	device_for_each_child(&dev->dev, NULL, remove_iter);
-	pci_free_irq_vectors(dev);
-	pci_disable_device(dev);
-}
-
 /**
  * pcie_port_probe_service - probe driver for given PCI Express port service
  * @dev: PCI Express port service device to probe against
diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index 1b7855a062ff..ab5e3a63981b 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -506,6 +506,27 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
 	return 0;
 }
 
+static int remove_iter(struct device *dev, void *data)
+{
+	if (dev->bus == &pcie_port_bus_type)
+		device_unregister(dev);
+	return 0;
+}
+
+/**
+ * pcie_port_device_remove - unregister PCI Express port service devices
+ * @dev: PCI Express port the service devices to unregister are associated with
+ *
+ * Remove PCI Express port service devices associated with given port and
+ * disable MSI-X or MSI for the port.
+ */
+static void pcie_port_device_remove(struct pci_dev *dev)
+{
+	device_for_each_child(&dev->dev, NULL, remove_iter);
+	pci_free_irq_vectors(dev);
+	pci_disable_device(dev);
+}
+
 static void pcie_portdrv_remove(struct pci_dev *dev)
 {
 	if (pci_bridge_d3_possible(dev)) {
