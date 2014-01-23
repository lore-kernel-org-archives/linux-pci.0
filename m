Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog117.obsmtp.com ([207.126.144.143]:39555 "EHLO
	eu1sys200aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754711AbaAWKdk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jan 2014 05:33:40 -0500
From: Mohit Kumar <mohit.kumar@st.com>
Cc: Pratyush Anand <pratyush.anand@st.com>,
	Mohit Kumar <mohit.kumar@st.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Viresh Kumar <viresh.linux@gmail.com>,
	<spear-devel@list.st.com>, <linux-pci@vger.kernel.org>
Subject: [PATCH V2 7/8] pcie: SPEAr13xx: Add designware pcie support
Date: Thu, 23 Jan 2014 16:02:47 +0530
Message-ID: <59f1ee2335f1f49913d5ed77213880f868987e96.1390471111.git.mohit.kumar@st.com>
In-Reply-To: <cover.1390471111.git.mohit.kumar@st.com>
References: <cover.1390471111.git.mohit.kumar@st.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: unlisted-recipients:; (no To-header on input)
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Pratyush Anand <pratyush.anand@st.com>

SPEAr1310 and SPEAr1340 SOC uses designware PCIe controller. Add
SPEAr13xx PCIe driver based on designware controller driver.

SPEAr1310 has 3 PCIe ports and SPEAr1340 has 1, which are multiplexed
with ahci/sata pins. By default evaluation board of both controller
works for ahci mode.
To use these patches on SPEAr1340/1310 evaluation board, do the
necessary modifications on board and enable (okay) pcie from respective
evb dtsi file.

Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
Signed-off-by: Mohit Kumar <mohit.kumar@st.com>
Cc: Mohit Kumar <mohit.kumar@st.com>
Cc: Jingoo Han <jg1.han@samsung.com>
Cc: Viresh Kumar <viresh.linux@gmail.com>
Cc: spear-devel@list.st.com
Cc: linux-pci@vger.kernel.org
---
 arch/arm/boot/dts/spear13xx.dtsi     |   53 +++++-
 arch/arm/configs/spear13xx_defconfig |    2 +
 arch/arm/mach-spear/Kconfig          |    1 +
 drivers/mfd/spear13xx-cfg.c          |  205 ++++++++++++++++++
 drivers/pci/host/Kconfig             |    5 +
 drivers/pci/host/Makefile            |    1 +
 drivers/pci/host/pcie-spear13xx.c    |  394 ++++++++++++++++++++++++++++++++++
 7 files changed, 659 insertions(+), 2 deletions(-)
 create mode 100644 drivers/pci/host/pcie-spear13xx.c

diff --git a/arch/arm/boot/dts/spear13xx.dtsi b/arch/arm/boot/dts/spear13xx.dtsi
index 2b4e58e..87d7aba 100644
--- a/arch/arm/boot/dts/spear13xx.dtsi
+++ b/arch/arm/boot/dts/spear13xx.dtsi
@@ -87,8 +87,8 @@
 		#size-cells = <1>;
 		compatible = "simple-bus";
 		ranges = <0x50000000 0x50000000 0x10000000
-			  0xb0000000 0xb0000000 0x10000000
-			  0xd0000000 0xd0000000 0x02000000
+			  0x80000000 0x80000000 0x20000000
+			  0xb0000000 0xb0000000 0x22000000
 			  0xd8000000 0xd8000000 0x01000000
 			  0xe0000000 0xe0000000 0x10000000>;
 
@@ -215,6 +215,54 @@
 			status = "disabled";
 		};
 
+		pcie@b1000000 {
+			compatible = "st,spear13xx-pcie", "snps,dw-pcie";
+			reg = <0xb1000000 0x4000>;
+			interrupts = <0 68 0x4>;
+			pcie_id = <0>;
+			pcie_is_gen1 = <0>;
+			num-lanes = <1>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			ranges = <0x00000800 0 0x80000000 0x80000000 0 0x00020000   /* configuration space */
+				0x81000000 0 0	 0x80020000 0 0x00010000   /* downstream I/O */
+				0x82000000 0 0x80030000 0xc0030000 0 0x0ffd0000>; /* non-prefetchable memory */
+			status = "disabled";
+		};
+
+		pcie@b1800000 {
+			compatible = "st,spear13xx-pcie", "snps,dw-pcie";
+			reg = <0xb1800000 0x4000>;
+			interrupts = <0 69 0x4>;
+			pcie_id = <1>;
+			pcie_is_gen1 = <0>;
+			num-lanes = <1>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			ranges = <0x00000800 0 0x90000000 0x90000000 0 0x00020000   /* configuration space */
+				0x81000000 0 0  0x90020000 0 0x00010000   /* downstream I/O */
+				0x82000000 0 0x90030000 0x90030000 0 0x0ffd0000>; /* non-prefetchable memory */
+			status = "disabled";
+		};
+
+		pcie@b4000000 {
+			compatible = "st,spear13xx-pcie", "snps,dw-pcie";
+			reg = <0xb4000000 0x4000>;
+			interrupts = <0 70 0x4>;
+			pcie_id = <2>;
+			pcie_is_gen1 = <0>;
+			num-lanes = <1>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			ranges = <0x00000800 0 0xc0000000 0xc0000000 0 0x00020000   /* configuration space */
+				0x81000000 0 0	 0xc0020000 0 0x00010000   /* downstream I/O */
+				0x82000000 0 0xc0030000 0xc0030000 0 0x0ffd0000>; /* non-prefetchable memory */
+			status = "disabled";
+		};
+
 		apb {
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -343,6 +391,7 @@
 				reg = <0xe07008c4 0x4>;
 				thermal_flags = <0x7000>;
 			};
+
 		};
 	};
 };
diff --git a/arch/arm/configs/spear13xx_defconfig b/arch/arm/configs/spear13xx_defconfig
index 0cf87d0..41cfb4f 100644
--- a/arch/arm/configs/spear13xx_defconfig
+++ b/arch/arm/configs/spear13xx_defconfig
@@ -11,6 +11,8 @@ CONFIG_ARCH_SPEAR13XX=y
 CONFIG_MACH_SPEAR1310=y
 CONFIG_MACH_SPEAR1340=y
 # CONFIG_SWP_EMULATE is not set
+CONFIG_PCI_MSI=y
+CONFIG_PCIE_SPEAR13XX=y
 CONFIG_SMP=y
 # CONFIG_SMP_ON_UP is not set
 # CONFIG_ARM_CPU_TOPOLOGY is not set
diff --git a/arch/arm/mach-spear/Kconfig b/arch/arm/mach-spear/Kconfig
index dedcafb..16de32e 100644
--- a/arch/arm/mach-spear/Kconfig
+++ b/arch/arm/mach-spear/Kconfig
@@ -27,6 +27,7 @@ config ARCH_SPEAR13XX
 	select PINCTRL
 	select USE_OF
 	select MFD_SYSCON
+	select PCI
 	help
 	  Supports for ARM's SPEAR13XX family
 
diff --git a/drivers/mfd/spear13xx-cfg.c b/drivers/mfd/spear13xx-cfg.c
index 1cf5785..8809079 100644
--- a/drivers/mfd/spear13xx-cfg.c
+++ b/drivers/mfd/spear13xx-cfg.c
@@ -72,6 +72,80 @@
 	#define SPEAR1340_PCIE_SATA_MIPHY_CFG_PCIE \
 			(SPEAR1340_MIPHY_OSC_BYPASS_EXT | \
 			SPEAR1340_MIPHY_PLL_RATIO_TOP(25))
+/* SPEAr1310 Registers */
+#define SPEAR1310_PCIE_SATA_CFG			0x3A4
+	#define SPEAR1310_PCIE_SATA2_SEL_PCIE		(0 << 31)
+	#define SPEAR1310_PCIE_SATA1_SEL_PCIE		(0 << 30)
+	#define SPEAR1310_PCIE_SATA0_SEL_PCIE		(0 << 29)
+	#define SPEAR1310_PCIE_SATA2_SEL_SATA		(1 << 31)
+	#define SPEAR1310_PCIE_SATA1_SEL_SATA		(1 << 30)
+	#define SPEAR1310_PCIE_SATA0_SEL_SATA		(1 << 29)
+	#define SPEAR1310_SATA2_CFG_TX_CLK_EN		(1 << 27)
+	#define SPEAR1310_SATA2_CFG_RX_CLK_EN		(1 << 26)
+	#define SPEAR1310_SATA2_CFG_POWERUP_RESET	(1 << 25)
+	#define SPEAR1310_SATA2_CFG_PM_CLK_EN		(1 << 24)
+	#define SPEAR1310_SATA1_CFG_TX_CLK_EN		(1 << 23)
+	#define SPEAR1310_SATA1_CFG_RX_CLK_EN		(1 << 22)
+	#define SPEAR1310_SATA1_CFG_POWERUP_RESET	(1 << 21)
+	#define SPEAR1310_SATA1_CFG_PM_CLK_EN		(1 << 20)
+	#define SPEAR1310_SATA0_CFG_TX_CLK_EN		(1 << 19)
+	#define SPEAR1310_SATA0_CFG_RX_CLK_EN		(1 << 18)
+	#define SPEAR1310_SATA0_CFG_POWERUP_RESET	(1 << 17)
+	#define SPEAR1310_SATA0_CFG_PM_CLK_EN		(1 << 16)
+	#define SPEAR1310_PCIE2_CFG_DEVICE_PRESENT	(1 << 11)
+	#define SPEAR1310_PCIE2_CFG_POWERUP_RESET	(1 << 10)
+	#define SPEAR1310_PCIE2_CFG_CORE_CLK_EN		(1 << 9)
+	#define SPEAR1310_PCIE2_CFG_AUX_CLK_EN		(1 << 8)
+	#define SPEAR1310_PCIE1_CFG_DEVICE_PRESENT	(1 << 7)
+	#define SPEAR1310_PCIE1_CFG_POWERUP_RESET	(1 << 6)
+	#define SPEAR1310_PCIE1_CFG_CORE_CLK_EN		(1 << 5)
+	#define SPEAR1310_PCIE1_CFG_AUX_CLK_EN		(1 << 4)
+	#define SPEAR1310_PCIE0_CFG_DEVICE_PRESENT	(1 << 3)
+	#define SPEAR1310_PCIE0_CFG_POWERUP_RESET	(1 << 2)
+	#define SPEAR1310_PCIE0_CFG_CORE_CLK_EN		(1 << 1)
+	#define SPEAR1310_PCIE0_CFG_AUX_CLK_EN		(1 << 0)
+
+	#define SPEAR1310_PCIE_CFG_MASK(x) ((0xF << (x * 4)) | (1 << (x + 29)))
+	#define SPEAR1310_SATA_CFG_MASK(x) ((0xF << (x * 4 + 16)) | \
+			(1 << (x + 29)))
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
+	#define SPEAR1310_MIPHY_DUAL_OSC_BYPASS_EXT	(1 << 31)
+	#define SPEAR1310_MIPHY_DUAL_CLK_REF_DIV2	(1 << 28)
+	#define SPEAR1310_MIPHY_DUAL_PLL_RATIO_TOP(x)	(x << 16)
+	#define SPEAR1310_MIPHY_SINGLE_OSC_BYPASS_EXT	(1 << 15)
+	#define SPEAR1310_MIPHY_SINGLE_CLK_REF_DIV2	(1 << 12)
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
 
 struct spear13xx_cfg_priv {
 	struct regmap		*misc;
@@ -162,6 +236,108 @@ static struct ahci_platform_data sata_pdata = {
 	.resume = sata_resume,
 };
 
+static int spear1340_pcie_miphy_init(struct device_node *np,
+		struct spear13xx_cfg_priv *cfgpriv)
+{
+	regmap_update_bits(cfgpriv->misc, SPEAR1340_PCIE_MIPHY_CFG,
+			SPEAR1340_PCIE_MIPHY_CFG_MASK,
+			SPEAR1340_PCIE_SATA_MIPHY_CFG_PCIE);
+	regmap_update_bits(cfgpriv->misc, SPEAR1340_PCIE_SATA_CFG,
+			SPEAR1340_PCIE_SATA_CFG_MASK, SPEAR1340_PCIE_CFG_VAL);
+
+	return 0;
+}
+
+static void spear1340_pcie_miphy_exit(struct device_node *np,
+		struct spear13xx_cfg_priv *cfgpriv)
+{
+	regmap_update_bits(cfgpriv->misc, SPEAR1340_PCIE_MIPHY_CFG,
+			SPEAR1340_PCIE_MIPHY_CFG_MASK, 0);
+	regmap_update_bits(cfgpriv->misc, SPEAR1340_PCIE_SATA_CFG,
+			SPEAR1340_PCIE_SATA_CFG_MASK, 0);
+}
+
+static int spear1310_pcie_miphy_init(struct device_node *np,
+		struct spear13xx_cfg_priv *cfgpriv)
+{
+	u32 id, mask, val;
+
+	regmap_update_bits(cfgpriv->misc, SPEAR1310_PCIE_MIPHY_CFG_1,
+			SPEAR1310_PCIE_SATA_MIPHY_CFG_PCIE_MASK,
+			SPEAR1310_PCIE_SATA_MIPHY_CFG_PCIE);
+
+	of_property_read_u32(np, "pcie_id", &id);
+
+	switch (id) {
+	case 0:
+		mask = SPEAR1310_PCIE_CFG_MASK(0);
+		val = SPEAR1310_PCIE_CFG_VAL(0);
+		break;
+	case 1:
+		mask = SPEAR1310_PCIE_CFG_MASK(1);
+		val = SPEAR1310_PCIE_CFG_VAL(1);
+		break;
+	case 2:
+		mask = SPEAR1310_PCIE_CFG_MASK(2);
+		val = SPEAR1310_PCIE_CFG_VAL(2);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	regmap_update_bits(cfgpriv->misc, SPEAR1310_PCIE_SATA_CFG, mask, val);
+
+	return 0;
+}
+
+static void spear1310_pcie_miphy_exit(struct device_node *np,
+		struct spear13xx_cfg_priv *cfgpriv)
+{
+	u32 id, mask;
+
+	of_property_read_u32(np, "pcie_id", &id);
+
+	switch (id) {
+	case 0:
+		mask = SPEAR1310_PCIE_CFG_MASK(0);
+		break;
+	case 1:
+		mask = SPEAR1310_PCIE_CFG_MASK(1);
+		break;
+	case 2:
+		mask = SPEAR1310_PCIE_CFG_MASK(2);
+		break;
+	}
+
+	regmap_update_bits(cfgpriv->misc, SPEAR1310_PCIE_SATA_CFG,
+			SPEAR1310_PCIE_CFG_MASK(id), 0);
+
+	regmap_update_bits(cfgpriv->misc, SPEAR1310_PCIE_MIPHY_CFG_1,
+			SPEAR1310_PCIE_SATA_MIPHY_CFG_PCIE_MASK, 0);
+}
+
+static int pcie_miphy_init(struct device_node *np,
+		struct spear13xx_cfg_priv *cfgpriv)
+{
+	int ret = -EINVAL;
+
+	if (of_machine_is_compatible("st,spear1340"))
+		ret = spear1340_pcie_miphy_init(np, cfgpriv);
+	else if (of_machine_is_compatible("st,spear1310"))
+		ret = spear1310_pcie_miphy_init(np, cfgpriv);
+
+	return ret;
+}
+
+static void pcie_miphy_exit(struct device_node *np,
+		struct spear13xx_cfg_priv *cfgpriv)
+{
+	if (of_machine_is_compatible("st,spear1340"))
+		spear1340_pcie_miphy_exit(np, cfgpriv);
+	else if (of_machine_is_compatible("st,spear1310"))
+		spear1310_pcie_miphy_exit(np, cfgpriv);
+}
+
 static const struct of_device_id spear13xx_cfg_of_match[] = {
 	{ .compatible = "st,spear13xx-cfg" },
 	{ },
@@ -174,6 +350,7 @@ static int __init spear13xx_cfg_probe(struct platform_device *pdev)
 	struct ahci_platform_data *ahci_pdata = &sata_pdata;
 	struct spear13xx_cfg_priv *cfgpriv;
 	struct device_node *np_ahci;
+	struct device_node *np_pcie;
 	struct platform_device *ahci_pdev;
 	int ret = 0;
 
@@ -190,6 +367,8 @@ static int __init spear13xx_cfg_probe(struct platform_device *pdev)
 		return PTR_ERR(cfgpriv->misc);
 	}
 
+	platform_set_drvdata(pdev, cfgpriv);
+
 	np_ahci = of_find_node_by_name(NULL, "ahci");
 	while (!IS_ERR_OR_NULL(np_ahci)) {
 		if (of_device_is_available(np_ahci)) {
@@ -209,11 +388,37 @@ static int __init spear13xx_cfg_probe(struct platform_device *pdev)
 		np_ahci = of_find_node_by_name(np_ahci, "ahci");
 	}
 
+	np_pcie = of_find_node_by_name(NULL, "pcie");
+	while (!IS_ERR_OR_NULL(np_pcie)) {
+		/*
+		 * There is a pcie node also in pinmux group. So, on top
+		 * of of_device_is_available we also check if parent
+		 * node is ahb and not pinmux.
+		 */
+		if (of_device_is_available(np_pcie) &&
+			of_node_cmp(np_pcie->parent->full_name, "/ahb") == 0)
+			pcie_miphy_init(np_pcie, cfgpriv);
+
+		np_pcie = of_find_node_by_name(np_pcie, "pcie");
+	}
+
 	return ret;
 }
 
 static int __exit spear13xx_cfg_remove(struct platform_device *pdev)
 {
+	struct spear13xx_cfg_priv *cfgpriv = platform_get_drvdata(pdev);
+	struct device_node *np_pcie;
+
+	np_pcie = of_find_node_by_name(NULL, "pcie");
+	while (!IS_ERR_OR_NULL(np_pcie)) {
+		if (of_device_is_available(np_pcie) &&
+			of_node_cmp(np_pcie->parent->full_name, "/ahb") == 0)
+			pcie_miphy_exit(np_pcie, cfgpriv);
+
+		np_pcie = of_find_node_by_name(np_pcie, "pcie");
+	}
+
 	return 0;
 }
 
diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 47d46c6..df52fad 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -33,4 +33,9 @@ config PCI_RCAR_GEN2
 	  There are 3 internal PCI controllers available with a single
 	  built-in EHCI/OHCI host controller present on each one.
 
+config PCIE_SPEAR13XX
+	bool "STMicroelectronics SPEAr PCIe controller"
+	depends on ARCH_SPEAR13XX
+	select PCIEPORTBUS
+	select PCIE_DW
 endmenu
diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
index 13fb333..42a491d 100644
--- a/drivers/pci/host/Makefile
+++ b/drivers/pci/host/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_PCI_IMX6) += pci-imx6.o
 obj-$(CONFIG_PCI_MVEBU) += pci-mvebu.o
 obj-$(CONFIG_PCI_TEGRA) += pci-tegra.o
 obj-$(CONFIG_PCI_RCAR_GEN2) += pci-rcar-gen2.o
+obj-$(CONFIG_PCIE_SPEAR13XX) += pcie-spear13xx.o
diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/host/pcie-spear13xx.c
new file mode 100644
index 0000000..46b0798
--- /dev/null
+++ b/drivers/pci/host/pcie-spear13xx.c
@@ -0,0 +1,394 @@
+/*
+ * PCIe host controller driver for ST Microelectronics SPEAr13xx SoCs
+ *
+ * SPEAr13xx PCIe Glue Layer Source Code
+ *
+ * Copyright (C) 2010-2014 ST Microelectronics
+ * Pratyush Anand <pratyush.anand@st.com>
+ *
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/resource.h>
+
+#include "pcie-designware.h"
+
+struct spear13xx_pcie {
+	void __iomem		*app_base;
+	struct clk		*clk;
+	struct pcie_port	pp;
+	int			id;
+	int			is_gen1;
+};
+
+struct pcie_app_reg {
+	u32	app_ctrl_0;		/*cr0*/
+	u32	app_ctrl_1;		/*cr1*/
+	u32	app_status_0;		/*cr2*/
+	u32	app_status_1;		/*cr3*/
+	u32	msg_status;		/*cr4*/
+	u32	msg_payload;		/*cr5*/
+	u32	int_sts;		/*cr6*/
+	u32	int_clr;		/*cr7*/
+	u32	int_mask;		/*cr8*/
+	u32	mst_bmisc;		/*cr9*/
+	u32	phy_ctrl;		/*cr10*/
+	u32	phy_status;		/*cr11*/
+	u32	cxpl_debug_info_0;	/*cr12*/
+	u32	cxpl_debug_info_1;	/*cr13*/
+	u32	ven_msg_ctrl_0;		/*cr14*/
+	u32	ven_msg_ctrl_1;		/*cr15*/
+	u32	ven_msg_data_0;		/*cr16*/
+	u32	ven_msg_data_1;		/*cr17*/
+	u32	ven_msi_0;		/*cr18*/
+	u32	ven_msi_1;		/*cr19*/
+	u32	mst_rmisc;		/*cr 20*/
+};
+
+/*CR0 ID*/
+#define RX_LANE_FLIP_EN_ID			0
+#define TX_LANE_FLIP_EN_ID			1
+#define SYS_AUX_PWR_DET_ID			2
+#define APP_LTSSM_ENABLE_ID			3
+#define SYS_ATTEN_BUTTON_PRESSED_ID		4
+#define SYS_MRL_SENSOR_STATE_ID			5
+#define SYS_PWR_FAULT_DET_ID			6
+#define SYS_MRL_SENSOR_CHGED_ID			7
+#define SYS_PRE_DET_CHGED_ID			8
+#define SYS_CMD_CPLED_INT_ID			9
+#define APP_INIT_RST_0_ID			11
+#define APP_REQ_ENTR_L1_ID			12
+#define APP_READY_ENTR_L23_ID			13
+#define APP_REQ_EXIT_L1_ID			14
+#define DEVICE_TYPE_EP				(0 << 25)
+#define DEVICE_TYPE_LEP				(1 << 25)
+#define DEVICE_TYPE_RC				(4 << 25)
+#define SYS_INT_ID				29
+#define MISCTRL_EN_ID				30
+#define REG_TRANSLATION_ENABLE			31
+
+/*CR1 ID*/
+#define APPS_PM_XMT_TURNOFF_ID			2
+#define APPS_PM_XMT_PME_ID			5
+
+/*CR3 ID*/
+#define XMLH_LTSSM_STATE_DETECT_QUIET		0x00
+#define XMLH_LTSSM_STATE_DETECT_ACT		0x01
+#define XMLH_LTSSM_STATE_POLL_ACTIVE		0x02
+#define XMLH_LTSSM_STATE_POLL_COMPLIANCE	0x03
+#define XMLH_LTSSM_STATE_POLL_CONFIG		0x04
+#define XMLH_LTSSM_STATE_PRE_DETECT_QUIET	0x05
+#define XMLH_LTSSM_STATE_DETECT_WAIT		0x06
+#define XMLH_LTSSM_STATE_CFG_LINKWD_START	0x07
+#define XMLH_LTSSM_STATE_CFG_LINKWD_ACEPT	0x08
+#define XMLH_LTSSM_STATE_CFG_LANENUM_WAIT	0x09
+#define XMLH_LTSSM_STATE_CFG_LANENUM_ACEPT	0x0A
+#define XMLH_LTSSM_STATE_CFG_COMPLETE		0x0B
+#define XMLH_LTSSM_STATE_CFG_IDLE		0x0C
+#define XMLH_LTSSM_STATE_RCVRY_LOCK		0x0D
+#define XMLH_LTSSM_STATE_RCVRY_SPEED		0x0E
+#define XMLH_LTSSM_STATE_RCVRY_RCVRCFG		0x0F
+#define XMLH_LTSSM_STATE_RCVRY_IDLE		0x10
+#define XMLH_LTSSM_STATE_L0			0x11
+#define XMLH_LTSSM_STATE_L0S			0x12
+#define XMLH_LTSSM_STATE_L123_SEND_EIDLE	0x13
+#define XMLH_LTSSM_STATE_L1_IDLE		0x14
+#define XMLH_LTSSM_STATE_L2_IDLE		0x15
+#define XMLH_LTSSM_STATE_L2_WAKE		0x16
+#define XMLH_LTSSM_STATE_DISABLED_ENTRY		0x17
+#define XMLH_LTSSM_STATE_DISABLED_IDLE		0x18
+#define XMLH_LTSSM_STATE_DISABLED		0x19
+#define XMLH_LTSSM_STATE_LPBK_ENTRY		0x1A
+#define XMLH_LTSSM_STATE_LPBK_ACTIVE		0x1B
+#define XMLH_LTSSM_STATE_LPBK_EXIT		0x1C
+#define XMLH_LTSSM_STATE_LPBK_EXIT_TIMEOUT	0x1D
+#define XMLH_LTSSM_STATE_HOT_RESET_ENTRY	0x1E
+#define XMLH_LTSSM_STATE_HOT_RESET		0x1F
+#define XMLH_LTSSM_STATE_MASK			0x3F
+#define XMLH_LINK_UP				(1 << 6)
+
+/*CR4 ID*/
+#define CFG_MSI_EN_ID				18
+
+/*CR6*/
+#define INTA_CTRL_INT				(1 << 7)
+#define INTB_CTRL_INT				(1 << 8)
+#define INTC_CTRL_INT				(1 << 9)
+#define INTD_CTRL_INT				(1 << 10)
+#define MSI_CTRL_INT				(1 << 26)
+
+/*CR19 ID*/
+#define VEN_MSI_REQ_ID				11
+#define VEN_MSI_FUN_NUM_ID			8
+#define VEN_MSI_TC_ID				5
+#define VEN_MSI_VECTOR_ID			0
+#define VEN_MSI_REQ_EN		((u32)0x1 << VEN_MSI_REQ_ID)
+#define VEN_MSI_FUN_NUM_MASK	((u32)0x7 << VEN_MSI_FUN_NUM_ID)
+#define VEN_MSI_TC_MASK		((u32)0x7 << VEN_MSI_TC_ID)
+#define VEN_MSI_VECTOR_MASK	((u32)0x1F << VEN_MSI_VECTOR_ID)
+
+#define PCI_CAP_ID_EXP_OFFSET			0x70
+
+#define to_spear13xx_pcie(x)	container_of(x, struct spear13xx_pcie, pp)
+
+static int spear13xx_pcie_establish_link(struct pcie_port *pp)
+{
+	u32 val;
+	int count = 0;
+	struct spear13xx_pcie *spear13xx_pcie = to_spear13xx_pcie(pp);
+	struct pcie_app_reg *app_reg = spear13xx_pcie->app_base;
+	u32 exp_cap_off = PCI_CAP_ID_EXP_OFFSET;
+
+	if (dw_pcie_link_up(pp)) {
+		dev_err(pp->dev, "Link already up\n");
+		return 0;
+	}
+
+	/* setup root complex */
+	dw_pcie_setup_rc(pp);
+
+	/*
+	 * this controller support only 128 bytes read size, however its
+	 * default value in capability register is 512 bytes. So force
+	 * it to 128 here.
+	 */
+	dw_pcie_cfg_read(pp->dbi_base, exp_cap_off + PCI_EXP_DEVCTL, 4, &val);
+	val &= ~PCI_EXP_DEVCTL_READRQ;
+	dw_pcie_cfg_write(pp->dbi_base, exp_cap_off + PCI_EXP_DEVCTL, 4, val);
+
+	/* program vid and did for RC */
+	dw_pcie_cfg_write(pp->dbi_base, PCI_VENDOR_ID, 2, 0x104A);
+	dw_pcie_cfg_write(pp->dbi_base, PCI_DEVICE_ID, 2, 0xCD80);
+
+	/*
+	 * if is_gen1 is set then handle it, so that some buggy card
+	 * also works
+	 */
+	if (spear13xx_pcie->is_gen1) {
+		dw_pcie_cfg_read(pp->dbi_base, exp_cap_off + PCI_EXP_LNKCAP, 4,
+				&val);
+		if ((val & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_2_5GB) {
+			val &= ~((u32)PCI_EXP_LNKCAP_SLS);
+			val |= PCI_EXP_LNKCAP_SLS_2_5GB;
+			dw_pcie_cfg_write(pp->dbi_base, exp_cap_off +
+					PCI_EXP_LNKCAP, 4, val);
+		}
+
+		dw_pcie_cfg_read(pp->dbi_base, exp_cap_off + PCI_EXP_LNKCTL2, 4,
+				&val);
+		if ((val & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_2_5GB) {
+			val &= ~((u32)PCI_EXP_LNKCAP_SLS);
+			val |= PCI_EXP_LNKCAP_SLS_2_5GB;
+			dw_pcie_cfg_write(pp->dbi_base, exp_cap_off +
+					PCI_EXP_LNKCTL2, 4, val);
+		}
+	}
+
+	/* enable ltssm */
+	writel(DEVICE_TYPE_RC | (1 << MISCTRL_EN_ID)
+			| (1 << APP_LTSSM_ENABLE_ID)
+			| ((u32)1 << REG_TRANSLATION_ENABLE),
+			&app_reg->app_ctrl_0);
+
+	/* check if the link is up or not */
+	while (!dw_pcie_link_up(pp)) {
+		mdelay(100);
+		count++;
+		if (count == 10) {
+			dev_err(pp->dev, "Link Fail\n");
+			return -EINVAL;
+		}
+	}
+	dev_info(pp->dev, "Link up\n");
+
+	return 0;
+}
+
+static irqreturn_t spear13xx_pcie_irq_handler(int irq, void *arg)
+{
+	struct pcie_port *pp = arg;
+	struct spear13xx_pcie *spear13xx_pcie = to_spear13xx_pcie(pp);
+	struct pcie_app_reg *app_reg = spear13xx_pcie->app_base;
+	unsigned int status;
+
+	status = readl(&app_reg->int_sts);
+
+	if (status & MSI_CTRL_INT) {
+		if (!IS_ENABLED(CONFIG_PCI_MSI))
+			BUG();
+		dw_handle_msi_irq(pp);
+	}
+
+	writel(status, &app_reg->int_clr);
+
+	return IRQ_HANDLED;
+}
+
+static void spear13xx_pcie_enable_interrupts(struct pcie_port *pp)
+{
+	struct spear13xx_pcie *spear13xx_pcie = to_spear13xx_pcie(pp);
+	struct pcie_app_reg *app_reg = spear13xx_pcie->app_base;
+
+	/* Enable MSI interrupt */
+	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+		dw_pcie_msi_init(pp);
+		writel(readl(&app_reg->int_mask) |
+				MSI_CTRL_INT, &app_reg->int_mask);
+	}
+
+	return;
+}
+
+static int spear13xx_pcie_link_up(struct pcie_port *pp)
+{
+	struct spear13xx_pcie *spear13xx_pcie = to_spear13xx_pcie(pp);
+	struct pcie_app_reg *app_reg = spear13xx_pcie->app_base;
+
+	if (readl(&app_reg->app_status_1) & XMLH_LINK_UP)
+		return 1;
+
+	return 0;
+}
+
+static void spear13xx_pcie_host_init(struct pcie_port *pp)
+{
+	spear13xx_pcie_establish_link(pp);
+	spear13xx_pcie_enable_interrupts(pp);
+}
+
+static struct pcie_host_ops spear13xx_pcie_host_ops = {
+	.link_up = spear13xx_pcie_link_up,
+	.host_init = spear13xx_pcie_host_init,
+};
+
+static int add_pcie_port(struct pcie_port *pp, struct platform_device *pdev)
+{
+	int ret;
+
+	pp->irq = platform_get_irq(pdev, 0);
+	if (!pp->irq) {
+		dev_err(&pdev->dev, "failed to get irq\n");
+		return -ENODEV;
+	}
+	ret = devm_request_irq(&pdev->dev, pp->irq, spear13xx_pcie_irq_handler,
+				IRQF_SHARED, "spear13xx-pcie", pp);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to request irq\n");
+		return ret;
+	}
+
+	pp->root_bus_nr = -1;
+	pp->ops = &spear13xx_pcie_host_ops;
+
+	spin_lock_init(&pp->conf_lock);
+	ret = dw_pcie_host_init(pp);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to initialize host\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int __init spear13xx_pcie_probe(struct platform_device *pdev)
+{
+	struct spear13xx_pcie *spear13xx_pcie;
+	struct pcie_port *pp;
+	struct device_node *np = pdev->dev.of_node;
+	struct resource *dbi_base;
+	int ret;
+
+	spear13xx_pcie = devm_kzalloc(&pdev->dev, sizeof(*spear13xx_pcie),
+				GFP_KERNEL);
+	if (!spear13xx_pcie) {
+		dev_err(&pdev->dev, "no memory for SPEAr13xx pcie\n");
+		return -ENOMEM;
+	}
+
+	spear13xx_pcie->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(spear13xx_pcie->clk)) {
+		dev_err(&pdev->dev, "couldn't get clk for pcie\n");
+		return PTR_ERR(spear13xx_pcie->clk);
+	}
+	ret = clk_prepare_enable(spear13xx_pcie->clk);
+	if (ret) {
+		dev_err(&pdev->dev, "couldn't enable clk for pcie\n");
+		return ret;
+	}
+
+	pp = &spear13xx_pcie->pp;
+
+	pp->dev = &pdev->dev;
+
+	dbi_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	pp->dbi_base = devm_ioremap_resource(&pdev->dev, dbi_base);
+	if (IS_ERR(pp->dbi_base)) {
+		dev_err(&pdev->dev, "couldn't remap dbi base\n");
+		ret = PTR_ERR(pp->dbi_base);
+		goto fail_clk;
+	}
+	spear13xx_pcie->app_base = pp->dbi_base + 0x2000;
+
+	of_property_read_u32(np, "pcie_is_gen1", &spear13xx_pcie->is_gen1);
+
+	ret = add_pcie_port(pp, pdev);
+	if (ret < 0)
+		goto fail_clk;
+
+	platform_set_drvdata(pdev, spear13xx_pcie);
+	return 0;
+
+fail_clk:
+	clk_disable_unprepare(spear13xx_pcie->clk);
+
+	return ret;
+}
+
+static int __exit spear13xx_pcie_remove(struct platform_device *pdev)
+{
+	struct spear13xx_pcie *spear13xx_pcie = platform_get_drvdata(pdev);
+
+	clk_disable_unprepare(spear13xx_pcie->clk);
+
+	return 0;
+}
+
+static const struct of_device_id spear13xx_pcie_of_match[] = {
+	{ .compatible = "st,spear13xx-pcie", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, spear13xx_pcie_of_match);
+
+static struct platform_driver spear13xx_pcie_driver = {
+	.remove		= __exit_p(spear13xx_pcie_remove),
+	.driver = {
+		.name	= "spear-pcie",
+		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(spear13xx_pcie_of_match),
+	},
+};
+
+/* SPEAr13xx PCIe driver does not allow module unload */
+
+static int __init pcie_init(void)
+{
+
+	return platform_driver_probe(&spear13xx_pcie_driver,
+				spear13xx_pcie_probe);
+}
+subsys_initcall(pcie_init);
+
+MODULE_DESCRIPTION("ST Microelectronics SPEAr13xx PCIe host controller driver");
+MODULE_AUTHOR("Pratyush Anand <pratyush.anand@st.com>");
+MODULE_LICENSE("GPL v2");
-- 
1.7.0.1

