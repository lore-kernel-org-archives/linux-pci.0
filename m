Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S941018AbcJGQgd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:36:33 -0400
Subject: [PATCH 7/8] PCI: exynos: Swap order of exynos_blk_writel() reg/val
 arguments
To: Jingoo Han <jingoohan1@gmail.com>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Kukjin Kim <kgene@kernel.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Date: Fri, 07 Oct 2016 11:36:24 -0500
Message-ID: <20161007163623.25314.27460.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007163526.25314.29033.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007163526.25314.29033.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Swap order of exynos_blk_writel() arguments to match the "dev, pos, val"
order used by pci_write_config_word() and other drivers.  No functional
change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-exynos.c |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
index 463cbd6..4fb3ce7 100644
--- a/drivers/pci/host/pci-exynos.c
+++ b/drivers/pci/host/pci-exynos.c
@@ -127,7 +127,7 @@ static u32 exynos_blk_readl(struct exynos_pcie *exynos, u32 reg)
 	return readl(exynos->block_base + reg);
 }
 
-static void exynos_blk_writel(struct exynos_pcie *exynos, u32 val, u32 reg)
+static void exynos_blk_writel(struct exynos_pcie *exynos, u32 reg, u32 val)
 {
 	writel(val, exynos->block_base + reg);
 }
@@ -186,23 +186,23 @@ static void exynos_pcie_deassert_core_reset(struct exynos_pcie *exynos)
 	exynos_elb_writel(exynos, PCIE_NONSTICKY_RESET, 1);
 	exynos_elb_writel(exynos, PCIE_APP_INIT_RESET, 1);
 	exynos_elb_writel(exynos, PCIE_APP_INIT_RESET, 0);
-	exynos_blk_writel(exynos, 1, PCIE_PHY_MAC_RESET);
+	exynos_blk_writel(exynos, PCIE_PHY_MAC_RESET, 1);
 }
 
 static void exynos_pcie_assert_phy_reset(struct exynos_pcie *exynos)
 {
-	exynos_blk_writel(exynos, 0, PCIE_PHY_MAC_RESET);
-	exynos_blk_writel(exynos, 1, PCIE_PHY_GLOBAL_RESET);
+	exynos_blk_writel(exynos, PCIE_PHY_MAC_RESET, 0);
+	exynos_blk_writel(exynos, PCIE_PHY_GLOBAL_RESET, 1);
 }
 
 static void exynos_pcie_deassert_phy_reset(struct exynos_pcie *exynos)
 {
-	exynos_blk_writel(exynos, 0, PCIE_PHY_GLOBAL_RESET);
+	exynos_blk_writel(exynos, PCIE_PHY_GLOBAL_RESET, 0);
 	exynos_elb_writel(exynos, PCIE_PWR_RESET, 1);
-	exynos_blk_writel(exynos, 0, PCIE_PHY_COMMON_RESET);
-	exynos_blk_writel(exynos, 0, PCIE_PHY_CMN_REG);
-	exynos_blk_writel(exynos, 0, PCIE_PHY_TRSVREG_RESET);
-	exynos_blk_writel(exynos, 0, PCIE_PHY_TRSV_RESET);
+	exynos_blk_writel(exynos, PCIE_PHY_COMMON_RESET, 0);
+	exynos_blk_writel(exynos, PCIE_PHY_CMN_REG, 0);
+	exynos_blk_writel(exynos, PCIE_PHY_TRSVREG_RESET, 0);
+	exynos_blk_writel(exynos, PCIE_PHY_TRSV_RESET, 0);
 }
 
 static void exynos_pcie_power_on_phy(struct exynos_pcie *exynos)
@@ -319,9 +319,9 @@ static int exynos_pcie_establish_link(struct exynos_pcie *exynos)
 	exynos_pcie_init_phy(exynos);
 
 	/* pulse for common reset */
-	exynos_blk_writel(exynos, 1, PCIE_PHY_COMMON_RESET);
+	exynos_blk_writel(exynos, PCIE_PHY_COMMON_RESET, 1);
 	udelay(500);
-	exynos_blk_writel(exynos, 0, PCIE_PHY_COMMON_RESET);
+	exynos_blk_writel(exynos, PCIE_PHY_COMMON_RESET, 0);
 
 	exynos_pcie_deassert_core_reset(exynos);
 	dw_pcie_setup_rc(pp);

