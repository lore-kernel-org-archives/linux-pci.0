Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:36642 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475AbcFHAIL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 7 Jun 2016 20:08:11 -0400
Received: by mail-yw0-f196.google.com with SMTP id l126so24887974ywe.3
        for <linux-pci@vger.kernel.org>; Tue, 07 Jun 2016 17:08:10 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: bhelgaas@google.com
Cc: l.stach@pengutronix.de, hongxing.zhu@nxp.com,
	chf.fritz@googlemail.com, shawnguo@kernel.org,
	linux-pci@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH] PCI: imx6: Add support for MX6SX LDO PCIE domain regulator
Date: Tue,  7 Jun 2016 21:07:52 -0300
Message-Id: <1465344472-15703-1-git-send-email-festevam@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Fabio Estevam <fabio.estevam@nxp.com>

MX6SX has an internal LDO regulator for the PCIE domain, which needs
to be turned on for PCIE functionality.

Add support for it.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |  2 ++
 drivers/pci/host/pci-imx6.c                        | 29 +++++++++++++++++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
index f3d26f47..cfb0e86 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
@@ -33,6 +33,8 @@ Optional properties:
 Additional required properties for imx6sx-pcie:
 - clock names: Must include the following additional entry:
 	- "pcie_inbound_axi"
+- pcie-phy-supply: Must point to the internal PCIE power domain regulator:
+		   <&reg_pcie>;
 
 Example:
 
diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index b741a36..ad9cc8b 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -27,6 +27,7 @@
 #include <linux/signal.h>
 #include <linux/types.h>
 #include <linux/interrupt.h>
+#include <linux/regulator/consumer.h>
 
 #include "pcie-designware.h"
 
@@ -55,6 +56,7 @@ struct imx6_pcie {
 	u32			tx_swing_full;
 	u32			tx_swing_low;
 	int			link_gen;
+	struct regulator	*phy_regulator;
 };
 
 /* PCIe Root Complex registers (memory-mapped) */
@@ -96,6 +98,8 @@ struct imx6_pcie {
 #define PHY_RX_OVRD_IN_LO_RX_DATA_EN (1 << 5)
 #define PHY_RX_OVRD_IN_LO_RX_PLL_EN (1 << 3)
 
+#define MX6SX_PCIE_LDO				1100000
+
 static int pcie_phy_poll_ack(void __iomem *dbi_base, int exp_val)
 {
 	u32 val;
@@ -407,11 +411,26 @@ err_pcie_phy:
 static void imx6_pcie_init_phy(struct pcie_port *pp)
 {
 	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
+	int ret;
+
+	if (imx6_pcie->variant == IMX6SX) {
+		ret = regulator_set_voltage(imx6_pcie->phy_regulator,
+					    MX6SX_PCIE_LDO, MX6SX_PCIE_LDO);
+		if (ret) {
+			dev_err(pp->dev, "failed to set pcie phy voltage.\n");
+			return ret;
+		}
+
+		ret = regulator_enable(imx6_pcie->phy_regulator);
+		if (ret) {
+			dev_err(pp->dev, "failed to enable pcie regulator.\n");
+			return;
+		}
 
-	if (imx6_pcie->variant == IMX6SX)
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				   IMX6SX_GPR12_PCIE_RX_EQ_MASK,
 				   IMX6SX_GPR12_PCIE_RX_EQ_2);
+	}
 
 	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 			IMX6Q_GPR12_PCIE_CTL_2, 0 << 10);
@@ -680,6 +699,14 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
 				"pcie_incbound_axi clock missing or invalid\n");
 			return PTR_ERR(imx6_pcie->pcie_inbound_axi);
 		}
+
+		imx6_pcie->phy_regulator = devm_regulator_get(pp->dev,
+							      "pcie-phy");
+		if (IS_ERR(imx6_pcie->phy_regulator)) {
+			dev_err(&pdev->dev,
+				"failed to get pcie-phy regulator\n");
+			return PTR_ERR(imx6_pcie->phy_regulator);
+		}
 	}
 
 	/* Grab GPR config register range */
-- 
1.9.1

