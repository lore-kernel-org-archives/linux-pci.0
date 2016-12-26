Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:53148 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752016AbcLZFUf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Dec 2016 00:20:35 -0500
From: Jaehoon Chung <jh80.chung@samsung.com>
To: linux-pci@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, bhelgaas@google.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org,
        krzk@kernel.org, javier@osg.samsung.com, kishon@ti.com,
        will.deacon@arm.com, catalin.marinas@arm.com, cpgs@samsung.com,
        Jaehoon Chung <jh80.chung@samsung.com>
Subject: [RFC PATCH 1/6] phy: exynos-pcie: Add support for Exynos PCIe phy
Date: Mon, 26 Dec 2016 14:20:24 +0900
Message-id: <20161226052029.10552-2-jh80.chung@samsung.com>
In-reply-to: <20161226052029.10552-1-jh80.chung@samsung.com>
References: <20161226052029.10552-1-jh80.chung@samsung.com>
 <CGME20161226052030epcas5p4ea673fc4ee5c0b2664e80f53d4758553@epcas5p4.samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch supports to use Generic Phy framework for Exynos PCIe phy.
When Exynos that supported the pcie want to use the PCIe,
it needs to control the phy resgister.
But it should be more complex to control in their own PCIe device drivers.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/phy/Kconfig           |   9 ++
 drivers/phy/Makefile          |   1 +
 drivers/phy/phy-exynos-pcie.c | 227 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 237 insertions(+)
 create mode 100644 drivers/phy/phy-exynos-pcie.c

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index fe00f91..94b0433 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -341,6 +341,15 @@ config PHY_EXYNOS5_USBDRD
 	  This driver provides PHY interface for USB 3.0 DRD controller
 	  present on Exynos5 SoC series.
 
+config PHY_EXYNOS_PCIE
+	bool "Exynos PCIe PHY driver"
+	depends on ARCH_EXYNOS && OF
+	depends on PCI_EXYNOS5433
+	select GENERIC_PHY
+	help
+	  Enable PCIe PHY support for Exynos SoC series.
+	  This driver provides PHY interface for Exynos PCIe controller.
+
 config PHY_PISTACHIO_USB
 	tristate "IMG Pistachio USB2.0 PHY driver"
 	depends on MACH_PISTACHIO
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index a534cf5..586344d 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -38,6 +38,7 @@ phy-exynos-usb2-$(CONFIG_PHY_EXYNOS4X12_USB2)	+= phy-exynos4x12-usb2.o
 phy-exynos-usb2-$(CONFIG_PHY_EXYNOS5250_USB2)	+= phy-exynos5250-usb2.o
 phy-exynos-usb2-$(CONFIG_PHY_S5PV210_USB2)	+= phy-s5pv210-usb2.o
 obj-$(CONFIG_PHY_EXYNOS5_USBDRD)	+= phy-exynos5-usbdrd.o
+obj-$(CONFIG_PHY_EXYNOS_PCIE)	+= phy-exynos-pcie.o
 obj-$(CONFIG_PHY_QCOM_APQ8064_SATA)	+= phy-qcom-apq8064-sata.o
 obj-$(CONFIG_PHY_ROCKCHIP_USB) += phy-rockchip-usb.o
 obj-$(CONFIG_PHY_ROCKCHIP_INNO_USB2)	+= phy-rockchip-inno-usb2.o
diff --git a/drivers/phy/phy-exynos-pcie.c b/drivers/phy/phy-exynos-pcie.c
new file mode 100644
index 0000000..0f5eefd
--- /dev/null
+++ b/drivers/phy/phy-exynos-pcie.c
@@ -0,0 +1,227 @@
+/*
+ * Samsung EXYNOS SoC series PCIe PHY driver
+ *
+ * Phy provider for PCIe controller on Exynos SoC series
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
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
+
+#define PCIE_EXYNOS5433_PMU_PHY_OFFSET		0x730
+#define PCIE_PHY_OFFSET(x)		((x) * 0x4)
+
+/* Sysreg Fsys register offset and bit for Exynos5433 */
+#define PCIE_PHY_MAC_RESET		0x208
+#define PCIE_MAC_RESET_MASK		0xFF
+#define PCIE_MAC_RESET			BIT(4)
+#define PCIE_L1SUB_CM_CON		0x1010
+#define PCIE_REFCLK_GATING_EN		BIT(0)
+#define PCIE_PHY_COMMON_RESET		0x1020
+#define PCIE_PHY_RESET			BIT(0)
+#define PCIE_PHY_GLOBAL_RESET		0x1040
+#define PCIE_GLOBAL_RESET		BIT(0)
+#define PCIE_REFCLK			BIT(1)
+#define PCIE_REFCLK_MASK		0x16
+#define PCIE_APP_REQ_EXIT_L1_MODE	BIT(5)
+
+enum exynos_pcie_phy_data_type {
+	PCIE_PHY_TYPE_EXYNOS5433,
+};
+
+struct exynos_pcie_phy_data {
+	enum exynos_pcie_phy_data_type	ctrl_type;
+	u32	pmureg_offset; /* PMU_REG offset */
+	struct phy_ops	*ops;
+};
+
+/* for Exynos pcie phy */
+struct exynos_pcie_phy {
+	const struct exynos_pcie_phy_data *drv_data;
+	struct regmap *pmureg;
+	struct regmap *fsysreg;
+	void __iomem *phy_base;
+};
+
+static void exynos_pcie_phy_writel(void __iomem *base, u32 val, u32 offset)
+{
+	writel(val, base + offset);
+}
+
+static int exynos_pcie_phy_init(struct phy *phy)
+{
+	struct exynos_pcie_phy *ep = phy_get_drvdata(phy);
+
+	if (ep->fsysreg) {
+		regmap_update_bits(ep->fsysreg, PCIE_PHY_COMMON_RESET,
+				PCIE_PHY_RESET, 1);
+		regmap_update_bits(ep->fsysreg, PCIE_PHY_MAC_RESET,
+				PCIE_MAC_RESET, 0);
+		/* PHY refclk 24MHz */
+		regmap_update_bits(ep->fsysreg, PCIE_PHY_GLOBAL_RESET,
+				PCIE_REFCLK_MASK, PCIE_REFCLK);
+		regmap_update_bits(ep->fsysreg, PCIE_PHY_GLOBAL_RESET,
+				PCIE_GLOBAL_RESET, 0);
+	}
+
+	exynos_pcie_phy_writel(ep->phy_base, 0x11, PCIE_PHY_OFFSET(0x3));
+
+	/* band gap reference on */
+	exynos_pcie_phy_writel(ep->phy_base, 0, PCIE_PHY_OFFSET(0x20));
+	exynos_pcie_phy_writel(ep->phy_base, 0, PCIE_PHY_OFFSET(0x4b));
+
+	/* jitter tunning */
+	exynos_pcie_phy_writel(ep->phy_base, 0x34, PCIE_PHY_OFFSET(0x4));
+	exynos_pcie_phy_writel(ep->phy_base, 0x02, PCIE_PHY_OFFSET(0x7));
+	exynos_pcie_phy_writel(ep->phy_base, 0x41, PCIE_PHY_OFFSET(0x21));
+	exynos_pcie_phy_writel(ep->phy_base, 0x7F, PCIE_PHY_OFFSET(0x14));
+	exynos_pcie_phy_writel(ep->phy_base, 0xC0, PCIE_PHY_OFFSET(0x15));
+	exynos_pcie_phy_writel(ep->phy_base, 0x61, PCIE_PHY_OFFSET(0x36));
+
+	/* D0 uninit.. */
+	exynos_pcie_phy_writel(ep->phy_base, 0x44, PCIE_PHY_OFFSET(0x3D));
+
+	/* 24MHz */
+	exynos_pcie_phy_writel(ep->phy_base, 0x94, PCIE_PHY_OFFSET(0x8));
+	exynos_pcie_phy_writel(ep->phy_base, 0xA7, PCIE_PHY_OFFSET(0x9));
+	exynos_pcie_phy_writel(ep->phy_base, 0x93, PCIE_PHY_OFFSET(0xA));
+	exynos_pcie_phy_writel(ep->phy_base, 0x6B, PCIE_PHY_OFFSET(0xC));
+	exynos_pcie_phy_writel(ep->phy_base, 0xA5, PCIE_PHY_OFFSET(0xF));
+	exynos_pcie_phy_writel(ep->phy_base, 0x34, PCIE_PHY_OFFSET(0x16));
+	exynos_pcie_phy_writel(ep->phy_base, 0xA3, PCIE_PHY_OFFSET(0x17));
+	exynos_pcie_phy_writel(ep->phy_base, 0xA7, PCIE_PHY_OFFSET(0x1A));
+	exynos_pcie_phy_writel(ep->phy_base, 0x71, PCIE_PHY_OFFSET(0x23));
+	exynos_pcie_phy_writel(ep->phy_base, 0x4C, PCIE_PHY_OFFSET(0x24));
+
+	exynos_pcie_phy_writel(ep->phy_base, 0x0E, PCIE_PHY_OFFSET(0x26));
+	exynos_pcie_phy_writel(ep->phy_base, 0x14, PCIE_PHY_OFFSET(0x7));
+	exynos_pcie_phy_writel(ep->phy_base, 0x48, PCIE_PHY_OFFSET(0x43));
+	exynos_pcie_phy_writel(ep->phy_base, 0x44, PCIE_PHY_OFFSET(0x44));
+	exynos_pcie_phy_writel(ep->phy_base, 0x03, PCIE_PHY_OFFSET(0x45));
+	exynos_pcie_phy_writel(ep->phy_base, 0xA7, PCIE_PHY_OFFSET(0x48));
+	exynos_pcie_phy_writel(ep->phy_base, 0x13, PCIE_PHY_OFFSET(0x54));
+	exynos_pcie_phy_writel(ep->phy_base, 0x04, PCIE_PHY_OFFSET(0x31));
+	exynos_pcie_phy_writel(ep->phy_base, 0, PCIE_PHY_OFFSET(0x32));
+
+	if (ep->fsysreg) {
+		regmap_update_bits(ep->fsysreg, PCIE_PHY_COMMON_RESET,
+				PCIE_PHY_RESET, 0);
+		regmap_update_bits(ep->fsysreg, PCIE_PHY_MAC_RESET,
+				PCIE_MAC_RESET_MASK, PCIE_MAC_RESET);
+	}
+
+	return 0;
+}
+
+static int exynos_pcie_phy_power_on(struct phy *phy)
+{
+	struct exynos_pcie_phy *ep = phy_get_drvdata(phy);
+
+	if (ep->pmureg) {
+		if (regmap_update_bits(ep->pmureg, ep->drv_data->pmureg_offset,
+					BIT(0), 1))
+			dev_warn(&phy->dev, "Failed to update regmap bit.\n");
+	}
+
+	if (ep->fsysreg) {
+		regmap_update_bits(ep->fsysreg, PCIE_PHY_GLOBAL_RESET,
+				PCIE_APP_REQ_EXIT_L1_MODE, 0);
+		regmap_update_bits(ep->fsysreg, PCIE_L1SUB_CM_CON,
+				PCIE_REFCLK_GATING_EN, 0);
+	}
+
+	return 0;
+}
+
+static struct phy_ops exynos_phy_ops = {
+	.init	= exynos_pcie_phy_init,
+	.power_on = exynos_pcie_phy_power_on,
+};
+
+static const struct exynos_pcie_phy_data exynos5433_pcie_phy_data = {
+	.ctrl_type	= PCIE_PHY_TYPE_EXYNOS5433,
+	.pmureg_offset	= PCIE_EXYNOS5433_PMU_PHY_OFFSET,
+	.ops		= &exynos_phy_ops,
+};
+
+static const struct of_device_id exynos_pcie_phy_match[] = {
+	{
+		.compatible = "samsung,exynos5433-pcie-phy",
+		.data = &exynos5433_pcie_phy_data,
+	},
+	{}
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
+	const struct of_device_id *match;
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
+	exynos_phy->pmureg = syscon_regmap_lookup_by_phandle(np,
+			"samsung,pmureg-phandle");
+	if (IS_ERR(exynos_phy->pmureg)) {
+		dev_warn(&pdev->dev, "pmureg syscon regmap lookup failed.\n");
+		exynos_phy->pmureg = NULL;
+	}
+
+	match = of_match_node(exynos_pcie_phy_match, pdev->dev.of_node);
+	drv_data = match->data;
+	exynos_phy->drv_data = drv_data;
+
+	exynos_phy->fsysreg = syscon_regmap_lookup_by_phandle(np,
+			"samsung,fsys-sysreg");
+	if (IS_ERR(exynos_phy->fsysreg)) {
+		dev_warn(&pdev->dev, "Fsysreg syscon regmap lookup failed.\n");
+		exynos_phy->fsysreg = NULL;
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

