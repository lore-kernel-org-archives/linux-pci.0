Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35375 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424770AbcBRMAI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 18 Feb 2016 07:00:08 -0500
Received: by mail-wm0-f68.google.com with SMTP id g62so2495970wme.2
        for <linux-pci@vger.kernel.org>; Thu, 18 Feb 2016 04:00:08 -0800 (PST)
From: Christoph Fritz <chf.fritz@googlemail.com>
To: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lee Jones <lee.jones@linaro.org>
Cc: linux-pci@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH v2 2/2] PCI: imx6: add initial imx6sx support
Date: Thu, 18 Feb 2016 12:59:03 +0100
Message-Id: <1455796743-5987-3-git-send-email-chf.fritz@googlemail.com>
In-Reply-To: <1455796743-5987-1-git-send-email-chf.fritz@googlemail.com>
References: <1455796743-5987-1-git-send-email-chf.fritz@googlemail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds initial PCIe support for the imx6 SoC derivate imx6sx.
PCI_MSI support is untested as its necessary suspend/resume quirk is
left out of this patch.
This patch is heavily based on patches by Richard Zhu.

Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
---
 drivers/pci/host/pci-imx6.c | 130 +++++++++++++++++++++++++++++++-------------
 1 file changed, 91 insertions(+), 39 deletions(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index fe60096..7e634a6 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -35,9 +35,11 @@ struct imx6_pcie {
 	struct gpio_desc	*reset_gpio;
 	struct clk		*pcie_bus;
 	struct clk		*pcie_phy;
+	struct clk		*pcie_inbound_axi;
 	struct clk		*pcie;
 	struct pcie_port	pp;
 	struct regmap		*iomuxc_gpr;
+	bool			is_imx6sx;
 	void __iomem		*mem_base;
 };
 
@@ -214,35 +216,46 @@ static int imx6_pcie_assert_core_reset(struct pcie_port *pp)
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
+	if (imx6_pcie->is_imx6sx) {
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				IMX6Q_GPR12_PCIE_CTL_2, 0 << 10);
-	}
+				IMX6SX_GPR12_PCIE_TEST_POWERDOWN,
+				IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
+		/* Force PCIe PHY reset */
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR5,
+					IMX6SX_GPR5_PCIE_BTNRST_RESET,
+					IMX6SX_GPR5_PCIE_BTNRST_RESET);
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
+				(gpr12 & IMX6Q_GPR12_PCIE_CTL_2)) {
+			val = readl(pp->dbi_base + PCIE_PL_PFLR);
+			val &= ~PCIE_PL_PFLR_LINK_STATE_MASK;
+			val |= PCIE_PL_PFLR_FORCE_LINK;
+			writel(val, pp->dbi_base + PCIE_PL_PFLR);
+
+			regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+				IMX6Q_GPR12_PCIE_CTL_2, 0);
+		}
 
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
-			IMX6Q_GPR1_PCIE_TEST_PD, 1 << 18);
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
-			IMX6Q_GPR1_PCIE_REF_CLK_EN, 0 << 16);
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+			IMX6Q_GPR1_PCIE_TEST_PD,
+			IMX6Q_GPR1_PCIE_TEST_PD);
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+			IMX6Q_GPR1_PCIE_REF_CLK_EN, 0);
+	}
 
 	return 0;
 }
@@ -270,18 +283,30 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
 		goto err_pcie;
 	}
 
-	/* power up core phy and enable ref clock */
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
-			IMX6Q_GPR1_PCIE_TEST_PD, 0 << 18);
-	/*
-	 * the async reset input need ref clock to sync internally,
-	 * when the ref clock comes after reset, internal synced
-	 * reset time is too short, cannot meet the requirement.
-	 * add one ~10us delay here.
-	 */
-	udelay(10);
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
-			IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
+	if (imx6_pcie->is_imx6sx) {
+		ret = clk_prepare_enable(imx6_pcie->pcie_inbound_axi);
+		if (ret) {
+			dev_err(pp->dev, "unable to enable pcie_axi clock\n");
+			goto err_inbound_axi;
+		}
+
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+			IMX6SX_GPR12_PCIE_TEST_POWERDOWN, 0);
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
+			IMX6Q_GPR1_PCIE_REF_CLK_EN,
+			IMX6Q_GPR1_PCIE_REF_CLK_EN);
+	}
 
 	/* allow the clocks to stabilize */
 	usleep_range(200, 500);
@@ -292,8 +317,15 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
 		msleep(100);
 		gpiod_set_value_cansleep(imx6_pcie->reset_gpio, 1);
 	}
+
+	if (imx6_pcie->is_imx6sx)
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR5,
+			IMX6SX_GPR5_PCIE_BTNRST_RESET, 0);
+
 	return 0;
 
+err_inbound_axi:
+	clk_disable_unprepare(imx6_pcie->pcie);
 err_pcie:
 	clk_disable_unprepare(imx6_pcie->pcie_bus);
 err_pcie_bus:
@@ -307,6 +339,12 @@ static void imx6_pcie_init_phy(struct pcie_port *pp)
 {
 	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
 
+	if (imx6_pcie->is_imx6sx) {
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+			IMX6SX_GPR12_PCIE_RX_EQ_MASK,
+			IMX6SX_GPR12_PCIE_RX_EQ_2);
+	}
+
 	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 			IMX6Q_GPR12_PCIE_CTL_2, 0 << 10);
 
@@ -571,6 +609,9 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
 	pp = &imx6_pcie->pp;
 	pp->dev = &pdev->dev;
 
+	imx6_pcie->is_imx6sx = of_device_is_compatible(pp->dev->of_node,
+					"fsl,imx6sx-pcie");
+
 	/* Added for PCI abort handling */
 	hook_fault_code(16 + 6, imx6q_pcie_abort_handler, SIGBUS, 0,
 		"imprecise external abort");
@@ -606,6 +647,16 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
 		return PTR_ERR(imx6_pcie->pcie);
 	}
 
+	if (imx6_pcie->is_imx6sx) {
+		imx6_pcie->pcie_inbound_axi = devm_clk_get(&pdev->dev,
+			"pcie_inbound_axi");
+		if (IS_ERR(imx6_pcie->pcie_inbound_axi)) {
+			dev_err(&pdev->dev,
+				"pcie_incbound_axi clock missing or invalid\n");
+			return PTR_ERR(imx6_pcie->pcie_inbound_axi);
+		}
+	}
+
 	/* Grab GPR config register range */
 	imx6_pcie->iomuxc_gpr =
 		 syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
@@ -632,6 +683,7 @@ static void imx6_pcie_shutdown(struct platform_device *pdev)
 
 static const struct of_device_id imx6_pcie_of_match[] = {
 	{ .compatible = "fsl,imx6q-pcie", },
+	{ .compatible = "fsl,imx6sx-pcie", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, imx6_pcie_of_match);
-- 
2.1.4

