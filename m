Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:55567 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755586Ab2FKPFk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jun 2012 11:05:40 -0400
From: Thierry Reding <thierry.reding@avionic-design.de>
To: linux-tegra@vger.kernel.org
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>,
	Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH v2 04/10] ARM: tegra: Move tegra_pcie_xclk_clamp() to PMC
Date: Mon, 11 Jun 2012 17:05:12 +0200
Message-Id: <1339427118-32263-5-git-send-email-thierry.reding@avionic-design.de>
In-Reply-To: <1339427118-32263-1-git-send-email-thierry.reding@avionic-design.de>
References: <1339427118-32263-1-git-send-email-thierry.reding@avionic-design.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The PMC code already accesses to PMC registers so it makes sense to
move this function there as well. While at it, rename the function to
tegra_pmc_pcie_xclk_clamp() for consistency.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
Acked-by: Stephen Warren <swarren@wwwdotorg.org>

---
Changes in v2:
- none
---
 arch/arm/mach-tegra/pcie.c |   30 ++++--------------------------
 arch/arm/mach-tegra/pmc.c  |   16 ++++++++++++++++
 arch/arm/mach-tegra/pmc.h  |    1 +
 3 files changed, 21 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-tegra/pcie.c b/arch/arm/mach-tegra/pcie.c
index 0e09137..fcdf8bc 100644
--- a/arch/arm/mach-tegra/pcie.c
+++ b/arch/arm/mach-tegra/pcie.c
@@ -42,6 +42,7 @@
 #include <mach/powergate.h>
 
 #include "board.h"
+#include "pmc.h"
 
 /* register definitions */
 #define AFI_OFFSET	0x3800
@@ -145,17 +146,6 @@
 #define  PADS_PLL_CTL_TXCLKREF_DIV10		(0 << 20)
 #define  PADS_PLL_CTL_TXCLKREF_DIV5		(1 << 20)
 
-/* PMC access is required for PCIE xclk (un)clamping */
-#define PMC_SCRATCH42		0x144
-#define PMC_SCRATCH42_PCX_CLAMP	(1 << 0)
-
-static void __iomem *reg_pmc_base = IO_ADDRESS(TEGRA_PMC_BASE);
-
-#define pmc_writel(value, reg) \
-	__raw_writel(value, reg_pmc_base + (reg))
-#define pmc_readl(reg) \
-	__raw_readl(reg_pmc_base + (reg))
-
 /*
  * Tegra2 defines 1GB in the AXI address map for PCIe.
  *
@@ -679,18 +669,6 @@ static int tegra_pcie_enable_controller(void)
 	return 0;
 }
 
-static void tegra_pcie_xclk_clamp(bool clamp)
-{
-	u32 reg;
-
-	reg = pmc_readl(PMC_SCRATCH42) & ~PMC_SCRATCH42_PCX_CLAMP;
-
-	if (clamp)
-		reg |= PMC_SCRATCH42_PCX_CLAMP;
-
-	pmc_writel(reg, PMC_SCRATCH42);
-}
-
 static void tegra_pcie_power_off(void)
 {
 	tegra_periph_reset_assert(tegra_pcie.pcie_xclk);
@@ -698,7 +676,7 @@ static void tegra_pcie_power_off(void)
 	tegra_periph_reset_assert(tegra_pcie.pex_clk);
 
 	tegra_powergate_power_off(TEGRA_POWERGATE_PCIE);
-	tegra_pcie_xclk_clamp(true);
+	tegra_pmc_pcie_xclk_clamp(true);
 }
 
 static int tegra_pcie_power_regate(void)
@@ -707,7 +685,7 @@ static int tegra_pcie_power_regate(void)
 
 	tegra_pcie_power_off();
 
-	tegra_pcie_xclk_clamp(true);
+	tegra_pmc_pcie_xclk_clamp(true);
 
 	tegra_periph_reset_assert(tegra_pcie.pcie_xclk);
 	tegra_periph_reset_assert(tegra_pcie.afi_clk);
@@ -721,7 +699,7 @@ static int tegra_pcie_power_regate(void)
 
 	tegra_periph_reset_deassert(tegra_pcie.afi_clk);
 
-	tegra_pcie_xclk_clamp(false);
+	tegra_pmc_pcie_xclk_clamp(false);
 
 	clk_enable(tegra_pcie.afi_clk);
 	clk_enable(tegra_pcie.pex_clk);
diff --git a/arch/arm/mach-tegra/pmc.c b/arch/arm/mach-tegra/pmc.c
index 7af6a54..399dc3a 100644
--- a/arch/arm/mach-tegra/pmc.c
+++ b/arch/arm/mach-tegra/pmc.c
@@ -24,6 +24,10 @@
 #define PMC_CTRL		0x0
 #define PMC_CTRL_INTR_LOW	(1 << 17)
 
+/* PMC access is required for PCIE xclk (un)clamping */
+#define PMC_SCRATCH42		0x144
+#define PMC_SCRATCH42_PCX_CLAMP	(1 << 0)
+
 static inline u32 tegra_pmc_readl(u32 reg)
 {
 	return readl(IO_ADDRESS(TEGRA_PMC_BASE + reg));
@@ -74,3 +78,15 @@ void __init tegra_pmc_init(void)
 		val &= ~PMC_CTRL_INTR_LOW;
 	tegra_pmc_writel(val, PMC_CTRL);
 }
+
+void tegra_pmc_pcie_xclk_clamp(bool clamp)
+{
+	u32 reg;
+
+	reg = tegra_pmc_readl(PMC_SCRATCH42) & ~PMC_SCRATCH42_PCX_CLAMP;
+
+	if (clamp)
+		reg |= PMC_SCRATCH42_PCX_CLAMP;
+
+	tegra_pmc_writel(reg, PMC_SCRATCH42);
+}
diff --git a/arch/arm/mach-tegra/pmc.h b/arch/arm/mach-tegra/pmc.h
index 8995ee4..2631c9a 100644
--- a/arch/arm/mach-tegra/pmc.h
+++ b/arch/arm/mach-tegra/pmc.h
@@ -19,5 +19,6 @@
 #define __MACH_TEGRA_PMC_H
 
 void tegra_pmc_init(void);
+void tegra_pmc_pcie_xclk_clamp(bool clamp);
 
 #endif
-- 
1.7.10.4

