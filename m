Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:42262 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759215AbeD1B5v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Apr 2018 21:57:51 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>
Subject: [PATCH v2 6/9] PCI: altera: Use pci_alloc_intx_irqd() helper to get irq domain for INTx
Date: Sat, 28 Apr 2018 09:50:03 +0800
Message-Id: <1524880203-101149-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1524880102-100856-1-git-send-email-shawn.lin@rock-chips.com>
References: <1524880102-100856-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Just avoid code duplication, but no functional change intended.

Cc: Ley Foon Tan <ley.foon.tan@intel.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v2: None

 drivers/pci/host/pcie-altera.c | 38 ++++----------------------------------
 1 file changed, 4 insertions(+), 34 deletions(-)

diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-altera.c
index a6af62e..a0fcf0f 100644
--- a/drivers/pci/host/pcie-altera.c
+++ b/drivers/pci/host/pcie-altera.c
@@ -441,19 +441,6 @@ static void altera_pcie_retrain(struct altera_pcie *pcie)
 	}
 }
 
-static int altera_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
-				irq_hw_number_t hwirq)
-{
-	irq_set_chip_and_handler(irq, &dummy_irq_chip, handle_simple_irq);
-	irq_set_chip_data(irq, domain->host_data);
-	return 0;
-}
-
-static const struct irq_domain_ops intx_domain_ops = {
-	.map = altera_pcie_intx_map,
-	.xlate = pci_irqd_intx_xlate,
-};
-
 static void altera_pcie_isr(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
@@ -518,22 +505,6 @@ static int altera_pcie_parse_request_of_pci_ranges(struct altera_pcie *pcie)
 	return err;
 }
 
-static int altera_pcie_init_irq_domain(struct altera_pcie *pcie)
-{
-	struct device *dev = &pcie->pdev->dev;
-	struct device_node *node = dev->of_node;
-
-	/* Setup INTx */
-	pcie->irq_domain = irq_domain_add_linear(node, PCI_NUM_INTX,
-					&intx_domain_ops, pcie);
-	if (!pcie->irq_domain) {
-		dev_err(dev, "Failed to get a INTx IRQ domain\n");
-		return -ENOMEM;
-	}
-
-	return 0;
-}
-
 static int altera_pcie_parse_dt(struct altera_pcie *pcie)
 {
 	struct device *dev = &pcie->pdev->dev;
@@ -591,11 +562,10 @@ static int altera_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = altera_pcie_init_irq_domain(pcie);
-	if (ret) {
-		dev_err(dev, "Failed creating IRQ Domain\n");
-		return ret;
-	}
+	pcie->irq_domain = pci_alloc_intx_irqd(dev, pcie, true, NULL,
+					       dev->of_node);
+	if (IS_ERR(pcie->irq_domain))
+		return PTR_ERR(pcie->irq_domain);
 
 	/* clear all interrupts */
 	cra_writel(pcie, P2A_INT_STS_ALL, P2A_INT_STATUS);
-- 
1.9.1
