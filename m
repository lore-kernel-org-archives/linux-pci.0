Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:57649 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752301AbcBASIG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 1 Feb 2016 13:08:06 -0500
From: Joao Pinto <Joao.Pinto@synopsys.com>
To: Vineet.Gupta1@synopsys.com, helgaas@kernel.org
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org, CARLOS.PALMINHA@synopsys.com,
	Alexey.Brodkin@synopsys.com, robh+dt@kernel.org,
	pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org, arnd@arndb.de,
	Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [PATCH v7 2/2] add new platform driver for PCI RC
Date: Mon,  1 Feb 2016 18:07:45 +0000
Message-Id: <10b29adcdb0a31eb8f8071b271da267e44ad8a04.1454349430.git.jpinto@synopsys.com>
In-Reply-To: <cover.1454349430.git.jpinto@synopsys.com>
References: <cover.1454349430.git.jpinto@synopsys.com>
In-Reply-To: <cover.1454349430.git.jpinto@synopsys.com>
References: <cover.1454349430.git.jpinto@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds a new driver that will be the reference platform driver
for all PCI RC IP Protoyping Kits based on ARC SDP.
This patch is composed by:

-MAINTAINERS file was updated to include the new driver
-Documentation/devicetree/bindings/pci was updated to include the new
driver documentation
-New driver called pcie-synopsys

Signed-off-by: Joao Pinto <jpinto@synopsys.com>
---
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

 .../devicetree/bindings/pci/pcie-synopsys.txt      |  33 +++
 MAINTAINERS                                        |   7 +
 drivers/pci/host/Kconfig                           |   8 +
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pcie-synopsys.c                   | 257 +++++++++++++++++++++
 5 files changed, 306 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/pcie-synopsys.txt
 create mode 100644 drivers/pci/host/pcie-synopsys.c

diff --git a/Documentation/devicetree/bindings/pci/pcie-synopsys.txt b/Documentation/devicetree/bindings/pci/pcie-synopsys.txt
new file mode 100644
index 0000000..f18507c
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/pcie-synopsys.txt
@@ -0,0 +1,33 @@
+Synopsys PCI RC IP Prototyping Kit
+----------------------------------
+
+This is the reference platform driver to be used in the Synopsys PCI Root
+Complex IP Prototyping Kit.
+
+Required properties:
+- compatible: set to "snps,pcie-synopsys";
+- reg: base address and length of the pcie controller registers.
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
+		compatible = "snps,pcie-synopsys";
+		reg = <0xdffff000 0x1000>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		device_type = "pci";
+		ranges = <0x00000800 0 0xd0000000 0xd0000000 0 0x00002000>,
+			 <0x81000000 0 0x00000000 0xde000000 0 0x00010000>,
+			 <0x82000000 0 0xd0400000 0xd0400000 0 0x0d000000>;
+		interrupts = <25>, <24>;
+		#interrupt-cells = <1>;
+		num-lanes = <1>;
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index e9caa4b..d2e4506 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8230,6 +8230,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
 F:	drivers/pci/host/pcie-hisi.c
 
+PCI DRIVER FOR SYNOPSYS PROTOTYPING DEVICE
+M:	Joao Pinto <jpinto@synopsys.com>
+L:	linux-pci@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/pci/pcie-snpsdev.txt
+F:	drivers/pci/host/pcie-snpsdev.c
+
 PCMCIA SUBSYSTEM
 P:	Linux PCMCIA Team
 L:	linux-pcmcia@lists.infradead.org
diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index f131ba9..58c5bb1 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -172,4 +172,12 @@ config PCI_HISI
 	help
 	  Say Y here if you want PCIe controller support on HiSilicon HIP05 SoC
 
+config PCIE_SYNOPSYS
+	bool "Platform Driver for Synopsys Device"
+	depends on ARC && OF
+	select PCIEPORTBUS
+	select PCIE_DW
+	help
+	  Say Y here if you want to enable PCIe controller support on the
+	  Synopsys IP Prototyping Kits.
 endmenu
diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
index 9d4d3c6..bb79b29 100644
--- a/drivers/pci/host/Makefile
+++ b/drivers/pci/host/Makefile
@@ -20,3 +20,4 @@ obj-$(CONFIG_PCIE_IPROC_BCMA) += pcie-iproc-bcma.o
 obj-$(CONFIG_PCIE_ALTERA) += pcie-altera.o
 obj-$(CONFIG_PCIE_ALTERA_MSI) += pcie-altera-msi.o
 obj-$(CONFIG_PCI_HISI) += pcie-hisi.o
+obj-$(CONFIG_PCIE_SYNOPSYS) += pcie-synopsys.o
diff --git a/drivers/pci/host/pcie-synopsys.c b/drivers/pci/host/pcie-synopsys.c
new file mode 100644
index 0000000..9702e79
--- /dev/null
+++ b/drivers/pci/host/pcie-synopsys.c
@@ -0,0 +1,257 @@
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
+#define to_synopsys_pcie(x)	container_of(x, struct synopsys_pcie, pp)
+
+struct synopsys_pcie {
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
+/* This handler was created for future work */
+static irqreturn_t synopsys_pcie_irq_handler(int irq, void *arg)
+{
+	return IRQ_NONE;
+}
+
+static irqreturn_t synopsys_pcie_msi_irq_handler(int irq, void *arg)
+{
+	struct pcie_port *pp = arg;
+
+	dw_handle_msi_irq(pp);
+
+	return dw_handle_msi_irq(pp);
+}
+
+static void synopsys_pcie_init_phy(struct pcie_port *pp)
+{
+	/* write Lane 0 Equalization Control fields register */
+	writel(PCI_EQUAL_CONTROL_PHY, pp->dbi_base + 0x154);
+}
+
+static int synopsys_pcie_deassert_core_reset(struct pcie_port *pp)
+{
+	return 0;
+}
+
+static void synopsys_pcie_establish_link(struct pcie_port *pp)
+{
+	int retries = 0;
+
+	/* check if the link is up or not */
+	for (retries = 0; retries < 10; retries++) {
+		if (dw_pcie_link_up(pp)) {
+			dev_info(pp->dev, "Link up\n");
+			return;
+		}
+		mdelay(100);
+	}
+}
+
+/*
+ * synopsys_pcie_host_init()
+ * Platform specific host/RC initialization
+ *	a. Assert the core reset
+ *	b. Assert and deassert phy reset and initialize the phy
+ *	c. De-Assert the core reset
+ *	d. Initializet the Root Port (BARs/Memory Or IO/ Interrupt/ Commnad Reg)
+ *	e. Initiate Link startup procedure
+ *
+ */
+static void synopsys_pcie_host_init(struct pcie_port *pp)
+{
+	/* Initialize Phy (Reset/poweron/control-inputs ) */
+	synopsys_pcie_init_phy(pp);
+
+	synopsys_pcie_deassert_core_reset(pp);
+
+	dw_pcie_setup_rc(pp);
+
+	synopsys_pcie_establish_link(pp);
+
+	if (IS_ENABLED(CONFIG_PCI_MSI))
+		dw_pcie_msi_init(pp);
+}
+
+static int synopsys_pcie_link_up(struct pcie_port *pp)
+{
+	u32 val;
+
+	val = readl(pp->dbi_base + PCIE_PHY_DEBUG_R1);
+	return val & PCIE_PHY_DEBUG_R1_LINK_UP;
+}
+
+/**
+ * This is RC operation structure
+ * synopsys_pcie_link_up: the function which initiates the phy link up procedure
+ * synopsys_pcie_host_init: the function which does the host/RC Root port
+ * initialization.
+ */
+static struct pcie_host_ops synopsys_pcie_host_ops = {
+	.link_up = synopsys_pcie_link_up,
+	.host_init = synopsys_pcie_host_init,
+};
+
+/**
+ * synopsys_add_pcie_port
+ * This function
+ * a. installs the interrupt handler
+ * b. registers host operations in the pcie_port structure
+ */
+static int synopsys_add_pcie_port(struct pcie_port *pp,
+				 struct platform_device *pdev)
+{
+	int ret;
+
+	pp->irq = platform_get_irq(pdev, 1);
+
+	if (pp->irq < 0)
+		return pp->irq;
+
+	ret = devm_request_irq(&pdev->dev, pp->irq, synopsys_pcie_irq_handler,
+				IRQF_SHARED, "synopsys-pcie", pp);
+
+	if (ret) {
+		dev_err(&pdev->dev, "failed to request irq\n");
+		return ret;
+	}
+
+	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+		pp->msi_irq = platform_get_irq(pdev, 0);
+
+		if (pp->msi_irq < 0)
+			return pp->msi_irq;
+
+		ret = devm_request_irq(&pdev->dev, pp->msi_irq,
+					synopsys_pcie_msi_irq_handler,
+					IRQF_SHARED, "synopsys-pcie-msi", pp);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to request msi irq\n");
+			return ret;
+		}
+	}
+
+	pp->root_bus_nr = -1;
+	pp->ops = &synopsys_pcie_host_ops;
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
+ * synopsys_pcie_probe()
+ * This function gets called as part of pcie registration. if the id matches
+ * the platform driver framework will call this function.
+ *
+ * @pdev: Pointer to the platform_device structure
+ *
+ * Returns zero on success; Negative errorno on failure
+ */
+static int synopsys_pcie_probe(struct platform_device *pdev)
+{
+	struct synopsys_pcie *synopsys_pcie;
+	struct pcie_port *pp;
+	struct resource *res;  /* Resource from DT */
+	int ret;
+
+	synopsys_pcie = devm_kzalloc(&pdev->dev, sizeof(*synopsys_pcie),
+					GFP_KERNEL);
+	if (!synopsys_pcie)
+		return -ENOMEM;
+
+	pp = &synopsys_pcie->pp;
+	pp->dev = &pdev->dev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	if (!res)
+		return -ENODEV;
+
+	synopsys_pcie->mem_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(synopsys_pcie->mem_base))
+		return PTR_ERR(synopsys_pcie->mem_base);
+
+	pp->dbi_base = synopsys_pcie->mem_base;
+
+	ret = synopsys_add_pcie_port(pp, pdev);
+	if (ret < 0)
+		return ret;
+
+	platform_set_drvdata(pdev, synopsys_pcie);
+
+	return 0;
+}
+
+static const struct of_device_id synopsys_pcie_of_match[] = {
+	{ .compatible = "snps,pcie-synopsys", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, synopsys_pcie_of_match);
+
+static struct platform_driver synopsys_pcie_driver = {
+	.driver = {
+		.name	= "pcie-synopsys",
+		.of_match_table = synopsys_pcie_of_match,
+	},
+	.probe = synopsys_pcie_probe,
+};
+
+module_platform_driver(synopsys_pcie_driver);
+
+MODULE_AUTHOR("Manjunath Bettegowda <manjumb@synopsys.com>");
+MODULE_DESCRIPTION("Synopsys PCIe host controller driver");
+MODULE_LICENSE("GPL v2");
-- 
1.8.1.5

