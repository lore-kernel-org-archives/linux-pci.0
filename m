Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:21023 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752305AbdHJGfL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Aug 2017 02:35:11 -0400
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
Subject: [PATCH v4 3/7] PCI: mediatek: Add a structure to abstract the controller generations
Date: Thu, 10 Aug 2017 14:34:56 +0800
Message-ID: <e60b42e3830ba65b3b1599fd25880bc244ccb752.1502336769.git.honghui.zhang@mediatek.com>
In-Reply-To: <cover.1502336769.git.honghui.zhang@mediatek.com>
References: <cover.1502336769.git.honghui.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Honghui Zhang <honghui.zhang@mediatek.com>

Introduce a structure "mtk_pcie_soc" to abstract the differences between
controller generations, and the .startup() hook is used to encapsulate
some SoC-dependent related setting. In doing so, the common code which
will be reused by future chips.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
---
 drivers/pci/host/pcie-mediatek.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/host/pcie-mediatek.c b/drivers/pci/host/pcie-mediatek.c
index 7d1b7cd..01caa98 100644
--- a/drivers/pci/host/pcie-mediatek.c
+++ b/drivers/pci/host/pcie-mediatek.c
@@ -64,6 +64,18 @@
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
@@ -97,6 +109,7 @@ struct mtk_pcie_port {
  * @busn: bus range
  * @offset: IO / Memory offset
  * @ports: pointer to PCIe port information
+ * @soc: pointer to SoC-dependent operations
  */
 struct mtk_pcie {
 	struct device *dev;
@@ -112,6 +125,7 @@ struct mtk_pcie {
 		resource_size_t io;
 	} offset;
 	struct list_head ports;
+	const struct mtk_pcie_soc *soc;
 };
 
 static void mtk_pcie_subsys_powerdown(struct mtk_pcie *pcie)
@@ -229,7 +243,8 @@ static int mtk_pcie_startup_port(struct mtk_pcie_port *port)
 
 static void mtk_pcie_enable_port(struct mtk_pcie_port *port)
 {
-	struct device *dev = port->pcie->dev;
+	struct mtk_pcie *pcie = port->pcie;
+	struct device *dev = pcie->dev;
 	int err;
 
 	err = clk_prepare_enable(port->sys_ck);
@@ -247,7 +262,7 @@ static void mtk_pcie_enable_port(struct mtk_pcie_port *port)
 		goto err_phy_on;
 	}
 
-	if (!mtk_pcie_startup_port(port))
+	if (!pcie->soc->startup(port))
 		return;
 
 	dev_info(dev, "Port%d link down\n", port->slot);
@@ -472,7 +487,7 @@ static int mtk_pcie_register_host(struct pci_host_bridge *host)
 
 	host->busnr = pcie->busn.start;
 	host->dev.parent = pcie->dev;
-	host->ops = &mtk_pcie_ops;
+	host->ops = pcie->soc->ops;
 	host->map_irq = of_irq_parse_and_map_pci;
 	host->swizzle_irq = pci_common_swizzle;
 
@@ -505,6 +520,7 @@ static int mtk_pcie_probe(struct platform_device *pdev)
 	pcie = pci_host_bridge_priv(host);
 
 	pcie->dev = dev;
+	pcie->soc = of_device_get_match_data(dev);
 	platform_set_drvdata(pdev, pcie);
 	INIT_LIST_HEAD(&pcie->ports);
 
@@ -529,9 +545,14 @@ static int mtk_pcie_probe(struct platform_device *pdev)
 	return err;
 }
 
+static const struct mtk_pcie_soc mtk_pcie_soc_v1 = {
+	.ops = &mtk_pcie_ops,
+	.startup = mtk_pcie_startup_port,
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
