Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: <honghui.zhang@mediatek.com>
To: <bhelgaas@google.com>, <matthias.bgg@gmail.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <yingjoe.chen@mediatek.com>,
 <eddie.huang@mediatek.com>, <ryder.lee@mediatek.com>
Subject: [PATCH] PCI: mediatek: add msi support for mt2712 and mt7622
Date: Fri, 11 Aug 2017 20:27:49 +0800
Message-ID: <1502454469-29230-1-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: youlin.pei@mediatek.com, hongkun.cao@mediatek.com, sean.wang@mediatek.com,
 xinping.qian@mediatek.com, honghui.zhang@mediatek.com, yt.shen@mediatek.com,
 yong.wu@mediatek.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

From: Honghui Zhang <honghui.zhang@mediatek.com>

MT2712 and MT7622's PCIe host controller support 32bit address MSI, and it
connect to GIC with the same IRQ number of INTx IRQ, so it shares the same
IRQ with INTx IRQ.

This patch adds MSI support for MT2712 and MT7622.

Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
---
 drivers/pci/host/pcie-mediatek.c | 146 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 146 insertions(+)

diff --git a/drivers/pci/host/pcie-mediatek.c b/drivers/pci/host/pcie-mediatek.c
index c96cd8f..72cad4f 100644
--- a/drivers/pci/host/pcie-mediatek.c
+++ b/drivers/pci/host/pcie-mediatek.c
@@ -73,11 +73,17 @@
 #define PCIE_CSR_ASPM_L1_EN(x)	BIT(1 + (x) * 8)
 
 /* PCIe V2 per-port registers */
+#define PCIE_MSI_VECTOR		0x0c0
 #define PCIE_INT_MASK		0x420
 #define INTX_MASK		GENMASK(19, 16)
 #define INTX_SHIFT		16
 #define INTX_NUM		4
 #define PCIE_INT_STATUS		0x424
+#define MSI_STATUS		BIT(23)
+#define PCIE_IMSI_STATUS	0x42c
+#define PCIE_IMSI_ADDR		0x430
+#define MSI_MASK		BIT(23)
+#define MTK_MSI_IRQS_NUM	32
 
 #define PCIE_AHB_TRANS_BASE0_L	0x438
 #define PCIE_AHB_TRANS_BASE0_H	0x43c
@@ -128,11 +134,13 @@ struct mtk_pcie_port;
 
 /**
  * struct mtk_pcie_soc - differentiate between host generations
+ * @support_msi: whether this host support MSI interrupt or not
  * @ops: pointer to configuration access functions
  * @startup: pointer to controller setting functions
  * @setup_irq: pointer to initialize IRQ functions
  */
 struct mtk_pcie_soc {
+	bool support_msi;
 	struct pci_ops *ops;
 	int (*startup)(struct mtk_pcie_port *port);
 	int (*setup_irq)(struct mtk_pcie_port *port, struct device_node *node);
@@ -156,6 +164,8 @@ struct mtk_pcie_soc {
  * @lane: lane count
  * @slot: port slot
  * @irq_domain: legacy INTx IRQ domain
+ * @msi_domain: MSI IRQ domain
+ * @msi_irq_in_use: bit map for assigned MSI IRQ
  */
 struct mtk_pcie_port {
 	void __iomem *base;
@@ -172,6 +182,8 @@ struct mtk_pcie_port {
 	u32 lane;
 	u32 slot;
 	struct irq_domain *irq_domain;
+	struct irq_domain *msi_domain;
+	DECLARE_BITMAP(msi_irq_in_use, MTK_MSI_IRQS_NUM);
 };
 
 /**
@@ -427,6 +439,108 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
 	return 0;
 }
 
+static int mtk_pcie_assign_msi(struct mtk_pcie_port *port)
+{
+	int pos;
+
+	pos = find_first_zero_bit(port->msi_irq_in_use, MTK_MSI_IRQS_NUM);
+	if (pos < MTK_MSI_IRQS_NUM)
+		set_bit(pos, port->msi_irq_in_use);
+	else
+		return -ENOSPC;
+
+	return pos;
+}
+
+static int mtk_pcie_msi_setup_irq(struct msi_controller *chip,
+				  struct pci_dev *pdev,
+				  struct msi_desc *desc)
+{
+	struct mtk_pcie_port *port;
+	struct msi_msg msg;
+	int hwirq;
+	u32 irq;
+
+	port = mtk_pcie_find_port(pdev->bus, pdev->devfn);
+	if (!port)
+		return -EINVAL;
+
+	chip->dev = &pdev->dev;
+	hwirq = mtk_pcie_assign_msi(port);
+	if (hwirq < 0)
+		return hwirq;
+
+	irq = irq_create_mapping(port->msi_domain, hwirq);
+	if (!irq)
+		return -EINVAL;
+
+	irq_set_msi_desc(irq, desc);
+
+	/* MT2712/MT7622 only support 32 bit MSI address */
+	msg.address_hi = 0;
+	msg.address_lo = lower_32_bits((u64)(port->base + PCIE_MSI_VECTOR));
+	msg.data = hwirq;
+
+	pci_write_msi_msg(irq, &msg);
+
+	return 0;
+}
+
+static void mtk_msi_teardown_irq(struct msi_controller *chip, unsigned int irq)
+{
+	struct pci_dev *pdev = to_pci_dev(chip->dev);
+	struct irq_data *d = irq_get_irq_data(irq);
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
+	struct mtk_pcie_port *port;
+
+	port = mtk_pcie_find_port(pdev->bus, pdev->devfn);
+	if (!port)
+		return;
+
+	if (!test_bit(hwirq, port->msi_irq_in_use))
+		dev_err(&pdev->dev, "Trying to free unused MSI#%d\n", irq);
+	else
+		clear_bit(hwirq, port->msi_irq_in_use);
+}
+
+static struct msi_controller mtk_pcie_msi_chip = {
+	.setup_irq = mtk_pcie_msi_setup_irq,
+	.teardown_irq = mtk_msi_teardown_irq,
+};
+
+static struct irq_chip mtk_msi_irq_chip = {
+	.name = "MTK PCIe MSI",
+	.irq_enable = pci_msi_unmask_irq,
+	.irq_disable = pci_msi_mask_irq,
+	.irq_mask = pci_msi_mask_irq,
+	.irq_unmask = pci_msi_unmask_irq,
+};
+
+static int mtk_pcie_msi_map(struct irq_domain *domain, unsigned int irq,
+			    irq_hw_number_t hwirq)
+{
+	irq_set_chip_and_handler(irq, &mtk_msi_irq_chip, handle_simple_irq);
+	irq_set_chip_data(irq, domain->host_data);
+
+	return 0;
+}
+
+static const struct irq_domain_ops msi_domain_ops = {
+	.map = mtk_pcie_msi_map,
+};
+
+static void mtk_pcie_enable_msi(struct mtk_pcie_port *port)
+{
+	u32 val;
+
+	val = lower_32_bits((u64)(port->base + PCIE_MSI_VECTOR));
+	writel(val, port->base + PCIE_IMSI_ADDR);
+
+	val = readl(port->base + PCIE_INT_MASK);
+	val &= ~MSI_MASK;
+	writel(val, port->base + PCIE_INT_MASK);
+}
+
 static int mtk_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
 			     irq_hw_number_t hwirq)
 {
@@ -460,6 +574,18 @@ static int mtk_pcie_init_irq_domain(struct mtk_pcie_port *port,
 		return PTR_ERR(port->irq_domain);
 	}
 
+	/* Setup MSI */
+	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+		port->msi_domain = irq_domain_add_linear(node, MTK_MSI_IRQS_NUM,
+							 &msi_domain_ops,
+							 &mtk_pcie_msi_chip);
+		if (!port->msi_domain) {
+			dev_err(dev, "Failed to get a MSI IRQ domain\n");
+			return PTR_ERR(port->msi_domain);
+		}
+		mtk_pcie_enable_msi(port);
+	}
+
 	return 0;
 }
 
@@ -480,6 +606,23 @@ static irqreturn_t mtk_pcie_intr_handler(int irq, void *data)
 		}
 	}
 
+	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+		while ((status = readl(port->base + PCIE_INT_STATUS)) & MSI_STATUS) {
+			unsigned long imsi_status;
+
+			while ((imsi_status = readl(port->base + PCIE_IMSI_STATUS))) {
+				for_each_set_bit(bit, &imsi_status, MTK_MSI_IRQS_NUM) {
+					/* Clear the MSI */
+					writel(1 << bit, port->base + PCIE_IMSI_STATUS);
+					virq = irq_find_mapping(port->msi_domain, bit);
+					generic_handle_irq(virq);
+				}
+			}
+			/* Clear MSI interrupt status */
+			writel(MSI_STATUS, port->base + PCIE_INT_STATUS);
+		}
+	}
+
 	return IRQ_HANDLED;
 }
 
@@ -939,6 +1082,8 @@ static int mtk_pcie_register_host(struct pci_host_bridge *host)
 	host->map_irq = of_irq_parse_and_map_pci;
 	host->swizzle_irq = pci_common_swizzle;
 	host->sysdata = pcie;
+	if (IS_ENABLED(CONFIG_PCI_MSI) && pcie->soc->support_msi)
+		host->msi = &mtk_pcie_msi_chip;
 
 	err = pci_scan_root_bus_bridge(host);
 	if (err < 0)
@@ -1000,6 +1145,7 @@ static const struct mtk_pcie_soc mtk_pcie_soc_v1 = {
 };
 
 static const struct mtk_pcie_soc mtk_pcie_soc_v2 = {
+	.support_msi = true,
 	.ops = &mtk_pcie_ops_v2,
 	.startup = mtk_pcie_startup_port_v2,
 	.setup_irq = mtk_pcie_setup_irq,
-- 
2.6.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
