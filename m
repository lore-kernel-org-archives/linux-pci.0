Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35352 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032776AbbKEO5v (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 5 Nov 2015 09:57:51 -0500
Received: by pasz6 with SMTP id z6so93238649pas.2
        for <linux-pci@vger.kernel.org>; Thu, 05 Nov 2015 06:57:50 -0800 (PST)
From: Tim Harvey <tharvey@gateworks.com>
To: Lucas Stach <l.stach@pengutronix.de>,
	Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH RFC] PCI: imx6: add dt prop for link gen, default to gen1
Date: Thu,  5 Nov 2015 06:58:01 -0800
Message-Id: <1446735481-27326-1-git-send-email-tharvey@gateworks.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Freescale has stated [1] that the LVDS clock source of the IMX6 does not pass
the PCI Gen2 clock jitter test, therefore unless an external Gen2 compliant
external clock source is present and supplied back to the IMX6 PCIe core
via LVDS CLK1/CLK2 you can not claim Gen2 compliance.

Add a dt property to specify gen1 vs gen2 and check this before allowing
a Gen2 link.

We default to Gen1 if the property is not present because at this time there
are no IMX6 boards in mainline that 'input' a clock on LVDS CLK1/CLK2.

In order to be Gen2 compliant on IMX6 you need to:
 - have a Gen2 compliant external clock generator and route that clock back
   to either LVDS CLK1 or LVDS CLK2 as an input.
   (see IMX6SX-SabreSD reference design)
 - specify this clock in the pcie node in the dt
   (ie IMX6QDL_CLK_LVDS1_IN or IMX6QDL_CLK_LVDS2_IN instead of
    IMX6QDL_CLK_LVDS1_GATE which configures it as a CLK output)

[1] https://community.freescale.com/message/453209

Signed-off-by: Tim Harvey <tharvey@gateworks.com>

This is an RFC because I'm assuming the decision to default to Gen1 link only
is going to ruffle some feathers. My understanding is that if you do not
use an external Gen2 compliant clockgen for peripepherals 'and' the IMX6 core
you should not claim Gen2 compliance. This was not obvious on original IMX6
reference designs and I believe the jitter issue was discovered by Freescale
later and future reference designs were modified to state you need an ext
clockgen for Gen2 compliance.

---
 .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |  3 +++
 drivers/pci/host/pci-imx6.c                        | 22 ++++++++++++++++------
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
index 6fbba53..7dff332 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
@@ -12,6 +12,8 @@ Required properties:
 	- "msi": The interrupt that is asserted when an MSI is received
 - clock-names: Must include the following additional entries:
 	- "pcie_phy"
+- fsl,max-link-speed: Specify PCI gen. Defaults to 1, can be 2 if board has
+  an external clock generator fed back to PCIe core.
 
 Example:
 
@@ -37,4 +39,5 @@ Example:
 		                <0 0 0 4 &intc GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clks 144>, <&clks 206>, <&clks 189>;
 		clock-names = "pcie", "pcie_bus", "pcie_phy";
+		fsl,max-link-speed = <2>;
 	};
diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 22e8224..16412c4 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -39,6 +39,7 @@ struct imx6_pcie {
 	struct pcie_port	pp;
 	struct regmap		*iomuxc_gpr;
 	void __iomem		*mem_base;
+	int			link_cap;
 };
 
 /* PCIe Root Complex registers (memory-mapped) */
@@ -393,11 +394,15 @@ static int imx6_pcie_establish_link(struct pcie_port *pp)
 	if (ret)
 		return ret;
 
-	/* Allow Gen2 mode after the link is up. */
-	tmp = readl(pp->dbi_base + PCIE_RC_LCR);
-	tmp &= ~PCIE_RC_LCR_MAX_LINK_SPEEDS_MASK;
-	tmp |= PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN2;
-	writel(tmp, pp->dbi_base + PCIE_RC_LCR);
+	if (imx6_pcie->link_cap == 2) {
+		/* Allow Gen2 mode after the link is up. */
+		tmp = readl(pp->dbi_base + PCIE_RC_LCR);
+		tmp &= ~PCIE_RC_LCR_MAX_LINK_SPEEDS_MASK;
+		tmp |= PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN2;
+		writel(tmp, pp->dbi_base + PCIE_RC_LCR);
+	} else {
+		dev_info(pp->dev, "Link: Gen2 disabled\n");
+	}
 
 	/*
 	 * Start Directed Speed Change so the best possible speed both link
@@ -421,7 +426,7 @@ static int imx6_pcie_establish_link(struct pcie_port *pp)
 	}
 
 	tmp = readl(pp->dbi_base + PCIE_RC_LCSR);
-	dev_dbg(pp->dev, "Link up, Gen=%i\n", (tmp >> 16) & 0xf);
+	dev_info(pp->dev, "Link up, Gen%i\n", (tmp >> 16) & 0xf);
 	return 0;
 }
 
@@ -591,6 +596,11 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
 		}
 	}
 
+	/* default link capability to gen1 */
+	imx6_pcie->link_cap = 1;
+	if (of_property_read_u32(np, "fsl,max-link-speed", &ret) == 0)
+		imx6_pcie->link_cap = ret;
+
 	/* Fetch clocks */
 	imx6_pcie->pcie_phy = devm_clk_get(&pdev->dev, "pcie_phy");
 	if (IS_ERR(imx6_pcie->pcie_phy)) {
-- 
1.9.1

