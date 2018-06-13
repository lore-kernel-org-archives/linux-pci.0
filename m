Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:43815 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933657AbeFMH1H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jun 2018 03:27:07 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pci@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v3 07/10] PCI: mediatek: Use pci_host_alloc_intx_irqd() helper to get irq domain for INTx
Date: Wed, 13 Jun 2018 15:26:41 +0800
Message-Id: <1528874801-7863-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1528874696-7524-1-git-send-email-shawn.lin@rock-chips.com>
References: <1528874696-7524-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Just avoid code duplication, but no functional change intended.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v3: None
Changes in v2: None

 drivers/pci/controller/pcie-mediatek.c | 30 ++++--------------------------
 1 file changed, 4 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 0baabe3..b35a8ce 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -590,39 +590,17 @@ static void mtk_pcie_enable_msi(struct mtk_pcie_port *port)
 	writel(val, port->base + PCIE_INT_MASK);
 }
 
-static int mtk_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
-			     irq_hw_number_t hwirq)
-{
-	irq_set_chip_and_handler(irq, &dummy_irq_chip, handle_simple_irq);
-	irq_set_chip_data(irq, domain->host_data);
-
-	return 0;
-}
-
-static const struct irq_domain_ops intx_domain_ops = {
-	.map = mtk_pcie_intx_map,
-};
-
 static int mtk_pcie_init_irq_domain(struct mtk_pcie_port *port,
 				    struct device_node *node)
 {
 	struct device *dev = port->pcie->dev;
-	struct device_node *pcie_intc_node;
 	int ret;
 
-	/* Setup INTx */
-	pcie_intc_node = of_get_next_child(node, NULL);
-	if (!pcie_intc_node) {
-		dev_err(dev, "no PCIe Intc node found\n");
-		return -ENODEV;
-	}
+	port->irq_domain = pci_host_alloc_intx_irqd(dev, port, false,
+						    NULL, NULL);
+	if (IS_ERR(port->irq_domain))
+		return PTR_ERR(port->irq_domain);
 
-	port->irq_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
-						 &intx_domain_ops, port);
-	if (!port->irq_domain) {
-		dev_err(dev, "failed to get INTx IRQ domain\n");
-		return -ENODEV;
-	}
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		ret = mtk_pcie_allocate_msi_domains(port);
-- 
1.9.1
