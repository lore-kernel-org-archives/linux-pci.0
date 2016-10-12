Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932765AbcJLNhd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 09:37:33 -0400
Subject: [PATCH v2 2/5] PCI: exynos: Uninline register accessors
To: Jingoo Han <jingoohan1@gmail.com>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Kukjin Kim <kgene@kernel.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Date: Wed, 12 Oct 2016 08:37:28 -0500
Message-ID: <20161012133728.28194.11799.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012133428.28194.54006.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012133428.28194.54006.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The register accessors are not performance critical and are small enough
that the compiler can inline them itself if it makes sense.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-exynos.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
index e633817..8e841f8 100644
--- a/drivers/pci/host/pci-exynos.c
+++ b/drivers/pci/host/pci-exynos.c
@@ -102,32 +102,32 @@ struct exynos_pcie {
 #define PCIE_PHY_TRSV3_PD_TSV		(0x1 << 7)
 #define PCIE_PHY_TRSV3_LVCC		0x31c
 
-static inline void exynos_elb_writel(struct exynos_pcie *pcie, u32 val, u32 reg)
+static void exynos_elb_writel(struct exynos_pcie *pcie, u32 val, u32 reg)
 {
 	writel(val, pcie->elbi_base + reg);
 }
 
-static inline u32 exynos_elb_readl(struct exynos_pcie *pcie, u32 reg)
+static u32 exynos_elb_readl(struct exynos_pcie *pcie, u32 reg)
 {
 	return readl(pcie->elbi_base + reg);
 }
 
-static inline void exynos_phy_writel(struct exynos_pcie *pcie, u32 val, u32 reg)
+static void exynos_phy_writel(struct exynos_pcie *pcie, u32 val, u32 reg)
 {
 	writel(val, pcie->phy_base + reg);
 }
 
-static inline u32 exynos_phy_readl(struct exynos_pcie *pcie, u32 reg)
+static u32 exynos_phy_readl(struct exynos_pcie *pcie, u32 reg)
 {
 	return readl(pcie->phy_base + reg);
 }
 
-static inline void exynos_blk_writel(struct exynos_pcie *pcie, u32 val, u32 reg)
+static void exynos_blk_writel(struct exynos_pcie *pcie, u32 val, u32 reg)
 {
 	writel(val, pcie->block_base + reg);
 }
 
-static inline u32 exynos_blk_readl(struct exynos_pcie *pcie, u32 reg)
+static u32 exynos_blk_readl(struct exynos_pcie *pcie, u32 reg)
 {
 	return readl(pcie->block_base + reg);
 }
@@ -427,7 +427,7 @@ static void exynos_pcie_enable_interrupts(struct pcie_port *pp)
 		exynos_pcie_msi_init(pp);
 }
 
-static inline u32 exynos_pcie_readl_rc(struct pcie_port *pp, u32 reg)
+static u32 exynos_pcie_readl_rc(struct pcie_port *pp, u32 reg)
 {
 	u32 val;
 
@@ -437,7 +437,7 @@ static inline u32 exynos_pcie_readl_rc(struct pcie_port *pp, u32 reg)
 	return val;
 }
 
-static inline void exynos_pcie_writel_rc(struct pcie_port *pp, u32 reg, u32 val)
+static void exynos_pcie_writel_rc(struct pcie_port *pp, u32 reg, u32 val)
 {
 	exynos_pcie_sideband_dbi_w_mode(pp, true);
 	writel(val, pp->dbi_base + reg);

