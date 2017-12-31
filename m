Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:56717 "EHLO
        compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750880AbdLaIb7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 31 Dec 2017 03:31:59 -0500
From: Ilya Ledvich <ilya@compulab.co.il>
To: Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ilya Ledvich <ilya@compulab.co.il>
Subject: [PATCH v2] PCI: imx6: Add PHY reference clock source support
Date: Sun, 31 Dec 2017 10:31:34 +0200
Message-Id: <1514709094-4110-1-git-send-email-ilya@compulab.co.il>
In-Reply-To: <AM5PR0402MB28505BE42AB7774EC90927E18C040@AM5PR0402MB2850.eurprd04.prod.outlook.com>
References: <AM5PR0402MB28505BE42AB7774EC90927E18C040@AM5PR0402MB2850.eurprd04.prod.outlook.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

i.MX7D variant of the IP can use either Crystal Oscillator input
or internal clock input as a Reference Clock input for PCIe PHY.
Add support for an optional property 'pcie-phy-refclk-internal'.
If present then an internal clock input is used as PCIe PHY
reference clock source. By default an external oscillator input
is still used.

Verified on Compulab SBC-iMX7 Single Board Computer.

Signed-off-by: Ilya Ledvich <ilya@compulab.co.il>
---
 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt | 5 +++++
 drivers/pci/dwc/pci-imx6.c                               | 8 +++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
index 7b1e48b..581bc09 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
@@ -50,6 +50,11 @@ Additional required properties for imx7d-pcie:
 	       - "pciephy"
 	       - "apps"
 
+Additional optional properties for imx7d-pcie:
+- pcie-phy-refclk-internal: If present then an internal PLL input is used as
+  PCIe PHY reference clock source. By default an external oscillator input
+  is used.
+
 Example:
 
 	pcie@0x01000000 {
diff --git a/drivers/pci/dwc/pci-imx6.c b/drivers/pci/dwc/pci-imx6.c
index b734835..a616192 100644
--- a/drivers/pci/dwc/pci-imx6.c
+++ b/drivers/pci/dwc/pci-imx6.c
@@ -61,6 +61,7 @@ struct imx6_pcie {
 	u32			tx_swing_low;
 	int			link_gen;
 	struct regulator	*vpcie;
+	bool			pciephy_refclk_sel;
 };
 
 /* Parameters for the waiting for PCIe PHY PLL to lock on i.MX7 */
@@ -474,7 +475,9 @@ static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
 	switch (imx6_pcie->variant) {
 	case IMX7D:
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL, 0);
+				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
+				   imx6_pcie->pciephy_refclk_sel ?
+				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL : 0);
 		break;
 	case IMX6SX:
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
@@ -840,6 +843,9 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 		imx6_pcie->vpcie = NULL;
 	}
 
+	imx6_pcie->pciephy_refclk_sel =
+		of_property_read_bool(node, "pcie-phy-refclk-internal");
+
 	platform_set_drvdata(pdev, imx6_pcie);
 
 	ret = imx6_add_pcie_port(imx6_pcie, pdev);
-- 
1.9.1
