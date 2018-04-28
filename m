Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:42072 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759215AbeD1B51 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Apr 2018 21:57:27 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH v2 4/9] PCI: aardvark: Use pci_alloc_intx_irqd() helper to get irq domain for INTx
Date: Sat, 28 Apr 2018 09:49:29 +0800
Message-Id: <1524880169-101045-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1524880102-100856-1-git-send-email-shawn.lin@rock-chips.com>
References: <1524880102-100856-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Just avoid code duplication, but no functional change intended.

Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v2: None

 drivers/pci/host/pci-aardvark.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/host/pci-aardvark.c b/drivers/pci/host/pci-aardvark.c
index 9abf549..df02b9a 100644
--- a/drivers/pci/host/pci-aardvark.c
+++ b/drivers/pci/host/pci-aardvark.c
@@ -702,37 +702,23 @@ static void advk_pcie_remove_msi_irq_domain(struct advk_pcie *pcie)
 static int advk_pcie_init_irq_domain(struct advk_pcie *pcie)
 {
 	struct device *dev = &pcie->pdev->dev;
-	struct device_node *node = dev->of_node;
-	struct device_node *pcie_intc_node;
 	struct irq_chip *irq_chip;
 
-	pcie_intc_node =  of_get_next_child(node, NULL);
-	if (!pcie_intc_node) {
-		dev_err(dev, "No PCIe Intc node found\n");
-		return -ENODEV;
-	}
-
 	irq_chip = &pcie->irq_chip;
 
 	irq_chip->name = devm_kasprintf(dev, GFP_KERNEL, "%s-irq",
 					dev_name(dev));
-	if (!irq_chip->name) {
-		of_node_put(pcie_intc_node);
+	if (!irq_chip->name)
 		return -ENOMEM;
-	}
 
 	irq_chip->irq_mask = advk_pcie_irq_mask;
 	irq_chip->irq_mask_ack = advk_pcie_irq_mask;
 	irq_chip->irq_unmask = advk_pcie_irq_unmask;
 
-	pcie->irq_domain =
-		irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
-				      &advk_pcie_irq_domain_ops, pcie);
-	if (!pcie->irq_domain) {
-		dev_err(dev, "Failed to get a INTx IRQ domain\n");
-		of_node_put(pcie_intc_node);
-		return -ENOMEM;
-	}
+	pcie->irq_domain = pci_alloc_intx_irqd(dev, pcie, false,
+				&advk_pcie_irq_domain_ops, NULL);
+	if (IS_ERR(pcie->irq_domain))
+		return PTR_ERR(pcie->irq_domain);
 
 	return 0;
 }
-- 
1.9.1
