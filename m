Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:43661 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754479AbeFMH0v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jun 2018 03:26:51 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pci@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v3 06/10] PCI: altera: Use pci_host_alloc_intx_irqd() helper to get irq domain for INTx
Date: Wed, 13 Jun 2018 15:26:28 +0800
Message-Id: <1528874788-7815-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1528874696-7524-1-git-send-email-shawn.lin@rock-chips.com>
References: <1528874696-7524-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Just avoid code duplication, but no functional change intended.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v3: None
Changes in v2: None

 drivers/pci/controller/pcie-altera.c | 38 ++++--------------------------------
 1 file changed, 4 insertions(+), 34 deletions(-)

diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
index 7d05e51..0915c8b 100644
--- a/drivers/pci/controller/pcie-altera.c
+++ b/drivers/pci/controller/pcie-altera.c
@@ -443,19 +443,6 @@ static void altera_pcie_retrain(struct altera_pcie *pcie)
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
@@ -519,22 +506,6 @@ static int altera_pcie_parse_request_of_pci_ranges(struct altera_pcie *pcie)
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
@@ -592,11 +563,10 @@ static int altera_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = altera_pcie_init_irq_domain(pcie);
-	if (ret) {
-		dev_err(dev, "Failed creating IRQ Domain\n");
-		return ret;
-	}
+	pcie->irq_domain = pci_host_alloc_intx_irqd(dev, pcie, true, NULL,
+						    dev->of_node);
+	if (IS_ERR(pcie->irq_domain))
+		return PTR_ERR(pcie->irq_domain);
 
 	/* clear all interrupts */
 	cra_writel(pcie, P2A_INT_STS_ALL, P2A_INT_STATUS);
-- 
1.9.1
