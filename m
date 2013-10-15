Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:51877 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759537Ab3JOQHE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Oct 2013 12:07:04 -0400
From: Marek Vasut <marex@denx.de>
To: linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Marek Vasut <marex@denx.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <lznuaa@gmail.com>, Jingoo Han <jg1.han@samsung.com>,
	Mohit KUMAR <Mohit.KUMAR@st.com>,
	Pratyush Anand <pratyush.anand@st.com>,
	Richard Zhu <r65037@freescale.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Sean Cross <xobs@kosagi.com>, Shawn Guo <shawn.guo@linaro.org>,
	Siva Reddy Kallam <siva.kallam@samsung.com>,
	Srikanth T Shivanand <ts.srikanth@samsung.com>,
	Tim Harvey <tharvey@gateworks.com>,
	Troy Kisky <troy.kisky@boundarydevices.com>,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 1/6] PCI: imx6: Make reset-gpio optional
Date: Tue, 15 Oct 2013 18:06:35 +0200
Message-Id: <1381853200-5534-2-git-send-email-marex@denx.de>
In-Reply-To: <1381853200-5534-1-git-send-email-marex@denx.de>
References: <1381853200-5534-1-git-send-email-marex@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Some boards do not have a PCIe reset GPIO. To avoid probe
failure on these boards, make the reset GPIO optional as
well.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Frank Li <lznuaa@gmail.com>
Cc: Jingoo Han <jg1.han@samsung.com>
Cc: Mohit KUMAR <Mohit.KUMAR@st.com>
Cc: Pratyush Anand <pratyush.anand@st.com>
Cc: Richard Zhu <r65037@freescale.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Sean Cross <xobs@kosagi.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Siva Reddy Kallam <siva.kallam@samsung.com>
Cc: Srikanth T Shivanand <ts.srikanth@samsung.com>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Troy Kisky <troy.kisky@boundarydevices.com>
Cc: Yinghai Lu <yinghai@kernel.org>
---
 .../devicetree/bindings/pci/designware-pcie.txt    |  2 +-
 drivers/pci/host/pci-imx6.c                        | 29 +++++++++++-----------
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
index d5d26d4..b7a2279 100644
--- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
@@ -19,9 +19,9 @@ Required properties:
 	to define the mapping of the PCIe interface to interrupt
 	numbers.
 - num-lanes: number of lanes to use
-- reset-gpio: gpio pin number of power good signal
 
 Optional properties for fsl,imx6q-pcie
+- reset-gpio: gpio pin number of power good signal
 - power-on-gpio: gpio pin number of power-enable signal
 - wake-up-gpio: gpio pin number of incoming wakeup signal
 - disable-gpio: gpio pin number of outgoing rfkill/endpoint disable signal
diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 5afa922..728989a 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -220,9 +220,12 @@ static int imx6_pcie_assert_core_reset(struct pcie_port *pp)
 	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
 			IMX6Q_GPR1_PCIE_REF_CLK_EN, 0 << 16);
 
-	gpio_set_value(imx6_pcie->reset_gpio, 0);
-	msleep(100);
-	gpio_set_value(imx6_pcie->reset_gpio, 1);
+	/* Some boards don't have PCIe reset GPIO. */
+	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
+		gpio_set_value(imx6_pcie->reset_gpio, 0);
+		msleep(100);
+		gpio_set_value(imx6_pcie->reset_gpio, 1);
+	}
 
 	return 0;
 }
@@ -446,17 +449,15 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
 
 	/* Fetch GPIOs */
 	imx6_pcie->reset_gpio = of_get_named_gpio(np, "reset-gpio", 0);
-	if (!gpio_is_valid(imx6_pcie->reset_gpio)) {
-		dev_err(&pdev->dev, "no reset-gpio defined\n");
-		ret = -ENODEV;
-	}
-	ret = devm_gpio_request_one(&pdev->dev,
-				imx6_pcie->reset_gpio,
-				GPIOF_OUT_INIT_LOW,
-				"PCIe reset");
-	if (ret) {
-		dev_err(&pdev->dev, "unable to get reset gpio\n");
-		goto err;
+	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
+		ret = devm_gpio_request_one(&pdev->dev,
+					imx6_pcie->reset_gpio,
+					GPIOF_OUT_INIT_LOW,
+					"PCIe reset");
+		if (ret) {
+			dev_err(&pdev->dev, "unable to get reset gpio\n");
+			goto err;
+		}
 	}
 
 	imx6_pcie->power_on_gpio = of_get_named_gpio(np, "power-on-gpio", 0);
-- 
1.8.4.rc3

