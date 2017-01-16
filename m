Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:42944 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751009AbdAPGbp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Jan 2017 01:31:45 -0500
From: Jaehoon Chung <jh80.chung@samsung.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, krzk@kernel.org, linux-kernel@vger.kernel.org,
        jingoohan1@gmail.com, javier@osg.samsung.com, kgene@kernel.org,
        linux-samsung-soc@vger.kernel.org, cpgs@samsung.com,
        Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH V3 4/5] PCI: exynos: Use the bitops API to operate the bit
 shifting
Date: Mon, 16 Jan 2017 15:31:37 +0900
Message-id: <20170116063138.25805-5-jh80.chung@samsung.com>
In-reply-to: <20170116063138.25805-1-jh80.chung@samsung.com>
References: <20170116063138.25805-1-jh80.chung@samsung.com>
 <CGME20170116063141epcas5p3717d40cea33d34b715b6c0016c10ab16@epcas5p3.samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Just use the bitops api to operate the bit.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
---
Changelog on V3:
- None
Changelog on V2:
- None
 drivers/pci/host/pci-exynos.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
index 6255294..c5892c2 100644
--- a/drivers/pci/host/pci-exynos.c
+++ b/drivers/pci/host/pci-exynos.c
@@ -40,19 +40,19 @@ struct exynos_pcie {
 
 /* PCIe ELBI registers */
 #define PCIE_IRQ_PULSE			0x000
-#define IRQ_INTA_ASSERT			(0x1 << 0)
-#define IRQ_INTB_ASSERT			(0x1 << 2)
-#define IRQ_INTC_ASSERT			(0x1 << 4)
-#define IRQ_INTD_ASSERT			(0x1 << 6)
+#define IRQ_INTA_ASSERT			BIT(0)
+#define IRQ_INTB_ASSERT			BIT(2)
+#define IRQ_INTC_ASSERT			BIT(4)
+#define IRQ_INTD_ASSERT			BIT(6)
 #define PCIE_IRQ_LEVEL			0x004
 #define PCIE_IRQ_SPECIAL		0x008
 #define PCIE_IRQ_EN_PULSE		0x00c
 #define PCIE_IRQ_EN_LEVEL		0x010
-#define IRQ_MSI_ENABLE			(0x1 << 2)
+#define IRQ_MSI_ENABLE			BIT(2)
 #define PCIE_IRQ_EN_SPECIAL		0x014
 #define PCIE_PWR_RESET			0x018
 #define PCIE_CORE_RESET			0x01c
-#define PCIE_CORE_RESET_ENABLE		(0x1 << 0)
+#define PCIE_CORE_RESET_ENABLE		BIT(0)
 #define PCIE_STICKY_RESET		0x020
 #define PCIE_NONSTICKY_RESET		0x024
 #define PCIE_APP_INIT_RESET		0x028
@@ -61,7 +61,7 @@ struct exynos_pcie {
 #define PCIE_ELBI_LTSSM_ENABLE		0x1
 #define PCIE_ELBI_SLV_AWMISC		0x11c
 #define PCIE_ELBI_SLV_ARMISC		0x120
-#define PCIE_ELBI_SLV_DBI_ENABLE	(0x1 << 21)
+#define PCIE_ELBI_SLV_DBI_ENABLE	BIT(21)
 
 /* PCIe Purple registers */
 #define PCIE_PHY_GLOBAL_RESET		0x000
@@ -79,27 +79,27 @@ struct exynos_pcie {
 #define PCIE_PHY_DCC_FEEDBACK		0x014
 #define PCIE_PHY_PLL_DIV_1		0x05c
 #define PCIE_PHY_COMMON_POWER		0x064
-#define PCIE_PHY_COMMON_PD_CMN		(0x1 << 3)
+#define PCIE_PHY_COMMON_PD_CMN		BIT(3)
 #define PCIE_PHY_TRSV0_EMP_LVL		0x084
 #define PCIE_PHY_TRSV0_DRV_LVL		0x088
 #define PCIE_PHY_TRSV0_RXCDR		0x0ac
 #define PCIE_PHY_TRSV0_POWER		0x0c4
-#define PCIE_PHY_TRSV0_PD_TSV		(0x1 << 7)
+#define PCIE_PHY_TRSV0_PD_TSV		BIT(7)
 #define PCIE_PHY_TRSV0_LVCC		0x0dc
 #define PCIE_PHY_TRSV1_EMP_LVL		0x144
 #define PCIE_PHY_TRSV1_RXCDR		0x16c
 #define PCIE_PHY_TRSV1_POWER		0x184
-#define PCIE_PHY_TRSV1_PD_TSV		(0x1 << 7)
+#define PCIE_PHY_TRSV1_PD_TSV		BIT(7)
 #define PCIE_PHY_TRSV1_LVCC		0x19c
 #define PCIE_PHY_TRSV2_EMP_LVL		0x204
 #define PCIE_PHY_TRSV2_RXCDR		0x22c
 #define PCIE_PHY_TRSV2_POWER		0x244
-#define PCIE_PHY_TRSV2_PD_TSV		(0x1 << 7)
+#define PCIE_PHY_TRSV2_PD_TSV		BIT(7)
 #define PCIE_PHY_TRSV2_LVCC		0x25c
 #define PCIE_PHY_TRSV3_EMP_LVL		0x2c4
 #define PCIE_PHY_TRSV3_RXCDR		0x2ec
 #define PCIE_PHY_TRSV3_POWER		0x304
-#define PCIE_PHY_TRSV3_PD_TSV		(0x1 << 7)
+#define PCIE_PHY_TRSV3_PD_TSV		BIT(7)
 #define PCIE_PHY_TRSV3_LVCC		0x31c
 
 static void exynos_pcie_writel(void __iomem *base, u32 val, u32 reg)
-- 
2.10.2

