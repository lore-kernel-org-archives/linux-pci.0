Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:38961 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751168AbdALCRZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jan 2017 21:17:25 -0500
From: Jaehoon Chung <jh80.chung@samsung.com>
To: linux-pci@vger.kernel.org
Cc: helgaas@google.com, krzk@kernel.org, linux-kernel@vger.kernel.org,
        jingoohan1@gmail.com, javier@osg.samsung.com, kgene@kernel.org,
        linux-samsung-soc@vger.kernel.org, cpgs@samsung.com,
        Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH V2 1/4] PCI: exynos: replace to one register accessor from each
 accessors
Date: Thu, 12 Jan 2017 11:17:16 +0900
Message-id: <20170112021719.24986-1-jh80.chung@samsung.com>
References: <CGME20170112021721epcas1p35f8919666f7c1c3b8b091f43f6807578@epcas1p3.samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There is no reason to maintain *_blk/phy/elbi_* as register accessors.
It can be replaced to one register accessor.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
---
Changelog on V2;
- Changes the all pointer names as "ep" instead of "exynos_pcie"

 drivers/pci/host/pci-exynos.c | 354 ++++++++++++++++++++----------------------
 1 file changed, 167 insertions(+), 187 deletions(-)

diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
index f1c544b..92856cd 100644
--- a/drivers/pci/host/pci-exynos.c
+++ b/drivers/pci/host/pci-exynos.c
@@ -102,212 +102,190 @@ struct exynos_pcie {
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
 
-static void exynos_pcie_assert_reset(struct exynos_pcie *exynos_pcie)
+static void exynos_pcie_assert_reset(struct exynos_pcie *ep)
 {
-	struct pcie_port *pp = &exynos_pcie->pp;
+	struct pcie_port *pp = &ep->pp;
 	struct device *dev = pp->dev;
 
-	if (exynos_pcie->reset_gpio >= 0)
-		devm_gpio_request_one(dev, exynos_pcie->reset_gpio,
+	if (ep->reset_gpio >= 0)
+		devm_gpio_request_one(dev, ep->reset_gpio,
 				GPIOF_OUT_INIT_HIGH, "RESET");
 }
 
-static int exynos_pcie_establish_link(struct exynos_pcie *exynos_pcie)
+static int exynos_pcie_establish_link(struct exynos_pcie *ep)
 {
-	struct pcie_port *pp = &exynos_pcie->pp;
+	struct pcie_port *pp = &ep->pp;
 	struct device *dev = pp->dev;
 	u32 val;
 
@@ -316,142 +294,144 @@ static int exynos_pcie_establish_link(struct exynos_pcie *exynos_pcie)
 		return 0;
 	}
 
-	exynos_pcie_assert_core_reset(exynos_pcie);
-	exynos_pcie_assert_phy_reset(exynos_pcie);
-	exynos_pcie_deassert_phy_reset(exynos_pcie);
-	exynos_pcie_power_on_phy(exynos_pcie);
-	exynos_pcie_init_phy(exynos_pcie);
+	exynos_pcie_assert_core_reset(ep);
+	exynos_pcie_assert_phy_reset(ep);
+	exynos_pcie_deassert_phy_reset(ep);
+	exynos_pcie_power_on_phy(ep);
+	exynos_pcie_init_phy(ep);
 
 	/* pulse for common reset */
-	exynos_blk_writel(exynos_pcie, 1, PCIE_PHY_COMMON_RESET);
+	exynos_pcie_writel(ep->block_base, 1, PCIE_PHY_COMMON_RESET);
 	udelay(500);
-	exynos_blk_writel(exynos_pcie, 0, PCIE_PHY_COMMON_RESET);
+	exynos_pcie_writel(ep->block_base, 0, PCIE_PHY_COMMON_RESET);
 
-	exynos_pcie_deassert_core_reset(exynos_pcie);
+	exynos_pcie_deassert_core_reset(ep);
 	dw_pcie_setup_rc(pp);
-	exynos_pcie_assert_reset(exynos_pcie);
+	exynos_pcie_assert_reset(ep);
 
 	/* assert LTSSM enable */
-	exynos_elb_writel(exynos_pcie, PCIE_ELBI_LTSSM_ENABLE,
+	exynos_pcie_writel(ep->elbi_base, PCIE_ELBI_LTSSM_ENABLE,
 			  PCIE_APP_LTSSM_ENABLE);
 
 	/* check if the link is up or not */
 	if (!dw_pcie_wait_for_link(pp))
 		return 0;
 
-	while (exynos_phy_readl(exynos_pcie, PCIE_PHY_PLL_LOCKED) == 0) {
-		val = exynos_blk_readl(exynos_pcie, PCIE_PHY_PLL_LOCKED);
+	while (exynos_pcie_readl(ep->phy_base,
+				PCIE_PHY_PLL_LOCKED) == 0) {
+		val = exynos_pcie_readl(ep->block_base,
+				PCIE_PHY_PLL_LOCKED);
 		dev_info(dev, "PLL Locked: 0x%x\n", val);
 	}
-	exynos_pcie_power_off_phy(exynos_pcie);
+	exynos_pcie_power_off_phy(ep);
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
 {
-	struct exynos_pcie *exynos_pcie = arg;
+	struct exynos_pcie *ep = arg;
 
-	exynos_pcie_clear_irq_pulse(exynos_pcie);
+	exynos_pcie_clear_irq_pulse(ep);
 	return IRQ_HANDLED;
 }
 
 static irqreturn_t exynos_pcie_msi_irq_handler(int irq, void *arg)
 {
-	struct exynos_pcie *exynos_pcie = arg;
-	struct pcie_port *pp = &exynos_pcie->pp;
+	struct exynos_pcie *ep = arg;
+	struct pcie_port *pp = &ep->pp;
 
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
 
-static void exynos_pcie_enable_interrupts(struct exynos_pcie *exynos_pcie)
+static void exynos_pcie_enable_interrupts(struct exynos_pcie *ep)
 {
-	exynos_pcie_enable_irq_pulse(exynos_pcie);
+	exynos_pcie_enable_irq_pulse(ep);
 
 	if (IS_ENABLED(CONFIG_PCI_MSI))
-		exynos_pcie_msi_init(exynos_pcie);
+		exynos_pcie_msi_init(ep);
 }
 
 static u32 exynos_pcie_readl_rc(struct pcie_port *pp, u32 reg)
 {
-	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
+	struct exynos_pcie *ep = to_exynos_pcie(pp);
 	u32 val;
 
-	exynos_pcie_sideband_dbi_r_mode(exynos_pcie, true);
+	exynos_pcie_sideband_dbi_r_mode(ep, true);
 	val = readl(pp->dbi_base + reg);
-	exynos_pcie_sideband_dbi_r_mode(exynos_pcie, false);
+	exynos_pcie_sideband_dbi_r_mode(ep, false);
 	return val;
 }
 
 static void exynos_pcie_writel_rc(struct pcie_port *pp, u32 reg, u32 val)
 {
-	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
+	struct exynos_pcie *ep = to_exynos_pcie(pp);
 
-	exynos_pcie_sideband_dbi_w_mode(exynos_pcie, true);
+	exynos_pcie_sideband_dbi_w_mode(ep, true);
 	writel(val, pp->dbi_base + reg);
-	exynos_pcie_sideband_dbi_w_mode(exynos_pcie, false);
+	exynos_pcie_sideband_dbi_w_mode(ep, false);
 }
 
 static int exynos_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
 				u32 *val)
 {
-	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
+	struct exynos_pcie *ep = to_exynos_pcie(pp);
 	int ret;
 
-	exynos_pcie_sideband_dbi_r_mode(exynos_pcie, true);
+	exynos_pcie_sideband_dbi_r_mode(ep, true);
 	ret = dw_pcie_cfg_read(pp->dbi_base + where, size, val);
-	exynos_pcie_sideband_dbi_r_mode(exynos_pcie, false);
+	exynos_pcie_sideband_dbi_r_mode(ep, false);
 	return ret;
 }
 
 static int exynos_pcie_wr_own_conf(struct pcie_port *pp, int where, int size,
 				u32 val)
 {
-	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
+	struct exynos_pcie *ep = to_exynos_pcie(pp);
 	int ret;
 
-	exynos_pcie_sideband_dbi_w_mode(exynos_pcie, true);
+	exynos_pcie_sideband_dbi_w_mode(ep, true);
 	ret = dw_pcie_cfg_write(pp->dbi_base + where, size, val);
-	exynos_pcie_sideband_dbi_w_mode(exynos_pcie, false);
+	exynos_pcie_sideband_dbi_w_mode(ep, false);
 	return ret;
 }
 
 static int exynos_pcie_link_up(struct pcie_port *pp)
 {
-	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
+	struct exynos_pcie *ep = to_exynos_pcie(pp);
 	u32 val;
 
-	val = exynos_elb_readl(exynos_pcie, PCIE_ELBI_RDLH_LINKUP);
+	val = exynos_pcie_readl(ep->elbi_base, PCIE_ELBI_RDLH_LINKUP);
 	if (val == PCIE_ELBI_LTSSM_ENABLE)
 		return 1;
 
@@ -460,10 +440,10 @@ static int exynos_pcie_link_up(struct pcie_port *pp)
 
 static void exynos_pcie_host_init(struct pcie_port *pp)
 {
-	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
+	struct exynos_pcie *ep = to_exynos_pcie(pp);
 
-	exynos_pcie_establish_link(exynos_pcie);
-	exynos_pcie_enable_interrupts(exynos_pcie);
+	exynos_pcie_establish_link(ep);
+	exynos_pcie_enable_interrupts(ep);
 }
 
 static struct pcie_host_ops exynos_pcie_host_ops = {
@@ -475,10 +455,10 @@ static struct pcie_host_ops exynos_pcie_host_ops = {
 	.host_init = exynos_pcie_host_init,
 };
 
-static int __init exynos_add_pcie_port(struct exynos_pcie *exynos_pcie,
+static int __init exynos_add_pcie_port(struct exynos_pcie *ep,
 				       struct platform_device *pdev)
 {
-	struct pcie_port *pp = &exynos_pcie->pp;
+	struct pcie_port *pp = &ep->pp;
 	struct device *dev = pp->dev;
 	int ret;
 
@@ -488,7 +468,7 @@ static int __init exynos_add_pcie_port(struct exynos_pcie *exynos_pcie,
 		return -ENODEV;
 	}
 	ret = devm_request_irq(dev, pp->irq, exynos_pcie_irq_handler,
-				IRQF_SHARED, "exynos-pcie", exynos_pcie);
+				IRQF_SHARED, "exynos-pcie", ep);
 	if (ret) {
 		dev_err(dev, "failed to request irq\n");
 		return ret;
@@ -504,7 +484,7 @@ static int __init exynos_add_pcie_port(struct exynos_pcie *exynos_pcie,
 		ret = devm_request_irq(dev, pp->msi_irq,
 					exynos_pcie_msi_irq_handler,
 					IRQF_SHARED | IRQF_NO_THREAD,
-					"exynos-pcie", exynos_pcie);
+					"exynos-pcie", ep);
 		if (ret) {
 			dev_err(dev, "failed to request msi irq\n");
 			return ret;
@@ -526,7 +506,7 @@ static int __init exynos_add_pcie_port(struct exynos_pcie *exynos_pcie,
 static int __init exynos_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct exynos_pcie *exynos_pcie;
+	struct exynos_pcie *ep;
 	struct pcie_port *pp;
 	struct device_node *np = dev->of_node;
 	struct resource *elbi_base;
@@ -534,75 +514,75 @@ static int __init exynos_pcie_probe(struct platform_device *pdev)
 	struct resource *block_base;
 	int ret;
 
-	exynos_pcie = devm_kzalloc(dev, sizeof(*exynos_pcie), GFP_KERNEL);
-	if (!exynos_pcie)
+	ep = devm_kzalloc(dev, sizeof(*ep), GFP_KERNEL);
+	if (!ep)
 		return -ENOMEM;
 
-	pp = &exynos_pcie->pp;
+	pp = &ep->pp;
 	pp->dev = dev;
 
-	exynos_pcie->reset_gpio = of_get_named_gpio(np, "reset-gpio", 0);
+	ep->reset_gpio = of_get_named_gpio(np, "reset-gpio", 0);
 
-	exynos_pcie->clk = devm_clk_get(dev, "pcie");
-	if (IS_ERR(exynos_pcie->clk)) {
+	ep->clk = devm_clk_get(dev, "pcie");
+	if (IS_ERR(ep->clk)) {
 		dev_err(dev, "Failed to get pcie rc clock\n");
-		return PTR_ERR(exynos_pcie->clk);
+		return PTR_ERR(ep->clk);
 	}
-	ret = clk_prepare_enable(exynos_pcie->clk);
+	ret = clk_prepare_enable(ep->clk);
 	if (ret)
 		return ret;
 
-	exynos_pcie->bus_clk = devm_clk_get(dev, "pcie_bus");
-	if (IS_ERR(exynos_pcie->bus_clk)) {
+	ep->bus_clk = devm_clk_get(dev, "pcie_bus");
+	if (IS_ERR(ep->bus_clk)) {
 		dev_err(dev, "Failed to get pcie bus clock\n");
-		ret = PTR_ERR(exynos_pcie->bus_clk);
+		ret = PTR_ERR(ep->bus_clk);
 		goto fail_clk;
 	}
-	ret = clk_prepare_enable(exynos_pcie->bus_clk);
+	ret = clk_prepare_enable(ep->bus_clk);
 	if (ret)
 		goto fail_clk;
 
 	elbi_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	exynos_pcie->elbi_base = devm_ioremap_resource(dev, elbi_base);
-	if (IS_ERR(exynos_pcie->elbi_base)) {
-		ret = PTR_ERR(exynos_pcie->elbi_base);
+	ep->elbi_base = devm_ioremap_resource(dev, elbi_base);
+	if (IS_ERR(ep->elbi_base)) {
+		ret = PTR_ERR(ep->elbi_base);
 		goto fail_bus_clk;
 	}
 
 	phy_base = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	exynos_pcie->phy_base = devm_ioremap_resource(dev, phy_base);
-	if (IS_ERR(exynos_pcie->phy_base)) {
-		ret = PTR_ERR(exynos_pcie->phy_base);
+	ep->phy_base = devm_ioremap_resource(dev, phy_base);
+	if (IS_ERR(ep->phy_base)) {
+		ret = PTR_ERR(ep->phy_base);
 		goto fail_bus_clk;
 	}
 
 	block_base = platform_get_resource(pdev, IORESOURCE_MEM, 2);
-	exynos_pcie->block_base = devm_ioremap_resource(dev, block_base);
-	if (IS_ERR(exynos_pcie->block_base)) {
-		ret = PTR_ERR(exynos_pcie->block_base);
+	ep->block_base = devm_ioremap_resource(dev, block_base);
+	if (IS_ERR(ep->block_base)) {
+		ret = PTR_ERR(ep->block_base);
 		goto fail_bus_clk;
 	}
 
-	ret = exynos_add_pcie_port(exynos_pcie, pdev);
+	ret = exynos_add_pcie_port(ep, pdev);
 	if (ret < 0)
 		goto fail_bus_clk;
 
-	platform_set_drvdata(pdev, exynos_pcie);
+	platform_set_drvdata(pdev, ep);
 	return 0;
 
 fail_bus_clk:
-	clk_disable_unprepare(exynos_pcie->bus_clk);
+	clk_disable_unprepare(ep->bus_clk);
 fail_clk:
-	clk_disable_unprepare(exynos_pcie->clk);
+	clk_disable_unprepare(ep->clk);
 	return ret;
 }
 
 static int __exit exynos_pcie_remove(struct platform_device *pdev)
 {
-	struct exynos_pcie *exynos_pcie = platform_get_drvdata(pdev);
+	struct exynos_pcie *ep = platform_get_drvdata(pdev);
 
-	clk_disable_unprepare(exynos_pcie->bus_clk);
-	clk_disable_unprepare(exynos_pcie->clk);
+	clk_disable_unprepare(ep->bus_clk);
+	clk_disable_unprepare(ep->clk);
 
 	return 0;
 }
-- 
2.10.2

