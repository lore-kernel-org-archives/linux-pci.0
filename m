Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog106.obsmtp.com ([207.126.144.121]:47261 "EHLO
	eu1sys200aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752588Ab2J2HCY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 29 Oct 2012 03:02:24 -0400
From: Pratyush Anand <pratyush.anand@st.com>
To: <arnd@arndb.de>, <shiraz.hashim@st.com>, <viresh.linux@gmail.com>
Cc: <spear-devel@list.st.com>, <linux-pci@vger.kernel.org>,
	<devicetree-discuss@lists.ozlabs.org>, <olof@lixom.net>,
	Pratyush Anand <pratyush.anand@st.com>
Subject: [PATCH 08/15] SPEAr1310: Add PCIe auxdata for miphy clock initialization
Date: Mon, 29 Oct 2012 12:31:22 +0530
Message-ID: <06c4b001f57084702b42a66565248ae871b909bf.1351492562.git.pratyush.anand@st.com>
In-Reply-To: <cover.1351492562.git.pratyush.anand@st.com>
References: <cover.1351492562.git.pratyush.anand@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Miphy Clock initialization is very specific to controller and its
instances. Pass this custom function using auxdata.

Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
---
 arch/arm/mach-spear13xx/spear1310.c |  148 +++++++++++++++++++++++++++++++++++
 1 files changed, 148 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-spear13xx/spear1310.c b/arch/arm/mach-spear13xx/spear1310.c
index 25e0fbb..3c673a1 100644
--- a/arch/arm/mach-spear13xx/spear1310.c
+++ b/arch/arm/mach-spear13xx/spear1310.c
@@ -24,6 +24,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <mach/generic.h>
+#include <mach/pcie.h>
 #include <mach/spear.h>
 
 /* Base addresses */
@@ -35,6 +36,9 @@
 #define SPEAR1310_SATA0_BASE			UL(0xB1000000)
 #define SPEAR1310_SATA1_BASE			UL(0xB1800000)
 #define SPEAR1310_SATA2_BASE			UL(0xB4000000)
+#define SPEAR1310_PCIE0_BASE			UL(0xB1000000)
+#define SPEAR1310_PCIE1_BASE			UL(0xB1800000)
+#define SPEAR1310_PCIE2_BASE			UL(0xB4000000)
 
 /* RAS Area Control Register */
 #define VA_SPEAR1310_RAS_CTRL_REG1	(VA_SPEAR1310_RAS_BASE + 0x4)
@@ -57,6 +61,81 @@
 #define SPEAR1310_PERIP1_SW_RST			(VA_MISC_BASE + 0x308)
 #define SPEAR1310_UOC_RST_ENB			11
 
+#define VA_SPEAR1310_PCIE_SATA_CFG		(VA_MISC_BASE + 0x3A4)
+	/* PCIE CFG MASks */
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
+#define VA_SPEAR1310_PCIE_MIPHY_CFG_1		(VA_MISC_BASE + 0x3A8)
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
+#define VA_SPEAR1310_PCIE_MIPHY_CFG_2		(VA_MISC_BASE + 0x3AC)
+
 static int spear1310_eth_phy_clk_cfg(struct platform_device *pdev)
 {
 	struct plat_stmmacenet_data *pdata = dev_get_platdata(&pdev->dev);
@@ -342,6 +421,69 @@ static struct dwc_otg_plat_data spear1310_otg_plat_data = {
 	.phy_init = spear1310_otg_phy_init,
 };
 
+static int spear1310_pcie_clk_init(struct pcie_port *pp)
+{
+	u32 temp;
+
+	temp = readl(VA_SPEAR1310_PCIE_MIPHY_CFG_1);
+	temp &= ~SPEAR1310_PCIE_SATA_MIPHY_CFG_PCIE_MASK;
+	temp |= SPEAR1310_PCIE_SATA_MIPHY_CFG_PCIE;
+
+	writel(temp, VA_SPEAR1310_PCIE_MIPHY_CFG_1);
+
+	temp = readl(VA_SPEAR1310_PCIE_SATA_CFG);
+
+	switch (pp->controller) {
+	case 0:
+		temp &= ~SPEAR1310_PCIE_CFG_MASK(0);
+		temp |= SPEAR1310_PCIE_CFG_VAL(0);
+		break;
+	case 1:
+		temp &= ~SPEAR1310_PCIE_CFG_MASK(1);
+		temp |= SPEAR1310_PCIE_CFG_VAL(1);
+		break;
+	case 2:
+		temp &= ~SPEAR1310_PCIE_CFG_MASK(2);
+		temp |= SPEAR1310_PCIE_CFG_VAL(2);
+		break;
+	default:
+		return -EINVAL;
+	}
+	writel(temp, VA_SPEAR1310_PCIE_SATA_CFG);
+
+	return 0;
+}
+
+static int spear1310_pcie_clk_exit(struct pcie_port *pp)
+{
+	u32 temp;
+
+	temp = readl(VA_SPEAR1310_PCIE_SATA_CFG);
+
+	switch (pp->controller) {
+	case 0:
+		temp &= ~SPEAR1310_PCIE_CFG_MASK(0);
+		break;
+	case 1:
+		temp &= ~SPEAR1310_PCIE_CFG_MASK(1);
+		break;
+	case 2:
+		temp &= ~SPEAR1310_PCIE_CFG_MASK(2);
+		break;
+	}
+
+	writel(temp, VA_SPEAR1310_PCIE_SATA_CFG);
+	writel(~SPEAR1310_PCIE_SATA_MIPHY_CFG_PCIE_MASK,
+			VA_SPEAR1310_PCIE_MIPHY_CFG_1);
+
+	return 0;
+}
+
+static struct pcie_port_info pcie_pdata = {
+	.clk_init = spear1310_pcie_clk_init,
+	.clk_exit = spear1310_pcie_clk_exit,
+};
+
 /* Add SPEAr1310 auxdata to pass platform data */
 static struct of_dev_auxdata spear1310_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("st,spear-adc", SPEAR13XX_ADC_BASE, NULL, &adc_pdata),
@@ -363,6 +505,12 @@ static struct of_dev_auxdata spear1310_auxdata_lookup[] __initdata = {
 			&eth4_data),
 	OF_DEV_AUXDATA("snps,usb-otg", SPEAR_UOC_BASE, NULL,
 			&spear1310_otg_plat_data),
+	OF_DEV_AUXDATA("st,pcie-host", SPEAR1310_PCIE0_BASE, NULL,
+			&pcie_pdata),
+	OF_DEV_AUXDATA("st,pcie-host", SPEAR1310_PCIE1_BASE, NULL,
+			&pcie_pdata),
+	OF_DEV_AUXDATA("st,pcie-host", SPEAR1310_PCIE2_BASE, NULL,
+			&pcie_pdata),
 	OF_DEV_AUXDATA("st,db9000-clcd", SPEAR13XX_CLCD_BASE, NULL,
 			&clcd_plat_info),
 	{}
-- 
1.7.5.4

