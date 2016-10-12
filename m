Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753528AbcJLNhl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 09:37:41 -0400
Subject: [PATCH v2 3/5] PCI: exynos: Name private struct pointer
 "exynos_pcie" consistently
To: Jingoo Han <jingoohan1@gmail.com>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Kukjin Kim <kgene@kernel.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Date: Wed, 12 Oct 2016 08:37:36 -0500
Message-ID: <20161012133736.28194.54662.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012133428.28194.54006.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012133428.28194.54006.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Most struct exynos_pcie pointers are already called "exynos_pcie".  Change
the rest of them to match.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-exynos.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
index 8e841f8..2b4d886 100644
--- a/drivers/pci/host/pci-exynos.c
+++ b/drivers/pci/host/pci-exynos.c
@@ -102,34 +102,34 @@ struct exynos_pcie {
 #define PCIE_PHY_TRSV3_PD_TSV		(0x1 << 7)
 #define PCIE_PHY_TRSV3_LVCC		0x31c
 
-static void exynos_elb_writel(struct exynos_pcie *pcie, u32 val, u32 reg)
+static void exynos_elb_writel(struct exynos_pcie *exynos_pcie, u32 val, u32 reg)
 {
-	writel(val, pcie->elbi_base + reg);
+	writel(val, exynos_pcie->elbi_base + reg);
 }
 
-static u32 exynos_elb_readl(struct exynos_pcie *pcie, u32 reg)
+static u32 exynos_elb_readl(struct exynos_pcie *exynos_pcie, u32 reg)
 {
-	return readl(pcie->elbi_base + reg);
+	return readl(exynos_pcie->elbi_base + reg);
 }
 
-static void exynos_phy_writel(struct exynos_pcie *pcie, u32 val, u32 reg)
+static void exynos_phy_writel(struct exynos_pcie *exynos_pcie, u32 val, u32 reg)
 {
-	writel(val, pcie->phy_base + reg);
+	writel(val, exynos_pcie->phy_base + reg);
 }
 
-static u32 exynos_phy_readl(struct exynos_pcie *pcie, u32 reg)
+static u32 exynos_phy_readl(struct exynos_pcie *exynos_pcie, u32 reg)
 {
-	return readl(pcie->phy_base + reg);
+	return readl(exynos_pcie->phy_base + reg);
 }
 
-static void exynos_blk_writel(struct exynos_pcie *pcie, u32 val, u32 reg)
+static void exynos_blk_writel(struct exynos_pcie *exynos_pcie, u32 val, u32 reg)
 {
-	writel(val, pcie->block_base + reg);
+	writel(val, exynos_pcie->block_base + reg);
 }
 
-static u32 exynos_blk_readl(struct exynos_pcie *pcie, u32 reg)
+static u32 exynos_blk_readl(struct exynos_pcie *exynos_pcie, u32 reg)
 {
-	return readl(pcie->block_base + reg);
+	return readl(exynos_pcie->block_base + reg);
 }
 
 static void exynos_pcie_sideband_dbi_w_mode(struct pcie_port *pp, bool on)

