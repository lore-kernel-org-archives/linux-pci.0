Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:14083 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727405AbeIABep (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 31 Aug 2018 21:34:45 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 06/16] PCI/ERR: Remove devices on recovery failure
Date: Fri, 31 Aug 2018 15:26:29 -0600
Message-Id: <20180831212639.10196-7-keith.busch@intel.com>
In-Reply-To: <20180831212639.10196-1-keith.busch@intel.com>
References: <20180831212639.10196-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch removes devices connected through a bus that can't recover
from an error.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/err.c | 42 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 44c55f7ceb39..45f574954fd6 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -166,6 +166,15 @@ static int report_resume(struct pci_dev *dev, void *data)
 	return 0;
 }
 
+static int report_disconnect(struct pci_dev *dev, void *data)
+{
+	device_lock(&dev->dev);
+	pci_dev_set_disconnected(dev, NULL);
+	pci_uevent_ers(dev, PCI_ERS_RESULT_DISCONNECT);
+	device_unlock(&dev->dev);
+	return 0;
+}
+
 /**
  * default_reset_link - default reset function
  * @dev: pointer to pci_dev data structure
@@ -271,6 +280,34 @@ static pci_ers_result_t broadcast_error_message(struct pci_dev *dev,
 	return result_data.result;
 }
 
+/**
+ * pcie_disconnect_device - Called when error handling ends with
+ * 			    PCI_ERS_RESULT_DISCONNECT status.
+ *
+ * Reaching here means error handling has irrevocably failed. This function
+ * will ungracefully disconnect all the devices below the bus that has
+ * experienced the unrecoverable error.
+ *
+ * If the link is active after the removing all devices on the bus, this will
+ * attempt to re-enumerate the bus from scratch.
+ */
+static void pcie_disconnect_device(struct pci_dev *dev)
+{
+	struct pci_bus *bus = dev->subordinate;
+	struct pci_dev *child, *tmp;
+
+	broadcast_error_message(dev, PCI_ERS_RESULT_DISCONNECT,
+				"disconnect", report_disconnect);
+	pci_lock_rescan_remove();
+	list_for_each_entry_safe(child, tmp, &bus->devices, bus_list)
+		pci_stop_and_remove_bus_device(child);
+
+	pci_bridge_secondary_bus_reset(dev);
+	if (pcie_wait_for_link(dev, true))
+		pci_rescan_bus(bus);
+	pci_unlock_rescan_remove();
+}
+
 static void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
 			     u32 service)
 {
@@ -313,12 +350,9 @@ static void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
 
 	pci_info(dev, "AER: Device recovery successful\n");
 	return;
-
 failed:
-	pci_uevent_ers(dev, PCI_ERS_RESULT_DISCONNECT);
-
-	/* TODO: Should kernel panic here? */
 	pci_info(dev, "AER: Device recovery failed\n");
+	pcie_disconnect_device(dev);
 }
 
 void pcie_do_fatal_recovery(struct pci_dev *dev, u32 service)
-- 
2.14.4
