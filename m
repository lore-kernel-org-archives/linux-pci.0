Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 23 Aug 2017 13:58:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: honghui.zhang@mediatek.com
Subject: Re: [PATCH v2 0/3] PCI: mediatek: Add MSI support for MT2712 and
 MT7622
Message-ID: <20170823185830.GE8498@bhelgaas-glaptop.roam.corp.google.com>
References: <1502715868-17651-1-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
In-Reply-To: <1502715868-17651-1-git-send-email-honghui.zhang@mediatek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 hongkun.cao@mediatek.com, ryder.lee@mediatek.com, linux-pci@vger.kernel.org,
 sean.wang@mediatek.com, xinping.qian@mediatek.com,
 linux-kernel@vger.kernel.org, yt.shen@mediatek.com, matthias.bgg@gmail.com,
 linux-mediatek@lists.infradead.org, yong.wu@mediatek.com, bhelgaas@google.com,
 yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 14, 2017 at 09:04:25PM +0800, honghui.zhang@mediatek.com wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>
> 
> MT2712 and MT7622's PCIe host controller support MSI, but only 32bit MSI
> address are supportted. It connect to GIC with the same IRQ number of INTx
> IRQ, so it shares the same IRQ with INTx IRQ.
> 
> This patchset add MSI support for MT2712 and MT7622.
> Also do some code fixup and cleanups.
> 
> Change Since V1:
>  - Add the first two patches into this patchset.
>  - Using -ENODEV instead of PTR_ERR if msi_domain == NULL
>  - Change the error logs with consistency of lower-case
>  - Using has_msi instead of support_msi to make the parameter name a bit shorter
> 
> Honghui Zhang (3):
>   PCI: mediatek: Fix return value in case of error
>   PCI: mediatek: take use of bus->sysdata to get host private data
>   PCI: mediatek: add msi support for MT2712 and MT7622
> 
>  drivers/pci/host/pcie-mediatek.c | 157 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 151 insertions(+), 6 deletions(-)

Since "PCI: mediatek: Add controller support for MT2712 and MT7622" patch
hasn't appeared upstream yet, I folded the return value fix directly into
it.

I applied the others to pci/host-mediatek.  I modified the third one to
remove what seemed to be needless differences from the rcar and tegra
drivers.  The incremental diff is attached.  Please check to make sure I
didn't break anything.


diff --git a/drivers/pci/host/pcie-mediatek.c b/drivers/pci/host/pcie-mediatek.c
index 35ab2321ed16..8891c00bf13c 100644
--- a/drivers/pci/host/pcie-mediatek.c
+++ b/drivers/pci/host/pcie-mediatek.c
@@ -134,7 +134,7 @@ struct mtk_pcie_port;
 
 /**
  * struct mtk_pcie_soc - differentiate between host generations
- * @has_msi: whether this host support MSI interrupt or not
+ * @has_msi: whether this host supports MSI interrupts or not
  * @ops: pointer to configuration access functions
  * @startup: pointer to controller setting functions
  * @setup_irq: pointer to initialize IRQ functions
@@ -439,44 +439,51 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
 	return 0;
 }
 
-static int mtk_pcie_assign_msi(struct mtk_pcie_port *port)
+static int mtk_pcie_msi_alloc(struct mtk_pcie_port *port)
 {
-	int pos;
+	int msi;
 
-	pos = find_first_zero_bit(port->msi_irq_in_use, MTK_MSI_IRQS_NUM);
-	if (pos < MTK_MSI_IRQS_NUM)
-		set_bit(pos, port->msi_irq_in_use);
+	msi = find_first_zero_bit(port->msi_irq_in_use, MTK_MSI_IRQS_NUM);
+	if (msi < MTK_MSI_IRQS_NUM)
+		set_bit(msi, port->msi_irq_in_use);
 	else
 		return -ENOSPC;
 
-	return pos;
+	return msi;
+}
+
+static void mtk_pcie_msi_free(struct mtk_pcie_port *port, unsigned long hwirq)
+{
+	clear_bit(hwirq, port->msi_irq_in_use);
 }
 
 static int mtk_pcie_msi_setup_irq(struct msi_controller *chip,
-				  struct pci_dev *pdev,
-				  struct msi_desc *desc)
+				  struct pci_dev *pdev, struct msi_desc *desc)
 {
 	struct mtk_pcie_port *port;
 	struct msi_msg msg;
+	unsigned int irq;
 	int hwirq;
-	u32 irq;
 
 	port = mtk_pcie_find_port(pdev->bus, pdev->devfn);
 	if (!port)
 		return -EINVAL;
 
-	chip->dev = &pdev->dev;
-	hwirq = mtk_pcie_assign_msi(port);
+	hwirq = mtk_pcie_msi_alloc(port);
 	if (hwirq < 0)
 		return hwirq;
 
 	irq = irq_create_mapping(port->msi_domain, hwirq);
-	if (!irq)
+	if (!irq) {
+		mtk_pcie_msi_free(port, hwirq);
 		return -EINVAL;
+	}
+
+	chip->dev = &pdev->dev;
 
 	irq_set_msi_desc(irq, desc);
 
-	/* MT2712/MT7622 only support 32 bit MSI address */
+	/* MT2712/MT7622 only support 32-bit MSI addresses */
 	msg.address_hi = 0;
 	msg.address_lo = lower_32_bits((u64)(port->base + PCIE_MSI_VECTOR));
 	msg.data = hwirq;
@@ -497,10 +504,8 @@ static void mtk_msi_teardown_irq(struct msi_controller *chip, unsigned int irq)
 	if (!port)
 		return;
 
-	if (!test_bit(hwirq, port->msi_irq_in_use))
-		dev_err(&pdev->dev, "trying to free unused MSI#%d\n", irq);
-	else
-		clear_bit(hwirq, port->msi_irq_in_use);
+	irq_dispose_mapping(irq);
+	mtk_pcie_msi_free(port, hwirq);
 }
 
 static struct msi_controller mtk_pcie_msi_chip = {
@@ -529,16 +534,26 @@ static const struct irq_domain_ops msi_domain_ops = {
 	.map = mtk_pcie_msi_map,
 };
 
-static void mtk_pcie_enable_msi(struct mtk_pcie_port *port)
+static int mtk_pcie_enable_msi(struct mtk_pcie_port *port)
 {
 	u32 val;
 
+	port->msi_domain = irq_domain_add_linear(node, MTK_MSI_IRQS_NUM,
+						 &msi_domain_ops,
+						 &mtk_pcie_msi_chip);
+	if (!port->msi_domain) {
+		dev_err(dev, "failed to create MSI IRQ domain\n");
+		return -ENOMEM;
+	}
+
 	val = lower_32_bits((u64)(port->base + PCIE_MSI_VECTOR));
 	writel(val, port->base + PCIE_IMSI_ADDR);
 
 	val = readl(port->base + PCIE_INT_MASK);
 	val &= ~MSI_MASK;
 	writel(val, port->base + PCIE_INT_MASK);
+
+	return 0;
 }
 
 static int mtk_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
@@ -559,6 +574,7 @@ static int mtk_pcie_init_irq_domain(struct mtk_pcie_port *port,
 {
 	struct device *dev = port->pcie->dev;
 	struct device_node *pcie_intc_node;
+	int err;
 
 	/* Setup INTx */
 	pcie_intc_node = of_get_next_child(node, NULL);
@@ -574,16 +590,10 @@ static int mtk_pcie_init_irq_domain(struct mtk_pcie_port *port,
 		return -ENODEV;
 	}
 
-	/* Setup MSI */
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-		port->msi_domain = irq_domain_add_linear(node, MTK_MSI_IRQS_NUM,
-							 &msi_domain_ops,
-							 &mtk_pcie_msi_chip);
-		if (!port->msi_domain) {
-			dev_err(dev, "failed to get MSI IRQ domain\n");
-			return -ENODEV;
-		}
-		mtk_pcie_enable_msi(port);
+		err = mtk_pcie_enable_msi(port);
+		if (err < 0)
+			return err;
 	}
 
 	return 0;

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
