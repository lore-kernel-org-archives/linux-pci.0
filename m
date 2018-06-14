Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:36976 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935710AbeFNBfF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jun 2018 21:35:05 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pci@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v4 02/10] PCI: dra7xx: Use pci_host_alloc_intx_irqd() helper to simplify the code
Date: Thu, 14 Jun 2018 09:34:43 +0800
Message-Id: <1528940083-183300-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1528939995-183203-1-git-send-email-shawn.lin@rock-chips.com>
References: <1528939995-183203-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Just avoid code duplication, but no functional change intended.

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/pci/controller/dwc/pci-dra7xx.c | 42 +++------------------------------
 1 file changed, 3 insertions(+), 39 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index cfaeef8..a281924 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -213,43 +213,6 @@ static int dra7xx_pcie_host_init(struct pcie_port *pp)
 	.host_init = dra7xx_pcie_host_init,
 };
 
-static int dra7xx_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
-				irq_hw_number_t hwirq)
-{
-	irq_set_chip_and_handler(irq, &dummy_irq_chip, handle_simple_irq);
-	irq_set_chip_data(irq, domain->host_data);
-
-	return 0;
-}
-
-static const struct irq_domain_ops intx_domain_ops = {
-	.map = dra7xx_pcie_intx_map,
-	.xlate = pci_irqd_intx_xlate,
-};
-
-static int dra7xx_pcie_init_irq_domain(struct pcie_port *pp)
-{
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct device *dev = pci->dev;
-	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pci);
-	struct device_node *node = dev->of_node;
-	struct device_node *pcie_intc_node =  of_get_next_child(node, NULL);
-
-	if (!pcie_intc_node) {
-		dev_err(dev, "No PCIe Intc node found\n");
-		return -ENODEV;
-	}
-
-	dra7xx->irq_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
-						   &intx_domain_ops, pp);
-	if (!dra7xx->irq_domain) {
-		dev_err(dev, "Failed to get a INTx IRQ domain\n");
-		return -ENODEV;
-	}
-
-	return 0;
-}
-
 static irqreturn_t dra7xx_pcie_msi_irq_handler(int irq, void *arg)
 {
 	struct dra7xx_pcie *dra7xx = arg;
@@ -455,8 +418,9 @@ static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
 		return ret;
 	}
 
-	ret = dra7xx_pcie_init_irq_domain(pp);
-	if (ret < 0)
+	dra7xx->irq_domain = pci_host_alloc_intx_irqd(dev, dra7xx, true, NULL,
+						      NULL);
+	if (IS_ERR(dra7xx->irq_domain))
 		return ret;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "rc_dbics");
-- 
1.9.1
