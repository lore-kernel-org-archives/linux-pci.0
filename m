Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH 3/3] PCI: imx6: Add code to support i.MX7D
Date: Thu, 19 Jan 2017 08:36:31 -0800
Message-Id: <20170119163631.10668-4-andrew.smirnov@gmail.com>
In-Reply-To: <20170119163631.10668-1-andrew.smirnov@gmail.com>
References: <20170119163631.10668-1-andrew.smirnov@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Richard Zhu <hongxing.zhu@nxp.com>, Andrey Smirnov <andrew.smirnov@gmail.com>,
 Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Lee Jones <lee.jones@linaro.org>, yurovsky@gmail.com,
 Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org,
 Lucas Stach <l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Add various bits of code needed to support i.MX7D variant of the IP.

Cc: yurovsky@gmail.com
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |   6 +-
 drivers/pci/host/pci-imx6.c                        | 188 ++++++++++++++++++---
 include/linux/mfd/syscon/imx7-gpc.h                |  18 ++
 include/linux/mfd/syscon/imx7-iomuxc-gpr.h         |   4 +
 include/linux/mfd/syscon/imx7-src.h                |  18 ++
 5 files changed, 208 insertions(+), 26 deletions(-)
 create mode 100644 include/linux/mfd/syscon/imx7-gpc.h
 create mode 100644 include/linux/mfd/syscon/imx7-src.h

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
index 83aeb1f..20b9382 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
@@ -4,7 +4,8 @@ This PCIe host controller is based on the Synopsis Designware PCIe IP
 and thus inherits all the common properties defined in designware-pcie.txt.
 
 Required properties:
-- compatible: "fsl,imx6q-pcie", "fsl,imx6sx-pcie", "fsl,imx6qp-pcie"
+- compatible: "fsl,imx6q-pcie", "fsl,imx6sx-pcie",
+  	      "fsl,imx6qp-pcie", "fsl,imx7d-pcie"
 - reg: base address and length of the PCIe controller
 - interrupts: A list of interrupt outputs of the controller. Must contain an
   entry for each entry in the interrupt-names property.
@@ -34,6 +35,9 @@ Additional required properties for imx6sx-pcie:
 - clock names: Must include the following additional entries:
 	- "pcie_inbound_axi"
 
+Additional required properties for imx7d-pcie:
+- pcie-phy-supply: Should specify the regulator supplying PCIe PHY
+
 Example:
 
 	pcie@0x01000000 {
diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 574f026..f29148e 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -17,6 +17,9 @@
 #include <linux/kernel.h>
 #include <linux/mfd/syscon.h>
 #include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
+#include <linux/mfd/syscon/imx7-iomuxc-gpr.h>
+#include <linux/mfd/syscon/imx7-src.h>
+#include <linux/mfd/syscon/imx7-gpc.h>
 #include <linux/module.h>
 #include <linux/of_gpio.h>
 #include <linux/of_device.h>
@@ -27,6 +30,7 @@
 #include <linux/signal.h>
 #include <linux/types.h>
 #include <linux/interrupt.h>
+#include <linux/regulator/consumer.h>
 
 #include "pcie-designware.h"
 
@@ -36,6 +40,7 @@ enum imx6_pcie_variants {
 	IMX6Q,
 	IMX6SX,
 	IMX6QP,
+	IMX7D,
 };
 
 struct imx6_pcie {
@@ -47,6 +52,8 @@ struct imx6_pcie {
 	struct clk		*pcie_inbound_axi;
 	struct clk		*pcie;
 	struct regmap		*iomuxc_gpr;
+	struct regmap		*src;
+	struct regmap		*gpc;
 	enum imx6_pcie_variants variant;
 	u32			tx_deemph_gen1;
 	u32			tx_deemph_gen2_3p5db;
@@ -54,8 +61,14 @@ struct imx6_pcie {
 	u32			tx_swing_full;
 	u32			tx_swing_low;
 	int			link_gen;
+	struct regulator	*pcie_phy_regulator;
 };
 
+/* Parameters for the waiting for PCIe PHY PLL to lock on i.MX7 */
+#define PHY_PLL_LOCK_WAIT_MAX_RETRIES	2000
+#define PHY_PLL_LOCK_WAIT_USLEEP_MIN	50
+#define PHY_PLL_LOCK_WAIT_USLEEP_MAX	200
+
 /* PCIe Root Complex registers (memory-mapped) */
 #define PCIE_RC_LCR				0x7c
 #define PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN1	0x1
@@ -251,6 +264,16 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 	u32 val, gpr1, gpr12;
 
 	switch (imx6_pcie->variant) {
+	case IMX7D:
+		regmap_update_bits(imx6_pcie->src,
+				   SRC_PCIEPHY_RCR,
+				   IMX7D_SRC_PCIEPHY_RCR_PCIEPHY_G_RST,
+				   IMX7D_SRC_PCIEPHY_RCR_PCIEPHY_G_RST);
+		regmap_update_bits(imx6_pcie->src,
+				   SRC_PCIEPHY_RCR,
+				   IMX7D_SRC_PCIEPHY_RCR_PCIEPHY_BTN,
+				   IMX7D_SRC_PCIEPHY_RCR_PCIEPHY_BTN);
+		break;
 	case IMX6SX:
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN,
@@ -333,11 +356,33 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
 				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
 		break;
+	case IMX7D:
+		break;
 	}
 
 	return ret;
 }
 
+static void imx7d_pcie_wait_for_phy_pll_lock(struct imx6_pcie *imx6_pcie)
+{
+	u32 val;
+	unsigned int retries;
+	struct pcie_port *pp = &imx6_pcie->pp;
+	struct device *dev = pp->dev;
+
+	for (retries = 0; retries < PHY_PLL_LOCK_WAIT_MAX_RETRIES; retries++) {
+		regmap_read(imx6_pcie->iomuxc_gpr, IOMUXC_GPR22, &val);
+
+		if (val & IMX7D_GPR22_PCIE_PHY_PLL_LOCKED)
+			return;
+
+		usleep_range(PHY_PLL_LOCK_WAIT_USLEEP_MIN,
+			     PHY_PLL_LOCK_WAIT_USLEEP_MAX);
+	}
+
+	dev_err(dev, "PCIe PLL lock timeout\n");
+}
+
 static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 {
 	struct pcie_port *pp = &imx6_pcie->pp;
@@ -381,6 +426,21 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 	}
 
 	switch (imx6_pcie->variant) {
+	case IMX7D:
+		/* wait for more than 10us to release phy g_rst and btnrst */
+		udelay(10);
+		regmap_update_bits(imx6_pcie->src,
+				   SRC_PCIEPHY_RCR,
+				   IMX7D_SRC_PCIEPHY_RCR_PCIE_CTRL_APPS_EN, 0);
+		regmap_update_bits(imx6_pcie->src,
+				   SRC_PCIEPHY_RCR,
+				   IMX7D_SRC_PCIEPHY_RCR_PCIEPHY_G_RST, 0);
+		regmap_update_bits(imx6_pcie->src,
+				   SRC_PCIEPHY_RCR,
+				   IMX7D_SRC_PCIEPHY_RCR_PCIEPHY_BTN, 0);
+
+		imx7d_pcie_wait_for_phy_pll_lock(imx6_pcie);
+		break;
 	case IMX6SX:
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR5,
 				   IMX6SX_GPR5_PCIE_BTNRST_RESET, 0);
@@ -407,35 +467,80 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 
 static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
 {
-	if (imx6_pcie->variant == IMX6SX)
+	switch (imx6_pcie->variant) {
+	case IMX7D: {
+		int ret;
+		unsigned int reg, mapping;
+		struct pcie_port *pp = &imx6_pcie->pp;
+		struct device *dev = pp->dev;
+
+		regulator_set_voltage(imx6_pcie->pcie_phy_regulator,
+				      1000000, 1000000);
+		ret = regulator_enable(imx6_pcie->pcie_phy_regulator);
+		if (ret) {
+			dev_err(dev, "failed to enable pcie regulator.\n");
+			return;
+		}
+
+		/*
+		 * Now that PHY regulator is enabled, do sofware
+		 * power-up request by mapping PHY in A7 domain and
+		 * setting power-up request bit
+		 */
+		regmap_read(imx6_pcie->gpc, GPC_PGC_CPU_MAPPING, &mapping);
+		regmap_write(imx6_pcie->gpc, GPC_PGC_CPU_MAPPING,
+			     mapping | IMX7D_PCIE_PHY_A7_DOMAIN);
+
+		regmap_update_bits(imx6_pcie->gpc, GPC_PU_PGC_SW_PUP_REQ,
+				   IMX7D_PCIE_PHY_SW_PUP_REQ,
+				   IMX7D_PCIE_PHY_SW_PUP_REQ);
+		/*
+		 * As per "5.5.9.4 Example Code 4" in IMX7DRM.pdf wait
+		 * for PUP_REQ bit to be cleared
+		 */
+		while (!regmap_read(imx6_pcie->gpc,
+				    GPC_PU_PGC_SW_PUP_REQ, &reg) &&
+		       reg & IMX7D_PCIE_PHY_SW_PUP_REQ)
+			;
+		regmap_write(imx6_pcie->gpc, GPC_PGC_CPU_MAPPING, mapping);
+
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL, 0);
+		break;
+	}
+	case IMX6SX:
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				   IMX6SX_GPR12_PCIE_RX_EQ_MASK,
 				   IMX6SX_GPR12_PCIE_RX_EQ_2);
+		/* FALLTHROUGH */
+	default:
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+				   IMX6Q_GPR12_PCIE_CTL_2, 0 << 10);
 
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
-			IMX6Q_GPR12_PCIE_CTL_2, 0 << 10);
+		/* configure constant input signal to the pcie ctrl and phy */
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+				   IMX6Q_GPR12_LOS_LEVEL, 9 << 4);
+
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
+				   IMX6Q_GPR8_TX_DEEMPH_GEN1,
+				   imx6_pcie->tx_deemph_gen1 << 0);
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
+				   IMX6Q_GPR8_TX_DEEMPH_GEN2_3P5DB,
+				   imx6_pcie->tx_deemph_gen2_3p5db << 6);
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
+				   IMX6Q_GPR8_TX_DEEMPH_GEN2_6DB,
+				   imx6_pcie->tx_deemph_gen2_6db << 12);
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
+				   IMX6Q_GPR8_TX_SWING_FULL,
+				   imx6_pcie->tx_swing_full << 18);
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
+				   IMX6Q_GPR8_TX_SWING_LOW,
+				   imx6_pcie->tx_swing_low << 25);
+		break;
+	}
 
-	/* configure constant input signal to the pcie ctrl and phy */
 	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 			IMX6Q_GPR12_DEVICE_TYPE, PCI_EXP_TYPE_ROOT_PORT << 12);
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
-			IMX6Q_GPR12_LOS_LEVEL, 9 << 4);
-
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
-			   IMX6Q_GPR8_TX_DEEMPH_GEN1,
-			   imx6_pcie->tx_deemph_gen1 << 0);
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
-			   IMX6Q_GPR8_TX_DEEMPH_GEN2_3P5DB,
-			   imx6_pcie->tx_deemph_gen2_3p5db << 6);
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
-			   IMX6Q_GPR8_TX_DEEMPH_GEN2_6DB,
-			   imx6_pcie->tx_deemph_gen2_6db << 12);
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
-			   IMX6Q_GPR8_TX_SWING_FULL,
-			   imx6_pcie->tx_swing_full << 18);
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
-			   IMX6Q_GPR8_TX_SWING_LOW,
-			   imx6_pcie->tx_swing_low << 25);
 }
 
 static int imx6_pcie_wait_for_link(struct imx6_pcie *imx6_pcie)
@@ -498,8 +603,14 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
 	dw_pcie_writel_rc(pp, PCIE_RC_LCR, tmp);
 
 	/* Start LTSSM. */
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
-			IMX6Q_GPR12_PCIE_CTL_2, 1 << 10);
+	if (imx6_pcie->variant == IMX7D)
+		regmap_update_bits(imx6_pcie->src,
+				   SRC_PCIEPHY_RCR,
+				   IMX7D_SRC_PCIEPHY_RCR_PCIE_CTRL_APPS_EN,
+				   IMX7D_SRC_PCIEPHY_RCR_PCIE_CTRL_APPS_EN);
+	else
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+				   IMX6Q_GPR12_PCIE_CTL_2, 1 << 10);
 
 	ret = imx6_pcie_wait_for_link(imx6_pcie);
 	if (ret) {
@@ -677,13 +788,39 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
 		return PTR_ERR(imx6_pcie->pcie);
 	}
 
-	if (imx6_pcie->variant == IMX6SX) {
+	switch (imx6_pcie->variant) {
+	case IMX6SX:
 		imx6_pcie->pcie_inbound_axi = devm_clk_get(dev,
 							   "pcie_inbound_axi");
 		if (IS_ERR(imx6_pcie->pcie_inbound_axi)) {
 			dev_err(dev, "pcie_inbound_axi clock missing or invalid\n");
 			return PTR_ERR(imx6_pcie->pcie_inbound_axi);
 		}
+		break;
+	case IMX7D:
+		imx6_pcie->src =
+			syscon_regmap_lookup_by_compatible("fsl,imx7d-src");
+		if (IS_ERR(imx6_pcie->src)) {
+			dev_err(dev, "imx7d pcie phy src missing or invalid\n");
+			return PTR_ERR(imx6_pcie->src);
+		}
+
+		imx6_pcie->gpc =
+			syscon_regmap_lookup_by_compatible("fsl,imx7d-gpc");
+		if (IS_ERR(imx6_pcie->gpc)) {
+			dev_err(dev, "unable to find gpc registers\n");
+			return PTR_ERR(imx6_pcie->gpc);
+		}
+
+		imx6_pcie->pcie_phy_regulator = devm_regulator_get(pp->dev,
+								   "pcie-phy");
+		if (IS_ERR(imx6_pcie->pcie_phy_regulator)) {
+			dev_err(dev, "imx7d pcie phy src missing or invalid\n");
+			return PTR_ERR(imx6_pcie->pcie_phy_regulator);
+		}
+		break;
+	default:
+		break;
 	}
 
 	/* Grab GPR config register range */
@@ -741,6 +878,7 @@ static const struct of_device_id imx6_pcie_of_match[] = {
 	{ .compatible = "fsl,imx6q-pcie",  .data = (void *)IMX6Q,  },
 	{ .compatible = "fsl,imx6sx-pcie", .data = (void *)IMX6SX, },
 	{ .compatible = "fsl,imx6qp-pcie", .data = (void *)IMX6QP, },
+	{ .compatible = "fsl,imx7d-pcie",  .data = (void *)IMX7D,  },
 	{},
 };
 
diff --git a/include/linux/mfd/syscon/imx7-gpc.h b/include/linux/mfd/syscon/imx7-gpc.h
new file mode 100644
index 0000000..38e1c9a9
--- /dev/null
+++ b/include/linux/mfd/syscon/imx7-gpc.h
@@ -0,0 +1,18 @@
+/*
+ * Copyright (C) 2017 Impinj
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __LINUX_IMX7_GPC_H
+#define __LINUX_IMX7_GPC_H
+
+#define GPC_PGC_CPU_MAPPING	0xec
+#define GPC_PU_PGC_SW_PUP_REQ	0xf8
+
+#define IMX7D_PCIE_PHY_A7_DOMAIN	BIT(3)
+#define IMX7D_PCIE_PHY_SW_PUP_REQ	BIT(1)
+
+#endif
diff --git a/include/linux/mfd/syscon/imx7-iomuxc-gpr.h b/include/linux/mfd/syscon/imx7-iomuxc-gpr.h
index 4585d61..abbd524 100644
--- a/include/linux/mfd/syscon/imx7-iomuxc-gpr.h
+++ b/include/linux/mfd/syscon/imx7-iomuxc-gpr.h
@@ -44,4 +44,8 @@
 
 #define IMX7D_GPR5_CSI_MUX_CONTROL_MIPI		(0x1 << 4)
 
+#define IMX7D_GPR12_PCIE_PHY_REFCLK_SEL		BIT(5)
+
+#define IMX7D_GPR22_PCIE_PHY_PLL_LOCKED		BIT(31)
+
 #endif /* __LINUX_IMX7_IOMUXC_GPR_H */
diff --git a/include/linux/mfd/syscon/imx7-src.h b/include/linux/mfd/syscon/imx7-src.h
new file mode 100644
index 0000000..fdc4806
--- /dev/null
+++ b/include/linux/mfd/syscon/imx7-src.h
@@ -0,0 +1,18 @@
+/*
+ * Copyright (C) 2017 Impinj
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __LINUX_IMX7_SRC_H
+#define __LINUX_IMX7_SRC_H
+
+#define SRC_PCIEPHY_RCR		0x2c
+
+#define IMX7D_SRC_PCIEPHY_RCR_PCIEPHY_G_RST	BIT(1)
+#define IMX7D_SRC_PCIEPHY_RCR_PCIEPHY_BTN	BIT(2)
+#define IMX7D_SRC_PCIEPHY_RCR_PCIE_CTRL_APPS_EN	BIT(6)
+
+#endif /* __LINUX_IMX7_IOMUXC_GPR_H */
-- 
2.9.3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
