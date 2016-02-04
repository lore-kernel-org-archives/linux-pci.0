Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:16368 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933018AbcBDQKy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Feb 2016 11:10:54 -0500
From: Paul Burton <paul.burton@imgtec.com>
To: <linux-mips@linux-mips.org>
CC: Bharat Kumar Gogada <bharatku@xilinx.com>,
	Michal Simek <michal.simek@xilinx.com>,
	Ravikiran Gummaluri <rgummal@xilinx.com>,
	"Paul Burton" <paul.burton@imgtec.com>,
	=?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	"Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
	Russell Joyce <russell.joyce@york.ac.uk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, Rob Herring <robh@kernel.org>,
	<linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Jingoo Han" <jingoohan1@gmail.com>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 1/6] PCI: xilinx: Keep references to both IRQ domains
Date: Thu, 4 Feb 2016 16:10:08 +0000
Message-ID: <1454602213-967-2-git-send-email-paul.burton@imgtec.com>
In-Reply-To: <1454602213-967-1-git-send-email-paul.burton@imgtec.com>
References: <1454602213-967-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pcie-xilinx creates 2 IRQ domains when built with MSI support: one for
MSI interrupts & one for legacy INTx interrupts. However, it only kept a
reference to the MSI IRQ domain. This means that any INTx interrupts
that may occur would be mapped using the wrong domain, and that only the
MSI IRQ domain would be removed along with the driver. Track both IRQ
domains & clean up both as appropriate.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Fixes: 8961def56845 ("PCI: xilinx: Add Xilinx AXI PCIe Host Bridge IP driver")

---

Changes in v3:
- Split out from Boston patchset.

Changes in v2:
- Add Fixes tag.

 drivers/pci/host/pcie-xilinx.c | 58 ++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 30 deletions(-)

diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index 4cfa463..1490bd1 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -105,6 +105,7 @@
  * @root_busno: Root Bus number
  * @dev: Device pointer
  * @irq_domain: IRQ domain pointer
+ * @msi_irq_domain: MSI IRQ domain pointer
  * @bus_range: Bus range
  * @resources: Bus Resources
  */
@@ -115,6 +116,7 @@ struct xilinx_pcie_port {
 	u8 root_busno;
 	struct device *dev;
 	struct irq_domain *irq_domain;
+	struct irq_domain *msi_irq_domain;
 	struct resource bus_range;
 	struct list_head resources;
 };
@@ -291,7 +293,7 @@ static int xilinx_pcie_msi_setup_irq(struct msi_controller *chip,
 	if (hwirq < 0)
 		return hwirq;
 
-	irq = irq_create_mapping(port->irq_domain, hwirq);
+	irq = irq_create_mapping(port->msi_irq_domain, hwirq);
 	if (!irq)
 		return -EINVAL;
 
@@ -517,31 +519,21 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
 
 /**
  * xilinx_pcie_free_irq_domain - Free IRQ domain
- * @port: PCIe port information
+ * @domain: the IRQ domain to free
+ * @nr: the number of IRQs in the domain
  */
-static void xilinx_pcie_free_irq_domain(struct xilinx_pcie_port *port)
+static void xilinx_pcie_free_irq_domain(struct irq_domain *domain, int nr)
 {
 	int i;
-	u32 irq, num_irqs;
-
-	/* Free IRQ Domain */
-	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-
-		free_pages(port->msi_pages, 0);
-
-		num_irqs = XILINX_NUM_MSI_IRQS;
-	} else {
-		/* INTx */
-		num_irqs = 4;
-	}
+	u32 irq;
 
-	for (i = 0; i < num_irqs; i++) {
-		irq = irq_find_mapping(port->irq_domain, i);
+	for (i = 0; i < nr; i++) {
+		irq = irq_find_mapping(domain, i);
 		if (irq > 0)
 			irq_dispose_mapping(irq);
 	}
 
-	irq_domain_remove(port->irq_domain);
+	irq_domain_remove(domain);
 }
 
 /**
@@ -571,20 +563,20 @@ static int xilinx_pcie_init_irq_domain(struct xilinx_pcie_port *port)
 		return PTR_ERR(port->irq_domain);
 	}
 
-	/* Setup MSI */
-	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-		port->irq_domain = irq_domain_add_linear(node,
-							 XILINX_NUM_MSI_IRQS,
-							 &msi_domain_ops,
-							 &xilinx_pcie_msi_chip);
-		if (!port->irq_domain) {
-			dev_err(dev, "Failed to get a MSI IRQ domain\n");
-			return PTR_ERR(port->irq_domain);
-		}
+	if (!IS_ENABLED(CONFIG_PCI_MSI))
+		return 0;
 
-		xilinx_pcie_enable_msi(port);
+	/* Setup MSI */
+	port->msi_irq_domain = irq_domain_add_linear(node,
+						     XILINX_NUM_MSI_IRQS,
+						     &msi_domain_ops,
+						     &xilinx_pcie_msi_chip);
+	if (!port->msi_irq_domain) {
+		dev_err(dev, "Failed to get a MSI IRQ domain\n");
+		return PTR_ERR(port->msi_irq_domain);
 	}
 
+	xilinx_pcie_enable_msi(port);
 	return 0;
 }
 
@@ -869,7 +861,13 @@ static int xilinx_pcie_remove(struct platform_device *pdev)
 {
 	struct xilinx_pcie_port *port = platform_get_drvdata(pdev);
 
-	xilinx_pcie_free_irq_domain(port);
+	xilinx_pcie_free_irq_domain(port->irq_domain, 4);
+
+	if (config_enabled(CONFIG_MSI)) {
+		free_pages(port->msi_pages, 0);
+		xilinx_pcie_free_irq_domain(port->msi_irq_domain,
+					    XILINX_NUM_MSI_IRQS);
+	}
 
 	return 0;
 }
-- 
2.7.0

