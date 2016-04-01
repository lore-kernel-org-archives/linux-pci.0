Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ibawizard.net ([82.208.49.253]:56486 "EHLO
	mengele.ibawizard.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753305AbcDAMux (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 1 Apr 2016 08:50:53 -0400
From: =?UTF-8?q?Petr=20=C5=A0tetiar?= <ynezz@true.cz>
To: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	Russell King <linux@arm.linux.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Mark Rutland <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Sascha Hauer <kernel@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Tim Harvey <tharvey@gateworks.com>,
	=?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>,
	Fabio Estevam <festevam@gmail.com>,
	Marcel Ziswiler <marcel.ziswiler@toradex.com>, stefan@agner.ch,
	=?UTF-8?q?Petr=20=C5=A0tetiar?= <ynezz@true.cz>
Subject: [PATCH 2/2] PCI: imx6: Add reset-gpio-active-high boolean property to DT
Date: Fri,  1 Apr 2016 14:41:48 +0200
Message-Id: <1459514508-8557-3-git-send-email-ynezz@true.cz>
In-Reply-To: <1459514508-8557-1-git-send-email-ynezz@true.cz>
References: <1459514508-8557-1-git-send-email-ynezz@true.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We need that property in order to make the Toradex Apalis SoMs working
without breaking old DTBs. On Apalis SoMs the GPIO1_IO28 used to PCIe
reset is not connected directly to PERST# PCIe signal, but it's ORed
with RESETBMCU coming off the PMIC, and thus is inverted, active-high.

Signed-off-by: Petr Štetiar <ynezz@true.cz>
---
 drivers/pci/host/pci-imx6.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 2f817fa..1b3bcfe 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -33,6 +33,7 @@
 
 struct imx6_pcie {
 	int			reset_gpio;
+	bool			gpio_active_high;
 	struct clk		*pcie_bus;
 	struct clk		*pcie_phy;
 	struct clk		*pcie;
@@ -310,9 +311,11 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
 
 	/* Some boards don't have PCIe reset GPIO. */
 	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
-		gpio_set_value_cansleep(imx6_pcie->reset_gpio, 0);
+		gpio_set_value_cansleep(imx6_pcie->reset_gpio,
+					!!imx6_pcie->gpio_active_high);
 		msleep(100);
-		gpio_set_value_cansleep(imx6_pcie->reset_gpio, 1);
+		gpio_set_value_cansleep(imx6_pcie->reset_gpio,
+					!imx6_pcie->gpio_active_high);
 	}
 	return 0;
 
@@ -546,9 +549,14 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
 
 	/* Fetch GPIOs */
 	imx6_pcie->reset_gpio = of_get_named_gpio(np, "reset-gpio", 0);
+	imx6_pcie->gpio_active_high = of_property_read_bool(np,
+						"reset-gpio-active-high");
 	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
 		ret = devm_gpio_request_one(&pdev->dev, imx6_pcie->reset_gpio,
-					    GPIOF_OUT_INIT_LOW, "PCIe reset");
+				imx6_pcie->gpio_active_high ?
+					GPIOF_OUT_INIT_HIGH :
+					GPIOF_OUT_INIT_LOW,
+				"PCIe reset");
 		if (ret) {
 			dev_err(&pdev->dev, "unable to get reset gpio\n");
 			return ret;
-- 
1.9.1

