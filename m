Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:39068 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750933AbcLSIQU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Dec 2016 03:16:20 -0500
From: Jaehoon Chung <jh80.chung@samsung.com>
To: linux-pci@vger.kernel.org
Cc: helgaas@google.com, krzk@kernel.org, linux-kernel@vger.kernel.org,
        jingoohan1@gmail.com, javier@osg.samsung.com, kgene@kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 1/4] PCI: exynos: replace to one register accessor from each
 accessors
Date: Mon, 19 Dec 2016 17:16:11 +0900
Message-id: <20161219081614.5403-2-jh80.chung@samsung.com>
In-reply-to: <20161219081614.5403-1-jh80.chung@samsung.com>
References: <20161219081614.5403-1-jh80.chung@samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There is no reason to maintain *_blk/phy/elbi_* as register accessors.
It can be replaced to one register accessor.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/pci/host/pci-exynos.c | 214 +++++++++++++++++++-----------------------
 1 file changed, 97 insertions(+), 117 deletions(-)

diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
index f1c544b..6dbfa2c 100644
--- a/drivers/pci/host/pci-exynos.c
+++ b/drivers/pci/host/pci-exynos.c
@@ -102,197 +102,175 @@ struct exynos_pcie {
 #define PCIE_PHY_TRSV3_PD_TSV		(0x1 << 7)
 #define PCIE_PHY_TRSV3_LVCC		0x31c
 
-static void exynos_elb_writel(struct exynos_pcie *exynos_pcie, u32 val, u32 reg)
+static void exynos_pcie_writel(void __iomem *base, u32 val, u32 reg)
 {
-	writel(val, exynos_pcie->elbi_base + reg);
+	writel(val, base + reg);
 }
 
-static u32 exynos_elb_readl(struct exynos_pcie *exynos_pcie, u32 reg)
+static u32 exynos_pcie_readl(void __iomem *base, u32 reg)
 {
-	return readl(exynos_pcie->elbi_base + reg);
+	return readl(base + reg);
 }
 
-static void exynos_phy_writel(struct exynos_pcie *exynos_pcie, u32 val, u32 reg)
-{
-	writel(val, exynos_pcie->phy_base + reg);
-}
-
-static u32 exynos_phy_readl(struct exynos_pcie *exynos_pcie, u32 reg)
-{
-	return readl(exynos_pcie->phy_base + reg);
-}
-
-static void exynos_blk_writel(struct exynos_pcie *exynos_pcie, u32 val, u32 reg)
-{
-	writel(val, exynos_pcie->block_base + reg);
-}
-
-static u32 exynos_blk_readl(struct exynos_pcie *exynos_pcie, u32 reg)
-{
-	return readl(exynos_pcie->block_base + reg);
-}
-
-static void exynos_pcie_sideband_dbi_w_mode(struct exynos_pcie *exynos_pcie,
-					    bool on)
+static void exynos_pcie_sideband_dbi_w_mode(struct exynos_pcie *ep, bool on)
 {
 	u32 val;
 
 	if (on) {
-		val = exynos_elb_readl(exynos_pcie, PCIE_ELBI_SLV_AWMISC);
+		val = exynos_pcie_readl(ep->elbi_base, PCIE_ELBI_SLV_AWMISC);
 		val |= PCIE_ELBI_SLV_DBI_ENABLE;
-		exynos_elb_writel(exynos_pcie, val, PCIE_ELBI_SLV_AWMISC);
+		exynos_pcie_writel(ep->elbi_base, val, PCIE_ELBI_SLV_AWMISC);
 	} else {
-		val = exynos_elb_readl(exynos_pcie, PCIE_ELBI_SLV_AWMISC);
+		val = exynos_pcie_readl(ep->elbi_base, PCIE_ELBI_SLV_AWMISC);
 		val &= ~PCIE_ELBI_SLV_DBI_ENABLE;
-		exynos_elb_writel(exynos_pcie, val, PCIE_ELBI_SLV_AWMISC);
+		exynos_pcie_writel(ep->elbi_base, val, PCIE_ELBI_SLV_AWMISC);
 	}
 }
 
-static void exynos_pcie_sideband_dbi_r_mode(struct exynos_pcie *exynos_pcie,
-					    bool on)
+static void exynos_pcie_sideband_dbi_r_mode(struct exynos_pcie *ep, bool on)
 {
 	u32 val;
 
 	if (on) {
-		val = exynos_elb_readl(exynos_pcie, PCIE_ELBI_SLV_ARMISC);
+		val = exynos_pcie_readl(ep->elbi_base, PCIE_ELBI_SLV_ARMISC);
 		val |= PCIE_ELBI_SLV_DBI_ENABLE;
-		exynos_elb_writel(exynos_pcie, val, PCIE_ELBI_SLV_ARMISC);
+		exynos_pcie_writel(ep->elbi_base, val, PCIE_ELBI_SLV_ARMISC);
 	} else {
-		val = exynos_elb_readl(exynos_pcie, PCIE_ELBI_SLV_ARMISC);
+		val = exynos_pcie_readl(ep->elbi_base, PCIE_ELBI_SLV_ARMISC);
 		val &= ~PCIE_ELBI_SLV_DBI_ENABLE;
-		exynos_elb_writel(exynos_pcie, val, PCIE_ELBI_SLV_ARMISC);
+		exynos_pcie_writel(ep->elbi_base, val, PCIE_ELBI_SLV_ARMISC);
 	}
 }
 
-static void exynos_pcie_assert_core_reset(struct exynos_pcie *exynos_pcie)
+static void exynos_pcie_assert_core_reset(struct exynos_pcie *ep)
 {
 	u32 val;
 
-	val = exynos_elb_readl(exynos_pcie, PCIE_CORE_RESET);
+	val = exynos_pcie_readl(ep->elbi_base, PCIE_CORE_RESET);
 	val &= ~PCIE_CORE_RESET_ENABLE;
-	exynos_elb_writel(exynos_pcie, val, PCIE_CORE_RESET);
-	exynos_elb_writel(exynos_pcie, 0, PCIE_PWR_RESET);
-	exynos_elb_writel(exynos_pcie, 0, PCIE_STICKY_RESET);
-	exynos_elb_writel(exynos_pcie, 0, PCIE_NONSTICKY_RESET);
+	exynos_pcie_writel(ep->elbi_base, val, PCIE_CORE_RESET);
+	exynos_pcie_writel(ep->elbi_base, 0, PCIE_PWR_RESET);
+	exynos_pcie_writel(ep->elbi_base, 0, PCIE_STICKY_RESET);
+	exynos_pcie_writel(ep->elbi_base, 0, PCIE_NONSTICKY_RESET);
 }
 
-static void exynos_pcie_deassert_core_reset(struct exynos_pcie *exynos_pcie)
+static void exynos_pcie_deassert_core_reset(struct exynos_pcie *ep)
 {
 	u32 val;
 
-	val = exynos_elb_readl(exynos_pcie, PCIE_CORE_RESET);
+	val = exynos_pcie_readl(ep->elbi_base, PCIE_CORE_RESET);
 	val |= PCIE_CORE_RESET_ENABLE;
 
-	exynos_elb_writel(exynos_pcie, val, PCIE_CORE_RESET);
-	exynos_elb_writel(exynos_pcie, 1, PCIE_STICKY_RESET);
-	exynos_elb_writel(exynos_pcie, 1, PCIE_NONSTICKY_RESET);
-	exynos_elb_writel(exynos_pcie, 1, PCIE_APP_INIT_RESET);
-	exynos_elb_writel(exynos_pcie, 0, PCIE_APP_INIT_RESET);
-	exynos_blk_writel(exynos_pcie, 1, PCIE_PHY_MAC_RESET);
+	exynos_pcie_writel(ep->elbi_base, val, PCIE_CORE_RESET);
+	exynos_pcie_writel(ep->elbi_base, 1, PCIE_STICKY_RESET);
+	exynos_pcie_writel(ep->elbi_base, 1, PCIE_NONSTICKY_RESET);
+	exynos_pcie_writel(ep->elbi_base, 1, PCIE_APP_INIT_RESET);
+	exynos_pcie_writel(ep->elbi_base, 0, PCIE_APP_INIT_RESET);
+	exynos_pcie_writel(ep->block_base, 1, PCIE_PHY_MAC_RESET);
 }
 
-static void exynos_pcie_assert_phy_reset(struct exynos_pcie *exynos_pcie)
+static void exynos_pcie_assert_phy_reset(struct exynos_pcie *ep)
 {
-	exynos_blk_writel(exynos_pcie, 0, PCIE_PHY_MAC_RESET);
-	exynos_blk_writel(exynos_pcie, 1, PCIE_PHY_GLOBAL_RESET);
+	exynos_pcie_writel(ep->block_base, 0, PCIE_PHY_MAC_RESET);
+	exynos_pcie_writel(ep->block_base, 1, PCIE_PHY_GLOBAL_RESET);
 }
 
-static void exynos_pcie_deassert_phy_reset(struct exynos_pcie *exynos_pcie)
+static void exynos_pcie_deassert_phy_reset(struct exynos_pcie *ep)
 {
-	exynos_blk_writel(exynos_pcie, 0, PCIE_PHY_GLOBAL_RESET);
-	exynos_elb_writel(exynos_pcie, 1, PCIE_PWR_RESET);
-	exynos_blk_writel(exynos_pcie, 0, PCIE_PHY_COMMON_RESET);
-	exynos_blk_writel(exynos_pcie, 0, PCIE_PHY_CMN_REG);
-	exynos_blk_writel(exynos_pcie, 0, PCIE_PHY_TRSVREG_RESET);
-	exynos_blk_writel(exynos_pcie, 0, PCIE_PHY_TRSV_RESET);
+	exynos_pcie_writel(ep->block_base, 0, PCIE_PHY_GLOBAL_RESET);
+	exynos_pcie_writel(ep->elbi_base, 1, PCIE_PWR_RESET);
+	exynos_pcie_writel(ep->block_base, 0, PCIE_PHY_COMMON_RESET);
+	exynos_pcie_writel(ep->block_base, 0, PCIE_PHY_CMN_REG);
+	exynos_pcie_writel(ep->block_base, 0, PCIE_PHY_TRSVREG_RESET);
+	exynos_pcie_writel(ep->block_base, 0, PCIE_PHY_TRSV_RESET);
 }
 
-static void exynos_pcie_power_on_phy(struct exynos_pcie *exynos_pcie)
+static void exynos_pcie_power_on_phy(struct exynos_pcie *ep)
 {
 	u32 val;
 
-	val = exynos_phy_readl(exynos_pcie, PCIE_PHY_COMMON_POWER);
+	val = exynos_pcie_readl(ep->phy_base, PCIE_PHY_COMMON_POWER);
 	val &= ~PCIE_PHY_COMMON_PD_CMN;
-	exynos_phy_writel(exynos_pcie, val, PCIE_PHY_COMMON_POWER);
+	exynos_pcie_writel(ep->phy_base, val, PCIE_PHY_COMMON_POWER);
 
-	val = exynos_phy_readl(exynos_pcie, PCIE_PHY_TRSV0_POWER);
+	val = exynos_pcie_readl(ep->phy_base, PCIE_PHY_TRSV0_POWER);
 	val &= ~PCIE_PHY_TRSV0_PD_TSV;
-	exynos_phy_writel(exynos_pcie, val, PCIE_PHY_TRSV0_POWER);
+	exynos_pcie_writel(ep->phy_base, val, PCIE_PHY_TRSV0_POWER);
 
-	val = exynos_phy_readl(exynos_pcie, PCIE_PHY_TRSV1_POWER);
+	val = exynos_pcie_readl(ep->phy_base, PCIE_PHY_TRSV1_POWER);
 	val &= ~PCIE_PHY_TRSV1_PD_TSV;
-	exynos_phy_writel(exynos_pcie, val, PCIE_PHY_TRSV1_POWER);
+	exynos_pcie_writel(ep->phy_base, val, PCIE_PHY_TRSV1_POWER);
 
-	val = exynos_phy_readl(exynos_pcie, PCIE_PHY_TRSV2_POWER);
+	val = exynos_pcie_readl(ep->phy_base, PCIE_PHY_TRSV2_POWER);
 	val &= ~PCIE_PHY_TRSV2_PD_TSV;
-	exynos_phy_writel(exynos_pcie, val, PCIE_PHY_TRSV2_POWER);
+	exynos_pcie_writel(ep->phy_base, val, PCIE_PHY_TRSV2_POWER);
 
-	val = exynos_phy_readl(exynos_pcie, PCIE_PHY_TRSV3_POWER);
+	val = exynos_pcie_readl(ep->phy_base, PCIE_PHY_TRSV3_POWER);
 	val &= ~PCIE_PHY_TRSV3_PD_TSV;
-	exynos_phy_writel(exynos_pcie, val, PCIE_PHY_TRSV3_POWER);
+	exynos_pcie_writel(ep->phy_base, val, PCIE_PHY_TRSV3_POWER);
 }
 
-static void exynos_pcie_power_off_phy(struct exynos_pcie *exynos_pcie)
+static void exynos_pcie_power_off_phy(struct exynos_pcie *ep)
 {
 	u32 val;
 
-	val = exynos_phy_readl(exynos_pcie, PCIE_PHY_COMMON_POWER);
+	val = exynos_pcie_readl(ep->phy_base, PCIE_PHY_COMMON_POWER);
 	val |= PCIE_PHY_COMMON_PD_CMN;
-	exynos_phy_writel(exynos_pcie, val, PCIE_PHY_COMMON_POWER);
+	exynos_pcie_writel(ep->phy_base, val, PCIE_PHY_COMMON_POWER);
 
-	val = exynos_phy_readl(exynos_pcie, PCIE_PHY_TRSV0_POWER);
+	val = exynos_pcie_readl(ep->phy_base, PCIE_PHY_TRSV0_POWER);
 	val |= PCIE_PHY_TRSV0_PD_TSV;
-	exynos_phy_writel(exynos_pcie, val, PCIE_PHY_TRSV0_POWER);
+	exynos_pcie_writel(ep->phy_base, val, PCIE_PHY_TRSV0_POWER);
 
-	val = exynos_phy_readl(exynos_pcie, PCIE_PHY_TRSV1_POWER);
+	val = exynos_pcie_readl(ep->phy_base, PCIE_PHY_TRSV1_POWER);
 	val |= PCIE_PHY_TRSV1_PD_TSV;
-	exynos_phy_writel(exynos_pcie, val, PCIE_PHY_TRSV1_POWER);
+	exynos_pcie_writel(ep->phy_base, val, PCIE_PHY_TRSV1_POWER);
 
-	val = exynos_phy_readl(exynos_pcie, PCIE_PHY_TRSV2_POWER);
+	val = exynos_pcie_readl(ep->phy_base, PCIE_PHY_TRSV2_POWER);
 	val |= PCIE_PHY_TRSV2_PD_TSV;
-	exynos_phy_writel(exynos_pcie, val, PCIE_PHY_TRSV2_POWER);
+	exynos_pcie_writel(ep->phy_base, val, PCIE_PHY_TRSV2_POWER);
 
-	val = exynos_phy_readl(exynos_pcie, PCIE_PHY_TRSV3_POWER);
+	val = exynos_pcie_readl(ep->phy_base, PCIE_PHY_TRSV3_POWER);
 	val |= PCIE_PHY_TRSV3_PD_TSV;
-	exynos_phy_writel(exynos_pcie, val, PCIE_PHY_TRSV3_POWER);
+	exynos_pcie_writel(ep->phy_base, val, PCIE_PHY_TRSV3_POWER);
 }
 
-static void exynos_pcie_init_phy(struct exynos_pcie *exynos_pcie)
+static void exynos_pcie_init_phy(struct exynos_pcie *ep)
 {
 	/* DCC feedback control off */
-	exynos_phy_writel(exynos_pcie, 0x29, PCIE_PHY_DCC_FEEDBACK);
+	exynos_pcie_writel(ep->phy_base, 0x29, PCIE_PHY_DCC_FEEDBACK);
 
 	/* set TX/RX impedance */
-	exynos_phy_writel(exynos_pcie, 0xd5, PCIE_PHY_IMPEDANCE);
+	exynos_pcie_writel(ep->phy_base, 0xd5, PCIE_PHY_IMPEDANCE);
 
 	/* set 50Mhz PHY clock */
-	exynos_phy_writel(exynos_pcie, 0x14, PCIE_PHY_PLL_DIV_0);
-	exynos_phy_writel(exynos_pcie, 0x12, PCIE_PHY_PLL_DIV_1);
+	exynos_pcie_writel(ep->phy_base, 0x14, PCIE_PHY_PLL_DIV_0);
+	exynos_pcie_writel(ep->phy_base, 0x12, PCIE_PHY_PLL_DIV_1);
 
 	/* set TX Differential output for lane 0 */
-	exynos_phy_writel(exynos_pcie, 0x7f, PCIE_PHY_TRSV0_DRV_LVL);
+	exynos_pcie_writel(ep->phy_base, 0x7f, PCIE_PHY_TRSV0_DRV_LVL);
 
 	/* set TX Pre-emphasis Level Control for lane 0 to minimum */
-	exynos_phy_writel(exynos_pcie, 0x0, PCIE_PHY_TRSV0_EMP_LVL);
+	exynos_pcie_writel(ep->phy_base, 0x0, PCIE_PHY_TRSV0_EMP_LVL);
 
 	/* set RX clock and data recovery bandwidth */
-	exynos_phy_writel(exynos_pcie, 0xe7, PCIE_PHY_PLL_BIAS);
-	exynos_phy_writel(exynos_pcie, 0x82, PCIE_PHY_TRSV0_RXCDR);
-	exynos_phy_writel(exynos_pcie, 0x82, PCIE_PHY_TRSV1_RXCDR);
-	exynos_phy_writel(exynos_pcie, 0x82, PCIE_PHY_TRSV2_RXCDR);
-	exynos_phy_writel(exynos_pcie, 0x82, PCIE_PHY_TRSV3_RXCDR);
+	exynos_pcie_writel(ep->phy_base, 0xe7, PCIE_PHY_PLL_BIAS);
+	exynos_pcie_writel(ep->phy_base, 0x82, PCIE_PHY_TRSV0_RXCDR);
+	exynos_pcie_writel(ep->phy_base, 0x82, PCIE_PHY_TRSV1_RXCDR);
+	exynos_pcie_writel(ep->phy_base, 0x82, PCIE_PHY_TRSV2_RXCDR);
+	exynos_pcie_writel(ep->phy_base, 0x82, PCIE_PHY_TRSV3_RXCDR);
 
 	/* change TX Pre-emphasis Level Control for lanes */
-	exynos_phy_writel(exynos_pcie, 0x39, PCIE_PHY_TRSV0_EMP_LVL);
-	exynos_phy_writel(exynos_pcie, 0x39, PCIE_PHY_TRSV1_EMP_LVL);
-	exynos_phy_writel(exynos_pcie, 0x39, PCIE_PHY_TRSV2_EMP_LVL);
-	exynos_phy_writel(exynos_pcie, 0x39, PCIE_PHY_TRSV3_EMP_LVL);
+	exynos_pcie_writel(ep->phy_base, 0x39, PCIE_PHY_TRSV0_EMP_LVL);
+	exynos_pcie_writel(ep->phy_base, 0x39, PCIE_PHY_TRSV1_EMP_LVL);
+	exynos_pcie_writel(ep->phy_base, 0x39, PCIE_PHY_TRSV2_EMP_LVL);
+	exynos_pcie_writel(ep->phy_base, 0x39, PCIE_PHY_TRSV3_EMP_LVL);
 
 	/* set LVCC */
-	exynos_phy_writel(exynos_pcie, 0x20, PCIE_PHY_TRSV0_LVCC);
-	exynos_phy_writel(exynos_pcie, 0xa0, PCIE_PHY_TRSV1_LVCC);
-	exynos_phy_writel(exynos_pcie, 0xa0, PCIE_PHY_TRSV2_LVCC);
-	exynos_phy_writel(exynos_pcie, 0xa0, PCIE_PHY_TRSV3_LVCC);
+	exynos_pcie_writel(ep->phy_base, 0x20, PCIE_PHY_TRSV0_LVCC);
+	exynos_pcie_writel(ep->phy_base, 0xa0, PCIE_PHY_TRSV1_LVCC);
+	exynos_pcie_writel(ep->phy_base, 0xa0, PCIE_PHY_TRSV2_LVCC);
+	exynos_pcie_writel(ep->phy_base, 0xa0, PCIE_PHY_TRSV3_LVCC);
 }
 
 static void exynos_pcie_assert_reset(struct exynos_pcie *exynos_pcie)
@@ -323,46 +301,48 @@ static int exynos_pcie_establish_link(struct exynos_pcie *exynos_pcie)
 	exynos_pcie_init_phy(exynos_pcie);
 
 	/* pulse for common reset */
-	exynos_blk_writel(exynos_pcie, 1, PCIE_PHY_COMMON_RESET);
+	exynos_pcie_writel(exynos_pcie->block_base, 1, PCIE_PHY_COMMON_RESET);
 	udelay(500);
-	exynos_blk_writel(exynos_pcie, 0, PCIE_PHY_COMMON_RESET);
+	exynos_pcie_writel(exynos_pcie->block_base, 0, PCIE_PHY_COMMON_RESET);
 
 	exynos_pcie_deassert_core_reset(exynos_pcie);
 	dw_pcie_setup_rc(pp);
 	exynos_pcie_assert_reset(exynos_pcie);
 
 	/* assert LTSSM enable */
-	exynos_elb_writel(exynos_pcie, PCIE_ELBI_LTSSM_ENABLE,
+	exynos_pcie_writel(exynos_pcie->elbi_base, PCIE_ELBI_LTSSM_ENABLE,
 			  PCIE_APP_LTSSM_ENABLE);
 
 	/* check if the link is up or not */
 	if (!dw_pcie_wait_for_link(pp))
 		return 0;
 
-	while (exynos_phy_readl(exynos_pcie, PCIE_PHY_PLL_LOCKED) == 0) {
-		val = exynos_blk_readl(exynos_pcie, PCIE_PHY_PLL_LOCKED);
+	while (exynos_pcie_readl(exynos_pcie->phy_base,
+				PCIE_PHY_PLL_LOCKED) == 0) {
+		val = exynos_pcie_readl(exynos_pcie->block_base,
+				PCIE_PHY_PLL_LOCKED);
 		dev_info(dev, "PLL Locked: 0x%x\n", val);
 	}
 	exynos_pcie_power_off_phy(exynos_pcie);
 	return -ETIMEDOUT;
 }
 
-static void exynos_pcie_clear_irq_pulse(struct exynos_pcie *exynos_pcie)
+static void exynos_pcie_clear_irq_pulse(struct exynos_pcie *ep)
 {
 	u32 val;
 
-	val = exynos_elb_readl(exynos_pcie, PCIE_IRQ_PULSE);
-	exynos_elb_writel(exynos_pcie, val, PCIE_IRQ_PULSE);
+	val = exynos_pcie_readl(ep->elbi_base, PCIE_IRQ_PULSE);
+	exynos_pcie_writel(ep->elbi_base, val, PCIE_IRQ_PULSE);
 }
 
-static void exynos_pcie_enable_irq_pulse(struct exynos_pcie *exynos_pcie)
+static void exynos_pcie_enable_irq_pulse(struct exynos_pcie *ep)
 {
 	u32 val;
 
 	/* enable INTX interrupt */
 	val = IRQ_INTA_ASSERT | IRQ_INTB_ASSERT |
 		IRQ_INTC_ASSERT | IRQ_INTD_ASSERT;
-	exynos_elb_writel(exynos_pcie, val, PCIE_IRQ_EN_PULSE);
+	exynos_pcie_writel(ep->elbi_base, val, PCIE_IRQ_EN_PULSE);
 }
 
 static irqreturn_t exynos_pcie_irq_handler(int irq, void *arg)
@@ -381,17 +361,17 @@ static irqreturn_t exynos_pcie_msi_irq_handler(int irq, void *arg)
 	return dw_handle_msi_irq(pp);
 }
 
-static void exynos_pcie_msi_init(struct exynos_pcie *exynos_pcie)
+static void exynos_pcie_msi_init(struct exynos_pcie *ep)
 {
-	struct pcie_port *pp = &exynos_pcie->pp;
+	struct pcie_port *pp = &ep->pp;
 	u32 val;
 
 	dw_pcie_msi_init(pp);
 
 	/* enable MSI interrupt */
-	val = exynos_elb_readl(exynos_pcie, PCIE_IRQ_EN_LEVEL);
+	val = exynos_pcie_readl(ep->elbi_base, PCIE_IRQ_EN_LEVEL);
 	val |= IRQ_MSI_ENABLE;
-	exynos_elb_writel(exynos_pcie, val, PCIE_IRQ_EN_LEVEL);
+	exynos_pcie_writel(ep->elbi_base, val, PCIE_IRQ_EN_LEVEL);
 }
 
 static void exynos_pcie_enable_interrupts(struct exynos_pcie *exynos_pcie)
@@ -451,7 +431,7 @@ static int exynos_pcie_link_up(struct pcie_port *pp)
 	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
 	u32 val;
 
-	val = exynos_elb_readl(exynos_pcie, PCIE_ELBI_RDLH_LINKUP);
+	val = exynos_pcie_readl(exynos_pcie->elbi_base, PCIE_ELBI_RDLH_LINKUP);
 	if (val == PCIE_ELBI_LTSSM_ENABLE)
 		return 1;
 
-- 
2.10.2

