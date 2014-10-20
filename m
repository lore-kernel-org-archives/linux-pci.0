Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2on0117.outbound.protection.outlook.com ([207.46.100.117]:9406
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752495AbaJTFz5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 20 Oct 2014 01:55:57 -0400
From: Richard Zhu <richard.zhu@freescale.com>
To: <linux-pci@vger.kernel.org>
CC: <shawn.guo@freescale.com>, <festevam@gmail.com>,
	<l.stach@pengutronix.de>, <tharvey@gateworks.com>,
	<m-karicheri2@ti.com>, Richard Zhu <r65037@freescale.com>,
	Richard Zhu <richard.zhu@freescale.com>
Subject: [PATCH v8 5/9] PCI: imx6: Add imx6sx pcie support
Date: Mon, 20 Oct 2014 13:25:20 +0800
Message-ID: <1413782724-30795-6-git-send-email-richard.zhu@freescale.com>
In-Reply-To: <1413782724-30795-1-git-send-email-richard.zhu@freescale.com>
References: <1413782724-30795-1-git-send-email-richard.zhu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Richard Zhu <r65037@freescale.com>

- imx6sx pcie has its own standalone pcie power supply.
In order to turn on the imx6sx pcie power during
initialization. Add the pcie regulator and the gpc regmap
into the imx6sx pcie structure.
- imx6sx pcie has the new added reset mechanism, add the
reset operations into the initialization.
- disp_axi clock is required by pcie inbound axi port actually.
Add one more clock named pcie_inbound_axi for imx6sx pcie.
- register one PM call-back, enter/exit L2 state during
system suspend/resume.
  * use noirq pm_ops instead of the general pm_ops in
  dev_pm_ops, since cfg read/write may occurs after suspend
  and before resume.
  * do msi store/re-store in suspend/resume callbacks, since
  controller maybe turned off, and these msi cfg maybe lost
  in suspend.
  * assert per-reset in suspend, and de-assert it in resume.
- host init maybe failed, change the func type of host_init
defined in struct pci_host_ops from void to int.

Signed-off-by: Richard Zhu <richard.zhu@freescale.com>
---
 drivers/pci/host/pci-dra7xx.c      |   4 +-
 drivers/pci/host/pci-exynos.c      |   4 +-
 drivers/pci/host/pci-imx6.c        | 265 ++++++++++++++++++++++++++++++-------
 drivers/pci/host/pcie-designware.c |   7 +-
 drivers/pci/host/pcie-designware.h |   2 +-
 drivers/pci/host/pcie-spear13xx.c  |   4 +-
 6 files changed, 232 insertions(+), 54 deletions(-)

diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
index 52b34fe..7b11968 100644
--- a/drivers/pci/host/pci-dra7xx.c
+++ b/drivers/pci/host/pci-dra7xx.c
@@ -141,13 +141,15 @@ static void dra7xx_pcie_enable_interrupts(struct pcie_port *pp)
 				   LEG_EP_INTERRUPTS);
 }
 
-static void dra7xx_pcie_host_init(struct pcie_port *pp)
+static int dra7xx_pcie_host_init(struct pcie_port *pp)
 {
 	dw_pcie_setup_rc(pp);
 	dra7xx_pcie_establish_link(pp);
 	if (IS_ENABLED(CONFIG_PCI_MSI))
 		dw_pcie_msi_init(pp);
 	dra7xx_pcie_enable_interrupts(pp);
+
+	return 0;
 }
 
 static struct pcie_host_ops dra7xx_pcie_host_ops = {
diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
index c5d0ca3..606d0a9 100644
--- a/drivers/pci/host/pci-exynos.c
+++ b/drivers/pci/host/pci-exynos.c
@@ -494,10 +494,12 @@ static int exynos_pcie_link_up(struct pcie_port *pp)
 	return 0;
 }
 
-static void exynos_pcie_host_init(struct pcie_port *pp)
+static int exynos_pcie_host_init(struct pcie_port *pp)
 {
 	exynos_pcie_establish_link(pp);
 	exynos_pcie_enable_interrupts(pp);
+
+	return 0;
 }
 
 static struct pcie_host_ops exynos_pcie_host_ops = {
diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index eac96fb..5d5abe1 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -22,6 +22,7 @@
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/resource.h>
 #include <linux/signal.h>
 #include <linux/types.h>
@@ -35,9 +36,12 @@ struct imx6_pcie {
 	int			reset_gpio;
 	struct clk		*pcie_bus;
 	struct clk		*pcie_phy;
+	struct clk		*pcie_inbound_axi;
 	struct clk		*pcie;
 	struct pcie_port	pp;
 	struct regmap		*iomuxc_gpr;
+	struct regmap		*gpc_ips_reg;
+	struct regulator	*pcie_phy_regulator;
 	void __iomem		*mem_base;
 };
 
@@ -77,6 +81,18 @@ struct imx6_pcie {
 #define PHY_RX_OVRD_IN_LO_RX_DATA_EN (1 << 5)
 #define PHY_RX_OVRD_IN_LO_RX_PLL_EN (1 << 3)
 
+/* GPC PCIE PHY bit definitions */
+#define GPC_CNTR			0
+#define GPC_CNTR_PCIE_PHY_PUP_REQ	BIT(7)
+
+static inline bool is_imx6sx_pcie(struct imx6_pcie *imx6_pcie)
+{
+	struct pcie_port *pp = &imx6_pcie->pp;
+	struct device_node *np = pp->dev->of_node;
+
+	return of_device_is_compatible(np, "fsl,imx6sx-pcie");
+}
+
 static int pcie_phy_poll_ack(void __iomem *dbi_base, int exp_val)
 {
 	u32 val;
@@ -219,35 +235,46 @@ static int imx6_pcie_assert_core_reset(struct pcie_port *pp)
 	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
 	u32 val, gpr1, gpr12;
 
-	/*
-	 * If the bootloader already enabled the link we need some special
-	 * handling to get the core back into a state where it is safe to
-	 * touch it for configuration.  As there is no dedicated reset signal
-	 * wired up for MX6QDL, we need to manually force LTSSM into "detect"
-	 * state before completely disabling LTSSM, which is a prerequisite
-	 * for core configuration.
-	 *
-	 * If both LTSSM_ENABLE and REF_SSP_ENABLE are active we have a strong
-	 * indication that the bootloader activated the link.
-	 */
-	regmap_read(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1, &gpr1);
-	regmap_read(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12, &gpr12);
-
-	if ((gpr1 & IMX6Q_GPR1_PCIE_REF_CLK_EN) &&
-	    (gpr12 & IMX6Q_GPR12_PCIE_CTL_2)) {
-		val = readl(pp->dbi_base + PCIE_PL_PFLR);
-		val &= ~PCIE_PL_PFLR_LINK_STATE_MASK;
-		val |= PCIE_PL_PFLR_FORCE_LINK;
-		writel(val, pp->dbi_base + PCIE_PL_PFLR);
-
+	if (is_imx6sx_pcie(imx6_pcie)) {
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				IMX6Q_GPR12_PCIE_CTL_2, 0 << 10);
-	}
+				IMX6SX_GPR12_PCIE_TEST_PD,
+				IMX6SX_GPR12_PCIE_TEST_PD);
+		/* Force PCIe PHY reset */
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR5,
+				IMX6SX_GPR5_PCIE_BTNRST,
+				IMX6SX_GPR5_PCIE_BTNRST);
+	} else {
+		/*
+		 * If the bootloader already enabled the link we need some
+		 * special handling to get the core back into a state where
+		 * it is safe to touch it for configuration.  As there is no
+		 * dedicated reset signal to manually force LTSSM into "detect"
+		 * state before completely disabling LTSSM, which is a
+		 * prerequisite for core configuration.
+		 *
+		 * If both LTSSM_ENABLE and REF_SSP_ENABLE are active we have
+		 * a strong indication that the bootloader activated the link.
+		 */
+		regmap_read(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1, &gpr1);
+		regmap_read(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12, &gpr12);
+
+		if ((gpr1 & IMX6Q_GPR1_PCIE_REF_CLK_EN) &&
+		    (gpr12 & IMX6Q_GPR12_PCIE_CTL_2)) {
+			val = readl(pp->dbi_base + PCIE_PL_PFLR);
+			val &= ~PCIE_PL_PFLR_LINK_STATE_MASK;
+			val |= PCIE_PL_PFLR_FORCE_LINK;
+			writel(val, pp->dbi_base + PCIE_PL_PFLR);
+
+			regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+					IMX6Q_GPR12_PCIE_CTL_2, 0);
+		}
 
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
-			IMX6Q_GPR1_PCIE_TEST_PD, 1 << 18);
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
-			IMX6Q_GPR1_PCIE_REF_CLK_EN, 0 << 16);
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+				IMX6Q_GPR1_PCIE_TEST_PD,
+				IMX6Q_GPR1_PCIE_TEST_PD);
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+				IMX6Q_GPR1_PCIE_REF_CLK_EN, 0);
+	}
 
 	return 0;
 }
@@ -275,18 +302,30 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
 		goto err_pcie;
 	}
 
-	/* power up core phy and enable ref clock */
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
-			IMX6Q_GPR1_PCIE_TEST_PD, 0 << 18);
-	/*
-	 * the async reset input need ref clock to sync internally,
-	 * when the ref clock comes after reset, internal synced
-	 * reset time is too short , cannot meet the requirement.
-	 * add one ~10us delay here.
-	 */
-	udelay(10);
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
-			IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
+	if (is_imx6sx_pcie(imx6_pcie)) {
+		ret = clk_prepare_enable(imx6_pcie->pcie_inbound_axi);
+		if (ret) {
+			dev_err(pp->dev, "unable to enable pcie clock\n");
+			goto err_inbound_axi;
+		}
+
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+				IMX6SX_GPR12_PCIE_TEST_PD, 0);
+	} else {
+		/* power up core phy and enable ref clock */
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+				IMX6Q_GPR1_PCIE_TEST_PD, 0);
+		/*
+		 * the async reset input need ref clock to sync internally,
+		 * when the ref clock comes after reset, internal synced
+		 * reset time is too short , cannot meet the requirement.
+		 * add one ~10us delay here.
+		 */
+		udelay(10);
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+				IMX6Q_GPR1_PCIE_REF_CLK_EN,
+				IMX6Q_GPR1_PCIE_REF_CLK_EN);
+	}
 
 	/* allow the clocks to stabilize */
 	usleep_range(200, 500);
@@ -297,8 +336,19 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
 		msleep(100);
 		gpio_set_value(imx6_pcie->reset_gpio, 1);
 	}
+
+	/*
+	 * Release the PCIe PHY reset here, that we have set in
+	 * imx6_pcie_assert_core_reset() now
+	 */
+	if (is_imx6sx_pcie(imx6_pcie))
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR5,
+				IMX6SX_GPR5_PCIE_BTNRST, 0);
+
 	return 0;
 
+err_inbound_axi:
+	clk_disable_unprepare(imx6_pcie->pcie);
 err_pcie:
 	clk_disable_unprepare(imx6_pcie->pcie_bus);
 err_pcie_bus:
@@ -308,9 +358,26 @@ err_pcie_phy:
 
 }
 
-static void imx6_pcie_init_phy(struct pcie_port *pp)
+static int imx6_pcie_init_phy(struct pcie_port *pp)
 {
 	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
+	int ret;
+
+	/* Power up the separate domain available on i.MX6SX */
+	if (is_imx6sx_pcie(imx6_pcie)) {
+		regmap_update_bits(imx6_pcie->gpc_ips_reg, GPC_CNTR,
+				GPC_CNTR_PCIE_PHY_PUP_REQ,
+				GPC_CNTR_PCIE_PHY_PUP_REQ);
+		regulator_set_voltage(imx6_pcie->pcie_phy_regulator,
+				1100000, 1100000);
+		ret = regulator_enable(imx6_pcie->pcie_phy_regulator);
+		if (ret) {
+			dev_err(pp->dev, "failed to enable pcie regulator.\n");
+			return ret;
+		}
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+				IMX6SX_GPR12_RX_EQ_MASK, IMX6SX_GPR12_RX_EQ_2);
+	}
 
 	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 			IMX6Q_GPR12_PCIE_CTL_2, 0 << 10);
@@ -319,7 +386,7 @@ static void imx6_pcie_init_phy(struct pcie_port *pp)
 	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 			IMX6Q_GPR12_DEVICE_TYPE, PCI_EXP_TYPE_ROOT_PORT << 12);
 	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
-			IMX6Q_GPR12_LOS_LEVEL, 9 << 4);
+			IMX6Q_GPR12_LOS_LEVEL, IMX6Q_GPR12_LOS_LEVEL_9);
 
 	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
 			IMX6Q_GPR8_TX_DEEMPH_GEN1, 0 << 0);
@@ -331,6 +398,8 @@ static void imx6_pcie_init_phy(struct pcie_port *pp)
 			IMX6Q_GPR8_TX_SWING_FULL, 127 << 18);
 	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
 			IMX6Q_GPR8_TX_SWING_LOW, 127 << 25);
+
+	return 0;
 }
 
 static int imx6_pcie_wait_for_link(struct pcie_port *pp)
@@ -377,7 +446,8 @@ static int imx6_pcie_start_link(struct pcie_port *pp)
 
 	/* Start LTSSM. */
 	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
-			IMX6Q_GPR12_PCIE_CTL_2, 1 << 10);
+			IMX6Q_GPR12_PCIE_CTL_2,
+			IMX6Q_GPR12_PCIE_CTL_2);
 
 	ret = imx6_pcie_wait_for_link(pp);
 	if (ret)
@@ -422,13 +492,19 @@ static int imx6_pcie_start_link(struct pcie_port *pp)
 	return ret;
 }
 
-static void imx6_pcie_host_init(struct pcie_port *pp)
+static int imx6_pcie_host_init(struct pcie_port *pp)
 {
+	int ret;
+
 	imx6_pcie_assert_core_reset(pp);
 
-	imx6_pcie_init_phy(pp);
+	ret = imx6_pcie_init_phy(pp);
+	if (ret < 0)
+		return ret;
 
-	imx6_pcie_deassert_core_reset(pp);
+	ret = imx6_pcie_deassert_core_reset(pp);
+	if (ret < 0)
+		return ret;
 
 	dw_pcie_setup_rc(pp);
 
@@ -436,6 +512,8 @@ static void imx6_pcie_host_init(struct pcie_port *pp)
 
 	if (IS_ENABLED(CONFIG_PCI_MSI))
 		dw_pcie_msi_init(pp);
+
+	return 0;
 }
 
 static void imx6_pcie_reset_phy(struct pcie_port *pp)
@@ -553,6 +631,76 @@ static int __init imx6_add_pcie_port(struct pcie_port *pp,
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int pci_imx_suspend_noirq(struct device *dev)
+{
+	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
+	struct pcie_port *pp = &imx6_pcie->pp;
+
+	if (is_imx6sx_pcie(imx6_pcie)) {
+		if (IS_ENABLED(CONFIG_PCI_MSI))
+			dw_pcie_msi_cfg_store(pp);
+
+		/* PM_TURN_OFF */
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+				IMX6SX_GPR12_PCIE_PM_TURN_OFF,
+				IMX6SX_GPR12_PCIE_PM_TURN_OFF);
+		udelay(10);
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+				IMX6SX_GPR12_PCIE_PM_TURN_OFF, 0);
+		clk_disable_unprepare(imx6_pcie->pcie);
+		clk_disable_unprepare(imx6_pcie->pcie_bus);
+		clk_disable_unprepare(imx6_pcie->pcie_phy);
+		clk_disable_unprepare(imx6_pcie->pcie_inbound_axi);
+
+		/* Assert per-reset to ep */
+		gpio_set_value(imx6_pcie->reset_gpio, 0);
+	}
+
+	return 0;
+}
+
+static int pci_imx_resume_noirq(struct device *dev)
+{
+	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
+	struct pcie_port *pp = &imx6_pcie->pp;
+
+	if (is_imx6sx_pcie(imx6_pcie)) {
+		clk_prepare_enable(imx6_pcie->pcie_inbound_axi);
+		clk_prepare_enable(imx6_pcie->pcie_bus);
+		clk_prepare_enable(imx6_pcie->pcie_phy);
+		clk_prepare_enable(imx6_pcie->pcie);
+
+		/* Reset iMX6SX PCIe */
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR5,
+				IMX6SX_GPR5_PCIE_PERST, IMX6SX_GPR5_PCIE_PERST);
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR5,
+				IMX6SX_GPR5_PCIE_PERST, 0);
+		/*
+		 * controller maybe turn off, re-configure again
+		 */
+		dw_pcie_setup_rc(pp);
+
+		if (IS_ENABLED(CONFIG_PCI_MSI))
+			dw_pcie_msi_cfg_restore(pp);
+
+		/* De-assert per-reset to ep */
+		gpio_set_value(imx6_pcie->reset_gpio, 1);
+	}
+
+	return 0;
+}
+
+static const struct dev_pm_ops pci_imx_pm_ops = {
+	.suspend_noirq = pci_imx_suspend_noirq,
+	.resume_noirq = pci_imx_resume_noirq,
+	.freeze_noirq = pci_imx_suspend_noirq,
+	.thaw_noirq = pci_imx_resume_noirq,
+	.poweroff_noirq = pci_imx_suspend_noirq,
+	.restore_noirq = pci_imx_resume_noirq,
+};
+#endif
+
 static int __init imx6_pcie_probe(struct platform_device *pdev)
 {
 	struct imx6_pcie *imx6_pcie;
@@ -610,9 +758,28 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
 		return PTR_ERR(imx6_pcie->pcie);
 	}
 
-	/* Grab GPR config register range */
-	imx6_pcie->iomuxc_gpr =
-		 syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
+	if (is_imx6sx_pcie(imx6_pcie)) {
+		imx6_pcie->pcie_inbound_axi = devm_clk_get(&pdev->dev,
+				"pcie_inbound_axi");
+		if (IS_ERR(imx6_pcie->pcie_inbound_axi)) {
+			dev_err(&pdev->dev,
+				"pcie clock source missing or invalid\n");
+			return PTR_ERR(imx6_pcie->pcie_inbound_axi);
+		}
+
+		imx6_pcie->pcie_phy_regulator = devm_regulator_get(pp->dev,
+				"pcie-phy");
+
+		imx6_pcie->iomuxc_gpr =
+			 syscon_regmap_lookup_by_compatible
+			 ("fsl,imx6sx-iomuxc-gpr");
+		imx6_pcie->gpc_ips_reg =
+			 syscon_regmap_lookup_by_compatible("fsl,imx6sx-gpc");
+	} else {
+		imx6_pcie->iomuxc_gpr =
+			syscon_regmap_lookup_by_compatible
+			("fsl,imx6q-iomuxc-gpr");
+	}
 	if (IS_ERR(imx6_pcie->iomuxc_gpr)) {
 		dev_err(&pdev->dev, "unable to find iomuxc registers\n");
 		return PTR_ERR(imx6_pcie->iomuxc_gpr);
@@ -636,6 +803,7 @@ static void imx6_pcie_shutdown(struct platform_device *pdev)
 
 static const struct of_device_id imx6_pcie_of_match[] = {
 	{ .compatible = "fsl,imx6q-pcie", },
+	{ .compatible = "fsl,imx6sx-pcie", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, imx6_pcie_of_match);
@@ -645,6 +813,7 @@ static struct platform_driver imx6_pcie_driver = {
 		.name	= "imx6q-pcie",
 		.owner	= THIS_MODULE,
 		.of_match_table = imx6_pcie_of_match,
+		.pm = &pci_imx_pm_ops,
 	},
 	.shutdown = imx6_pcie_shutdown,
 };
diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index e3cd54a..a4bac0a 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -601,8 +601,11 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
 		}
 	}
 
-	if (pp->ops->host_init)
-		pp->ops->host_init(pp);
+	if (pp->ops->host_init) {
+		ret = pp->ops->host_init(pp);
+		if (ret < 0)
+			return ret;
+	}
 
 	dw_pcie_wr_own_conf(pp, PCI_BASE_ADDRESS_0, 4, 0);
 
diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
index 1a59600..6061355 100644
--- a/drivers/pci/host/pcie-designware.h
+++ b/drivers/pci/host/pcie-designware.h
@@ -75,7 +75,7 @@ struct pcie_host_ops {
 	int (*wr_other_conf)(struct pcie_port *pp, struct pci_bus *bus,
 			unsigned int devfn, int where, int size, u32 val);
 	int (*link_up)(struct pcie_port *pp);
-	void (*host_init)(struct pcie_port *pp);
+	int (*host_init)(struct pcie_port *pp);
 	void (*msi_set_irq)(struct pcie_port *pp, int irq);
 	void (*msi_clear_irq)(struct pcie_port *pp, int irq);
 	u32 (*get_msi_data)(struct pcie_port *pp);
diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/host/pcie-spear13xx.c
index 6dea9e4..b8fd76b 100644
--- a/drivers/pci/host/pcie-spear13xx.c
+++ b/drivers/pci/host/pcie-spear13xx.c
@@ -258,10 +258,12 @@ static int spear13xx_pcie_link_up(struct pcie_port *pp)
 	return 0;
 }
 
-static void spear13xx_pcie_host_init(struct pcie_port *pp)
+static int spear13xx_pcie_host_init(struct pcie_port *pp)
 {
 	spear13xx_pcie_establish_link(pp);
 	spear13xx_pcie_enable_interrupts(pp);
+
+	return 0;
 }
 
 static struct pcie_host_ops spear13xx_pcie_host_ops = {
-- 
1.9.1

