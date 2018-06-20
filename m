Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:20584 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933326AbeFTVfX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Jun 2018 17:35:23 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Sinan Kaya <okaya@codeaurora.org>,
        Oza Pawandeep <poza@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 2/7] PCI/DPC: Defer event handling to work queue
Date: Wed, 20 Jun 2018 15:38:28 -0600
Message-Id: <20180620213833.25072-2-keith.busch@intel.com>
In-Reply-To: <20180620213833.25072-1-keith.busch@intel.com>
References: <20180620213833.25072-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This moves all event handling to the existing work queue, which will
make passing event information simpler to the handler.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/dpc.c | 44 ++++++++++++++++++++------------------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 972aac892846..5f5fac279c75 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -108,14 +108,6 @@ static pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
 	return PCI_ERS_RESULT_RECOVERED;
 }
 
-static void dpc_work(struct work_struct *work)
-{
-	struct dpc_dev *dpc = container_of(work, struct dpc_dev, work);
-	struct pci_dev *pdev = dpc->dev->port;
-
-	/* We configure DPC so it only triggers on ERR_FATAL */
-	pcie_do_fatal_recovery(pdev, PCIE_PORT_SERVICE_DPC);
-}
 
 static void dpc_process_rp_pio_error(struct dpc_dev *dpc)
 {
@@ -174,33 +166,21 @@ static void dpc_process_rp_pio_error(struct dpc_dev *dpc)
 	}
 }
 
-static irqreturn_t dpc_irq(int irq, void *context)
+static void dpc_work(struct work_struct *work)
 {
-	struct dpc_dev *dpc = (struct dpc_dev *)context;
+	struct dpc_dev *dpc = container_of(work, struct dpc_dev, work);
 	struct pci_dev *pdev = dpc->dev->port;
 	struct device *dev = &dpc->dev->device;
 	u16 cap = dpc->cap_pos, status, source, reason, ext_reason;
 
 	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
-
-	if (!(status & PCI_EXP_DPC_STATUS_INTERRUPT) || status == (u16)(~0))
-		return IRQ_NONE;
-
-	if (!(status & PCI_EXP_DPC_STATUS_TRIGGER)) {
-		pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
-				      PCI_EXP_DPC_STATUS_INTERRUPT);
-		return IRQ_HANDLED;
-	}
-
-	pci_read_config_word(pdev, cap + PCI_EXP_DPC_SOURCE_ID,
-			     &source);
+	pci_read_config_word(pdev, cap + PCI_EXP_DPC_SOURCE_ID, &source);
 
 	dev_info(dev, "DPC containment event, status:%#06x source:%#06x\n",
-		status, source);
+		 status, source);
 
 	reason = (status & PCI_EXP_DPC_STATUS_TRIGGER_RSN) >> 1;
 	ext_reason = (status & PCI_EXP_DPC_STATUS_TRIGGER_RSN_EXT) >> 5;
-
 	dev_warn(dev, "DPC %s detected, remove downstream devices\n",
 		 (reason == 0) ? "unmasked uncorrectable error" :
 		 (reason == 1) ? "ERR_NONFATAL" :
@@ -208,10 +188,26 @@ static irqreturn_t dpc_irq(int irq, void *context)
 		 (ext_reason == 0) ? "RP PIO error" :
 		 (ext_reason == 1) ? "software trigger" :
 				     "reserved error");
+
 	/* show RP PIO error detail information */
 	if (dpc->rp_extensions && reason == 3 && ext_reason == 0)
 		dpc_process_rp_pio_error(dpc);
 
+	/* We configure DPC so it only triggers on ERR_FATAL */
+	pcie_do_fatal_recovery(pdev, PCIE_PORT_SERVICE_DPC);
+}
+
+static irqreturn_t dpc_irq(int irq, void *context)
+{
+	struct dpc_dev *dpc = (struct dpc_dev *)context;
+	struct pci_dev *pdev = dpc->dev->port;
+	u16 cap = dpc->cap_pos, status;
+
+	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
+
+	if (!(status & PCI_EXP_DPC_STATUS_INTERRUPT) || status == (u16)(~0))
+		return IRQ_NONE;
+
 	pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
 			      PCI_EXP_DPC_STATUS_INTERRUPT);
 	if (status & PCI_EXP_DPC_STATUS_TRIGGER)
-- 
2.14.3
