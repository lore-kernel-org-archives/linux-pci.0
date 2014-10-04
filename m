Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qa0-f50.google.com ([209.85.216.50]:55449 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750857AbaJDO4P (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 4 Oct 2014 10:56:15 -0400
Received: by mail-qa0-f50.google.com with SMTP id w8so1962000qac.23
        for <linux-pci@vger.kernel.org>; Sat, 04 Oct 2014 07:56:14 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: bhelgaas@google.com
Cc: l.stach@pengutronix.de, Hong-Xing.Zhu@freescale.com,
	linux-pci@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH] PCI: imx6q-pcie doc: Update the clocks descriptions to use defines
Date: Sat,  4 Oct 2014 11:55:48 -0300
Message-Id: <1412434548-11219-1-git-send-email-festevam@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Fabio Estevam <fabio.estevam@freescale.com>

Let's make the imx6q-pcie example to actually match the usage on imx6qdl.dtsi
by providing the clock names via defines rather than hardcoded numbers.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
index 6fbba53..0b28b52 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
@@ -35,6 +35,8 @@ Example:
 		                <0 0 0 2 &intc GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
 		                <0 0 0 3 &intc GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
 		                <0 0 0 4 &intc GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&clks 144>, <&clks 206>, <&clks 189>;
+		clocks = <&clks IMX6QDL_CLK_PCIE_AXI>,
+			 <&clks IMX6QDL_CLK_LVDS1_GATE>,
+			 <&clks IMX6QDL_CLK_PCIE_REF_125M>;
 		clock-names = "pcie", "pcie_bus", "pcie_phy";
 	};
-- 
1.9.1

