Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:34486 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751878AbcFFNGv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 6 Jun 2016 09:06:51 -0400
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Keith Busch <keith.busch@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH 3/4] PCI / DPC: Convert the driver to use devm_* functions
Date: Mon,  6 Jun 2016 16:06:07 +0300
Message-Id: <1465218368-36494-4-git-send-email-mika.westerberg@linux.intel.com>
In-Reply-To: <1465218368-36494-1-git-send-email-mika.westerberg@linux.intel.com>
References: <1465218368-36494-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

These will automatically release the resources when the driver is removed
so no need to do that explicitly in the driver.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/pcie/pcie-dpc.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
index 533c548607d7..8a061645f217 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -89,7 +89,7 @@ static int dpc_probe(struct pcie_device *dev)
 	int status;
 	u16 ctl, cap;
 
-	dpc = kzalloc(sizeof(*dpc), GFP_KERNEL);
+	dpc = devm_kzalloc(&dev->device, sizeof(*dpc), GFP_KERNEL);
 	if (!dpc)
 		return -ENOMEM;
 
@@ -98,11 +98,12 @@ static int dpc_probe(struct pcie_device *dev)
 	INIT_WORK(&dpc->work, interrupt_event_handler);
 	set_service_data(dev, dpc);
 
-	status = request_irq(dev->irq, dpc_irq, IRQF_SHARED, "pcie-dpc", dpc);
+	status = devm_request_irq(&dev->device, dev->irq, dpc_irq, IRQF_SHARED,
+				  "pcie-dpc", dpc);
 	if (status) {
 		dev_warn(&dev->device, "request IRQ%d failed: %d\n", dev->irq,
 			 status);
-		goto out;
+		return status;
 	}
 
 	pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CAP, &cap);
@@ -117,9 +118,6 @@ static int dpc_probe(struct pcie_device *dev)
 		FLAG(cap, PCI_EXP_DPC_CAP_SW_TRIGGER), (cap >> 8) & 0xf,
 		FLAG(cap, PCI_EXP_DPC_CAP_DL_ACTIVE));
 	return status;
- out:
-	kfree(dpc);
-	return status;
 }
 
 static void dpc_remove(struct pcie_device *dev)
@@ -131,9 +129,6 @@ static void dpc_remove(struct pcie_device *dev)
 	pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, &ctl);
 	ctl &= ~(PCI_EXP_DPC_CTL_EN_NONFATAL | PCI_EXP_DPC_CTL_INT_EN);
 	pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, ctl);
-
-	free_irq(dev->irq, dpc);
-	kfree(dpc);
 }
 
 static struct pcie_port_service_driver dpcdriver = {
-- 
2.8.1

