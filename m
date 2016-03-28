Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f53.google.com ([209.85.192.53]:34008 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752441AbcC1AuW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 27 Mar 2016 20:50:22 -0400
From: Fabio Estevam <festevam@gmail.com>
To: bhelgaas@google.com
Cc: l.stach@pengutronix.de, hongxing.zhu@nxp.com, khalasa@piap.pl,
	ynezz@true.cz, linux-pci@vger.kernel.org,
	Fabio Estevam <fabio.estevam@nxp.com>, <stable@vger.kernel.org>
Subject: [PATCH] Revert "PCI: imx6: Add support for active-low reset GPIO"
Date: Sun, 27 Mar 2016 21:49:56 -0300
Message-Id: <1459126196-15063-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Fabio Estevam <fabio.estevam@nxp.com>

Commit 5c5fb40de8f14 ("PCI: imx6: Add support for active-low reset GPIO")
has the following issues:

1. It can break old dtb's that didn't take into account the gpio polarity
specified in the device tree (For example: Gateworks Laguna
imx6qdl-gw54xx.dtsi no longer works after this commit)

2. It sets the gpio polarity in the wrong logic level

So revert the commit to avoid such regressions.

Cc: <stable@vger.kernel.org> # 4.5
Reported-by: Krzysztof Hałasa <khalasa@piap.pl>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/pci/host/pci-imx6.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index eb5a275..2f817fa 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -32,7 +32,7 @@
 #define to_imx6_pcie(x)	container_of(x, struct imx6_pcie, pp)
 
 struct imx6_pcie {
-	struct gpio_desc	*reset_gpio;
+	int			reset_gpio;
 	struct clk		*pcie_bus;
 	struct clk		*pcie_phy;
 	struct clk		*pcie;
@@ -309,10 +309,10 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
 	usleep_range(200, 500);
 
 	/* Some boards don't have PCIe reset GPIO. */
-	if (imx6_pcie->reset_gpio) {
-		gpiod_set_value_cansleep(imx6_pcie->reset_gpio, 0);
+	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
+		gpio_set_value_cansleep(imx6_pcie->reset_gpio, 0);
 		msleep(100);
-		gpiod_set_value_cansleep(imx6_pcie->reset_gpio, 1);
+		gpio_set_value_cansleep(imx6_pcie->reset_gpio, 1);
 	}
 	return 0;
 
@@ -523,6 +523,7 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
 {
 	struct imx6_pcie *imx6_pcie;
 	struct pcie_port *pp;
+	struct device_node *np = pdev->dev.of_node;
 	struct resource *dbi_base;
 	struct device_node *node = pdev->dev.of_node;
 	int ret;
@@ -544,8 +545,15 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
 		return PTR_ERR(pp->dbi_base);
 
 	/* Fetch GPIOs */
-	imx6_pcie->reset_gpio = devm_gpiod_get_optional(&pdev->dev, "reset",
-							GPIOD_OUT_LOW);
+	imx6_pcie->reset_gpio = of_get_named_gpio(np, "reset-gpio", 0);
+	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
+		ret = devm_gpio_request_one(&pdev->dev, imx6_pcie->reset_gpio,
+					    GPIOF_OUT_INIT_LOW, "PCIe reset");
+		if (ret) {
+			dev_err(&pdev->dev, "unable to get reset gpio\n");
+			return ret;
+		}
+	}
 
 	/* Fetch clocks */
 	imx6_pcie->pcie_phy = devm_clk_get(&pdev->dev, "pcie_phy");
-- 
1.9.1

