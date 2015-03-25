Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bon0115.outbound.protection.outlook.com ([157.56.111.115]:1798
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751916AbbCYHOc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 25 Mar 2015 03:14:32 -0400
From: Minghuan Lian <Minghuan.Lian@freescale.com>
To: <linux-pci@vger.kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>,
	Zang Roy-R61911 <r61911@freescale.com>,
	Hu Mingkai-B21284 <B21284@freescale.com>,
	Scott Wood <scottwood@freescale.com>,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Jingoo Han" <jg1.han@samsung.com>,
	Minghuan Lian <Minghuan.Lian@freescale.com>
Subject: [PATCH 3/3] pci/layerscape: Add LS2085A PCIe support
Date: Wed, 25 Mar 2015 14:42:41 +0800
Message-ID: <1427265761-31828-4-git-send-email-Minghuan.Lian@freescale.com>
In-Reply-To: <1427265761-31828-1-git-send-email-Minghuan.Lian@freescale.com>
References: <1427265761-31828-1-git-send-email-Minghuan.Lian@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

LS2085a is based on arm64 architecture, however, currently,
layerscape PCIe driver based on pci-desginware.c is not
compatible with arm64 architecture. The patch changes code
to reuse PCIe Designware Base driver and provides LS2085a
PCIe support.

Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
---
 drivers/pci/host/Kconfig                |   4 +-
 drivers/pci/host/pci-layerscape.c       | 188 +++++++++++++++++++-------------
 drivers/pci/host/pcie-designware-base.h |   3 +
 3 files changed, 115 insertions(+), 80 deletions(-)

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index f883d47..796e58f 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -99,8 +99,8 @@ config PCI_XGENE
 
 config PCI_LAYERSCAPE
 	bool "Freescale Layerscape PCIe controller"
-	depends on OF && ARM
-	select PCIE_DW
+	depends on OF && (ARM || ARM64)
+	select PCIE_DW_BASE
 	select MFD_SYSCON
 	help
 	  Say Y here if you want PCIe controller support on Layerscape SoCs.
diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
index 68c9e5e..ca64f6a 100644
--- a/drivers/pci/host/pci-layerscape.c
+++ b/drivers/pci/host/pci-layerscape.c
@@ -1,7 +1,7 @@
 /*
  * PCIe host controller driver for Freescale Layerscape SoCs
  *
- * Copyright (C) 2014 Freescale Semiconductor.
+ * Copyright (C) 2014 - 2015 Freescale Semiconductor.
  *
   * Author: Minghuan Lian <Minghuan.Lian@freescale.com>
  *
@@ -11,20 +11,16 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/delay.h>
-#include <linux/interrupt.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of_pci.h>
 #include <linux/of_platform.h>
-#include <linux/of_irq.h>
-#include <linux/of_address.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
-#include <linux/resource.h>
-#include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
+#include <linux/resource.h>
 
-#include "pcie-designware.h"
+#include "pcie-designware-base.h"
 
 /* PEX1/2 Misc Ports Status Register */
 #define SCFG_PEXMSCPORTSR(pex_idx)	(0x94 + (pex_idx) * 4)
@@ -32,26 +28,29 @@
 #define LTSSM_STATE_MASK	0x3f
 #define LTSSM_PCIE_L0		0x11 /* L0 state */
 
-/* Symbol Timer Register and Filter Mask Register 1 */
-#define PCIE_STRFMR1 0x71c
+/* PEX LUT registers */
+#define PCIE_LUT_BASE		0x80000
+#define PCIE_LUT_DBG		0x7FC /* PEX LUT Debug register */
+
+#define PCIE_ATU_NUM		6
 
 struct ls_pcie {
-	struct list_head node;
-	struct device *dev;
-	struct pci_bus *bus;
-	void __iomem *dbi;
-	struct regmap *scfg;
-	struct pcie_port pp;
-	int index;
-	int msi_irq;
+	struct dw_pcie_port	pp;
+	void __iomem		*regs;
+	void __iomem		*lut;
+	struct regmap		*scfg;
+	int			index;
 };
 
 #define to_ls_pcie(x)	container_of(x, struct ls_pcie, pp)
 
-static int ls_pcie_link_up(struct pcie_port *pp)
+static int ls1_pcie_link_up(struct dw_pcie_port *pp)
 {
-	u32 state;
 	struct ls_pcie *pcie = to_ls_pcie(pp);
+	u32 state;
+
+	if (!pcie->scfg)
+		return 0;
 
 	regmap_read(pcie->scfg, SCFG_PEXMSCPORTSR(pcie->index), &state);
 	state = (state >> LTSSM_STATE_SHIFT) & LTSSM_STATE_MASK;
@@ -62,94 +61,133 @@ static int ls_pcie_link_up(struct pcie_port *pp)
 	return 1;
 }
 
-static void ls_pcie_host_init(struct pcie_port *pp)
+static int ls1_pcie_host_init(struct dw_pcie_port *pp)
 {
 	struct ls_pcie *pcie = to_ls_pcie(pp);
-	int count = 0;
-	u32 val;
-
-	dw_pcie_setup_rc(pp);
+	u32 val, index[2];
+	int ret;
 
-	while (!ls_pcie_link_up(pp)) {
-		usleep_range(100, 1000);
-		count++;
-		if (count >= 200) {
-			dev_err(pp->dev, "phy link never came up\n");
-			return;
-		}
+	pcie->scfg = syscon_regmap_lookup_by_phandle(pp->dev->of_node,
+						     "fsl,pcie-scfg");
+	if (IS_ERR(pcie->scfg)) {
+		dev_err(pp->dev, "No syscfg phandle specified\n");
+		return PTR_ERR(pcie->scfg);
 	}
 
+	ret = of_property_read_u32_array(pp->dev->of_node,
+					 "fsl,pcie-scfg", index, 2);
+	if (ret)
+		return ret;
+
+	pcie->index = index[1];
+
 	/*
 	 * LS1021A Workaround for internal TKT228622
 	 * to fix the INTx hang issue
 	 */
-	val = ioread32(pcie->dbi + PCIE_STRFMR1);
+	val = dw_pcie_dbi_read(pp, PCIE_SYMBOL_TIMER_1);
 	val &= 0xffff;
-	iowrite32(val, pcie->dbi + PCIE_STRFMR1);
+	dw_pcie_dbi_write(pp, val, PCIE_SYMBOL_TIMER_1);
+
+	/* Fix class value */
+	val = dw_pcie_dbi_read(pp, PCI_CLASS_REVISION);
+	val = (val & 0x0000ffff) | (PCI_CLASS_BRIDGE_PCI << 16);
+	dw_pcie_dbi_write(pp, val, PCI_CLASS_REVISION);
+
+	if (!ls1_pcie_link_up(pp))
+		dev_err(pp->dev, "phy link never came up\n");
+
+	return 0;
 }
 
-static struct pcie_host_ops ls_pcie_host_ops = {
-	.link_up = ls_pcie_link_up,
-	.host_init = ls_pcie_host_init,
+static struct dw_host_ops ls1_dw_host_ops = {
+	.link_up = ls1_pcie_link_up,
+	.host_init = ls1_pcie_host_init,
 };
 
-static int ls_add_pcie_port(struct ls_pcie *pcie)
+static int ls2_pcie_link_up(struct dw_pcie_port *pp)
 {
-	struct pcie_port *pp;
-	int ret;
+	struct ls_pcie *pcie = to_ls_pcie(pp);
+	u32 state;
 
-	pp = &pcie->pp;
-	pp->dev = pcie->dev;
-	pp->dbi_base = pcie->dbi;
-	pp->root_bus_nr = -1;
-	pp->ops = &ls_pcie_host_ops;
+	if (!pcie->lut)
+		return 0;
 
-	ret = dw_pcie_host_init(pp);
-	if (ret) {
-		dev_err(pp->dev, "failed to initialize host\n");
-		return ret;
-	}
+	state = ioread32(pcie->lut + PCIE_LUT_DBG) & LTSSM_STATE_MASK;
+	if (state < LTSSM_PCIE_L0)
+		return 0;
+
+	return 1;
+}
+
+static int ls2_pcie_host_init(struct dw_pcie_port *pp)
+{
+	struct ls_pcie *pcie = to_ls_pcie(pp);
+	u32 val;
+
+	pcie->lut = pp->dbi + PCIE_LUT_BASE;
+
+	dw_pcie_dbi_write(pp, 1, PCIE_DBI_RO_WR_EN);
+	/* Fix class value */
+	val = dw_pcie_dbi_read(pp, PCI_CLASS_REVISION);
+	val = (val & 0x0000ffff) | (PCI_CLASS_BRIDGE_PCI << 16);
+	dw_pcie_dbi_write(pp, val, PCI_CLASS_REVISION);
+	/* clean multi-func bit */
+	val = dw_pcie_dbi_read(pp, PCI_HEADER_TYPE & ~0x3);
+	val &= ~(1 << 23);
+	dw_pcie_dbi_write(pp, val, PCI_HEADER_TYPE & ~0x3);
+	dw_pcie_dbi_write(pp, 0, PCIE_DBI_RO_WR_EN);
+
+	if (!ls2_pcie_link_up(pp))
+		dev_err(pp->dev, "phy link never came up\n");
 
 	return 0;
 }
 
+static struct dw_host_ops ls2_dw_host_ops = {
+	.link_up = ls2_pcie_link_up,
+	.host_init = ls2_pcie_host_init,
+};
+
+static const struct of_device_id ls_pcie_of_match[] = {
+	{ .compatible = "fsl,ls1021a-pcie", .data = &ls1_dw_host_ops },
+	{ .compatible = "fsl,ls2085a-pcie", .data = &ls2_dw_host_ops },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ls_pcie_of_match);
+
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
-	if (!dbi_base) {
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
+	if (!res) {
 		dev_err(&pdev->dev, "missing *regs* space\n");
 		return -ENODEV;
 	}
 
-	pcie->dbi = devm_ioremap_resource(&pdev->dev, dbi_base);
-	if (IS_ERR(pcie->dbi))
-		return PTR_ERR(pcie->dbi);
-
-	pcie->scfg = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
-						     "fsl,pcie-scfg");
-	if (IS_ERR(pcie->scfg)) {
-		dev_err(&pdev->dev, "No syscfg phandle specified\n");
-		return PTR_ERR(pcie->scfg);
-	}
+	pcie->regs = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(pcie->regs))
+		return PTR_ERR(pcie->regs);
 
-	ret = of_property_read_u32_array(pdev->dev.of_node,
-					 "fsl,pcie-scfg", index, 2);
-	if (ret)
-		return ret;
-	pcie->index = index[1];
+	pcie->lut = pcie->regs + PCIE_LUT_BASE;
+	pcie->pp.dev = &pdev->dev;
+	pcie->pp.dbi = pcie->regs;
+	pcie->pp.dw_ops = (struct dw_host_ops *)match->data;
+	pcie->pp.atu_num = PCIE_ATU_NUM;
 
-	ret = ls_add_pcie_port(pcie);
+	ret = dw_pcie_port_init(&pcie->pp);
 	if (ret < 0)
 		return ret;
 
@@ -158,12 +196,6 @@ static int __init ls_pcie_probe(struct platform_device *pdev)
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
diff --git a/drivers/pci/host/pcie-designware-base.h b/drivers/pci/host/pcie-designware-base.h
index dd7a3b3..84d65d1 100644
--- a/drivers/pci/host/pcie-designware-base.h
+++ b/drivers/pci/host/pcie-designware-base.h
@@ -10,6 +10,9 @@
 #define _PCIE_DESIGNWARE_BASE_H
 
 /* Synopsis specific PCIE configuration registers */
+#define PCIE_SYMBOL_TIMER_1		0x71c
+#define PCIE_DBI_RO_WR_EN		0x8bc
+
 #define PCIE_ATU_VIEWPORT		0x900
 #define PCIE_ATU_REGION_INBOUND		(0x1 << 31)
 #define PCIE_ATU_REGION_OUTBOUND	(0x0 << 31)
-- 
1.9.1

