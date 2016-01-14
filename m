Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Joao Pinto <Joao.Pinto@synopsys.com>
To: Vineet.Gupta1@synopsys.com, helgaas@kernel.org
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org, CARLOS.PALMINHA@synopsys.com,
	Alexey.Brodkin@synopsys.com, robh+dt@kernel.org,
	pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org, arnd@arndb.de,
	Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [PATCH v6 2/2] add new platform driver for PCI RC
Date: Thu, 14 Jan 2016 11:04:33 +0000
Message-Id: <9b45cc43f6aff7e5de15ac55e77fbab9cf008d2f.1452611234.git.jpinto@synopsys.com>
In-Reply-To: <cover.1452611234.git.jpinto@synopsys.com>
References: <cover.1452611234.git.jpinto@synopsys.com>
In-Reply-To: <cover.1452611234.git.jpinto@synopsys.com>
References: <cover.1452611234.git.jpinto@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds a new driver that will be the reference platform driver
for all PCI RC IP Protoyping Kits based on ARC SDP.
This patch is composed by:

-Changes to pcie-designware driver add a function that enables the
feature of starting the LTSSM (Link Train Status State) used by the
new driver
-MAINTAINERS file was updated to include the new driver
-Documentation/devicetree/bindings/pci was updated to include the new
driver documentation
-New driver called pcie-snpsdev

Signed-off-by: Joao Pinto <jpinto@synopsys.com>
---
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

 .../devicetree/bindings/pci/pcie-snpsdev.txt       |  33 +++
 MAINTAINERS                                        |   7 +
 drivers/pci/host/Kconfig                           |   8 +
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pcie-designware.c                 |   9 +
 drivers/pci/host/pcie-designware.h                 |   1 +
 drivers/pci/host/pcie-snpsdev.c                    | 286 +++++++++++++++++++++
 7 files changed, 345 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/pcie-snpsdev.txt
 create mode 100644 drivers/pci/host/pcie-snpsdev.c

diff --git a/Documentation/devicetree/bindings/pci/pcie-snpsdev.txt b/Documentation/devicetree/bindings/pci/pcie-snpsdev.txt
new file mode 100644
index 0000000..cae548b
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/pcie-snpsdev.txt
@@ -0,0 +1,33 @@
+Synopsys PCI RC IP Prototyping Kit
+----------------------------------
+
+This is the reference platform driver to be used in the Synopsys PCI Root
+Complex IP Prototyping Kit.
+
+Required properties:
+- compatible: set to "snps,pcie-snpsdev";
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
+		compatible = "snps,pcie-snpsdev";
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
index f131ba9..589bc15 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -172,4 +172,12 @@ config PCI_HISI
 	help
 	  Say Y here if you want PCIe controller support on HiSilicon HIP05 SoC
 
+config PCIE_SNPSDEV
+	bool "Platform Driver for Synopsys Device"
+	depends on ARC && OF
+	select PCIEPORTBUS
+	select PCIE_DW
+	help
+	  Say Y here if you want to enable PCIe controller support on the
+	  Synopsys IP Prototyping Kits.
 endmenu
diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
index 9d4d3c6..e422f65 100644
--- a/drivers/pci/host/Makefile
+++ b/drivers/pci/host/Makefile
@@ -20,3 +20,4 @@ obj-$(CONFIG_PCIE_IPROC_BCMA) += pcie-iproc-bcma.o
 obj-$(CONFIG_PCIE_ALTERA) += pcie-altera.o
 obj-$(CONFIG_PCIE_ALTERA_MSI) += pcie-altera-msi.o
 obj-$(CONFIG_PCI_HISI) += pcie-hisi.o
+obj-$(CONFIG_PCIE_SNPSDEV) += pcie-snpsdev.o
diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 540f077..f73a3cf 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -706,6 +706,15 @@ static struct pci_ops dw_pcie_ops = {
 	.write = dw_pcie_wr_conf,
 };
 
+void dw_pcie_link_retrain(struct pcie_port *pp)
+{
+	u32 val = 0;
+
+	dw_pcie_readl_rc(pp, PCI_EXP_LNKCTL+0x70, &val);
+	val = val | PCI_EXP_LNKCTL_RL;
+	dw_pcie_writel_rc(pp, val, PCI_EXP_LNKCTL+0x70);
+}
+
 void dw_pcie_setup_rc(struct pcie_port *pp)
 {
 	u32 val;
diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
index 2356d29..249b631 100644
--- a/drivers/pci/host/pcie-designware.h
+++ b/drivers/pci/host/pcie-designware.h
@@ -79,5 +79,6 @@ void dw_pcie_msi_init(struct pcie_port *pp);
 int dw_pcie_link_up(struct pcie_port *pp);
 void dw_pcie_setup_rc(struct pcie_port *pp);
 int dw_pcie_host_init(struct pcie_port *pp);
+void dw_pcie_link_retrain(struct pcie_port *pp);
 
 #endif /* _PCIE_DESIGNWARE_H */
diff --git a/drivers/pci/host/pcie-snpsdev.c b/drivers/pci/host/pcie-snpsdev.c
new file mode 100644
index 0000000..4ca7ec5
--- /dev/null
+++ b/drivers/pci/host/pcie-snpsdev.c
@@ -0,0 +1,286 @@
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
+#define to_snpsdev_pcie(x)	container_of(x, struct snpsdev_pcie, pp)
+
+struct snpsdev_pcie {
+	void __iomem		*mem_base; /* Memory Base to access Core's [RC]
+					    * Config Space Layout
+					    */
+	struct pcie_port	pp;        /* RC Root Port specific structure -
+					    * DWC_PCIE_RC stuff
+					    */
+};
+
+#define PCI_EQUAL_CONTROL_PHY 0x00000707
+
+/* PCIe Port Logic registers (memory-mapped) */
+#define PLR_OFFSET 0x700
+#define PCIE_PHY_DEBUG_R0 (PLR_OFFSET + 0x28) /* 0x728 */
+#define PCIE_PHY_DEBUG_R1 (PLR_OFFSET + 0x2c) /* 0x72c */
+
+/* This handler was created for future work */
+static irqreturn_t snpsdev_pcie_irq_handler(int irq, void *arg)
+{
+	return IRQ_NONE;
+}
+
+static irqreturn_t snpsdev_pcie_msi_irq_handler(int irq, void *arg)
+{
+	struct pcie_port *pp = arg;
+
+	dw_handle_msi_irq(pp);
+
+	return IRQ_HANDLED;
+}
+
+static void snpsdev_pcie_init_phy(struct pcie_port *pp)
+{
+	/* write Lane 0 Equalization Control fields register */
+	writel(PCI_EQUAL_CONTROL_PHY, pp->dbi_base + 0x154);
+}
+
+static int snpsdev_pcie_deassert_core_reset(struct pcie_port *pp)
+{
+	return 0;
+}
+
+static void snpsdev_pcie_establish_link(struct pcie_port *pp)
+{
+	int count = 0;
+
+	/* Initialize Phy (Reset/poweron/control-inputs ) */
+	snpsdev_pcie_init_phy(pp);
+
+	/* de-assert core reset */
+	snpsdev_pcie_deassert_core_reset(pp);
+
+	/* We expect the PCIe Link to be up by this time */
+	dw_pcie_setup_rc(pp);
+
+	/* Start LTSSM here */
+	dw_pcie_link_retrain(pp);
+
+	while (!dw_pcie_link_up(pp)) {
+		usleep_range(1000, 1100);
+		count++;
+		if (count == 20) {
+			dev_err(pp->dev, "phy link never came up\n");
+			dev_dbg(pp->dev,
+				"PL_DEBUG0: 0x%08x, DEBUG_R1: 0x%08x\n",
+				readl(pp->dbi_base + PCIE_PHY_DEBUG_R0),
+				readl(pp->dbi_base + PCIE_PHY_DEBUG_R1));
+			break;
+		}
+	}
+}
+
+/*
+ * snpsdev_pcie_host_init()
+ * Platform specific host/RC initialization
+ *	a. Assert the core reset
+ *	b. Assert and deassert phy reset and initialize the phy
+ *	c. De-Assert the core reset
+ *	d. Initializet the Root Port (BARs/Memory Or IO/ Interrupt/ Commnad Reg)
+ *	e. Initiate Link startup procedure
+ *
+ */
+static void snpsdev_pcie_host_init(struct pcie_port *pp)
+{
+	/* Establish link */
+	snpsdev_pcie_establish_link(pp);
+
+	if (IS_ENABLED(CONFIG_PCI_MSI))
+		dw_pcie_msi_init(pp);
+}
+
+static int snpsdev_pcie_link_up(struct pcie_port *pp)
+{
+	u32 status;
+
+	/* Bit number 36: reports LTSSM PHY Link UP; Available in bit 3 of
+	 * PCIE_PHY_DEBUG_R1
+	 */
+	status = readl(pp->dbi_base + PCIE_PHY_DEBUG_R1) & (0x1 << 4);
+	if (status != 0)
+		return 1;
+
+	/* TODO:Now Link is in L0;Initiate GEN2/GEN3 migration if RC Supports*/
+	return 0;
+}
+
+/**
+ * This is RC operation structure
+ * snpsdev_pcie_link_up: the function which initiates the phy link up procedure
+ * snpsdev_pcie_host_init: the function which does the host/RC Root port
+ * initialization.
+ */
+static struct pcie_host_ops snpsdev_pcie_host_ops = {
+	.link_up = snpsdev_pcie_link_up,
+	.host_init = snpsdev_pcie_host_init,
+};
+
+/**
+ * snpsdev_add_pcie_port
+ * This function
+ * a. installs the interrupt handler
+ * b. registers host operations in the pcie_port structure
+ */
+static int snpsdev_add_pcie_port(struct pcie_port *pp,
+				 struct platform_device *pdev)
+{
+	int ret;
+
+	pp->irq = platform_get_irq(pdev, 1);
+
+	if (pp->irq < 0) {
+		if (pp->irq != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "cannot get irq\n");
+		return pp->irq;
+	}
+
+	ret = devm_request_irq(&pdev->dev, pp->irq, snpsdev_pcie_irq_handler,
+				IRQF_SHARED, "snpsdev-pcie", pp);
+
+	if (ret) {
+		dev_err(&pdev->dev, "failed to request irq\n");
+		return ret;
+	}
+
+	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+		pp->msi_irq = platform_get_irq(pdev, 0);
+
+		if (pp->msi_irq < 0) {
+			if (pp->msi_irq != -EPROBE_DEFER)
+				dev_err(&pdev->dev, "cannot get msi irq\n");
+			return pp->msi_irq;
+		}
+
+		ret = devm_request_irq(&pdev->dev, pp->msi_irq,
+					snpsdev_pcie_msi_irq_handler,
+					IRQF_SHARED, "snpsdev-pcie-msi", pp);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to request msi irq\n");
+			return ret;
+		}
+	}
+
+	pp->root_bus_nr = -1;
+	pp->ops = &snpsdev_pcie_host_ops;
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
+ * snpsdev_pcie_rc_probe()
+ * This function gets called as part of pcie registration. if the id matches
+ * the platform driver framework will call this function.
+ *
+ * @pdev: Pointer to the platform_device structure
+ *
+ * Returns zero on success; Negative errorno on failure
+ */
+static int snpsdev_pcie_rc_probe(struct platform_device *pdev)
+{
+	struct snpsdev_pcie *snpsdev_pcie;
+	struct pcie_port *pp;
+	struct resource *dwc_pcie_rc_res;  /* Resource from DT */
+	int ret;
+
+	snpsdev_pcie = devm_kzalloc(&pdev->dev, sizeof(*snpsdev_pcie),
+					GFP_KERNEL);
+	if (!snpsdev_pcie)
+		return -ENOMEM;
+
+	pp = &snpsdev_pcie->pp;
+	pp->dev = &pdev->dev;
+
+	dwc_pcie_rc_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	if (!dwc_pcie_rc_res)
+		return -ENODEV;
+
+	snpsdev_pcie->mem_base = devm_ioremap_resource(&pdev->dev,
+							dwc_pcie_rc_res);
+	if (IS_ERR(snpsdev_pcie->mem_base)) {
+		ret = PTR_ERR(snpsdev_pcie->mem_base);
+		return ret;
+	}
+	pp->dbi_base = snpsdev_pcie->mem_base;
+
+	ret = snpsdev_add_pcie_port(pp, pdev);
+	if (ret < 0)
+		return ret;
+
+	platform_set_drvdata(pdev, snpsdev_pcie);
+
+	return 0;
+}
+
+static int snpsdev_pcie_rc_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static const struct of_device_id snpsdev_pcie_rc_of_match[] = {
+	{ .compatible = "snps,pcie-snpsdev", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, snpsdev_pcie_rc_of_match);
+
+static struct platform_driver snpsdev_pcie_rc_driver = {
+	.driver = {
+		.name	= "pcie-snpsdev",
+		.of_match_table = snpsdev_pcie_rc_of_match,
+	},
+	.probe = snpsdev_pcie_rc_probe,
+};
+
+module_platform_driver(snpsdev_pcie_rc_driver);
+
+MODULE_AUTHOR("Manjunath Bettegowda <manjumb@synopsys.com>");
+MODULE_DESCRIPTION("Platform Driver for Synopsys Device");
+MODULE_LICENSE("GPL v2");
-- 
1.8.1.5
