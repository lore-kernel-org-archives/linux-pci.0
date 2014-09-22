Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2on0106.outbound.protection.outlook.com ([207.46.100.106]:63652
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750914AbaIVJot (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 22 Sep 2014 05:44:49 -0400
From: Richard Zhu <r65037@freescale.com>
To: <linux-pci-owner@vger.kernel.org>
CC: <stable@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<l.stach@pengutronix.de>, Richard Zhu <r65037@freescale.com>
Subject: [PATCH RFC 2/2] PCI: imx6: add imx6sx pcie support
Date: Mon, 22 Sep 2014 17:01:38 +0800
Message-ID: <1411376498-14653-3-git-send-email-r65037@freescale.com>
In-Reply-To: <1411376498-14653-1-git-send-email-r65037@freescale.com>
References: <1411376498-14653-1-git-send-email-r65037@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

- imx6sx pcie has its own standalone pcie power supply.
In order to turn on the imx6sx pcie power during
initialization. Add the pcie regulator and the gpc regmap
into the imx6sx pcie structure.
- imx6sx pcie has the new added reset mechanism, add the
reset operations into the initialization.
- another dis_axi clk is mandatory required by imx6sx pcie.
Add one new clk named pcie_sec into imx6_pcie structure.
- pcie_ref_125m is not used as pcie_phy clk anymore on imx6sx.
The parent clk (pcie_ref) of the pcie_bus(lvds1_gate)
is used as pcie_phy clk.
- Register one PM call-back, enter/exit L2 state of the ASPM
during system suspend/resume.
- wait the clocks to stabilize after the pcie_ref_en
(IMX6Q_GPR1_PCIE_REF_CLK_EN) is set.

Signed-off-by: Richard Zhu <r65037@freescale.com>
---
 arch/arm/boot/dts/imx6sx-sdb.dts            |  15 ++
 arch/arm/boot/dts/imx6sx.dtsi               |  33 ++--
 arch/arm/mach-imx/Kconfig                   |   1 +
 drivers/pci/host/pci-imx6.c                 | 228 ++++++++++++++++++++++++----
 include/linux/mfd/syscon/imx6q-iomuxc-gpr.h |  14 ++
 5 files changed, 249 insertions(+), 42 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sx-sdb.dts b/arch/arm/boot/dts/imx6sx-sdb.dts
index a3980d9..83d0892 100644
--- a/arch/arm/boot/dts/imx6sx-sdb.dts
+++ b/arch/arm/boot/dts/imx6sx-sdb.dts
@@ -251,6 +251,14 @@
 	};
 };
 
+&pcie {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pcie>;
+	power-on-gpio = <&gpio2 1 0>;
+	reset-gpio = <&gpio2 0 0>;
+	status = "okay";
+};
+
 &ssi2 {
 	status = "okay";
 };
@@ -365,6 +373,13 @@
 			>;
 		};
 
+		pinctrl_pcie: pciegrp {
+			fsl,pins = <
+				MX6SX_PAD_ENET1_COL__GPIO2_IO_0 0x17059
+				MX6SX_PAD_ENET1_CRS__GPIO2_IO_1	0x17059
+			>;
+		};
+
 		pinctrl_vcc_sd3: vccsd3grp {
 			fsl,pins = <
 				MX6SX_PAD_KEY_COL1__GPIO2_IO_11		0x17059
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index f4b9da6..ec34698 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -689,9 +689,11 @@
 			};
 
 			gpc: gpc@020dc000 {
-				compatible = "fsl,imx6sx-gpc", "fsl,imx6q-gpc";
+				compatible = "fsl,imx6sx-gpc",
+					     "fsl,imx6q-gpc", "syscon";
 				reg = <0x020dc000 0x4000>;
 				interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
+				pcie-supply = <&reg_pcie>;
 			};
 
 			iomuxc: iomuxc@020e0000 {
@@ -1188,20 +1190,23 @@
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
-				  /* configuration space */
-			ranges = <0x00000800 0 0x08f00000 0x08f00000 0 0x00080000
-				  /* downstream I/O */
-				  0x81000000 0 0          0x08f80000 0 0x00010000
-				  /* non-prefetchable memory */
-				  0x82000000 0 0x08000000 0x08000000 0 0x00f00000>;
+			ranges = <0x00000800 0 0x01f00000 0x08f00000 0 0x00080000 /* configuration space */
+				  0x81000000 0 0          0x08f80000 0 0x00010000 /* downstream I/O */
+				  0x82000000 0 0x01000000 0x08000000 0 0x00f00000>; /* non-prefetchable memory */
 			num-lanes = <1>;
-			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clks IMX6SX_CLK_PCIE_REF_125M>,
-				 <&clks IMX6SX_CLK_PCIE_AXI>,
-				 <&clks IMX6SX_CLK_LVDS1_OUT>,
-				 <&clks IMX6SX_CLK_DISPLAY_AXI>;
-			clock-names = "pcie_ref_125m", "pcie_axi",
-				      "lvds_gate", "display_axi";
+			interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+			                <0 0 0 2 &intc GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
+			                <0 0 0 3 &intc GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
+			                <0 0 0 4 &intc GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks IMX6SX_CLK_PCIE_AXI>,
+				 <&clks IMX6SX_CLK_DISPLAY_AXI>,
+				 <&clks IMX6SX_CLK_LVDS1_OUT>;
+			clock-names = "pcie", "pcie_sec", "pcie_bus";
+			pcie-supply = <&reg_pcie>;
 			status = "disabled";
 		};
 	};
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index be9a51a..0a055f0 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -718,6 +718,7 @@ config SOC_IMX6SL
 
 config SOC_IMX6SX
 	bool "i.MX6 SoloX support"
+	select PCI_DOMAINS if PCI
 	select PINCTRL_IMX6SX
 	select SOC_IMX6
 
diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 233fe8a..c9b2f69 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -18,12 +18,16 @@
 #include <linux/mfd/syscon.h>
 #include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
 #include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
 #include <linux/of_gpio.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/resource.h>
 #include <linux/signal.h>
+#include <linux/syscore_ops.h>
 #include <linux/types.h>
 #include <linux/interrupt.h>
 
@@ -31,15 +35,32 @@
 
 #define to_imx6_pcie(x)	container_of(x, struct imx6_pcie, pp)
 
+/* The pcie who have standalone power domain */
+#define PCIE_PHY_HAS_PWR_DOMAIN		BIT(0)
+
+struct imx_pcie_data {
+	unsigned int flags;
+};
+
+static const struct imx_pcie_data imx6sx_pcie_data = {
+	.flags = PCIE_PHY_HAS_PWR_DOMAIN,
+};
+
 struct imx6_pcie {
 	int			reset_gpio;
+	int			power_on_gpio;
+	const struct		imx_pcie_data *data;
 	struct clk		*pcie_bus;
 	struct clk		*pcie_phy;
+	struct clk		*pcie_sec;
 	struct clk		*pcie;
 	struct pcie_port	pp;
 	struct regmap		*iomuxc_gpr;
+	struct regmap		*gpc_ips_reg;
+	struct regulator	*pcie_regulator;
 	void __iomem		*mem_base;
 };
+static struct imx6_pcie *imx6_pcie;
 
 /* PCIe Root Complex registers (memory-mapped) */
 #define PCIE_RC_LCR				0x7c
@@ -77,6 +98,11 @@ struct imx6_pcie {
 #define PHY_RX_OVRD_IN_LO_RX_DATA_EN (1 << 5)
 #define PHY_RX_OVRD_IN_LO_RX_PLL_EN (1 << 3)
 
+static inline bool is_imx6sx_pcie(struct imx6_pcie *imx6_pcie)
+{
+	return imx6_pcie->data == &imx6sx_pcie_data;
+}
+
 static int pcie_phy_poll_ack(void __iomem *dbi_base, int exp_val)
 {
 	u32 val;
@@ -257,10 +283,21 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
 	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
 	int ret;
 
-	ret = clk_prepare_enable(imx6_pcie->pcie_phy);
-	if (ret) {
-		dev_err(pp->dev, "unable to enable pcie_phy clock\n");
-		goto err_pcie_phy;
+	if (gpio_is_valid(imx6_pcie->power_on_gpio))
+		gpio_set_value(imx6_pcie->power_on_gpio, 1);
+
+	if (is_imx6sx_pcie(imx6_pcie)) {
+		ret = clk_prepare_enable(imx6_pcie->pcie_sec);
+		if (ret) {
+			dev_err(pp->dev, "unable to enable pcie_sec clk.\n");
+			goto err_pcie_sec;
+		}
+	} else {
+		ret = clk_prepare_enable(imx6_pcie->pcie_phy);
+		if (ret) {
+			dev_err(pp->dev, "unable to enable pcie_phy clock\n");
+			goto err_pcie_phy;
+		}
 	}
 
 	ret = clk_prepare_enable(imx6_pcie->pcie_bus);
@@ -275,28 +312,50 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
 		goto err_pcie;
 	}
 
+	if (is_imx6sx_pcie(imx6_pcie)) {
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+				IMX6SX_GPR12_PCIE_TEST_PD,
+				IMX6SX_GPR12_PCIE_TEST_PD_CLR);
+	} else {
+		/* power up core phy and enable ref clock */
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+				IMX6Q_GPR1_PCIE_TEST_PD, 0 << 18);
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+				IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
+	}
+
 	/* allow the clocks to stabilize */
 	usleep_range(200, 500);
 
-	/* power up core phy and enable ref clock */
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
-			IMX6Q_GPR1_PCIE_TEST_PD, 0 << 18);
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
-			IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
-
 	/* Some boards don't have PCIe reset GPIO. */
 	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
 		gpio_set_value(imx6_pcie->reset_gpio, 0);
 		msleep(100);
 		gpio_set_value(imx6_pcie->reset_gpio, 1);
 	}
+
+	/*
+	 * iMX6SX PCIe has the stand-alone power domain.
+	 * refer to the initialization for iMX6SX PCIe,
+	 * release the PCIe PHY reset here,
+	 * before LTSSM enable is set.
+	 */
+	if (is_imx6sx_pcie(imx6_pcie))
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR5,
+				IMX6SX_GPR5_PCIE_BTNRST,
+				IMX6SX_GPR5_PCIE_BTNRST_CLR);
+
 	return 0;
 
 err_pcie:
 	clk_disable_unprepare(imx6_pcie->pcie_bus);
 err_pcie_bus:
-	clk_disable_unprepare(imx6_pcie->pcie_phy);
+	if (!is_imx6sx_pcie(imx6_pcie))
+		clk_disable_unprepare(imx6_pcie->pcie_phy);
 err_pcie_phy:
+	if (is_imx6sx_pcie(imx6_pcie))
+		clk_disable_unprepare(imx6_pcie->pcie_sec);
+err_pcie_sec:
 	return ret;
 
 }
@@ -304,15 +363,38 @@ err_pcie_phy:
 static void imx6_pcie_init_phy(struct pcie_port *pp)
 {
 	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
+	int ret;
+
+	/*
+	 * iMX6SX PCIe has the stand-alone power domain
+	 * add the initialization here for iMX6SX PCIe.
+	 */
+	if (is_imx6sx_pcie(imx6_pcie)) {
+		/* Force PCIe PHY reset */
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR5,
+				IMX6SX_GPR5_PCIE_BTNRST,
+				IMX6SX_GPR5_PCIE_BTNRST);
+
+		regmap_update_bits(imx6_pcie->gpc_ips_reg, 0, 1 << 7, 1 << 7);
+		/* Power up PCIe PHY, ANATOP_REG_CORE offset 0x140, bit13-9 */
+		regulator_set_voltage(imx6_pcie->pcie_regulator,
+				1100000, 1100000);
+		ret = regulator_enable(imx6_pcie->pcie_regulator);
+		if (ret)
+			dev_info(pp->dev, "failed to enable pcie regulator.\n");
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+				IMX6SX_GPR12_RX_EQ_MASK, IMX6SX_GPR12_RX_EQ_2);
+	}
 
 	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
-			IMX6Q_GPR12_PCIE_CTL_2, 0 << 10);
+			IMX6Q_GPR12_PCIE_CTL_2,
+			IMX6Q_GPR12_PCIE_CTL_2_CLR);
 
 	/* configure constant input signal to the pcie ctrl and phy */
 	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 			IMX6Q_GPR12_DEVICE_TYPE, PCI_EXP_TYPE_ROOT_PORT << 12);
 	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
-			IMX6Q_GPR12_LOS_LEVEL, 9 << 4);
+			IMX6Q_GPR12_LOS_LEVEL, IMX6Q_GPR12_LOS_LEVEL_9);
 
 	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
 			IMX6Q_GPR8_TX_DEEMPH_GEN1, 0 << 0);
@@ -370,7 +452,8 @@ static int imx6_pcie_start_link(struct pcie_port *pp)
 
 	/* Start LTSSM. */
 	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
-			IMX6Q_GPR12_PCIE_CTL_2, 1 << 10);
+			IMX6Q_GPR12_PCIE_CTL_2,
+			IMX6Q_GPR12_PCIE_CTL_2);
 
 	ret = imx6_pcie_wait_for_link(pp);
 	if (ret)
@@ -546,10 +629,73 @@ static int __init imx6_add_pcie_port(struct pcie_port *pp,
 	return 0;
 }
 
+static const struct of_device_id imx6_pcie_of_match[] = {
+	{ .compatible = "fsl,imx6q-pcie", },
+	{ .compatible = "fsl,imx6sx-pcie", .data = &imx6sx_pcie_data},
+	{},
+};
+MODULE_DEVICE_TABLE(of, imx6_pcie_of_match);
+
+#ifdef CONFIG_PM_SLEEP
+static int pci_imx_suspend(void)
+{
+	int rc = 0;
+
+	if (is_imx6sx_pcie(imx6_pcie)) {
+		/* PM_TURN_OFF */
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+				BIT(16), 1 << 16);
+		udelay(10);
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+				BIT(16), 0 << 16);
+	}
+
+	return rc;
+}
+
+static void pci_imx_resume(void)
+{
+	struct pcie_port *pp = &imx6_pcie->pp;
+
+	if (is_imx6sx_pcie(imx6_pcie)) {
+		/* reset iMX6SX PCIe */
+		regmap_update_bits(imx6_pcie->iomuxc_gpr,
+				IOMUXC_GPR5, BIT(18), 1 << 18);
+
+		regmap_update_bits(imx6_pcie->iomuxc_gpr,
+				IOMUXC_GPR5, BIT(18), 0 << 18);
+
+		/*
+		 * controller maybe turn off, re-configure again
+		 * Set the CLASS_REV of RC CFG header to
+		 * PCI_CLASS_BRIDGE_PCI
+		 */
+		writel(readl(pp->dbi_base + PCI_CLASS_REVISION)
+			| (PCI_CLASS_BRIDGE_PCI << 16),
+			pp->dbi_base + PCI_CLASS_REVISION);
+
+		dw_pcie_setup_rc(pp);
+
+		/* reset iMX6SX PCIe */
+		regmap_update_bits(imx6_pcie->iomuxc_gpr,
+				IOMUXC_GPR5, BIT(18), 1 << 18);
+
+		regmap_update_bits(imx6_pcie->iomuxc_gpr,
+				IOMUXC_GPR5, BIT(18), 0 << 18);
+	}
+}
+
+static struct syscore_ops pci_imx_syscore_ops = {
+	.suspend = pci_imx_suspend,
+	.resume = pci_imx_resume,
+};
+#endif
+
 static int __init imx6_pcie_probe(struct platform_device *pdev)
 {
-	struct imx6_pcie *imx6_pcie;
 	struct pcie_port *pp;
+	const struct of_device_id *of_id =
+			of_match_device(imx6_pcie_of_match, &pdev->dev);
 	struct device_node *np = pdev->dev.of_node;
 	struct resource *dbi_base;
 	int ret;
@@ -560,6 +706,7 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
 
 	pp = &imx6_pcie->pp;
 	pp->dev = &pdev->dev;
+	imx6_pcie->data = of_id->data;
 
 	/* Added for PCI abort handling */
 	hook_fault_code(16 + 6, imx6q_pcie_abort_handler, SIGBUS, 0,
@@ -581,12 +728,26 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
 		}
 	}
 
+	imx6_pcie->power_on_gpio = of_get_named_gpio(np, "power-on-gpio", 0);
+	if (gpio_is_valid(imx6_pcie->power_on_gpio)) {
+		ret = devm_gpio_request_one(&pdev->dev,
+					imx6_pcie->power_on_gpio,
+					GPIOF_OUT_INIT_LOW,
+					"PCIe power enable");
+		if (ret) {
+			dev_err(&pdev->dev, "unable to get power-on gpio\n");
+			return ret;
+		}
+	}
+
 	/* Fetch clocks */
-	imx6_pcie->pcie_phy = devm_clk_get(&pdev->dev, "pcie_phy");
-	if (IS_ERR(imx6_pcie->pcie_phy)) {
-		dev_err(&pdev->dev,
-			"pcie_phy clock source missing or invalid\n");
-		return PTR_ERR(imx6_pcie->pcie_phy);
+	if (!is_imx6sx_pcie(imx6_pcie)) {
+		imx6_pcie->pcie_phy = devm_clk_get(&pdev->dev, "pcie_phy");
+		if (IS_ERR(imx6_pcie->pcie_phy)) {
+			dev_err(&pdev->dev,
+				"pcie_phy clock source missing or invalid\n");
+			return PTR_ERR(imx6_pcie->pcie_phy);
+		}
 	}
 
 	imx6_pcie->pcie_bus = devm_clk_get(&pdev->dev, "pcie_bus");
@@ -604,8 +765,22 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
 	}
 
 	/* Grab GPR config register range */
-	imx6_pcie->iomuxc_gpr =
-		 syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
+	if (is_imx6sx_pcie(imx6_pcie)) {
+		/* Get pcie regulator */
+		imx6_pcie->pcie_regulator = devm_regulator_get(pp->dev, "pcie");
+
+		/* Grab GPR config register range */
+		imx6_pcie->iomuxc_gpr =
+			 syscon_regmap_lookup_by_compatible
+			 ("fsl,imx6sx-iomuxc-gpr");
+		/* Grab GPC IPS register range */
+		imx6_pcie->gpc_ips_reg =
+			 syscon_regmap_lookup_by_compatible("fsl,imx6sx-gpc");
+	} else {
+		imx6_pcie->iomuxc_gpr =
+			syscon_regmap_lookup_by_compatible
+			("fsl,imx6q-iomuxc-gpr");
+	}
 	if (IS_ERR(imx6_pcie->iomuxc_gpr)) {
 		dev_err(&pdev->dev, "unable to find iomuxc registers\n");
 		return PTR_ERR(imx6_pcie->iomuxc_gpr);
@@ -616,6 +791,9 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
 		return ret;
 
 	platform_set_drvdata(pdev, imx6_pcie);
+#ifdef CONFIG_PM_SLEEP
+	register_syscore_ops(&pci_imx_syscore_ops);
+#endif
 	return 0;
 }
 
@@ -627,12 +805,6 @@ static void imx6_pcie_shutdown(struct platform_device *pdev)
 	imx6_pcie_assert_core_reset(&imx6_pcie->pp);
 }
 
-static const struct of_device_id imx6_pcie_of_match[] = {
-	{ .compatible = "fsl,imx6q-pcie", },
-	{},
-};
-MODULE_DEVICE_TABLE(of, imx6_pcie_of_match);
-
 static struct platform_driver imx6_pcie_driver = {
 	.driver = {
 		.name	= "imx6q-pcie",
diff --git a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h b/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
index ff44374..f02875e 100644
--- a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
+++ b/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
@@ -113,10 +113,12 @@
 #define IMX6Q_GPR1_MIPI_IPU1_MUX_GASKET		0x0
 #define IMX6Q_GPR1_MIPI_IPU1_MUX_IOMUX		BIT(19)
 #define IMX6Q_GPR1_PCIE_TEST_PD			BIT(18)
+#define IMX6Q_GPR1_PCIE_TEST_PD_CLR		0x0
 #define IMX6Q_GPR1_IPU_VPU_MUX_MASK		BIT(17)
 #define IMX6Q_GPR1_IPU_VPU_MUX_IPU1		0x0
 #define IMX6Q_GPR1_IPU_VPU_MUX_IPU2		BIT(17)
 #define IMX6Q_GPR1_PCIE_REF_CLK_EN		BIT(16)
+#define IMX6Q_GPR1_PCIE_REF_CLK_CLR		0x0
 #define IMX6Q_GPR1_USB_EXP_MODE			BIT(15)
 #define IMX6Q_GPR1_PCIE_INT			BIT(14)
 #define IMX6Q_GPR1_USB_OTG_ID_SEL_MASK		BIT(13)
@@ -300,7 +302,9 @@
 #define IMX6Q_GPR12_ARMP_APB_CLK_EN		BIT(24)
 #define IMX6Q_GPR12_DEVICE_TYPE			(0xf << 12)
 #define IMX6Q_GPR12_PCIE_CTL_2			BIT(10)
+#define IMX6Q_GPR12_PCIE_CTL_2_CLR		0x0
 #define IMX6Q_GPR12_LOS_LEVEL			(0x1f << 4)
+#define IMX6Q_GPR12_LOS_LEVEL_9			(0x9 << 4)
 
 #define IMX6Q_GPR13_SDMA_STOP_REQ		BIT(30)
 #define IMX6Q_GPR13_CAN2_STOP_REQ		BIT(29)
@@ -395,4 +399,14 @@
 #define IMX6SL_GPR1_FEC_CLOCK_MUX1_SEL_MASK    (0x3 << 17)
 #define IMX6SL_GPR1_FEC_CLOCK_MUX2_SEL_MASK    (0x1 << 14)
 
+/* For imx6sx iomux gpr register field define */
+#define IMX6SX_GPR5_PCIE_BTNRST			BIT(19)
+#define IMX6SX_GPR5_PCIE_BTNRST_CLR		0x0
+#define IMX6SX_GPR5_PCIE_PERST			BIT(18)
+#define IMX6SX_GPR5_PCIE_PERST_CLR		0x0
+
+#define IMX6SX_GPR12_PCIE_TEST_PD		BIT(30)
+#define IMX6SX_GPR12_PCIE_TEST_PD_CLR		0x0
+#define IMX6SX_GPR12_RX_EQ_MASK			(0x7 << 0)
+#define IMX6SX_GPR12_RX_EQ_2			(0x2 << 0)
 #endif /* __LINUX_IMX6Q_IOMUXC_GPR_H */
-- 
1.9.1

