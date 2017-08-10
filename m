Return-Path: <linux-kernel-owner@vger.kernel.org>
From: <honghui.zhang@mediatek.com>
To: <bhelgaas@google.com>, <robh@kerenl.org>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <yingjoe.chen@mediatek.com>, <eddie.huang@mediatek.com>,
        <ryder.lee@mediatek.com>
CC: <honghui.zhang@mediatek.com>, <hongkun.cao@mediatek.com>,
        <youlin.pei@mediatek.com>, <yong.wu@mediatek.com>,
        <yt.shen@mediatek.com>, <sean.wang@mediatek.com>,
        <xinping.qian@mediatek.com>
Subject: [PATCH v4 2/7] PCI: mediatek: make the parameter and function names more accurate
Date: Thu, 10 Aug 2017 14:34:55 +0800
Message-ID: <78775c0224b1798c1ab6ac744f124abcd5d5bfbf.1502336769.git.honghui.zhang@mediatek.com>
In-Reply-To: <cover.1502336769.git.honghui.zhang@mediatek.com>
References: <cover.1502336769.git.honghui.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Honghui Zhang <honghui.zhang@mediatek.com>

Rename "port->index" to "port->slot" since the ports are hardwired at
PCI_SLOT. Also rename "mtk_pcie_parse_ports" to "mtk_pcie_parse_port"
since it parses one port each time.

No functional change in this patch.

Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
---
 drivers/pci/host/pcie-mediatek.c | 50 ++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/host/pcie-mediatek.c b/drivers/pci/host/pcie-mediatek.c
index f4e4226..7d1b7cd 100644
--- a/drivers/pci/host/pcie-mediatek.c
+++ b/drivers/pci/host/pcie-mediatek.c
@@ -73,7 +73,7 @@
  * @sys_ck: pointer to bus clock
  * @phy: pointer to phy control block
  * @lane: lane count
- * @index: port index
+ * @slot: port slot
  */
 struct mtk_pcie_port {
 	void __iomem *base;
@@ -83,7 +83,7 @@ struct mtk_pcie_port {
 	struct clk *sys_ck;
 	struct phy *phy;
 	u32 lane;
-	u32 index;
+	u32 slot;
 };
 
 /**
@@ -170,19 +170,19 @@ static struct pci_ops mtk_pcie_ops = {
 static int mtk_pcie_startup_port(struct mtk_pcie_port *port)
 {
 	struct mtk_pcie *pcie = port->pcie;
-	u32 func = PCI_FUNC(port->index << 3);
-	u32 slot = PCI_SLOT(port->index << 3);
+	u32 func = PCI_FUNC(port->slot << 3);
+	u32 slot = PCI_SLOT(port->slot << 3);
 	u32 val;
 	int err;
 
 	/* assert port PERST_N */
 	val = readl(pcie->base + PCIE_SYS_CFG);
-	val |= PCIE_PORT_PERST(port->index);
+	val |= PCIE_PORT_PERST(port->slot);
 	writel(val, pcie->base + PCIE_SYS_CFG);
 
 	/* de-assert port PERST_N */
 	val = readl(pcie->base + PCIE_SYS_CFG);
-	val &= ~PCIE_PORT_PERST(port->index);
+	val &= ~PCIE_PORT_PERST(port->slot);
 	writel(val, pcie->base + PCIE_SYS_CFG);
 
 	/* 100ms timeout value should be enough for Gen1/2 training */
@@ -194,7 +194,7 @@ static int mtk_pcie_startup_port(struct mtk_pcie_port *port)
 
 	/* enable interrupt */
 	val = readl(pcie->base + PCIE_INT_ENABLE);
-	val |= PCIE_PORT_INT_EN(port->index);
+	val |= PCIE_PORT_INT_EN(port->slot);
 	writel(val, pcie->base + PCIE_INT_ENABLE);
 
 	/* map to all DDR region. We need to set it before cfg operation. */
@@ -227,14 +227,14 @@ static int mtk_pcie_startup_port(struct mtk_pcie_port *port)
 	return 0;
 }
 
-static void mtk_pcie_enable_ports(struct mtk_pcie_port *port)
+static void mtk_pcie_enable_port(struct mtk_pcie_port *port)
 {
 	struct device *dev = port->pcie->dev;
 	int err;
 
 	err = clk_prepare_enable(port->sys_ck);
 	if (err) {
-		dev_err(dev, "failed to enable port%d clock\n", port->index);
+		dev_err(dev, "failed to enable port%d clock\n", port->slot);
 		goto err_sys_clk;
 	}
 
@@ -243,14 +243,14 @@ static void mtk_pcie_enable_ports(struct mtk_pcie_port *port)
 
 	err = phy_power_on(port->phy);
 	if (err) {
-		dev_err(dev, "failed to power on port%d phy\n", port->index);
+		dev_err(dev, "failed to power on port%d phy\n", port->slot);
 		goto err_phy_on;
 	}
 
 	if (!mtk_pcie_startup_port(port))
 		return;
 
-	dev_info(dev, "Port%d link down\n", port->index);
+	dev_info(dev, "Port%d link down\n", port->slot);
 
 	phy_power_off(port->phy);
 err_phy_on:
@@ -259,9 +259,9 @@ static void mtk_pcie_enable_ports(struct mtk_pcie_port *port)
 	mtk_pcie_port_free(port);
 }
 
-static int mtk_pcie_parse_ports(struct mtk_pcie *pcie,
-				struct device_node *node,
-				int index)
+static int mtk_pcie_parse_port(struct mtk_pcie *pcie,
+			       struct device_node *node,
+			       int slot)
 {
 	struct mtk_pcie_port *port;
 	struct resource *regs;
@@ -280,32 +280,32 @@ static int mtk_pcie_parse_ports(struct mtk_pcie *pcie,
 		return err;
 	}
 
-	regs = platform_get_resource(pdev, IORESOURCE_MEM, index + 1);
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, slot + 1);
 	port->base = devm_ioremap_resource(dev, regs);
 	if (IS_ERR(port->base)) {
-		dev_err(dev, "failed to map port%d base\n", index);
+		dev_err(dev, "failed to map port%d base\n", slot);
 		return PTR_ERR(port->base);
 	}
 
-	snprintf(name, sizeof(name), "sys_ck%d", index);
+	snprintf(name, sizeof(name), "sys_ck%d", slot);
 	port->sys_ck = devm_clk_get(dev, name);
 	if (IS_ERR(port->sys_ck)) {
-		dev_err(dev, "failed to get port%d clock\n", index);
+		dev_err(dev, "failed to get port%d clock\n", slot);
 		return PTR_ERR(port->sys_ck);
 	}
 
-	snprintf(name, sizeof(name), "pcie-rst%d", index);
+	snprintf(name, sizeof(name), "pcie-rst%d", slot);
 	port->reset = devm_reset_control_get_optional_exclusive(dev, name);
 	if (PTR_ERR(port->reset) == -EPROBE_DEFER)
 		return PTR_ERR(port->reset);
 
 	/* some platforms may use default PHY setting */
-	snprintf(name, sizeof(name), "pcie-phy%d", index);
+	snprintf(name, sizeof(name), "pcie-phy%d", slot);
 	port->phy = devm_phy_optional_get(dev, name);
 	if (IS_ERR(port->phy))
 		return PTR_ERR(port->phy);
 
-	port->index = index;
+	port->slot = slot;
 	port->pcie = pcie;
 
 	INIT_LIST_HEAD(&port->list);
@@ -414,7 +414,7 @@ static int mtk_pcie_setup(struct mtk_pcie *pcie)
 	}
 
 	for_each_available_child_of_node(node, child) {
-		int index;
+		int slot;
 
 		err = of_pci_get_devfn(child);
 		if (err < 0) {
@@ -422,9 +422,9 @@ static int mtk_pcie_setup(struct mtk_pcie *pcie)
 			return err;
 		}
 
-		index = PCI_SLOT(err);
+		slot = PCI_SLOT(err);
 
-		err = mtk_pcie_parse_ports(pcie, child, index);
+		err = mtk_pcie_parse_port(pcie, child, slot);
 		if (err)
 			return err;
 	}
@@ -435,7 +435,7 @@ static int mtk_pcie_setup(struct mtk_pcie *pcie)
 
 	/* enable each port, and then check link status */
 	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
-		mtk_pcie_enable_ports(port);
+		mtk_pcie_enable_port(port);
 
 	/* power down PCIe subsys if slots are all empty (link down) */
 	if (list_empty(&pcie->ports))
-- 
2.6.4
