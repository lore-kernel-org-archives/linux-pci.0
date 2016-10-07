Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S941022AbcJGQgI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:36:08 -0400
Subject: [PATCH 5/8] PCI: exynos: Swap order of exynos_elb_writel() reg/val
 arguments
To: Jingoo Han <jingoohan1@gmail.com>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Kukjin Kim <kgene@kernel.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Date: Fri, 07 Oct 2016 11:36:03 -0500
Message-ID: <20161007163603.25314.16022.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007163526.25314.29033.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007163526.25314.29033.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Swap order of exynos_elb_writel() arguments to match the "dev, pos, val"
order used by pci_write_config_word() and other drivers.  No functional
change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-exynos.c |   40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
index 5f54ab5..eb50b1a 100644
--- a/drivers/pci/host/pci-exynos.c
+++ b/drivers/pci/host/pci-exynos.c
@@ -107,7 +107,7 @@ static u32 exynos_elb_readl(struct exynos_pcie *exynos, u32 reg)
 	return readl(exynos->elbi_base + reg);
 }
 
-static void exynos_elb_writel(struct exynos_pcie *exynos, u32 val, u32 reg)
+static void exynos_elb_writel(struct exynos_pcie *exynos, u32 reg, u32 val)
 {
 	writel(val, exynos->elbi_base + reg);
 }
@@ -139,11 +139,11 @@ static void exynos_pcie_sideband_dbi_w_mode(struct exynos_pcie *exynos, bool on)
 	if (on) {
 		val = exynos_elb_readl(exynos, PCIE_ELBI_SLV_AWMISC);
 		val |= PCIE_ELBI_SLV_DBI_ENABLE;
-		exynos_elb_writel(exynos, val, PCIE_ELBI_SLV_AWMISC);
+		exynos_elb_writel(exynos, PCIE_ELBI_SLV_AWMISC, val);
 	} else {
 		val = exynos_elb_readl(exynos, PCIE_ELBI_SLV_AWMISC);
 		val &= ~PCIE_ELBI_SLV_DBI_ENABLE;
-		exynos_elb_writel(exynos, val, PCIE_ELBI_SLV_AWMISC);
+		exynos_elb_writel(exynos, PCIE_ELBI_SLV_AWMISC, val);
 	}
 }
 
@@ -154,11 +154,11 @@ static void exynos_pcie_sideband_dbi_r_mode(struct exynos_pcie *exynos, bool on)
 	if (on) {
 		val = exynos_elb_readl(exynos, PCIE_ELBI_SLV_ARMISC);
 		val |= PCIE_ELBI_SLV_DBI_ENABLE;
-		exynos_elb_writel(exynos, val, PCIE_ELBI_SLV_ARMISC);
+		exynos_elb_writel(exynos, PCIE_ELBI_SLV_ARMISC, val);
 	} else {
 		val = exynos_elb_readl(exynos, PCIE_ELBI_SLV_ARMISC);
 		val &= ~PCIE_ELBI_SLV_DBI_ENABLE;
-		exynos_elb_writel(exynos, val, PCIE_ELBI_SLV_ARMISC);
+		exynos_elb_writel(exynos, PCIE_ELBI_SLV_ARMISC, val);
 	}
 }
 
@@ -168,10 +168,10 @@ static void exynos_pcie_assert_core_reset(struct exynos_pcie *exynos)
 
 	val = exynos_elb_readl(exynos, PCIE_CORE_RESET);
 	val &= ~PCIE_CORE_RESET_ENABLE;
-	exynos_elb_writel(exynos, val, PCIE_CORE_RESET);
-	exynos_elb_writel(exynos, 0, PCIE_PWR_RESET);
-	exynos_elb_writel(exynos, 0, PCIE_STICKY_RESET);
-	exynos_elb_writel(exynos, 0, PCIE_NONSTICKY_RESET);
+	exynos_elb_writel(exynos, PCIE_CORE_RESET, val);
+	exynos_elb_writel(exynos, PCIE_PWR_RESET, 0);
+	exynos_elb_writel(exynos, PCIE_STICKY_RESET, 0);
+	exynos_elb_writel(exynos, PCIE_NONSTICKY_RESET, 0);
 }
 
 static void exynos_pcie_deassert_core_reset(struct exynos_pcie *exynos)
@@ -181,11 +181,11 @@ static void exynos_pcie_deassert_core_reset(struct exynos_pcie *exynos)
 	val = exynos_elb_readl(exynos, PCIE_CORE_RESET);
 	val |= PCIE_CORE_RESET_ENABLE;
 
-	exynos_elb_writel(exynos, val, PCIE_CORE_RESET);
-	exynos_elb_writel(exynos, 1, PCIE_STICKY_RESET);
-	exynos_elb_writel(exynos, 1, PCIE_NONSTICKY_RESET);
-	exynos_elb_writel(exynos, 1, PCIE_APP_INIT_RESET);
-	exynos_elb_writel(exynos, 0, PCIE_APP_INIT_RESET);
+	exynos_elb_writel(exynos, PCIE_CORE_RESET, val);
+	exynos_elb_writel(exynos, PCIE_STICKY_RESET, 1);
+	exynos_elb_writel(exynos, PCIE_NONSTICKY_RESET, 1);
+	exynos_elb_writel(exynos, PCIE_APP_INIT_RESET, 1);
+	exynos_elb_writel(exynos, PCIE_APP_INIT_RESET, 0);
 	exynos_blk_writel(exynos, 1, PCIE_PHY_MAC_RESET);
 }
 
@@ -198,7 +198,7 @@ static void exynos_pcie_assert_phy_reset(struct exynos_pcie *exynos)
 static void exynos_pcie_deassert_phy_reset(struct exynos_pcie *exynos)
 {
 	exynos_blk_writel(exynos, 0, PCIE_PHY_GLOBAL_RESET);
-	exynos_elb_writel(exynos, 1, PCIE_PWR_RESET);
+	exynos_elb_writel(exynos, PCIE_PWR_RESET, 1);
 	exynos_blk_writel(exynos, 0, PCIE_PHY_COMMON_RESET);
 	exynos_blk_writel(exynos, 0, PCIE_PHY_CMN_REG);
 	exynos_blk_writel(exynos, 0, PCIE_PHY_TRSVREG_RESET);
@@ -328,8 +328,8 @@ static int exynos_pcie_establish_link(struct exynos_pcie *exynos)
 	exynos_pcie_assert_reset(exynos);
 
 	/* assert LTSSM enable */
-	exynos_elb_writel(exynos, PCIE_ELBI_LTSSM_ENABLE,
-			  PCIE_APP_LTSSM_ENABLE);
+	exynos_elb_writel(exynos, PCIE_APP_LTSSM_ENABLE,
+			  PCIE_ELBI_LTSSM_ENABLE);
 
 	/* check if the link is up or not */
 	if (!dw_pcie_wait_for_link(pp))
@@ -348,7 +348,7 @@ static void exynos_pcie_clear_irq_pulse(struct exynos_pcie *exynos)
 	u32 val;
 
 	val = exynos_elb_readl(exynos, PCIE_IRQ_PULSE);
-	exynos_elb_writel(exynos, val, PCIE_IRQ_PULSE);
+	exynos_elb_writel(exynos, PCIE_IRQ_PULSE, val);
 }
 
 static void exynos_pcie_enable_irq_pulse(struct exynos_pcie *exynos)
@@ -358,7 +358,7 @@ static void exynos_pcie_enable_irq_pulse(struct exynos_pcie *exynos)
 	/* enable INTX interrupt */
 	val = IRQ_INTA_ASSERT | IRQ_INTB_ASSERT |
 		IRQ_INTC_ASSERT | IRQ_INTD_ASSERT;
-	exynos_elb_writel(exynos, val, PCIE_IRQ_EN_PULSE);
+	exynos_elb_writel(exynos, PCIE_IRQ_EN_PULSE, val);
 }
 
 static irqreturn_t exynos_pcie_irq_handler(int irq, void *arg)
@@ -387,7 +387,7 @@ static void exynos_pcie_msi_init(struct exynos_pcie *exynos)
 	/* enable MSI interrupt */
 	val = exynos_elb_readl(exynos, PCIE_IRQ_EN_LEVEL);
 	val |= IRQ_MSI_ENABLE;
-	exynos_elb_writel(exynos, val, PCIE_IRQ_EN_LEVEL);
+	exynos_elb_writel(exynos, PCIE_IRQ_EN_LEVEL, val);
 }
 
 static void exynos_pcie_enable_interrupts(struct exynos_pcie *exynos)

