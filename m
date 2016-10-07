Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964821AbcJGQir (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:38:47 -0400
Subject: [PATCH 01/10] PCI: imx6: Name private struct pointer "imx6"
 consistently
To: Richard Zhu <Richard.Zhu@freescale.com>,
        Lucas Stach <l.stach@pengutronix.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Fri, 07 Oct 2016 11:38:39 -0500
Message-ID: <20161007163839.25776.2512.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use a device-specific name, "imx6", for struct imx6_pcie pointers to hint
that this is device-specific information.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-imx6.c |  186 ++++++++++++++++++++++---------------------
 1 file changed, 93 insertions(+), 93 deletions(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index ead4a5c..43ae3f9 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -244,21 +244,21 @@ static int imx6q_pcie_abort_handler(unsigned long addr,
 
 static int imx6_pcie_assert_core_reset(struct pcie_port *pp)
 {
-	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
+	struct imx6_pcie *imx6 = to_imx6_pcie(pp);
 	u32 val, gpr1, gpr12;
 
-	switch (imx6_pcie->variant) {
+	switch (imx6->variant) {
 	case IMX6SX:
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+		regmap_update_bits(imx6->iomuxc_gpr, IOMUXC_GPR12,
 				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN,
 				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
 		/* Force PCIe PHY reset */
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR5,
+		regmap_update_bits(imx6->iomuxc_gpr, IOMUXC_GPR5,
 				   IMX6SX_GPR5_PCIE_BTNRST_RESET,
 				   IMX6SX_GPR5_PCIE_BTNRST_RESET);
 		break;
 	case IMX6QP:
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+		regmap_update_bits(imx6->iomuxc_gpr, IOMUXC_GPR1,
 				   IMX6Q_GPR1_PCIE_SW_RST,
 				   IMX6Q_GPR1_PCIE_SW_RST);
 		break;
@@ -276,8 +276,8 @@ static int imx6_pcie_assert_core_reset(struct pcie_port *pp)
 		 * have a strong indication that the bootloader activated
 		 * the link.
 		 */
-		regmap_read(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1, &gpr1);
-		regmap_read(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12, &gpr12);
+		regmap_read(imx6->iomuxc_gpr, IOMUXC_GPR1, &gpr1);
+		regmap_read(imx6->iomuxc_gpr, IOMUXC_GPR12, &gpr12);
 
 		if ((gpr1 & IMX6Q_GPR1_PCIE_REF_CLK_EN) &&
 		    (gpr12 & IMX6Q_GPR12_PCIE_CTL_2)) {
@@ -286,13 +286,13 @@ static int imx6_pcie_assert_core_reset(struct pcie_port *pp)
 			val |= PCIE_PL_PFLR_FORCE_LINK;
 			writel(val, pp->dbi_base + PCIE_PL_PFLR);
 
-			regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+			regmap_update_bits(imx6->iomuxc_gpr, IOMUXC_GPR12,
 					   IMX6Q_GPR12_PCIE_CTL_2, 0 << 10);
 		}
 
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+		regmap_update_bits(imx6->iomuxc_gpr, IOMUXC_GPR1,
 				   IMX6Q_GPR1_PCIE_TEST_PD, 1 << 18);
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+		regmap_update_bits(imx6->iomuxc_gpr, IOMUXC_GPR1,
 				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 0 << 16);
 		break;
 	}
@@ -300,26 +300,26 @@ static int imx6_pcie_assert_core_reset(struct pcie_port *pp)
 	return 0;
 }
 
-static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
+static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6)
 {
-	struct pcie_port *pp = &imx6_pcie->pp;
+	struct pcie_port *pp = &imx6->pp;
 	int ret = 0;
 
-	switch (imx6_pcie->variant) {
+	switch (imx6->variant) {
 	case IMX6SX:
-		ret = clk_prepare_enable(imx6_pcie->pcie_inbound_axi);
+		ret = clk_prepare_enable(imx6->pcie_inbound_axi);
 		if (ret) {
 			dev_err(pp->dev, "unable to enable pcie_axi clock\n");
 			break;
 		}
 
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+		regmap_update_bits(imx6->iomuxc_gpr, IOMUXC_GPR12,
 				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN, 0);
 		break;
 	case IMX6QP: 		/* FALLTHROUGH */
 	case IMX6Q:
 		/* power up core phy and enable ref clock */
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+		regmap_update_bits(imx6->iomuxc_gpr, IOMUXC_GPR1,
 				   IMX6Q_GPR1_PCIE_TEST_PD, 0 << 18);
 		/*
 		 * the async reset input need ref clock to sync internally,
@@ -328,7 +328,7 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 		 * add one ~10us delay here.
 		 */
 		udelay(10);
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+		regmap_update_bits(imx6->iomuxc_gpr, IOMUXC_GPR1,
 				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
 		break;
 	}
@@ -338,28 +338,28 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 
 static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
 {
-	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
+	struct imx6_pcie *imx6 = to_imx6_pcie(pp);
 	int ret;
 
-	ret = clk_prepare_enable(imx6_pcie->pcie_phy);
+	ret = clk_prepare_enable(imx6->pcie_phy);
 	if (ret) {
 		dev_err(pp->dev, "unable to enable pcie_phy clock\n");
 		goto err_pcie_phy;
 	}
 
-	ret = clk_prepare_enable(imx6_pcie->pcie_bus);
+	ret = clk_prepare_enable(imx6->pcie_bus);
 	if (ret) {
 		dev_err(pp->dev, "unable to enable pcie_bus clock\n");
 		goto err_pcie_bus;
 	}
 
-	ret = clk_prepare_enable(imx6_pcie->pcie);
+	ret = clk_prepare_enable(imx6->pcie);
 	if (ret) {
 		dev_err(pp->dev, "unable to enable pcie clock\n");
 		goto err_pcie;
 	}
 
-	ret = imx6_pcie_enable_ref_clk(imx6_pcie);
+	ret = imx6_pcie_enable_ref_clk(imx6);
 	if (ret) {
 		dev_err(pp->dev, "unable to enable pcie ref clock\n");
 		goto err_ref_clk;
@@ -369,21 +369,21 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
 	usleep_range(200, 500);
 
 	/* Some boards don't have PCIe reset GPIO. */
-	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
-		gpio_set_value_cansleep(imx6_pcie->reset_gpio,
-					imx6_pcie->gpio_active_high);
+	if (gpio_is_valid(imx6->reset_gpio)) {
+		gpio_set_value_cansleep(imx6->reset_gpio,
+					imx6->gpio_active_high);
 		msleep(100);
-		gpio_set_value_cansleep(imx6_pcie->reset_gpio,
-					!imx6_pcie->gpio_active_high);
+		gpio_set_value_cansleep(imx6->reset_gpio,
+					!imx6->gpio_active_high);
 	}
 
-	switch (imx6_pcie->variant) {
+	switch (imx6->variant) {
 	case IMX6SX:
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR5,
+		regmap_update_bits(imx6->iomuxc_gpr, IOMUXC_GPR5,
 				   IMX6SX_GPR5_PCIE_BTNRST_RESET, 0);
 		break;
 	case IMX6QP:
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+		regmap_update_bits(imx6->iomuxc_gpr, IOMUXC_GPR1,
 				   IMX6Q_GPR1_PCIE_SW_RST, 0);
 
 		usleep_range(200, 500);
@@ -395,48 +395,48 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
 	return 0;
 
 err_ref_clk:
-	clk_disable_unprepare(imx6_pcie->pcie);
+	clk_disable_unprepare(imx6->pcie);
 err_pcie:
-	clk_disable_unprepare(imx6_pcie->pcie_bus);
+	clk_disable_unprepare(imx6->pcie_bus);
 err_pcie_bus:
-	clk_disable_unprepare(imx6_pcie->pcie_phy);
+	clk_disable_unprepare(imx6->pcie_phy);
 err_pcie_phy:
 	return ret;
 }
 
 static void imx6_pcie_init_phy(struct pcie_port *pp)
 {
-	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
+	struct imx6_pcie *imx6 = to_imx6_pcie(pp);
 
-	if (imx6_pcie->variant == IMX6SX)
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+	if (imx6->variant == IMX6SX)
+		regmap_update_bits(imx6->iomuxc_gpr, IOMUXC_GPR12,
 				   IMX6SX_GPR12_PCIE_RX_EQ_MASK,
 				   IMX6SX_GPR12_PCIE_RX_EQ_2);
 
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+	regmap_update_bits(imx6->iomuxc_gpr, IOMUXC_GPR12,
 			IMX6Q_GPR12_PCIE_CTL_2, 0 << 10);
 
 	/* configure constant input signal to the pcie ctrl and phy */
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+	regmap_update_bits(imx6->iomuxc_gpr, IOMUXC_GPR12,
 			IMX6Q_GPR12_DEVICE_TYPE, PCI_EXP_TYPE_ROOT_PORT << 12);
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+	regmap_update_bits(imx6->iomuxc_gpr, IOMUXC_GPR12,
 			IMX6Q_GPR12_LOS_LEVEL, 9 << 4);
 
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
+	regmap_update_bits(imx6->iomuxc_gpr, IOMUXC_GPR8,
 			   IMX6Q_GPR8_TX_DEEMPH_GEN1,
-			   imx6_pcie->tx_deemph_gen1 << 0);
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
+			   imx6->tx_deemph_gen1 << 0);
+	regmap_update_bits(imx6->iomuxc_gpr, IOMUXC_GPR8,
 			   IMX6Q_GPR8_TX_DEEMPH_GEN2_3P5DB,
-			   imx6_pcie->tx_deemph_gen2_3p5db << 6);
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
+			   imx6->tx_deemph_gen2_3p5db << 6);
+	regmap_update_bits(imx6->iomuxc_gpr, IOMUXC_GPR8,
 			   IMX6Q_GPR8_TX_DEEMPH_GEN2_6DB,
-			   imx6_pcie->tx_deemph_gen2_6db << 12);
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
+			   imx6->tx_deemph_gen2_6db << 12);
+	regmap_update_bits(imx6->iomuxc_gpr, IOMUXC_GPR8,
 			   IMX6Q_GPR8_TX_SWING_FULL,
-			   imx6_pcie->tx_swing_full << 18);
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
+			   imx6->tx_swing_full << 18);
+	regmap_update_bits(imx6->iomuxc_gpr, IOMUXC_GPR8,
 			   IMX6Q_GPR8_TX_SWING_LOW,
-			   imx6_pcie->tx_swing_low << 25);
+			   imx6->tx_swing_low << 25);
 }
 
 static int imx6_pcie_wait_for_link(struct pcie_port *pp)
@@ -477,7 +477,7 @@ static irqreturn_t imx6_pcie_msi_handler(int irq, void *arg)
 
 static int imx6_pcie_establish_link(struct pcie_port *pp)
 {
-	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
+	struct imx6_pcie *imx6 = to_imx6_pcie(pp);
 	u32 tmp;
 	int ret;
 
@@ -492,7 +492,7 @@ static int imx6_pcie_establish_link(struct pcie_port *pp)
 	writel(tmp, pp->dbi_base + PCIE_RC_LCR);
 
 	/* Start LTSSM. */
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+	regmap_update_bits(imx6->iomuxc_gpr, IOMUXC_GPR12,
 			IMX6Q_GPR12_PCIE_CTL_2, 1 << 10);
 
 	ret = imx6_pcie_wait_for_link(pp);
@@ -501,7 +501,7 @@ static int imx6_pcie_establish_link(struct pcie_port *pp)
 		goto err_reset_phy;
 	}
 
-	if (imx6_pcie->link_gen == 2) {
+	if (imx6->link_gen == 2) {
 		/* Allow Gen2 mode after the link is up. */
 		tmp = readl(pp->dbi_base + PCIE_RC_LCR);
 		tmp &= ~PCIE_RC_LCR_MAX_LINK_SPEEDS_MASK;
@@ -608,21 +608,21 @@ static int __init imx6_add_pcie_port(struct pcie_port *pp,
 
 static int __init imx6_pcie_probe(struct platform_device *pdev)
 {
-	struct imx6_pcie *imx6_pcie;
+	struct imx6_pcie *imx6;
 	struct pcie_port *pp;
 	struct device_node *np = pdev->dev.of_node;
 	struct resource *dbi_base;
 	struct device_node *node = pdev->dev.of_node;
 	int ret;
 
-	imx6_pcie = devm_kzalloc(&pdev->dev, sizeof(*imx6_pcie), GFP_KERNEL);
-	if (!imx6_pcie)
+	imx6 = devm_kzalloc(&pdev->dev, sizeof(*imx6), GFP_KERNEL);
+	if (!imx6)
 		return -ENOMEM;
 
-	pp = &imx6_pcie->pp;
+	pp = &imx6->pp;
 	pp->dev = &pdev->dev;
 
-	imx6_pcie->variant =
+	imx6->variant =
 		(enum imx6_pcie_variants)of_device_get_match_data(&pdev->dev);
 
 	/* Added for PCI abort handling */
@@ -635,12 +635,12 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
 		return PTR_ERR(pp->dbi_base);
 
 	/* Fetch GPIOs */
-	imx6_pcie->reset_gpio = of_get_named_gpio(np, "reset-gpio", 0);
-	imx6_pcie->gpio_active_high = of_property_read_bool(np,
+	imx6->reset_gpio = of_get_named_gpio(np, "reset-gpio", 0);
+	imx6->gpio_active_high = of_property_read_bool(np,
 						"reset-gpio-active-high");
-	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
-		ret = devm_gpio_request_one(&pdev->dev, imx6_pcie->reset_gpio,
-				imx6_pcie->gpio_active_high ?
+	if (gpio_is_valid(imx6->reset_gpio)) {
+		ret = devm_gpio_request_one(&pdev->dev, imx6->reset_gpio,
+				imx6->gpio_active_high ?
 					GPIOF_OUT_INIT_HIGH :
 					GPIOF_OUT_INIT_LOW,
 				"PCIe reset");
@@ -651,86 +651,86 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
 	}
 
 	/* Fetch clocks */
-	imx6_pcie->pcie_phy = devm_clk_get(&pdev->dev, "pcie_phy");
-	if (IS_ERR(imx6_pcie->pcie_phy)) {
+	imx6->pcie_phy = devm_clk_get(&pdev->dev, "pcie_phy");
+	if (IS_ERR(imx6->pcie_phy)) {
 		dev_err(&pdev->dev,
 			"pcie_phy clock source missing or invalid\n");
-		return PTR_ERR(imx6_pcie->pcie_phy);
+		return PTR_ERR(imx6->pcie_phy);
 	}
 
-	imx6_pcie->pcie_bus = devm_clk_get(&pdev->dev, "pcie_bus");
-	if (IS_ERR(imx6_pcie->pcie_bus)) {
+	imx6->pcie_bus = devm_clk_get(&pdev->dev, "pcie_bus");
+	if (IS_ERR(imx6->pcie_bus)) {
 		dev_err(&pdev->dev,
 			"pcie_bus clock source missing or invalid\n");
-		return PTR_ERR(imx6_pcie->pcie_bus);
+		return PTR_ERR(imx6->pcie_bus);
 	}
 
-	imx6_pcie->pcie = devm_clk_get(&pdev->dev, "pcie");
-	if (IS_ERR(imx6_pcie->pcie)) {
+	imx6->pcie = devm_clk_get(&pdev->dev, "pcie");
+	if (IS_ERR(imx6->pcie)) {
 		dev_err(&pdev->dev,
 			"pcie clock source missing or invalid\n");
-		return PTR_ERR(imx6_pcie->pcie);
+		return PTR_ERR(imx6->pcie);
 	}
 
-	if (imx6_pcie->variant == IMX6SX) {
-		imx6_pcie->pcie_inbound_axi = devm_clk_get(&pdev->dev,
+	if (imx6->variant == IMX6SX) {
+		imx6->pcie_inbound_axi = devm_clk_get(&pdev->dev,
 							   "pcie_inbound_axi");
-		if (IS_ERR(imx6_pcie->pcie_inbound_axi)) {
+		if (IS_ERR(imx6->pcie_inbound_axi)) {
 			dev_err(&pdev->dev,
 				"pcie_incbound_axi clock missing or invalid\n");
-			return PTR_ERR(imx6_pcie->pcie_inbound_axi);
+			return PTR_ERR(imx6->pcie_inbound_axi);
 		}
 	}
 
 	/* Grab GPR config register range */
-	imx6_pcie->iomuxc_gpr =
+	imx6->iomuxc_gpr =
 		 syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
-	if (IS_ERR(imx6_pcie->iomuxc_gpr)) {
+	if (IS_ERR(imx6->iomuxc_gpr)) {
 		dev_err(&pdev->dev, "unable to find iomuxc registers\n");
-		return PTR_ERR(imx6_pcie->iomuxc_gpr);
+		return PTR_ERR(imx6->iomuxc_gpr);
 	}
 
 	/* Grab PCIe PHY Tx Settings */
 	if (of_property_read_u32(node, "fsl,tx-deemph-gen1",
-				 &imx6_pcie->tx_deemph_gen1))
-		imx6_pcie->tx_deemph_gen1 = 0;
+				 &imx6->tx_deemph_gen1))
+		imx6->tx_deemph_gen1 = 0;
 
 	if (of_property_read_u32(node, "fsl,tx-deemph-gen2-3p5db",
-				 &imx6_pcie->tx_deemph_gen2_3p5db))
-		imx6_pcie->tx_deemph_gen2_3p5db = 0;
+				 &imx6->tx_deemph_gen2_3p5db))
+		imx6->tx_deemph_gen2_3p5db = 0;
 
 	if (of_property_read_u32(node, "fsl,tx-deemph-gen2-6db",
-				 &imx6_pcie->tx_deemph_gen2_6db))
-		imx6_pcie->tx_deemph_gen2_6db = 20;
+				 &imx6->tx_deemph_gen2_6db))
+		imx6->tx_deemph_gen2_6db = 20;
 
 	if (of_property_read_u32(node, "fsl,tx-swing-full",
-				 &imx6_pcie->tx_swing_full))
-		imx6_pcie->tx_swing_full = 127;
+				 &imx6->tx_swing_full))
+		imx6->tx_swing_full = 127;
 
 	if (of_property_read_u32(node, "fsl,tx-swing-low",
-				 &imx6_pcie->tx_swing_low))
-		imx6_pcie->tx_swing_low = 127;
+				 &imx6->tx_swing_low))
+		imx6->tx_swing_low = 127;
 
 	/* Limit link speed */
 	ret = of_property_read_u32(pp->dev->of_node, "fsl,max-link-speed",
-				   &imx6_pcie->link_gen);
+				   &imx6->link_gen);
 	if (ret)
-		imx6_pcie->link_gen = 1;
+		imx6->link_gen = 1;
 
 	ret = imx6_add_pcie_port(pp, pdev);
 	if (ret < 0)
 		return ret;
 
-	platform_set_drvdata(pdev, imx6_pcie);
+	platform_set_drvdata(pdev, imx6);
 	return 0;
 }
 
 static void imx6_pcie_shutdown(struct platform_device *pdev)
 {
-	struct imx6_pcie *imx6_pcie = platform_get_drvdata(pdev);
+	struct imx6_pcie *imx6 = platform_get_drvdata(pdev);
 
 	/* bring down link, so bootloader gets clean state in case of reboot */
-	imx6_pcie_assert_core_reset(&imx6_pcie->pp);
+	imx6_pcie_assert_core_reset(&imx6->pp);
 }
 
 static const struct of_device_id imx6_pcie_of_match[] = {

