Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1blp0189.outbound.protection.outlook.com ([207.46.163.189]:17353
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753589AbaIDKpO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 4 Sep 2014 06:45:14 -0400
From: Minghuan Lian <Minghuan.Lian@freescale.com>
To: <linux-pci@vger.kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>,
	Zang Roy-R61911 <r61911@freescale.com>,
	Hu Mingkai-B21284 <B21284@freescale.com>,
	"Minghuan Lian" <Minghuan.Lian@freescale.com>
Subject: [PATCH 2/2] PCI: Layerscape: Add Layerscape PCIe driver
Date: Thu, 4 Sep 2014 18:45:38 +0000
Message-ID: <1409856338-1730-2-git-send-email-Minghuan.Lian@freescale.com>
In-Reply-To: <1409856338-1730-1-git-send-email-Minghuan.Lian@freescale.com>
References: <1409856338-1730-1-git-send-email-Minghuan.Lian@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add support for Freescale Layerscape PCIe controller. This driver
re-uses the designware core code.

Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
---
 .../devicetree/bindings/pci/fsl,ls-pcie.txt        |  41 +++
 drivers/pci/host/Kconfig                           |   7 +
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pci-layerscape.c                  | 315 +++++++++++++++++++++
 include/linux/pci_ids.h                            |   1 +
 5 files changed, 365 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/fsl,ls-pcie.txt
 create mode 100644 drivers/pci/host/pci-layerscape.c

diff --git a/Documentation/devicetree/bindings/pci/fsl,ls-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,ls-pcie.txt
new file mode 100644
index 0000000..af2ee1c0
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/fsl,ls-pcie.txt
@@ -0,0 +1,41 @@
+Freescale Layerscape PCIe controller
+
+This PCIe host controller is based on the Synopsis Designware PCIe IP
+and thus inherits all the common properties defined in designware-pcie.txt.
+
+Required properties:
+- compatible: should contain "fsl,ls-pcie", to identify the platform,
+  plus an identifier for specific instance such as "fsl,ls1021a-pcie"
+- reg: base addresses and lengths of the PCIe controller
+- interrupts: A list of interrupt outputs of the controller. Must contain an
+  entry for each entry in the interrupt-names property.
+- interrupt-names: Must include the following entries:
+  "intr": The interrupt that is asserted for controller interrupts
+  "msi": The interrupt that is asserted when an MSI is received
+  "pme": The interrupt that is asserted when PME state changes
+
+Example:
+
+	pcie@3400000 {
+		compatible = "fsl,ls1021a-pcie", "fsl,ls-pcie", "snps,dw-pcie";
+		reg = <0x00 0x03400000 0x0 0x00010000   /* controller registers */
+		       0x40 0x00000000 0x0 0x00080000>; /* configuration space */
+		reg-names = "regs", "config";
+		interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>, /* controller interrupt */
+			     <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>, /* MSI interrupt */
+			     <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>; /* PME interrupt */
+		interrupt-names = "intr", "msi", "pme";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		device_type = "pci";
+		num-lanes = <4>;
+		bus-range = <0x0 0xff>;
+		ranges = <0x81000000 0x0 0x00000000 0x40 0x10000000 0x0 0x00010000   /* downstream I/O */
+			  0x82000000 0x0 0x00000000 0x41 0x00000000 0x1 0x00000000>; /* non-prefetchable memory */
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0000 0 0 1 &gic GIC_SPI 91  IRQ_TYPE_LEVEL_HIGH>,
+				<0000 0 0 2 &gic GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>,
+				<0000 0 0 3 &gic GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
+				<0000 0 0 4 &gic GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
+	};
diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 8922c37..e0d7bbf 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -63,4 +63,11 @@ config PCIE_SPEAR13XX
 	help
 	  Say Y here if you want PCIe support on SPEAr13XX SoCs.
 
+config PCI_LAYERSCAPE
+	bool "Freescale Layerscape PCIe controller"
+	depends on SOC_LS1021A
+	select PCIE_DW
+	help
+	  Say Y here if you want PCIe controller support on Layerscape SoCs.
+
 endmenu
diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
index d0e88f1..54cd9b2 100644
--- a/drivers/pci/host/Makefile
+++ b/drivers/pci/host/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_PCI_RCAR_GEN2) += pci-rcar-gen2.o
 obj-$(CONFIG_PCI_RCAR_GEN2_PCIE) += pcie-rcar.o
 obj-$(CONFIG_PCI_HOST_GENERIC) += pci-host-generic.o
 obj-$(CONFIG_PCIE_SPEAR13XX) += pcie-spear13xx.o
+obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o
diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
new file mode 100644
index 0000000..077a20b
--- /dev/null
+++ b/drivers/pci/host/pci-layerscape.c
@@ -0,0 +1,315 @@
+/*
+ * PCIe host controller driver for Freescale Layerscape SoCs
+ *
+ * Copyright (C) 2014 Freescale Semiconductor.
+ *
+  * Author: Minghuan Lian <Minghuan.Lian@freescale.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/of_pci.h>
+#include <linux/of_platform.h>
+#include <linux/of_irq.h>
+#include <linux/of_address.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/resource.h>
+
+#include "pcie-designware.h"
+
+/* PEX1/2 Misc Ports Status Register */
+#define PEXMSCPORTSR(pex_idx)	(0x94 + (pex_idx) * 4)
+#define LTSSM_STATE_SHIFT	20
+#define LTSSM_STATE_MASK	0x3f
+#define LTSSM_PCIE_L0		0x11 /* L0 state */
+
+#define SCFG_SPIMSICR_OFF	0x40
+#define SCFG_SPIMSICR_ADDR	0x1570040
+#define SCFG_SPIMSICLRCR_OFF	0x90
+#define SCFG_SCFGREVCR_OFF	0x200
+#define SCFG_BIT_REVERSE	0xFFFFFFFF
+#define SCFG_NO_BIT_REVERSE	0x0
+
+#define MSI_LS1021A_DATA(pex_idx)	(0xb3 + pex_idx)
+
+/* Symbol Timer Register and Filter Mask Register 1 */
+#define PCIE_STRFMR1 0x71c
+
+#define PCIE_LS1021A_BASE	0x3400000
+#define PCIE_LS1021A_REG_SIZE	0x0100000
+
+struct ls_pcie {
+	struct list_head node;
+	struct device *dev;
+	struct pci_bus *bus;
+	void __iomem *dbi;
+	void __iomem *scfg;
+	struct pcie_port pp;
+	int id;
+	int index;
+	int irq;
+	int msi_irq;
+	int pme_irq;
+};
+
+static LIST_HEAD(ls_pcie_list);
+
+#define to_ls_pcie(x)	container_of(x, struct ls_pcie, pp)
+
+static int ls_pcie_link_up(struct pcie_port *pp)
+{
+	u32 rc, tmp;
+	struct ls_pcie *pcie = to_ls_pcie(pp);
+
+	tmp = ioread32(pcie->scfg + SCFG_SCFGREVCR_OFF);
+	iowrite32(SCFG_NO_BIT_REVERSE, pcie->scfg + SCFG_SCFGREVCR_OFF);
+
+	rc = (ioread32(pcie->scfg + PEXMSCPORTSR(pcie->index)) >>
+	     LTSSM_STATE_SHIFT) & LTSSM_STATE_MASK;
+
+	iowrite32(tmp, pcie->scfg + SCFG_SCFGREVCR_OFF);
+
+	if (rc < LTSSM_PCIE_L0)
+		return 0;
+
+	return 1;
+}
+
+static u32 ls_pcie_get_msi_addr(struct pcie_port *pp)
+{
+	return SCFG_SPIMSICR_ADDR;
+}
+
+static u32 ls_pcie_get_msi_data(struct pcie_port *pp, int pos)
+{
+	struct ls_pcie *pcie = to_ls_pcie(pp);
+
+	if (pcie->id == PCI_DEVICE_ID_LS1021A)
+		return MSI_LS1021A_DATA(pcie->index);
+
+	return pos;
+}
+
+static irqreturn_t ls_pcie_msi_irq_handler(int irq, void *data)
+{
+	struct pcie_port *pp = data;
+	struct ls_pcie *pcie = to_ls_pcie(pp);
+	unsigned int msi_irq, processed = 0;
+
+	if (pcie->id == PCI_DEVICE_ID_LS1021A) {
+		/* clear the interrupt */
+		iowrite32(MSI_LS1021A_DATA(pcie->index),
+			  pcie->scfg + SCFG_SPIMSICLRCR_OFF);
+
+		msi_irq = irq_find_mapping(pp->irq_domain, 0);
+		if (msi_irq)
+			generic_handle_irq(msi_irq);
+		else
+			/*
+			 * that's weird who triggered this?
+			 * just clear it
+			 */
+			dev_info(pcie->dev, "unexpected MSI\n");
+
+		processed++;
+	}
+
+	return processed > 0 ? IRQ_HANDLED : IRQ_NONE;
+}
+
+static void ls_pcie_msi_clear_irq(struct pcie_port *pp, int irq)
+{
+}
+
+static void ls_pcie_msi_set_irq(struct pcie_port *pp, int irq)
+{
+	struct ls_pcie *pcie = to_ls_pcie(pp);
+
+	/* MSI needs to set SCFG bit reverse */
+	iowrite32(SCFG_BIT_REVERSE, pcie->scfg + SCFG_SCFGREVCR_OFF);
+}
+
+static void ls_pcie_msi_fixup(struct pcie_port *pp)
+{
+	struct ls_pcie *pcie = to_ls_pcie(pp);
+	int i;
+
+	if (pcie->id != PCI_DEVICE_ID_LS1021A)
+		return;
+
+	/**
+	 * LS1021A has only one MSI interrupt
+	 * Set all msi interrupts as used except the first one
+	 */
+	for (i = 1; i < MAX_MSI_IRQS; i++)
+		set_bit(i, pp->msi_irq_in_use);
+}
+
+static void ls_pcie_host_init(struct pcie_port *pp)
+{
+	struct ls_pcie *pcie = to_ls_pcie(pp);
+	int count = 0;
+	u32 val;
+
+	dw_pcie_setup_rc(pp);
+
+	while (!ls_pcie_link_up(pp)) {
+		usleep_range(100, 1000);
+		count++;
+		if (count >= 200) {
+			dev_err(pp->dev, "phy link never came up\n");
+			return;
+		}
+	}
+
+	/* Workaround for internal TKT228622 to fix the INTx hang issue */
+	val = ioread32(pcie->dbi + PCIE_STRFMR1);
+	val &= 0xffff;
+	iowrite32(val, pcie->dbi + PCIE_STRFMR1);
+
+	ls_pcie_msi_fixup(pp);
+}
+
+static struct pcie_host_ops ls_pcie_host_ops = {
+	.link_up = ls_pcie_link_up,
+	.host_init = ls_pcie_host_init,
+	.msi_set_irq = ls_pcie_msi_set_irq,
+	.msi_clear_irq = ls_pcie_msi_clear_irq,
+	.get_msi_addr = ls_pcie_get_msi_addr,
+	.get_msi_data = ls_pcie_get_msi_data,
+};
+
+static int ls_add_pcie_port(struct ls_pcie *pcie)
+{
+	struct pcie_port *pp;
+	int ret;
+
+	if (!pcie)
+		return -EINVAL;
+
+	pp = &pcie->pp;
+	pp->dev = pcie->dev;
+	pp->dbi_base = pcie->dbi;
+	pp->msi_irq = pcie->msi_irq;
+
+	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+		ret = devm_request_irq(pp->dev, pp->msi_irq,
+					ls_pcie_msi_irq_handler,
+					IRQF_SHARED, "ls-pcie-msi", pp);
+		if (ret) {
+			dev_err(pp->dev, "failed to request msi irq\n");
+			return ret;
+		}
+	}
+
+	pp->root_bus_nr = -1;
+	pp->ops = &ls_pcie_host_ops;
+
+	ret = dw_pcie_host_init(pp);
+	if (ret) {
+		dev_err(pp->dev, "failed to initialize host\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int __init ls_pcie_probe(struct platform_device *pdev)
+{
+	struct ls_pcie *pcie;
+	struct resource *dbi_base;
+	struct device_node *np;
+	int ret;
+
+	pcie = devm_kzalloc(&pdev->dev, sizeof(*pcie), GFP_KERNEL);
+	if (!pcie)
+		return -ENOMEM;
+
+	pcie->dev = &pdev->dev;
+
+	dbi_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
+	if (!dbi_base) {
+		dev_err(&pdev->dev, "missing *regs* space\n");
+		return -ENODEV;
+	}
+
+	pcie->dbi = devm_ioremap_resource(&pdev->dev, dbi_base);
+	if (IS_ERR(pcie->dbi))
+		return PTR_ERR(pcie->dbi);
+
+	if (of_device_is_compatible(pdev->dev.of_node, "fsl,ls1021a-pcie")) {
+		pcie->id = PCI_DEVICE_ID_LS1021A;
+		pcie->index = (dbi_base->start - PCIE_LS1021A_BASE) /
+			      PCIE_LS1021A_REG_SIZE;
+
+		/* map SCFG register */
+		np = of_find_compatible_node(NULL, NULL, "fsl,ls1021a-scfg");
+		pcie->scfg = of_iomap(np, 0);
+		if (!pcie->scfg) {
+			dev_err(&pdev->dev, "unable to find SCFG registers\n");
+			return PTR_ERR(pcie->scfg);
+		}
+	}
+
+	/* request interrupt */
+	pcie->irq = platform_get_irq_byname(pdev, "intr");
+	if (pcie->irq < 0) {
+		dev_err(&pdev->dev, "failed to get IRQ: %d\n", pcie->irq);
+		return pcie->irq;
+	}
+
+	pcie->msi_irq = platform_get_irq_byname(pdev, "msi");
+	if (pcie->msi_irq < 0) {
+		dev_err(&pdev->dev,
+			"failed to get MSI IRQ: %d\n", pcie->msi_irq);
+		return pcie->msi_irq;
+	}
+
+	pcie->pme_irq = platform_get_irq_byname(pdev, "pme");
+	if (pcie->pme_irq < 0) {
+		dev_err(&pdev->dev,
+			"failed to get PME IRQ: %d\n", pcie->pme_irq);
+		return pcie->pme_irq;
+	}
+
+	ret = ls_add_pcie_port(pcie);
+	if (ret < 0)
+		return ret;
+
+	platform_set_drvdata(pdev, pcie);
+	list_add(&pcie->node, &ls_pcie_list);
+
+	return 0;
+}
+
+static const struct of_device_id ls_pcie_of_match[] = {
+	{ .compatible = "fsl,ls-pcie" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ls_pcie_of_match);
+
+static struct platform_driver ls_pcie_driver = {
+	.driver = {
+		.name = "layerscape-pcie",
+		.owner = THIS_MODULE,
+		.of_match_table = ls_pcie_of_match,
+	},
+};
+
+/* Freescale PCIe driver does not allow module unload */
+static int __init ls_pcie_init(void)
+{
+	return platform_driver_probe(&ls_pcie_driver, ls_pcie_probe);
+}
+subsys_initcall(ls_pcie_init);
+
+MODULE_AUTHOR("Minghuan Lian <Minghuan.Lian@freescale.com>");
+MODULE_DESCRIPTION("Freescale Layerscape PCIe host controller driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 6ed0bb7..26d4c30 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2442,6 +2442,7 @@
 #define PCI_DEVICE_ID_P5020		0x0421
 #define PCI_DEVICE_ID_P5010E		0x0428
 #define PCI_DEVICE_ID_P5010		0x0429
+#define PCI_DEVICE_ID_LS1021A		0x0e0b
 #define PCI_DEVICE_ID_MPC8641		0x7010
 #define PCI_DEVICE_ID_MPC8641D		0x7011
 #define PCI_DEVICE_ID_MPC8610		0x7018
-- 
1.9.1

