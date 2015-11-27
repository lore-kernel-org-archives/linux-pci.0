Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ibawizard.net ([82.208.49.253]:50658 "EHLO
	mengele.ibawizard.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538AbbK0K4m (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 27 Nov 2015 05:56:42 -0500
From: =?UTF-8?q?Petr=20=C5=A0tetiar?= <ynezz@true.cz>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	=?UTF-8?q?Petr=20=C5=A0tetiar?= <ynezz@true.cz>
Subject: [PATCH v3] PCI: imx6: Fix reset-gpio to work with active low GPIO
Date: Fri, 27 Nov 2015 11:56:34 +0100
Message-Id: <1448621794-19916-1-git-send-email-ynezz@true.cz>
In-Reply-To: <1448620464.3689.94.camel@pengutronix.de>
References: <1448620464.3689.94.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

It's currently not possible to use reset-gpio on board where the GPIO is
active low as the code incorrectly assumes, that reset-gpio will be
always active high.

In my case the broken behavior was observed on Toradex Apalis SoM with
Ixora base board.

Signed-off-by: Petr Štetiar <ynezz@true.cz>
---

Changes since v1:                                                                                                                                                        
 * reworked to use descriptor based GPIO interface

Changes since v2:
 * rebased on pci/host-imx6 which now uses gpio_set_value_cansleep()

 drivers/pci/host/pci-imx6.c |   20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 3c3b37f..8e9afa5 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -32,7 +32,7 @@
 #define to_imx6_pcie(x)	container_of(x, struct imx6_pcie, pp)
 
 struct imx6_pcie {
-	int			reset_gpio;
+	struct gpio_desc	*reset_gpio;
 	struct clk		*pcie_bus;
 	struct clk		*pcie_phy;
 	struct clk		*pcie;
@@ -287,10 +287,10 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
 	usleep_range(200, 500);
 
 	/* Some boards don't have PCIe reset GPIO. */
-	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
-		gpio_set_value_cansleep(imx6_pcie->reset_gpio, 0);
+	if (imx6_pcie->reset_gpio) {
+		gpiod_set_value_cansleep(imx6_pcie->reset_gpio, 0);
 		msleep(100);
-		gpio_set_value_cansleep(imx6_pcie->reset_gpio, 1);
+		gpiod_set_value_cansleep(imx6_pcie->reset_gpio, 1);
 	}
 	return 0;
 
@@ -560,7 +560,6 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
 {
 	struct imx6_pcie *imx6_pcie;
 	struct pcie_port *pp;
-	struct device_node *np = pdev->dev.of_node;
 	struct resource *dbi_base;
 	int ret;
 
@@ -581,15 +580,8 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
 		return PTR_ERR(pp->dbi_base);
 
 	/* Fetch GPIOs */
-	imx6_pcie->reset_gpio = of_get_named_gpio(np, "reset-gpio", 0);
-	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
-		ret = devm_gpio_request_one(&pdev->dev, imx6_pcie->reset_gpio,
-					    GPIOF_OUT_INIT_LOW, "PCIe reset");
-		if (ret) {
-			dev_err(&pdev->dev, "unable to get reset gpio\n");
-			return ret;
-		}
-	}
+	imx6_pcie->reset_gpio = devm_gpiod_get_optional(&pdev->dev, "reset",
+							GPIOD_OUT_LOW);
 
 	/* Fetch clocks */
 	imx6_pcie->pcie_phy = devm_clk_get(&pdev->dev, "pcie_phy");
-- 
1.7.9.5

