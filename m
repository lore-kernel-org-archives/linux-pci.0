Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754829AbcJLNhu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 09:37:50 -0400
Subject: [PATCH v2 4/5] PCI: exynos: Pass device-specific struct to internal
 functions
To: Jingoo Han <jingoohan1@gmail.com>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Kukjin Kim <kgene@kernel.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Date: Wed, 12 Oct 2016 08:37:44 -0500
Message-ID: <20161012133744.28194.65481.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012133428.28194.54006.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012133428.28194.54006.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Only interfaces used from outside the driver, e.g., those called by the
DesignWare core, need to accept pointers to the generic struct pcie_port.
Internal interfaces can accept pointers to the device-specific struct,
which makes them more straightforward.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-exynos.c |  132 ++++++++++++++++++-----------------------
 1 file changed, 58 insertions(+), 74 deletions(-)

diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
index 2b4d886..829aa6b 100644
--- a/drivers/pci/host/pci-exynos.c
+++ b/drivers/pci/host/pci-exynos.c
@@ -132,10 +132,10 @@ static u32 exynos_blk_readl(struct exynos_pcie *exynos_pcie, u32 reg)
 	return readl(exynos_pcie->block_base + reg);
 }
 
-static void exynos_pcie_sideband_dbi_w_mode(struct pcie_port *pp, bool on)
+static void exynos_pcie_sideband_dbi_w_mode(struct exynos_pcie *exynos_pcie,
+					    bool on)
 {
 	u32 val;
-	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
 
 	if (on) {
 		val = exynos_elb_readl(exynos_pcie, PCIE_ELBI_SLV_AWMISC);
@@ -148,10 +148,10 @@ static void exynos_pcie_sideband_dbi_w_mode(struct pcie_port *pp, bool on)
 	}
 }
 
-static void exynos_pcie_sideband_dbi_r_mode(struct pcie_port *pp, bool on)
+static void exynos_pcie_sideband_dbi_r_mode(struct exynos_pcie *exynos_pcie,
+					    bool on)
 {
 	u32 val;
-	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
 
 	if (on) {
 		val = exynos_elb_readl(exynos_pcie, PCIE_ELBI_SLV_ARMISC);
@@ -164,10 +164,9 @@ static void exynos_pcie_sideband_dbi_r_mode(struct pcie_port *pp, bool on)
 	}
 }
 
-static void exynos_pcie_assert_core_reset(struct pcie_port *pp)
+static void exynos_pcie_assert_core_reset(struct exynos_pcie *exynos_pcie)
 {
 	u32 val;
-	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
 
 	val = exynos_elb_readl(exynos_pcie, PCIE_CORE_RESET);
 	val &= ~PCIE_CORE_RESET_ENABLE;
@@ -177,10 +176,9 @@ static void exynos_pcie_assert_core_reset(struct pcie_port *pp)
 	exynos_elb_writel(exynos_pcie, 0, PCIE_NONSTICKY_RESET);
 }
 
-static void exynos_pcie_deassert_core_reset(struct pcie_port *pp)
+static void exynos_pcie_deassert_core_reset(struct exynos_pcie *exynos_pcie)
 {
 	u32 val;
-	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
 
 	val = exynos_elb_readl(exynos_pcie, PCIE_CORE_RESET);
 	val |= PCIE_CORE_RESET_ENABLE;
@@ -193,18 +191,14 @@ static void exynos_pcie_deassert_core_reset(struct pcie_port *pp)
 	exynos_blk_writel(exynos_pcie, 1, PCIE_PHY_MAC_RESET);
 }
 
-static void exynos_pcie_assert_phy_reset(struct pcie_port *pp)
+static void exynos_pcie_assert_phy_reset(struct exynos_pcie *exynos_pcie)
 {
-	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
-
 	exynos_blk_writel(exynos_pcie, 0, PCIE_PHY_MAC_RESET);
 	exynos_blk_writel(exynos_pcie, 1, PCIE_PHY_GLOBAL_RESET);
 }
 
-static void exynos_pcie_deassert_phy_reset(struct pcie_port *pp)
+static void exynos_pcie_deassert_phy_reset(struct exynos_pcie *exynos_pcie)
 {
-	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
-
 	exynos_blk_writel(exynos_pcie, 0, PCIE_PHY_GLOBAL_RESET);
 	exynos_elb_writel(exynos_pcie, 1, PCIE_PWR_RESET);
 	exynos_blk_writel(exynos_pcie, 0, PCIE_PHY_COMMON_RESET);
@@ -213,10 +207,9 @@ static void exynos_pcie_deassert_phy_reset(struct pcie_port *pp)
 	exynos_blk_writel(exynos_pcie, 0, PCIE_PHY_TRSV_RESET);
 }
 
-static void exynos_pcie_power_on_phy(struct pcie_port *pp)
+static void exynos_pcie_power_on_phy(struct exynos_pcie *exynos_pcie)
 {
 	u32 val;
-	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
 
 	val = exynos_phy_readl(exynos_pcie, PCIE_PHY_COMMON_POWER);
 	val &= ~PCIE_PHY_COMMON_PD_CMN;
@@ -239,10 +232,9 @@ static void exynos_pcie_power_on_phy(struct pcie_port *pp)
 	exynos_phy_writel(exynos_pcie, val, PCIE_PHY_TRSV3_POWER);
 }
 
-static void exynos_pcie_power_off_phy(struct pcie_port *pp)
+static void exynos_pcie_power_off_phy(struct exynos_pcie *exynos_pcie)
 {
 	u32 val;
-	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
 
 	val = exynos_phy_readl(exynos_pcie, PCIE_PHY_COMMON_POWER);
 	val |= PCIE_PHY_COMMON_PD_CMN;
@@ -265,10 +257,8 @@ static void exynos_pcie_power_off_phy(struct pcie_port *pp)
 	exynos_phy_writel(exynos_pcie, val, PCIE_PHY_TRSV3_POWER);
 }
 
-static void exynos_pcie_init_phy(struct pcie_port *pp)
+static void exynos_pcie_init_phy(struct exynos_pcie *exynos_pcie)
 {
-	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
-
 	/* DCC feedback control off */
 	exynos_phy_writel(exynos_pcie, 0x29, PCIE_PHY_DCC_FEEDBACK);
 
@@ -305,9 +295,9 @@ static void exynos_pcie_init_phy(struct pcie_port *pp)
 	exynos_phy_writel(exynos_pcie, 0xa0, PCIE_PHY_TRSV3_LVCC);
 }
 
-static void exynos_pcie_assert_reset(struct pcie_port *pp)
+static void exynos_pcie_assert_reset(struct exynos_pcie *exynos_pcie)
 {
-	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
+	struct pcie_port *pp = &exynos_pcie->pp;
 	struct device *dev = pp->dev;
 
 	if (exynos_pcie->reset_gpio >= 0)
@@ -315,9 +305,9 @@ static void exynos_pcie_assert_reset(struct pcie_port *pp)
 				GPIOF_OUT_INIT_HIGH, "RESET");
 }
 
-static int exynos_pcie_establish_link(struct pcie_port *pp)
+static int exynos_pcie_establish_link(struct exynos_pcie *exynos_pcie)
 {
-	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
+	struct pcie_port *pp = &exynos_pcie->pp;
 	struct device *dev = pp->dev;
 	u32 val;
 
@@ -326,32 +316,20 @@ static int exynos_pcie_establish_link(struct pcie_port *pp)
 		return 0;
 	}
 
-	/* assert reset signals */
-	exynos_pcie_assert_core_reset(pp);
-	exynos_pcie_assert_phy_reset(pp);
-
-	/* de-assert phy reset */
-	exynos_pcie_deassert_phy_reset(pp);
-
-	/* power on phy */
-	exynos_pcie_power_on_phy(pp);
-
-	/* initialize phy */
-	exynos_pcie_init_phy(pp);
+	exynos_pcie_assert_core_reset(exynos_pcie);
+	exynos_pcie_assert_phy_reset(exynos_pcie);
+	exynos_pcie_deassert_phy_reset(exynos_pcie);
+	exynos_pcie_power_on_phy(exynos_pcie);
+	exynos_pcie_init_phy(exynos_pcie);
 
 	/* pulse for common reset */
 	exynos_blk_writel(exynos_pcie, 1, PCIE_PHY_COMMON_RESET);
 	udelay(500);
 	exynos_blk_writel(exynos_pcie, 0, PCIE_PHY_COMMON_RESET);
 
-	/* de-assert core reset */
-	exynos_pcie_deassert_core_reset(pp);
-
-	/* setup root complex */
+	exynos_pcie_deassert_core_reset(exynos_pcie);
 	dw_pcie_setup_rc(pp);
-
-	/* assert reset signal */
-	exynos_pcie_assert_reset(pp);
+	exynos_pcie_assert_reset(exynos_pcie);
 
 	/* assert LTSSM enable */
 	exynos_elb_writel(exynos_pcie, PCIE_ELBI_LTSSM_ENABLE,
@@ -365,25 +343,21 @@ static int exynos_pcie_establish_link(struct pcie_port *pp)
 		val = exynos_blk_readl(exynos_pcie, PCIE_PHY_PLL_LOCKED);
 		dev_info(dev, "PLL Locked: 0x%x\n", val);
 	}
-	/* power off phy */
-	exynos_pcie_power_off_phy(pp);
-
+	exynos_pcie_power_off_phy(exynos_pcie);
 	return -ETIMEDOUT;
 }
 
-static void exynos_pcie_clear_irq_pulse(struct pcie_port *pp)
+static void exynos_pcie_clear_irq_pulse(struct exynos_pcie *exynos_pcie)
 {
 	u32 val;
-	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
 
 	val = exynos_elb_readl(exynos_pcie, PCIE_IRQ_PULSE);
 	exynos_elb_writel(exynos_pcie, val, PCIE_IRQ_PULSE);
 }
 
-static void exynos_pcie_enable_irq_pulse(struct pcie_port *pp)
+static void exynos_pcie_enable_irq_pulse(struct exynos_pcie *exynos_pcie)
 {
 	u32 val;
-	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
 
 	/* enable INTX interrupt */
 	val = IRQ_INTA_ASSERT | IRQ_INTB_ASSERT |
@@ -393,23 +367,24 @@ static void exynos_pcie_enable_irq_pulse(struct pcie_port *pp)
 
 static irqreturn_t exynos_pcie_irq_handler(int irq, void *arg)
 {
-	struct pcie_port *pp = arg;
+	struct exynos_pcie *exynos_pcie = arg;
 
-	exynos_pcie_clear_irq_pulse(pp);
+	exynos_pcie_clear_irq_pulse(exynos_pcie);
 	return IRQ_HANDLED;
 }
 
 static irqreturn_t exynos_pcie_msi_irq_handler(int irq, void *arg)
 {
-	struct pcie_port *pp = arg;
+	struct exynos_pcie *exynos_pcie = arg;
+	struct pcie_port *pp = &exynos_pcie->pp;
 
 	return dw_handle_msi_irq(pp);
 }
 
-static void exynos_pcie_msi_init(struct pcie_port *pp)
+static void exynos_pcie_msi_init(struct exynos_pcie *exynos_pcie)
 {
+	struct pcie_port *pp = &exynos_pcie->pp;
 	u32 val;
-	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
 
 	dw_pcie_msi_init(pp);
 
@@ -419,58 +394,64 @@ static void exynos_pcie_msi_init(struct pcie_port *pp)
 	exynos_elb_writel(exynos_pcie, val, PCIE_IRQ_EN_LEVEL);
 }
 
-static void exynos_pcie_enable_interrupts(struct pcie_port *pp)
+static void exynos_pcie_enable_interrupts(struct exynos_pcie *exynos_pcie)
 {
-	exynos_pcie_enable_irq_pulse(pp);
+	exynos_pcie_enable_irq_pulse(exynos_pcie);
 
 	if (IS_ENABLED(CONFIG_PCI_MSI))
-		exynos_pcie_msi_init(pp);
+		exynos_pcie_msi_init(exynos_pcie);
 }
 
 static u32 exynos_pcie_readl_rc(struct pcie_port *pp, u32 reg)
 {
+	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
 	u32 val;
 
-	exynos_pcie_sideband_dbi_r_mode(pp, true);
+	exynos_pcie_sideband_dbi_r_mode(exynos_pcie, true);
 	val = readl(pp->dbi_base + reg);
-	exynos_pcie_sideband_dbi_r_mode(pp, false);
+	exynos_pcie_sideband_dbi_r_mode(exynos_pcie, false);
 	return val;
 }
 
 static void exynos_pcie_writel_rc(struct pcie_port *pp, u32 reg, u32 val)
 {
-	exynos_pcie_sideband_dbi_w_mode(pp, true);
+	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
+
+	exynos_pcie_sideband_dbi_w_mode(exynos_pcie, true);
 	writel(val, pp->dbi_base + reg);
-	exynos_pcie_sideband_dbi_w_mode(pp, false);
+	exynos_pcie_sideband_dbi_w_mode(exynos_pcie, false);
 }
 
 static int exynos_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
 				u32 *val)
 {
+	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
 	int ret;
 
-	exynos_pcie_sideband_dbi_r_mode(pp, true);
+	exynos_pcie_sideband_dbi_r_mode(exynos_pcie, true);
 	ret = dw_pcie_cfg_read(pp->dbi_base + where, size, val);
-	exynos_pcie_sideband_dbi_r_mode(pp, false);
+	exynos_pcie_sideband_dbi_r_mode(exynos_pcie, false);
 	return ret;
 }
 
 static int exynos_pcie_wr_own_conf(struct pcie_port *pp, int where, int size,
 				u32 val)
 {
+	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
 	int ret;
 
-	exynos_pcie_sideband_dbi_w_mode(pp, true);
+	exynos_pcie_sideband_dbi_w_mode(exynos_pcie, true);
 	ret = dw_pcie_cfg_write(pp->dbi_base + where, size, val);
-	exynos_pcie_sideband_dbi_w_mode(pp, false);
+	exynos_pcie_sideband_dbi_w_mode(exynos_pcie, false);
 	return ret;
 }
 
 static int exynos_pcie_link_up(struct pcie_port *pp)
 {
 	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
-	u32 val = exynos_elb_readl(exynos_pcie, PCIE_ELBI_RDLH_LINKUP);
+	u32 val;
 
+	val = exynos_elb_readl(exynos_pcie, PCIE_ELBI_RDLH_LINKUP);
 	if (val == PCIE_ELBI_LTSSM_ENABLE)
 		return 1;
 
@@ -479,8 +460,10 @@ static int exynos_pcie_link_up(struct pcie_port *pp)
 
 static void exynos_pcie_host_init(struct pcie_port *pp)
 {
-	exynos_pcie_establish_link(pp);
-	exynos_pcie_enable_interrupts(pp);
+	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
+
+	exynos_pcie_establish_link(exynos_pcie);
+	exynos_pcie_enable_interrupts(exynos_pcie);
 }
 
 static struct pcie_host_ops exynos_pcie_host_ops = {
@@ -492,9 +475,10 @@ static struct pcie_host_ops exynos_pcie_host_ops = {
 	.host_init = exynos_pcie_host_init,
 };
 
-static int __init exynos_add_pcie_port(struct pcie_port *pp,
+static int __init exynos_add_pcie_port(struct exynos_pcie *exynos_pcie,
 				       struct platform_device *pdev)
 {
+	struct pcie_port *pp = &exynos_pcie->pp;
 	struct device *dev = pp->dev;
 	int ret;
 
@@ -504,7 +488,7 @@ static int __init exynos_add_pcie_port(struct pcie_port *pp,
 		return -ENODEV;
 	}
 	ret = devm_request_irq(dev, pp->irq, exynos_pcie_irq_handler,
-				IRQF_SHARED, "exynos-pcie", pp);
+				IRQF_SHARED, "exynos-pcie", exynos_pcie);
 	if (ret) {
 		dev_err(dev, "failed to request irq\n");
 		return ret;
@@ -520,7 +504,7 @@ static int __init exynos_add_pcie_port(struct pcie_port *pp,
 		ret = devm_request_irq(dev, pp->msi_irq,
 					exynos_pcie_msi_irq_handler,
 					IRQF_SHARED | IRQF_NO_THREAD,
-					"exynos-pcie", pp);
+					"exynos-pcie", exynos_pcie);
 		if (ret) {
 			dev_err(dev, "failed to request msi irq\n");
 			return ret;
@@ -599,7 +583,7 @@ static int __init exynos_pcie_probe(struct platform_device *pdev)
 		goto fail_bus_clk;
 	}
 
-	ret = exynos_add_pcie_port(pp, pdev);
+	ret = exynos_add_pcie_port(exynos_pcie, pdev);
 	if (ret < 0)
 		goto fail_bus_clk;
 

