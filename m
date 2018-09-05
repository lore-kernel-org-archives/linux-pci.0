Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:58562 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727645AbeIFBIZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Sep 2018 21:08:25 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv2 10/20] PCI/ERR: Remove devices on recovery failure
Date: Wed,  5 Sep 2018 14:35:36 -0600
Message-Id: <20180905203546.21921-11-keith.busch@intel.com>
In-Reply-To: <20180905203546.21921-1-keith.busch@intel.com>
References: <20180905203546.21921-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch removes devices connected through a bus that can't recover from
an error. After removing everything, one final enumeration from scratch
will be attempted if the bridge and its downstream link appear accessible.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/err.c | 42 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 31e8a4314384..2264001f695b 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -145,6 +145,41 @@ static int report_resume(struct pci_dev *dev, void *data)
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
+/**
+ * pcie_disconnect- Called when error handling ends with
+* 		    PCI_ERS_RESULT_DISCONNECT status.
+ *
+ * Reaching here means error handling has irrevocably failed. This function
+ * will ungracefully disconnect all the devices below the bus that has
+ * experienced the unrecoverable error.
+ *
+ * If the link is active after the removing all devices on the bus, this will
+ * attempt to re-enumerate the bus from scratch.
+ */
+static void pcie_disconnect(struct pci_dev *dev)
+{
+	struct pci_bus *bus = dev->subordinate;
+	struct pci_dev *child, *tmp;
+
+	pci_lock_rescan_remove();
+	list_for_each_entry_safe(child, tmp, &bus->devices, bus_list)
+		pci_stop_and_remove_bus_device(child);
+
+	if (pci_bridge_secondary_bus_reset(dev) == 0 &&
+	    pcie_wait_for_link(dev, true))
+		pci_rescan_bus(bus);
+	pci_unlock_rescan_remove();
+}
+
 /**
  * default_reset_link - default reset function
  * @dev: pointer to pci_dev data structure
@@ -238,10 +273,9 @@ void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
 	pci_cleanup_aer_uncorrect_error_status(dev);
 	pci_info(dev, "AER: Device recovery successful\n");
 	return;
-
 failed:
-	pci_uevent_ers(dev, PCI_ERS_RESULT_DISCONNECT);
-
-	/* TODO: Should kernel panic here? */
 	pci_info(dev, "AER: Device recovery failed\n");
+	pci_dbg(dev, "broadcast disconnect message\n");
+	pci_walk_bus(bus, report_disconnect, &status);
+	pcie_disconnect(dev);
 }
-- 
2.14.4
