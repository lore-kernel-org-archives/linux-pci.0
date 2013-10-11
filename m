Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:58168 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752048Ab3JKCMv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Oct 2013 22:12:51 -0400
From: Marek Vasut <marex@denx.de>
To: linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Marek Vasut <marex@denx.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <lznuaa@gmail.com>,
	Richard Zhu <r65037@freescale.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Sean Cross <xobs@kosagi.com>, Shawn Guo <shawn.guo@linaro.org>,
	Tim Harvey <tharvey@gateworks.com>,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 1/2] PCI: imx6: Make reset-gpio optional
Date: Fri, 11 Oct 2013 04:12:31 +0200
Message-Id: <1381457552-6575-1-git-send-email-marex@denx.de>
In-Reply-To: <CAErSpo5e5ZyVqGOHR9p568k7_Qx4tBQCBjQvWvL+xGCqFLHHKQ@mail.gmail.com>
References: <CAErSpo5e5ZyVqGOHR9p568k7_Qx4tBQCBjQvWvL+xGCqFLHHKQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Some boards do not have a PCIe reset GPIO. To avoid probe
failure on these boards, make the reset GPIO optional as
well.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Frank Li <lznuaa@gmail.com>
Cc: Richard Zhu <r65037@freescale.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Sean Cross <xobs@kosagi.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/host/pci-imx6.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index d3639aa..8e7adce 100644
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
@@ -447,17 +450,15 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
 
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

