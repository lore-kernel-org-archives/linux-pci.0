Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog115.obsmtp.com ([207.126.144.139]:33451 "EHLO
	eu1sys200aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750911Ab3LKJjo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Dec 2013 04:39:44 -0500
From: Mohit Kumar <mohit.kumar@st.com>
To: <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Cc: Pratyush Anand <pratyush.anand@st.com>,
	Mohit Kumar <mohit.kumar@st.com>,
	Viresh Kumar <viresh.linux@gmail.com>,
	<spear-devel@list.st.com>
Subject: [PATCH 02/12] SPEAr13xx: Move SPEAr1340 definitions to header file
Date: Wed, 11 Dec 2013 15:08:27 +0530
Message-ID: <9ae7b152da13c094b024c54d27187aab96e439b3.1386752447.git.mohit.kumar@st.com>
In-Reply-To: <cover.1386752447.git.mohit.kumar@st.com>
References: <cover.1386752447.git.mohit.kumar@st.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Pratyush Anand <pratyush.anand@st.com>

Move SPEAr1340 definitions to header files so that theese can be used by
other code too.

Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
Cc: Mohit Kumar <mohit.kumar@st.com>
Cc: Viresh Kumar <viresh.linux@gmail.com>
Cc: spear-devel@list.st.com
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm/mach-spear/include/mach/spear.h |   55 ++++++++++++++++++++++++++++++
 arch/arm/mach-spear/spear1340.c          |   54 -----------------------------
 2 files changed, 55 insertions(+), 54 deletions(-)

diff --git a/arch/arm/mach-spear/include/mach/spear.h b/arch/arm/mach-spear/include/mach/spear.h
index 5cdc53d..4526f75 100644
--- a/arch/arm/mach-spear/include/mach/spear.h
+++ b/arch/arm/mach-spear/include/mach/spear.h
@@ -86,6 +86,61 @@
 /* Debug uart for linux, will be used for debug and uncompress messages */
 #define SPEAR_DBG_UART_BASE			UART_BASE
 
+/* PCIe/SATA Base addresses */
+#define SPEAR1340_SATA_BASE			UL(0xB1000000)
+#define SPEAR1340_PCIE_BASE			UL(0xB1000000)
+
+/* Power Management Registers */
+#define SPEAR1340_PCM_CFG			(VA_MISC_BASE + 0x100)
+#define SPEAR1340_PCM_WKUP_CFG			(VA_MISC_BASE + 0x104)
+#define SPEAR1340_SWITCH_CTR			(VA_MISC_BASE + 0x108)
+
+#define SPEAR1340_PERIP1_SW_RST			(VA_MISC_BASE + 0x318)
+#define SPEAR1340_PERIP2_SW_RST			(VA_MISC_BASE + 0x31C)
+#define SPEAR1340_PERIP3_SW_RST			(VA_MISC_BASE + 0x320)
+
+/* PCIE - SATA configuration registers */
+#define SPEAR1340_PCIE_SATA_CFG			(VA_MISC_BASE + 0x424)
+	/* PCIE CFG MASks */
+	#define SPEAR1340_PCIE_CFG_DEVICE_PRESENT	(1 << 11)
+	#define SPEAR1340_PCIE_CFG_POWERUP_RESET	(1 << 10)
+	#define SPEAR1340_PCIE_CFG_CORE_CLK_EN		(1 << 9)
+	#define SPEAR1340_PCIE_CFG_AUX_CLK_EN		(1 << 8)
+	#define SPEAR1340_SATA_CFG_TX_CLK_EN		(1 << 4)
+	#define SPEAR1340_SATA_CFG_RX_CLK_EN		(1 << 3)
+	#define SPEAR1340_SATA_CFG_POWERUP_RESET	(1 << 2)
+	#define SPEAR1340_SATA_CFG_PM_CLK_EN		(1 << 1)
+	#define SPEAR1340_PCIE_SATA_SEL_PCIE		(0)
+	#define SPEAR1340_PCIE_SATA_SEL_SATA		(1)
+	#define SPEAR1340_SATA_PCIE_CFG_MASK		0xF1F
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
+#define SPEAR1340_PCIE_MIPHY_CFG		(VA_MISC_BASE + 0x428)
+	#define SPEAR1340_MIPHY_OSC_BYPASS_EXT		(1 << 31)
+	#define SPEAR1340_MIPHY_CLK_REF_DIV2		(1 << 27)
+	#define SPEAR1340_MIPHY_CLK_REF_DIV4		(2 << 27)
+	#define SPEAR1340_MIPHY_CLK_REF_DIV8		(3 << 27)
+	#define SPEAR1340_MIPHY_PLL_RATIO_TOP(x)	(x << 0)
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
+
 #endif /* SPEAR13XX */
 
 #endif /* __MACH_SPEAR_H */
diff --git a/arch/arm/mach-spear/spear1340.c b/arch/arm/mach-spear/spear1340.c
index 3fb6834..1b47609 100644
--- a/arch/arm/mach-spear/spear1340.c
+++ b/arch/arm/mach-spear/spear1340.c
@@ -22,60 +22,6 @@
 #include <mach/spear.h>
 
 /* FIXME: Move SATA PHY code into a standalone driver */
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
 /* SATA device registration */
 static int sata_miphy_init(struct device *dev, void __iomem *addr)
 {
-- 
1.7.0.1

