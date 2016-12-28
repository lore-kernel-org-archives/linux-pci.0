Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:59040 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751268AbcL1Ke7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Dec 2016 05:34:59 -0500
From: Jaehoon Chung <jh80.chung@samsung.com>
To: linux-pci@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, bhelgaas@google.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org,
        krzk@kernel.org, kishon@ti.com, jingoohan1@gmail.com,
        vivek.gautam@codeaurora.org, pankaj.dubey@samsung.com,
        alim.akhtar@samsung.com, cpgs@samsung.com,
        Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 1/4] phy: exynos-pcie: Add support for Exynos PCIe phy
Date: Wed, 28 Dec 2016 19:34:51 +0900
Message-id: <20161228103454.26467-2-jh80.chung@samsung.com>
In-reply-to: <20161228103454.26467-1-jh80.chung@samsung.com>
References: <20161228103454.26467-1-jh80.chung@samsung.com>
 <CGME20161228103455epcas1p118b44f5a1644ce90eeaa7331f9c4a41c@epcas1p1.samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch supports to use Generic Phy framework for Exynos PCIe phy.
When Exynos that supported the pcie want to use the PCIe,
it needs to control the phy resgister.
But it should be more complex to control in their own PCIe device drivers.

To use this, move some codes from driver/pci/host/pci-exynos.c.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/pci/host/pci-exynos.c | 198 ++++-------------------------
 drivers/phy/Kconfig           |   9 ++
 drivers/phy/Makefile          |   1 +
 drivers/phy/phy-exynos-pcie.c | 289 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 321 insertions(+), 176 deletions(-)
 create mode 100644 drivers/phy/phy-exynos-pcie.c

diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
index feed0fd..ab03f02 100644
--- a/drivers/pci/host/pci-exynos.c
+++ b/drivers/pci/host/pci-exynos.c
@@ -21,6 +21,7 @@
 #include <linux/of_gpio.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
+#include <linux/phy/phy.h>
 #include <linux/resource.h>
 #include <linux/signal.h>
 #include <linux/types.h>
@@ -54,49 +55,8 @@
 #define PCIE_ELBI_SLV_ARMISC		0x120
 #define PCIE_ELBI_SLV_DBI_ENABLE	BIT(21)
 
-/* PCIe Purple registers */
-#define PCIE_PHY_GLOBAL_RESET		0x000
-#define PCIE_PHY_COMMON_RESET		0x004
-#define PCIE_PHY_CMN_REG		0x008
-#define PCIE_PHY_MAC_RESET		0x00c
-#define PCIE_PHY_PLL_LOCKED		0x010
-#define PCIE_PHY_TRSVREG_RESET		0x020
-#define PCIE_PHY_TRSV_RESET		0x024
-
-/* PCIe PHY registers */
-#define PCIE_PHY_IMPEDANCE		0x004
-#define PCIE_PHY_PLL_DIV_0		0x008
-#define PCIE_PHY_PLL_BIAS		0x00c
-#define PCIE_PHY_DCC_FEEDBACK		0x014
-#define PCIE_PHY_PLL_DIV_1		0x05c
-#define PCIE_PHY_COMMON_POWER		0x064
-#define PCIE_PHY_COMMON_PD_CMN		BIT(3)
-#define PCIE_PHY_TRSV0_EMP_LVL		0x084
-#define PCIE_PHY_TRSV0_DRV_LVL		0x088
-#define PCIE_PHY_TRSV0_RXCDR		0x0ac
-#define PCIE_PHY_TRSV0_POWER		0x0c4
-#define PCIE_PHY_TRSV0_PD_TSV		BIT(7)
-#define PCIE_PHY_TRSV0_LVCC		0x0dc
-#define PCIE_PHY_TRSV1_EMP_LVL		0x144
-#define PCIE_PHY_TRSV1_RXCDR		0x16c
-#define PCIE_PHY_TRSV1_POWER		0x184
-#define PCIE_PHY_TRSV1_PD_TSV		BIT(7)
-#define PCIE_PHY_TRSV1_LVCC		0x19c
-#define PCIE_PHY_TRSV2_EMP_LVL		0x204
-#define PCIE_PHY_TRSV2_RXCDR		0x22c
-#define PCIE_PHY_TRSV2_POWER		0x244
-#define PCIE_PHY_TRSV2_PD_TSV		BIT(7)
-#define PCIE_PHY_TRSV2_LVCC		0x25c
-#define PCIE_PHY_TRSV3_EMP_LVL		0x2c4
-#define PCIE_PHY_TRSV3_RXCDR		0x2ec
-#define PCIE_PHY_TRSV3_POWER		0x304
-#define PCIE_PHY_TRSV3_PD_TSV		BIT(7)
-#define PCIE_PHY_TRSV3_LVCC		0x31c
-
 struct exynos_pcie_mem_res {
 	void __iomem *elbi_base; /* DT 0th resource: PCIE CTRL */
-	void __iomem *phy_base; /* DT 1st resource: PHY CTRL */
-	void __iomem *block_base; /* DT 2nd resource: PHY ADDITIONAL CTRL */
 };
 
 struct exynos_pcie_clk_res {
@@ -110,6 +70,7 @@ struct exynos_pcie {
 	struct exynos_pcie_clk_res	*clk_res;
 	const struct exynos_pcie_ops	*ops;
 	int				reset_gpio;
+	struct phy		*phy;
 };
 
 struct exynos_pcie_ops {
@@ -135,16 +96,6 @@ static int exynos5440_pcie_get_mem_resources(struct platform_device *pdev,
 	if (IS_ERR(ep->mem_res->elbi_base))
 		return PTR_ERR(ep->mem_res->elbi_base);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	ep->mem_res->phy_base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(ep->mem_res->phy_base))
-		return PTR_ERR(ep->mem_res->phy_base);
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
-	ep->mem_res->block_base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(ep->mem_res->block_base))
-		return PTR_ERR(ep->mem_res->block_base);
-
 	return 0;
 }
 
@@ -267,111 +218,6 @@ static void exynos_pcie_deassert_core_reset(struct exynos_pcie *ep)
 	exynos_pcie_writel(ep->mem_res->elbi_base, 1, PCIE_NONSTICKY_RESET);
 	exynos_pcie_writel(ep->mem_res->elbi_base, 1, PCIE_APP_INIT_RESET);
 	exynos_pcie_writel(ep->mem_res->elbi_base, 0, PCIE_APP_INIT_RESET);
-	exynos_pcie_writel(ep->mem_res->block_base, 1, PCIE_PHY_MAC_RESET);
-}
-
-static void exynos_pcie_assert_phy_reset(struct exynos_pcie *ep)
-{
-	exynos_pcie_writel(ep->mem_res->block_base, 0, PCIE_PHY_MAC_RESET);
-	exynos_pcie_writel(ep->mem_res->block_base, 1, PCIE_PHY_GLOBAL_RESET);
-}
-
-static void exynos_pcie_deassert_phy_reset(struct exynos_pcie *ep)
-{
-	exynos_pcie_writel(ep->mem_res->block_base, 0, PCIE_PHY_GLOBAL_RESET);
-	exynos_pcie_writel(ep->mem_res->elbi_base, 1, PCIE_PWR_RESET);
-	exynos_pcie_writel(ep->mem_res->block_base, 0, PCIE_PHY_COMMON_RESET);
-	exynos_pcie_writel(ep->mem_res->block_base, 0, PCIE_PHY_CMN_REG);
-	exynos_pcie_writel(ep->mem_res->block_base, 0, PCIE_PHY_TRSVREG_RESET);
-	exynos_pcie_writel(ep->mem_res->block_base, 0, PCIE_PHY_TRSV_RESET);
-}
-
-static void exynos_pcie_power_on_phy(struct exynos_pcie *ep)
-{
-	u32 val;
-
-	val = exynos_pcie_readl(ep->mem_res->phy_base, PCIE_PHY_COMMON_POWER);
-	val &= ~PCIE_PHY_COMMON_PD_CMN;
-	exynos_pcie_writel(ep->mem_res->phy_base, val, PCIE_PHY_COMMON_POWER);
-
-	val = exynos_pcie_readl(ep->mem_res->phy_base, PCIE_PHY_TRSV0_POWER);
-	val &= ~PCIE_PHY_TRSV0_PD_TSV;
-	exynos_pcie_writel(ep->mem_res->phy_base, val, PCIE_PHY_TRSV0_POWER);
-
-	val = exynos_pcie_readl(ep->mem_res->phy_base, PCIE_PHY_TRSV1_POWER);
-	val &= ~PCIE_PHY_TRSV1_PD_TSV;
-	exynos_pcie_writel(ep->mem_res->phy_base, val, PCIE_PHY_TRSV1_POWER);
-
-	val = exynos_pcie_readl(ep->mem_res->phy_base, PCIE_PHY_TRSV2_POWER);
-	val &= ~PCIE_PHY_TRSV2_PD_TSV;
-	exynos_pcie_writel(ep->mem_res->phy_base, val, PCIE_PHY_TRSV2_POWER);
-
-	val = exynos_pcie_readl(ep->mem_res->phy_base, PCIE_PHY_TRSV3_POWER);
-	val &= ~PCIE_PHY_TRSV3_PD_TSV;
-	exynos_pcie_writel(ep->mem_res->phy_base, val, PCIE_PHY_TRSV3_POWER);
-}
-
-static void exynos_pcie_power_off_phy(struct exynos_pcie *ep)
-{
-	u32 val;
-
-	val = exynos_pcie_readl(ep->mem_res->phy_base, PCIE_PHY_COMMON_POWER);
-	val |= PCIE_PHY_COMMON_PD_CMN;
-	exynos_pcie_writel(ep->mem_res->phy_base, val, PCIE_PHY_COMMON_POWER);
-
-	val = exynos_pcie_readl(ep->mem_res->phy_base, PCIE_PHY_TRSV0_POWER);
-	val |= PCIE_PHY_TRSV0_PD_TSV;
-	exynos_pcie_writel(ep->mem_res->phy_base, val, PCIE_PHY_TRSV0_POWER);
-
-	val = exynos_pcie_readl(ep->mem_res->phy_base, PCIE_PHY_TRSV1_POWER);
-	val |= PCIE_PHY_TRSV1_PD_TSV;
-	exynos_pcie_writel(ep->mem_res->phy_base, val, PCIE_PHY_TRSV1_POWER);
-
-	val = exynos_pcie_readl(ep->mem_res->phy_base, PCIE_PHY_TRSV2_POWER);
-	val |= PCIE_PHY_TRSV2_PD_TSV;
-	exynos_pcie_writel(ep->mem_res->phy_base, val, PCIE_PHY_TRSV2_POWER);
-
-	val = exynos_pcie_readl(ep->mem_res->phy_base, PCIE_PHY_TRSV3_POWER);
-	val |= PCIE_PHY_TRSV3_PD_TSV;
-	exynos_pcie_writel(ep->mem_res->phy_base, val, PCIE_PHY_TRSV3_POWER);
-}
-
-static void exynos_pcie_init_phy(struct exynos_pcie *ep)
-{
-	/* DCC feedback control off */
-	exynos_pcie_writel(ep->mem_res->phy_base, 0x29, PCIE_PHY_DCC_FEEDBACK);
-
-	/* set TX/RX impedance */
-	exynos_pcie_writel(ep->mem_res->phy_base, 0xd5, PCIE_PHY_IMPEDANCE);
-
-	/* set 50Mhz PHY clock */
-	exynos_pcie_writel(ep->mem_res->phy_base, 0x14, PCIE_PHY_PLL_DIV_0);
-	exynos_pcie_writel(ep->mem_res->phy_base, 0x12, PCIE_PHY_PLL_DIV_1);
-
-	/* set TX Differential output for lane 0 */
-	exynos_pcie_writel(ep->mem_res->phy_base, 0x7f, PCIE_PHY_TRSV0_DRV_LVL);
-
-	/* set TX Pre-emphasis Level Control for lane 0 to minimum */
-	exynos_pcie_writel(ep->mem_res->phy_base, 0x0, PCIE_PHY_TRSV0_EMP_LVL);
-
-	/* set RX clock and data recovery bandwidth */
-	exynos_pcie_writel(ep->mem_res->phy_base, 0xe7, PCIE_PHY_PLL_BIAS);
-	exynos_pcie_writel(ep->mem_res->phy_base, 0x82, PCIE_PHY_TRSV0_RXCDR);
-	exynos_pcie_writel(ep->mem_res->phy_base, 0x82, PCIE_PHY_TRSV1_RXCDR);
-	exynos_pcie_writel(ep->mem_res->phy_base, 0x82, PCIE_PHY_TRSV2_RXCDR);
-	exynos_pcie_writel(ep->mem_res->phy_base, 0x82, PCIE_PHY_TRSV3_RXCDR);
-
-	/* change TX Pre-emphasis Level Control for lanes */
-	exynos_pcie_writel(ep->mem_res->phy_base, 0x39, PCIE_PHY_TRSV0_EMP_LVL);
-	exynos_pcie_writel(ep->mem_res->phy_base, 0x39, PCIE_PHY_TRSV1_EMP_LVL);
-	exynos_pcie_writel(ep->mem_res->phy_base, 0x39, PCIE_PHY_TRSV2_EMP_LVL);
-	exynos_pcie_writel(ep->mem_res->phy_base, 0x39, PCIE_PHY_TRSV3_EMP_LVL);
-
-	/* set LVCC */
-	exynos_pcie_writel(ep->mem_res->phy_base, 0x20, PCIE_PHY_TRSV0_LVCC);
-	exynos_pcie_writel(ep->mem_res->phy_base, 0xa0, PCIE_PHY_TRSV1_LVCC);
-	exynos_pcie_writel(ep->mem_res->phy_base, 0xa0, PCIE_PHY_TRSV2_LVCC);
-	exynos_pcie_writel(ep->mem_res->phy_base, 0xa0, PCIE_PHY_TRSV3_LVCC);
 }
 
 static void exynos_pcie_assert_reset(struct exynos_pcie *exynos_pcie)
@@ -388,7 +234,6 @@ static int exynos_pcie_establish_link(struct exynos_pcie *exynos_pcie)
 {
 	struct pcie_port *pp = &exynos_pcie->pp;
 	struct device *dev = pp->dev;
-	u32 val;
 
 	if (dw_pcie_link_up(pp)) {
 		dev_err(dev, "Link already up\n");
@@ -396,17 +241,13 @@ static int exynos_pcie_establish_link(struct exynos_pcie *exynos_pcie)
 	}
 
 	exynos_pcie_assert_core_reset(exynos_pcie);
-	exynos_pcie_assert_phy_reset(exynos_pcie);
-	exynos_pcie_deassert_phy_reset(exynos_pcie);
-	exynos_pcie_power_on_phy(exynos_pcie);
-	exynos_pcie_init_phy(exynos_pcie);
-
-	/* pulse for common reset */
-	exynos_pcie_writel(exynos_pcie->mem_res->block_base, 1,
-				PCIE_PHY_COMMON_RESET);
-	udelay(500);
-	exynos_pcie_writel(exynos_pcie->mem_res->block_base, 0,
-				PCIE_PHY_COMMON_RESET);
+
+	phy_reset(exynos_pcie->phy);
+
+	exynos_pcie_writel(exynos_pcie->mem_res->elbi_base, 1, PCIE_PWR_RESET);
+
+	phy_power_on(exynos_pcie->phy);
+	phy_init(exynos_pcie->phy);
 
 	exynos_pcie_deassert_core_reset(exynos_pcie);
 	dw_pcie_setup_rc(pp);
@@ -420,13 +261,8 @@ static int exynos_pcie_establish_link(struct exynos_pcie *exynos_pcie)
 	if (!dw_pcie_wait_for_link(pp))
 		return 0;
 
-	while (exynos_pcie_readl(exynos_pcie->mem_res->phy_base,
-				PCIE_PHY_PLL_LOCKED) == 0) {
-		val = exynos_pcie_readl(exynos_pcie->mem_res->block_base,
-				PCIE_PHY_PLL_LOCKED);
-		dev_info(dev, "PLL Locked: 0x%x\n", val);
-	}
-	exynos_pcie_power_off_phy(exynos_pcie);
+	phy_power_off(exynos_pcie->phy);
+
 	return -ETIMEDOUT;
 }
 
@@ -649,9 +485,19 @@ static int __init exynos_pcie_probe(struct platform_device *pdev)
 			return ret;
 	}
 
+	exynos_pcie->phy = devm_phy_get(&pdev->dev, "pcie-phy");
+	if (IS_ERR(exynos_pcie->phy)) {
+		if (PTR_ERR(exynos_pcie->phy) != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Can't find the pcie-phy\n");
+		ret = PTR_ERR(exynos_pcie->phy);
+		goto fail_probe;
+	}
+
 	ret = exynos_add_pcie_port(exynos_pcie, pdev);
-	if (ret < 0)
+	if (ret < 0) {
+		phy_exit(exynos_pcie->phy);
 		goto fail_probe;
+	}
 
 	platform_set_drvdata(pdev, exynos_pcie);
 	return 0;
diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index e8eb7f2..2dddef4 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -331,6 +331,15 @@ config PHY_EXYNOS5_USBDRD
 	  This driver provides PHY interface for USB 3.0 DRD controller
 	  present on Exynos5 SoC series.
 
+config PHY_EXYNOS_PCIE
+	bool "Exynos PCIe PHY driver"
+	depends on ARCH_EXYNOS && OF
+	depends on PCI_EXYNOS
+	select GENERIC_PHY
+	help
+	  Enable PCIe PHY support for Exynos SoC series.
+	  This driver provides PHY interface for Exynos PCIe controller.
+
 config PHY_PISTACHIO_USB
 	tristate "IMG Pistachio USB2.0 PHY driver"
 	depends on MACH_PISTACHIO
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index 65eb2f4..081aeb4 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -37,6 +37,7 @@ phy-exynos-usb2-$(CONFIG_PHY_EXYNOS4X12_USB2)	+= phy-exynos4x12-usb2.o
 phy-exynos-usb2-$(CONFIG_PHY_EXYNOS5250_USB2)	+= phy-exynos5250-usb2.o
 phy-exynos-usb2-$(CONFIG_PHY_S5PV210_USB2)	+= phy-s5pv210-usb2.o
 obj-$(CONFIG_PHY_EXYNOS5_USBDRD)	+= phy-exynos5-usbdrd.o
+obj-$(CONFIG_PHY_EXYNOS_PCIE)	+= phy-exynos-pcie.o
 obj-$(CONFIG_PHY_QCOM_APQ8064_SATA)	+= phy-qcom-apq8064-sata.o
 obj-$(CONFIG_PHY_ROCKCHIP_USB) += phy-rockchip-usb.o
 obj-$(CONFIG_PHY_ROCKCHIP_INNO_USB2)	+= phy-rockchip-inno-usb2.o
diff --git a/drivers/phy/phy-exynos-pcie.c b/drivers/phy/phy-exynos-pcie.c
new file mode 100644
index 0000000..0a99b77
--- /dev/null
+++ b/drivers/phy/phy-exynos-pcie.c
@@ -0,0 +1,289 @@
+/*
+ * Samsung EXYNOS5 SoC series PCIe PHY driver
+ *
+ * Phy provider for PCIe controller on Exynos5 SoC series
+ *
+ * Copyright (C) 2016 Samsung Electronics Co., Ltd.
+ * Jaehoon Chung <jh80.chung@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/phy/phy.h>
+#include <linux/regmap.h>
+
+/* PCIe Purple registers */
+#define PCIE_PHY_GLOBAL_RESET		0x000
+#define PCIE_PHY_COMMON_RESET		0x004
+#define PCIE_PHY_CMN_REG		0x008
+#define PCIE_PHY_MAC_RESET		0x00c
+#define PCIE_PHY_PLL_LOCKED		0x010
+#define PCIE_PHY_TRSVREG_RESET		0x020
+#define PCIE_PHY_TRSV_RESET		0x024
+
+/* PCIe PHY registers */
+#define PCIE_PHY_IMPEDANCE		0x004
+#define PCIE_PHY_PLL_DIV_0		0x008
+#define PCIE_PHY_PLL_BIAS		0x00c
+#define PCIE_PHY_DCC_FEEDBACK		0x014
+#define PCIE_PHY_PLL_DIV_1		0x05c
+#define PCIE_PHY_COMMON_POWER		0x064
+#define PCIE_PHY_COMMON_PD_CMN		BIT(3)
+#define PCIE_PHY_TRSV0_EMP_LVL		0x084
+#define PCIE_PHY_TRSV0_DRV_LVL		0x088
+#define PCIE_PHY_TRSV0_RXCDR		0x0ac
+#define PCIE_PHY_TRSV0_POWER		0x0c4
+#define PCIE_PHY_TRSV0_PD_TSV		BIT(7)
+#define PCIE_PHY_TRSV0_LVCC		0x0dc
+#define PCIE_PHY_TRSV1_EMP_LVL		0x144
+#define PCIE_PHY_TRSV1_RXCDR		0x16c
+#define PCIE_PHY_TRSV1_POWER		0x184
+#define PCIE_PHY_TRSV1_PD_TSV		BIT(7)
+#define PCIE_PHY_TRSV1_LVCC		0x19c
+#define PCIE_PHY_TRSV2_EMP_LVL		0x204
+#define PCIE_PHY_TRSV2_RXCDR		0x22c
+#define PCIE_PHY_TRSV2_POWER		0x244
+#define PCIE_PHY_TRSV2_PD_TSV		BIT(7)
+#define PCIE_PHY_TRSV2_LVCC		0x25c
+#define PCIE_PHY_TRSV3_EMP_LVL		0x2c4
+#define PCIE_PHY_TRSV3_RXCDR		0x2ec
+#define PCIE_PHY_TRSV3_POWER		0x304
+#define PCIE_PHY_TRSV3_PD_TSV		BIT(7)
+#define PCIE_PHY_TRSV3_LVCC		0x31c
+
+struct exynos_pcie_phy_data {
+	struct phy_ops	*ops;
+};
+
+/* For Exynos pcie phy */
+struct exynos_pcie_phy {
+	const struct exynos_pcie_phy_data *drv_data;
+	void __iomem *phy_base;
+	void __iomem *blk_base; /* For exynos5440 */
+};
+
+static void exynos_pcie_phy_writel(void __iomem *base, u32 val, u32 offset)
+{
+	writel(val, base + offset);
+}
+
+static u32 exynos_pcie_phy_readl(void __iomem *base, u32 offset)
+{
+	return readl(base + offset);
+}
+
+/* For Exynos5440 specific functions */
+static int exynos5440_pcie_phy_init(struct phy *phy)
+{
+	struct exynos_pcie_phy *ep = phy_get_drvdata(phy);
+
+	/* DCC feedback control off */
+	exynos_pcie_phy_writel(ep->phy_base, 0x29, PCIE_PHY_DCC_FEEDBACK);
+
+	/* set TX/RX impedance */
+	exynos_pcie_phy_writel(ep->phy_base, 0xd5, PCIE_PHY_IMPEDANCE);
+
+	/* set 50Mhz PHY clock */
+	exynos_pcie_phy_writel(ep->phy_base, 0x14, PCIE_PHY_PLL_DIV_0);
+	exynos_pcie_phy_writel(ep->phy_base, 0x12, PCIE_PHY_PLL_DIV_1);
+
+	/* set TX Differential output for lane 0 */
+	exynos_pcie_phy_writel(ep->phy_base, 0x7f, PCIE_PHY_TRSV0_DRV_LVL);
+
+	/* set TX Pre-emphasis Level Control for lane 0 to minimum */
+	exynos_pcie_phy_writel(ep->phy_base, 0x0, PCIE_PHY_TRSV0_EMP_LVL);
+
+	/* set RX clock and data recovery bandwidth */
+	exynos_pcie_phy_writel(ep->phy_base, 0xe7, PCIE_PHY_PLL_BIAS);
+	exynos_pcie_phy_writel(ep->phy_base, 0x82, PCIE_PHY_TRSV0_RXCDR);
+	exynos_pcie_phy_writel(ep->phy_base, 0x82, PCIE_PHY_TRSV1_RXCDR);
+	exynos_pcie_phy_writel(ep->phy_base, 0x82, PCIE_PHY_TRSV2_RXCDR);
+	exynos_pcie_phy_writel(ep->phy_base, 0x82, PCIE_PHY_TRSV3_RXCDR);
+
+	/* change TX Pre-emphasis Level Control for lanes */
+	exynos_pcie_phy_writel(ep->phy_base, 0x39, PCIE_PHY_TRSV0_EMP_LVL);
+	exynos_pcie_phy_writel(ep->phy_base, 0x39, PCIE_PHY_TRSV1_EMP_LVL);
+	exynos_pcie_phy_writel(ep->phy_base, 0x39, PCIE_PHY_TRSV2_EMP_LVL);
+	exynos_pcie_phy_writel(ep->phy_base, 0x39, PCIE_PHY_TRSV3_EMP_LVL);
+
+	/* set LVCC */
+	exynos_pcie_phy_writel(ep->phy_base, 0x20, PCIE_PHY_TRSV0_LVCC);
+	exynos_pcie_phy_writel(ep->phy_base, 0xa0, PCIE_PHY_TRSV1_LVCC);
+	exynos_pcie_phy_writel(ep->phy_base, 0xa0, PCIE_PHY_TRSV2_LVCC);
+	exynos_pcie_phy_writel(ep->phy_base, 0xa0, PCIE_PHY_TRSV3_LVCC);
+
+	/* pulse for common reset */
+	exynos_pcie_phy_writel(ep->blk_base, 1, PCIE_PHY_COMMON_RESET);
+	udelay(500);
+	exynos_pcie_phy_writel(ep->blk_base, 0, PCIE_PHY_COMMON_RESET);
+
+	return 0;
+}
+
+static int exynos5440_pcie_phy_power_on(struct phy *phy)
+{
+	struct exynos_pcie_phy *ep = phy_get_drvdata(phy);
+	u32 val;
+
+	exynos_pcie_phy_writel(ep->blk_base, 0, PCIE_PHY_COMMON_RESET);
+	exynos_pcie_phy_writel(ep->blk_base, 0, PCIE_PHY_CMN_REG);
+	exynos_pcie_phy_writel(ep->blk_base, 0, PCIE_PHY_TRSVREG_RESET);
+	exynos_pcie_phy_writel(ep->blk_base, 0, PCIE_PHY_TRSV_RESET);
+
+	val = exynos_pcie_phy_readl(ep->phy_base, PCIE_PHY_COMMON_POWER);
+	val &= ~PCIE_PHY_COMMON_PD_CMN;
+	exynos_pcie_phy_writel(ep->phy_base, val, PCIE_PHY_COMMON_POWER);
+
+	val = exynos_pcie_phy_readl(ep->phy_base, PCIE_PHY_TRSV0_POWER);
+	val &= ~PCIE_PHY_TRSV0_PD_TSV;
+	exynos_pcie_phy_writel(ep->phy_base, val, PCIE_PHY_TRSV0_POWER);
+
+	val = exynos_pcie_phy_readl(ep->phy_base, PCIE_PHY_TRSV1_POWER);
+	val &= ~PCIE_PHY_TRSV1_PD_TSV;
+	exynos_pcie_phy_writel(ep->phy_base, val, PCIE_PHY_TRSV1_POWER);
+
+	val = exynos_pcie_phy_readl(ep->phy_base, PCIE_PHY_TRSV2_POWER);
+	val &= ~PCIE_PHY_TRSV2_PD_TSV;
+	exynos_pcie_phy_writel(ep->phy_base, val, PCIE_PHY_TRSV2_POWER);
+
+	val = exynos_pcie_phy_readl(ep->phy_base, PCIE_PHY_TRSV3_POWER);
+	val &= ~PCIE_PHY_TRSV3_PD_TSV;
+	exynos_pcie_phy_writel(ep->phy_base, val, PCIE_PHY_TRSV3_POWER);
+
+	return 0;
+}
+
+static int exynos5440_pcie_phy_power_off(struct phy *phy)
+{
+	struct exynos_pcie_phy *ep = phy_get_drvdata(phy);
+	u32 val;
+
+	while (exynos_pcie_phy_readl(ep->phy_base,
+				PCIE_PHY_PLL_LOCKED) == 0) {
+		val = exynos_pcie_phy_readl(ep->blk_base,
+				PCIE_PHY_PLL_LOCKED);
+		dev_info(&phy->dev, "PLL Locked: 0x%x\n", val);
+	}
+
+	val = exynos_pcie_phy_readl(ep->phy_base, PCIE_PHY_COMMON_POWER);
+	val |= PCIE_PHY_COMMON_PD_CMN;
+	exynos_pcie_phy_writel(ep->phy_base, val, PCIE_PHY_COMMON_POWER);
+
+	val = exynos_pcie_phy_readl(ep->phy_base, PCIE_PHY_TRSV0_POWER);
+	val |= PCIE_PHY_TRSV0_PD_TSV;
+	exynos_pcie_phy_writel(ep->phy_base, val, PCIE_PHY_TRSV0_POWER);
+
+	val = exynos_pcie_phy_readl(ep->phy_base, PCIE_PHY_TRSV1_POWER);
+	val |= PCIE_PHY_TRSV1_PD_TSV;
+	exynos_pcie_phy_writel(ep->phy_base, val, PCIE_PHY_TRSV1_POWER);
+
+	val = exynos_pcie_phy_readl(ep->phy_base, PCIE_PHY_TRSV2_POWER);
+	val |= PCIE_PHY_TRSV2_PD_TSV;
+	exynos_pcie_phy_writel(ep->phy_base, val, PCIE_PHY_TRSV2_POWER);
+
+	val = exynos_pcie_phy_readl(ep->phy_base, PCIE_PHY_TRSV3_POWER);
+	val |= PCIE_PHY_TRSV3_PD_TSV;
+	exynos_pcie_phy_writel(ep->phy_base, val, PCIE_PHY_TRSV3_POWER);
+
+	return 0;
+}
+
+static int exynos5440_pcie_phy_reset(struct phy *phy)
+{
+	struct exynos_pcie_phy *ep = phy_get_drvdata(phy);
+
+	exynos_pcie_phy_writel(ep->blk_base, 0, PCIE_PHY_MAC_RESET);
+	exynos_pcie_phy_writel(ep->blk_base, 1, PCIE_PHY_GLOBAL_RESET);
+	exynos_pcie_phy_writel(ep->blk_base, 0, PCIE_PHY_GLOBAL_RESET);
+
+	return 0;
+}
+
+static struct phy_ops exynos5440_phy_ops = {
+	.init	= exynos5440_pcie_phy_init,
+	.power_on = exynos5440_pcie_phy_power_on,
+	.power_off = exynos5440_pcie_phy_power_off,
+	.reset	= exynos5440_pcie_phy_reset,
+};
+
+static const struct exynos_pcie_phy_data exynos5440_pcie_phy_data = {
+	.ops		= &exynos5440_phy_ops,
+};
+
+static const struct of_device_id exynos_pcie_phy_match[] = {
+	{
+		.compatible = "samsung,exynos5440-pcie-phy",
+		.data = &exynos5440_pcie_phy_data,
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, exynos_pcie_phy_match);
+
+static int exynos_pcie_phy_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct exynos_pcie_phy *exynos_phy;
+	struct phy *generic_phy;
+	struct phy_provider *phy_provider;
+	struct resource *res;
+	const struct exynos_pcie_phy_data *drv_data;
+	struct device_node *child;
+	int ret;
+
+	drv_data = of_device_get_match_data(dev);
+	if (!drv_data)
+		return -ENODEV;
+
+	exynos_phy = devm_kzalloc(dev, sizeof(*exynos_phy), GFP_KERNEL);
+	if (!exynos_phy)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	exynos_phy->phy_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(exynos_phy->phy_base))
+		return PTR_ERR(exynos_phy->phy_base);
+
+	exynos_phy->drv_data = drv_data;
+
+	for_each_child_of_node(np, child) {
+		ret = of_address_to_resource(child, 0, res);
+		if (!ret) {
+			exynos_phy->blk_base =
+				devm_ioremap_resource(dev, res);
+		} else {
+			dev_warn(dev, "Failed to get block_base.\n");
+			return ret;
+		}
+	}
+
+	generic_phy = devm_phy_create(dev, dev->of_node, drv_data->ops);
+	if (IS_ERR(generic_phy)) {
+		dev_err(dev, "failed to create PHY\n");
+		return PTR_ERR(generic_phy);
+	}
+
+	phy_set_drvdata(generic_phy, exynos_phy);
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+
+	return PTR_ERR_OR_ZERO(phy_provider);
+}
+
+static struct platform_driver exynos_pcie_phy_driver = {
+	.probe	= exynos_pcie_phy_probe,
+	.driver = {
+		.of_match_table	= exynos_pcie_phy_match,
+		.name		= "exynos_pcie_phy",
+	}
+};
+module_platform_driver(exynos_pcie_phy_driver);
-- 
2.10.2

