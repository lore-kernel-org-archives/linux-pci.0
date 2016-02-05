Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Joao Pinto <Joao.Pinto@synopsys.com>
To: helgaas@kernel.org, arnd@arndb.de
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Vineet.Gupta1@synopsys.com, Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [PATCH v2] synopsys pcie rc generic platform driver update
Date: Fri,  5 Feb 2016 14:35:28 +0000
Message-Id: <192173247b53783570af804512f5ed8b1f84bc5d.1454682656.git.jpinto@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The patch work consisted of:
- driver name was changed from pcie-synopsys to pcie-designware-pltfm
- mdelay() replaced for msleep() in the new driver
- Devicetree bindings for the new driver was updated (config space removed
from ranges and new compatibility strings were introduced)
- Unnecessary synopsys_pcie_irq_handler() was removed
- Driver compatibility strings updated

Patch was done against host/pcie-synopsys branch.

Signed-off-by: Joao Pinto <jpinto@synopsys.com>
---
Changes v1->v2:
- Patch description was not correct

 .../bindings/pci/pcie-designware-pltfm.txt         |  37 +++
 .../devicetree/bindings/pci/pcie-synopsys.txt      |  33 ---
 drivers/pci/host/Kconfig                           |   8 +-
 drivers/pci/host/Makefile                          |   2 +-
 drivers/pci/host/pcie-designware-pltfm.c           | 239 ++++++++++++++++++++
 drivers/pci/host/pcie-synopsys.c                   | 250 ---------------------
 6 files changed, 281 insertions(+), 288 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/pcie-designware-pltfm.txt
 delete mode 100644 Documentation/devicetree/bindings/pci/pcie-synopsys.txt
 create mode 100644 drivers/pci/host/pcie-designware-pltfm.c
 delete mode 100644 drivers/pci/host/pcie-synopsys.c

diff --git a/Documentation/devicetree/bindings/pci/pcie-designware-pltfm.txt b/Documentation/devicetree/bindings/pci/pcie-designware-pltfm.txt
new file mode 100644
index 0000000..77b2637
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/pcie-designware-pltfm.txt
@@ -0,0 +1,37 @@
+Synopsys PCI RC IP Reference plaftform driver
+---------------------------------------------
+
+This is the reference platform driver to be used in the Synopsys PCI Root
+Complex IP.
+
+Required properties:
+- compatible: set to "snps,pcie-dw-platform" or "snps,pcie-dw-ipk" or
+"pcie-dw-haps-prototyping";
+- reg: base address and length of the pcie controller registers and
+configuration address space.
+- reg-names: Must be "config" for the PCIe configuration space.
+- #address-cells: set to <3>.
+- #size-cells: set to <2>.
+- device_type: set to "pci".
+- ranges: ranges for the PCI memory and I/O regions.
+- interrupts: one interrupt source for MSI interrupts, followed by interrupt
+	source for hardware related interrupts.
+- #interrupt-cells: set to <1>.
+- num-lanes: set to <1>.
+
+Example configuration:
+
+	pcie: pcie@0xdffff000 {
+		compatible = "snps,pcie-dw-platform";
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
diff --git a/Documentation/devicetree/bindings/pci/pcie-synopsys.txt b/Documentation/devicetree/bindings/pci/pcie-synopsys.txt
deleted file mode 100644
index f18507c..0000000
--- a/Documentation/devicetree/bindings/pci/pcie-synopsys.txt
+++ /dev/null
@@ -1,33 +0,0 @@
-Synopsys PCI RC IP Prototyping Kit
-----------------------------------
-
-This is the reference platform driver to be used in the Synopsys PCI Root
-Complex IP Prototyping Kit.
-
-Required properties:
-- compatible: set to "snps,pcie-synopsys";
-- reg: base address and length of the pcie controller registers.
-- #address-cells: set to <3>
-- #size-cells: set to <2>
-- device_type: set to "pci"
-- ranges: ranges for the PCI memory and I/O regions.
-- interrupts: one interrupt source for MSI interrupts, followed by interrupt
-	source for hardware related interrupts.
-- #interrupt-cells: set to <1>
-- num-lanes: set to <1>;
-
-Example configuration:
-
-	pcie: pcie@0xdffff000 {
-		compatible = "snps,pcie-synopsys";
-		reg = <0xdffff000 0x1000>;
-		#address-cells = <3>;
-		#size-cells = <2>;
-		device_type = "pci";
-		ranges = <0x00000800 0 0xd0000000 0xd0000000 0 0x00002000>,
-			 <0x81000000 0 0x00000000 0xde000000 0 0x00010000>,
-			 <0x82000000 0 0xd0400000 0xd0400000 0 0x0d000000>;
-		interrupts = <25>, <24>;
-		#interrupt-cells = <1>;
-		num-lanes = <1>;
-	};
diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 0e62e58..29a2ac4 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -191,12 +191,12 @@ config PCIE_QCOM
 	  PCIe controller uses the Designware core plus Qualcomm-specific
 	  hardware wrappers.
 
-config PCIE_SYNOPSYS
-	bool "Platform Driver for Synopsys Device"
+config PCIE_DW_PLAT
+	bool "Generic Platform Driver for DesignWare PCIe RC"
 	depends on ARC && OF
 	select PCIEPORTBUS
 	select PCIE_DW
 	help
-	  Say Y here if you want to enable PCIe controller support on the
-	  Synopsys IP Prototyping Kits.
+	  Say Y here if you want to use the generic platform driver for
+	  DesignWare PCIe RC IP.
 endmenu
diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
index f9d9307..0906e93 100644
--- a/drivers/pci/host/Makefile
+++ b/drivers/pci/host/Makefile
@@ -22,4 +22,4 @@ obj-$(CONFIG_PCIE_ALTERA) += pcie-altera.o
 obj-$(CONFIG_PCIE_ALTERA_MSI) += pcie-altera-msi.o
 obj-$(CONFIG_PCI_HISI) += pcie-hisi.o
 obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o
-obj-$(CONFIG_PCIE_SYNOPSYS) += pcie-synopsys.o
+obj-$(CONFIG_PCIE_DW_PLAT) += pcie-designware-pltfm.o
diff --git a/drivers/pci/host/pcie-designware-pltfm.c b/drivers/pci/host/pcie-designware-pltfm.c
new file mode 100644
index 0000000..2fb8bcb
--- /dev/null
+++ b/drivers/pci/host/pcie-designware-pltfm.c
@@ -0,0 +1,239 @@
+/*
+ * PCIe RC driver for Synopsys Designware Core
+ *
+ * Copyright (C) 2015-2016 Synopsys, Inc. (www.synopsys.com)
+ *
+ * Authors: Manjunath Bettegowda <manjumb@synopsys.com>
+ *	    Jie Deng <jiedeng@synopsys.com>
+ *	    Joao Pinto <jpinto@synopsys.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/resource.h>
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
+#define PCI_EQUAL_CONTROL_PHY		0x00000707
+#define PCIE_PHY_DEBUG_R1_LINK_UP	0x00000010
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
+	int retries;
+
+	/* wait for link to come up */
+	for (retries = 0; retries < 10; retries++) {
+		if (dw_pcie_link_up(pp)) {
+			dev_info(pp->dev, "Link up\n");
+			return;
+		}
+		msleep(100);
+	}
+
+	dev_err(pp->dev, "Link fail\n");
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
+	if (pp->irq < 0)
+		return pp->irq;
+
+	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+		pp->msi_irq = platform_get_irq(pdev, 0);
+		if (pp->msi_irq < 0)
+			return pp->msi_irq;
+
+		ret = devm_request_irq(&pdev->dev, pp->msi_irq,
+					dw_pltfm_pcie_msi_irq_handler,
+					IRQF_SHARED, "dw_pltfm-pcie-msi", pp);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to request MSI IRQ %d\n",
+				pp->msi_irq);
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
+ * This function gets called as part of PCIe registration. If the ID matches
+ * the platform driver framework will call this function.
+ *
+ * @pdev: Pointer to the platform_device structure
+ *
+ * Returns zero on success; Negative errno on failure
+ */
+static int dw_pltfm_pcie_probe(struct platform_device *pdev)
+{
+	struct dw_pltfm_pcie *dw_pltfm_pcie;
+	struct pcie_port *pp;
+	struct resource *res;
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
+	{ .compatible = "snps,pcie-dw-platform", },
+	{ .compatible = "snps,pcie-dw-ipk", },
+	{ .compatible = "pcie-dw-haps-prototyping", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, dw_pltfm_pcie_of_match);
+
+static struct platform_driver dw_pltfm_pcie_driver = {
+	.driver = {
+		.name	= "pcie-designware-pltfm",
+		.of_match_table = dw_pltfm_pcie_of_match,
+	},
+	.probe = dw_pltfm_pcie_probe,
+};
+
+module_platform_driver(dw_pltfm_pcie_driver);
+
+MODULE_AUTHOR("Manjunath Bettegowda <manjumb@synopsys.com>");
+MODULE_DESCRIPTION("DesignWare PCIe host controller platform driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/pci/host/pcie-synopsys.c b/drivers/pci/host/pcie-synopsys.c
deleted file mode 100644
index 757ba30..0000000
--- a/drivers/pci/host/pcie-synopsys.c
+++ /dev/null
@@ -1,250 +0,0 @@
-/*
- * PCIe RC driver for Synopsys Designware Core
- *
- * Copyright (C) 2015-2016 Synopsys, Inc. (www.synopsys.com)
- *
- * Authors: Manjunath Bettegowda <manjumb@synopsys.com>
- *	    Jie Deng <jiedeng@synopsys.com>
- *	    Joao Pinto <jpinto@synopsys.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/delay.h>
-#include <linux/interrupt.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/pci.h>
-#include <linux/platform_device.h>
-#include <linux/resource.h>
-#include <linux/types.h>
-
-#include "pcie-designware.h"
-
-#define to_synopsys_pcie(x)	container_of(x, struct synopsys_pcie, pp)
-
-struct synopsys_pcie {
-	void __iomem		*mem_base; /* Memory Base to access Core's [RC]
-					    * Config Space Layout
-					    */
-	struct pcie_port	pp;        /* RC Root Port specific structure -
-					    * DWC_PCIE_RC stuff
-					    */
-};
-
-#define PCI_EQUAL_CONTROL_PHY		0x00000707
-#define PCIE_PHY_DEBUG_R1_LINK_UP	0x00000010
-
-/* PCIe Port Logic registers (memory-mapped) */
-#define PLR_OFFSET 0x700
-#define PCIE_PHY_DEBUG_R0 (PLR_OFFSET + 0x28) /* 0x728 */
-#define PCIE_PHY_DEBUG_R1 (PLR_OFFSET + 0x2c) /* 0x72c */
-
-/* This handler was created for future work */
-static irqreturn_t synopsys_pcie_irq_handler(int irq, void *arg)
-{
-	return IRQ_NONE;
-}
-
-static irqreturn_t synopsys_pcie_msi_irq_handler(int irq, void *arg)
-{
-	struct pcie_port *pp = arg;
-
-	return dw_handle_msi_irq(pp);
-}
-
-static void synopsys_pcie_init_phy(struct pcie_port *pp)
-{
-	/* write Lane 0 Equalization Control fields register */
-	writel(PCI_EQUAL_CONTROL_PHY, pp->dbi_base + 0x154);
-}
-
-static int synopsys_pcie_deassert_core_reset(struct pcie_port *pp)
-{
-	return 0;
-}
-
-static void synopsys_pcie_establish_link(struct pcie_port *pp)
-{
-	int retries;
-
-	/* wait for link to come up */
-	for (retries = 0; retries < 10; retries++) {
-		if (dw_pcie_link_up(pp)) {
-			dev_info(pp->dev, "Link up\n");
-			return;
-		}
-		mdelay(100);
-	}
-
-	dev_err(pp->dev, "Link fail\n");
-}
-
-/*
- * synopsys_pcie_host_init()
- * Platform specific host/RC initialization
- *	a. Assert the core reset
- *	b. Assert and deassert phy reset and initialize the phy
- *	c. De-Assert the core reset
- *	d. Initializet the Root Port (BARs/Memory Or IO/ Interrupt/ Commnad Reg)
- *	e. Initiate Link startup procedure
- *
- */
-static void synopsys_pcie_host_init(struct pcie_port *pp)
-{
-	/* Initialize Phy (Reset/poweron/control-inputs ) */
-	synopsys_pcie_init_phy(pp);
-
-	synopsys_pcie_deassert_core_reset(pp);
-
-	dw_pcie_setup_rc(pp);
-
-	synopsys_pcie_establish_link(pp);
-
-	if (IS_ENABLED(CONFIG_PCI_MSI))
-		dw_pcie_msi_init(pp);
-}
-
-static int synopsys_pcie_link_up(struct pcie_port *pp)
-{
-	u32 val;
-
-	val = readl(pp->dbi_base + PCIE_PHY_DEBUG_R1);
-	return val & PCIE_PHY_DEBUG_R1_LINK_UP;
-}
-
-/**
- * This is RC operation structure
- * synopsys_pcie_link_up: the function which initiates the phy link up procedure
- * synopsys_pcie_host_init: the function which does the host/RC Root port
- * initialization.
- */
-static struct pcie_host_ops synopsys_pcie_host_ops = {
-	.link_up = synopsys_pcie_link_up,
-	.host_init = synopsys_pcie_host_init,
-};
-
-/**
- * synopsys_add_pcie_port
- * This function
- * a. installs the interrupt handler
- * b. registers host operations in the pcie_port structure
- */
-static int synopsys_add_pcie_port(struct pcie_port *pp,
-				 struct platform_device *pdev)
-{
-	int ret;
-
-	pp->irq = platform_get_irq(pdev, 1);
-	if (pp->irq < 0)
-		return pp->irq;
-
-	ret = devm_request_irq(&pdev->dev, pp->irq, synopsys_pcie_irq_handler,
-				IRQF_SHARED, "synopsys-pcie", pp);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to request IRQ %d\n", pp->irq);
-		return ret;
-	}
-
-	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-		pp->msi_irq = platform_get_irq(pdev, 0);
-		if (pp->msi_irq < 0)
-			return pp->msi_irq;
-
-		ret = devm_request_irq(&pdev->dev, pp->msi_irq,
-					synopsys_pcie_msi_irq_handler,
-					IRQF_SHARED, "synopsys-pcie-msi", pp);
-		if (ret) {
-			dev_err(&pdev->dev, "failed to request MSI IRQ %d\n",
-				pp->msi_irq);
-			return ret;
-		}
-	}
-
-	pp->root_bus_nr = -1;
-	pp->ops = &synopsys_pcie_host_ops;
-
-	/* Below function:
-	 * Checks for range property from DT
-	 * Gets the IO and MEMORY and CONFIG-Space ranges from DT
-	 * Does IOREMAPS on the physical addresses
-	 * Gets the num-lanes from DT
-	 * Gets MSI capability from DT
-	 * Calls the platform specific host initialization
-	 * Program the correct class, BAR0, Link width, in Config space
-	 * Then it calls pci common init routine
-	 * Then it calls function to assign "unassigned resources"
-	 */
-	ret = dw_pcie_host_init(pp);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to initialize host\n");
-		return ret;
-	}
-
-	return 0;
-}
-
-/**
- * synopsys_pcie_probe()
- * This function gets called as part of PCIe registration. If the ID matches
- * the platform driver framework will call this function.
- *
- * @pdev: Pointer to the platform_device structure
- *
- * Returns zero on success; Negative errno on failure
- */
-static int synopsys_pcie_probe(struct platform_device *pdev)
-{
-	struct synopsys_pcie *synopsys_pcie;
-	struct pcie_port *pp;
-	struct resource *res;
-	int ret;
-
-	synopsys_pcie = devm_kzalloc(&pdev->dev, sizeof(*synopsys_pcie),
-					GFP_KERNEL);
-	if (!synopsys_pcie)
-		return -ENOMEM;
-
-	pp = &synopsys_pcie->pp;
-	pp->dev = &pdev->dev;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENODEV;
-
-	synopsys_pcie->mem_base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(synopsys_pcie->mem_base))
-		return PTR_ERR(synopsys_pcie->mem_base);
-
-	pp->dbi_base = synopsys_pcie->mem_base;
-
-	ret = synopsys_add_pcie_port(pp, pdev);
-	if (ret < 0)
-		return ret;
-
-	platform_set_drvdata(pdev, synopsys_pcie);
-
-	return 0;
-}
-
-static const struct of_device_id synopsys_pcie_of_match[] = {
-	{ .compatible = "snps,pcie-synopsys", },
-	{},
-};
-MODULE_DEVICE_TABLE(of, synopsys_pcie_of_match);
-
-static struct platform_driver synopsys_pcie_driver = {
-	.driver = {
-		.name	= "pcie-synopsys",
-		.of_match_table = synopsys_pcie_of_match,
-	},
-	.probe = synopsys_pcie_probe,
-};
-
-module_platform_driver(synopsys_pcie_driver);
-
-MODULE_AUTHOR("Manjunath Bettegowda <manjumb@synopsys.com>");
-MODULE_DESCRIPTION("Synopsys PCIe host controller driver");
-MODULE_LICENSE("GPL v2");
-- 
1.8.1.5
