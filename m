Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:55936 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759215AbeD1B6g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Apr 2018 21:58:36 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 9/9] PCI: xilinx: Use pci_alloc_intx_irqd() helper to get irq domain for INTx
Date: Sat, 28 Apr 2018 09:50:43 +0800
Message-Id: <1524880243-101356-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1524880102-100856-1-git-send-email-shawn.lin@rock-chips.com>
References: <1524880102-100856-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Just avoid code duplication, but no functional change intended.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v2: None

 drivers/pci/host/pcie-xilinx.c | 43 +++---------------------------------------
 1 file changed, 3 insertions(+), 40 deletions(-)

diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index 0ad188e..905668a 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -344,31 +344,6 @@ static void xilinx_pcie_enable_msi(struct xilinx_pcie_port *port)
 	pcie_write(port, msg_addr, XILINX_PCIE_REG_MSIBASE2);
 }
 
-/* INTx Functions */
-
-/**
- * xilinx_pcie_intx_map - Set the handler for the INTx and mark IRQ as valid
- * @domain: IRQ domain
- * @irq: Virtual IRQ number
- * @hwirq: HW interrupt number
- *
- * Return: Always returns 0.
- */
-static int xilinx_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
-				irq_hw_number_t hwirq)
-{
-	irq_set_chip_and_handler(irq, &dummy_irq_chip, handle_simple_irq);
-	irq_set_chip_data(irq, domain->host_data);
-
-	return 0;
-}
-
-/* INTx IRQ Domain operations */
-static const struct irq_domain_ops intx_domain_ops = {
-	.map = xilinx_pcie_intx_map,
-	.xlate = pci_irqd_intx_xlate,
-};
-
 /* PCIe HW Functions */
 
 /**
@@ -495,22 +470,10 @@ static int xilinx_pcie_init_irq_domain(struct xilinx_pcie_port *port)
 {
 	struct device *dev = port->dev;
 	struct device_node *node = dev->of_node;
-	struct device_node *pcie_intc_node;
 
-	/* Setup INTx */
-	pcie_intc_node = of_get_next_child(node, NULL);
-	if (!pcie_intc_node) {
-		dev_err(dev, "No PCIe Intc node found\n");
-		return -ENODEV;
-	}
-
-	port->leg_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
-						 &intx_domain_ops,
-						 port);
-	if (!port->leg_domain) {
-		dev_err(dev, "Failed to get a INTx IRQ domain\n");
-		return -ENODEV;
-	}
+	port->leg_domain = pci_alloc_intx_irqd(dev, port, true, NULL, NULL);
+	if (IS_ERR(port->leg_domain))
+		return PTR_ERR(port->leg_domain);
 
 	/* Setup MSI */
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-- 
1.9.1
