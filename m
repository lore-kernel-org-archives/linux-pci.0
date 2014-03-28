Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59007 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752450AbaC1QxH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 28 Mar 2014 12:53:07 -0400
From: Lucas Stach <l.stach@pengutronix.de>
To: linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
	Sean Cross <xobs@kosagi.com>, Marek Vasut <marex@denx.de>,
	Richard Zhu <r65037@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Mark Rutland <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Tim Harvey <tharvey@gateworks.com>, kernel@pengutronix.de
Subject: [PATCH 4/8] PCI: imx6: use new clock names
Date: Fri, 28 Mar 2014 17:52:55 +0100
Message-Id: <1396025579-14344-5-git-send-email-l.stach@pengutronix.de>
In-Reply-To: <1396025579-14344-1-git-send-email-l.stach@pengutronix.de>
References: <1396025579-14344-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

As defined in the new binding.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/pci/host/pci-imx6.c | 74 ++++++++++++++++++---------------------------
 1 file changed, 29 insertions(+), 45 deletions(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index ee082509b0ba..71730bbcd9a2 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -35,10 +35,9 @@ struct imx6_pcie {
 	int			power_on_gpio;
 	int			wake_up_gpio;
 	int			disable_gpio;
-	struct clk		*lvds_gate;
-	struct clk		*sata_ref_100m;
-	struct clk		*pcie_ref_125m;
-	struct clk		*pcie_axi;
+	struct clk		*pcie_bus;
+	struct clk		*pcie_phy;
+	struct clk		*pcie;
 	struct pcie_port	pp;
 	struct regmap		*iomuxc_gpr;
 	void __iomem		*mem_base;
@@ -239,28 +238,22 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
 	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
 			IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
 
-	ret = clk_prepare_enable(imx6_pcie->sata_ref_100m);
+	ret = clk_prepare_enable(imx6_pcie->pcie_phy);
 	if (ret) {
-		dev_err(pp->dev, "unable to enable sata_ref_100m\n");
-		goto err_sata_ref;
+		dev_err(pp->dev, "unable to enable pcie_phy clock\n");
+		goto err_pcie_phy;
 	}
 
-	ret = clk_prepare_enable(imx6_pcie->pcie_ref_125m);
+	ret = clk_prepare_enable(imx6_pcie->pcie_bus);
 	if (ret) {
-		dev_err(pp->dev, "unable to enable pcie_ref_125m\n");
-		goto err_pcie_ref;
+		dev_err(pp->dev, "unable to enable pcie_bus clock\n");
+		goto err_pcie_bus;
 	}
 
-	ret = clk_prepare_enable(imx6_pcie->lvds_gate);
+	ret = clk_prepare_enable(imx6_pcie->pcie);
 	if (ret) {
-		dev_err(pp->dev, "unable to enable lvds_gate\n");
-		goto err_lvds_gate;
-	}
-
-	ret = clk_prepare_enable(imx6_pcie->pcie_axi);
-	if (ret) {
-		dev_err(pp->dev, "unable to enable pcie_axi\n");
-		goto err_pcie_axi;
+		dev_err(pp->dev, "unable to enable pcie clock\n");
+		goto err_pcie;
 	}
 
 	/* allow the clocks to stabilize */
@@ -274,13 +267,11 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
 	}
 	return 0;
 
-err_pcie_axi:
-	clk_disable_unprepare(imx6_pcie->lvds_gate);
-err_lvds_gate:
-	clk_disable_unprepare(imx6_pcie->pcie_ref_125m);
-err_pcie_ref:
-	clk_disable_unprepare(imx6_pcie->sata_ref_100m);
-err_sata_ref:
+err_pcie:
+	clk_disable_unprepare(imx6_pcie->pcie_bus);
+err_pcie_bus:
+	clk_disable_unprepare(imx6_pcie->pcie_phy);
+err_pcie_phy:
 	return ret;
 
 }
@@ -583,32 +574,25 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
 	}
 
 	/* Fetch clocks */
-	imx6_pcie->lvds_gate = devm_clk_get(&pdev->dev, "lvds_gate");
-	if (IS_ERR(imx6_pcie->lvds_gate)) {
-		dev_err(&pdev->dev,
-			"lvds_gate clock select missing or invalid\n");
-		return PTR_ERR(imx6_pcie->lvds_gate);
-	}
-
-	imx6_pcie->sata_ref_100m = devm_clk_get(&pdev->dev, "sata_ref_100m");
-	if (IS_ERR(imx6_pcie->sata_ref_100m)) {
+	imx6_pcie->pcie_phy = devm_clk_get(&pdev->dev, "pcie_phy");
+	if (IS_ERR(imx6_pcie->pcie_phy)) {
 		dev_err(&pdev->dev,
-			"sata_ref_100m clock source missing or invalid\n");
-		return PTR_ERR(imx6_pcie->sata_ref_100m);
+			"pcie_phy clock source missing or invalid\n");
+		return PTR_ERR(imx6_pcie->pcie_phy);
 	}
 
-	imx6_pcie->pcie_ref_125m = devm_clk_get(&pdev->dev, "pcie_ref_125m");
-	if (IS_ERR(imx6_pcie->pcie_ref_125m)) {
+	imx6_pcie->pcie_bus = devm_clk_get(&pdev->dev, "pcie_bus");
+	if (IS_ERR(imx6_pcie->pcie_bus)) {
 		dev_err(&pdev->dev,
-			"pcie_ref_125m clock source missing or invalid\n");
-		return PTR_ERR(imx6_pcie->pcie_ref_125m);
+			"pcie_bus clock source missing or invalid\n");
+		return PTR_ERR(imx6_pcie->pcie_bus);
 	}
 
-	imx6_pcie->pcie_axi = devm_clk_get(&pdev->dev, "pcie_axi");
-	if (IS_ERR(imx6_pcie->pcie_axi)) {
+	imx6_pcie->pcie = devm_clk_get(&pdev->dev, "pcie");
+	if (IS_ERR(imx6_pcie->pcie)) {
 		dev_err(&pdev->dev,
-			"pcie_axi clock source missing or invalid\n");
-		return PTR_ERR(imx6_pcie->pcie_axi);
+			"pcie clock source missing or invalid\n");
+		return PTR_ERR(imx6_pcie->pcie);
 	}
 
 	/* Grab GPR config register range */
-- 
1.9.0

