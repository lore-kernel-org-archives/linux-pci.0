Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:65218 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751856AbeA2V2G (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Jan 2018 16:28:06 -0500
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Cc: Keith Busch <keith.busch@intel.com>
Subject: [PATCH 2/6] PCI/DPC: Leave interrupts enabled while handling event
Date: Mon, 29 Jan 2018 14:31:41 -0700
Message-Id: <20180129213145.26068-2-keith.busch@intel.com>
In-Reply-To: <20180129213145.26068-1-keith.busch@intel.com>
References: <20180129213145.26068-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The control register was being abused as a way to know if a shared
interrupt is notifying the driver of a new DPC event. A DPC capable port
can not trigger a second interrupt until the host acknowledges the first,
and since DPC handles events in a deferred work queue, we don't need to
use the config register to know if the DPC driver needs to handle the
interrupt. We just need to make sure we don't schedule the same work
multiple times.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/pcie-dpc.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
index ecdb76bc7b56..cf0398ccaeb6 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -89,7 +89,7 @@ static void dpc_work(struct work_struct *work)
 	struct dpc_dev *dpc = container_of(work, struct dpc_dev, work);
 	struct pci_dev *dev, *temp, *pdev = dpc->dev->port;
 	struct pci_bus *parent = pdev->subordinate;
-	u16 cap = dpc->cap_pos, ctl, status, source, reason, ext_reason;
+	u16 cap = dpc->cap_pos, status, source, reason, ext_reason;
 
 	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
 	pci_read_config_word(pdev, cap + PCI_EXP_DPC_SOURCE_ID, &source);
@@ -135,10 +135,6 @@ static void dpc_work(struct work_struct *work)
 
 	pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
 		PCI_EXP_DPC_STATUS_TRIGGER | PCI_EXP_DPC_STATUS_INTERRUPT);
-
-	pci_read_config_word(pdev, cap + PCI_EXP_DPC_CTL, &ctl);
-	pci_write_config_word(pdev, cap + PCI_EXP_DPC_CTL,
-			      ctl | PCI_EXP_DPC_CTL_INT_EN);
 }
 
 static void dpc_process_rp_pio_error(struct dpc_dev *dpc)
@@ -207,16 +203,10 @@ static irqreturn_t dpc_irq(int irq, void *context)
 {
 	struct dpc_dev *dpc = (struct dpc_dev *)context;
 	struct pci_dev *pdev = dpc->dev->port;
-	u16 cap = dpc->cap_pos, ctl, status;
-
-	pci_read_config_word(pdev, cap + PCI_EXP_DPC_CTL, &ctl);
-
-	if (!(ctl & PCI_EXP_DPC_CTL_INT_EN) || ctl == (u16)(~0))
-		return IRQ_NONE;
+	u16 cap = dpc->cap_pos, status;
 
 	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
-
-	if (!(status & PCI_EXP_DPC_STATUS_INTERRUPT))
+	if (!(status & PCI_EXP_DPC_STATUS_INTERRUPT) || status == (u16)(~0))
 		return IRQ_NONE;
 
 	if (!(status & PCI_EXP_DPC_STATUS_TRIGGER)) {
@@ -225,11 +215,8 @@ static irqreturn_t dpc_irq(int irq, void *context)
 		return IRQ_HANDLED;
 	}
 
-	pci_write_config_word(pdev, cap + PCI_EXP_DPC_CTL,
-			      ctl & ~PCI_EXP_DPC_CTL_INT_EN);
-
-	schedule_work(&dpc->work);
-
+	if (!work_busy(&dpc->work))
+		schedule_work(&dpc->work);
 	return IRQ_HANDLED;
 }
 
-- 
2.14.3
