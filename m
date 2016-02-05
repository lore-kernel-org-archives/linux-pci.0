Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:57818 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754576AbcBETzt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 5 Feb 2016 14:55:49 -0500
From: Joao Pinto <Joao.Pinto@synopsys.com>
To: helgaas@kernel.org, arnd@arndb.de
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Vineet.Gupta1@synopsys.com, CARLOS.PALMINHA@synopsys.com,
	Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [PATCH v3] synopsys pcie rc generic platform driver update
Date: Fri,  5 Feb 2016 19:55:43 +0000
Message-Id: <28b04a32cc7caf6db542d4b5aa1feddacd02b2c9.1454701564.git.jpinto@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch tries to improve the host/pcie-synopsys branch including a new
driver name, more accurate documentation and centralized link up validation.
Other platform drivers were also updated to include the new centralized link
up validation function.

Signed-off-by: Joao Pinto <jpinto@synopsys.com>
---
Changes v2->v3:
 - Created a dw_pcie_wait_for_link_up() function in pcie-designware
 - Updated all the platform drivers that were using the link wait routine to
 use the pcie-designware'
 - Complemented pcie-designware-pltfm.txt with more info
 PS: not able to generate a "rename files merged diff" patch
Changes v1->v2:
 - Patch description was not correct
Changes v1:
 - driver name was changed from pcie-synopsys to pcie-designware-pltfm
 - mdelay() replaced for msleep() in the new driver
 - Devicetree bindings for the new driver was updated (config space 
 removed from ranges and new compatibility strings were introduced)
 - Unnecessary synopsys_pcie_irq_handler() was removed
 - Driver compatibility strings updated

 .../bindings/pci/pcie-designware-pltfm.txt         |  38 +++++++
 .../devicetree/bindings/pci/pcie-synopsys.txt      |  33 ------
 drivers/pci/host/Kconfig                           |   8 +-
 drivers/pci/host/Makefile                          |   2 +-
 drivers/pci/host/pci-dra7xx.c                      |   8 +-
 drivers/pci/host/pci-exynos.c                      |   9 +-
 drivers/pci/host/pci-imx6.c                        |   8 +-
 .../{pcie-synopsys.c => pcie-designware-pltfm.c}   | 114 ++++++++-------------
 drivers/pci/host/pcie-designware.c                 |  17 +++
 drivers/pci/host/pcie-designware.h                 |   1 +
 drivers/pci/host/pcie-qcom.c                       |   7 +-
 drivers/pci/host/pcie-spear13xx.c                  |  10 +-
 12 files changed, 116 insertions(+), 139 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/pcie-designware-pltfm.txt
 delete mode 100644 Documentation/devicetree/bindings/pci/pcie-synopsys.txt
 rename drivers/pci/host/{pcie-synopsys.c => pcie-designware-pltfm.c} (59%)

diff --git a/Documentation/devicetree/bindings/pci/pcie-designware-pltfm.txt b/Documentation/devicetree/bindings/pci/pcie-designware-pltfm.txt
new file mode 100644
index 0000000..1bbed35
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/pcie-designware-pltfm.txt
@@ -0,0 +1,38 @@
+Synopsys PCI RC IP Reference plaftform driver
+---------------------------------------------
+
+This is the reference platform driver to be used in the Synopsys PCI Root
+Complex IP.
+
+Required properties:
+- compatible: set to "pcie-dw"
+- reg: base address and length of the pcie controller registers and
+configuration address space (config declared second).
+- reg-names: Controller registers can be called "ctrlreg" but you can change 
+with no implications. The PCI config follows, and this one must be
+called "config".
+- #address-cells: set to <3>.
+- #size-cells: set to <2>.
+- device_type: set to "pci".
+- ranges: ranges for the PCI memory and I/O regions (by this order).
+- interrupts: one interrupt source for MSI interrupts, followed by interrupt
+	source for hardware related interrupts.
+- #interrupt-cells: set to <1>.
+- num-lanes: set to <1>.
+
+Example configuration:
+
+	pcie: pcie@0xdffff000 {
+		compatible = "pcie-dw";
+		reg = <0xdffff000 0x1000>,
+		      <0xd0000000 0x2000>;
+		reg-names = "ctrlreg", "config";
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
diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
index 923607b..1864956 100644
--- a/drivers/pci/host/pci-dra7xx.c
+++ b/drivers/pci/host/pci-dra7xx.c
@@ -119,11 +119,9 @@ static int dra7xx_pcie_establish_link(struct pcie_port *pp)
 	reg |= LTSSM_EN;
 	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_DEVICE_CMD, reg);
 
-	for (retries = 0; retries < 1000; retries++) {
-		if (dw_pcie_link_up(pp))
-			return 0;
-		usleep_range(10, 20);
-	}
+	/* check if the link is up or not */
+	if (dw_pcie_wait_for_link_up(pp, 10, 10))
+		return 0;
 
 	dev_err(pp->dev, "link is not up\n");
 	return -EINVAL;
diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
index d997d22..0b1f813 100644
--- a/drivers/pci/host/pci-exynos.c
+++ b/drivers/pci/host/pci-exynos.c
@@ -357,13 +357,8 @@ static int exynos_pcie_establish_link(struct pcie_port *pp)
 			  PCIE_APP_LTSSM_ENABLE);
 
 	/* check if the link is up or not */
-	for (retries = 0; retries < 10; retries++) {
-		if (dw_pcie_link_up(pp)) {
-			dev_info(pp->dev, "Link up\n");
-			return 0;
-		}
-		mdelay(100);
-	}
+	if (dw_pcie_wait_for_link_up(pp, 10, 100))
+		return 0;
 
 	while (exynos_phy_readl(exynos_pcie, PCIE_PHY_PLL_LOCKED) == 0) {
 		val = exynos_blk_readl(exynos_pcie, PCIE_PHY_PLL_LOCKED);
diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index fe60096..4c6e64f 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -332,11 +332,9 @@ static int imx6_pcie_wait_for_link(struct pcie_port *pp)
 {
 	unsigned int retries;
 
-	for (retries = 0; retries < 200; retries++) {
-		if (dw_pcie_link_up(pp))
-			return 0;
-		usleep_range(100, 1000);
-	}
+	/* check if the link is up or not */
+	if (dw_pcie_wait_for_link_up(pp, 200, 1))
+		return 0;
 
 	dev_err(pp->dev, "phy link never came up\n");
 	dev_dbg(pp->dev, "DEBUG_R0: 0x%08x, DEBUG_R1: 0x%08x\n",
diff --git a/drivers/pci/host/pcie-synopsys.c b/drivers/pci/host/pcie-designware-pltfm.c
similarity index 59%
rename from drivers/pci/host/pcie-synopsys.c
rename to drivers/pci/host/pcie-designware-pltfm.c
index 757ba30..3e765e0 100644
--- a/drivers/pci/host/pcie-synopsys.c
+++ b/drivers/pci/host/pcie-designware-pltfm.c
@@ -23,9 +23,9 @@
 
 #include "pcie-designware.h"
 
-#define to_synopsys_pcie(x)	container_of(x, struct synopsys_pcie, pp)
+#define to_dw_pltfm_pcie(x)	container_of(x, struct dw_pltfm_pcie, pp)
 
-struct synopsys_pcie {
+struct dw_pltfm_pcie {
 	void __iomem		*mem_base; /* Memory Base to access Core's [RC]
 					    * Config Space Layout
 					    */
@@ -42,48 +42,26 @@ struct synopsys_pcie {
 #define PCIE_PHY_DEBUG_R0 (PLR_OFFSET + 0x28) /* 0x728 */
 #define PCIE_PHY_DEBUG_R1 (PLR_OFFSET + 0x2c) /* 0x72c */
 
-/* This handler was created for future work */
-static irqreturn_t synopsys_pcie_irq_handler(int irq, void *arg)
-{
-	return IRQ_NONE;
-}
-
-static irqreturn_t synopsys_pcie_msi_irq_handler(int irq, void *arg)
+static irqreturn_t dw_pltfm_pcie_msi_irq_handler(int irq, void *arg)
 {
 	struct pcie_port *pp = arg;
 
 	return dw_handle_msi_irq(pp);
 }
 
-static void synopsys_pcie_init_phy(struct pcie_port *pp)
+static void dw_pltfm_pcie_init_phy(struct pcie_port *pp)
 {
 	/* write Lane 0 Equalization Control fields register */
 	writel(PCI_EQUAL_CONTROL_PHY, pp->dbi_base + 0x154);
 }
 
-static int synopsys_pcie_deassert_core_reset(struct pcie_port *pp)
+static int dw_pltfm_pcie_deassert_core_reset(struct pcie_port *pp)
 {
 	return 0;
 }
 
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
-		msleep(100);
-	}
-
-	dev_err(pp->dev, "Link fail\n");
-}
-
 /*
- * synopsys_pcie_host_init()
+ * dw_pltfm_pcie_host_init()
  * Platform specific host/RC initialization
  *	a. Assert the core reset
  *	b. Assert and deassert phy reset and initialize the phy
@@ -92,22 +70,23 @@ static void synopsys_pcie_establish_link(struct pcie_port *pp)
  *	e. Initiate Link startup procedure
  *
  */
-static void synopsys_pcie_host_init(struct pcie_port *pp)
+static void dw_pltfm_pcie_host_init(struct pcie_port *pp)
 {
 	/* Initialize Phy (Reset/poweron/control-inputs ) */
-	synopsys_pcie_init_phy(pp);
+	dw_pltfm_pcie_init_phy(pp);
 
-	synopsys_pcie_deassert_core_reset(pp);
+	dw_pltfm_pcie_deassert_core_reset(pp);
 
 	dw_pcie_setup_rc(pp);
 
-	synopsys_pcie_establish_link(pp);
+	if (!dw_pcie_wait_for_link_up(pp, 10, 100))
+		dev_err(pp->dev, "Link fail\n");
 
 	if (IS_ENABLED(CONFIG_PCI_MSI))
 		dw_pcie_msi_init(pp);
 }
 
-static int synopsys_pcie_link_up(struct pcie_port *pp)
+static int dw_pltfm_pcie_link_up(struct pcie_port *pp)
 {
 	u32 val;
 
@@ -117,22 +96,22 @@ static int synopsys_pcie_link_up(struct pcie_port *pp)
 
 /**
  * This is RC operation structure
- * synopsys_pcie_link_up: the function which initiates the phy link up procedure
- * synopsys_pcie_host_init: the function which does the host/RC Root port
+ * dw_pltfm_pcie_link_up: the function which initiates the phy link up procedure
+ * dw_pltfm_pcie_host_init: the function which does the host/RC Root port
  * initialization.
  */
-static struct pcie_host_ops synopsys_pcie_host_ops = {
-	.link_up = synopsys_pcie_link_up,
-	.host_init = synopsys_pcie_host_init,
+static struct pcie_host_ops dw_pltfm_pcie_host_ops = {
+	.link_up = dw_pltfm_pcie_link_up,
+	.host_init = dw_pltfm_pcie_host_init,
 };
 
 /**
- * synopsys_add_pcie_port
+ * dw_pltfm_add_pcie_port
  * This function
  * a. installs the interrupt handler
  * b. registers host operations in the pcie_port structure
  */
-static int synopsys_add_pcie_port(struct pcie_port *pp,
+static int dw_pltfm_add_pcie_port(struct pcie_port *pp,
 				 struct platform_device *pdev)
 {
 	int ret;
@@ -141,21 +120,14 @@ static int synopsys_add_pcie_port(struct pcie_port *pp,
 	if (pp->irq < 0)
 		return pp->irq;
 
-	ret = devm_request_irq(&pdev->dev, pp->irq, synopsys_pcie_irq_handler,
-				IRQF_SHARED, "synopsys-pcie", pp);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to request IRQ %d\n", pp->irq);
-		return ret;
-	}
-
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		pp->msi_irq = platform_get_irq(pdev, 0);
 		if (pp->msi_irq < 0)
 			return pp->msi_irq;
 
 		ret = devm_request_irq(&pdev->dev, pp->msi_irq,
-					synopsys_pcie_msi_irq_handler,
-					IRQF_SHARED, "synopsys-pcie-msi", pp);
+					dw_pltfm_pcie_msi_irq_handler,
+					IRQF_SHARED, "dw_pltfm-pcie-msi", pp);
 		if (ret) {
 			dev_err(&pdev->dev, "failed to request MSI IRQ %d\n",
 				pp->msi_irq);
@@ -164,7 +136,7 @@ static int synopsys_add_pcie_port(struct pcie_port *pp,
 	}
 
 	pp->root_bus_nr = -1;
-	pp->ops = &synopsys_pcie_host_ops;
+	pp->ops = &dw_pltfm_pcie_host_ops;
 
 	/* Below function:
 	 * Checks for range property from DT
@@ -187,7 +159,7 @@ static int synopsys_add_pcie_port(struct pcie_port *pp,
 }
 
 /**
- * synopsys_pcie_probe()
+ * dw_pltfm_pcie_probe()
  * This function gets called as part of PCIe registration. If the ID matches
  * the platform driver framework will call this function.
  *
@@ -195,56 +167,56 @@ static int synopsys_add_pcie_port(struct pcie_port *pp,
  *
  * Returns zero on success; Negative errno on failure
  */
-static int synopsys_pcie_probe(struct platform_device *pdev)
+static int dw_pltfm_pcie_probe(struct platform_device *pdev)
 {
-	struct synopsys_pcie *synopsys_pcie;
+	struct dw_pltfm_pcie *dw_pltfm_pcie;
 	struct pcie_port *pp;
 	struct resource *res;
 	int ret;
 
-	synopsys_pcie = devm_kzalloc(&pdev->dev, sizeof(*synopsys_pcie),
+	dw_pltfm_pcie = devm_kzalloc(&pdev->dev, sizeof(*dw_pltfm_pcie),
 					GFP_KERNEL);
-	if (!synopsys_pcie)
+	if (!dw_pltfm_pcie)
 		return -ENOMEM;
 
-	pp = &synopsys_pcie->pp;
+	pp = &dw_pltfm_pcie->pp;
 	pp->dev = &pdev->dev;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res)
 		return -ENODEV;
 
-	synopsys_pcie->mem_base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(synopsys_pcie->mem_base))
-		return PTR_ERR(synopsys_pcie->mem_base);
+	dw_pltfm_pcie->mem_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(dw_pltfm_pcie->mem_base))
+		return PTR_ERR(dw_pltfm_pcie->mem_base);
 
-	pp->dbi_base = synopsys_pcie->mem_base;
+	pp->dbi_base = dw_pltfm_pcie->mem_base;
 
-	ret = synopsys_add_pcie_port(pp, pdev);
+	ret = dw_pltfm_add_pcie_port(pp, pdev);
 	if (ret < 0)
 		return ret;
 
-	platform_set_drvdata(pdev, synopsys_pcie);
+	platform_set_drvdata(pdev, dw_pltfm_pcie);
 
 	return 0;
 }
 
-static const struct of_device_id synopsys_pcie_of_match[] = {
-	{ .compatible = "snps,pcie-synopsys", },
+static const struct of_device_id dw_pltfm_pcie_of_match[] = {
+	{ .compatible = "snps,pcie-dw", },
 	{},
 };
-MODULE_DEVICE_TABLE(of, synopsys_pcie_of_match);
+MODULE_DEVICE_TABLE(of, dw_pltfm_pcie_of_match);
 
-static struct platform_driver synopsys_pcie_driver = {
+static struct platform_driver dw_pltfm_pcie_driver = {
 	.driver = {
-		.name	= "pcie-synopsys",
-		.of_match_table = synopsys_pcie_of_match,
+		.name	= "pcie-designware-pltfm",
+		.of_match_table = dw_pltfm_pcie_of_match,
 	},
-	.probe = synopsys_pcie_probe,
+	.probe = dw_pltfm_pcie_probe,
 };
 
-module_platform_driver(synopsys_pcie_driver);
+module_platform_driver(dw_pltfm_pcie_driver);
 
 MODULE_AUTHOR("Manjunath Bettegowda <manjumb@synopsys.com>");
-MODULE_DESCRIPTION("Synopsys PCIe host controller driver");
+MODULE_DESCRIPTION("DesignWare PCIe host controller platform driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 2171682..f675269 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -22,6 +22,7 @@
 #include <linux/pci_regs.h>
 #include <linux/platform_device.h>
 #include <linux/types.h>
+#include <linux/delay.h>
 
 #include "pcie-designware.h"
 
@@ -380,6 +381,22 @@ static struct msi_controller dw_pcie_msi_chip = {
 	.teardown_irq = dw_msi_teardown_irq,
 };
 
+int dw_pcie_wait_for_link_up(struct pcie_port *pp, int loops, int sleep_time)
+{
+	int retries = 0;
+
+	/* check if the link is up or not */
+	for (retries = 0; retries < loops; retries++) {
+		if (dw_pcie_link_up(pp)) {
+			dev_info(pp->dev, "Link up\n");
+			return 1;
+		}
+		mdelay(sleep_time);
+	}
+	
+	return 0;
+}
+
 int dw_pcie_link_up(struct pcie_port *pp)
 {
 	if (pp->ops->link_up)
diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
index 2356d29..5c141d2 100644
--- a/drivers/pci/host/pcie-designware.h
+++ b/drivers/pci/host/pcie-designware.h
@@ -76,6 +76,7 @@ int dw_pcie_cfg_read(void __iomem *addr, int size, u32 *val);
 int dw_pcie_cfg_write(void __iomem *addr, int size, u32 val);
 irqreturn_t dw_handle_msi_irq(struct pcie_port *pp);
 void dw_pcie_msi_init(struct pcie_port *pp);
+int dw_pcie_wait_for_link_up(struct pcie_port *pp, int loops, int sleep_time);
 int dw_pcie_link_up(struct pcie_port *pp);
 void dw_pcie_setup_rc(struct pcie_port *pp);
 int dw_pcie_host_init(struct pcie_port *pp);
diff --git a/drivers/pci/host/pcie-qcom.c b/drivers/pci/host/pcie-qcom.c
index e845fba..8adccfe 100644
--- a/drivers/pci/host/pcie-qcom.c
+++ b/drivers/pci/host/pcie-qcom.c
@@ -128,11 +128,8 @@ static int qcom_pcie_establish_link(struct qcom_pcie *pcie)
 	val |= PCIE20_ELBI_SYS_CTRL_LT_ENABLE;
 	writel(val, pcie->elbi + PCIE20_ELBI_SYS_CTRL);
 
-	do {
-		if (dw_pcie_link_up(&pcie->pp))
-			return 0;
-		usleep_range(250, 1000);
-	} while (retries < 200);
+	if (dw_pcie_wait_for_link_up(pp, 200, 1))
+		return 0;
 
 	dev_warn(dev, "phy link never came up\n");
 
diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/host/pcie-spear13xx.c
index a6cd823..15e89a8 100644
--- a/drivers/pci/host/pcie-spear13xx.c
+++ b/drivers/pci/host/pcie-spear13xx.c
@@ -13,7 +13,6 @@
  */
 
 #include <linux/clk.h>
-#include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -201,13 +200,8 @@ static int spear13xx_pcie_establish_link(struct pcie_port *pp)
 			&app_reg->app_ctrl_0);
 
 	/* check if the link is up or not */
-	for (retries = 0; retries < 10; retries++) {
-		if (dw_pcie_link_up(pp)) {
-			dev_info(pp->dev, "link up\n");
-			return 0;
-		}
-		mdelay(100);
-	}
+	if (dw_pcie_wait_for_link_up(pp, 10, 100))
+		return 0;
 
 	dev_err(pp->dev, "link Fail\n");
 	return -EINVAL;
-- 
1.8.1.5

