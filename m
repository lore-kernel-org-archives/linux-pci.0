Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:40106 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752771AbeDBQT5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Apr 2018 12:19:57 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Oza Pawandeep <poza@codeaurora.org>,
        Sinan Kaya <okaya@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv2 3/7] PCI/DPC: Leave interrupts enabled while handling event
Date: Mon,  2 Apr 2018 10:21:59 -0600
Message-Id: <20180402162203.3370-4-keith.busch@intel.com>
In-Reply-To: <20180402162203.3370-1-keith.busch@intel.com>
References: <20180402162203.3370-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now that the DPC driver clears the interrupt status before exiting the
irq handler, we don't need to abuse the DPC control register to know if
a shared interrupt is for a new DPC event: a DPC port can not trigger
a second interrupt until the host clears the trigger status later in the
work queue handler.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/pcie-dpc.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
index 82644245cb4d..38b2d0586c72 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -87,7 +87,7 @@ static void dpc_work(struct work_struct *work)
 	struct dpc_dev *dpc = container_of(work, struct dpc_dev, work);
 	struct pci_dev *dev, *temp, *pdev = dpc->dev->port;
 	struct pci_bus *parent = pdev->subordinate;
-	u16 cap = dpc->cap_pos, ctl;
+	u16 cap = dpc->cap_pos;
 
 	pci_lock_rescan_remove();
 	list_for_each_entry_safe_reverse(dev, temp, &parent->devices,
@@ -113,10 +113,6 @@ static void dpc_work(struct work_struct *work)
 
 	pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
 			      PCI_EXP_DPC_STATUS_TRIGGER);
-
-	pci_read_config_word(pdev, cap + PCI_EXP_DPC_CTL, &ctl);
-	pci_write_config_word(pdev, cap + PCI_EXP_DPC_CTL,
-			      ctl | PCI_EXP_DPC_CTL_INT_EN);
 }
 
 static void dpc_process_rp_pio_error(struct dpc_dev *dpc)
@@ -181,16 +177,10 @@ static irqreturn_t dpc_irq(int irq, void *context)
 	struct dpc_dev *dpc = (struct dpc_dev *)context;
 	struct pci_dev *pdev = dpc->dev->port;
 	struct device *dev = &dpc->dev->device;
-	u16 cap = dpc->cap_pos, ctl, status, source, reason, ext_reason;
-
-	pci_read_config_word(pdev, cap + PCI_EXP_DPC_CTL, &ctl);
-
-	if (!(ctl & PCI_EXP_DPC_CTL_INT_EN) || ctl == (u16)(~0))
-		return IRQ_NONE;
+	u16 cap = dpc->cap_pos, status, source, reason, ext_reason;
 
 	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
-
-	if (!(status & PCI_EXP_DPC_STATUS_INTERRUPT))
+	if (!(status & PCI_EXP_DPC_STATUS_INTERRUPT) || status == (u16)(~0))
 		return IRQ_NONE;
 
 	if (!(status & PCI_EXP_DPC_STATUS_TRIGGER)) {
@@ -199,9 +189,6 @@ static irqreturn_t dpc_irq(int irq, void *context)
 		return IRQ_HANDLED;
 	}
 
-	pci_write_config_word(pdev, cap + PCI_EXP_DPC_CTL,
-			      ctl & ~PCI_EXP_DPC_CTL_INT_EN);
-
 	pci_read_config_word(pdev, cap + PCI_EXP_DPC_SOURCE_ID,
 			     &source);
 
@@ -224,9 +211,8 @@ static irqreturn_t dpc_irq(int irq, void *context)
 
 	pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
 			      PCI_EXP_DPC_STATUS_INTERRUPT);
-
-	schedule_work(&dpc->work);
-
+	if (status & PCI_EXP_DPC_STATUS_TRIGGER)
+		schedule_work(&dpc->work);
 	return IRQ_HANDLED;
 }
 
-- 
2.14.3
