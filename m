Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-pci@vger.kernel.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, yurovsky@gmail.com,
        Lucas Stach <l.stach@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] PCI: imx6: Add code to support i.MX7D
Date: Wed,  1 Feb 2017 08:55:59 -0800
Message-Id: <20170201165559.22436-4-andrew.smirnov@gmail.com>
In-Reply-To: <20170201165559.22436-1-andrew.smirnov@gmail.com>
References: <20170201165559.22436-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add various bits of code needed to support i.MX7D variant of the IP.

Cc: yurovsky@gmail.com
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |   6 +-
 drivers/pci/host/pci-imx6.c                        | 136 +++++++++++++++++----
 include/linux/mfd/syscon/imx7-gpc.h                |  18 +++
 include/linux/mfd/syscon/imx7-iomuxc-gpr.h         |   4 +
 include/linux/mfd/syscon/imx7-src.h                |  18 +++
 5 files changed, 156 insertions(+), 26 deletions(-)
 create mode 100644 include/linux/mfd/syscon/imx7-gpc.h
 create mode 100644 include/linux/mfd/syscon/imx7-src.h

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
index 83aeb1f..9f57759 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
@@ -4,7 +4,11 @@ This PCIe host controller is based on the Synopsis Designware PCIe IP
 and thus inherits all the common properties defined in designware-pcie.txt.
 
 Required properties:
-- compatible: "fsl,imx6q-pcie", "fsl,imx6sx-pcie", "fsl,imx6qp-pcie"
+- compatible:
+	- "fsl,imx6q-pcie"
+	- "fsl,imx6sx-pcie",
+	- "fsl,imx6qp-pcie"
+	- "fsl,imx7d-pcie"
 - reg: base address and length of the PCIe controller
 - interrupts: A list of interrupt outputs of the controller. Must contain an
   entry for each entry in the interrupt-names property.
diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 3ef8093..e64ddd9 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -17,6 +17,8 @@
 #include <linux/kernel.h>
 #include <linux/mfd/syscon.h>
 #include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
+#include <linux/mfd/syscon/imx7-iomuxc-gpr.h>
+#include <linux/mfd/syscon/imx7-src.h>
 #include <linux/module.h>
 #include <linux/of_gpio.h>
 #include <linux/of_device.h>
@@ -27,6 +29,7 @@
 #include <linux/signal.h>
 #include <linux/types.h>
 #include <linux/interrupt.h>
+#include <linux/pm_domain.h>
 
 #include "pcie-designware.h"
 
@@ -36,6 +39,7 @@ enum imx6_pcie_variants {
 	IMX6Q,
 	IMX6SX,
 	IMX6QP,
+	IMX7D,
 };
 
 struct imx6_pcie {
@@ -47,6 +51,7 @@ struct imx6_pcie {
 	struct clk		*pcie_inbound_axi;
 	struct clk		*pcie;
 	struct regmap		*iomuxc_gpr;
+	struct regmap		*src;
 	enum imx6_pcie_variants variant;
 	u32			tx_deemph_gen1;
 	u32			tx_deemph_gen2_3p5db;
@@ -56,6 +61,11 @@ struct imx6_pcie {
 	int			link_gen;
 };
 
+/* Parameters for the waiting for PCIe PHY PLL to lock on i.MX7 */
+#define PHY_PLL_LOCK_WAIT_MAX_RETRIES	2000
+#define PHY_PLL_LOCK_WAIT_USLEEP_MIN	50
+#define PHY_PLL_LOCK_WAIT_USLEEP_MAX	200
+
 /* PCIe Root Complex registers (memory-mapped) */
 #define PCIE_RC_LCR				0x7c
 #define PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN1	0x1
@@ -251,6 +261,16 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
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
@@ -333,11 +353,33 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
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
@@ -381,6 +423,21 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
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
@@ -407,35 +464,45 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 
 static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
 {
-	if (imx6_pcie->variant == IMX6SX)
+	switch (imx6_pcie->variant) {
+	case IMX7D: {
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
@@ -498,8 +565,14 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
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
@@ -676,13 +749,25 @@ static int imx6_pcie_probe(struct platform_device *pdev)
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
+		break;
+	default:
+		break;
 	}
 
 	/* Grab GPR config register range */
@@ -740,6 +825,7 @@ static const struct of_device_id imx6_pcie_of_match[] = {
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
