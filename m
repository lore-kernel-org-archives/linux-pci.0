Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail1.g1.pair.com ([66.39.3.162]:43903 "EHLO mail1.g1.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752281AbaLSISj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 19 Dec 2014 03:18:39 -0500
From: Sean Cross <xobs@kosagi.com>
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawn.guo@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	devicetree@vger.kernel.org, Richard Zhu <r65037@freescale.com>,
	Grant Likely <grant.likely@linaro.org>,
	linux-pci@vger.kernel.org
Cc: bunnie@kosagi.com, Sean Cross <xobs@kosagi.com>
Subject: [PATCH 1/2] PCI: imx6: Add power-supply support
Date: Fri, 19 Dec 2014 16:10:16 +0800
Message-Id: <1418976617-833-2-git-send-email-xobs@kosagi.com>
In-Reply-To: <1418976617-833-1-git-send-email-xobs@kosagi.com>
References: <1418976617-833-1-git-send-email-xobs@kosagi.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Some PCIe ports gate power to the slot.  In order to prevent system lockup,
these boards must enable power to the slot before attempting communication
over the PCI bus.

Signed-off-by: Sean Cross <xobs@kosagi.com>
---
 .../devicetree/bindings/pci/fsl,imx6q-pcie.txt       |  3 +++
 drivers/pci/host/pci-imx6.c                          | 20 +++++++++++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
index 6fbba53..fe912bd 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
@@ -13,6 +13,9 @@ Required properties:
 - clock-names: Must include the following additional entries:
 	- "pcie_phy"
 
+Optional properties:
+- power-supply: A regulator that controls power to the port
+
 Example:
 
 	pcie@0x01000000 {
diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 69202d1..9c2140e 100644
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
@@ -39,6 +40,7 @@ struct imx6_pcie {
 	struct pcie_port	pp;
 	struct regmap		*iomuxc_gpr;
 	void __iomem		*mem_base;
+	struct regulator	*power_reg;
 };
 
 /* PCIe Root Complex registers (memory-mapped) */
@@ -588,6 +590,19 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
 		}
 	}
 
+	/* Fetch power supply */
+	imx6_pcie->power_reg = devm_regulator_get(&pdev->dev, "power");
+	if (IS_ERR(imx6_pcie->power_reg))
+		imx6_pcie->power_reg = 0;
+
+	if (imx6_pcie->power_reg) {
+		ret = regulator_enable(imx6_pcie->power_reg);
+		if (ret) {
+			dev_err(&pdev->dev, "Unable to enable power regulator");
+			return ret;
+		}
+	}
+
 	/* Fetch clocks */
 	imx6_pcie->pcie_phy = devm_clk_get(&pdev->dev, "pcie_phy");
 	if (IS_ERR(imx6_pcie->pcie_phy)) {
@@ -619,8 +634,11 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
 	}
 
 	ret = imx6_add_pcie_port(pp, pdev);
-	if (ret < 0)
+	if (ret < 0) {
+		if (imx6_pcie->power_reg)
+			regulator_disable(imx6_pcie->power_reg);
 		return ret;
+	}
 
 	platform_set_drvdata(pdev, imx6_pcie);
 	return 0;
-- 
2.1.3

