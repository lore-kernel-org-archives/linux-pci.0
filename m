Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:40105 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752609AbeDBQT5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Apr 2018 12:19:57 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Oza Pawandeep <poza@codeaurora.org>,
        Sinan Kaya <okaya@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv2 4/7] PCI/DPC: Defer event handling to work queue
Date: Mon,  2 Apr 2018 10:22:00 -0600
Message-Id: <20180402162203.3370-5-keith.busch@intel.com>
In-Reply-To: <20180402162203.3370-1-keith.busch@intel.com>
References: <20180402162203.3370-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This moves all event handling to the existing work queue, which will
make passing event information simpler to the handler.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/pcie-dpc.c | 53 ++++++++++++++++++++-------------------------
 1 file changed, 24 insertions(+), 29 deletions(-)

diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
index 38b2d0586c72..a28901e88f7b 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -45,6 +45,8 @@ static const char * const rp_pio_error_string[] = {
 	"Memory Request Completion Timeout",		 /* Bit Position 18 */
 };
 
+static void dpc_process_rp_pio_error(struct dpc_dev *dpc);
+
 static int dpc_wait_rp_inactive(struct dpc_dev *dpc)
 {
 	unsigned long timeout = jiffies + HZ;
@@ -87,7 +89,27 @@ static void dpc_work(struct work_struct *work)
 	struct dpc_dev *dpc = container_of(work, struct dpc_dev, work);
 	struct pci_dev *dev, *temp, *pdev = dpc->dev->port;
 	struct pci_bus *parent = pdev->subordinate;
-	u16 cap = dpc->cap_pos;
+	u16 cap = dpc->cap_pos, status, source, reason, ext_reason;
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
+		dpc_process_rp_pio_error(dpc);
 
 	pci_lock_rescan_remove();
 	list_for_each_entry_safe_reverse(dev, temp, &parent->devices,
@@ -176,39 +198,12 @@ static irqreturn_t dpc_irq(int irq, void *context)
 {
 	struct dpc_dev *dpc = (struct dpc_dev *)context;
 	struct pci_dev *pdev = dpc->dev->port;
-	struct device *dev = &dpc->dev->device;
-	u16 cap = dpc->cap_pos, status, source, reason, ext_reason;
+	u16 cap = dpc->cap_pos, status;
 
 	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
 	if (!(status & PCI_EXP_DPC_STATUS_INTERRUPT) || status == (u16)(~0))
 		return IRQ_NONE;
 
-	if (!(status & PCI_EXP_DPC_STATUS_TRIGGER)) {
-		pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
-				      PCI_EXP_DPC_STATUS_INTERRUPT);
-		return IRQ_HANDLED;
-	}
-
-	pci_read_config_word(pdev, cap + PCI_EXP_DPC_SOURCE_ID,
-			     &source);
-
-	dev_info(dev, "DPC containment event, status:%#06x source:%#06x\n",
-		status, source);
-
-	reason = (status & PCI_EXP_DPC_STATUS_TRIGGER_RSN) >> 1;
-	ext_reason = (status & PCI_EXP_DPC_STATUS_TRIGGER_RSN_EXT) >> 5;
-
-	dev_warn(dev, "DPC %s detected, remove downstream devices\n",
-		 (reason == 0) ? "unmasked uncorrectable error" :
-		 (reason == 1) ? "ERR_NONFATAL" :
-		 (reason == 2) ? "ERR_FATAL" :
-		 (ext_reason == 0) ? "RP PIO error" :
-		 (ext_reason == 1) ? "software trigger" :
-				     "reserved error");
-	/* show RP PIO error detail information */
-	if (dpc->rp_extensions && reason == 3 && ext_reason == 0)
-		dpc_process_rp_pio_error(dpc);
-
 	pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
 			      PCI_EXP_DPC_STATUS_INTERRUPT);
 	if (status & PCI_EXP_DPC_STATUS_TRIGGER)
-- 
2.14.3
