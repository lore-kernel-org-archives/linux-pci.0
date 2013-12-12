Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:35521 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751579Ab3LLVu2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 12 Dec 2013 16:50:28 -0500
From: Marek Vasut <marex@denx.de>
To: linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Marek Vasut <marex@denx.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <lznuaa@gmail.com>, Harro Haan <hrhaan@gmail.com>,
	Jingoo Han <jg1.han@samsung.com>,
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
Subject: [PATCH V2 1/7] PCI: imx6: Make reset-gpio optional
Date: Thu, 12 Dec 2013 22:49:58 +0100
Message-Id: <1386885004-10252-1-git-send-email-marex@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Some boards do not have a PCIe reset GPIO. To avoid probe
failure on these boards, make the reset GPIO optional as
well.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Frank Li <lznuaa@gmail.com>
Cc: Harro Haan <hrhaan@gmail.com>
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
 .../devicetree/bindings/pci/designware-pcie.txt    |  2 ++
 drivers/pci/host/pci-imx6.c                        | 29 +++++++++++-----------
 2 files changed, 17 insertions(+), 14 deletions(-)

V2: Make the 'reset-gpio' prop shared between imx6 and exynos
    Rebase on top of pci/host-imx6

diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
index d5d26d4..d6fae13 100644
--- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
@@ -19,6 +19,8 @@ Required properties:
 	to define the mapping of the PCIe interface to interrupt
 	numbers.
 - num-lanes: number of lanes to use
+
+Optional properties:
 - reset-gpio: gpio pin number of power good signal
 
 Optional properties for fsl,imx6q-pcie
diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 9fc1cb6..c247602 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -214,9 +214,12 @@ static int imx6_pcie_assert_core_reset(struct pcie_port *pp)
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
@@ -432,17 +435,15 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
 
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
-		return ret;
+	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
+		ret = devm_gpio_request_one(&pdev->dev,
+					imx6_pcie->reset_gpio,
+					GPIOF_OUT_INIT_LOW,
+					"PCIe reset");
+		if (ret) {
+			dev_err(&pdev->dev, "unable to get reset gpio\n");
+			return ret;
+		}
 	}
 
 	imx6_pcie->power_on_gpio = of_get_named_gpio(np, "power-on-gpio", 0);
-- 
1.8.4.3

