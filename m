Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:52528 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752894AbcJUCCI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Oct 2016 22:02:08 -0400
From: Ruqiang Ju <juruqiang@huawei.com>
To: <bhelgaas@google.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bin.chen@linaro.org>,
        <elder@linaro.org>, <hermit.wangheming@hisilicon.com>,
        <yanhaifeng@hisilicon.com>, <xuejiancheng@hisilicon.com>,
        Ruqiang Ju <juruqiang@huawei.com>
Subject: [PATCH 1/2] PCI: hisi: add PCIe driver support for HiSilicon STB SoCs
Date: Fri, 21 Oct 2016 09:45:36 +0800
Message-ID: <1477014336-12385-1-git-send-email-juruqiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add PCIe controller drvier for HiSilicon STB SoCs,
the controller is based on the DesignWare's PCIe core.

Signed-off-by: Ruqiang Ju <juruqiang@huawei.com>
---
 .../bindings/pci/hisilicon-histb-pcie.txt          |  66 +++
 drivers/pci/host/Kconfig                           |   8 +
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pcie-histb.c                      | 448 +++++++++++++++++++++
 4 files changed, 523 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/hisilicon-histb-pcie.txt
 create mode 100644 drivers/pci/host/pcie-histb.c

diff --git a/Documentation/devicetree/bindings/pci/hisilicon-histb-pcie.txt b/Documentation/devicetree/bindings/pci/hisilicon-histb-pcie.txt
new file mode 100644
index 0000000..952f1db
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/hisilicon-histb-pcie.txt
@@ -0,0 +1,66 @@
+HiSilicon STB PCIe host bridge DT description
+
+HiSilicon PCIe host controller is based on Designware PCI core.
+It shares common functions with PCIe Designware core driver and inherits
+common properties defined in
+Documentation/devicetree/bindings/pci/designware-pci.txt.
+
+Additional properties are described here:
+
+Required properties
+- compatible: Should be one of the following strings
+		 "hisilicon,histb-pcie",
+		 "hisilicon,hi3798cv200-pcie"
+- reg: Should contain sysctl, rc_dbi, config registers location and length.
+- reg-names: Must include the following entries:
+  "sysctrl": system control registers of PCIe controller;
+  "rc_dbi": configuration space of PCIe controller;
+  "config": configuration transaction space of PCIe controller.
+- interrupts: MSI interrupt.
+- interrupt-names: Must include "msi" entries.
+- clocks: List of phandle and clock specifier pairs as listed
+		in clock-names property.
+- clock-name: Must include the following entries:
+  "aux_clk": auxiliary gate clock;
+  "pipe_clk": pipe gate clock;
+  "sys_clk": sys gate clock;
+  "bus_clk": bus gate clock.
+- resets: List of phandle and reset specifier pairs as listed
+			in reset-names property
+- reset-names: Must include the following entries:
+  "soft_reset": soft reset;
+  "sys_reset": sys reset;
+  "bus_rest": bus reset.
+
+Optional properties:
+- power-gpios: pcie device power control gpio if needed;
+- power-gpios-active-high: must include this propty
+		if active level is high.
+- status: Either "ok" or "disabled".
+
+Example:
+	pcie@f9860000 {
+		compatible = "hisilicon,histb-pcie", "snps,dw-pcie";
+		reg = <0xf9860000 0x1000>,
+			<0xf0000000 0x2000>,
+			<0xf2000000 0x01000000>;
+		reg-names = "sysctrl", "rc_dbi", "config";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		device_type = "pci";
+		num-lanes = <1>;
+		ranges=<0x81000000 0 0 0xf4000000 0 0x00010000
+			0x82000000 0 0xf3000000 0xf3000000 0 0x01000000>;
+		interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "msi";
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0x0 0 0 1 &gic 0 131 4>;
+		clocks = <&crg PCIE_AUX_CLK>,
+			 <&crg PCIE_PIPE_CLK>,
+			 <&crg PCIE_SYS_CLK>,
+			 <&crg PCIE_BUS_CLK>;
+		clock-names = "aux_clk", "pipe_clk", "sys_clk", "bus_clk";
+		resets = <&crg 0x18c 6>, <&crg 0x18c 5>, <&crg 0x18c 4>;
+		reset-names = "soft_reset", "sys_reset", "bus_reset";
+	};
diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index d7e7c0a..57ce4df 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -227,6 +227,14 @@ config PCI_HISI
 	  Say Y here if you want PCIe controller support on HiSilicon
 	  Hip05 and Hip06 SoCs
 
+config PCIE_HISI_STB
+	depends on OF
+	bool "HiSilicon STB SoCs PCIe controllers"
+	select PCIEPORTBUS
+	select PCIE_DW
+	help
+	  Say Y here if you want PCIe controller support on HiSilicon STB SoCs
+
 config PCIE_QCOM
 	bool "Qualcomm PCIe controller"
 	depends on ARCH_QCOM && OF
diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
index 084cb49..55f4fe7 100644
--- a/drivers/pci/host/Makefile
+++ b/drivers/pci/host/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_PCIE_IPROC_BCMA) += pcie-iproc-bcma.o
 obj-$(CONFIG_PCIE_ALTERA) += pcie-altera.o
 obj-$(CONFIG_PCIE_ALTERA_MSI) += pcie-altera-msi.o
 obj-$(CONFIG_PCI_HISI) += pcie-hisi.o
+obj-$(CONFIG_PCIE_HISI_STB) += pcie-histb.o
 obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o
 obj-$(CONFIG_PCI_HOST_THUNDER_ECAM) += pci-thunder-ecam.o
 obj-$(CONFIG_PCI_HOST_THUNDER_PEM) += pci-thunder-pem.o
diff --git a/drivers/pci/host/pcie-histb.c b/drivers/pci/host/pcie-histb.c
new file mode 100644
index 0000000..71e344f
--- /dev/null
+++ b/drivers/pci/host/pcie-histb.c
@@ -0,0 +1,448 @@
+/*
+ * PCIe host controller driver for HiSilicon STB SoCs
+ *
+ * Copyright (C) 2016 HiSilicon Co., Ltd. http://www.hisilicon.com
+ *
+ * Authors: RuQiang Ju <juruqiang@huawei.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/resource.h>
+#include <linux/reset.h>
+
+#include "pcie-designware.h"
+
+#define PCIE_SYS_CTRL0			0x0000
+#define PCIE_SYS_CTRL1			0x0004
+#define PCIE_SYS_CTRL7			0x001C
+#define PCIE_SYS_CTRL13			0x0034
+#define PCIE_SYS_CTRL15			0x003c
+#define PCIE_SYS_CTRL16			0x0040
+#define PCIE_SYS_CTRL17			0x0044
+
+#define PCIE_SYS_STAT0			0x0100
+#define PCIE_SYS_STAT4			0x0110
+
+#define PCIE_RDLH_LINK_UP		BIT(5)
+#define PCIE_XMLH_LINK_UP		BIT(15)
+#define PCIE_ELBI_SLV_DBI_ENABLE	BIT(21)
+#define PCIE_APP_LTSSM_ENABLE		BIT(11)
+
+#define PCIE_DEVICE_TYPE_MASK		GENMASK(31, 28)
+#define PCIE_WM_EP			0
+#define PCIE_WM_LEGACY			BIT(1)
+#define PCIE_WM_RC			BIT(30)
+
+#define PCIE_LTSSM_STATE_MASK		GENMASK(5, 0)
+#define PCIE_LTSSM_STATE_ACTIVE		0x11
+
+struct histb_pcie_host {
+	void __iomem *sysctrl;
+	int power_gpio;
+	bool gpio_active_high;
+	struct clk *aux_clk;
+	struct clk *pipe_clk;
+	struct clk *sys_clk;
+	struct clk *bus_clk;
+	struct reset_control *soft_reset;
+	struct reset_control *sys_reset;
+	struct reset_control *bus_reset;
+	struct pcie_port pp;
+};
+
+#define to_histb_pcie(x) container_of(x, struct histb_pcie_host, pp)
+
+static void histb_pcie_dbi_w_mode(struct pcie_port *pp, bool enable)
+{
+	struct histb_pcie_host *hipcie = to_histb_pcie(pp);
+	u32 val;
+
+	if (enable) {
+		val = readl(hipcie->sysctrl + PCIE_SYS_CTRL0);
+		val |= PCIE_ELBI_SLV_DBI_ENABLE;
+		writel(val, hipcie->sysctrl + PCIE_SYS_CTRL0);
+	} else {
+		val = readl(hipcie->sysctrl + PCIE_SYS_CTRL0);
+		val &= ~PCIE_ELBI_SLV_DBI_ENABLE;
+		writel(val, hipcie->sysctrl + PCIE_SYS_CTRL0);
+	}
+}
+
+static void histb_pcie_dbi_r_mode(struct pcie_port *pp, bool enable)
+{
+	struct histb_pcie_host *hipcie = to_histb_pcie(pp);
+	u32 val;
+
+	if (enable) {
+		val = readl(hipcie->sysctrl + PCIE_SYS_CTRL1);
+		val |= PCIE_ELBI_SLV_DBI_ENABLE;
+		writel(val, hipcie->sysctrl + PCIE_SYS_CTRL1);
+	} else {
+		val = readl(hipcie->sysctrl + PCIE_SYS_CTRL1);
+		val &= ~PCIE_ELBI_SLV_DBI_ENABLE;
+		writel(val, hipcie->sysctrl + PCIE_SYS_CTRL1);
+	}
+}
+
+static inline u32 histb_pcie_readl_rc(struct pcie_port *pp, u32 reg)
+{
+	u32 val;
+
+	histb_pcie_dbi_r_mode(pp, true);
+	val = readl(pp->dbi_base + reg);
+	histb_pcie_dbi_r_mode(pp, false);
+
+	return val;
+}
+
+static inline void histb_pcie_writel_rc(struct pcie_port *pp,
+					u32 reg, u32 val)
+{
+	histb_pcie_dbi_w_mode(pp, true);
+	writel(val, pp->dbi_base + reg);
+	histb_pcie_dbi_w_mode(pp, false);
+}
+
+static int histb_pcie_rd_own_conf(struct pcie_port *pp,
+	int where, int size, u32 *val)
+{
+	int ret;
+
+	histb_pcie_dbi_r_mode(pp, true);
+	ret = dw_pcie_cfg_read(pp->dbi_base + where, size, val);
+	histb_pcie_dbi_r_mode(pp, false);
+
+	return ret;
+}
+
+static int histb_pcie_wr_own_conf(struct pcie_port *pp,
+	int where, int size, u32 val)
+{
+	int ret;
+
+	histb_pcie_dbi_w_mode(pp, true);
+	ret = dw_pcie_cfg_write(pp->dbi_base + where, size, val);
+	histb_pcie_dbi_w_mode(pp, false);
+
+	return ret;
+}
+
+static int histb_pcie_link_up(struct pcie_port *pp)
+{
+	struct histb_pcie_host *hipcie = to_histb_pcie(pp);
+	u32 regval;
+	u32 status;
+
+	regval = readl(hipcie->sysctrl + PCIE_SYS_STAT0);
+	status = readl(hipcie->sysctrl + PCIE_SYS_STAT4);
+	status &= PCIE_LTSSM_STATE_MASK;
+	if ((regval & PCIE_XMLH_LINK_UP) &&
+		(regval & PCIE_RDLH_LINK_UP) &&
+		(status == PCIE_LTSSM_STATE_ACTIVE))
+		return 1;
+
+	return 0;
+}
+
+static int histb_pcie_establish_link(struct pcie_port *pp)
+{
+	struct histb_pcie_host *hipcie = to_histb_pcie(pp);
+	u32 regval;
+	int count = 0;
+
+	if (dw_pcie_link_up(pp)) {
+		dev_err(pp->dev, "Link already up\n");
+		return 0;
+	}
+
+	/* PCIe RC work mode */
+	regval = readl(hipcie->sysctrl + PCIE_SYS_CTRL0);
+	regval &= ~PCIE_DEVICE_TYPE_MASK;
+	regval |= PCIE_WM_RC;
+	writel(regval, hipcie->sysctrl + PCIE_SYS_CTRL0);
+
+	/* setup root complex */
+	dw_pcie_setup_rc(pp);
+
+	/* assert LTSSM enable */
+	regval = readl(hipcie->sysctrl + PCIE_SYS_CTRL7);
+	regval |= PCIE_APP_LTSSM_ENABLE;
+	writel(regval,  hipcie->sysctrl + PCIE_SYS_CTRL7);
+
+	/* check if the link is up or not */
+	while (!dw_pcie_link_up(pp)) {
+		mdelay(10);
+		count++;
+		if (count == 50) {
+			dev_err(pp->dev, "PCIe Link Fail\n");
+			return -EINVAL;
+		}
+	}
+
+	dev_info(pp->dev, "Link up\n");
+
+	return 0;
+}
+
+static void histb_pcie_host_init(struct pcie_port *pp)
+{
+	histb_pcie_establish_link(pp);
+
+	if (IS_ENABLED(CONFIG_PCI_MSI))
+		dw_pcie_msi_init(pp);
+}
+
+static struct pcie_host_ops histb_pcie_host_ops = {
+	.readl_rc = histb_pcie_readl_rc,
+	.writel_rc = histb_pcie_writel_rc,
+	.rd_own_conf = histb_pcie_rd_own_conf,
+	.wr_own_conf = histb_pcie_wr_own_conf,
+	.link_up = histb_pcie_link_up,
+	.host_init = histb_pcie_host_init,
+};
+
+#ifdef CONFIG_PCI_MSI
+static irqreturn_t histb_pcie_msi_irq_handler(int irq, void *arg)
+{
+	struct pcie_port *pp = arg;
+
+	return dw_handle_msi_irq(pp);
+}
+#endif
+
+static void histb_pcie_host_disable(struct histb_pcie_host *hipcie)
+{
+	reset_control_assert(hipcie->soft_reset);
+	reset_control_assert(hipcie->sys_reset);
+	reset_control_assert(hipcie->bus_reset);
+
+	clk_disable_unprepare(hipcie->aux_clk);
+	clk_disable_unprepare(hipcie->pipe_clk);
+	clk_disable_unprepare(hipcie->sys_clk);
+	clk_disable_unprepare(hipcie->bus_clk);
+
+	if (gpio_is_valid(hipcie->power_gpio))
+		gpio_set_value_cansleep(hipcie->power_gpio,
+					!hipcie->gpio_active_high);
+}
+
+static int histb_pcie_host_enable(struct pcie_port *pp)
+{
+	struct histb_pcie_host *hipcie = to_histb_pcie(pp);
+	struct device *dev = pp->dev;
+	int ret;
+
+	/* power on pcie device if have */
+	if (gpio_is_valid(hipcie->power_gpio))
+		gpio_set_value_cansleep(hipcie->power_gpio,
+					hipcie->gpio_active_high);
+
+	ret = clk_prepare_enable(hipcie->bus_clk);
+	if (ret) {
+		dev_err(dev, "cannot prepare/enable bus_clk\n");
+		goto err_bus_clk;
+	}
+	ret = clk_prepare_enable(hipcie->sys_clk);
+	if (ret) {
+		dev_err(dev, "cannot prepare/enable sys_clk\n");
+		goto err_sys_clk;
+	}
+	ret = clk_prepare_enable(hipcie->pipe_clk);
+	if (ret) {
+		dev_err(dev, "cannot prepare/enable pipe_clk\n");
+		goto err_pipe_clk;
+	}
+	ret = clk_prepare_enable(hipcie->aux_clk);
+	if (ret) {
+		dev_err(dev, "cannot prepare/enable aux_clk\n");
+		goto err_aux_clk;
+	}
+
+	reset_control_assert(hipcie->soft_reset);
+	reset_control_deassert(hipcie->soft_reset);
+
+	reset_control_assert(hipcie->sys_reset);
+	reset_control_deassert(hipcie->sys_reset);
+
+	reset_control_assert(hipcie->bus_reset);
+	reset_control_deassert(hipcie->bus_reset);
+
+	return 0;
+
+err_aux_clk:
+	clk_disable_unprepare(hipcie->aux_clk);
+err_pipe_clk:
+	clk_disable_unprepare(hipcie->pipe_clk);
+err_sys_clk:
+	clk_disable_unprepare(hipcie->sys_clk);
+err_bus_clk:
+	clk_disable_unprepare(hipcie->bus_clk);
+
+	return ret;
+}
+
+
+static int histb_pcie_probe(struct platform_device *pdev)
+{
+	struct histb_pcie_host *hipcie;
+	struct pcie_port *pp;
+	struct resource *res;
+	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	hipcie = devm_kzalloc(dev, sizeof(*hipcie), GFP_KERNEL);
+	if (!hipcie)
+		return -ENOMEM;
+
+	pp = &hipcie->pp;
+	pp->dev = dev;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "sysctrl");
+	hipcie->sysctrl = devm_ioremap_resource(dev, res);
+	if (IS_ERR(hipcie->sysctrl)) {
+		dev_err(dev, "cannot get sysctrl base\n");
+		return PTR_ERR(hipcie->sysctrl);
+	}
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "rc_dbi");
+	pp->dbi_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(pp->dbi_base)) {
+		dev_err(dev, "cannot get rc_dbi base\n");
+		return PTR_ERR(pp->dbi_base);
+	}
+
+	hipcie->power_gpio = of_get_named_gpio(np, "power-gpios", 0);
+	hipcie->gpio_active_high = of_property_read_bool(np,
+						"power-gpios-active-high");
+	if (gpio_is_valid(hipcie->power_gpio)) {
+		ret = devm_gpio_request_one(dev, hipcie->power_gpio,
+				hipcie->gpio_active_high ?
+					GPIOF_OUT_INIT_HIGH :
+					GPIOF_OUT_INIT_LOW,
+					"PCIe Dev power");
+		if (ret) {
+			dev_err(dev, "unable to request gpio\n");
+			return ret;
+		}
+	}
+
+	hipcie->aux_clk = devm_clk_get(dev, "aux_clk");
+	if (IS_ERR(hipcie->aux_clk)) {
+		dev_err(dev, "Failed to get pcie aux_clk clock\n");
+		return PTR_ERR(hipcie->aux_clk);
+	}
+
+	hipcie->pipe_clk = devm_clk_get(dev, "pipe_clk");
+	if (IS_ERR(hipcie->pipe_clk)) {
+		dev_err(dev, "Failed to get pcie pipe_clk clock\n");
+		return PTR_ERR(hipcie->pipe_clk);
+	}
+
+	hipcie->sys_clk = devm_clk_get(dev, "sys_clk");
+	if (IS_ERR(hipcie->sys_clk)) {
+		dev_err(dev, "Failed to get pcie sys_clk clock\n");
+		return PTR_ERR(hipcie->sys_clk);
+	}
+
+	hipcie->bus_clk = devm_clk_get(dev, "bus_clk");
+	if (IS_ERR(hipcie->bus_clk)) {
+		dev_err(dev, "Failed to get pcie bus_clk clock\n");
+		return PTR_ERR(hipcie->bus_clk);
+	}
+
+	hipcie->soft_reset = devm_reset_control_get(dev, "soft_reset");
+	if (IS_ERR(hipcie->soft_reset)) {
+		dev_err(dev, "couldn't get soft_reset\n");
+		return PTR_ERR(hipcie->soft_reset);
+	}
+
+	hipcie->sys_reset = devm_reset_control_get(dev, "sys_reset");
+	if (IS_ERR(hipcie->sys_reset)) {
+		dev_err(dev, "couldn't get sys_reset\n");
+		return PTR_ERR(hipcie->sys_reset);
+	}
+
+	hipcie->bus_reset = devm_reset_control_get(dev, "bus_reset");
+	if (IS_ERR(hipcie->bus_reset)) {
+		dev_err(dev, "couldn't get bus_reset\n");
+		return PTR_ERR(hipcie->bus_reset);
+	}
+
+	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+		pp->msi_irq = platform_get_irq_byname(pdev, "msi");
+		if (pp->msi_irq < 0) {
+			dev_err(dev, "Failed to get msi irq\n");
+			return pp->msi_irq;
+		}
+		ret = devm_request_irq(dev, pp->msi_irq,
+				       histb_pcie_msi_irq_handler,
+				       IRQF_SHARED, "histb-pcie-msi", pp);
+		if (ret) {
+			dev_err(dev, "cannot request msi irq\n");
+			return ret;
+		}
+	}
+
+	pp->root_bus_nr = -1;
+	pp->ops = &histb_pcie_host_ops;
+
+	ret = histb_pcie_host_enable(pp);
+	if (ret) {
+		dev_err(dev, "failed to enable host\n");
+		return ret;
+	}
+
+	ret = dw_pcie_host_init(pp);
+	if (ret) {
+		dev_err(dev, "failed to initialize host\n");
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, hipcie);
+
+	return 0;
+}
+
+static int histb_pcie_remove(struct platform_device *pdev)
+{
+	struct histb_pcie_host *hipcie = platform_get_drvdata(pdev);
+
+	histb_pcie_host_disable(hipcie);
+
+	return 0;
+}
+
+static const struct of_device_id histb_pcie_of_match[] = {
+	{ .compatible = "hisilicon,histb-pcie", },
+	{ .compatible = "hisilicon,hi3798cv200-pcie", },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, histb_pcie_of_match);
+
+static struct platform_driver histb_pcie_platform_driver = {
+	.probe	= histb_pcie_probe,
+	.remove	= histb_pcie_remove,
+	.driver = {
+		.name = "histb-pcie",
+		.of_match_table = of_match_ptr(histb_pcie_of_match),
+	},
+};
+
+module_platform_driver(histb_pcie_platform_driver);
+
+MODULE_AUTHOR("RuQiang Ju <juruqiang@huawei.com>");
+MODULE_DESCRIPTION("HiSilicon STB PCIe host controller driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1

