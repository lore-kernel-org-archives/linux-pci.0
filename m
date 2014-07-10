Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:48326 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751541AbaGJH1x (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Jul 2014 03:27:53 -0400
Received: by mail-pa0-f47.google.com with SMTP id kq14so10488864pab.6
        for <linux-pci@vger.kernel.org>; Thu, 10 Jul 2014 00:27:53 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: arnd@linaro.org, olof@lixom.net
Cc: linux-arm-kernel@lists.infradead.org, spear-devel@list.st.com,
	b.zolnierkie@samsung.com, bhelgaas@google.com, mark@nicholnet.com,
	linux-pci@vger.kernel.org, Pratyush Anand <pratyush.anand@st.com>,
	Mohit Kumar <mohit.kumar@st.com>,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V9 6/7] ARM: SPEAr13xx: Add pcie and miphy DT nodes
Date: Thu, 10 Jul 2014 12:56:37 +0530
Message-Id: <fb8de2ded8922bdd1639085a972b34e77e63249b.1404976059.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1404976058.git.viresh.kumar@linaro.org>
References: <cover.1404976058.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1404976058.git.viresh.kumar@linaro.org>
References: <cover.1404976058.git.viresh.kumar@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Pratyush Anand <pratyush.anand@st.com>

This patch adds necessary DT nodes for pcie controllers and miphys for SPEAr13xx
SoCs.

SPEAr1310 has 3 PCIe ports and SPEAr1340 has 1, which are multiplexed with
ahci/sata pins. By default evaluation board of both controller works in ahci
mode. Because of this, these nodes are marked "disabled" by default.

In order to use pcie controller on evaluation boards do necessary modifications
on board and enable (By replacing "disabled" with "okay") pcie and miphy from
respective 'evb' dtsi file.

Phy specific initialization was previously done from spear1340.c, which isn't
required anymore as we have separate drivers for it. Remove it.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
Signed-off-by: Mohit Kumar <mohit.kumar@st.com>
[viresh: fixed logs/cclist/checkpatch warnings, clubbed multiple patches into one]
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/boot/dts/spear1310-evb.dts |   4 ++
 arch/arm/boot/dts/spear1310.dtsi    |  93 ++++++++++++++++++++++++++-
 arch/arm/boot/dts/spear1340-evb.dts |   4 ++
 arch/arm/boot/dts/spear1340.dtsi    |  30 ++++++++-
 arch/arm/boot/dts/spear13xx.dtsi    |   4 +-
 arch/arm/mach-spear/Kconfig         |   3 +
 arch/arm/mach-spear/spear1340.c     | 125 +-----------------------------------
 7 files changed, 133 insertions(+), 130 deletions(-)

diff --git a/arch/arm/boot/dts/spear1310-evb.dts b/arch/arm/boot/dts/spear1310-evb.dts
index b56a801..d42c84b 100644
--- a/arch/arm/boot/dts/spear1310-evb.dts
+++ b/arch/arm/boot/dts/spear1310-evb.dts
@@ -106,6 +106,10 @@
 			status = "okay";
 		};
 
+		miphy@eb800000 {
+			status = "okay";
+		};
+
 		cf@b2800000 {
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/spear1310.dtsi b/arch/arm/boot/dts/spear1310.dtsi
index 122ae94..fa5f2bb 100644
--- a/arch/arm/boot/dts/spear1310.dtsi
+++ b/arch/arm/boot/dts/spear1310.dtsi
@@ -29,24 +29,111 @@
 			#gpio-cells = <2>;
 		};
 
-		ahci@b1000000 {
+		miphy0: miphy@eb800000 {
+			compatible = "st,spear1310-miphy";
+			reg = <0xeb800000 0x4000>;
+			misc = <&misc>;
+			phy-id = <0>;
+			#phy-cells = <1>;
+			status = "disabled";
+		};
+
+		miphy1: miphy@eb804000 {
+			compatible = "st,spear1310-miphy";
+			reg = <0xeb804000 0x4000>;
+			misc = <&misc>;
+			phy-id = <1>;
+			#phy-cells = <1>;
+			status = "disabled";
+		};
+
+		miphy2: miphy@eb808000 {
+			compatible = "st,spear1310-miphy";
+			reg = <0xeb808000 0x4000>;
+			misc = <&misc>;
+			phy-id = <2>;
+			#phy-cells = <1>;
+			status = "disabled";
+		};
+
+		ahci0: ahci@b1000000 {
 			compatible = "snps,spear-ahci";
 			reg = <0xb1000000 0x10000>;
 			interrupts = <0 68 0x4>;
+			phys = <&miphy0 0>;
+			phy-names = "sata-phy";
 			status = "disabled";
 		};
 
-		ahci@b1800000 {
+		ahci1: ahci@b1800000 {
 			compatible = "snps,spear-ahci";
 			reg = <0xb1800000 0x10000>;
 			interrupts = <0 69 0x4>;
+			phys = <&miphy1 0>;
+			phy-names = "sata-phy";
 			status = "disabled";
 		};
 
-		ahci@b4000000 {
+		ahci2: ahci@b4000000 {
 			compatible = "snps,spear-ahci";
 			reg = <0xb4000000 0x10000>;
 			interrupts = <0 70 0x4>;
+			phys = <&miphy2 0>;
+			phy-names = "sata-phy";
+			status = "disabled";
+		};
+
+		pcie0: pcie@b1000000 {
+			compatible = "st,spear1340-pcie", "snps,dw-pcie";
+			reg = <0xb1000000 0x4000>;
+			interrupts = <0 68 0x4>;
+			interrupt-map-mask = <0 0 0 0>;
+			interrupt-map = <0x0 0 &gic 0 68 0x4>;
+			num-lanes = <1>;
+			phys = <&miphy0 1>;
+			phy-names = "pcie-phy";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			ranges = <0x00000800 0 0x80000000 0x80000000 0 0x00020000   /* configuration space */
+				0x81000000 0 0	 0x80020000 0 0x00010000   /* downstream I/O */
+				0x82000000 0 0x80030000 0xc0030000 0 0x0ffd0000>; /* non-prefetchable memory */
+			status = "disabled";
+		};
+
+		pcie1: pcie@b1800000 {
+			compatible = "st,spear1340-pcie", "snps,dw-pcie";
+			reg = <0xb1800000 0x4000>;
+			interrupts = <0 69 0x4>;
+			interrupt-map-mask = <0 0 0 0>;
+			interrupt-map = <0x0 0 &gic 0 69 0x4>;
+			num-lanes = <1>;
+			phys = <&miphy1 1>;
+			phy-names = "pcie-phy";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			ranges = <0x00000800 0 0x90000000 0x90000000 0 0x00020000   /* configuration space */
+				0x81000000 0 0  0x90020000 0 0x00010000   /* downstream I/O */
+				0x82000000 0 0x90030000 0x90030000 0 0x0ffd0000>; /* non-prefetchable memory */
+			status = "disabled";
+		};
+
+		pcie2: pcie@b4000000 {
+			compatible = "st,spear1340-pcie", "snps,dw-pcie";
+			reg = <0xb4000000 0x4000>;
+			interrupts = <0 70 0x4>;
+			interrupt-map-mask = <0 0 0 0>;
+			interrupt-map = <0x0 0 &gic 0 70 0x4>;
+			num-lanes = <1>;
+			phys = <&miphy2 1>;
+			phy-names = "pcie-phy";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			ranges = <0x00000800 0 0xc0000000 0xc0000000 0 0x00020000   /* configuration space */
+				0x81000000 0 0	 0xc0020000 0 0x00010000   /* downstream I/O */
+				0x82000000 0 0xc0030000 0xc0030000 0 0x0ffd0000>; /* non-prefetchable memory */
 			status = "disabled";
 		};
 
diff --git a/arch/arm/boot/dts/spear1340-evb.dts b/arch/arm/boot/dts/spear1340-evb.dts
index d6c30ae..b23e05e 100644
--- a/arch/arm/boot/dts/spear1340-evb.dts
+++ b/arch/arm/boot/dts/spear1340-evb.dts
@@ -122,6 +122,10 @@
 			status = "okay";
 		};
 
+		miphy@eb800000 {
+			status = "okay";
+		};
+
 		dma@ea800000 {
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/spear1340.dtsi b/arch/arm/boot/dts/spear1340.dtsi
index 54d128d..e71df0f 100644
--- a/arch/arm/boot/dts/spear1340.dtsi
+++ b/arch/arm/boot/dts/spear1340.dtsi
@@ -31,10 +31,38 @@
 			status = "disabled";
 		};
 
-		ahci@b1000000 {
+		miphy0: miphy@eb800000 {
+			compatible = "st,spear1340-miphy";
+			reg = <0xeb800000 0x4000>;
+			misc = <&misc>;
+			#phy-cells = <1>;
+			status = "disabled";
+		};
+
+		ahci0: ahci@b1000000 {
 			compatible = "snps,spear-ahci";
 			reg = <0xb1000000 0x10000>;
 			interrupts = <0 72 0x4>;
+			phys = <&miphy0 0>;
+			phy-names = "sata-phy";
+			status = "disabled";
+		};
+
+		pcie0: pcie@b1000000 {
+			compatible = "st,spear1340-pcie", "snps,dw-pcie";
+			reg = <0xb1000000 0x4000>;
+			interrupts = <0 68 0x4>;
+			interrupt-map-mask = <0 0 0 0>;
+			interrupt-map = <0x0 0 &gic 0 68 0x4>;
+			num-lanes = <1>;
+			phys = <&miphy0 1>;
+			phy-names = "pcie-phy";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			ranges = <0x00000800 0 0x80000000 0x80000000 0 0x00020000   /* configuration space */
+				0x81000000 0 0	 0x80020000 0 0x00010000   /* downstream I/O */
+				0x82000000 0 0x80030000 0xc0030000 0 0x0ffd0000>; /* non-prefetchable memory */
 			status = "disabled";
 		};
 
diff --git a/arch/arm/boot/dts/spear13xx.dtsi b/arch/arm/boot/dts/spear13xx.dtsi
index 3a72508..a6eb543 100644
--- a/arch/arm/boot/dts/spear13xx.dtsi
+++ b/arch/arm/boot/dts/spear13xx.dtsi
@@ -83,8 +83,8 @@
 		#size-cells = <1>;
 		compatible = "simple-bus";
 		ranges = <0x50000000 0x50000000 0x10000000
-			  0xb0000000 0xb0000000 0x10000000
-			  0xd0000000 0xd0000000 0x02000000
+			  0x80000000 0x80000000 0x20000000
+			  0xb0000000 0xb0000000 0x22000000
 			  0xd8000000 0xd8000000 0x01000000
 			  0xe0000000 0xe0000000 0x10000000>;
 
diff --git a/arch/arm/mach-spear/Kconfig b/arch/arm/mach-spear/Kconfig
index ba57677..6fd4dc8 100644
--- a/arch/arm/mach-spear/Kconfig
+++ b/arch/arm/mach-spear/Kconfig
@@ -20,6 +20,7 @@ config ARCH_SPEAR13XX
 	select HAVE_ARM_TWD if SMP
 	select PINCTRL
 	select MFD_SYSCON
+	select MIGHT_HAVE_PCI
 	help
 	  Supports for ARM's SPEAR13XX family
 
@@ -28,12 +29,14 @@ if ARCH_SPEAR13XX
 config MACH_SPEAR1310
 	bool "SPEAr1310 Machine support with Device Tree"
 	select PINCTRL_SPEAR1310
+	select PHY_ST_SPEAR1310_MIPHY
 	help
 	  Supports ST SPEAr1310 machine configured via the device-tree
 
 config MACH_SPEAR1340
 	bool "SPEAr1340 Machine support with Device Tree"
 	select PINCTRL_SPEAR1340
+	select PHY_ST_SPEAR1340_MIPHY
 	help
 	  Supports ST SPEAr1340 machine configured via the device-tree
 
diff --git a/arch/arm/mach-spear/spear1340.c b/arch/arm/mach-spear/spear1340.c
index 7b6bff7..3f3c0f1 100644
--- a/arch/arm/mach-spear/spear1340.c
+++ b/arch/arm/mach-spear/spear1340.c
@@ -13,136 +13,13 @@
 
 #define pr_fmt(fmt) "SPEAr1340: " fmt
 
-#include <linux/ahci_platform.h>
-#include <linux/amba/serial.h>
-#include <linux/delay.h>
 #include <linux/of_platform.h>
 #include <asm/mach/arch.h>
 #include "generic.h"
-#include <mach/spear.h>
-
-/* FIXME: Move SATA PHY code into a standalone driver */
-
-/* Base addresses */
-#define SPEAR1340_SATA_BASE			UL(0xB1000000)
-
-/* Power Management Registers */
-#define SPEAR1340_PCM_CFG			(VA_MISC_BASE + 0x100)
-#define SPEAR1340_PCM_WKUP_CFG			(VA_MISC_BASE + 0x104)
-#define SPEAR1340_SWITCH_CTR			(VA_MISC_BASE + 0x108)
-
-#define SPEAR1340_PERIP1_SW_RST			(VA_MISC_BASE + 0x318)
-#define SPEAR1340_PERIP2_SW_RST			(VA_MISC_BASE + 0x31C)
-#define SPEAR1340_PERIP3_SW_RST			(VA_MISC_BASE + 0x320)
-
-/* PCIE - SATA configuration registers */
-#define SPEAR1340_PCIE_SATA_CFG			(VA_MISC_BASE + 0x424)
-	/* PCIE CFG MASks */
-	#define SPEAR1340_PCIE_CFG_DEVICE_PRESENT	(1 << 11)
-	#define SPEAR1340_PCIE_CFG_POWERUP_RESET	(1 << 10)
-	#define SPEAR1340_PCIE_CFG_CORE_CLK_EN		(1 << 9)
-	#define SPEAR1340_PCIE_CFG_AUX_CLK_EN		(1 << 8)
-	#define SPEAR1340_SATA_CFG_TX_CLK_EN		(1 << 4)
-	#define SPEAR1340_SATA_CFG_RX_CLK_EN		(1 << 3)
-	#define SPEAR1340_SATA_CFG_POWERUP_RESET	(1 << 2)
-	#define SPEAR1340_SATA_CFG_PM_CLK_EN		(1 << 1)
-	#define SPEAR1340_PCIE_SATA_SEL_PCIE		(0)
-	#define SPEAR1340_PCIE_SATA_SEL_SATA		(1)
-	#define SPEAR1340_SATA_PCIE_CFG_MASK		0xF1F
-	#define SPEAR1340_PCIE_CFG_VAL	(SPEAR1340_PCIE_SATA_SEL_PCIE | \
-			SPEAR1340_PCIE_CFG_AUX_CLK_EN | \
-			SPEAR1340_PCIE_CFG_CORE_CLK_EN | \
-			SPEAR1340_PCIE_CFG_POWERUP_RESET | \
-			SPEAR1340_PCIE_CFG_DEVICE_PRESENT)
-	#define SPEAR1340_SATA_CFG_VAL	(SPEAR1340_PCIE_SATA_SEL_SATA | \
-			SPEAR1340_SATA_CFG_PM_CLK_EN | \
-			SPEAR1340_SATA_CFG_POWERUP_RESET | \
-			SPEAR1340_SATA_CFG_RX_CLK_EN | \
-			SPEAR1340_SATA_CFG_TX_CLK_EN)
-
-#define SPEAR1340_PCIE_MIPHY_CFG		(VA_MISC_BASE + 0x428)
-	#define SPEAR1340_MIPHY_OSC_BYPASS_EXT		(1 << 31)
-	#define SPEAR1340_MIPHY_CLK_REF_DIV2		(1 << 27)
-	#define SPEAR1340_MIPHY_CLK_REF_DIV4		(2 << 27)
-	#define SPEAR1340_MIPHY_CLK_REF_DIV8		(3 << 27)
-	#define SPEAR1340_MIPHY_PLL_RATIO_TOP(x)	(x << 0)
-	#define SPEAR1340_PCIE_SATA_MIPHY_CFG_SATA \
-			(SPEAR1340_MIPHY_OSC_BYPASS_EXT | \
-			SPEAR1340_MIPHY_CLK_REF_DIV2 | \
-			SPEAR1340_MIPHY_PLL_RATIO_TOP(60))
-	#define SPEAR1340_PCIE_SATA_MIPHY_CFG_SATA_25M_CRYSTAL_CLK \
-			(SPEAR1340_MIPHY_PLL_RATIO_TOP(120))
-	#define SPEAR1340_PCIE_SATA_MIPHY_CFG_PCIE \
-			(SPEAR1340_MIPHY_OSC_BYPASS_EXT | \
-			SPEAR1340_MIPHY_PLL_RATIO_TOP(25))
-
-/* SATA device registration */
-static int sata_miphy_init(struct device *dev, void __iomem *addr)
-{
-	writel(SPEAR1340_SATA_CFG_VAL, SPEAR1340_PCIE_SATA_CFG);
-	writel(SPEAR1340_PCIE_SATA_MIPHY_CFG_SATA_25M_CRYSTAL_CLK,
-			SPEAR1340_PCIE_MIPHY_CFG);
-	/* Switch on sata power domain */
-	writel((readl(SPEAR1340_PCM_CFG) | (0x800)), SPEAR1340_PCM_CFG);
-	msleep(20);
-	/* Disable PCIE SATA Controller reset */
-	writel((readl(SPEAR1340_PERIP1_SW_RST) & (~0x1000)),
-			SPEAR1340_PERIP1_SW_RST);
-	msleep(20);
-
-	return 0;
-}
-
-void sata_miphy_exit(struct device *dev)
-{
-	writel(0, SPEAR1340_PCIE_SATA_CFG);
-	writel(0, SPEAR1340_PCIE_MIPHY_CFG);
-
-	/* Enable PCIE SATA Controller reset */
-	writel((readl(SPEAR1340_PERIP1_SW_RST) | (0x1000)),
-			SPEAR1340_PERIP1_SW_RST);
-	msleep(20);
-	/* Switch off sata power domain */
-	writel((readl(SPEAR1340_PCM_CFG) & (~0x800)), SPEAR1340_PCM_CFG);
-	msleep(20);
-}
-
-int sata_suspend(struct device *dev)
-{
-	if (dev->power.power_state.event == PM_EVENT_FREEZE)
-		return 0;
-
-	sata_miphy_exit(dev);
-
-	return 0;
-}
-
-int sata_resume(struct device *dev)
-{
-	if (dev->power.power_state.event == PM_EVENT_THAW)
-		return 0;
-
-	return sata_miphy_init(dev, NULL);
-}
-
-static struct ahci_platform_data sata_pdata = {
-	.init = sata_miphy_init,
-	.exit = sata_miphy_exit,
-	.suspend = sata_suspend,
-	.resume = sata_resume,
-};
-
-/* Add SPEAr1340 auxdata to pass platform data */
-static struct of_dev_auxdata spear1340_auxdata_lookup[] __initdata = {
-	OF_DEV_AUXDATA("snps,spear-ahci", SPEAR1340_SATA_BASE, NULL,
-			&sata_pdata),
-	{}
-};
 
 static void __init spear1340_dt_init(void)
 {
-	of_platform_populate(NULL, of_default_bus_match_table,
-			spear1340_auxdata_lookup, NULL);
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 	platform_device_register_simple("spear-cpufreq", -1, NULL, 0);
 }
 
-- 
2.0.0.rc2

