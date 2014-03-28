Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59014 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752560AbaC1QxI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 28 Mar 2014 12:53:08 -0400
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
Subject: [PATCH 6/8] PCI: imx6: rip out optional (and unused) irqs
Date: Fri, 28 Mar 2014 17:52:57 +0100
Message-Id: <1396025579-14344-7-git-send-email-l.stach@pengutronix.de>
In-Reply-To: <1396025579-14344-1-git-send-email-l.stach@pengutronix.de>
References: <1396025579-14344-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

They are dropped with the new binding.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/pci/host/pci-imx6.c | 42 ------------------------------------------
 1 file changed, 42 deletions(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 259a73687526..4c20fc4795e5 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -32,9 +32,6 @@
 
 struct imx6_pcie {
 	int			reset_gpio;
-	int			power_on_gpio;
-	int			wake_up_gpio;
-	int			disable_gpio;
 	struct clk		*pcie_bus;
 	struct clk		*pcie_phy;
 	struct clk		*pcie;
@@ -230,9 +227,6 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
 	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
 	int ret;
 
-	if (gpio_is_valid(imx6_pcie->power_on_gpio))
-		gpio_set_value(imx6_pcie->power_on_gpio, 1);
-
 	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
 			IMX6Q_GPR1_PCIE_TEST_PD, 0 << 18);
 	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
@@ -531,42 +525,6 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
 		}
 	}
 
-	imx6_pcie->power_on_gpio = of_get_named_gpio(np, "power-on-gpio", 0);
-	if (gpio_is_valid(imx6_pcie->power_on_gpio)) {
-		ret = devm_gpio_request_one(&pdev->dev,
-					imx6_pcie->power_on_gpio,
-					GPIOF_OUT_INIT_LOW,
-					"PCIe power enable");
-		if (ret) {
-			dev_err(&pdev->dev, "unable to get power-on gpio\n");
-			return ret;
-		}
-	}
-
-	imx6_pcie->wake_up_gpio = of_get_named_gpio(np, "wake-up-gpio", 0);
-	if (gpio_is_valid(imx6_pcie->wake_up_gpio)) {
-		ret = devm_gpio_request_one(&pdev->dev,
-					imx6_pcie->wake_up_gpio,
-					GPIOF_IN,
-					"PCIe wake up");
-		if (ret) {
-			dev_err(&pdev->dev, "unable to get wake-up gpio\n");
-			return ret;
-		}
-	}
-
-	imx6_pcie->disable_gpio = of_get_named_gpio(np, "disable-gpio", 0);
-	if (gpio_is_valid(imx6_pcie->disable_gpio)) {
-		ret = devm_gpio_request_one(&pdev->dev,
-					imx6_pcie->disable_gpio,
-					GPIOF_OUT_INIT_HIGH,
-					"PCIe disable endpoint");
-		if (ret) {
-			dev_err(&pdev->dev, "unable to get disable-ep gpio\n");
-			return ret;
-		}
-	}
-
 	/* Fetch clocks */
 	imx6_pcie->pcie_phy = devm_clk_get(&pdev->dev, "pcie_phy");
 	if (IS_ERR(imx6_pcie->pcie_phy)) {
-- 
1.9.0

