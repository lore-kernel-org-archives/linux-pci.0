Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S941018AbcJGQgU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:36:20 -0400
Subject: [PATCH 6/8] PCI: exynos: Swap order of exynos_phy_writel() reg/val
 arguments
To: Jingoo Han <jingoohan1@gmail.com>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Kukjin Kim <kgene@kernel.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Date: Fri, 07 Oct 2016 11:36:11 -0500
Message-ID: <20161007163611.25314.70157.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007163526.25314.29033.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007163526.25314.29033.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Swap order of exynos_phy_writel() arguments to match the "dev, pos, val"
order used by pci_write_config_word() and other drivers.  No functional
change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-exynos.c |   60 +++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
index eb50b1a..463cbd6 100644
--- a/drivers/pci/host/pci-exynos.c
+++ b/drivers/pci/host/pci-exynos.c
@@ -117,7 +117,7 @@ static u32 exynos_phy_readl(struct exynos_pcie *exynos, u32 reg)
 	return readl(exynos->phy_base + reg);
 }
 
-static void exynos_phy_writel(struct exynos_pcie *exynos, u32 val, u32 reg)
+static void exynos_phy_writel(struct exynos_pcie *exynos, u32 reg, u32 val)
 {
 	writel(val, exynos->phy_base + reg);
 }
@@ -211,23 +211,23 @@ static void exynos_pcie_power_on_phy(struct exynos_pcie *exynos)
 
 	val = exynos_phy_readl(exynos, PCIE_PHY_COMMON_POWER);
 	val &= ~PCIE_PHY_COMMON_PD_CMN;
-	exynos_phy_writel(exynos, val, PCIE_PHY_COMMON_POWER);
+	exynos_phy_writel(exynos, PCIE_PHY_COMMON_POWER, val);
 
 	val = exynos_phy_readl(exynos, PCIE_PHY_TRSV0_POWER);
 	val &= ~PCIE_PHY_TRSV0_PD_TSV;
-	exynos_phy_writel(exynos, val, PCIE_PHY_TRSV0_POWER);
+	exynos_phy_writel(exynos, PCIE_PHY_TRSV0_POWER, val);
 
 	val = exynos_phy_readl(exynos, PCIE_PHY_TRSV1_POWER);
 	val &= ~PCIE_PHY_TRSV1_PD_TSV;
-	exynos_phy_writel(exynos, val, PCIE_PHY_TRSV1_POWER);
+	exynos_phy_writel(exynos, PCIE_PHY_TRSV1_POWER, val);
 
 	val = exynos_phy_readl(exynos, PCIE_PHY_TRSV2_POWER);
 	val &= ~PCIE_PHY_TRSV2_PD_TSV;
-	exynos_phy_writel(exynos, val, PCIE_PHY_TRSV2_POWER);
+	exynos_phy_writel(exynos, PCIE_PHY_TRSV2_POWER, val);
 
 	val = exynos_phy_readl(exynos, PCIE_PHY_TRSV3_POWER);
 	val &= ~PCIE_PHY_TRSV3_PD_TSV;
-	exynos_phy_writel(exynos, val, PCIE_PHY_TRSV3_POWER);
+	exynos_phy_writel(exynos, PCIE_PHY_TRSV3_POWER, val);
 }
 
 static void exynos_pcie_power_off_phy(struct exynos_pcie *exynos)
@@ -236,61 +236,61 @@ static void exynos_pcie_power_off_phy(struct exynos_pcie *exynos)
 
 	val = exynos_phy_readl(exynos, PCIE_PHY_COMMON_POWER);
 	val |= PCIE_PHY_COMMON_PD_CMN;
-	exynos_phy_writel(exynos, val, PCIE_PHY_COMMON_POWER);
+	exynos_phy_writel(exynos, PCIE_PHY_COMMON_POWER, val);
 
 	val = exynos_phy_readl(exynos, PCIE_PHY_TRSV0_POWER);
 	val |= PCIE_PHY_TRSV0_PD_TSV;
-	exynos_phy_writel(exynos, val, PCIE_PHY_TRSV0_POWER);
+	exynos_phy_writel(exynos, PCIE_PHY_TRSV0_POWER, val);
 
 	val = exynos_phy_readl(exynos, PCIE_PHY_TRSV1_POWER);
 	val |= PCIE_PHY_TRSV1_PD_TSV;
-	exynos_phy_writel(exynos, val, PCIE_PHY_TRSV1_POWER);
+	exynos_phy_writel(exynos, PCIE_PHY_TRSV1_POWER, val);
 
 	val = exynos_phy_readl(exynos, PCIE_PHY_TRSV2_POWER);
 	val |= PCIE_PHY_TRSV2_PD_TSV;
-	exynos_phy_writel(exynos, val, PCIE_PHY_TRSV2_POWER);
+	exynos_phy_writel(exynos, PCIE_PHY_TRSV2_POWER, val);
 
 	val = exynos_phy_readl(exynos, PCIE_PHY_TRSV3_POWER);
 	val |= PCIE_PHY_TRSV3_PD_TSV;
-	exynos_phy_writel(exynos, val, PCIE_PHY_TRSV3_POWER);
+	exynos_phy_writel(exynos, PCIE_PHY_TRSV3_POWER, val);
 }
 
 static void exynos_pcie_init_phy(struct exynos_pcie *exynos)
 {
 	/* DCC feedback control off */
-	exynos_phy_writel(exynos, 0x29, PCIE_PHY_DCC_FEEDBACK);
+	exynos_phy_writel(exynos, PCIE_PHY_DCC_FEEDBACK, 0x29);
 
 	/* set TX/RX impedance */
-	exynos_phy_writel(exynos, 0xd5, PCIE_PHY_IMPEDANCE);
+	exynos_phy_writel(exynos, PCIE_PHY_IMPEDANCE, 0xd5);
 
 	/* set 50Mhz PHY clock */
-	exynos_phy_writel(exynos, 0x14, PCIE_PHY_PLL_DIV_0);
-	exynos_phy_writel(exynos, 0x12, PCIE_PHY_PLL_DIV_1);
+	exynos_phy_writel(exynos, PCIE_PHY_PLL_DIV_0, 0x14);
+	exynos_phy_writel(exynos, PCIE_PHY_PLL_DIV_1, 0x12);
 
 	/* set TX Differential output for lane 0 */
-	exynos_phy_writel(exynos, 0x7f, PCIE_PHY_TRSV0_DRV_LVL);
+	exynos_phy_writel(exynos, PCIE_PHY_TRSV0_DRV_LVL, 0x7f);
 
 	/* set TX Pre-emphasis Level Control for lane 0 to minimum */
-	exynos_phy_writel(exynos, 0x0, PCIE_PHY_TRSV0_EMP_LVL);
+	exynos_phy_writel(exynos, PCIE_PHY_TRSV0_EMP_LVL, 0x0);
 
 	/* set RX clock and data recovery bandwidth */
-	exynos_phy_writel(exynos, 0xe7, PCIE_PHY_PLL_BIAS);
-	exynos_phy_writel(exynos, 0x82, PCIE_PHY_TRSV0_RXCDR);
-	exynos_phy_writel(exynos, 0x82, PCIE_PHY_TRSV1_RXCDR);
-	exynos_phy_writel(exynos, 0x82, PCIE_PHY_TRSV2_RXCDR);
-	exynos_phy_writel(exynos, 0x82, PCIE_PHY_TRSV3_RXCDR);
+	exynos_phy_writel(exynos, PCIE_PHY_PLL_BIAS, 0xe7);
+	exynos_phy_writel(exynos, PCIE_PHY_TRSV0_RXCDR, 0x82);
+	exynos_phy_writel(exynos, PCIE_PHY_TRSV1_RXCDR, 0x82);
+	exynos_phy_writel(exynos, PCIE_PHY_TRSV2_RXCDR, 0x82);
+	exynos_phy_writel(exynos, PCIE_PHY_TRSV3_RXCDR, 0x82);
 
 	/* change TX Pre-emphasis Level Control for lanes */
-	exynos_phy_writel(exynos, 0x39, PCIE_PHY_TRSV0_EMP_LVL);
-	exynos_phy_writel(exynos, 0x39, PCIE_PHY_TRSV1_EMP_LVL);
-	exynos_phy_writel(exynos, 0x39, PCIE_PHY_TRSV2_EMP_LVL);
-	exynos_phy_writel(exynos, 0x39, PCIE_PHY_TRSV3_EMP_LVL);
+	exynos_phy_writel(exynos, PCIE_PHY_TRSV0_EMP_LVL, 0x39);
+	exynos_phy_writel(exynos, PCIE_PHY_TRSV1_EMP_LVL, 0x39);
+	exynos_phy_writel(exynos, PCIE_PHY_TRSV2_EMP_LVL, 0x39);
+	exynos_phy_writel(exynos, PCIE_PHY_TRSV3_EMP_LVL, 0x39);
 
 	/* set LVCC */
-	exynos_phy_writel(exynos, 0x20, PCIE_PHY_TRSV0_LVCC);
-	exynos_phy_writel(exynos, 0xa0, PCIE_PHY_TRSV1_LVCC);
-	exynos_phy_writel(exynos, 0xa0, PCIE_PHY_TRSV2_LVCC);
-	exynos_phy_writel(exynos, 0xa0, PCIE_PHY_TRSV3_LVCC);
+	exynos_phy_writel(exynos, PCIE_PHY_TRSV0_LVCC, 0x20);
+	exynos_phy_writel(exynos, PCIE_PHY_TRSV1_LVCC, 0xa0);
+	exynos_phy_writel(exynos, PCIE_PHY_TRSV2_LVCC, 0xa0);
+	exynos_phy_writel(exynos, PCIE_PHY_TRSV3_LVCC, 0xa0);
 }
 
 static void exynos_pcie_assert_reset(struct exynos_pcie *exynos)

