Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:35388 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752250AbcDARO3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 1 Apr 2016 13:14:29 -0400
Received: by mail-pf0-f175.google.com with SMTP id n5so95549709pfn.2
        for <linux-pci@vger.kernel.org>; Fri, 01 Apr 2016 10:14:29 -0700 (PDT)
From: Tim Harvey <tharvey@gateworks.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>,
	Fabio Estevam <fabio.estevam@freescale.com>,
	Zhu Richard <Richard.Zhu@freescale.com>,
	Akshay Bhat <akshay.bhat@timesys.com>,
	Rob Herring <robh+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v3] PCI: imx6: add dt prop for link gen, default to gen1
Date: Fri,  1 Apr 2016 10:17:09 -0700
Message-Id: <1459531029-16208-1-git-send-email-tharvey@gateworks.com>
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

Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Zhu Richard <Richard.Zhu@freescale.com>
Cc: Akshay Bhat <akshay.bhat@timesys.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
v3:
 - added note in dt bindings doc that we limit to gen1 unless this is specified
   as gen2 capable
 - move property to imx6 pcie phy instead of designware core
 - don't use &ret as temp storage as of_property_read_u32() doesn't change the
   outval if property isn't found
v2:
 - moved dt property to designware core

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |  6 ++++++
 drivers/pci/host/pci-imx6.c                        | 23 ++++++++++++++++------
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
index 6fbba53..4ffaf19 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
@@ -13,6 +13,12 @@ Required properties:
 - clock-names: Must include the following additional entries:
 	- "pcie_phy"
 
+Optional properties:
+- max-link-speed: Specify PCI gen for link capability. Must be '2' for
+  gen2, otherwise will default to gen1. Note that the IMX6 LVDS clock outputs
+  do not meet gen2 jitter requirements and thus for gen2 capability a gen2
+  compliant clock generator should be used and configured.
+
 Example:
 
 	pcie@0x01000000 {
diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 88ccfea..d1bfcff 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -39,6 +39,7 @@ struct imx6_pcie {
 	struct pcie_port	pp;
 	struct regmap		*iomuxc_gpr;
 	void __iomem		*mem_base;
+	int			link_gen;
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
+	if (imx6_pcie->link_gen == 2) {
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
 
@@ -622,6 +627,12 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
 		return PTR_ERR(imx6_pcie->iomuxc_gpr);
 	}
 
+	/* Limit link speed */
+	ret = of_property_read_u32(pp->dev->of_node, "max-link-speed",
+				   &imx6_pcie->link_gen);
+	if (ret)
+		imx6_pcie->link_gen = -1;
+
 	ret = imx6_add_pcie_port(pp, pdev);
 	if (ret < 0)
 		return ret;
-- 
1.9.1

