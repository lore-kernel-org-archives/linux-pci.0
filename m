Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2on0122.outbound.protection.outlook.com ([207.46.100.122]:47457
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750775AbbJJGW6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sat, 10 Oct 2015 02:22:58 -0400
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
Subject: [PATCH v3] PCI: layerscape: Add PCIe support for LS1043a and LS2080a
Date: Sat, 10 Oct 2015 14:23:37 +0800
Message-ID: <1444458217-31004-1-git-send-email-Minghuan.Lian@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The patch adds PCIe support for LS1043a and LS2080a.

Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
---
This patch is based on v4.3-rc4 and [PATCH v10 3/6]
PCI: designware: Add ARM64 support.

change log
v3:
1. Use 8 or 16 bit access function to simplify code
2. Add ls_add_pcie_port in accordance with other DesignWare-based drivers

v2:
1. Rename ls2085a to ls2080a
2. Add ls_pcie_msi_host_init()

 drivers/pci/host/Kconfig          |   2 +-
 drivers/pci/host/pci-layerscape.c | 215 +++++++++++++++++++++++++++-----------
 2 files changed, 153 insertions(+), 64 deletions(-)

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index d5e58ba..b5f1a3b 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -105,7 +105,7 @@ config PCI_XGENE_MSI
 
 config PCI_LAYERSCAPE
 	bool "Freescale Layerscape PCIe controller"
-	depends on OF && ARM
+	depends on OF && (ARM || ARM64)
 	select PCIE_DW
 	select MFD_SYSCON
 	help
diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
index b2328ea1..024727f 100644
--- a/drivers/pci/host/pci-layerscape.c
+++ b/drivers/pci/host/pci-layerscape.c
@@ -11,7 +11,6 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/of_pci.h>
@@ -32,27 +31,60 @@
 #define LTSSM_STATE_MASK	0x3f
 #define LTSSM_PCIE_L0		0x11 /* L0 state */
 
-/* Symbol Timer Register and Filter Mask Register 1 */
-#define PCIE_STRFMR1 0x71c
+/* PEX Internal Configuration Registers */
+#define PCIE_STRFMR1		0x71c /* Symbol Timer & Filter Mask Register1 */
+#define PCIE_DBI_RO_WR_EN	0x8bc /* DBI Read-Only Write Enable Register */
+
+/* PEX LUT registers */
+#define PCIE_LUT_DBG		0x7FC /* PEX LUT Debug Register */
+
+struct ls_pcie_drvdata {
+	u32 lut_offset;
+	u32 ltssm_shift;
+	struct pcie_host_ops *ops;
+};
 
 struct ls_pcie {
-	struct list_head node;
-	struct device *dev;
-	struct pci_bus *bus;
-	void __iomem *dbi;
-	struct regmap *scfg;
 	struct pcie_port pp;
+	const struct ls_pcie_drvdata *drvdata;
+	void __iomem *regs;
+	void __iomem *lut;
+	struct regmap *scfg;
 	int index;
-	int msi_irq;
 };
 
 #define to_ls_pcie(x)	container_of(x, struct ls_pcie, pp)
 
-static int ls_pcie_link_up(struct pcie_port *pp)
+static bool ls_pcie_is_bridge(struct ls_pcie *pcie)
+{
+	u32 header_type;
+
+	header_type = ioread8(pcie->regs + PCI_HEADER_TYPE);
+	header_type &= 0x7f;
+
+	return header_type == PCI_HEADER_TYPE_BRIDGE;
+}
+
+/* Clear multi-function bit */
+static void ls_pcie_clear_multifunction(struct ls_pcie *pcie)
+{
+	iowrite8(PCI_HEADER_TYPE_BRIDGE, pcie->regs + PCI_HEADER_TYPE);
+}
+
+/* Fix class value */
+static void ls_pcie_fix_class(struct ls_pcie *pcie)
+{
+	iowrite16(PCI_CLASS_BRIDGE_PCI, pcie->regs + PCI_CLASS_DEVICE);
+}
+
+static int ls1021_pcie_link_up(struct pcie_port *pp)
 {
 	u32 state;
 	struct ls_pcie *pcie = to_ls_pcie(pp);
 
+	if (!pcie->scfg)
+		return 0;
+
 	regmap_read(pcie->scfg, SCFG_PEXMSCPORTSR(pcie->index), &state);
 	state = (state >> LTSSM_STATE_SHIFT) & LTSSM_STATE_MASK;
 
@@ -62,56 +94,124 @@ static int ls_pcie_link_up(struct pcie_port *pp)
 	return 1;
 }
 
-static int ls_pcie_establish_link(struct pcie_port *pp)
+static void ls1021_pcie_host_init(struct pcie_port *pp)
 {
-	unsigned int retries;
+	struct ls_pcie *pcie = to_ls_pcie(pp);
+	u32 val, index[2];
 
-	for (retries = 0; retries < 200; retries++) {
-		if (dw_pcie_link_up(pp))
-			return 0;
-		usleep_range(100, 1000);
+	pcie->scfg = syscon_regmap_lookup_by_phandle(pp->dev->of_node,
+						     "fsl,pcie-scfg");
+	if (IS_ERR(pcie->scfg)) {
+		dev_err(pp->dev, "No syscfg phandle specified\n");
+		pcie->scfg = NULL;
+		return;
 	}
 
-	dev_err(pp->dev, "phy link never came up\n");
-	return -EINVAL;
+	if (of_property_read_u32_array(pp->dev->of_node,
+				       "fsl,pcie-scfg", index, 2)) {
+		pcie->scfg = NULL;
+		return;
+	}
+	pcie->index = index[1];
+
+	/*
+	 * LS1021A Workaround for internal TKT228622
+	 * to fix the INTx hang issue
+	 */
+	val = ioread32(pcie->regs + PCIE_STRFMR1);
+	val &= 0xffff;
+	iowrite32(val, pcie->regs + PCIE_STRFMR1);
+}
+
+static int ls_pcie_link_up(struct pcie_port *pp)
+{
+	struct ls_pcie *pcie = to_ls_pcie(pp);
+	u32 state;
+
+	state = (ioread32(pcie->lut + PCIE_LUT_DBG) >>
+		 pcie->drvdata->ltssm_shift) &
+		 LTSSM_STATE_MASK;
+
+	if (state < LTSSM_PCIE_L0)
+		return 0;
+
+	return 1;
 }
 
 static void ls_pcie_host_init(struct pcie_port *pp)
 {
 	struct ls_pcie *pcie = to_ls_pcie(pp);
-	u32 val;
 
-	dw_pcie_setup_rc(pp);
-	ls_pcie_establish_link(pp);
+	iowrite32(1, pcie->regs + PCIE_DBI_RO_WR_EN);
+	ls_pcie_fix_class(pcie);
+	ls_pcie_clear_multifunction(pcie);
+	iowrite32(0, pcie->regs + PCIE_DBI_RO_WR_EN);
+}
 
-	/*
-	 * LS1021A Workaround for internal TKT228622
-	 * to fix the INTx hang issue
-	 */
-	val = ioread32(pcie->dbi + PCIE_STRFMR1);
-	val &= 0xffff;
-	iowrite32(val, pcie->dbi + PCIE_STRFMR1);
+static int ls_pcie_msi_host_init(struct pcie_port *pp,
+				 struct msi_controller *chip)
+{
+	struct device_node *msi_node;
+	struct device_node *np = pp->dev->of_node;
+
+	msi_node = of_parse_phandle(np, "msi-parent", 0);
+	if (!msi_node) {
+		dev_err(pp->dev, "failed to find msi-parent\n");
+		return -EINVAL;
+	}
+
+	return 0;
 }
 
+static struct pcie_host_ops ls1021_pcie_host_ops = {
+	.link_up = ls1021_pcie_link_up,
+	.host_init = ls1021_pcie_host_init,
+	.msi_host_init = ls_pcie_msi_host_init,
+};
+
 static struct pcie_host_ops ls_pcie_host_ops = {
 	.link_up = ls_pcie_link_up,
 	.host_init = ls_pcie_host_init,
+	.msi_host_init = ls_pcie_msi_host_init,
+};
+
+static struct ls_pcie_drvdata ls1021_drvdata = {
+	.ops = &ls1021_pcie_host_ops,
+};
+
+static struct ls_pcie_drvdata ls1043_drvdata = {
+	.lut_offset = 0x10000,
+	.ltssm_shift = 24,
+	.ops = &ls_pcie_host_ops,
+};
+
+static struct ls_pcie_drvdata ls2080_drvdata = {
+	.lut_offset = 0x80000,
+	.ltssm_shift = 0,
+	.ops = &ls_pcie_host_ops,
 };
 
-static int ls_add_pcie_port(struct ls_pcie *pcie)
+static const struct of_device_id ls_pcie_of_match[] = {
+	{ .compatible = "fsl,ls1021a-pcie", .data = &ls1021_drvdata },
+	{ .compatible = "fsl,ls1043a-pcie", .data = &ls1043_drvdata },
+	{ .compatible = "fsl,ls2080a-pcie", .data = &ls2080_drvdata },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ls_pcie_of_match);
+
+static int __init ls_add_pcie_port(struct pcie_port *pp,
+				   struct platform_device *pdev)
 {
-	struct pcie_port *pp;
 	int ret;
+	struct ls_pcie *pcie = to_ls_pcie(pp);
 
-	pp = &pcie->pp;
-	pp->dev = pcie->dev;
-	pp->dbi_base = pcie->dbi;
-	pp->root_bus_nr = -1;
-	pp->ops = &ls_pcie_host_ops;
+	pp->dev = &pdev->dev;
+	pp->dbi_base = pcie->regs;
+	pp->ops = pcie->drvdata->ops;
 
 	ret = dw_pcie_host_init(pp);
 	if (ret) {
-		dev_err(pp->dev, "failed to initialize host\n");
+		dev_err(&pdev->dev, "failed to initialize host\n");
 		return ret;
 	}
 
@@ -120,39 +220,34 @@ static int ls_add_pcie_port(struct ls_pcie *pcie)
 
 static int __init ls_pcie_probe(struct platform_device *pdev)
 {
+	const struct of_device_id *match;
 	struct ls_pcie *pcie;
-	struct resource *dbi_base;
-	u32 index[2];
+	struct resource *res;
 	int ret;
 
+	match = of_match_device(ls_pcie_of_match, &pdev->dev);
+	if (!match)
+		return -ENODEV;
+
 	pcie = devm_kzalloc(&pdev->dev, sizeof(*pcie), GFP_KERNEL);
 	if (!pcie)
 		return -ENOMEM;
 
-	pcie->dev = &pdev->dev;
-
-	dbi_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
-	pcie->dbi = devm_ioremap_resource(&pdev->dev, dbi_base);
-	if (IS_ERR(pcie->dbi)) {
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
+	pcie->regs = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(pcie->regs)) {
 		dev_err(&pdev->dev, "missing *regs* space\n");
-		return PTR_ERR(pcie->dbi);
+		return PTR_ERR(pcie->regs);
 	}
 
-	pcie->scfg = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
-						     "fsl,pcie-scfg");
-	if (IS_ERR(pcie->scfg)) {
-		dev_err(&pdev->dev, "No syscfg phandle specified\n");
-		return PTR_ERR(pcie->scfg);
-	}
+	pcie->drvdata = match->data;
+	pcie->lut = pcie->regs + pcie->drvdata->lut_offset;
 
-	ret = of_property_read_u32_array(pdev->dev.of_node,
-					 "fsl,pcie-scfg", index, 2);
-	if (ret)
-		return ret;
-	pcie->index = index[1];
+	if (!ls_pcie_is_bridge(pcie))
+		return -ENODEV;
 
-	ret = ls_add_pcie_port(pcie);
-	if (ret < 0)
+	ret = ls_add_pcie_port(&pcie->pp, pdev);
+	if (ret)
 		return ret;
 
 	platform_set_drvdata(pdev, pcie);
@@ -160,12 +255,6 @@ static int __init ls_pcie_probe(struct platform_device *pdev)
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

