Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:31442 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752608Ab3H2Mf6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 29 Aug 2013 08:35:58 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MSA00HRNLNXJAE0@mailout1.samsung.com> for
 linux-pci@vger.kernel.org; Thu, 29 Aug 2013 21:35:57 +0900 (KST)
From: Seungwon Jeon <tgih.jun@samsung.com>
To: linux-pci@vger.kernel.org
Cc: 'Bjorn Helgaas' <bhelgaas@google.com>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <001d01cea3e5$3a07c8b0$ae175a10$%jun@samsung.com>
 <000f01cea48e$f5fc3160$e1f49420$%han@samsung.com>
In-reply-to: <000f01cea48e$f5fc3160$e1f49420$%han@samsung.com>
Subject: [PATCH v2 2/3] PCI: exynos: add wrapped I/O access functions
Date: Thu, 29 Aug 2013 21:35:56 +0900
Message-id: <001901cea4b4$4e9db530$ebd91f90$%jun@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

read/write operation for I/O mem is wrapped with hiding
base address inside in order to simplify the usage.
[elbi_base, phy_base, block_base]

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
Acked-by: Jingoo Han <jg1.han@samsung.com>
---
Changes in v2:
 - Removed unnecessary change(removing one line)

 drivers/pci/host/pci-exynos.c |  160 +++++++++++++++++++++++------------------
 1 files changed, 91 insertions(+), 69 deletions(-)

diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
index 012ca8a..94e096b 100644
--- a/drivers/pci/host/pci-exynos.c
+++ b/drivers/pci/host/pci-exynos.c
@@ -91,19 +91,49 @@ struct exynos_pcie {
 #define PCIE_PHY_TRSV3_RXCDR		0x2ec
 #define PCIE_PHY_TRSV3_LVCC		0x31c
 
+static inline void exynos_elb_writel(struct exynos_pcie *pcie, u32 val, u32 reg)
+{
+	writel(val, pcie->elbi_base + reg);
+}
+
+static inline u32 exynos_elb_readl(struct exynos_pcie *pcie, u32 reg)
+{
+	return readl(pcie->elbi_base + reg);
+}
+
+static inline void exynos_phy_writel(struct exynos_pcie *pcie, u32 val, u32 reg)
+{
+	writel(val, pcie->phy_base + reg);
+}
+
+static inline u32 exynos_phy_readl(struct exynos_pcie *pcie, u32 reg)
+{
+	return readl(pcie->phy_base + reg);
+}
+
+static inline void exynos_blk_writel(struct exynos_pcie *pcie, u32 val, u32 reg)
+{
+	writel(val, pcie->block_base + reg);
+}
+
+static inline u32 exynos_blk_readl(struct exynos_pcie *pcie, u32 reg)
+{
+	return readl(pcie->block_base + reg);
+}
+
 static void exynos_pcie_sideband_dbi_w_mode(struct pcie_port *pp, bool on)
 {
 	u32 val;
 	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
 
 	if (on) {
-		val = readl(exynos_pcie->elbi_base + PCIE_ELBI_SLV_AWMISC);
+		val = exynos_elb_readl(exynos_pcie, PCIE_ELBI_SLV_AWMISC);
 		val |= PCIE_ELBI_SLV_DBI_ENABLE;
-		writel(val, exynos_pcie->elbi_base + PCIE_ELBI_SLV_AWMISC);
+		exynos_elb_writel(exynos_pcie, val, PCIE_ELBI_SLV_AWMISC);
 	} else {
-		val = readl(exynos_pcie->elbi_base + PCIE_ELBI_SLV_AWMISC);
+		val = exynos_elb_readl(exynos_pcie, PCIE_ELBI_SLV_AWMISC);
 		val &= ~PCIE_ELBI_SLV_DBI_ENABLE;
-		writel(val, exynos_pcie->elbi_base + PCIE_ELBI_SLV_AWMISC);
+		exynos_elb_writel(exynos_pcie, val, PCIE_ELBI_SLV_AWMISC);
 	}
 }
 
@@ -113,13 +143,13 @@ static void exynos_pcie_sideband_dbi_r_mode(struct pcie_port *pp, bool on)
 	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
 
 	if (on) {
-		val = readl(exynos_pcie->elbi_base + PCIE_ELBI_SLV_ARMISC);
+		val = exynos_elb_readl(exynos_pcie, PCIE_ELBI_SLV_ARMISC);
 		val |= PCIE_ELBI_SLV_DBI_ENABLE;
-		writel(val, exynos_pcie->elbi_base + PCIE_ELBI_SLV_ARMISC);
+		exynos_elb_writel(exynos_pcie, val, PCIE_ELBI_SLV_ARMISC);
 	} else {
-		val = readl(exynos_pcie->elbi_base + PCIE_ELBI_SLV_ARMISC);
+		val = exynos_elb_readl(exynos_pcie, PCIE_ELBI_SLV_ARMISC);
 		val &= ~PCIE_ELBI_SLV_DBI_ENABLE;
-		writel(val, exynos_pcie->elbi_base + PCIE_ELBI_SLV_ARMISC);
+		exynos_elb_writel(exynos_pcie, val, PCIE_ELBI_SLV_ARMISC);
 	}
 }
 
@@ -127,95 +157,89 @@ static void exynos_pcie_assert_core_reset(struct pcie_port *pp)
 {
 	u32 val;
 	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
-	void __iomem *elbi_base = exynos_pcie->elbi_base;
 
-	val = readl(elbi_base + PCIE_CORE_RESET);
+	val = exynos_elb_readl(exynos_pcie, PCIE_CORE_RESET);
 	val &= ~PCIE_CORE_RESET_ENABLE;
-	writel(val, elbi_base + PCIE_CORE_RESET);
-	writel(0, elbi_base + PCIE_PWR_RESET);
-	writel(0, elbi_base + PCIE_STICKY_RESET);
-	writel(0, elbi_base + PCIE_NONSTICKY_RESET);
+	exynos_elb_writel(exynos_pcie, val, PCIE_CORE_RESET);
+	exynos_elb_writel(exynos_pcie, 0, PCIE_PWR_RESET);
+	exynos_elb_writel(exynos_pcie, 0, PCIE_STICKY_RESET);
+	exynos_elb_writel(exynos_pcie, 0, PCIE_NONSTICKY_RESET);
 }
 
 static void exynos_pcie_deassert_core_reset(struct pcie_port *pp)
 {
 	u32 val;
 	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
-	void __iomem *elbi_base = exynos_pcie->elbi_base;
-	void __iomem *block_base = exynos_pcie->block_base;
 
-	val = readl(elbi_base + PCIE_CORE_RESET);
+	val = exynos_elb_readl(exynos_pcie, PCIE_CORE_RESET);
 	val |= PCIE_CORE_RESET_ENABLE;
-	writel(val, elbi_base + PCIE_CORE_RESET);
-	writel(1, elbi_base + PCIE_STICKY_RESET);
-	writel(1, elbi_base + PCIE_NONSTICKY_RESET);
-	writel(1, elbi_base + PCIE_APP_INIT_RESET);
-	writel(0, elbi_base + PCIE_APP_INIT_RESET);
-	writel(1, block_base + PCIE_PHY_MAC_RESET);
+
+	exynos_elb_writel(exynos_pcie, val, PCIE_CORE_RESET);
+	exynos_elb_writel(exynos_pcie, 1, PCIE_STICKY_RESET);
+	exynos_elb_writel(exynos_pcie, 1, PCIE_NONSTICKY_RESET);
+	exynos_elb_writel(exynos_pcie, 1, PCIE_APP_INIT_RESET);
+	exynos_elb_writel(exynos_pcie, 0, PCIE_APP_INIT_RESET);
+	exynos_blk_writel(exynos_pcie, 1, PCIE_PHY_MAC_RESET);
 }
 
 static void exynos_pcie_assert_phy_reset(struct pcie_port *pp)
 {
 	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
-	void __iomem *block_base = exynos_pcie->block_base;
 
-	writel(0, block_base + PCIE_PHY_MAC_RESET);
-	writel(1, block_base + PCIE_PHY_GLOBAL_RESET);
+	exynos_blk_writel(exynos_pcie, 0, PCIE_PHY_MAC_RESET);
+	exynos_blk_writel(exynos_pcie, 1, PCIE_PHY_GLOBAL_RESET);
 }
 
 static void exynos_pcie_deassert_phy_reset(struct pcie_port *pp)
 {
 	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
-	void __iomem *elbi_base = exynos_pcie->elbi_base;
-	void __iomem *block_base = exynos_pcie->block_base;
-
-	writel(0, block_base + PCIE_PHY_GLOBAL_RESET);
-	writel(1, elbi_base + PCIE_PWR_RESET);
-	writel(0, block_base + PCIE_PHY_COMMON_RESET);
-	writel(0, block_base + PCIE_PHY_CMN_REG);
-	writel(0, block_base + PCIE_PHY_TRSVREG_RESET);
-	writel(0, block_base + PCIE_PHY_TRSV_RESET);
+
+	exynos_blk_writel(exynos_pcie, 0, PCIE_PHY_GLOBAL_RESET);
+	exynos_elb_writel(exynos_pcie, 1, PCIE_PWR_RESET);
+	exynos_blk_writel(exynos_pcie, 0, PCIE_PHY_COMMON_RESET);
+	exynos_blk_writel(exynos_pcie, 0, PCIE_PHY_CMN_REG);
+	exynos_blk_writel(exynos_pcie, 0, PCIE_PHY_TRSVREG_RESET);
+	exynos_blk_writel(exynos_pcie, 0, PCIE_PHY_TRSV_RESET);
 }
 
 static void exynos_pcie_init_phy(struct pcie_port *pp)
 {
 	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
-	void __iomem *phy_base = exynos_pcie->phy_base;
 
 	/* DCC feedback control off */
-	writel(0x29, phy_base + PCIE_PHY_DCC_FEEDBACK);
+	exynos_phy_writel(exynos_pcie, 0x29, PCIE_PHY_DCC_FEEDBACK);
 
 	/* set TX/RX impedance */
-	writel(0xd5, phy_base + PCIE_PHY_IMPEDANCE);
+	exynos_phy_writel(exynos_pcie, 0xd5, PCIE_PHY_IMPEDANCE);
 
 	/* set 50Mhz PHY clock */
-	writel(0x14, phy_base + PCIE_PHY_PLL_DIV_0);
-	writel(0x12, phy_base + PCIE_PHY_PLL_DIV_1);
+	exynos_phy_writel(exynos_pcie, 0x14, PCIE_PHY_PLL_DIV_0);
+	exynos_phy_writel(exynos_pcie, 0x12, PCIE_PHY_PLL_DIV_1);
 
 	/* set TX Differential output for lane 0 */
-	writel(0x7f, phy_base + PCIE_PHY_TRSV0_DRV_LVL);
+	exynos_phy_writel(exynos_pcie, 0x7f, PCIE_PHY_TRSV0_DRV_LVL);
 
 	/* set TX Pre-emphasis Level Control for lane 0 to minimum */
-	writel(0x0, phy_base + PCIE_PHY_TRSV0_EMP_LVL);
+	exynos_phy_writel(exynos_pcie, 0x0, PCIE_PHY_TRSV0_EMP_LVL);
 
 	/* set RX clock and data recovery bandwidth */
-	writel(0xe7, phy_base + PCIE_PHY_PLL_BIAS);
-	writel(0x82, phy_base + PCIE_PHY_TRSV0_RXCDR);
-	writel(0x82, phy_base + PCIE_PHY_TRSV1_RXCDR);
-	writel(0x82, phy_base + PCIE_PHY_TRSV2_RXCDR);
-	writel(0x82, phy_base + PCIE_PHY_TRSV3_RXCDR);
+	exynos_phy_writel(exynos_pcie, 0xe7, PCIE_PHY_PLL_BIAS);
+	exynos_phy_writel(exynos_pcie, 0x82, PCIE_PHY_TRSV0_RXCDR);
+	exynos_phy_writel(exynos_pcie, 0x82, PCIE_PHY_TRSV1_RXCDR);
+	exynos_phy_writel(exynos_pcie, 0x82, PCIE_PHY_TRSV2_RXCDR);
+	exynos_phy_writel(exynos_pcie, 0x82, PCIE_PHY_TRSV3_RXCDR);
 
 	/* change TX Pre-emphasis Level Control for lanes */
-	writel(0x39, phy_base + PCIE_PHY_TRSV0_EMP_LVL);
-	writel(0x39, phy_base + PCIE_PHY_TRSV1_EMP_LVL);
-	writel(0x39, phy_base + PCIE_PHY_TRSV2_EMP_LVL);
-	writel(0x39, phy_base + PCIE_PHY_TRSV3_EMP_LVL);
+	exynos_phy_writel(exynos_pcie, 0x39, PCIE_PHY_TRSV0_EMP_LVL);
+	exynos_phy_writel(exynos_pcie, 0x39, PCIE_PHY_TRSV1_EMP_LVL);
+	exynos_phy_writel(exynos_pcie, 0x39, PCIE_PHY_TRSV2_EMP_LVL);
+	exynos_phy_writel(exynos_pcie, 0x39, PCIE_PHY_TRSV3_EMP_LVL);
 
 	/* set LVCC */
-	writel(0x20, phy_base + PCIE_PHY_TRSV0_LVCC);
-	writel(0xa0, phy_base + PCIE_PHY_TRSV1_LVCC);
-	writel(0xa0, phy_base + PCIE_PHY_TRSV2_LVCC);
-	writel(0xa0, phy_base + PCIE_PHY_TRSV3_LVCC);
+	exynos_phy_writel(exynos_pcie, 0x20, PCIE_PHY_TRSV0_LVCC);
+	exynos_phy_writel(exynos_pcie, 0xa0, PCIE_PHY_TRSV1_LVCC);
+	exynos_phy_writel(exynos_pcie, 0xa0, PCIE_PHY_TRSV2_LVCC);
+	exynos_phy_writel(exynos_pcie, 0xa0, PCIE_PHY_TRSV3_LVCC);
 }
 
 static void exynos_pcie_assert_reset(struct pcie_port *pp)
@@ -233,9 +257,6 @@ static int exynos_pcie_establish_link(struct pcie_port *pp)
 	u32 val;
 	int count = 0;
 	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
-	void __iomem *elbi_base = exynos_pcie->elbi_base;
-	void __iomem *block_base = exynos_pcie->block_base;
-	void __iomem *phy_base = exynos_pcie->phy_base;
 
 	if (dw_pcie_link_up(pp)) {
 		dev_err(pp->dev, "Link already up\n");
@@ -253,9 +274,9 @@ static int exynos_pcie_establish_link(struct pcie_port *pp)
 	exynos_pcie_init_phy(pp);
 
 	/* pulse for common reset */
-	writel(1, block_base + PCIE_PHY_COMMON_RESET);
+	exynos_blk_writel(exynos_pcie, 1, PCIE_PHY_COMMON_RESET);
 	udelay(500);
-	writel(0, block_base + PCIE_PHY_COMMON_RESET);
+	exynos_blk_writel(exynos_pcie, 0, PCIE_PHY_COMMON_RESET);
 
 	/* de-assert core reset */
 	exynos_pcie_deassert_core_reset(pp);
@@ -267,15 +288,18 @@ static int exynos_pcie_establish_link(struct pcie_port *pp)
 	exynos_pcie_assert_reset(pp);
 
 	/* assert LTSSM enable */
-	writel(PCIE_ELBI_LTSSM_ENABLE, elbi_base + PCIE_APP_LTSSM_ENABLE);
+	exynos_elb_writel(exynos_pcie, PCIE_ELBI_LTSSM_ENABLE,
+			  PCIE_APP_LTSSM_ENABLE);
 
 	/* check if the link is up or not */
 	while (!dw_pcie_link_up(pp)) {
 		mdelay(100);
 		count++;
 		if (count == 10) {
-			while (readl(phy_base + PCIE_PHY_PLL_LOCKED) == 0) {
-				val = readl(block_base + PCIE_PHY_PLL_LOCKED);
+			while (exynos_phy_readl(exynos_pcie,
+						PCIE_PHY_PLL_LOCKED) == 0) {
+				val = exynos_blk_readl(exynos_pcie,
+						       PCIE_PHY_PLL_LOCKED);
 				dev_info(pp->dev, "PLL Locked: 0x%x\n", val);
 			}
 			dev_err(pp->dev, "PCIe Link Fail\n");
@@ -292,10 +316,9 @@ static void exynos_pcie_clear_irq_pulse(struct pcie_port *pp)
 {
 	u32 val;
 	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
-	void __iomem *elbi_base = exynos_pcie->elbi_base;
 
-	val = readl(elbi_base + PCIE_IRQ_PULSE);
-	writel(val, elbi_base + PCIE_IRQ_PULSE);
+	val = exynos_elb_readl(exynos_pcie, PCIE_IRQ_PULSE);
+	exynos_elb_writel(exynos_pcie, val, PCIE_IRQ_PULSE);
 	return;
 }
 
@@ -303,12 +326,11 @@ static void exynos_pcie_enable_irq_pulse(struct pcie_port *pp)
 {
 	u32 val;
 	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
-	void __iomem *elbi_base = exynos_pcie->elbi_base;
 
 	/* enable INTX interrupt */
 	val = IRQ_INTA_ASSERT | IRQ_INTB_ASSERT |
 		IRQ_INTC_ASSERT | IRQ_INTD_ASSERT,
-	writel(val, elbi_base + PCIE_IRQ_EN_PULSE);
+	exynos_elb_writel(exynos_pcie, val, PCIE_IRQ_EN_PULSE);
 	return;
 }
 
@@ -369,7 +391,7 @@ static int exynos_pcie_wr_own_conf(struct pcie_port *pp, int where, int size,
 static int exynos_pcie_link_up(struct pcie_port *pp)
 {
 	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
-	u32 val = readl(exynos_pcie->elbi_base + PCIE_ELBI_RDLH_LINKUP);
+	u32 val = exynos_elb_readl(exynos_pcie, PCIE_ELBI_RDLH_LINKUP);
 
 	if (val == PCIE_ELBI_LTSSM_ENABLE)
 		return 1;
-- 
1.7.0.4


