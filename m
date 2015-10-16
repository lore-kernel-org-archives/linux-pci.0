Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1on0139.outbound.protection.outlook.com ([157.56.110.139]:16790
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752370AbbJPHSp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 16 Oct 2015 03:18:45 -0400
From: Minghuan Lian <Minghuan.Lian@freescale.com>
To: <linux-pci@vger.kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>,
	Zang Roy-R61911 <r61911@freescale.com>,
	Hu Mingkai-B21284 <B21284@freescale.com>,
	"Yoder Stuart-B08248" <stuart.yoder@freescale.com>,
	Li Yang <leoli@freescale.com>, Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Jingoo Han" <jg1.han@samsung.com>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	"Minghuan Lian" <Minghuan.Lian@freescale.com>
Subject: [PATCH v4 3/6] PCI: layerscape: factor out SCFG related function
Date: Fri, 16 Oct 2015 15:19:17 +0800
Message-ID: <1444979960-24100-3-git-send-email-Minghuan.Lian@freescale.com>
In-Reply-To: <1444979960-24100-1-git-send-email-Minghuan.Lian@freescale.com>
References: <1444979960-24100-1-git-send-email-Minghuan.Lian@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

For LS1021a PCIe controller, some status registers are located
in SCFG. This is different to other kind of Layerscape. The
patch moves SCFG related code to ls1021_pcie_host_init() and
rename ls_pcie_link_up to ls1021_pcie_link_up because LTSSM
status is also in SCFG.

Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
---
Change log
v4: split from [PATCH v3] PCI: layerscape: Add PCIe support for LS1043a and LS2080a

 drivers/pci/host/pci-layerscape.c | 72 +++++++++++++++++++++++++--------------
 1 file changed, 46 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
index 5eabe92..89b7eb8 100644
--- a/drivers/pci/host/pci-layerscape.c
+++ b/drivers/pci/host/pci-layerscape.c
@@ -34,6 +34,10 @@
 /* Symbol Timer Register and Filter Mask Register 1 */
 #define PCIE_STRFMR1 0x71c
 
+struct ls_pcie_drvdata {
+	struct pcie_host_ops *ops;
+};
+
 struct ls_pcie {
 	struct list_head node;
 	struct device *dev;
@@ -41,6 +45,7 @@ struct ls_pcie {
 	void __iomem *dbi;
 	struct regmap *scfg;
 	struct pcie_port pp;
+	const struct ls_pcie_drvdata *drvdata;
 	int index;
 	int msi_irq;
 };
@@ -57,11 +62,14 @@ static bool ls_pcie_is_bridge(struct ls_pcie *pcie)
 	return header_type == PCI_HEADER_TYPE_BRIDGE;
 }
 
-static int ls_pcie_link_up(struct pcie_port *pp)
+static int ls1021_pcie_link_up(struct pcie_port *pp)
 {
 	u32 state;
 	struct ls_pcie *pcie = to_ls_pcie(pp);
 
+	if (!pcie->scfg)
+		return 0;
+
 	regmap_read(pcie->scfg, SCFG_PEXMSCPORTSR(pcie->index), &state);
 	state = (state >> LTSSM_STATE_SHIFT) & LTSSM_STATE_MASK;
 
@@ -71,10 +79,25 @@ static int ls_pcie_link_up(struct pcie_port *pp)
 	return 1;
 }
 
-static void ls_pcie_host_init(struct pcie_port *pp)
+static void ls1021_pcie_host_init(struct pcie_port *pp)
 {
 	struct ls_pcie *pcie = to_ls_pcie(pp);
-	u32 val;
+	u32 val, index[2];
+
+	pcie->scfg = syscon_regmap_lookup_by_phandle(pp->dev->of_node,
+						     "fsl,pcie-scfg");
+	if (IS_ERR(pcie->scfg)) {
+		dev_err(pp->dev, "No syscfg phandle specified\n");
+		pcie->scfg = NULL;
+		return;
+	}
+
+	if (of_property_read_u32_array(pp->dev->of_node,
+				       "fsl,pcie-scfg", index, 2)) {
+		pcie->scfg = NULL;
+		return;
+	}
+	pcie->index = index[1];
 
 	dw_pcie_setup_rc(pp);
 
@@ -87,11 +110,21 @@ static void ls_pcie_host_init(struct pcie_port *pp)
 	iowrite32(val, pcie->dbi + PCIE_STRFMR1);
 }
 
-static struct pcie_host_ops ls_pcie_host_ops = {
-	.link_up = ls_pcie_link_up,
-	.host_init = ls_pcie_host_init,
+static struct pcie_host_ops ls1021_pcie_host_ops = {
+	.link_up = ls1021_pcie_link_up,
+	.host_init = ls1021_pcie_host_init,
+};
+
+static struct ls_pcie_drvdata ls1021_drvdata = {
+	.ops = &ls1021_pcie_host_ops,
 };
 
+static const struct of_device_id ls_pcie_of_match[] = {
+	{ .compatible = "fsl,ls1021a-pcie", .data = &ls1021_drvdata },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ls_pcie_of_match);
+
 static int ls_add_pcie_port(struct ls_pcie *pcie)
 {
 	struct pcie_port *pp;
@@ -101,7 +134,7 @@ static int ls_add_pcie_port(struct ls_pcie *pcie)
 	pp->dev = pcie->dev;
 	pp->dbi_base = pcie->dbi;
 	pp->root_bus_nr = -1;
-	pp->ops = &ls_pcie_host_ops;
+	pp->ops = pcie->drvdata->ops;
 
 	ret = dw_pcie_host_init(pp);
 	if (ret) {
@@ -114,11 +147,15 @@ static int ls_add_pcie_port(struct ls_pcie *pcie)
 
 static int __init ls_pcie_probe(struct platform_device *pdev)
 {
+	const struct of_device_id *match;
 	struct ls_pcie *pcie;
 	struct resource *dbi_base;
-	u32 index[2];
 	int ret;
 
+	match = of_match_device(ls_pcie_of_match, &pdev->dev);
+	if (!match)
+		return -ENODEV;
+
 	pcie = devm_kzalloc(&pdev->dev, sizeof(*pcie), GFP_KERNEL);
 	if (!pcie)
 		return -ENOMEM;
@@ -132,18 +169,7 @@ static int __init ls_pcie_probe(struct platform_device *pdev)
 		return PTR_ERR(pcie->dbi);
 	}
 
-	pcie->scfg = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
-						     "fsl,pcie-scfg");
-	if (IS_ERR(pcie->scfg)) {
-		dev_err(&pdev->dev, "No syscfg phandle specified\n");
-		return PTR_ERR(pcie->scfg);
-	}
-
-	ret = of_property_read_u32_array(pdev->dev.of_node,
-					 "fsl,pcie-scfg", index, 2);
-	if (ret)
-		return ret;
-	pcie->index = index[1];
+	pcie->drvdata = match->data;
 
 	if (!ls_pcie_is_bridge(pcie))
 		return -ENODEV;
@@ -157,12 +183,6 @@ static int __init ls_pcie_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id ls_pcie_of_match[] = {
-	{ .compatible = "fsl,ls1021a-pcie" },
-	{ },
-};
-MODULE_DEVICE_TABLE(of, ls_pcie_of_match);
-
 static struct platform_driver ls_pcie_driver = {
 	.driver = {
 		.name = "layerscape-pcie",
-- 
1.9.1

