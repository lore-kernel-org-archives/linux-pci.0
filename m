Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35413 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402AbcBNUxk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 14 Feb 2016 15:53:40 -0500
Received: by mail-wm0-f65.google.com with SMTP id g62so12567361wme.2
        for <linux-pci@vger.kernel.org>; Sun, 14 Feb 2016 12:53:39 -0800 (PST)
From: Christoph Fritz <chf.fritz@googlemail.com>
To: Lucas Stach <l.stach@pengutronix.de>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lee Jones <lee.jones@linaro.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, linux-pci@vger.kernel.org
Subject: [PATCH 2/2] PCI: imx6: add initial imx6sx support
Date: Sun, 14 Feb 2016 21:52:44 +0100
Message-Id: <1455483164-13755-3-git-send-email-chf.fritz@googlemail.com>
In-Reply-To: <1455483164-13755-1-git-send-email-chf.fritz@googlemail.com>
References: <1455483164-13755-1-git-send-email-chf.fritz@googlemail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds initial PCIe support for the imx6 SoC derivate imx6sx.
PCI_MSI support is untested as its necessary suspend/resume quirk is left
out of this patch.
This patch is heavily based on patches by Richard Zhu.

Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
---
 drivers/pci/host/pci-imx6.c | 172 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 129 insertions(+), 43 deletions(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index fe60096..73abc3e 100644
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
@@ -35,9 +36,13 @@ struct imx6_pcie {
 	struct gpio_desc	*reset_gpio;
 	struct clk		*pcie_bus;
 	struct clk		*pcie_phy;
+	struct clk		*pcie_inbound_axi;
 	struct clk		*pcie;
 	struct pcie_port	pp;
 	struct regmap		*iomuxc_gpr;
+	struct regmap		*gpc_ips_reg;
+	struct regulator	*pcie_phy_regulator;
+	bool			is_imx6sx;
 	void __iomem		*mem_base;
 };
 
@@ -80,6 +85,9 @@ struct imx6_pcie {
 #define PHY_RX_OVRD_IN_LO_RX_DATA_EN (1 << 5)
 #define PHY_RX_OVRD_IN_LO_RX_PLL_EN (1 << 3)
 
+#define PCIE_PHY_IMX6SX_GPC_CNTR		0x0
+#define PCIE_PHY_IMX6SX_GPC_CNTR_PUP_REQ	BIT(7)
+
 static int pcie_phy_poll_ack(void __iomem *dbi_base, int exp_val)
 {
 	u32 val;
@@ -214,35 +222,46 @@ static int imx6_pcie_assert_core_reset(struct pcie_port *pp)
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
+				IMX6SX_GPR12_PCIE_TEST_POWERDOWN_MASK,
+				IMX6SX_GPR12_PCIE_TEST_POWERDOWN_ENABLE);
+		/* Force PCIe PHY reset */
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR5,
+					IMX6SX_GPR5_PCIE_BTNRST_MASK,
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
@@ -270,18 +289,31 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
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
+			IMX6SX_GPR12_PCIE_TEST_POWERDOWN_MASK,
+			IMX6SX_GPR12_PCIE_TEST_POWERDOWN_DISABLE);
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
@@ -292,8 +324,16 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
 		msleep(100);
 		gpiod_set_value_cansleep(imx6_pcie->reset_gpio, 1);
 	}
+
+	if (imx6_pcie->is_imx6sx)
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR5,
+			IMX6SX_GPR5_PCIE_BTNRST_MASK,
+			IMX6SX_GPR5_PCIE_BTNRST_RELEASE);
+
 	return 0;
 
+err_inbound_axi:
+	clk_disable_unprepare(imx6_pcie->pcie);
 err_pcie:
 	clk_disable_unprepare(imx6_pcie->pcie_bus);
 err_pcie_bus:
@@ -303,9 +343,28 @@ err_pcie_phy:
 
 }
 
-static void imx6_pcie_init_phy(struct pcie_port *pp)
+static int imx6_pcie_init_phy(struct pcie_port *pp)
 {
 	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
+	int ret = 0;
+
+	if (imx6_pcie->is_imx6sx) {
+		/* power up separate domain available on i.mx6sx */
+		regmap_update_bits(imx6_pcie->gpc_ips_reg,
+			PCIE_PHY_IMX6SX_GPC_CNTR,
+			PCIE_PHY_IMX6SX_GPC_CNTR_PUP_REQ,
+			PCIE_PHY_IMX6SX_GPC_CNTR_PUP_REQ);
+		regulator_set_voltage(imx6_pcie->pcie_phy_regulator,
+			1100000, 1100000);
+		ret = regulator_enable(imx6_pcie->pcie_phy_regulator);
+		if (ret) {
+			dev_err(pp->dev, "cannot enable pcie_phy regulator\n");
+			return ret;
+		}
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+			IMX6SX_GPR12_PCIE_RX_EQ_MASK,
+			IMX6SX_GPR12_PCIE_RX_EQ_2);
+	}
 
 	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 			IMX6Q_GPR12_PCIE_CTL_2, 0 << 10);
@@ -326,6 +385,8 @@ static void imx6_pcie_init_phy(struct pcie_port *pp)
 			IMX6Q_GPR8_TX_SWING_FULL, 127 << 18);
 	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
 			IMX6Q_GPR8_TX_SWING_LOW, 127 << 25);
+
+	return ret;
 }
 
 static int imx6_pcie_wait_for_link(struct pcie_port *pp)
@@ -571,6 +632,9 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
 	pp = &imx6_pcie->pp;
 	pp->dev = &pdev->dev;
 
+	imx6_pcie->is_imx6sx = of_device_is_compatible(pp->dev->of_node,
+					"fsl,imx6sx-pcie");
+
 	/* Added for PCI abort handling */
 	hook_fault_code(16 + 6, imx6q_pcie_abort_handler, SIGBUS, 0,
 		"imprecise external abort");
@@ -606,9 +670,30 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
 		return PTR_ERR(imx6_pcie->pcie);
 	}
 
-	/* Grab GPR config register range */
-	imx6_pcie->iomuxc_gpr =
-		 syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
+	if (imx6_pcie->is_imx6sx) {
+		imx6_pcie->pcie_inbound_axi = devm_clk_get(&pdev->dev,
+			"pcie_inbound_axi");
+
+		if (IS_ERR(imx6_pcie->pcie_inbound_axi)) {
+			dev_err(&pdev->dev,
+				"pcie_incbound_axi clock missing or invalid\n");
+			return PTR_ERR(imx6_pcie->pcie_inbound_axi);
+		}
+
+		imx6_pcie->pcie_phy_regulator = devm_regulator_get(pp->dev,
+			"pcie-phy");
+
+		imx6_pcie->iomuxc_gpr =
+			syscon_regmap_lookup_by_compatible
+			("fsl,imx6sx-iomuxc-gpr");
+
+		imx6_pcie->gpc_ips_reg =
+			syscon_regmap_lookup_by_compatible("fsl,imx6sx-gpc");
+	} else {
+		imx6_pcie->iomuxc_gpr =
+			syscon_regmap_lookup_by_compatible
+			("fsl,imx6q-iomuxc-gpr");
+	}
 	if (IS_ERR(imx6_pcie->iomuxc_gpr)) {
 		dev_err(&pdev->dev, "unable to find iomuxc registers\n");
 		return PTR_ERR(imx6_pcie->iomuxc_gpr);
@@ -632,6 +717,7 @@ static void imx6_pcie_shutdown(struct platform_device *pdev)
 
 static const struct of_device_id imx6_pcie_of_match[] = {
 	{ .compatible = "fsl,imx6q-pcie", },
+	{ .compatible = "fsl,imx6sx-pcie", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, imx6_pcie_of_match);
-- 
2.1.4

