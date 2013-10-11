Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:51686 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752048Ab3JKCMx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Oct 2013 22:12:53 -0400
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
Subject: [PATCH 2/2] PCI: imx6: Fix the clock for PCIe
Date: Fri, 11 Oct 2013 04:12:32 +0200
Message-Id: <1381457552-6575-2-git-send-email-marex@denx.de>
In-Reply-To: <1381457552-6575-1-git-send-email-marex@denx.de>
References: <CAErSpo5e5ZyVqGOHR9p568k7_Qx4tBQCBjQvWvL+xGCqFLHHKQ@mail.gmail.com>
 <1381457552-6575-1-git-send-email-marex@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The clk #205 are lvds_sel, not lvds_gate , so fix this. Moreover,
the PCIe needs lvds_gate for successful operation, so make the PCIe
driver enable (set as output) the lvds_gate .

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
 arch/arm/boot/dts/imx6qdl.dtsi |  6 +++---
 drivers/pci/host/pci-imx6.c    | 19 ++++++++++++++++++-
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 3d8874a..b8601ea 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -127,9 +127,9 @@
 				  0x82000000 0 0x01000000 0x01000000 0 0x00f00000>; /* non-prefetchable memory */
 			num-lanes = <1>;
 			interrupts = <0 123 0x04>;
-			clocks = <&clks 189>, <&clks 187>, <&clks 205>, <&clks 144>;
-			clock-names = "pcie_ref_125m", "sata_ref_100m", "lvds_gate", "pcie_axi";
-			status = "disabled";
+			clocks = <&clks 189>, <&clks 187>, <&clks 205>, <&clks 144>, <&clks 207>;
+			clock-names = "pcie_ref_125m", "sata_ref_100m", "lvds_sel", "pcie_axi", "lvds_gate";
+			status = "okay";
 		};
 
 		pmu {
diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 8e7adce..32b30ca 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -35,6 +35,7 @@ struct imx6_pcie {
 	int			power_on_gpio;
 	int			wake_up_gpio;
 	int			disable_gpio;
+	struct clk		*lvds_sel;
 	struct clk		*lvds_gate;
 	struct clk		*sata_ref_100m;
 	struct clk		*pcie_ref_125m;
@@ -255,6 +256,12 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
 		goto err_pcie_ref;
 	}
 
+	ret = clk_prepare_enable(imx6_pcie->lvds_sel);
+	if (ret) {
+		dev_err(pp->dev, "unable to enable lvds_sel\n");
+		goto err_lvds_sel;
+	}
+
 	ret = clk_prepare_enable(imx6_pcie->lvds_gate);
 	if (ret) {
 		dev_err(pp->dev, "unable to enable lvds_gate\n");
@@ -273,8 +280,10 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
 	return 0;
 
 err_pcie_axi:
-	clk_disable_unprepare(imx6_pcie->lvds_gate);
+	clk_disable_unprepare(imx6_pcie->lvds_sel);
 err_lvds_gate:
+	clk_disable_unprepare(imx6_pcie->lvds_gate);
+err_lvds_sel:
 	clk_disable_unprepare(imx6_pcie->pcie_ref_125m);
 err_pcie_ref:
 	clk_disable_unprepare(imx6_pcie->sata_ref_100m);
@@ -498,6 +507,14 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
 	}
 
 	/* Fetch clocks */
+	imx6_pcie->lvds_sel = devm_clk_get(&pdev->dev, "lvds_sel");
+	if (IS_ERR(imx6_pcie->lvds_sel)) {
+		dev_err(&pdev->dev,
+			"lvds_sel clock select missing or invalid\n");
+		ret = PTR_ERR(imx6_pcie->lvds_sel);
+		goto err;
+	}
+
 	imx6_pcie->lvds_gate = devm_clk_get(&pdev->dev, "lvds_gate");
 	if (IS_ERR(imx6_pcie->lvds_gate)) {
 		dev_err(&pdev->dev,
-- 
1.8.4.rc3

