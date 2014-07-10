Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:55307 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321AbaGJH1U (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Jul 2014 03:27:20 -0400
Received: by mail-pa0-f45.google.com with SMTP id rd3so10604438pab.18
        for <linux-pci@vger.kernel.org>; Thu, 10 Jul 2014 00:27:20 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: arnd@linaro.org, olof@lixom.net
Cc: linux-arm-kernel@lists.infradead.org, spear-devel@list.st.com,
	b.zolnierkie@samsung.com, bhelgaas@google.com, mark@nicholnet.com,
	linux-pci@vger.kernel.org, Pratyush Anand <pratyush.anand@st.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V9 2/7] phy: Add drivers for PCIe and SATA phy on SPEAr13xx
Date: Thu, 10 Jul 2014 12:56:33 +0530
Message-Id: <d1ef8db8704d09ba4f276c954dc22b555998f957.1404976058.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1404976058.git.viresh.kumar@linaro.org>
References: <cover.1404976058.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1404976058.git.viresh.kumar@linaro.org>
References: <cover.1404976058.git.viresh.kumar@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Pratyush Anand <pratyush.anand@st.com>

ARM based ST Microelectronics's SPEAr1310/40 platforms uses ST's phy (known as
'miphy') for PCIe and SATA. This patch adds drivers for these miphys.

This also adds proper bindings for miphys.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
Tested-by: Mohit Kumar <mohit.kumar@st.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
[viresh: fixed logs/cclist/checkpatch warnings, broken into smaller patches]
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 .../devicetree/bindings/phy/st-spear1310-miphy.txt |  12 +
 .../devicetree/bindings/phy/st-spear1340-miphy.txt |  11 +
 drivers/phy/Kconfig                                |  12 +
 drivers/phy/Makefile                               |   2 +
 drivers/phy/phy-spear1310-miphy.c                  | 274 +++++++++++++++++++
 drivers/phy/phy-spear1340-miphy.c                  | 302 +++++++++++++++++++++
 6 files changed, 613 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/st-spear1310-miphy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/st-spear1340-miphy.txt
 create mode 100644 drivers/phy/phy-spear1310-miphy.c
 create mode 100644 drivers/phy/phy-spear1340-miphy.c

diff --git a/Documentation/devicetree/bindings/phy/st-spear1310-miphy.txt b/Documentation/devicetree/bindings/phy/st-spear1310-miphy.txt
new file mode 100644
index 0000000..b9b281a
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/st-spear1310-miphy.txt
@@ -0,0 +1,12 @@
+ST SPEAr1310-miphy DT detail
+===================================
+
+SPEAr1310-miphy is a phy controller supporting PCIe and SATA.
+
+Required properties:
+- compatible : should be "st,spear1310-miphy"
+- reg : offset and length of the PHY register set.
+- misc: phandle for the syscon node to access misc registers
+- phy-id: Instance id of the phy.
+- #phy-cells : from the generic PHY bindings, must be 1.
+	- cell[1]: 0 if phy used for SATA, 1 for PCIe.
diff --git a/Documentation/devicetree/bindings/phy/st-spear1340-miphy.txt b/Documentation/devicetree/bindings/phy/st-spear1340-miphy.txt
new file mode 100644
index 0000000..7eb5335
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/st-spear1340-miphy.txt
@@ -0,0 +1,11 @@
+ST SPEAr1340-miphy DT detail
+===================================
+
+SPEAr1340-miphy is a phy controller supporting PCIe and SATA.
+
+Required properties:
+- compatible : should be "st,spear1340-miphy"
+- reg : offset and length of the PHY register set.
+- misc: phandle for the syscon node to access misc registers
+- #phy-cells : from the generic PHY bindings, must be 1.
+	- cell[1]: 0 if phy used for SATA, 1 for PCIe.
diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 16a2f06..e8f8a2d 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -178,4 +178,16 @@ config PHY_XGENE
 	help
 	  This option enables support for APM X-Gene SoC multi-purpose PHY.
 
+config PHY_ST_SPEAR1310_MIPHY
+	tristate "ST SPEAR1310-MIPHY driver"
+	select GENERIC_PHY
+	help
+	  Support for ST SPEAr1310 MIPHY which can be used for PCIe and SATA.
+
+config PHY_ST_SPEAR1340_MIPHY
+	tristate "ST SPEAR1340-MIPHY driver"
+	select GENERIC_PHY
+	help
+	  Support for ST SPEAr1340 MIPHY which can be used for PCIe and SATA.
+
 endmenu
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index b4f1d57..d39609b 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -20,3 +20,5 @@ phy-exynos-usb2-$(CONFIG_PHY_EXYNOS4X12_USB2)	+= phy-exynos4x12-usb2.o
 phy-exynos-usb2-$(CONFIG_PHY_EXYNOS5250_USB2)	+= phy-exynos5250-usb2.o
 obj-$(CONFIG_PHY_EXYNOS5_USBDRD)	+= phy-exynos5-usbdrd.o
 obj-$(CONFIG_PHY_XGENE)			+= phy-xgene.o
+obj-$(CONFIG_PHY_ST_SPEAR1310_MIPHY)	+= phy-spear1310-miphy.o
+obj-$(CONFIG_PHY_ST_SPEAR1340_MIPHY)	+= phy-spear1340-miphy.o
diff --git a/drivers/phy/phy-spear1310-miphy.c b/drivers/phy/phy-spear1310-miphy.c
new file mode 100644
index 0000000..c58c869
--- /dev/null
+++ b/drivers/phy/phy-spear1310-miphy.c
@@ -0,0 +1,274 @@
+/*
+ * ST SPEAr1310-miphy driver
+ *
+ * Copyright (C) 2014 ST Microelectronics
+ * Pratyush Anand <pratyush.anand@st.com>
+ * Mohit Kumar <mohit.kumar@st.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/phy/phy.h>
+#include <linux/regmap.h>
+
+/* SPEAr1310 Registers */
+#define SPEAR1310_PCIE_SATA_CFG			0x3A4
+	#define SPEAR1310_PCIE_SATA2_SEL_PCIE		(0 << 31)
+	#define SPEAR1310_PCIE_SATA1_SEL_PCIE		(0 << 30)
+	#define SPEAR1310_PCIE_SATA0_SEL_PCIE		(0 << 29)
+	#define SPEAR1310_PCIE_SATA2_SEL_SATA		BIT(31)
+	#define SPEAR1310_PCIE_SATA1_SEL_SATA		BIT(30)
+	#define SPEAR1310_PCIE_SATA0_SEL_SATA		BIT(29)
+	#define SPEAR1310_SATA2_CFG_TX_CLK_EN		BIT(27)
+	#define SPEAR1310_SATA2_CFG_RX_CLK_EN		BIT(26)
+	#define SPEAR1310_SATA2_CFG_POWERUP_RESET	BIT(25)
+	#define SPEAR1310_SATA2_CFG_PM_CLK_EN		BIT(24)
+	#define SPEAR1310_SATA1_CFG_TX_CLK_EN		BIT(23)
+	#define SPEAR1310_SATA1_CFG_RX_CLK_EN		BIT(22)
+	#define SPEAR1310_SATA1_CFG_POWERUP_RESET	BIT(21)
+	#define SPEAR1310_SATA1_CFG_PM_CLK_EN		BIT(20)
+	#define SPEAR1310_SATA0_CFG_TX_CLK_EN		BIT(19)
+	#define SPEAR1310_SATA0_CFG_RX_CLK_EN		BIT(18)
+	#define SPEAR1310_SATA0_CFG_POWERUP_RESET	BIT(17)
+	#define SPEAR1310_SATA0_CFG_PM_CLK_EN		BIT(16)
+	#define SPEAR1310_PCIE2_CFG_DEVICE_PRESENT	BIT(11)
+	#define SPEAR1310_PCIE2_CFG_POWERUP_RESET	BIT(10)
+	#define SPEAR1310_PCIE2_CFG_CORE_CLK_EN		BIT(9)
+	#define SPEAR1310_PCIE2_CFG_AUX_CLK_EN		BIT(8)
+	#define SPEAR1310_PCIE1_CFG_DEVICE_PRESENT	BIT(7)
+	#define SPEAR1310_PCIE1_CFG_POWERUP_RESET	BIT(6)
+	#define SPEAR1310_PCIE1_CFG_CORE_CLK_EN		BIT(5)
+	#define SPEAR1310_PCIE1_CFG_AUX_CLK_EN		BIT(4)
+	#define SPEAR1310_PCIE0_CFG_DEVICE_PRESENT	BIT(3)
+	#define SPEAR1310_PCIE0_CFG_POWERUP_RESET	BIT(2)
+	#define SPEAR1310_PCIE0_CFG_CORE_CLK_EN		BIT(1)
+	#define SPEAR1310_PCIE0_CFG_AUX_CLK_EN		BIT(0)
+
+	#define SPEAR1310_PCIE_CFG_MASK(x) ((0xF << (x * 4)) | BIT((x + 29)))
+	#define SPEAR1310_SATA_CFG_MASK(x) ((0xF << (x * 4 + 16)) | \
+			BIT((x + 29)))
+	#define SPEAR1310_PCIE_CFG_VAL(x) \
+			(SPEAR1310_PCIE_SATA##x##_SEL_PCIE | \
+			SPEAR1310_PCIE##x##_CFG_AUX_CLK_EN | \
+			SPEAR1310_PCIE##x##_CFG_CORE_CLK_EN | \
+			SPEAR1310_PCIE##x##_CFG_POWERUP_RESET | \
+			SPEAR1310_PCIE##x##_CFG_DEVICE_PRESENT)
+	#define SPEAR1310_SATA_CFG_VAL(x) \
+			(SPEAR1310_PCIE_SATA##x##_SEL_SATA | \
+			SPEAR1310_SATA##x##_CFG_PM_CLK_EN | \
+			SPEAR1310_SATA##x##_CFG_POWERUP_RESET | \
+			SPEAR1310_SATA##x##_CFG_RX_CLK_EN | \
+			SPEAR1310_SATA##x##_CFG_TX_CLK_EN)
+
+#define SPEAR1310_PCIE_MIPHY_CFG_1		0x3A8
+	#define SPEAR1310_MIPHY_DUAL_OSC_BYPASS_EXT	BIT(31)
+	#define SPEAR1310_MIPHY_DUAL_CLK_REF_DIV2	BIT(28)
+	#define SPEAR1310_MIPHY_DUAL_PLL_RATIO_TOP(x)	(x << 16)
+	#define SPEAR1310_MIPHY_SINGLE_OSC_BYPASS_EXT	BIT(15)
+	#define SPEAR1310_MIPHY_SINGLE_CLK_REF_DIV2	BIT(12)
+	#define SPEAR1310_MIPHY_SINGLE_PLL_RATIO_TOP(x)	(x << 0)
+	#define SPEAR1310_PCIE_SATA_MIPHY_CFG_SATA_MASK (0xFFFF)
+	#define SPEAR1310_PCIE_SATA_MIPHY_CFG_PCIE_MASK (0xFFFF << 16)
+	#define SPEAR1310_PCIE_SATA_MIPHY_CFG_SATA \
+			(SPEAR1310_MIPHY_DUAL_OSC_BYPASS_EXT | \
+			SPEAR1310_MIPHY_DUAL_CLK_REF_DIV2 | \
+			SPEAR1310_MIPHY_DUAL_PLL_RATIO_TOP(60) | \
+			SPEAR1310_MIPHY_SINGLE_OSC_BYPASS_EXT | \
+			SPEAR1310_MIPHY_SINGLE_CLK_REF_DIV2 | \
+			SPEAR1310_MIPHY_SINGLE_PLL_RATIO_TOP(60))
+	#define SPEAR1310_PCIE_SATA_MIPHY_CFG_SATA_25M_CRYSTAL_CLK \
+			(SPEAR1310_MIPHY_SINGLE_PLL_RATIO_TOP(120))
+	#define SPEAR1310_PCIE_SATA_MIPHY_CFG_PCIE \
+			(SPEAR1310_MIPHY_DUAL_OSC_BYPASS_EXT | \
+			SPEAR1310_MIPHY_DUAL_PLL_RATIO_TOP(25) | \
+			SPEAR1310_MIPHY_SINGLE_OSC_BYPASS_EXT | \
+			SPEAR1310_MIPHY_SINGLE_PLL_RATIO_TOP(25))
+
+#define SPEAR1310_PCIE_MIPHY_CFG_2		0x3AC
+
+enum spear1310_miphy_mode {
+	SATA,
+	PCIE,
+};
+
+struct spear1310_miphy_priv {
+	/* instance id of this phy */
+	u32				id;
+	/* phy mode: 0 for SATA 1 for PCIe */
+	enum spear1310_miphy_mode	mode;
+	/* regmap for any soc specific misc registers */
+	struct regmap			*misc;
+	/* phy struct pointer */
+	struct phy			*phy;
+};
+
+static int spear1310_miphy_pcie_init(struct spear1310_miphy_priv *priv)
+{
+	u32 val;
+
+	regmap_update_bits(priv->misc, SPEAR1310_PCIE_MIPHY_CFG_1,
+			   SPEAR1310_PCIE_SATA_MIPHY_CFG_PCIE_MASK,
+			   SPEAR1310_PCIE_SATA_MIPHY_CFG_PCIE);
+
+	switch (priv->id) {
+	case 0:
+		val = SPEAR1310_PCIE_CFG_VAL(0);
+		break;
+	case 1:
+		val = SPEAR1310_PCIE_CFG_VAL(1);
+		break;
+	case 2:
+		val = SPEAR1310_PCIE_CFG_VAL(2);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	regmap_update_bits(priv->misc, SPEAR1310_PCIE_SATA_CFG,
+			   SPEAR1310_PCIE_CFG_MASK(priv->id), val);
+
+	return 0;
+}
+
+static int spear1310_miphy_pcie_exit(struct spear1310_miphy_priv *priv)
+{
+	regmap_update_bits(priv->misc, SPEAR1310_PCIE_SATA_CFG,
+			   SPEAR1310_PCIE_CFG_MASK(priv->id), 0);
+
+	regmap_update_bits(priv->misc, SPEAR1310_PCIE_MIPHY_CFG_1,
+			   SPEAR1310_PCIE_SATA_MIPHY_CFG_PCIE_MASK, 0);
+
+	return 0;
+}
+
+static int spear1310_miphy_init(struct phy *phy)
+{
+	struct spear1310_miphy_priv *priv = phy_get_drvdata(phy);
+	int ret = 0;
+
+	if (priv->mode == PCIE)
+		ret = spear1310_miphy_pcie_init(priv);
+
+	return ret;
+}
+
+static int spear1310_miphy_exit(struct phy *phy)
+{
+	struct spear1310_miphy_priv *priv = phy_get_drvdata(phy);
+	int ret = 0;
+
+	if (priv->mode == PCIE)
+		ret = spear1310_miphy_pcie_exit(priv);
+
+	return ret;
+}
+
+static const struct of_device_id spear1310_miphy_of_match[] = {
+	{ .compatible = "st,spear1310-miphy" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, spear1310_miphy_of_match);
+
+static struct phy_ops spear1310_miphy_ops = {
+	.init = spear1310_miphy_init,
+	.exit = spear1310_miphy_exit,
+	.owner = THIS_MODULE,
+};
+
+static struct phy *spear1310_miphy_xlate(struct device *dev,
+					 struct of_phandle_args *args)
+{
+	struct spear1310_miphy_priv *priv = dev_get_drvdata(dev);
+
+	if (args->args_count < 1) {
+		dev_err(dev, "DT did not pass correct no of args\n");
+		return NULL;
+	}
+
+	priv->mode = args->args[0];
+
+	if (priv->mode != SATA && priv->mode != PCIE) {
+		dev_err(dev, "DT did not pass correct phy mode\n");
+		return NULL;
+	}
+
+	return priv->phy;
+}
+
+static int spear1310_miphy_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct spear1310_miphy_priv *priv;
+	struct phy_provider *phy_provider;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv) {
+		dev_err(dev, "can't alloc spear1310_miphy private date memory\n");
+		return -ENOMEM;
+	}
+
+	priv->misc =
+		syscon_regmap_lookup_by_phandle(dev->of_node, "misc");
+	if (IS_ERR(priv->misc)) {
+		dev_err(dev, "failed to find misc regmap\n");
+		return PTR_ERR(priv->misc);
+	}
+
+	if (of_property_read_u32(dev->of_node, "phy-id", &priv->id)) {
+		dev_err(dev, "failed to find phy id\n");
+		return -EINVAL;
+	}
+
+	priv->phy = devm_phy_create(dev, &spear1310_miphy_ops, NULL);
+	if (IS_ERR(priv->phy)) {
+		dev_err(dev, "failed to create SATA PCIe PHY\n");
+		return PTR_ERR(priv->phy);
+	}
+
+	dev_set_drvdata(dev, priv);
+	phy_set_drvdata(priv->phy, priv);
+
+	phy_provider =
+		devm_of_phy_provider_register(dev, spear1310_miphy_xlate);
+	if (IS_ERR(phy_provider)) {
+		dev_err(dev, "failed to register phy provider\n");
+		return PTR_ERR(phy_provider);
+	}
+
+	return 0;
+}
+
+static struct platform_driver spear1310_miphy_driver = {
+	.probe		= spear1310_miphy_probe,
+	.driver = {
+		.name = "spear1310-miphy",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(spear1310_miphy_of_match),
+	},
+};
+
+static int __init spear1310_miphy_phy_init(void)
+{
+	return platform_driver_register(&spear1310_miphy_driver);
+}
+module_init(spear1310_miphy_phy_init);
+
+static void __exit spear1310_miphy_phy_exit(void)
+{
+	platform_driver_unregister(&spear1310_miphy_driver);
+}
+module_exit(spear1310_miphy_phy_exit);
+
+MODULE_DESCRIPTION("ST SPEAR1310-MIPHY driver");
+MODULE_AUTHOR("Pratyush Anand <pratyush.anand@st.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/phy/phy-spear1340-miphy.c b/drivers/phy/phy-spear1340-miphy.c
new file mode 100644
index 0000000..5e39231
--- /dev/null
+++ b/drivers/phy/phy-spear1340-miphy.c
@@ -0,0 +1,302 @@
+/*
+ * ST spear1340-miphy driver
+ *
+ * Copyright (C) 2014 ST Microelectronics
+ * Pratyush Anand <pratyush.anand@st.com>
+ * Mohit Kumar <mohit.kumar@st.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/phy/phy.h>
+#include <linux/regmap.h>
+
+/* SPEAr1340 Registers */
+/* Power Management Registers */
+#define SPEAR1340_PCM_CFG			0x100
+	#define SPEAR1340_PCM_CFG_SATA_POWER_EN		BIT(11)
+#define SPEAR1340_PCM_WKUP_CFG			0x104
+#define SPEAR1340_SWITCH_CTR			0x108
+
+#define SPEAR1340_PERIP1_SW_RST			0x318
+	#define SPEAR1340_PERIP1_SW_RSATA		BIT(12)
+#define SPEAR1340_PERIP2_SW_RST			0x31C
+#define SPEAR1340_PERIP3_SW_RST			0x320
+
+/* PCIE - SATA configuration registers */
+#define SPEAR1340_PCIE_SATA_CFG			0x424
+	/* PCIE CFG MASks */
+	#define SPEAR1340_PCIE_CFG_DEVICE_PRESENT	BIT(11)
+	#define SPEAR1340_PCIE_CFG_POWERUP_RESET	BIT(10)
+	#define SPEAR1340_PCIE_CFG_CORE_CLK_EN		BIT(9)
+	#define SPEAR1340_PCIE_CFG_AUX_CLK_EN		BIT(8)
+	#define SPEAR1340_SATA_CFG_TX_CLK_EN		BIT(4)
+	#define SPEAR1340_SATA_CFG_RX_CLK_EN		BIT(3)
+	#define SPEAR1340_SATA_CFG_POWERUP_RESET	BIT(2)
+	#define SPEAR1340_SATA_CFG_PM_CLK_EN		BIT(1)
+	#define SPEAR1340_PCIE_SATA_SEL_PCIE		(0)
+	#define SPEAR1340_PCIE_SATA_SEL_SATA		(1)
+	#define SPEAR1340_PCIE_SATA_CFG_MASK		0xF1F
+	#define SPEAR1340_PCIE_CFG_VAL	(SPEAR1340_PCIE_SATA_SEL_PCIE | \
+			SPEAR1340_PCIE_CFG_AUX_CLK_EN | \
+			SPEAR1340_PCIE_CFG_CORE_CLK_EN | \
+			SPEAR1340_PCIE_CFG_POWERUP_RESET | \
+			SPEAR1340_PCIE_CFG_DEVICE_PRESENT)
+	#define SPEAR1340_SATA_CFG_VAL	(SPEAR1340_PCIE_SATA_SEL_SATA | \
+			SPEAR1340_SATA_CFG_PM_CLK_EN | \
+			SPEAR1340_SATA_CFG_POWERUP_RESET | \
+			SPEAR1340_SATA_CFG_RX_CLK_EN | \
+			SPEAR1340_SATA_CFG_TX_CLK_EN)
+
+#define SPEAR1340_PCIE_MIPHY_CFG		0x428
+	#define SPEAR1340_MIPHY_OSC_BYPASS_EXT		BIT(31)
+	#define SPEAR1340_MIPHY_CLK_REF_DIV2		BIT(27)
+	#define SPEAR1340_MIPHY_CLK_REF_DIV4		(2 << 27)
+	#define SPEAR1340_MIPHY_CLK_REF_DIV8		(3 << 27)
+	#define SPEAR1340_MIPHY_PLL_RATIO_TOP(x)	(x << 0)
+	#define SPEAR1340_PCIE_MIPHY_CFG_MASK		0xF80000FF
+	#define SPEAR1340_PCIE_SATA_MIPHY_CFG_SATA \
+			(SPEAR1340_MIPHY_OSC_BYPASS_EXT | \
+			SPEAR1340_MIPHY_CLK_REF_DIV2 | \
+			SPEAR1340_MIPHY_PLL_RATIO_TOP(60))
+	#define SPEAR1340_PCIE_SATA_MIPHY_CFG_SATA_25M_CRYSTAL_CLK \
+			(SPEAR1340_MIPHY_PLL_RATIO_TOP(120))
+	#define SPEAR1340_PCIE_SATA_MIPHY_CFG_PCIE \
+			(SPEAR1340_MIPHY_OSC_BYPASS_EXT | \
+			SPEAR1340_MIPHY_PLL_RATIO_TOP(25))
+
+enum spear1340_miphy_mode {
+	SATA,
+	PCIE,
+};
+
+struct spear1340_miphy_priv {
+	/* phy mode: 0 for SATA 1 for PCIe */
+	enum spear1340_miphy_mode	mode;
+	/* regmap for any soc specific misc registers */
+	struct regmap			*misc;
+	/* phy struct pointer */
+	struct phy			*phy;
+};
+
+static int spear1340_miphy_sata_init(struct spear1340_miphy_priv *priv)
+{
+	regmap_update_bits(priv->misc, SPEAR1340_PCIE_SATA_CFG,
+			   SPEAR1340_PCIE_SATA_CFG_MASK,
+			   SPEAR1340_SATA_CFG_VAL);
+	regmap_update_bits(priv->misc, SPEAR1340_PCIE_MIPHY_CFG,
+			   SPEAR1340_PCIE_MIPHY_CFG_MASK,
+			   SPEAR1340_PCIE_SATA_MIPHY_CFG_SATA_25M_CRYSTAL_CLK);
+	/* Switch on sata power domain */
+	regmap_update_bits(priv->misc, SPEAR1340_PCM_CFG,
+			   SPEAR1340_PCM_CFG_SATA_POWER_EN,
+			   SPEAR1340_PCM_CFG_SATA_POWER_EN);
+	msleep(20);
+	/* Disable PCIE SATA Controller reset */
+	regmap_update_bits(priv->misc, SPEAR1340_PERIP1_SW_RST,
+			   SPEAR1340_PERIP1_SW_RSATA, 0);
+	msleep(20);
+
+	return 0;
+}
+
+static int spear1340_miphy_sata_exit(struct spear1340_miphy_priv *priv)
+{
+	regmap_update_bits(priv->misc, SPEAR1340_PCIE_SATA_CFG,
+			   SPEAR1340_PCIE_SATA_CFG_MASK, 0);
+	regmap_update_bits(priv->misc, SPEAR1340_PCIE_MIPHY_CFG,
+			   SPEAR1340_PCIE_MIPHY_CFG_MASK, 0);
+
+	/* Enable PCIE SATA Controller reset */
+	regmap_update_bits(priv->misc, SPEAR1340_PERIP1_SW_RST,
+			   SPEAR1340_PERIP1_SW_RSATA,
+			   SPEAR1340_PERIP1_SW_RSATA);
+	msleep(20);
+	/* Switch off sata power domain */
+	regmap_update_bits(priv->misc, SPEAR1340_PCM_CFG,
+			   SPEAR1340_PCM_CFG_SATA_POWER_EN, 0);
+	msleep(20);
+
+	return 0;
+}
+
+static int spear1340_miphy_pcie_init(struct spear1340_miphy_priv *priv)
+{
+	regmap_update_bits(priv->misc, SPEAR1340_PCIE_MIPHY_CFG,
+			   SPEAR1340_PCIE_MIPHY_CFG_MASK,
+			   SPEAR1340_PCIE_SATA_MIPHY_CFG_PCIE);
+	regmap_update_bits(priv->misc, SPEAR1340_PCIE_SATA_CFG,
+			   SPEAR1340_PCIE_SATA_CFG_MASK,
+			   SPEAR1340_PCIE_CFG_VAL);
+
+	return 0;
+}
+
+static int spear1340_miphy_pcie_exit(struct spear1340_miphy_priv *priv)
+{
+	regmap_update_bits(priv->misc, SPEAR1340_PCIE_MIPHY_CFG,
+			   SPEAR1340_PCIE_MIPHY_CFG_MASK, 0);
+	regmap_update_bits(priv->misc, SPEAR1340_PCIE_SATA_CFG,
+			   SPEAR1340_PCIE_SATA_CFG_MASK, 0);
+
+	return 0;
+}
+
+static int spear1340_miphy_init(struct phy *phy)
+{
+	struct spear1340_miphy_priv *priv = phy_get_drvdata(phy);
+	int ret = 0;
+
+	if (priv->mode == SATA)
+		ret = spear1340_miphy_sata_init(priv);
+	else if (priv->mode == PCIE)
+		ret = spear1340_miphy_pcie_init(priv);
+
+	return ret;
+}
+
+static int spear1340_miphy_exit(struct phy *phy)
+{
+	struct spear1340_miphy_priv *priv = phy_get_drvdata(phy);
+	int ret = 0;
+
+	if (priv->mode == SATA)
+		ret = spear1340_miphy_sata_exit(priv);
+	else if (priv->mode == PCIE)
+		ret = spear1340_miphy_pcie_exit(priv);
+
+	return ret;
+}
+
+static const struct of_device_id spear1340_miphy_of_match[] = {
+	{ .compatible = "st,spear1340-miphy" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, spear1340_miphy_of_match);
+
+static struct phy_ops spear1340_miphy_ops = {
+	.init = spear1340_miphy_init,
+	.exit = spear1340_miphy_exit,
+	.owner = THIS_MODULE,
+};
+
+#ifdef CONFIG_PM_SLEEP
+static int spear1340_miphy_suspend(struct device *dev)
+{
+	struct spear1340_miphy_priv *priv = dev_get_drvdata(dev);
+	int ret = 0;
+
+	if (priv->mode == SATA)
+		ret = spear1340_miphy_sata_exit(priv);
+
+	return ret;
+}
+
+static int spear1340_miphy_resume(struct device *dev)
+{
+	struct spear1340_miphy_priv *priv = dev_get_drvdata(dev);
+	int ret = 0;
+
+	if (priv->mode == SATA)
+		ret = spear1340_miphy_sata_init(priv);
+
+	return ret;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(spear1340_miphy_pm_ops, spear1340_miphy_suspend,
+			 spear1340_miphy_resume);
+
+static struct phy *spear1340_miphy_xlate(struct device *dev,
+					 struct of_phandle_args *args)
+{
+	struct spear1340_miphy_priv *priv = dev_get_drvdata(dev);
+
+	if (args->args_count < 1) {
+		dev_err(dev, "DT did not pass correct no of args\n");
+		return NULL;
+	}
+
+	priv->mode = args->args[0];
+
+	if (priv->mode != SATA && priv->mode != PCIE) {
+		dev_err(dev, "DT did not pass correct phy mode\n");
+		return NULL;
+	}
+
+	return priv->phy;
+}
+
+static int spear1340_miphy_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct spear1340_miphy_priv *priv;
+	struct phy_provider *phy_provider;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv) {
+		dev_err(dev, "can't alloc spear1340_miphy private date memory\n");
+		return -ENOMEM;
+	}
+
+	priv->misc =
+		syscon_regmap_lookup_by_phandle(dev->of_node, "misc");
+	if (IS_ERR(priv->misc)) {
+		dev_err(dev, "failed to find misc regmap\n");
+		return PTR_ERR(priv->misc);
+	}
+
+	priv->phy = devm_phy_create(dev, &spear1340_miphy_ops, NULL);
+	if (IS_ERR(priv->phy)) {
+		dev_err(dev, "failed to create SATA PCIe PHY\n");
+		return PTR_ERR(priv->phy);
+	}
+
+	dev_set_drvdata(dev, priv);
+	phy_set_drvdata(priv->phy, priv);
+
+	phy_provider =
+		devm_of_phy_provider_register(dev, spear1340_miphy_xlate);
+	if (IS_ERR(phy_provider)) {
+		dev_err(dev, "failed to register phy provider\n");
+		return PTR_ERR(phy_provider);
+	}
+
+	return 0;
+}
+
+static struct platform_driver spear1340_miphy_driver = {
+	.probe		= spear1340_miphy_probe,
+	.driver = {
+		.name = "spear1340-miphy",
+		.owner = THIS_MODULE,
+		.pm = &spear1340_miphy_pm_ops,
+		.of_match_table = of_match_ptr(spear1340_miphy_of_match),
+	},
+};
+
+static int __init spear1340_miphy_phy_init(void)
+{
+	return platform_driver_register(&spear1340_miphy_driver);
+}
+module_init(spear1340_miphy_phy_init);
+
+static void __exit spear1340_miphy_phy_exit(void)
+{
+	platform_driver_unregister(&spear1340_miphy_driver);
+}
+module_exit(spear1340_miphy_phy_exit);
+
+MODULE_DESCRIPTION("ST SPEAR1340-MIPHY driver");
+MODULE_AUTHOR("Pratyush Anand <pratyush.anand@st.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.0.0.rc2

