Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.47.9]:40931 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933368AbcBDPw0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Feb 2016 10:52:26 -0500
From: Joao Pinto <Joao.Pinto@synopsys.com>
To: Vineet.Gupta1@synopsys.com, helgaas@kernel.org, arnd@arndb.de
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org, CARLOS.PALMINHA@synopsys.com,
	Alexey.Brodkin@synopsys.com, robh+dt@kernel.org,
	pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [PATCH v8 2/2] add new platform driver for PCI RC
Date: Thu,  4 Feb 2016 15:52:10 +0000
Message-Id: <c7af1603d4f18d11cb0ccee1c07708a1455ea4ed.1454600622.git.jpinto@synopsys.com>
In-Reply-To: <cover.1454600622.git.jpinto@synopsys.com>
References: <cover.1454600622.git.jpinto@synopsys.com>
In-Reply-To: <cover.1454600622.git.jpinto@synopsys.com>
References: <cover.1454600622.git.jpinto@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds a new driver that will be the reference platform driver
for all PCI RC IP Protoyping Kits based on ARC SDP.

Signed-off-by: Joao Pinto <jpinto@synopsys.com>
---
Change v7 -> v8 (Bjorn Helgaas and Arnd Bergmann):
- driver name was changed from pcie-synopsys to pcie-dw-pltfm
- mdelay() replaced for msleep() in the new driver
- Devicetree bindings for the new driver was updated (config space removed
from ranges)
- Unnecessary synopsys_pcie_irq_handler() was removed
- Driver compatibility strings updated
Change v6 -> v7 (Bjorn Helgaas):
- driver name was changed from pcie-snpsdev to pcie-synopsys
- driver internals (functions and certain variables) also changed name
accordingly
- devicetree bindings documentation also changed accordingly
- quirk function dw_pcie_link_retrain() was removed (tests were made
successfully without it)
- driver was changed to meet pci standards (link up confirmation routine,
init rc functions, etc.)
- EPROBE_DEFER were removed
Change v5 -> v6:
- Nothing changed (just to keep up with patch set version).
Change v4 -> v5:
- Nothing changed (just to keep up with patch set version).
Changes v3 -> v4 (Bjorn Helgaas):
- ARCH dependencies were added to the drivers/pci/host/kconfig for the
PCIE_SNPSDEV.
Changes v2 -> v3 (Bjorn Helgaas):
- link init stuff was moved to a snpsdev_pcie_establish_link() function in
pcie-snpsdev
- pcie-snpsdev driver declaration was changed to be more 
standard (Bjorn Helgaas)
- pcie-designware' dw_pcie_link_retrain() now use standard registers from
pci-regs.h (Bjorn Helgaas)
- pcie-snpsdev.txt was complemented with more info (Mark Rutland)
Changes v1 -> v2 (Bjorn Helgaas):
- Fixups snpsdev_pcie_fixup_bridge() and snpsdev_pcie_fixup_res() were removed
from the driver (these functions were for specific tests only and not usefull
in mainline)
- Driver' comments were reviewed (fix Typos and excessive comments removal)
- Removed unnecessary definitions in the driver source (PCIE_PHY_CTRL and
PCIE_PHY_STAT)

 .../devicetree/bindings/pci/pcie-dw-pltfm.txt      |  36 +++
 MAINTAINERS                                        |   7 +
 drivers/pci/host/Kconfig                           |   8 +
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pcie-dw-pltfm.c                   | 244 +++++++++++++++++++++
 5 files changed, 296 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/pcie-dw-pltfm.txt
 create mode 100644 drivers/pci/host/pcie-dw-pltfm.c

diff --git a/Documentation/devicetree/bindings/pci/pcie-dw-pltfm.txt b/Documentation/devicetree/bindings/pci/pcie-dw-pltfm.txt
new file mode 100644
index 0000000..ee2a877
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/pcie-dw-pltfm.txt
@@ -0,0 +1,36 @@
+Synopsys PCI RC IP Prototyping Kit
+----------------------------------
+
+This is the reference platform driver to be used in the Synopsys PCI Root
+Complex IP Prototyping Kit.
+
+Required properties:
+- compatible: set to "snps,dw-pcie" or "snps,ipk-pcie";
+- reg: base address and length of the pcie controller registers and
+configuration address space
+- reg-names: Must be "config" for the PCIe configuration space.
+- #address-cells: set to <3>
+- #size-cells: set to <2>
+- device_type: set to "pci"
+- ranges: ranges for the PCI memory and I/O regions.
+- interrupts: one interrupt source for MSI interrupts, followed by interrupt
+	source for hardware related interrupts.
+- #interrupt-cells: set to <1>
+- num-lanes: set to <1>;
+
+Example configuration:
+
+	pcie: pcie@0xdffff000 {
+		compatible = "snps,dw-pcie";
+		reg = <0xdffff000 0x1000
+		       0xd0000000 0x2000>;
+		reg-names = "csr", "config";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		device_type = "pci";
+		ranges = <0x81000000 0 0x00000000 0xde000000 0 0x00010000
+			  0x82000000 0 0xd0400000 0xd0400000 0 0x0d000000>;
+		interrupts = <25>, <24>;
+		#interrupt-cells = <1>;
+		num-lanes = <1>;
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index e9caa4b..8362189 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8230,6 +8230,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
 F:	drivers/pci/host/pcie-hisi.c
 
+PCI DRIVER FOR SYNOPSYS PROTOTYPING DEVICE
+M:	Joao Pinto <jpinto@synopsys.com>
+L:	linux-pci@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/pci/pcie-dw-pltfm.txt
+F:	drivers/pci/host/pcie-dw-pltfm.c
+
 PCMCIA SUBSYSTEM
 P:	Linux PCMCIA Team
 L:	linux-pcmcia@lists.infradead.org
diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index f131ba9..61cdc72 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -172,4 +172,12 @@ config PCI_HISI
 	help
 	  Say Y here if you want PCIe controller support on HiSilicon HIP05 SoC
 
+config PCIE_DW_PLAT
+	bool "Platform Driver for Synopsys PCIe controller"
+	depends on ARC && OF
+	select PCIEPORTBUS
+	select PCIE_DW
+	help
+	  Say Y here if you want to enable Synopsys PCIe controller platform
+	  driver.
 endmenu
diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
index 9d4d3c6..8c84ba4 100644
--- a/drivers/pci/host/Makefile
+++ b/drivers/pci/host/Makefile
@@ -20,3 +20,4 @@ obj-$(CONFIG_PCIE_IPROC_BCMA) += pcie-iproc-bcma.o
 obj-$(CONFIG_PCIE_ALTERA) += pcie-altera.o
 obj-$(CONFIG_PCIE_ALTERA_MSI) += pcie-altera-msi.o
 obj-$(CONFIG_PCI_HISI) += pcie-hisi.o
+obj-$(CONFIG_PCIE_DW_PLAT) += pcie-dw-pltfm.o
diff --git a/drivers/pci/host/pcie-dw-pltfm.c b/drivers/pci/host/pcie-dw-pltfm.c
new file mode 100644
index 0000000..0924ec4
--- /dev/null
+++ b/drivers/pci/host/pcie-dw-pltfm.c
@@ -0,0 +1,244 @@
+/*
+ * PCIe RC driver for Synopsys Designware Core
+ *
+ * Copyright (C) 2015-2016 Synopsys, Inc. (www.synopsys.com)
+ *
+ * Authors: Manjunath Bettegowda <manjumb@synopsys.com>,
+ *	    Jie Deng <jiedeng@synopsys.com>
+ *	    Joao Pinto <jpinto@synopsys.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/gpio.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_gpio.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/resource.h>
+#include <linux/signal.h>
+#include <linux/types.h>
+
+#include "pcie-designware.h"
+
+#define to_dw_pltfm_pcie(x)	container_of(x, struct dw_pltfm_pcie, pp)
+
+struct dw_pltfm_pcie {
+	void __iomem		*mem_base; /* Memory Base to access Core's [RC]
+					    * Config Space Layout
+					    */
+	struct pcie_port	pp;        /* RC Root Port specific structure -
+					    * DWC_PCIE_RC stuff
+					    */
+};
+
+#define PCI_EQUAL_CONTROL_PHY 0x00000707
+#define PCIE_PHY_DEBUG_R1_LINK_UP 0x00000010
+
+/* PCIe Port Logic registers (memory-mapped) */
+#define PLR_OFFSET 0x700
+#define PCIE_PHY_DEBUG_R0 (PLR_OFFSET + 0x28) /* 0x728 */
+#define PCIE_PHY_DEBUG_R1 (PLR_OFFSET + 0x2c) /* 0x72c */
+
+static irqreturn_t dw_pltfm_pcie_msi_irq_handler(int irq, void *arg)
+{
+	struct pcie_port *pp = arg;
+
+	dw_handle_msi_irq(pp);
+
+	return dw_handle_msi_irq(pp);
+}
+
+static void dw_pltfm_pcie_init_phy(struct pcie_port *pp)
+{
+	/* write Lane 0 Equalization Control fields register */
+	writel(PCI_EQUAL_CONTROL_PHY, pp->dbi_base + 0x154);
+}
+
+static int dw_pltfm_pcie_deassert_core_reset(struct pcie_port *pp)
+{
+	return 0;
+}
+
+static void dw_pltfm_pcie_establish_link(struct pcie_port *pp)
+{
+	int retries = 0;
+
+	/* check if the link is up or not */
+	for (retries = 0; retries < 10; retries++) {
+		if (dw_pcie_link_up(pp)) {
+			dev_info(pp->dev, "Link up\n");
+			return;
+		}
+		msleep(100);
+	}
+}
+
+/*
+ * dw_pltfm_pcie_host_init()
+ * Platform specific host/RC initialization
+ *	a. Assert the core reset
+ *	b. Assert and deassert phy reset and initialize the phy
+ *	c. De-Assert the core reset
+ *	d. Initializet the Root Port (BARs/Memory Or IO/ Interrupt/ Commnad Reg)
+ *	e. Initiate Link startup procedure
+ *
+ */
+static void dw_pltfm_pcie_host_init(struct pcie_port *pp)
+{
+	/* Initialize Phy (Reset/poweron/control-inputs ) */
+	dw_pltfm_pcie_init_phy(pp);
+
+	dw_pltfm_pcie_deassert_core_reset(pp);
+
+	dw_pcie_setup_rc(pp);
+
+	dw_pltfm_pcie_establish_link(pp);
+
+	if (IS_ENABLED(CONFIG_PCI_MSI))
+		dw_pcie_msi_init(pp);
+}
+
+static int dw_pltfm_pcie_link_up(struct pcie_port *pp)
+{
+	u32 val;
+
+	val = readl(pp->dbi_base + PCIE_PHY_DEBUG_R1);
+	return val & PCIE_PHY_DEBUG_R1_LINK_UP;
+}
+
+/**
+ * This is RC operation structure
+ * dw_pltfm_pcie_link_up: the function which initiates the phy link up procedure
+ * dw_pltfm_pcie_host_init: the function which does the host/RC Root port
+ * initialization.
+ */
+static struct pcie_host_ops dw_pltfm_pcie_host_ops = {
+	.link_up = dw_pltfm_pcie_link_up,
+	.host_init = dw_pltfm_pcie_host_init,
+};
+
+/**
+ * dw_pltfm_add_pcie_port
+ * This function
+ * a. installs the interrupt handler
+ * b. registers host operations in the pcie_port structure
+ */
+static int dw_pltfm_add_pcie_port(struct pcie_port *pp,
+				 struct platform_device *pdev)
+{
+	int ret;
+
+	pp->irq = platform_get_irq(pdev, 1);
+
+	if (pp->irq < 0)
+		return pp->irq;
+
+	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+		pp->msi_irq = platform_get_irq(pdev, 0);
+
+		if (pp->msi_irq < 0)
+			return pp->msi_irq;
+
+		ret = devm_request_irq(&pdev->dev, pp->msi_irq,
+					dw_pltfm_pcie_msi_irq_handler,
+					IRQF_SHARED, "dw-pltfm-pcie-msi", pp);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to request msi irq\n");
+			return ret;
+		}
+	}
+
+	pp->root_bus_nr = -1;
+	pp->ops = &dw_pltfm_pcie_host_ops;
+
+	/* Below function:
+	 * Checks for range property from DT
+	 * Gets the IO and MEMORY and CONFIG-Space ranges from DT
+	 * Does IOREMAPS on the physical addresses
+	 * Gets the num-lanes from DT
+	 * Gets MSI capability from DT
+	 * Calls the platform specific host initialization
+	 * Program the correct class, BAR0, Link width, in Config space
+	 * Then it calls pci common init routine
+	 * Then it calls function to assign "unassigned resources"
+	 */
+	ret = dw_pcie_host_init(pp);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to initialize host\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * dw_pltfm_pcie_probe()
+ * This function gets called as part of pcie registration. if the id matches
+ * the platform driver framework will call this function.
+ *
+ * @pdev: Pointer to the platform_device structure
+ *
+ * Returns zero on success; Negative errorno on failure
+ */
+static int dw_pltfm_pcie_probe(struct platform_device *pdev)
+{
+	struct dw_pltfm_pcie *dw_pltfm_pcie;
+	struct pcie_port *pp;
+	struct resource *res;  /* Resource from DT */
+	int ret;
+
+	dw_pltfm_pcie = devm_kzalloc(&pdev->dev, sizeof(*dw_pltfm_pcie),
+					GFP_KERNEL);
+	if (!dw_pltfm_pcie)
+		return -ENOMEM;
+
+	pp = &dw_pltfm_pcie->pp;
+	pp->dev = &pdev->dev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	if (!res)
+		return -ENODEV;
+
+	dw_pltfm_pcie->mem_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(dw_pltfm_pcie->mem_base))
+		return PTR_ERR(dw_pltfm_pcie->mem_base);
+
+	pp->dbi_base = dw_pltfm_pcie->mem_base;
+
+	ret = dw_pltfm_add_pcie_port(pp, pdev);
+	if (ret < 0)
+		return ret;
+
+	platform_set_drvdata(pdev, dw_pltfm_pcie);
+
+	return 0;
+}
+
+static const struct of_device_id dw_pltfm_pcie_of_match[] = {
+	{ .compatible = "snps,dw-pcie", },
+	{ .compatible = "snps,ipk-pcie", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, dw_pltfm_pcie_of_match);
+
+static struct platform_driver dw_pltfm_pcie_driver = {
+	.driver = {
+		.name	= "dw-pcie",
+		.of_match_table = dw_pltfm_pcie_of_match,
+	},
+	.probe = dw_pltfm_pcie_probe,
+};
+
+module_platform_driver(dw_pltfm_pcie_driver);
+
+MODULE_AUTHOR("Manjunath Bettegowda <manjumb@synopsys.com>");
+MODULE_DESCRIPTION("Synopsys PCIe host controller driver");
+MODULE_LICENSE("GPL v2");
-- 
1.8.1.5

