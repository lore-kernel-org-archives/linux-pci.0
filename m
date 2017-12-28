Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-eopbgr00070.outbound.protection.outlook.com ([40.107.0.70]:22752
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752763AbdL1KF6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Dec 2017 05:05:58 -0500
From: Richard Zhu <hongxing.zhu@nxp.com>
To: Ilya Ledvich <ilya@compulab.co.il>,
        Lucas Stach <l.stach@pengutronix.de>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] PCI: imx6: Add PHY reference clock source support
Date: Thu, 28 Dec 2017 10:05:55 +0000
Message-ID: <AM5PR0402MB28505BE42AB7774EC90927E18C040@AM5PR0402MB2850.eurprd04.prod.outlook.com>
References: <1514369154-21105-1-git-send-email-ilya@compulab.co.il>
In-Reply-To: <1514369154-21105-1-git-send-email-ilya@compulab.co.il>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Ilya:
I think the "ocsillator" in the binding document should be oscillator.
Thanks.

Best Regards
Richard

Best Regards
hongxing zhu
Linux BSP team
Office: 86-21-28937189
Email: hongxing.zhu@nxp.com


-----Original Message-----
From: Ilya Ledvich [mailto:ilya@compulab.co.il]=20
Sent: Wednesday, December 27, 2017 6:06 PM
To: Richard Zhu <hongxing.zhu@nxp.com>; Lucas Stach <l.stach@pengutronix.de=
>
Cc: Bjorn Helgaas <bhelgaas@google.com>; linux-pci@vger.kernel.org; linux-a=
rm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Ilya Ledvich <=
ilya@compulab.co.il>
Subject: [PATCH] PCI: imx6: Add PHY reference clock source support

i.MX7D variant of the IP can use either Crystal Oscillator input or interna=
l clock input as a Reference Clock input for PCIe PHY.
Add support for an optional property 'pcie-phy-refclk-internal'.
If present then an internal clock input is used as PCIe PHY reference clock=
 source. By default an external oscillator input is still used.

Verified on Compulab SBC-iMX7 Single Board Computer.

Signed-off-by: Ilya Ledvich <ilya@compulab.co.il>
---
 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt | 5 +++++
 drivers/pci/dwc/pci-imx6.c                               | 8 +++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Doc=
umentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
index 7b1e48b..f9cf11e 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
@@ -50,6 +50,11 @@ Additional required properties for imx7d-pcie:
 	       - "pciephy"
 	       - "apps"
=20
+Additional optional properties for imx7d-pcie:
+- pcie-phy-refclk-internal: If present then an internal PLL input is=20
+used as
+  PCIe PHY reference clock source. By default an external ocsillator=20
+input
+  is used.
+
 Example:
=20
 	pcie@0x01000000 {
diff --git a/drivers/pci/dwc/pci-imx6.c b/drivers/pci/dwc/pci-imx6.c index =
b734835..a616192 100644
--- a/drivers/pci/dwc/pci-imx6.c
+++ b/drivers/pci/dwc/pci-imx6.c
@@ -61,6 +61,7 @@ struct imx6_pcie {
 	u32			tx_swing_low;
 	int			link_gen;
 	struct regulator	*vpcie;
+	bool			pciephy_refclk_sel;
 };
=20
 /* Parameters for the waiting for PCIe PHY PLL to lock on i.MX7 */ @@ -474=
,7 +475,9 @@ static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
 	switch (imx6_pcie->variant) {
 	case IMX7D:
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL, 0);
+				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
+				   imx6_pcie->pciephy_refclk_sel ?
+				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL : 0);
 		break;
 	case IMX6SX:
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12, @@ -840,6 +843,9=
 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 		imx6_pcie->vpcie =3D NULL;
 	}
=20
+	imx6_pcie->pciephy_refclk_sel =3D
+		of_property_read_bool(node, "pcie-phy-refclk-internal");
+
 	platform_set_drvdata(pdev, imx6_pcie);
=20
 	ret =3D imx6_add_pcie_port(imx6_pcie, pdev);
--
1.9.1
