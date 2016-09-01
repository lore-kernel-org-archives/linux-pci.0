Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: <bhelgaas@google.com>, <soren.brinkmann@xilinx.com>,
 <christophe.jaillet@wanadoo.fr>, <grygorii.strashko@ti.com>,
 <yinghai@kernel.org>, <lorenzo.pieralisi@arm.com>, <fengguang.wu@intel.com>,
 <michal.simek@xilinx.com>, <arnd@arndb.de>
Subject: [PATCH 1/6] PCI: xilinx: Keep both legacy and MSI interrupt
 references.
Date: Thu, 1 Sep 2016 15:44:41 +0530
Message-ID: <1472724886-28301-1-git-send-email-bharatku@xilinx.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Bharat Kumar Gogada <bharatku@xilinx.com>, linux-pci@vger.kernel.org,
 rgummal@xilinx.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

When built with MSI support the legacy domain reference is being
overwritten with MSI.
Instead creating two separate domains for MSI and legacy interrupts.

Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
---
 drivers/pci/host/pcie-xilinx.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index a30e016..bd64677 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -101,7 +101,8 @@
  * @msi_pages: MSI pages
  * @root_busno: Root Bus number
  * @dev: Device pointer
- * @irq_domain: IRQ domain pointer
+ * @msi_domain: MSI IRQ domain pointer
+ * @leg_domain: Legacy IRQ domain pointer
  * @resources: Bus Resources
  */
 struct xilinx_pcie_port {
@@ -110,7 +111,8 @@ struct xilinx_pcie_port {
 	unsigned long msi_pages;
 	u8 root_busno;
 	struct device *dev;
-	struct irq_domain *irq_domain;
+	struct irq_domain *msi_domain;
+	struct irq_domain *leg_domain;
 	struct list_head resources;
 };
 
@@ -281,7 +283,7 @@ static int xilinx_pcie_msi_setup_irq(struct msi_controller *chip,
 	if (hwirq < 0)
 		return hwirq;
 
-	irq = irq_create_mapping(port->irq_domain, hwirq);
+	irq = irq_create_mapping(port->msi_domain, hwirq);
 	if (!irq)
 		return -EINVAL;
 
@@ -443,7 +445,7 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
 			/* Handle INTx Interrupt */
 			val = ((val & XILINX_PCIE_RPIFR1_INTR_MASK) >>
 				XILINX_PCIE_RPIFR1_INTR_SHIFT) + 1;
-			generic_handle_irq(irq_find_mapping(port->irq_domain,
+			generic_handle_irq(irq_find_mapping(port->leg_domain,
 							    val));
 		}
 	}
@@ -526,12 +528,14 @@ static void xilinx_pcie_free_irq_domain(struct xilinx_pcie_port *port)
 	}
 
 	for (i = 0; i < num_irqs; i++) {
-		irq = irq_find_mapping(port->irq_domain, i);
+		irq = irq_find_mapping(port->leg_domain, i);
 		if (irq > 0)
 			irq_dispose_mapping(irq);
 	}
-
-	irq_domain_remove(port->irq_domain);
+	if (port->leg_domain)
+		irq_domain_remove(port->leg_domain);
+	if (port->msi_domain)
+		irq_domain_remove(port->msi_domain);
 }
 
 /**
@@ -553,21 +557,21 @@ static int xilinx_pcie_init_irq_domain(struct xilinx_pcie_port *port)
 		return -ENODEV;
 	}
 
-	port->irq_domain = irq_domain_add_linear(pcie_intc_node, 4,
+	port->leg_domain = irq_domain_add_linear(pcie_intc_node, 4,
 						 &intx_domain_ops,
 						 port);
-	if (!port->irq_domain) {
+	if (!port->leg_domain) {
 		dev_err(dev, "Failed to get a INTx IRQ domain\n");
 		return -ENODEV;
 	}
 
 	/* Setup MSI */
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-		port->irq_domain = irq_domain_add_linear(node,
+		port->msi_domain = irq_domain_add_linear(node,
 							 XILINX_NUM_MSI_IRQS,
 							 &msi_domain_ops,
 							 &xilinx_pcie_msi_chip);
-		if (!port->irq_domain) {
+		if (!port->msi_domain) {
 			dev_err(dev, "Failed to get a MSI IRQ domain\n");
 			return -ENODEV;
 		}
-- 
2.1.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
