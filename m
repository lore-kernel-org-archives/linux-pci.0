Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757322AbcJGQf7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:35:59 -0400
Subject: [PATCH 4/8] PCI: exynos: Reorder accessor functions
To: Jingoo Han <jingoohan1@gmail.com>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Kukjin Kim <kgene@kernel.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Date: Fri, 07 Oct 2016 11:35:54 -0500
Message-ID: <20161007163554.25314.62435.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007163526.25314.29033.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007163526.25314.29033.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Reorder the accessors so the reader is first, as most other drivers do.  No
functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-exynos.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
index c7b0809..5f54ab5 100644
--- a/drivers/pci/host/pci-exynos.c
+++ b/drivers/pci/host/pci-exynos.c
@@ -102,19 +102,14 @@ struct exynos_pcie {
 #define PCIE_PHY_TRSV3_PD_TSV		(0x1 << 7)
 #define PCIE_PHY_TRSV3_LVCC		0x31c
 
-static void exynos_elb_writel(struct exynos_pcie *exynos, u32 val, u32 reg)
-{
-	writel(val, exynos->elbi_base + reg);
-}
-
 static u32 exynos_elb_readl(struct exynos_pcie *exynos, u32 reg)
 {
 	return readl(exynos->elbi_base + reg);
 }
 
-static void exynos_phy_writel(struct exynos_pcie *exynos, u32 val, u32 reg)
+static void exynos_elb_writel(struct exynos_pcie *exynos, u32 val, u32 reg)
 {
-	writel(val, exynos->phy_base + reg);
+	writel(val, exynos->elbi_base + reg);
 }
 
 static u32 exynos_phy_readl(struct exynos_pcie *exynos, u32 reg)
@@ -122,9 +117,9 @@ static u32 exynos_phy_readl(struct exynos_pcie *exynos, u32 reg)
 	return readl(exynos->phy_base + reg);
 }
 
-static void exynos_blk_writel(struct exynos_pcie *exynos, u32 val, u32 reg)
+static void exynos_phy_writel(struct exynos_pcie *exynos, u32 val, u32 reg)
 {
-	writel(val, exynos->block_base + reg);
+	writel(val, exynos->phy_base + reg);
 }
 
 static u32 exynos_blk_readl(struct exynos_pcie *exynos, u32 reg)
@@ -132,6 +127,11 @@ static u32 exynos_blk_readl(struct exynos_pcie *exynos, u32 reg)
 	return readl(exynos->block_base + reg);
 }
 
+static void exynos_blk_writel(struct exynos_pcie *exynos, u32 val, u32 reg)
+{
+	writel(val, exynos->block_base + reg);
+}
+
 static void exynos_pcie_sideband_dbi_w_mode(struct exynos_pcie *exynos, bool on)
 {
 	u32 val;

