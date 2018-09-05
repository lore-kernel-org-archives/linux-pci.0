Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:45689 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727674AbeIFBIn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Sep 2018 21:08:43 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv2 11/20] PCI/portdrv: Provide pci error callbacks
Date: Wed,  5 Sep 2018 14:35:37 -0600
Message-Id: <20180905203546.21921-12-keith.busch@intel.com>
In-Reply-To: <20180905203546.21921-1-keith.busch@intel.com>
References: <20180905203546.21921-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The error notification walks the whole bus, and some ports may need to
do something to prepare for error handling and recover after slot resets
too. This patch chains the error notification to the port services that
register this callback.

Since the callback is service specific, the patch is also changing the
callback data from the generic 'struct pci_dev' to the service specific
'struct pcie_device'. This is so the service doesn't need to search for
its service specific data, and the callback can always reference the
port if they only wanted the generic pci_dev.

And while we're here, remove the misleading comments referring to AER
root ports in the generic port services driver, as the port may be
involved with other services.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/portdrv.h     | 10 ++++++++--
 drivers/pci/pcie/portdrv_pci.c | 43 ++++++++++++++++++++++++++++++++++++++----
 2 files changed, 47 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index d59afa42fc14..36b6e7fb199f 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -53,10 +53,16 @@ struct pcie_port_service_driver {
 	int (*resume_noirq) (struct pcie_device *dev);
 	int (*resume) (struct pcie_device *dev);
 
+	/* Device driver notification of error handling */
+	void (*error_detected)(struct pcie_device *dev);
+
+	/* Device driver notification of slot reset */
+	void (*slot_reset)(struct pcie_device *dev);
+
 	/* Device driver may resume normal operations */
-	void (*error_resume)(struct pci_dev *dev);
+	void (*error_resume)(struct pcie_device *dev);
 
-	/* Link Reset Capability - AER service driver specific */
+	/* Link Reset Capability - service driver specific */
 	pci_ers_result_t (*reset_link) (struct pci_dev *dev);
 
 	int port_type;  /* Type of the port this driver can handle */
diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index eef22dc29140..93ab8be21a64 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -139,13 +139,49 @@ static void pcie_portdrv_remove(struct pci_dev *dev)
 	pcie_port_device_remove(dev);
 }
 
+static int detected_iter(struct device *device, void *data)
+{
+	struct pcie_device *pcie_device;
+	struct pcie_port_service_driver *driver;
+
+	if (device->bus == &pcie_port_bus_type && device->driver) {
+		driver = to_service_driver(device->driver);
+		if (driver && driver->error_detected) {
+			pcie_device = to_pcie_device(device);
+			driver->error_detected(pcie_device);
+		}
+	}
+	return 0;
+}
+
 static pci_ers_result_t pcie_portdrv_error_detected(struct pci_dev *dev,
 					enum pci_channel_state error)
 {
-	/* Root Port has no impact. Always recovers. */
+	device_for_each_child(&dev->dev, dev, detected_iter);
 	return PCI_ERS_RESULT_CAN_RECOVER;
 }
 
+static int slot_reset_iter(struct device *device, void *data)
+{
+	struct pcie_device *pcie_device;
+	struct pcie_port_service_driver *driver;
+
+	if (device->bus == &pcie_port_bus_type && device->driver) {
+		driver = to_service_driver(device->driver);
+		if (driver && driver->slot_reset) {
+			pcie_device = to_pcie_device(device);
+			driver->slot_reset(pcie_device);
+		}
+	}
+	return 0;
+}
+
+static pci_ers_result_t pcie_portdrv_slot_reset(struct pci_dev *dev)
+{
+	device_for_each_child(&dev->dev, dev, slot_reset_iter);
+	return PCI_ERS_RESULT_RECOVERED;
+}
+
 static pci_ers_result_t pcie_portdrv_mmio_enabled(struct pci_dev *dev)
 {
 	return PCI_ERS_RESULT_RECOVERED;
@@ -160,9 +196,7 @@ static int resume_iter(struct device *device, void *data)
 		driver = to_service_driver(device->driver);
 		if (driver && driver->error_resume) {
 			pcie_device = to_pcie_device(device);
-
-			/* Forward error message to service drivers */
-			driver->error_resume(pcie_device->port);
+			driver->error_resume(pcie_device);
 		}
 	}
 
@@ -185,6 +219,7 @@ static const struct pci_device_id port_pci_ids[] = { {
 
 static const struct pci_error_handlers pcie_portdrv_err_handler = {
 	.error_detected = pcie_portdrv_error_detected,
+	.slot_reset = pcie_portdrv_slot_reset,
 	.mmio_enabled = pcie_portdrv_mmio_enabled,
 	.resume = pcie_portdrv_err_resume,
 };
-- 
2.14.4
