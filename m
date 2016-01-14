Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34001 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752221AbcANU2C (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jan 2016 15:28:02 -0500
Received: by mail-pa0-f49.google.com with SMTP id uo6so366812533pac.1
        for <linux-pci@vger.kernel.org>; Thu, 14 Jan 2016 12:28:02 -0800 (PST)
From: Justin Waters <justin.waters@timesys.com>
To: linux-pci@vger.kernel.org
Cc: festevam@gmail.com, l.stach@pengutronix.de,
	Justin Waters <justin.waters@timesys.com>
Subject: [PATCH] PCI: imx6: Add DT bindings to configure Tx Driver settings
Date: Thu, 14 Jan 2016 15:27:49 -0500
Message-Id: <1452803269-18412-1-git-send-email-justin.waters@timesys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The settings in GPR8 are dependent upon the particular layout of the
hardware platform. As such, they should be configurable via the device
tree.

As many boards have been using the default values, this implementation
uses the old values if they are not specified in the device tree.

Signed-off-by: Justin Waters <justin.waters@timesys.com>
---
 .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     | 13 +++++++
 drivers/pci/host/pci-imx6.c                        | 43 +++++++++++++++++++---
 2 files changed, 51 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
index 6fbba53..3aa462d 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
@@ -13,6 +13,17 @@ Required properties:
 - clock-names: Must include the following additional entries:
 	- "pcie_phy"
 
+Optional properties:
+- fsl,tx-deemph-gen1: Sets GPR8 value for Tx driver de-emphasis when PHY is
+  running at Gen1 rates.
+- fsl,tx-deemph-gen2-3p5db: Sets GPR8 value for Tx driver de-emphasis when
+  PHY is running at Gen2 (3.5db) rate.
+- fsl,tx-demmph-gen2-6db: Sets GPR8 value for Tx driver de-emphasis when
+  PHY is running at Gen2 (3.5db) rate.
+- fsl,tx-swing-full: Sets GPR8 value for Tx driver SWING_FULL.
+- fsl,tx-swing-low: Sets GPR8 value for launch amplitude of transmitter when
+  pipe0_tx_swing is set to 0.
+
 Example:
 
 	pcie@0x01000000 {
@@ -37,4 +48,6 @@ Example:
 		                <0 0 0 4 &intc GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clks 144>, <&clks 206>, <&clks 189>;
 		clock-names = "pcie", "pcie_bus", "pcie_phy";
+		fsl,tx-swing-full = <103>;
+		fsl,tx-swing-low = <103>;
 	};
diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 230ebf9..10036e4 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -39,6 +39,11 @@ struct imx6_pcie {
 	struct pcie_port	pp;
 	struct regmap		*iomuxc_gpr;
 	void __iomem		*mem_base;
+	u32			tx_deemph_gen1;
+	u32			tx_deemph_gen2_3p5db;
+	u32			tx_deemph_gen2_6db;
+	u32			tx_swing_full;
+	u32			tx_swing_low;
 };
 
 /* PCIe Root Complex registers (memory-mapped) */
@@ -317,15 +322,20 @@ static void imx6_pcie_init_phy(struct pcie_port *pp)
 			IMX6Q_GPR12_LOS_LEVEL, 9 << 4);
 
 	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
-			IMX6Q_GPR8_TX_DEEMPH_GEN1, 0 << 0);
+			   IMX6Q_GPR8_TX_DEEMPH_GEN1,
+			   imx6_pcie->tx_deemph_gen1 << 0);
 	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
-			IMX6Q_GPR8_TX_DEEMPH_GEN2_3P5DB, 0 << 6);
+			   IMX6Q_GPR8_TX_DEEMPH_GEN2_3P5DB,
+			   imx6_pcie->tx_deemph_gen2_3p5db << 6);
 	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
-			IMX6Q_GPR8_TX_DEEMPH_GEN2_6DB, 20 << 12);
+			   IMX6Q_GPR8_TX_DEEMPH_GEN2_6DB,
+			   imx6_pcie->tx_deemph_gen2_6db << 12);
 	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
-			IMX6Q_GPR8_TX_SWING_FULL, 127 << 18);
+			   IMX6Q_GPR8_TX_SWING_FULL,
+			   imx6_pcie->tx_swing_full << 18);
 	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
-			IMX6Q_GPR8_TX_SWING_LOW, 127 << 25);
+			   IMX6Q_GPR8_TX_SWING_LOW,
+			   imx6_pcie->tx_swing_low << 25);
 }
 
 static int imx6_pcie_wait_for_link(struct pcie_port *pp)
@@ -565,6 +575,7 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
 	struct imx6_pcie *imx6_pcie;
 	struct pcie_port *pp;
 	struct resource *dbi_base;
+	struct device_node *node = pdev->dev.of_node;
 	int ret;
 
 	imx6_pcie = devm_kzalloc(&pdev->dev, sizeof(*imx6_pcie), GFP_KERNEL);
@@ -617,6 +628,28 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
 		return PTR_ERR(imx6_pcie->iomuxc_gpr);
 	}
 
+	/* Grab PCIe PHY Tx Settings */
+	if (of_property_read_u32
+	    (node, "fsl,tx-deemph-gen1", &imx6_pcie->tx_deemph_gen1))
+		imx6_pcie->tx_deemph_gen1 = 0;
+
+	if (of_property_read_u32
+	    (node, "fsl,tx-deemph-gen2-3p5db",
+	     &imx6_pcie->tx_deemph_gen2_3p5db))
+		imx6_pcie->tx_deemph_gen2_3p5db = 0;
+
+	if (of_property_read_u32
+	    (node, "fsl,tx-deemph-gen2-6db", &imx6_pcie->tx_deemph_gen2_6db))
+		imx6_pcie->tx_deemph_gen2_6db = 20;
+
+	if (of_property_read_u32
+	    (node, "fsl,tx-swing-full", &imx6_pcie->tx_swing_full))
+		imx6_pcie->tx_swing_full = 127;
+
+	if (of_property_read_u32
+	    (node, "fsl,tx-swing-low", &imx6_pcie->tx_swing_low))
+		imx6_pcie->tx_swing_low = 127;
+
 	ret = imx6_add_pcie_port(pp, pdev);
 	if (ret < 0)
 		return ret;
-- 
2.5.0

