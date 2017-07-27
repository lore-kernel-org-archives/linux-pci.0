Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:5974 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751638AbdG0C6z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Jul 2017 22:58:55 -0400
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
Subject: [PATCH v2 1/5] PCI: mediatek: Add a structure to abstract the controller generations
Date: Thu, 27 Jul 2017 10:58:35 +0800
Message-ID: <948f9bd0881402d13e6913ad425e7dff50f3fcfc.1501122135.git.honghui.zhang@mediatek.com>
In-Reply-To: <cover.1501122135.git.honghui.zhang@mediatek.com>
References: <cover.1501122135.git.honghui.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Ryder Lee <ryder.lee@mediatek.com>

Introduce a structure "mtk_pcie_soc" to abstract the differences between
controller generations, and the .startup() hook is used to encapsulate
some SoC-dependent related setting. In doing so, the common code which
will be reused by future chips.

In addition, we change the approaches to waiting Gen2 training by using
readl_poll_timeout() calls.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
---
 drivers/pci/host/pcie-mediatek.c | 81 +++++++++++++++++++++++-----------------
 1 file changed, 47 insertions(+), 34 deletions(-)

diff --git a/drivers/pci/host/pcie-mediatek.c b/drivers/pci/host/pcie-mediatek.c
index 5a9d858..7f952a4 100644
--- a/drivers/pci/host/pcie-mediatek.c
+++ b/drivers/pci/host/pcie-mediatek.c
@@ -16,6 +16,7 @@
 
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
@@ -63,6 +64,18 @@
 #define PCIE_FC_CREDIT_MASK	(GENMASK(31, 31) | GENMASK(28, 16))
 #define PCIE_FC_CREDIT_VAL(x)	((x) << 16)
 
+struct mtk_pcie_port;
+
+/**
+ * struct mtk_pcie_soc - differentiate between host generations
+ * @ops: pointer to configuration access functions
+ * @startup: pointer to controller setting functions
+ */
+struct mtk_pcie_soc {
+	struct pci_ops *ops;
+	int (*startup)(struct mtk_pcie_port *port);
+};
+
 /**
  * struct mtk_pcie_port - PCIe port information
  * @base: IO mapped register base
@@ -96,6 +109,7 @@ struct mtk_pcie_port {
  * @busn: bus range
  * @offset: IO / Memory offset
  * @ports: pointer to PCIe port information
+ * @soc: pointer to SoC-dependent operations
  */
 struct mtk_pcie {
 	struct device *dev;
@@ -111,13 +125,9 @@ struct mtk_pcie {
 		resource_size_t io;
 	} offset;
 	struct list_head ports;
+	const struct mtk_pcie_soc *soc;
 };
 
-static inline bool mtk_pcie_link_up(struct mtk_pcie_port *port)
-{
-	return !!(readl(port->base + PCIE_LINK_STATUS) & PCIE_PORT_LINKUP);
-}
-
 static void mtk_pcie_subsys_powerdown(struct mtk_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
@@ -171,12 +181,30 @@ static struct pci_ops mtk_pcie_ops = {
 	.write = pci_generic_config_write,
 };
 
-static void mtk_pcie_configure_rc(struct mtk_pcie_port *port)
+static int mtk_pcie_startup_ports(struct mtk_pcie_port *port)
 {
 	struct mtk_pcie *pcie = port->pcie;
 	u32 func = PCI_FUNC(port->index << 3);
 	u32 slot = PCI_SLOT(port->index << 3);
 	u32 val;
+	int err;
+
+	/* assert port PERST_N */
+	val = readl(pcie->base + PCIE_SYS_CFG);
+	val |= PCIE_PORT_PERST(port->index);
+	writel(val, pcie->base + PCIE_SYS_CFG);
+
+	/* de-assert port PERST_N */
+	val = readl(pcie->base + PCIE_SYS_CFG);
+	val &= ~PCIE_PORT_PERST(port->index);
+	writel(val, pcie->base + PCIE_SYS_CFG);
+
+	/* 100ms timeout value should be enough for Gen1/2 training */
+	err = readl_poll_timeout(port->base + PCIE_LINK_STATUS, val,
+				 !!(val & PCIE_PORT_LINKUP), 20,
+				 100 * USEC_PER_MSEC);
+	if (err)
+		return -ETIMEDOUT;
 
 	/* enable interrupt */
 	val = readl(pcie->base + PCIE_INT_ENABLE);
@@ -209,30 +237,14 @@ static void mtk_pcie_configure_rc(struct mtk_pcie_port *port)
 	writel(PCIE_CONF_ADDR(PCIE_FTS_NUM, func, slot, 0),
 	       pcie->base + PCIE_CFG_ADDR);
 	writel(val, pcie->base + PCIE_CFG_DATA);
-}
 
-static void mtk_pcie_assert_ports(struct mtk_pcie_port *port)
-{
-	struct mtk_pcie *pcie = port->pcie;
-	u32 val;
-
-	/* assert port PERST_N */
-	val = readl(pcie->base + PCIE_SYS_CFG);
-	val |= PCIE_PORT_PERST(port->index);
-	writel(val, pcie->base + PCIE_SYS_CFG);
-
-	/* de-assert port PERST_N */
-	val = readl(pcie->base + PCIE_SYS_CFG);
-	val &= ~PCIE_PORT_PERST(port->index);
-	writel(val, pcie->base + PCIE_SYS_CFG);
-
-	/* PCIe v2.0 need at least 100ms delay to train from Gen1 to Gen2 */
-	msleep(100);
+	return 0;
 }
 
 static void mtk_pcie_enable_ports(struct mtk_pcie_port *port)
 {
-	struct device *dev = port->pcie->dev;
+	struct mtk_pcie *pcie = port->pcie;
+	struct device *dev = pcie->dev;
 	int err;
 
 	err = clk_prepare_enable(port->sys_ck);
@@ -250,13 +262,8 @@ static void mtk_pcie_enable_ports(struct mtk_pcie_port *port)
 		goto err_phy_on;
 	}
 
-	mtk_pcie_assert_ports(port);
-
-	/* if link up, then setup root port configuration space */
-	if (mtk_pcie_link_up(port)) {
-		mtk_pcie_configure_rc(port);
+	if (!pcie->soc->startup(port))
 		return;
-	}
 
 	dev_info(dev, "Port%d link down\n", port->index);
 
@@ -480,7 +487,7 @@ static int mtk_pcie_register_host(struct pci_host_bridge *host)
 
 	host->busnr = pcie->busn.start;
 	host->dev.parent = pcie->dev;
-	host->ops = &mtk_pcie_ops;
+	host->ops = pcie->soc->ops;
 	host->map_irq = of_irq_parse_and_map_pci;
 	host->swizzle_irq = pci_common_swizzle;
 
@@ -513,6 +520,7 @@ static int mtk_pcie_probe(struct platform_device *pdev)
 	pcie = pci_host_bridge_priv(host);
 
 	pcie->dev = dev;
+	pcie->soc = of_device_get_match_data(dev);
 	platform_set_drvdata(pdev, pcie);
 	INIT_LIST_HEAD(&pcie->ports);
 
@@ -537,9 +545,14 @@ static int mtk_pcie_probe(struct platform_device *pdev)
 	return err;
 }
 
+static struct mtk_pcie_soc mtk_pcie_soc_v1 = {
+	.ops = &mtk_pcie_ops,
+	.startup = mtk_pcie_startup_ports,
+};
+
 static const struct of_device_id mtk_pcie_ids[] = {
-	{ .compatible = "mediatek,mt7623-pcie"},
-	{ .compatible = "mediatek,mt2701-pcie"},
+	{ .compatible = "mediatek,mt2701-pcie", .data = &mtk_pcie_soc_v1 },
+	{ .compatible = "mediatek,mt7623-pcie", .data = &mtk_pcie_soc_v1 },
 	{},
 };
 
-- 
2.6.4
