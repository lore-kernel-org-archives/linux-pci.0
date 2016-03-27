Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:39008 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753305AbcC0JbV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 27 Mar 2016 05:31:21 -0400
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Kumar Gala <galak@codeaurora.org>
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Hanna Hawa <hannah@marvell.com>,
	linux-arm-kernel@lists.infradead.org,
	Yehuda Yitschak <yehuday@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH 2/2] pci: host: new driver for Marvell Armada 7K/8K PCIe controller
Date: Sun, 27 Mar 2016 11:30:58 +0200
Message-Id: <1459071058-18328-3-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1459071058-18328-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1459071058-18328-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Marvell Armada 7K/8K SoCs integrate a PCIe controller from
Synopsys. This commit adds a new driver that provides the small glue
needed to use the existing Designware driver to make it work on
Marvell Armada 7K/8K SoCs.

The MSI support will be enabled at a later point.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/pci/host/Kconfig         |  11 ++
 drivers/pci/host/Makefile        |   1 +
 drivers/pci/host/pcie-armada8k.c | 261 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 273 insertions(+)
 create mode 100644 drivers/pci/host/pcie-armada8k.c

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 7a0780d..a3b6f24 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -231,4 +231,15 @@ config PCI_HOST_THUNDER_ECAM
 	help
 	  Say Y here if you want ECAM support for CN88XX-Pass-1.x Cavium Thunder SoCs.
 
+config PCIE_ARMADA_8K
+	bool "Marvell Armada-8K PCIe controller"
+	depends on ARCH_MVEBU
+	select PCIE_DW
+	select PCIEPORTBUS
+	help
+	  Say Y here if you want to enable PCIe controller support on
+	  Armada-8K SoCs. The PCIe controller on Armada-8K is based on
+	  Designware hardware and therefore the driver re-uses the
+	  Designware core functions to implement the driver.
+
 endmenu
diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
index d85b5fa..a6f85e3 100644
--- a/drivers/pci/host/Makefile
+++ b/drivers/pci/host/Makefile
@@ -28,3 +28,4 @@ obj-$(CONFIG_PCI_HISI) += pcie-hisi.o
 obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o
 obj-$(CONFIG_PCI_HOST_THUNDER_ECAM) += pci-thunder-ecam.o
 obj-$(CONFIG_PCI_HOST_THUNDER_PEM) += pci-thunder-pem.o
+obj-$(CONFIG_PCIE_ARMADA_8K) += pcie-armada8k.o
diff --git a/drivers/pci/host/pcie-armada8k.c b/drivers/pci/host/pcie-armada8k.c
new file mode 100644
index 0000000..903ab34
--- /dev/null
+++ b/drivers/pci/host/pcie-armada8k.c
@@ -0,0 +1,261 @@
+/*
+ * PCIe host controller driver for Marvell Armada-8K SoCs
+ *
+ * Armada-8K PCIe Glue Layer Source Code
+ *
+ * Copyright (C) 2016 Marvell Technology Group Ltd.
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#define pr_fmt(fmt) "armada-8k-pcie: " fmt
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/pci.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/resource.h>
+#include <linux/of_pci.h>
+#include <linux/of_irq.h>
+
+#include "pcie-designware.h"
+
+struct armada8k_pcie {
+	void __iomem *base;
+	struct clk *main_clk;
+	struct clk *lane_clk;
+	struct pcie_port pp;
+};
+
+#define PCIE_VENDOR_REGS_OFFSET		0x8000
+
+#define PCIE_GLOBAL_CONTROL_REG		0x0
+#define PCIE_APP_LTSSM_EN		BIT(2)
+#define PCIE_DEVICE_TYPE_SHIFT		4
+#define PCIE_DEVICE_TYPE_MASK		0xF
+#define PCIE_DEVICE_TYPE_EP		0x0 /* Endpoint */
+#define PCIE_DEVICE_TYPE_LEP		0x1 /* Legacy endpoint */
+#define PCIE_DEVICE_TYPE_RC		0x4 /* Root complex */
+
+#define PCIE_GLOBAL_STATUS_REG		0x8
+#define PCIE_GLB_STS_RDLH_LINK_UP	BIT(1)
+#define PCIE_GLB_STS_PHY_LINK_UP	BIT(9)
+
+#define PCIE_GLOBAL_INT_CAUSE1_REG	0x1C
+#define PCIE_GLOBAL_INT_MASK1_REG	0x20
+#define PCIE_INT_A_ASSERT_MASK		BIT(9)
+#define PCIE_INT_B_ASSERT_MASK		BIT(10)
+#define PCIE_INT_C_ASSERT_MASK		BIT(11)
+#define PCIE_INT_D_ASSERT_MASK		BIT(12)
+
+#define PCIE_ARCACHE_TRC_REG		0x50
+#define PCIE_AWCACHE_TRC_REG		0x54
+#define PCIE_ARUSER_REG			0x5C
+#define PCIE_AWUSER_REG			0x60
+/*
+ * AR/AW Cache defauls: Normal memory, Write-Back, Read / Write
+ * allocate
+ */
+#define ARCACHE_DEFAULT_VALUE		0x3511
+#define AWCACHE_DEFAULT_VALUE		0x5311
+
+#define DOMAIN_OUTER_SHAREABLE		0x2
+#define AX_USER_DOMAIN_MASK		0x3
+#define AX_USER_DOMAIN_SHIFT		4
+
+
+
+#define to_armada8k_pcie(x)	container_of(x, struct armada8k_pcie, pp)
+
+static int armada8k_pcie_link_up(struct pcie_port *pp)
+{
+	u32 reg;
+	struct armada8k_pcie *pcie = to_armada8k_pcie(pp);
+	u32 mask = PCIE_GLB_STS_RDLH_LINK_UP | PCIE_GLB_STS_PHY_LINK_UP;
+
+	reg = readl(pcie->base + PCIE_GLOBAL_STATUS_REG);
+
+	if ((reg & mask) == mask)
+		return 1;
+
+	pr_debug("No link detected (Global-Status: 0x%08x).\n", reg);
+	return 0;
+}
+
+static void armada8k_pcie_host_init(struct pcie_port *pp)
+{
+	struct armada8k_pcie *pcie = to_armada8k_pcie(pp);
+	void __iomem *base = pcie->base;
+	int timeout = 1000;
+	u32 reg;
+
+	if (!armada8k_pcie_link_up(pp)) {
+		/* Disable LTSSM state machine to enable configuration */
+		reg = readl(base + PCIE_GLOBAL_CONTROL_REG);
+		reg &= ~(PCIE_APP_LTSSM_EN);
+		writel(reg, base + PCIE_GLOBAL_CONTROL_REG);
+	}
+
+	/* Set the device to root complex mode */
+	reg = readl(base + PCIE_GLOBAL_CONTROL_REG);
+	reg &= ~(PCIE_DEVICE_TYPE_MASK << PCIE_DEVICE_TYPE_SHIFT);
+	reg |= PCIE_DEVICE_TYPE_RC << PCIE_DEVICE_TYPE_SHIFT;
+	writel(reg, base + PCIE_GLOBAL_CONTROL_REG);
+
+	/* Set the PCIe master AxCache attributes */
+	writel(ARCACHE_DEFAULT_VALUE, base + PCIE_ARCACHE_TRC_REG);
+	writel(AWCACHE_DEFAULT_VALUE, base + PCIE_AWCACHE_TRC_REG);
+
+	/* Set the PCIe master AxDomain attributes */
+	reg = readl(base + PCIE_ARUSER_REG);
+	reg &= ~(AX_USER_DOMAIN_MASK << AX_USER_DOMAIN_SHIFT);
+	reg |= DOMAIN_OUTER_SHAREABLE << AX_USER_DOMAIN_SHIFT;
+	writel(reg, base + PCIE_ARUSER_REG);
+
+	reg = readl(base + PCIE_AWUSER_REG);
+	reg &= ~(AX_USER_DOMAIN_MASK << AX_USER_DOMAIN_SHIFT);
+	reg |= DOMAIN_OUTER_SHAREABLE << AX_USER_DOMAIN_SHIFT;
+	writel(reg, base + PCIE_AWUSER_REG);
+
+	dw_pcie_setup_rc(pp);
+
+	/* Enable INT A-D interrupts */
+	reg = readl(base + PCIE_GLOBAL_INT_MASK1_REG);
+	reg |= PCIE_INT_A_ASSERT_MASK | PCIE_INT_B_ASSERT_MASK |
+	       PCIE_INT_C_ASSERT_MASK | PCIE_INT_D_ASSERT_MASK;
+	writel(reg, base + PCIE_GLOBAL_INT_MASK1_REG);
+
+	if (!armada8k_pcie_link_up(pp)) {
+		/* Configuration done. Start LTSSM */
+		reg = readl(base + PCIE_GLOBAL_CONTROL_REG);
+		reg |= PCIE_APP_LTSSM_EN;
+		writel(reg, base + PCIE_GLOBAL_CONTROL_REG);
+	}
+
+	/* Wait until the link becomes active again */
+	while (timeout) {
+		if (armada8k_pcie_link_up(pp))
+			break;
+		udelay(1);
+		timeout--;
+	}
+
+	if (timeout == 0)
+		dev_err(pp->dev, "Link not up after reconfiguration\n");
+}
+
+static irqreturn_t armada8k_pcie_irq_handler(int irq, void *arg)
+{
+	struct pcie_port *pp = arg;
+	struct armada8k_pcie *pcie = to_armada8k_pcie(pp);
+	void __iomem *base = pcie->base;
+	u32 val;
+
+	val = readl(base + PCIE_GLOBAL_INT_CAUSE1_REG);
+	writel(val, base + PCIE_GLOBAL_INT_CAUSE1_REG);
+
+	return IRQ_HANDLED;
+}
+
+static struct pcie_host_ops armada8k_pcie_host_ops = {
+	.link_up = armada8k_pcie_link_up,
+	.host_init = armada8k_pcie_host_init,
+};
+
+static int armada8k_pcie_probe(struct platform_device *pdev)
+{
+	struct armada8k_pcie *pcie;
+	struct pcie_port *pp;
+	struct device *dev = &pdev->dev;
+	struct resource *base;
+	int ret;
+
+	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
+	if (!pcie)
+		return -ENOMEM;
+
+	pcie->main_clk = devm_clk_get(dev, "main");
+	if (!IS_ERR(pcie->main_clk))
+		clk_prepare_enable(pcie->main_clk);
+
+	pcie->lane_clk = devm_clk_get(dev, "port");
+	if (!IS_ERR(pcie->lane_clk))
+		clk_prepare_enable(pcie->lane_clk);
+
+	pp = &pcie->pp;
+
+	platform_set_drvdata(pdev, pcie);
+
+	/* Get the dw-pcie unit configuration/control registers base. */
+	base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ctrl");
+	pp->dbi_base = devm_ioremap_resource(dev, base);
+	if (IS_ERR(pp->dbi_base)) {
+		dev_err(dev, "couldn't remap regs base %p\n", base);
+		ret = PTR_ERR(pp->dbi_base);
+		goto fail;
+	}
+
+	pcie->base = pp->dbi_base + PCIE_VENDOR_REGS_OFFSET;
+
+	pp->dev = dev;
+	pp->root_bus_nr = -1;
+	pp->ops = &armada8k_pcie_host_ops;
+
+	pp->irq = platform_get_irq(pdev, 0);
+	if (!pp->irq) {
+		dev_err(dev, "failed to get irq for port\n");
+		ret = -ENODEV;
+		goto fail;
+	}
+
+	ret = devm_request_irq(dev, pp->irq, armada8k_pcie_irq_handler,
+				IRQF_SHARED, "armada8k-pcie", pp);
+	if (ret) {
+		dev_err(dev, "failed to request irq %d\n", pp->irq);
+		goto fail;
+	}
+
+	ret = dw_pcie_host_init(pp);
+	if (ret) {
+		dev_err(dev, "failed to initialize host: %d\n", ret);
+		goto fail;
+	}
+
+	return 0;
+
+fail:
+	if (!IS_ERR(pcie->lane_clk))
+		clk_disable_unprepare(pcie->lane_clk);
+	if (!IS_ERR(pcie->main_clk))
+		clk_disable_unprepare(pcie->main_clk);
+
+	return ret;
+}
+
+static const struct of_device_id armada8k_pcie_of_match[] = {
+	{ .compatible = "marvell,armada8k-pcie", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, armada8k_pcie_of_match);
+
+static struct platform_driver armada8k_pcie_driver = {
+	.probe		= armada8k_pcie_probe,
+	.driver = {
+		.name	= "armada8k-pcie",
+		.of_match_table = of_match_ptr(armada8k_pcie_of_match),
+	},
+};
+
+module_platform_driver(armada8k_pcie_driver);
+
+MODULE_DESCRIPTION("Armada 8k PCIe host controller driver");
+MODULE_AUTHOR("Yehuda Yitshak <yehuday@marvell.com>");
+MODULE_AUTHOR("Shadi Ammouri <shadi@marvell.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.6.4

