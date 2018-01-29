Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:65219 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751855AbeA2V2G (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Jan 2018 16:28:06 -0500
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Cc: Keith Busch <keith.busch@intel.com>
Subject: [PATCH 4/6] PCI/DPC: Cleanup declarations
Date: Mon, 29 Jan 2018 14:31:43 -0700
Message-Id: <20180129213145.26068-4-keith.busch@intel.com>
In-Reply-To: <20180129213145.26068-1-keith.busch@intel.com>
References: <20180129213145.26068-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Combining declarations of the same type and removing function forward
declaration. No functional change.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/pcie-dpc.c | 116 +++++++++++++++++++++-----------------------
 1 file changed, 55 insertions(+), 61 deletions(-)

diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
index f0f5f5ba71ff..8c28840b6b91 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -44,8 +44,6 @@ static const char * const rp_pio_error_string[] = {
 	"Memory Request Completion Timeout",		 /* Bit Position 18 */
 };
 
-static u32 dpc_process_rp_pio_error(struct dpc_dev *dpc);
-
 static int dpc_wait_rp_inactive(struct dpc_dev *dpc)
 {
 	unsigned long timeout = jiffies + HZ;
@@ -83,70 +81,14 @@ static void dpc_wait_link_inactive(struct dpc_dev *dpc)
 		dev_warn(dev, "Link state not disabled for DPC event\n");
 }
 
-static void dpc_work(struct work_struct *work)
-{
-	struct dpc_dev *dpc = container_of(work, struct dpc_dev, work);
-	struct pci_dev *dev, *temp, *pdev = dpc->dev->port;
-	struct pci_bus *parent = pdev->subordinate;
-	u16 cap = dpc->cap_pos, status, source, reason, ext_reason;
-	u32 pio_status = 0;
-
-	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
-	pci_read_config_word(pdev, cap + PCI_EXP_DPC_SOURCE_ID, &source);
-
-	dev_info(&pdev->dev, "DPC containment event, status:%#06x source:%#06x\n",
-		status, source);
-
-	reason = (status & PCI_EXP_DPC_STATUS_TRIGGER_RSN) >> 1;
-	ext_reason = (status & PCI_EXP_DPC_STATUS_TRIGGER_RSN_EXT) >> 5;
-
-	dev_warn(&pdev->dev, "DPC %s detected, remove downstream devices\n",
-		 (reason == 0) ? "unmasked uncorrectable error" :
-		 (reason == 1) ? "ERR_NONFATAL" :
-		 (reason == 2) ? "ERR_FATAL" :
-		 (ext_reason == 0) ? "RP PIO error" :
-		 (ext_reason == 1) ? "software trigger" :
-				     "reserved error");
-
-	if (dpc->rp_extensions && reason == 3 && ext_reason == 0)
-		pio_status = dpc_process_rp_pio_error(dpc);
-
-	pci_lock_rescan_remove();
-	list_for_each_entry_safe_reverse(dev, temp, &parent->devices,
-					 bus_list) {
-		pci_dev_get(dev);
-		pci_dev_set_disconnected(dev, NULL);
-		if (pci_has_subordinate(dev))
-			pci_walk_bus(dev->subordinate,
-				     pci_dev_set_disconnected, NULL);
-		pci_stop_and_remove_bus_device(dev);
-		pci_dev_put(dev);
-	}
-	pci_unlock_rescan_remove();
-
-	dpc_wait_link_inactive(dpc);
-	if (dpc->rp_extensions && dpc_wait_rp_inactive(dpc))
-		return;
-	if (dpc->rp_extensions && pio_status)
-		pci_write_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_STATUS,
-				       pio_status);
-
-	pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
-		PCI_EXP_DPC_STATUS_TRIGGER | PCI_EXP_DPC_STATUS_INTERRUPT);
-}
-
 static u32 dpc_process_rp_pio_error(struct dpc_dev *dpc)
 {
 	struct device *dev = &dpc->dev->device;
 	struct pci_dev *pdev = dpc->dev->port;
-	u16 cap = dpc->cap_pos;
-	u32 status, mask;
-	u32 sev, syserr, exc;
-	u16 dpc_status, first_error;
+	u16 cap = dpc->cap_pos, dpc_status, first_error;
+	u32 status, mask, sev, syserr, exc, dw0, dw1, dw2, dw3, log, prefix,
+		pio_status;
 	int i;
-	u32 dw0, dw1, dw2, dw3;
-	u32 log;
-	u32 prefix, pio_status;
 
 	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_STATUS, &status);
 	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_MASK, &mask);
@@ -198,6 +140,58 @@ static u32 dpc_process_rp_pio_error(struct dpc_dev *dpc)
 	return pio_status;
 }
 
+static void dpc_work(struct work_struct *work)
+{
+	struct dpc_dev *dpc = container_of(work, struct dpc_dev, work);
+	struct pci_dev *dev, *temp, *pdev = dpc->dev->port;
+	struct pci_bus *parent = pdev->subordinate;
+	u16 cap = dpc->cap_pos, status, source, reason, ext_reason;
+	u32 pio_status = 0;
+
+	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
+	pci_read_config_word(pdev, cap + PCI_EXP_DPC_SOURCE_ID, &source);
+
+	dev_info(&pdev->dev, "DPC containment event, status:%#06x source:%#06x\n",
+		status, source);
+
+	reason = (status & PCI_EXP_DPC_STATUS_TRIGGER_RSN) >> 1;
+	ext_reason = (status & PCI_EXP_DPC_STATUS_TRIGGER_RSN_EXT) >> 5;
+
+	dev_warn(&pdev->dev, "DPC %s detected, remove downstream devices\n",
+		 (reason == 0) ? "unmasked uncorrectable error" :
+		 (reason == 1) ? "ERR_NONFATAL" :
+		 (reason == 2) ? "ERR_FATAL" :
+		 (ext_reason == 0) ? "RP PIO error" :
+		 (ext_reason == 1) ? "software trigger" :
+				     "reserved error");
+
+	if (dpc->rp_extensions && reason == 3 && ext_reason == 0)
+		pio_status = dpc_process_rp_pio_error(dpc);
+
+	pci_lock_rescan_remove();
+	list_for_each_entry_safe_reverse(dev, temp, &parent->devices,
+					 bus_list) {
+		pci_dev_get(dev);
+		pci_dev_set_disconnected(dev, NULL);
+		if (pci_has_subordinate(dev))
+			pci_walk_bus(dev->subordinate,
+				     pci_dev_set_disconnected, NULL);
+		pci_stop_and_remove_bus_device(dev);
+		pci_dev_put(dev);
+	}
+	pci_unlock_rescan_remove();
+
+	dpc_wait_link_inactive(dpc);
+	if (dpc->rp_extensions && dpc_wait_rp_inactive(dpc))
+		return;
+	if (dpc->rp_extensions && pio_status)
+		pci_write_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_STATUS,
+				       pio_status);
+
+	pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
+		PCI_EXP_DPC_STATUS_TRIGGER | PCI_EXP_DPC_STATUS_INTERRUPT);
+}
+
 static irqreturn_t dpc_irq(int irq, void *context)
 {
 	struct dpc_dev *dpc = (struct dpc_dev *)context;
-- 
2.14.3
