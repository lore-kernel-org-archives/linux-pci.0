Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:18229 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941Ab3IFIVs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 6 Sep 2013 04:21:48 -0400
From: Jingoo Han <jg1.han@samsung.com>
To: 'Bjorn Helgaas' <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	'Kukjin Kim' <kgene.kim@samsung.com>,
	'Jingoo Han' <jg1.han@samsung.com>
Subject: [PATCH] PCI: exynos: turn off power of phy block when link failed
Date: Fri, 06 Sep 2013 17:21:45 +0900
Message-id: <002301ceaada$1ffa8fb0$5fefaf10$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When link failed, there is no need to turn on phy block. Also,
turning on phy block is added, in order to turn on phy block
regardless of the default value of phy registers.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
Tested on Exynos5440.

 drivers/pci/host/pci-exynos.c |   68 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
index 94e096b..974f091 100644
--- a/drivers/pci/host/pci-exynos.c
+++ b/drivers/pci/host/pci-exynos.c
@@ -77,18 +77,28 @@ struct exynos_pcie {
 #define PCIE_PHY_PLL_BIAS		0x00c
 #define PCIE_PHY_DCC_FEEDBACK		0x014
 #define PCIE_PHY_PLL_DIV_1		0x05c
+#define PCIE_PHY_COMMON_POWER		0x064
+#define PCIE_PHY_COMMON_PD_CMN		(0x1 << 3)
 #define PCIE_PHY_TRSV0_EMP_LVL		0x084
 #define PCIE_PHY_TRSV0_DRV_LVL		0x088
 #define PCIE_PHY_TRSV0_RXCDR		0x0ac
+#define PCIE_PHY_TRSV0_POWER		0x0c4
+#define PCIE_PHY_TRSV0_PD_TSV		(0x1 << 7)
 #define PCIE_PHY_TRSV0_LVCC		0x0dc
 #define PCIE_PHY_TRSV1_EMP_LVL		0x144
 #define PCIE_PHY_TRSV1_RXCDR		0x16c
+#define PCIE_PHY_TRSV1_POWER		0x184
+#define PCIE_PHY_TRSV1_PD_TSV		(0x1 << 7)
 #define PCIE_PHY_TRSV1_LVCC		0x19c
 #define PCIE_PHY_TRSV2_EMP_LVL		0x204
 #define PCIE_PHY_TRSV2_RXCDR		0x22c
+#define PCIE_PHY_TRSV2_POWER		0x244
+#define PCIE_PHY_TRSV2_PD_TSV		(0x1 << 7)
 #define PCIE_PHY_TRSV2_LVCC		0x25c
 #define PCIE_PHY_TRSV3_EMP_LVL		0x2c4
 #define PCIE_PHY_TRSV3_RXCDR		0x2ec
+#define PCIE_PHY_TRSV3_POWER		0x304
+#define PCIE_PHY_TRSV3_PD_TSV		(0x1 << 7)
 #define PCIE_PHY_TRSV3_LVCC		0x31c
 
 static inline void exynos_elb_writel(struct exynos_pcie *pcie, u32 val, u32 reg)
@@ -202,6 +212,58 @@ static void exynos_pcie_deassert_phy_reset(struct pcie_port *pp)
 	exynos_blk_writel(exynos_pcie, 0, PCIE_PHY_TRSV_RESET);
 }
 
+static void exynos_pcie_power_on_phy(struct pcie_port *pp)
+{
+	u32 val;
+	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
+
+	val = exynos_phy_readl(exynos_pcie, PCIE_PHY_COMMON_POWER);
+	val &= ~PCIE_PHY_COMMON_PD_CMN;
+	exynos_phy_writel(exynos_pcie, val, PCIE_PHY_COMMON_POWER);
+
+	val = exynos_phy_readl(exynos_pcie, PCIE_PHY_TRSV0_POWER);
+	val &= ~PCIE_PHY_TRSV0_PD_TSV;
+	exynos_phy_writel(exynos_pcie, val, PCIE_PHY_TRSV0_POWER);
+
+	val = exynos_phy_readl(exynos_pcie, PCIE_PHY_TRSV1_POWER);
+	val &= ~PCIE_PHY_TRSV1_PD_TSV;
+	exynos_phy_writel(exynos_pcie, val, PCIE_PHY_TRSV1_POWER);
+
+	val = exynos_phy_readl(exynos_pcie, PCIE_PHY_TRSV2_POWER);
+	val &= ~PCIE_PHY_TRSV2_PD_TSV;
+	exynos_phy_writel(exynos_pcie, val, PCIE_PHY_TRSV2_POWER);
+
+	val = exynos_phy_readl(exynos_pcie, PCIE_PHY_TRSV3_POWER);
+	val &= ~PCIE_PHY_TRSV3_PD_TSV;
+	exynos_phy_writel(exynos_pcie, val, PCIE_PHY_TRSV3_POWER);
+}
+
+static void exynos_pcie_power_off_phy(struct pcie_port *pp)
+{
+	u32 val;
+	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
+
+	val = exynos_phy_readl(exynos_pcie, PCIE_PHY_COMMON_POWER);
+	val |= PCIE_PHY_COMMON_PD_CMN;
+	exynos_phy_writel(exynos_pcie, val, PCIE_PHY_COMMON_POWER);
+
+	val = exynos_phy_readl(exynos_pcie, PCIE_PHY_TRSV0_POWER);
+	val |= PCIE_PHY_TRSV0_PD_TSV;
+	exynos_phy_writel(exynos_pcie, val, PCIE_PHY_TRSV0_POWER);
+
+	val = exynos_phy_readl(exynos_pcie, PCIE_PHY_TRSV1_POWER);
+	val |= PCIE_PHY_TRSV1_PD_TSV;
+	exynos_phy_writel(exynos_pcie, val, PCIE_PHY_TRSV1_POWER);
+
+	val = exynos_phy_readl(exynos_pcie, PCIE_PHY_TRSV2_POWER);
+	val |= PCIE_PHY_TRSV2_PD_TSV;
+	exynos_phy_writel(exynos_pcie, val, PCIE_PHY_TRSV2_POWER);
+
+	val = exynos_phy_readl(exynos_pcie, PCIE_PHY_TRSV3_POWER);
+	val |= PCIE_PHY_TRSV3_PD_TSV;
+	exynos_phy_writel(exynos_pcie, val, PCIE_PHY_TRSV3_POWER);
+}
+
 static void exynos_pcie_init_phy(struct pcie_port *pp)
 {
 	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
@@ -270,6 +332,9 @@ static int exynos_pcie_establish_link(struct pcie_port *pp)
 	/* de-assert phy reset */
 	exynos_pcie_deassert_phy_reset(pp);
 
+	/* power on phy */
+	exynos_pcie_power_on_phy(pp);
+
 	/* initialize phy */
 	exynos_pcie_init_phy(pp);
 
@@ -302,6 +367,9 @@ static int exynos_pcie_establish_link(struct pcie_port *pp)
 						       PCIE_PHY_PLL_LOCKED);
 				dev_info(pp->dev, "PLL Locked: 0x%x\n", val);
 			}
+			/* power off phy */
+			exynos_pcie_power_off_phy(pp);
+
 			dev_err(pp->dev, "PCIe Link Fail\n");
 			return -EINVAL;
 		}
-- 
1.7.10.4


