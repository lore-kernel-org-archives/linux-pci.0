Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-eopbgr60043.outbound.protection.outlook.com ([40.107.6.43]:35184
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730635AbeHNTjN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Aug 2018 15:39:13 -0400
From: Leonard Crestez <leonard.crestez@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        linux-pci@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v4 6/6] PCI: imx: Add PME_Turn_Off support
Date: Tue, 14 Aug 2018 19:50:20 +0300
Message-Id: <7079253f4622c78a6c8a911dda1df60a3198a9a9.1534264292.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1534264292.git.leonard.crestez@nxp.com>
References: <cover.1534264292.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When the root complex suspends it must send a PME_Turn_Off TLP.
Implement this by asserting the "turnoff" reset.

On imx7d this is functionality is part of the SRC and exposed through
the linux reset-controller subsystem. On imx6 equivalent bits are in the
IOMUXC GPR area which the imx6-pcie driver accesses directly.

This is only for imx7d right now but it's deliberately implemented as an
optional reset, ignoring the chip variant:
* Older dtbs won't have this reset so it will be ignored.
* Future chips might also expose this as a reset controller.

For example imx8m (not yet supported) has the exact same
PCIE_CTRL_APPS_TURNOFF bit in the same location.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 926858701726..eeba64392dba 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -50,10 +50,11 @@ struct imx6_pcie {
 	struct clk		*pcie_inbound_axi;
 	struct clk		*pcie;
 	struct regmap		*iomuxc_gpr;
 	struct reset_control	*pciephy_reset;
 	struct reset_control	*apps_reset;
+	struct reset_control	*turnoff_reset;
 	enum imx6_pcie_variants variant;
 	u32			tx_deemph_gen1;
 	u32			tx_deemph_gen2_3p5db;
 	u32			tx_deemph_gen2_6db;
 	u32			tx_swing_full;
@@ -757,10 +758,16 @@ static void imx6_pcie_ltssm_disable(struct device *dev)
 	default:
 		dev_err(dev, "ltssm_disable not supported\n");
 	}
 }
 
+static void imx6_pcie_pm_turnoff(struct imx6_pcie *imx6_pcie)
+{
+	reset_control_assert(imx6_pcie->turnoff_reset);
+	reset_control_deassert(imx6_pcie->turnoff_reset);
+}
+
 static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
 {
 	clk_disable_unprepare(imx6_pcie->pcie);
 	clk_disable_unprepare(imx6_pcie->pcie_phy);
 	clk_disable_unprepare(imx6_pcie->pcie_bus);
@@ -777,10 +784,11 @@ static int imx6_pcie_suspend_noirq(struct device *dev)
 	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
 
 	if (imx6_pcie->variant != IMX7D)
 		return 0;
 
+	imx6_pcie_pm_turnoff(imx6_pcie);
 	imx6_pcie_clk_disable(imx6_pcie);
 	imx6_pcie_ltssm_disable(dev);
 
 	return 0;
 }
@@ -904,10 +912,17 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 		break;
 	default:
 		break;
 	}
 
+	/* Grab turnoff reset */
+	imx6_pcie->turnoff_reset = devm_reset_control_get_optional_exclusive(dev, "turnoff");
+	if (IS_ERR(imx6_pcie->turnoff_reset)) {
+		dev_err(dev, "Failed to get TURNOFF reset control\n");
+		return PTR_ERR(imx6_pcie->turnoff_reset);
+	}
+
 	/* Grab GPR config register range */
 	imx6_pcie->iomuxc_gpr =
 		 syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
 	if (IS_ERR(imx6_pcie->iomuxc_gpr)) {
 		dev_err(dev, "unable to find iomuxc registers\n");
-- 
2.17.1
