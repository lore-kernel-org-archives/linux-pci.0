Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:14083 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727416AbeIABes (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 31 Aug 2018 21:34:48 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 10/16] PCI/portdrv: Provide pci error callbacks
Date: Fri, 31 Aug 2018 15:26:33 -0600
Message-Id: <20180831212639.10196-11-keith.busch@intel.com>
In-Reply-To: <20180831212639.10196-1-keith.busch@intel.com>
References: <20180831212639.10196-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The error notification walks the whole bus, and some ports may need to
do something to prepare for error handling and recover after slot resets
too. This patch chains the error notification to the port services that
register this callback.

And while we're here, remove the misleading comment referring to AER
root ports in the generic port services driver, as the port may be
involved with other services.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/portdrv.h     |  6 ++++++
 drivers/pci/pcie/portdrv_pci.c | 35 ++++++++++++++++++++++++++++++++++-
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index d59afa42fc14..70b770dd83f1 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -53,6 +53,12 @@ struct pcie_port_service_driver {
 	int (*resume_noirq) (struct pcie_device *dev);
 	int (*resume) (struct pcie_device *dev);
 
+	/* Device driver notification of error handling */
+	void (*error_detected)(struct pci_dev *dev);
+
+	/* Device driver notification of slot reset */
+	void (*slot_reset)(struct pci_dev *dev);
+
 	/* Device driver may resume normal operations */
 	void (*error_resume)(struct pci_dev *dev);
 
diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index eef22dc29140..b1deab941f68 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -139,13 +139,45 @@ static void pcie_portdrv_remove(struct pci_dev *dev)
 	pcie_port_device_remove(dev);
 }
 
+static int detected_iter(struct device *device, void *data)
+{
+	struct pci_dev *pdev = data;
+	struct pcie_port_service_driver *driver;
+
+	if (device->bus == &pcie_port_bus_type && device->driver) {
+		driver = to_service_driver(device->driver);
+		if (driver && driver->error_detected)
+			driver->error_detected(pdev);
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
+	struct pci_dev *pdev = data;
+	struct pcie_port_service_driver *driver;
+
+	if (device->bus == &pcie_port_bus_type && device->driver) {
+		driver = to_service_driver(device->driver);
+		if (driver && driver->slot_reset)
+			driver->slot_reset(pdev);
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
@@ -185,6 +217,7 @@ static const struct pci_device_id port_pci_ids[] = { {
 
 static const struct pci_error_handlers pcie_portdrv_err_handler = {
 	.error_detected = pcie_portdrv_error_detected,
+	.slot_reset = pcie_portdrv_slot_reset,
 	.mmio_enabled = pcie_portdrv_mmio_enabled,
 	.resume = pcie_portdrv_err_resume,
 };
-- 
2.14.4
