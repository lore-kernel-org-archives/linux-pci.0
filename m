Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757313AbcJGQfk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:35:40 -0400
Subject: [PATCH 2/8] PCI: exynos: Pass device-specific struct to internal
 functions
To: Jingoo Han <jingoohan1@gmail.com>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Kukjin Kim <kgene@kernel.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Date: Fri, 07 Oct 2016 11:35:35 -0500
Message-ID: <20161007163534.25314.42168.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007163526.25314.29033.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007163526.25314.29033.stgit@bhelgaas-glaptop2.roam.corp.google.com>
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
 drivers/pci/host/pci-exynos.c |  130 ++++++++++++++++++-----------------------
 1 file changed, 56 insertions(+), 74 deletions(-)

diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
index 05eb246..fa0784d 100644
--- a/drivers/pci/host/pci-exynos.c
+++ b/drivers/pci/host/pci-exynos.c
@@ -132,10 +132,9 @@ static u32 exynos_blk_readl(struct exynos_pcie *exynos, u32 reg)
 	return readl(exynos->block_base + reg);
 }
 
-static void exynos_pcie_sideband_dbi_w_mode(struct pcie_port *pp, bool on)
+static void exynos_pcie_sideband_dbi_w_mode(struct exynos_pcie *exynos, bool on)
 {
 	u32 val;
-	struct exynos_pcie *exynos = to_exynos_pcie(pp);
 
 	if (on) {
 		val = exynos_elb_readl(exynos, PCIE_ELBI_SLV_AWMISC);
@@ -148,10 +147,9 @@ static void exynos_pcie_sideband_dbi_w_mode(struct pcie_port *pp, bool on)
 	}
 }
 
-static void exynos_pcie_sideband_dbi_r_mode(struct pcie_port *pp, bool on)
+static void exynos_pcie_sideband_dbi_r_mode(struct exynos_pcie *exynos, bool on)
 {
 	u32 val;
-	struct exynos_pcie *exynos = to_exynos_pcie(pp);
 
 	if (on) {
 		val = exynos_elb_readl(exynos, PCIE_ELBI_SLV_ARMISC);
@@ -164,10 +162,9 @@ static void exynos_pcie_sideband_dbi_r_mode(struct pcie_port *pp, bool on)
 	}
 }
 
-static void exynos_pcie_assert_core_reset(struct pcie_port *pp)
+static void exynos_pcie_assert_core_reset(struct exynos_pcie *exynos)
 {
 	u32 val;
-	struct exynos_pcie *exynos = to_exynos_pcie(pp);
 
 	val = exynos_elb_readl(exynos, PCIE_CORE_RESET);
 	val &= ~PCIE_CORE_RESET_ENABLE;
@@ -177,10 +174,9 @@ static void exynos_pcie_assert_core_reset(struct pcie_port *pp)
 	exynos_elb_writel(exynos, 0, PCIE_NONSTICKY_RESET);
 }
 
-static void exynos_pcie_deassert_core_reset(struct pcie_port *pp)
+static void exynos_pcie_deassert_core_reset(struct exynos_pcie *exynos)
 {
 	u32 val;
-	struct exynos_pcie *exynos = to_exynos_pcie(pp);
 
 	val = exynos_elb_readl(exynos, PCIE_CORE_RESET);
 	val |= PCIE_CORE_RESET_ENABLE;
@@ -193,18 +189,14 @@ static void exynos_pcie_deassert_core_reset(struct pcie_port *pp)
 	exynos_blk_writel(exynos, 1, PCIE_PHY_MAC_RESET);
 }
 
-static void exynos_pcie_assert_phy_reset(struct pcie_port *pp)
+static void exynos_pcie_assert_phy_reset(struct exynos_pcie *exynos)
 {
-	struct exynos_pcie *exynos = to_exynos_pcie(pp);
-
 	exynos_blk_writel(exynos, 0, PCIE_PHY_MAC_RESET);
 	exynos_blk_writel(exynos, 1, PCIE_PHY_GLOBAL_RESET);
 }
 
-static void exynos_pcie_deassert_phy_reset(struct pcie_port *pp)
+static void exynos_pcie_deassert_phy_reset(struct exynos_pcie *exynos)
 {
-	struct exynos_pcie *exynos = to_exynos_pcie(pp);
-
 	exynos_blk_writel(exynos, 0, PCIE_PHY_GLOBAL_RESET);
 	exynos_elb_writel(exynos, 1, PCIE_PWR_RESET);
 	exynos_blk_writel(exynos, 0, PCIE_PHY_COMMON_RESET);
@@ -213,10 +205,9 @@ static void exynos_pcie_deassert_phy_reset(struct pcie_port *pp)
 	exynos_blk_writel(exynos, 0, PCIE_PHY_TRSV_RESET);
 }
 
-static void exynos_pcie_power_on_phy(struct pcie_port *pp)
+static void exynos_pcie_power_on_phy(struct exynos_pcie *exynos)
 {
 	u32 val;
-	struct exynos_pcie *exynos = to_exynos_pcie(pp);
 
 	val = exynos_phy_readl(exynos, PCIE_PHY_COMMON_POWER);
 	val &= ~PCIE_PHY_COMMON_PD_CMN;
@@ -239,10 +230,9 @@ static void exynos_pcie_power_on_phy(struct pcie_port *pp)
 	exynos_phy_writel(exynos, val, PCIE_PHY_TRSV3_POWER);
 }
 
-static void exynos_pcie_power_off_phy(struct pcie_port *pp)
+static void exynos_pcie_power_off_phy(struct exynos_pcie *exynos)
 {
 	u32 val;
-	struct exynos_pcie *exynos = to_exynos_pcie(pp);
 
 	val = exynos_phy_readl(exynos, PCIE_PHY_COMMON_POWER);
 	val |= PCIE_PHY_COMMON_PD_CMN;
@@ -265,10 +255,8 @@ static void exynos_pcie_power_off_phy(struct pcie_port *pp)
 	exynos_phy_writel(exynos, val, PCIE_PHY_TRSV3_POWER);
 }
 
-static void exynos_pcie_init_phy(struct pcie_port *pp)
+static void exynos_pcie_init_phy(struct exynos_pcie *exynos)
 {
-	struct exynos_pcie *exynos = to_exynos_pcie(pp);
-
 	/* DCC feedback control off */
 	exynos_phy_writel(exynos, 0x29, PCIE_PHY_DCC_FEEDBACK);
 
@@ -305,18 +293,18 @@ static void exynos_pcie_init_phy(struct pcie_port *pp)
 	exynos_phy_writel(exynos, 0xa0, PCIE_PHY_TRSV3_LVCC);
 }
 
-static void exynos_pcie_assert_reset(struct pcie_port *pp)
+static void exynos_pcie_assert_reset(struct exynos_pcie *exynos)
 {
-	struct exynos_pcie *exynos = to_exynos_pcie(pp);
+	struct pcie_port *pp = &exynos->pp;
 
 	if (exynos->reset_gpio >= 0)
 		devm_gpio_request_one(pp->dev, exynos->reset_gpio,
 				GPIOF_OUT_INIT_HIGH, "RESET");
 }
 
-static int exynos_pcie_establish_link(struct pcie_port *pp)
+static int exynos_pcie_establish_link(struct exynos_pcie *exynos)
 {
-	struct exynos_pcie *exynos = to_exynos_pcie(pp);
+	struct pcie_port *pp = &exynos->pp;
 	u32 val;
 
 	if (dw_pcie_link_up(pp)) {
@@ -324,32 +312,20 @@ static int exynos_pcie_establish_link(struct pcie_port *pp)
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
+	exynos_pcie_assert_core_reset(exynos);
+	exynos_pcie_assert_phy_reset(exynos);
+	exynos_pcie_deassert_phy_reset(exynos);
+	exynos_pcie_power_on_phy(exynos);
+	exynos_pcie_init_phy(exynos);
 
 	/* pulse for common reset */
 	exynos_blk_writel(exynos, 1, PCIE_PHY_COMMON_RESET);
 	udelay(500);
 	exynos_blk_writel(exynos, 0, PCIE_PHY_COMMON_RESET);
 
-	/* de-assert core reset */
-	exynos_pcie_deassert_core_reset(pp);
-
-	/* setup root complex */
+	exynos_pcie_deassert_core_reset(exynos);
 	dw_pcie_setup_rc(pp);
-
-	/* assert reset signal */
-	exynos_pcie_assert_reset(pp);
+	exynos_pcie_assert_reset(exynos);
 
 	/* assert LTSSM enable */
 	exynos_elb_writel(exynos, PCIE_ELBI_LTSSM_ENABLE,
@@ -363,25 +339,21 @@ static int exynos_pcie_establish_link(struct pcie_port *pp)
 		val = exynos_blk_readl(exynos, PCIE_PHY_PLL_LOCKED);
 		dev_info(pp->dev, "PLL Locked: 0x%x\n", val);
 	}
-	/* power off phy */
-	exynos_pcie_power_off_phy(pp);
-
+	exynos_pcie_power_off_phy(exynos);
 	return -ETIMEDOUT;
 }
 
-static void exynos_pcie_clear_irq_pulse(struct pcie_port *pp)
+static void exynos_pcie_clear_irq_pulse(struct exynos_pcie *exynos)
 {
 	u32 val;
-	struct exynos_pcie *exynos = to_exynos_pcie(pp);
 
 	val = exynos_elb_readl(exynos, PCIE_IRQ_PULSE);
 	exynos_elb_writel(exynos, val, PCIE_IRQ_PULSE);
 }
 
-static void exynos_pcie_enable_irq_pulse(struct pcie_port *pp)
+static void exynos_pcie_enable_irq_pulse(struct exynos_pcie *exynos)
 {
 	u32 val;
-	struct exynos_pcie *exynos = to_exynos_pcie(pp);
 
 	/* enable INTX interrupt */
 	val = IRQ_INTA_ASSERT | IRQ_INTB_ASSERT |
@@ -391,23 +363,24 @@ static void exynos_pcie_enable_irq_pulse(struct pcie_port *pp)
 
 static irqreturn_t exynos_pcie_irq_handler(int irq, void *arg)
 {
-	struct pcie_port *pp = arg;
+	struct exynos_pcie *exynos = arg;
 
-	exynos_pcie_clear_irq_pulse(pp);
+	exynos_pcie_clear_irq_pulse(exynos);
 	return IRQ_HANDLED;
 }
 
 static irqreturn_t exynos_pcie_msi_irq_handler(int irq, void *arg)
 {
-	struct pcie_port *pp = arg;
+	struct exynos_pcie *exynos = arg;
+	struct pcie_port *pp = &exynos->pp;
 
 	return dw_handle_msi_irq(pp);
 }
 
-static void exynos_pcie_msi_init(struct pcie_port *pp)
+static void exynos_pcie_msi_init(struct exynos_pcie *exynos)
 {
+	struct pcie_port *pp = &exynos->pp;
 	u32 val;
-	struct exynos_pcie *exynos = to_exynos_pcie(pp);
 
 	dw_pcie_msi_init(pp);
 
@@ -417,58 +390,64 @@ static void exynos_pcie_msi_init(struct pcie_port *pp)
 	exynos_elb_writel(exynos, val, PCIE_IRQ_EN_LEVEL);
 }
 
-static void exynos_pcie_enable_interrupts(struct pcie_port *pp)
+static void exynos_pcie_enable_interrupts(struct exynos_pcie *exynos)
 {
-	exynos_pcie_enable_irq_pulse(pp);
+	exynos_pcie_enable_irq_pulse(exynos);
 
 	if (IS_ENABLED(CONFIG_PCI_MSI))
-		exynos_pcie_msi_init(pp);
+		exynos_pcie_msi_init(exynos);
 }
 
 static inline u32 exynos_pcie_readl_rc(struct pcie_port *pp, u32 reg)
 {
+	struct exynos_pcie *exynos = to_exynos_pcie(pp);
 	u32 val;
 
-	exynos_pcie_sideband_dbi_r_mode(pp, true);
+	exynos_pcie_sideband_dbi_r_mode(exynos, true);
 	val = readl(pp->dbi_base + reg);
-	exynos_pcie_sideband_dbi_r_mode(pp, false);
+	exynos_pcie_sideband_dbi_r_mode(exynos, false);
 	return val;
 }
 
 static inline void exynos_pcie_writel_rc(struct pcie_port *pp, u32 reg, u32 val)
 {
-	exynos_pcie_sideband_dbi_w_mode(pp, true);
+	struct exynos_pcie *exynos = to_exynos_pcie(pp);
+
+	exynos_pcie_sideband_dbi_w_mode(exynos, true);
 	writel(val, pp->dbi_base + reg);
-	exynos_pcie_sideband_dbi_w_mode(pp, false);
+	exynos_pcie_sideband_dbi_w_mode(exynos, false);
 }
 
 static int exynos_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
 				u32 *val)
 {
+	struct exynos_pcie *exynos = to_exynos_pcie(pp);
 	int ret;
 
-	exynos_pcie_sideband_dbi_r_mode(pp, true);
+	exynos_pcie_sideband_dbi_r_mode(exynos, true);
 	ret = dw_pcie_cfg_read(pp->dbi_base + where, size, val);
-	exynos_pcie_sideband_dbi_r_mode(pp, false);
+	exynos_pcie_sideband_dbi_r_mode(exynos, false);
 	return ret;
 }
 
 static int exynos_pcie_wr_own_conf(struct pcie_port *pp, int where, int size,
 				u32 val)
 {
+	struct exynos_pcie *exynos = to_exynos_pcie(pp);
 	int ret;
 
-	exynos_pcie_sideband_dbi_w_mode(pp, true);
+	exynos_pcie_sideband_dbi_w_mode(exynos, true);
 	ret = dw_pcie_cfg_write(pp->dbi_base + where, size, val);
-	exynos_pcie_sideband_dbi_w_mode(pp, false);
+	exynos_pcie_sideband_dbi_w_mode(exynos, false);
 	return ret;
 }
 
 static int exynos_pcie_link_up(struct pcie_port *pp)
 {
 	struct exynos_pcie *exynos = to_exynos_pcie(pp);
-	u32 val = exynos_elb_readl(exynos, PCIE_ELBI_RDLH_LINKUP);
+	u32 val;
 
+	val = exynos_elb_readl(exynos, PCIE_ELBI_RDLH_LINKUP);
 	if (val == PCIE_ELBI_LTSSM_ENABLE)
 		return 1;
 
@@ -477,8 +456,10 @@ static int exynos_pcie_link_up(struct pcie_port *pp)
 
 static void exynos_pcie_host_init(struct pcie_port *pp)
 {
-	exynos_pcie_establish_link(pp);
-	exynos_pcie_enable_interrupts(pp);
+	struct exynos_pcie *exynos = to_exynos_pcie(pp);
+
+	exynos_pcie_establish_link(exynos);
+	exynos_pcie_enable_interrupts(exynos);
 }
 
 static struct pcie_host_ops exynos_pcie_host_ops = {
@@ -490,9 +471,10 @@ static struct pcie_host_ops exynos_pcie_host_ops = {
 	.host_init = exynos_pcie_host_init,
 };
 
-static int __init exynos_add_pcie_port(struct pcie_port *pp,
+static int __init exynos_add_pcie_port(struct exynos_pcie *exynos,
 				       struct platform_device *pdev)
 {
+	struct pcie_port *pp = &exynos->pp;
 	int ret;
 
 	pp->irq = platform_get_irq(pdev, 1);
@@ -501,7 +483,7 @@ static int __init exynos_add_pcie_port(struct pcie_port *pp,
 		return -ENODEV;
 	}
 	ret = devm_request_irq(&pdev->dev, pp->irq, exynos_pcie_irq_handler,
-				IRQF_SHARED, "exynos-pcie", pp);
+				IRQF_SHARED, "exynos-pcie", exynos);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to request irq\n");
 		return ret;
@@ -517,7 +499,7 @@ static int __init exynos_add_pcie_port(struct pcie_port *pp,
 		ret = devm_request_irq(&pdev->dev, pp->msi_irq,
 					exynos_pcie_msi_irq_handler,
 					IRQF_SHARED | IRQF_NO_THREAD,
-					"exynos-pcie", pp);
+					"exynos-pcie", exynos);
 		if (ret) {
 			dev_err(&pdev->dev, "failed to request msi irq\n");
 			return ret;
@@ -595,7 +577,7 @@ static int __init exynos_pcie_probe(struct platform_device *pdev)
 		goto fail_bus_clk;
 	}
 
-	ret = exynos_add_pcie_port(pp, pdev);
+	ret = exynos_add_pcie_port(exynos, pdev);
 	if (ret < 0)
 		goto fail_bus_clk;
 

