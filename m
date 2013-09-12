Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail1.g1.pair.com ([66.39.3.162]:54129 "EHLO mail1.g1.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753595Ab3ILEUe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 12 Sep 2013 00:20:34 -0400
From: Sean Cross <xobs@kosagi.com>
To: devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Sean Cross <xobs@kosagi.com>
Subject: [PATCH v3 3/3] PCI: imx6: Add support for i.MX6 PCIe controller
Date: Thu, 12 Sep 2013 04:03:31 +0000
Message-Id: <1378958611-4274-4-git-send-email-xobs@kosagi.com>
In-Reply-To: <1378958611-4274-1-git-send-email-xobs@kosagi.com>
References: <1378958611-4274-1-git-send-email-xobs@kosagi.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add support for the PCIe port present on the i.MX6 family of controllers.
These use the Synopsis Designware core tied to their own PHY.

Signed-off-by: Sean Cross <xobs@kosagi.com>
---
 .../devicetree/bindings/pci/designware-pcie.txt    |    5 +
 arch/arm/boot/dts/imx6qdl.dtsi                     |   18 +
 arch/arm/mach-imx/Kconfig                          |    2 +
 drivers/pci/host/Kconfig                           |    6 +
 drivers/pci/host/Makefile                          |    1 +
 drivers/pci/host/pci-imx6.c                        |  549 ++++++++++++++++++++
 6 files changed, 581 insertions(+)
 create mode 100644 drivers/pci/host/pci-imx6.c

diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
index eabcb4b..41d8419 100644
--- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
@@ -21,6 +21,11 @@ Required properties:
 - num-lanes: number of lanes to use
 - reset-gpio: gpio pin number of power good signal
 
+Optional properties for fsl,imx6-pcie
+- power-on-gpio: gpio pin number of power-enable signal
+- wake-up-gpio: gpio pin number of incoming wakeup signal
+- disable-gpio: gpio pin number of outgoing rfkill/endpoint disable signal
+
 Example:
 
 SoC specific DT Entry:
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index ccd55c2..ae51f60 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -116,6 +116,24 @@
 			arm,data-latency = <4 2 3>;
 		};
 
+		pcie: pcie@0x01000000 {
+			compatible = "fsl,imx6-pcie", "snps,dw-pcie";
+			reg = <0x01ffc000 0x4000>; /* DBI */
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			ranges = <0x00000800 0 0x01f00000 0x01f00000 0 0x000fc000   /* configuration space */
+				  0x81000000 0 0          0x01000000 0 0x00100000   /* downstream I/O */
+				  0x82000000 0 0x01100000 0x01100000 0 0x00e00000>; /* non-prefetchable memory */
+
+			num-lanes = <1>;
+			interrupts = <0 123 0x04>;
+			clocks = <&clks 186>, <&clks 189>, <&clks 203>, <&clks 205>, <&clks 144>;
+			clock-names = "sata_ref", "pcie_ref_125m", "lvds1_sel", "lvds1_gate", "pcie_axi";
+			status = "disabled";
+		};
+
 		pmu {
 			compatible = "arm,cortex-a9-pmu";
 			interrupts = <0 94 0x04>;
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 29a8af6..e6ac281 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -801,6 +801,8 @@ config SOC_IMX6Q
 	select HAVE_IMX_SRC
 	select HAVE_SMP
 	select MFD_SYSCON
+	select MIGHT_HAVE_PCI
+	select PCI_DOMAINS if PCI
 	select PINCTRL
 	select PINCTRL_IMX6Q
 	select PL310_ERRATA_588369 if CACHE_PL310
diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 3d95048..efa24d9 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -15,6 +15,12 @@ config PCI_EXYNOS
 	select PCIEPORTBUS
 	select PCIE_DW
 
+config PCI_IMX6
+	bool "Freescale i.MX6 PCIe controller"
+	depends on SOC_IMX6Q
+	select PCIEPORTBUS
+	select PCIE_DW
+
 config PCI_TEGRA
 	bool "NVIDIA Tegra PCIe controller"
 	depends on ARCH_TEGRA
diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
index c9a997b..287d6a0 100644
--- a/drivers/pci/host/Makefile
+++ b/drivers/pci/host/Makefile
@@ -1,4 +1,5 @@
 obj-$(CONFIG_PCIE_DW) += pcie-designware.o
 obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
+obj-$(CONFIG_PCI_IMX6) += pci-imx6.o
 obj-$(CONFIG_PCI_MVEBU) += pci-mvebu.o
 obj-$(CONFIG_PCI_TEGRA) += pci-tegra.o
diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
new file mode 100644
index 0000000..160bac2
--- /dev/null
+++ b/drivers/pci/host/pci-imx6.c
@@ -0,0 +1,549 @@
+/*
+ * PCIe host controller driver for Freescale i.MX6 SoCs
+ *
+ * Copyright (C) 2013 Kosagi
+ *		http://www.kosagi.com
+ *
+ * Author: Sean Cross <xobs@kosagi.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/gpio.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_gpio.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/resource.h>
+#include <linux/signal.h>
+#include <linux/types.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
+#include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
+
+#include "pcie-designware.h"
+
+#define to_imx6_pcie(x)	container_of(x, struct imx6_pcie, pp)
+
+struct imx6_pcie {
+	int			reset_gpio;
+	int			power_on_gpio;
+	int			wake_up_gpio;
+	int			disable_gpio;
+	struct clk		*lvds1_sel;
+	struct clk		*lvds1_gate;
+	struct clk		*pcie_ref_125m;
+	struct clk		*pcie_axi;
+	struct clk		*sata_ref;
+	struct pcie_port	pp;
+	struct regmap		*iomuxc_gpr;
+	void __iomem		*mem_base;
+};
+
+#define IMX6_ENTER_RESET 0
+#define IMX6_EXIT_RESET 1
+
+#define IMX6_POWER_OFF 0
+#define IMX6_POWER_ON 1
+
+/* PCIe Port Logic registers (memory-mapped) */
+#define PL_OFFSET 0x700
+#define PCIE_PHY_DEBUG_R0 (PL_OFFSET + 0x28)
+#define PCIE_PHY_DEBUG_R1 (PL_OFFSET + 0x2c)
+
+#define PCIE_PHY_CTRL (PL_OFFSET + 0x114)
+#define PCIE_PHY_CTRL_DATA_LOC 0
+#define PCIE_PHY_CTRL_CAP_ADR_LOC 16
+#define PCIE_PHY_CTRL_CAP_DAT_LOC 17
+#define PCIE_PHY_CTRL_WR_LOC 18
+#define PCIE_PHY_CTRL_RD_LOC 19
+
+#define PCIE_PHY_STAT (PL_OFFSET + 0x110)
+#define PCIE_PHY_STAT_DATA_LOC 0
+#define PCIE_PHY_STAT_ACK_LOC 16
+
+/* PHY registers (not memory-mapped) */
+#define PCIE_PHY_RX_ASIC_OUT 0x100D
+
+#define PHY_RX_OVRD_IN_LO 0x1005
+#define PHY_RX_OVRD_IN_LO_RX_DATA_EN (1<<5)
+#define PHY_RX_OVRD_IN_LO_RX_PLL_EN (1<<3)
+
+static int pcie_phy_poll_ack(void __iomem *dbi_base, int max_iterations,
+			     int exp_val)
+{
+	u32 val;
+	u32 wait_counter = 0;
+
+	do {
+		val = readl(dbi_base + PCIE_PHY_STAT);
+		val = (val >> PCIE_PHY_STAT_ACK_LOC) & 0x1;
+		wait_counter++;
+	} while ((wait_counter < max_iterations) && (val != exp_val));
+
+	if (val != exp_val)
+		return -1;
+
+	return 0;
+}
+
+static int pcie_phy_wait_ack(void __iomem *dbi_base, int addr)
+{
+	u32 val;
+
+	val = addr << PCIE_PHY_CTRL_DATA_LOC;
+	writel(val, dbi_base + PCIE_PHY_CTRL);
+
+	val |= (0x1 << PCIE_PHY_CTRL_CAP_ADR_LOC);
+	writel(val, dbi_base + PCIE_PHY_CTRL);
+
+	if (pcie_phy_poll_ack(dbi_base, 100, 1))
+		return -1;
+
+	val = addr << PCIE_PHY_CTRL_DATA_LOC;
+	writel(val, dbi_base + PCIE_PHY_CTRL);
+
+	if (pcie_phy_poll_ack(dbi_base, 100, 0))
+		return -1;
+
+	return 0;
+}
+
+/* Read from the 16-bt PCIe PHY control registers (not memory-mapped) */
+static int pcie_phy_read(void __iomem *dbi_base, int addr , int *data)
+{
+	u32 val, phy_ctl;
+
+	if (pcie_phy_wait_ack(dbi_base, addr))
+		return -1;
+
+	/* assert Read signal */
+	phy_ctl = 0x1 << PCIE_PHY_CTRL_RD_LOC;
+	writel(phy_ctl, dbi_base + PCIE_PHY_CTRL);
+
+	if (pcie_phy_poll_ack(dbi_base, 100, 1))
+		return -1;
+
+	val = readl(dbi_base + PCIE_PHY_STAT);
+	*data = (val & (0xffff << PCIE_PHY_STAT_DATA_LOC));
+
+	/* deassert Read signal */
+	writel(0x00, dbi_base + PCIE_PHY_CTRL);
+
+	if (pcie_phy_poll_ack(dbi_base, 100, 0))
+		return -1;
+
+	return 0;
+}
+
+static int pcie_phy_write(void __iomem *dbi_base, int addr, int data)
+{
+	u32 var;
+
+	/* write addr */
+	/* cap addr */
+	if (pcie_phy_wait_ack(dbi_base, addr))
+		return -1;
+
+	var = data << PCIE_PHY_CTRL_DATA_LOC;
+	writel(var, dbi_base + PCIE_PHY_CTRL);
+
+	/* capture data */
+	var |= (0x1 << PCIE_PHY_CTRL_CAP_DAT_LOC);
+	writel(var, dbi_base + PCIE_PHY_CTRL);
+
+	/* wait for ack */
+	if (pcie_phy_poll_ack(dbi_base, 100, 1))
+		return -1;
+
+	/* deassert cap data */
+	var = data << PCIE_PHY_CTRL_DATA_LOC;
+	writel(var, dbi_base + PCIE_PHY_CTRL);
+
+	/* wait for ack de-assetion */
+	if (pcie_phy_poll_ack(dbi_base, 100, 0))
+		return -1;
+
+	/* assert wr signal */
+	var = 0x1 << PCIE_PHY_CTRL_WR_LOC;
+	writel(var, dbi_base + PCIE_PHY_CTRL);
+
+	/* wait for ack */
+	if (pcie_phy_poll_ack(dbi_base, 100, 1))
+		return -1;
+
+	/* deassert wr signal */
+	var = data << PCIE_PHY_CTRL_DATA_LOC;
+	writel(var, dbi_base + PCIE_PHY_CTRL);
+
+	/* wait for ack de-assetion */
+	if (pcie_phy_poll_ack(dbi_base, 100, 0))
+		return -1;
+
+	writel(0x0, dbi_base + PCIE_PHY_CTRL);
+
+	return 0;
+}
+
+static int imx6_pcie_assert_core_reset(struct pcie_port *pp)
+{
+	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
+	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+			IMX6Q_GPR1_PCIE_TEST_PD, 1 << 18);
+	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+			IMX6Q_GPR12_PCIE_CTL_2, 1 << 10);
+	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+			IMX6Q_GPR1_PCIE_REF_CLK_EN, 0 << 16);
+
+	gpio_set_value(imx6_pcie->reset_gpio, 0);
+	msleep(100);
+	gpio_set_value(imx6_pcie->reset_gpio, 1);
+
+	return 0;
+}
+
+static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
+{
+	int ret;
+	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
+
+	if (imx6_pcie->power_on_gpio >= 0)
+		gpio_set_value(imx6_pcie->power_on_gpio, IMX6_POWER_ON);
+
+	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+			IMX6Q_GPR1_PCIE_TEST_PD, 0 << 18);
+	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+			IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
+
+	ret = clk_set_parent(imx6_pcie->lvds1_sel, imx6_pcie->sata_ref);
+	if (ret) {
+		dev_err(pp->dev, "unable to set lvds1_gate parent\n");
+		goto err_set_parent;
+	}
+
+	ret = clk_prepare_enable(imx6_pcie->pcie_ref_125m);
+	if (ret) {
+		dev_err(pp->dev, "unable to enable pcie_ref_125m\n");
+		goto err_pcie_ref;
+	}
+
+	ret = clk_prepare_enable(imx6_pcie->lvds1_gate);
+	if (ret) {
+		dev_err(pp->dev, "unable to enable lvds1_gate\n");
+		goto err_lvds1_gate;
+	}
+
+	ret = clk_prepare_enable(imx6_pcie->pcie_axi);
+	if (ret) {
+		dev_err(pp->dev, "unable to enable pcie_axi\n");
+		goto err_pcie_axi;
+	}
+
+	/* allow the clocks to stabilize */
+	usleep_range(100, 200);
+
+	return 0;
+
+err_pcie_axi:
+	clk_disable(imx6_pcie->lvds1_gate);
+err_lvds1_gate:
+	clk_disable(imx6_pcie->pcie_ref_125m);
+err_pcie_ref:
+err_set_parent:
+	return ret;
+}
+
+static void imx6_pcie_init_phy(struct pcie_port *pp)
+{
+	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
+
+	/* FIXME the field name should be aligned to RM */
+	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+			IMX6Q_GPR12_PCIE_CTL_2, 0 << 10);
+
+	/* configure constant input signal to the pcie ctrl and phy */
+	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+			IMX6Q_GPR12_DEVICE_TYPE, PCI_EXP_TYPE_ROOT_PORT << 12);
+	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+			IMX6Q_GPR12_LOS_LEVEL, 9 << 4);
+
+	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
+			IMX6Q_GPR8_TX_DEEMPH_GEN1, 0 << 0);
+	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
+			IMX6Q_GPR8_TX_DEEMPH_GEN2_3P5DB, 0 << 6);
+	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
+			IMX6Q_GPR8_TX_DEEMPH_GEN2_6DB, 20 << 12);
+	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
+			IMX6Q_GPR8_TX_SWING_FULL, 127 << 18);
+	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
+			IMX6Q_GPR8_TX_SWING_LOW, 127 << 25);
+}
+
+static void imx6_pcie_host_init(struct pcie_port *pp)
+{
+	int count = 0;
+	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
+
+	imx6_pcie_assert_core_reset(pp);
+
+	imx6_pcie_init_phy(pp);
+
+	imx6_pcie_deassert_core_reset(pp);
+
+	dw_pcie_setup_rc(pp);
+
+	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+			IMX6Q_GPR12_PCIE_CTL_2, 1 << 10);
+
+	while (!dw_pcie_link_up(pp)) {
+		mdelay(100);
+		count++;
+		if (count >= 10) {
+			dev_err(pp->dev, "phy link never came up\n");
+			dev_dbg(pp->dev,"DEBUG_R0: 0x%08x, DEBUG_R1: 0x%08x\n",
+				readl(pp->dbi_base + PCIE_PHY_DEBUG_R0),
+				readl(pp->dbi_base + PCIE_PHY_DEBUG_R1));
+			return;
+		}
+	}
+
+	return;
+}
+
+static int imx6_pcie_link_up(struct pcie_port *pp)
+{
+	u32 rc, ltssm, rx_valid, temp;
+
+	/* link is debug bit 36, debug register 1 starts at bit 32 */
+	rc = readl(pp->dbi_base + PCIE_PHY_DEBUG_R1) & (0x1 << (36 - 32));
+	if (rc)
+		return -1;
+
+	/* From L0, initiate MAC entry to gen2 if EP/RC supports gen2.
+	 * Wait 2ms (LTSSM timeout is 24ms, PHY lock is ~5us in gen2).
+	 * If (MAC/LTSSM.state == Recovery.RcvrLock)
+	 * && (PHY/rx_valid==0) then pulse PHY/rx_reset. Transition
+	 * to gen2 is stuck
+	 */
+	pcie_phy_read(pp->dbi_base, PCIE_PHY_RX_ASIC_OUT, &rx_valid);
+	ltssm = readl(pp->dbi_base + PCIE_PHY_DEBUG_R0) & 0x3F;
+
+	if (rx_valid & 0x01)
+		return 0;
+
+	if (ltssm != 0x0d)
+		return 0;
+
+	dev_err(pp->dev,
+		"transition to gen2 is stuck, reset PHY!\n");
+
+	pcie_phy_read(pp->dbi_base,
+		PHY_RX_OVRD_IN_LO, &temp);
+	temp |= (PHY_RX_OVRD_IN_LO_RX_DATA_EN
+		| PHY_RX_OVRD_IN_LO_RX_PLL_EN);
+	pcie_phy_write(pp->dbi_base,
+		PHY_RX_OVRD_IN_LO, temp);
+
+	usleep_range(2000, 3000);
+
+	pcie_phy_read(pp->dbi_base,
+		PHY_RX_OVRD_IN_LO, &temp);
+	temp &= ~(PHY_RX_OVRD_IN_LO_RX_DATA_EN
+		| PHY_RX_OVRD_IN_LO_RX_PLL_EN);
+	pcie_phy_write(pp->dbi_base,
+		PHY_RX_OVRD_IN_LO, temp);
+
+	return 0;
+}
+
+static struct pcie_host_ops imx6_pcie_host_ops = {
+	.link_up = imx6_pcie_link_up,
+	.host_init = imx6_pcie_host_init,
+};
+
+static int add_pcie_port(struct pcie_port *pp, struct platform_device *pdev)
+{
+	int ret;
+
+	pp->irq = platform_get_irq(pdev, 0);
+	if (!pp->irq) {
+		dev_err(&pdev->dev, "failed to get irq\n");
+		return -ENODEV;
+	}
+
+	pp->root_bus_nr = -1;
+	pp->ops = &imx6_pcie_host_ops;
+
+	spin_lock_init(&pp->conf_lock);
+	ret = dw_pcie_host_init(pp);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to initialize host\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int __init imx6_pcie_probe(struct platform_device *pdev)
+{
+	struct imx6_pcie *imx6_pcie;
+	struct pcie_port *pp;
+	struct device_node *np = pdev->dev.of_node;
+	struct resource *dbi_base;
+	int ret;
+
+	imx6_pcie = devm_kzalloc(&pdev->dev, sizeof(*imx6_pcie),
+				GFP_KERNEL);
+	if (!imx6_pcie)
+		return -ENOMEM;
+
+	pp = &imx6_pcie->pp;
+	pp->dev = &pdev->dev;
+
+	dbi_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!dbi_base) {
+		dev_err(&pdev->dev, "dbi_base memory resource not found\n");
+		return -ENODEV;
+	}
+
+	pp->dbi_base = devm_request_and_ioremap(&pdev->dev, dbi_base);
+	if (IS_ERR(pp->dbi_base)) {
+		dev_err(&pdev->dev, "unable to remap dbi_base\n");
+		ret = PTR_ERR(pp->dbi_base);
+		goto err;
+	}
+
+	/* Fetch GPIOs */
+	imx6_pcie->reset_gpio = of_get_named_gpio(np, "reset-gpio", 0);
+	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
+		ret = devm_gpio_request_one(&pdev->dev,
+					imx6_pcie->reset_gpio,
+					GPIOF_OUT_INIT_LOW,
+					"PCIe reset");
+		if (ret) {
+			dev_err(&pdev->dev, "unable to get reset line\n");
+			goto err;
+		}
+	}
+
+	imx6_pcie->power_on_gpio = of_get_named_gpio(np, "power-on-gpio", 0);
+	if (gpio_is_valid(imx6_pcie->power_on_gpio))
+		devm_gpio_request_one(&pdev->dev, imx6_pcie->power_on_gpio,
+				    GPIOF_OUT_INIT_LOW,
+				    "PCIe power enable");
+
+	imx6_pcie->wake_up_gpio = of_get_named_gpio(np, "wake-up-gpio", 0);
+	if (gpio_is_valid(imx6_pcie->wake_up_gpio))
+		devm_gpio_request_one(&pdev->dev, imx6_pcie->wake_up_gpio,
+				    GPIOF_IN,
+				    "PCIe wake up");
+
+	imx6_pcie->disable_gpio = of_get_named_gpio(np, "disable-gpio", 0);
+	if (gpio_is_valid(imx6_pcie->disable_gpio))
+		devm_gpio_request_one(&pdev->dev, imx6_pcie->disable_gpio,
+				    GPIOF_OUT_INIT_HIGH,
+				    "PCIe disable endpoint");
+
+	/* Fetch clocks */
+	imx6_pcie->lvds1_sel = clk_get(&pdev->dev, "lvds1_sel");
+	if (IS_ERR(imx6_pcie->lvds1_sel)) {
+		dev_err(&pdev->dev,
+			"lvds1_sel clock missing or invalid\n");
+		ret = PTR_ERR(imx6_pcie->lvds1_sel);
+		goto err;
+	}
+
+	imx6_pcie->lvds1_gate = clk_get(&pdev->dev, "lvds1_gate");
+	if (IS_ERR(imx6_pcie->lvds1_gate)) {
+		dev_err(&pdev->dev,
+			"lvds1_gate clock select missing or invalid\n");
+		ret = PTR_ERR(imx6_pcie->lvds1_gate);
+		goto err;
+	}
+
+	imx6_pcie->pcie_ref_125m = clk_get(&pdev->dev, "pcie_ref_125m");
+	if (IS_ERR(imx6_pcie->pcie_ref_125m)) {
+		dev_err(&pdev->dev,
+			"pcie_ref_125m clock source missing or invalid\n");
+		ret = PTR_ERR(imx6_pcie->pcie_ref_125m);
+		goto err;
+	}
+
+	imx6_pcie->pcie_axi = clk_get(&pdev->dev, "pcie_axi");
+	if (IS_ERR(imx6_pcie->pcie_axi)) {
+		dev_err(&pdev->dev,
+			"pcie_axi clock source missing or invalid\n");
+		ret = PTR_ERR(imx6_pcie->pcie_axi);
+		goto err;
+	}
+
+	imx6_pcie->sata_ref = clk_get(&pdev->dev, "sata_ref");
+	if (IS_ERR(imx6_pcie->sata_ref)) {
+		dev_err(&pdev->dev,
+			"sata_ref clock source missing or invalid\n");
+		ret = PTR_ERR(imx6_pcie->sata_ref);
+		goto err;
+	}
+
+	/* Grab GPR config register range */
+	imx6_pcie->iomuxc_gpr =
+		 syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
+	if (IS_ERR(imx6_pcie->iomuxc_gpr)) {
+		dev_err(&pdev->dev, "unable to find iomuxc registers\n");
+		ret = PTR_ERR(imx6_pcie->iomuxc_gpr);
+		goto err;
+	}
+
+	ret = add_pcie_port(pp, pdev);
+	if (ret < 0)
+		goto err;
+
+	platform_set_drvdata(pdev, imx6_pcie);
+	return 0;
+
+err:
+	return ret;
+}
+
+static int __exit imx6_pcie_remove(struct platform_device *pdev)
+{
+	struct imx6_pcie *imx6_pcie = platform_get_drvdata(pdev);
+
+	clk_disable_unprepare(imx6_pcie->pcie_axi);
+	clk_disable_unprepare(imx6_pcie->lvds1_gate);
+	clk_disable_unprepare(imx6_pcie->pcie_ref_125m);
+
+	return 0;
+}
+
+static const struct of_device_id imx6_pcie_of_match[] = {
+	{ .compatible = "fsl,imx6-pcie", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, imx6_pcie_of_match);
+
+static struct platform_driver imx6_pcie_driver = {
+	.remove		= __exit_p(imx6_pcie_remove),
+	.driver = {
+		.name	= "imx6-pcie",
+		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(imx6_pcie_of_match),
+	},
+};
+
+/* Freescale PCIe driver does not allow module unload */
+
+static int __init pcie_init(void)
+{
+	return platform_driver_probe(&imx6_pcie_driver, imx6_pcie_probe);
+}
+subsys_initcall(pcie_init);
+
+MODULE_AUTHOR("Sean Cross <xobs@kosagi.com>");
+MODULE_DESCRIPTION("Freescale i.MX6 PCIe host controller driver");
+MODULE_LICENSE("GPL v2");
-- 
1.7.9.5

