Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:40353 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759538Ab3JOQHE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Oct 2013 12:07:04 -0400
From: Marek Vasut <marex@denx.de>
To: linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Marek Vasut <marex@denx.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <lznuaa@gmail.com>, Jingoo Han <jg1.han@samsung.com>,
	Mohit KUMAR <Mohit.KUMAR@st.com>,
	Pratyush Anand <pratyush.anand@st.com>,
	Richard Zhu <r65037@freescale.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Sean Cross <xobs@kosagi.com>, Shawn Guo <shawn.guo@linaro.org>,
	Siva Reddy Kallam <siva.kallam@samsung.com>,
	Srikanth T Shivanand <ts.srikanth@samsung.com>,
	Tim Harvey <tharvey@gateworks.com>,
	Troy Kisky <troy.kisky@boundarydevices.com>,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 2/6] PCI: imx6: Fix the clock for PCIe
Date: Tue, 15 Oct 2013 18:06:36 +0200
Message-Id: <1381853200-5534-3-git-send-email-marex@denx.de>
In-Reply-To: <1381853200-5534-1-git-send-email-marex@denx.de>
References: <1381853200-5534-1-git-send-email-marex@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The PCIe needs lvds_gate for successful operation, so make the PCIe
driver enable (set as output) the lvds_gate .

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Frank Li <lznuaa@gmail.com>
Cc: Jingoo Han <jg1.han@samsung.com>
Cc: Mohit KUMAR <Mohit.KUMAR@st.com>
Cc: Pratyush Anand <pratyush.anand@st.com>
Cc: Richard Zhu <r65037@freescale.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Sean Cross <xobs@kosagi.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Siva Reddy Kallam <siva.kallam@samsung.com>
Cc: Srikanth T Shivanand <ts.srikanth@samsung.com>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Troy Kisky <troy.kisky@boundarydevices.com>
Cc: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/host/pci-imx6.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 728989a..94e4d0f 100644
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
@@ -497,6 +506,14 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
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

