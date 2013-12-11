Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog112.obsmtp.com ([207.126.144.133]:51998 "EHLO
	eu1sys200aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750960Ab3LKJjp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Dec 2013 04:39:45 -0500
From: Mohit Kumar <mohit.kumar@st.com>
To: <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Cc: Pratyush Anand <pratyush.anand@st.com>,
	Mohit Kumar <mohit.kumar@st.com>,
	Viresh Kumar <viresh.linux@gmail.com>,
	<spear-devel@list.st.com>
Subject: [PATCH 03/12] SPEAr13xx: Add SPEAr1310 PCIe register definitions
Date: Wed, 11 Dec 2013 15:08:28 +0530
Message-ID: <3a008bd5223b1da9f17ceac745b3fc08b6b842e3.1386752447.git.mohit.kumar@st.com>
In-Reply-To: <cover.1386752447.git.mohit.kumar@st.com>
References: <cover.1386752447.git.mohit.kumar@st.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Pratyush Anand <pratyush.anand@st.com>

Add SPEAr1310 Misc register definitions for PCIe.

Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
Cc: Mohit Kumar <mohit.kumar@st.com>
Cc: Viresh Kumar <viresh.linux@gmail.com>
Cc: spear-devel@list.st.com
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm/mach-spear/include/mach/spear.h |   73 ++++++++++++++++++++++++++++++
 1 files changed, 73 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-spear/include/mach/spear.h b/arch/arm/mach-spear/include/mach/spear.h
index 4526f75..c236cef 100644
--- a/arch/arm/mach-spear/include/mach/spear.h
+++ b/arch/arm/mach-spear/include/mach/spear.h
@@ -140,6 +140,79 @@
 			(SPEAR1340_MIPHY_OSC_BYPASS_EXT | \
 			SPEAR1340_MIPHY_PLL_RATIO_TOP(25))
 
+#define VA_SPEAR1310_PCIE_SATA_CFG		(VA_MISC_BASE + 0x3A4)
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
 
 #endif /* SPEAR13XX */
 
-- 
1.7.0.1

