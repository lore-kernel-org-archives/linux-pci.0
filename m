Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ibawizard.net ([82.208.49.253]:49261 "EHLO
	mengele.ibawizard.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755246AbcDFMg5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 Apr 2016 08:36:57 -0400
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
Subject: [PATCH v3 2/2] PCI: imx6: Add reset-gpio-active-high boolean property to DT
Date: Wed,  6 Apr 2016 14:36:47 +0200
Message-Id: <1459946207-11923-1-git-send-email-ynezz@true.cz>
In-Reply-To: <1459936100.2256.30.camel@pengutronix.de>
References: <1459936100.2256.30.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Currently the reset-gpio DT property which controls the PCI bus device
reset signal defaults to active-low reset sequence (L=reset state,
H=operation state) plus the code in reset function isn't GPIO polarity
aware - it doesn't matter if the defined reset-gpio is active-low or
active-high, it will always result into active-low reset sequence.

I've tried to fix it properly and changed the reset-gpio reset sequence
to be polarity aware, but this patch has been accepted and then reverted
as it has introduced few backward incompatible issues:

1. Some of the DTBs as for example imx6qdl-sabresd, doesn't define
reset-gpio polarity correctly:

  reset-gpio = <&gpio7 12 0>;

which means, that it's defined as active-high, but in reality it's
active-low, thus it wouldn't work without DTS fix.

2. The logic in reset function is inverted:

	gpio_set_value_cansleep(imx6_pcie->reset_gpio, 0)
	msleep(100);
	gpio_set_value_cansleep(imx6_pcie->reset_gpio, 1);

so even if some of the i.MX6 boards had reset-gpio polarity defined
correctly in their DTSes, they would stop working.

As we can't break old DTBs, we can't fix them and that's why we need to
introduce this new DT reset-gpio-active-high boolean property, so we can
support boards with active-high reset sequence.

This active-high reset sequence is for example needed on Apalis SoMs,
where GPIO1_IO28, used to PCIe reset is not connected directly to PERST#
PCIe signal, but it's ORed with RESETBMCU coming off the PMIC, and thus
is inverted, active-high.

Signed-off-by: Petr Štetiar <ynezz@true.cz>
---
 Changes since v1:

  * Added documentation of reset-gpio and reset-gpio-active-high DT properties
  * Removed unnecessary double negation of GPIO value

 Changes since v2:

  * Changed commit message so it explains in more detail why we need new DT
    property
  * Changed PHY to 'bus device' in binding's documentation

 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt |  6 ++++++
 drivers/pci/host/pci-imx6.c                              | 14 +++++++++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
index 3be80c6..072efbf 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
@@ -19,6 +19,12 @@ Optional properties:
 - fsl,tx-deemph-gen2-6db: Gen2 (6db) De-emphasis value. Default: 20
 - fsl,tx-swing-full: Gen2 TX SWING FULL value. Default: 127
 - fsl,tx-swing-low: TX launch amplitude swing_low value. Default: 127
+- reset-gpio: Should specify the GPIO for controlling the PCI bus device reset
+  signal. Its not polarity aware and defaults to active-low reset sequence
+  (L=reset state, H=operation state).
+- reset-gpio-active-high: If present then the reset sequence using the GPIO
+  specified in the "reset-gpio" property is reversed (H=reset state,
+  L=operation state).
 
 Example:
 
diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 2f817fa..17f4cc3 100644
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
+					imx6_pcie->gpio_active_high);
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

