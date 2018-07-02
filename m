Return-Path: <linux-kernel-owner@vger.kernel.org>
From: <honghui.zhang@mediatek.com>
To: <lorenzo.pieralisi@arm.com>, <marc.zyngier@arm.com>,
        <bhelgaas@google.com>, <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <yingjoe.chen@mediatek.com>, <eddie.huang@mediatek.com>,
        <ryder.lee@mediatek.com>
CC: <honghui.zhang@mediatek.com>, <hongkun.cao@mediatek.com>,
        <youlin.pei@mediatek.com>, <yong.wu@mediatek.com>,
        <yt.shen@mediatek.com>, <sean.wang@mediatek.com>
Subject: [PATCH v3 2/4] PCI: mediatek: enable msi after clock enabled
Date: Mon, 2 Jul 2018 15:57:42 +0800
Message-ID: <1530518264-6125-3-git-send-email-honghui.zhang@mediatek.com>
In-Reply-To: <1530518264-6125-1-git-send-email-honghui.zhang@mediatek.com>
References: <1530518264-6125-1-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Honghui Zhang <honghui.zhang@mediatek.com>

The clocks was not enabled when enable MSI. This patch fix this
issue by calling mtk_pcie_enable_msi in mtk_pcie_startup_port_v2
since the clock was all enabled at that time.

The function of mtk_pcie_startup_port_v2's define location is
re-arranged to avoid mtk_pcie_enable_msi's forward declaration.

Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/pci/controller/pcie-mediatek.c | 143 +++++++++++++++++----------------
 1 file changed, 72 insertions(+), 71 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index b43f41d..86918d4 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -398,75 +398,6 @@ static struct pci_ops mtk_pcie_ops_v2 = {
 	.write = mtk_pcie_config_write,
 };
 
-static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
-{
-	struct mtk_pcie *pcie = port->pcie;
-	struct resource *mem = &pcie->mem;
-	const struct mtk_pcie_soc *soc = port->pcie->soc;
-	u32 val;
-	size_t size;
-	int err;
-
-	/* MT7622 platforms need to enable LTSSM and ASPM from PCIe subsys */
-	if (pcie->base) {
-		val = readl(pcie->base + PCIE_SYS_CFG_V2);
-		val |= PCIE_CSR_LTSSM_EN(port->slot) |
-		       PCIE_CSR_ASPM_L1_EN(port->slot);
-		writel(val, pcie->base + PCIE_SYS_CFG_V2);
-	}
-
-	/* Assert all reset signals */
-	writel(0, port->base + PCIE_RST_CTRL);
-
-	/*
-	 * Enable PCIe link down reset, if link status changed from link up to
-	 * link down, this will reset MAC control registers and configuration
-	 * space.
-	 */
-	writel(PCIE_LINKDOWN_RST_EN, port->base + PCIE_RST_CTRL);
-
-	/* De-assert PHY, PE, PIPE, MAC and configuration reset	*/
-	val = readl(port->base + PCIE_RST_CTRL);
-	val |= PCIE_PHY_RSTB | PCIE_PERSTB | PCIE_PIPE_SRSTB |
-	       PCIE_MAC_SRSTB | PCIE_CRSTB;
-	writel(val, port->base + PCIE_RST_CTRL);
-
-	/* Set up vendor ID and class code */
-	if (soc->need_fix_class_id) {
-		val = PCI_VENDOR_ID_MEDIATEK;
-		writew(val, port->base + PCIE_CONF_VEND_ID);
-
-		val = PCI_CLASS_BRIDGE_HOST;
-		writew(val, port->base + PCIE_CONF_CLASS_ID);
-	}
-
-	/* 100ms timeout value should be enough for Gen1/2 training */
-	err = readl_poll_timeout(port->base + PCIE_LINK_STATUS_V2, val,
-				 !!(val & PCIE_PORT_LINKUP_V2), 20,
-				 100 * USEC_PER_MSEC);
-	if (err)
-		return -ETIMEDOUT;
-
-	/* Set INTx mask */
-	val = readl(port->base + PCIE_INT_MASK);
-	val &= ~INTX_MASK;
-	writel(val, port->base + PCIE_INT_MASK);
-
-	/* Set AHB to PCIe translation windows */
-	size = mem->end - mem->start;
-	val = lower_32_bits(mem->start) | AHB2PCIE_SIZE(fls(size));
-	writel(val, port->base + PCIE_AHB_TRANS_BASE0_L);
-
-	val = upper_32_bits(mem->start);
-	writel(val, port->base + PCIE_AHB_TRANS_BASE0_H);
-
-	/* Set PCIe to AXI translation memory space.*/
-	val = fls(0xffffffff) | WIN_ENABLE;
-	writel(val, port->base + PCIE_AXI_WINDOW0);
-
-	return 0;
-}
-
 static void mtk_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 {
 	struct mtk_pcie_port *port = irq_data_get_irq_chip_data(data);
@@ -643,8 +574,6 @@ static int mtk_pcie_init_irq_domain(struct mtk_pcie_port *port,
 		ret = mtk_pcie_allocate_msi_domains(port);
 		if (ret)
 			return ret;
-
-		mtk_pcie_enable_msi(port);
 	}
 
 	return 0;
@@ -711,6 +640,78 @@ static int mtk_pcie_setup_irq(struct mtk_pcie_port *port,
 	return 0;
 }
 
+static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
+{
+	struct mtk_pcie *pcie = port->pcie;
+	struct resource *mem = &pcie->mem;
+	const struct mtk_pcie_soc *soc = port->pcie->soc;
+	u32 val;
+	size_t size;
+	int err;
+
+	/* MT7622 platforms need to enable LTSSM and ASPM from PCIe subsys */
+	if (pcie->base) {
+		val = readl(pcie->base + PCIE_SYS_CFG_V2);
+		val |= PCIE_CSR_LTSSM_EN(port->slot) |
+		       PCIE_CSR_ASPM_L1_EN(port->slot);
+		writel(val, pcie->base + PCIE_SYS_CFG_V2);
+	}
+
+	/* Assert all reset signals */
+	writel(0, port->base + PCIE_RST_CTRL);
+
+	/*
+	 * Enable PCIe link down reset, if link status changed from link up to
+	 * link down, this will reset MAC control registers and configuration
+	 * space.
+	 */
+	writel(PCIE_LINKDOWN_RST_EN, port->base + PCIE_RST_CTRL);
+
+	/* De-assert PHY, PE, PIPE, MAC and configuration reset	*/
+	val = readl(port->base + PCIE_RST_CTRL);
+	val |= PCIE_PHY_RSTB | PCIE_PERSTB | PCIE_PIPE_SRSTB |
+	       PCIE_MAC_SRSTB | PCIE_CRSTB;
+	writel(val, port->base + PCIE_RST_CTRL);
+
+	/* Set up vendor ID and class code */
+	if (soc->need_fix_class_id) {
+		val = PCI_VENDOR_ID_MEDIATEK;
+		writew(val, port->base + PCIE_CONF_VEND_ID);
+
+		val = PCI_CLASS_BRIDGE_HOST;
+		writew(val, port->base + PCIE_CONF_CLASS_ID);
+	}
+
+	/* 100ms timeout value should be enough for Gen1/2 training */
+	err = readl_poll_timeout(port->base + PCIE_LINK_STATUS_V2, val,
+				 !!(val & PCIE_PORT_LINKUP_V2), 20,
+				 100 * USEC_PER_MSEC);
+	if (err)
+		return -ETIMEDOUT;
+
+	/* Set INTx mask */
+	val = readl(port->base + PCIE_INT_MASK);
+	val &= ~INTX_MASK;
+	writel(val, port->base + PCIE_INT_MASK);
+
+	if (IS_ENABLED(CONFIG_PCI_MSI))
+		mtk_pcie_enable_msi(port);
+
+	/* Set AHB to PCIe translation windows */
+	size = mem->end - mem->start;
+	val = lower_32_bits(mem->start) | AHB2PCIE_SIZE(fls(size));
+	writel(val, port->base + PCIE_AHB_TRANS_BASE0_L);
+
+	val = upper_32_bits(mem->start);
+	writel(val, port->base + PCIE_AHB_TRANS_BASE0_H);
+
+	/* Set PCIe to AXI translation memory space.*/
+	val = fls(0xffffffff) | WIN_ENABLE;
+	writel(val, port->base + PCIE_AXI_WINDOW0);
+
+	return 0;
+}
+
 static void __iomem *mtk_pcie_map_bus(struct pci_bus *bus,
 				      unsigned int devfn, int where)
 {
-- 
2.6.4
