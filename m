Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:6988 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752046AbbCKSEF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Mar 2015 14:04:05 -0400
From: Ray Jui <rjui@broadcom.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Paul Bolle <pebolle@tiscali.nl>
CC: Florian Fainelli <f.fainelli@gmail.com>,
	Dmitry Torokhov <dtor@google.com>,
	Anatol Pomazau <anatol@google.com>,
	Scott Branden <sbranden@broadcom.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<bcm-kernel-feedback-list@broadcom.com>,
	<devicetree@vger.kernel.org>, "Ray Jui" <rjui@broadcom.com>
Subject: [PATCH v6 3/4] pci: iproc: Add Broadcom iProc PCIe support
Date: Wed, 11 Mar 2015 11:06:08 -0700
Message-ID: <1426097169-20805-4-git-send-email-rjui@broadcom.com>
In-Reply-To: <1426097169-20805-1-git-send-email-rjui@broadcom.com>
References: <1426097169-20805-1-git-send-email-rjui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This adds the support for Broadcom iProc PCIe controller

pcie-iproc.c servers as the common core driver, and front-end bus
interface needs to be added to support different bus interfaces

pcie-iproc-pltfm.c contains the support for the platform bus interface

Signed-off-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 drivers/pci/host/Kconfig            |   17 +++
 drivers/pci/host/Makefile           |    2 +
 drivers/pci/host/pcie-iproc-pltfm.c |  108 ++++++++++++++
 drivers/pci/host/pcie-iproc.c       |  268 +++++++++++++++++++++++++++++++++++
 drivers/pci/host/pcie-iproc.h       |   42 ++++++
 5 files changed, 437 insertions(+)
 create mode 100644 drivers/pci/host/pcie-iproc-pltfm.c
 create mode 100644 drivers/pci/host/pcie-iproc.c
 create mode 100644 drivers/pci/host/pcie-iproc.h

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 7b892a9..f4d9c90 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -106,4 +106,21 @@ config PCI_VERSATILE
 	bool "ARM Versatile PB PCI controller"
 	depends on ARCH_VERSATILE
 
+config PCIE_IPROC
+	tristate "Broadcom iProc PCIe controller"
+	help
+	  This enables the iProc PCIe core controller support for Broadcom's
+	  iProc family of SoCs. An appropriate bus interface driver also needs
+	  to be enabled
+
+config PCIE_IPROC_PLTFM
+	tristate "Broadcom iProc PCIe platform bus driver"
+	depends on ARCH_BCM_IPROC || COMPILE_TEST
+	depends on OF
+	select PCIE_IPROC
+	default ARCH_BCM_IPROC
+	help
+	  Say Y here if you want to use the Broadcom iProc PCIe controller
+	  through the generic platform bus interface
+
 endmenu
diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
index e61d91c..2e02d20 100644
--- a/drivers/pci/host/Makefile
+++ b/drivers/pci/host/Makefile
@@ -13,3 +13,5 @@ obj-$(CONFIG_PCIE_XILINX) += pcie-xilinx.o
 obj-$(CONFIG_PCI_XGENE) += pci-xgene.o
 obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o
 obj-$(CONFIG_PCI_VERSATILE) += pci-versatile.o
+obj-$(CONFIG_PCIE_IPROC) += pcie-iproc.o
+obj-$(CONFIG_PCIE_IPROC_PLTFM) += pcie-iproc-pltfm.o
diff --git a/drivers/pci/host/pcie-iproc-pltfm.c b/drivers/pci/host/pcie-iproc-pltfm.c
new file mode 100644
index 0000000..af935ea
--- /dev/null
+++ b/drivers/pci/host/pcie-iproc-pltfm.c
@@ -0,0 +1,108 @@
+/*
+ * Copyright (C) 2015 Broadcom Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/of_address.h>
+#include <linux/of_pci.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/phy/phy.h>
+
+#include "pcie-iproc.h"
+
+static int __init iproc_pcie_pltfm_probe(struct platform_device *pdev)
+{
+	struct iproc_pcie *pcie;
+	struct device_node *np = pdev->dev.of_node;
+	struct resource reg;
+	resource_size_t iobase = 0;
+	LIST_HEAD(res);
+	int ret;
+
+	pcie = devm_kzalloc(&pdev->dev, sizeof(struct iproc_pcie), GFP_KERNEL);
+	if (!pcie)
+		return -ENOMEM;
+
+	pcie->dev = &pdev->dev;
+	platform_set_drvdata(pdev, pcie);
+
+	ret = of_address_to_resource(np, 0, &reg);
+	if (ret < 0) {
+		dev_err(pcie->dev, "unable to obtain controller resources\n");
+		return ret;
+	}
+
+	pcie->base = devm_ioremap(pcie->dev, reg.start, resource_size(&reg));
+	if (!pcie->base) {
+		dev_err(pcie->dev, "unable to map controller registers\n");
+		return -ENOMEM;
+	}
+
+	/* PHY use is optional */
+	pcie->phy = devm_phy_get(&pdev->dev, "pcie-phy");
+	if (IS_ERR(pcie->phy)) {
+		if (PTR_ERR(pcie->phy) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+		pcie->phy = NULL;
+	}
+
+	ret = of_pci_get_host_bridge_resources(np, 0, 0xff, &res, &iobase);
+	if (ret) {
+		dev_err(pcie->dev,
+			"unable to get PCI host bridge resources\n");
+		return ret;
+	}
+
+	pcie->resources = &res;
+
+	ret = iproc_pcie_setup(pcie);
+	if (ret) {
+		dev_err(pcie->dev, "PCIe controller setup failed\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int iproc_pcie_pltfm_remove(struct platform_device *pdev)
+{
+	struct iproc_pcie *pcie = platform_get_drvdata(pdev);
+
+	return iproc_pcie_remove(pcie);
+}
+
+static const struct of_device_id iproc_pcie_of_match_table[] = {
+	{ .compatible = "brcm,iproc-pcie", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, iproc_pcie_of_match_table);
+
+static struct platform_driver iproc_pcie_pltfm_driver = {
+	.driver = {
+		.name = "iproc-pcie",
+		.of_match_table = of_match_ptr(iproc_pcie_of_match_table),
+	},
+	.probe = iproc_pcie_pltfm_probe,
+	.remove = iproc_pcie_pltfm_remove,
+};
+module_platform_driver(iproc_pcie_pltfm_driver);
+
+MODULE_AUTHOR("Ray Jui <rjui@broadcom.com>");
+MODULE_DESCRIPTION("Broadcom iPROC PCIe platform driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
new file mode 100644
index 0000000..986fa5a
--- /dev/null
+++ b/drivers/pci/host/pcie-iproc.c
@@ -0,0 +1,268 @@
+/*
+ * Copyright (C) 2014 Hauke Mehrtens <hauke@hauke-m.de>
+ * Copyright (C) 2015 Broadcom Corporatcommon ion
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/msi.h>
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/mbus.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/of_address.h>
+#include <linux/of_pci.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/phy/phy.h>
+
+#include "pcie-iproc.h"
+
+#define CLK_CONTROL_OFFSET           0x000
+#define EP_MODE_SURVIVE_PERST_SHIFT  1
+#define EP_MODE_SURVIVE_PERST        BIT(EP_MODE_SURVIVE_PERST_SHIFT)
+#define RC_PCIE_RST_OUTPUT_SHIFT     0
+#define RC_PCIE_RST_OUTPUT           BIT(RC_PCIE_RST_OUTPUT_SHIFT)
+
+#define CFG_IND_ADDR_OFFSET          0x120
+#define CFG_IND_ADDR_MASK            0x00001ffc
+
+#define CFG_IND_DATA_OFFSET          0x124
+
+#define CFG_ADDR_OFFSET              0x1f8
+#define CFG_ADDR_BUS_NUM_SHIFT       20
+#define CFG_ADDR_BUS_NUM_MASK        0x0ff00000
+#define CFG_ADDR_DEV_NUM_SHIFT       15
+#define CFG_ADDR_DEV_NUM_MASK        0x000f8000
+#define CFG_ADDR_FUNC_NUM_SHIFT      12
+#define CFG_ADDR_FUNC_NUM_MASK       0x00007000
+#define CFG_ADDR_REG_NUM_SHIFT       2
+#define CFG_ADDR_REG_NUM_MASK        0x00000ffc
+#define CFG_ADDR_CFG_TYPE_SHIFT      0
+#define CFG_ADDR_CFG_TYPE_MASK       0x00000003
+
+#define CFG_DATA_OFFSET              0x1fc
+
+#define SYS_RC_INTX_EN               0x330
+#define SYS_RC_INTX_MASK             0xf
+
+static inline struct iproc_pcie *sys_to_pcie(struct pci_sys_data *sys)
+{
+	return sys->private_data;
+}
+
+/**
+ * Note access to the configuration registers are protected at the higher layer
+ * by 'pci_lock' in drivers/pci/access.c
+ */
+static void __iomem *iproc_pcie_map_cfg_bus(struct pci_bus *bus,
+					    unsigned int devfn,
+					    int where)
+{
+	struct pci_sys_data *sys = bus->sysdata;
+	struct iproc_pcie *pcie = sys_to_pcie(sys);
+	unsigned slot = PCI_SLOT(devfn);
+	unsigned fn = PCI_FUNC(devfn);
+	unsigned busno = bus->number;
+	u32 val;
+
+	/* root complex access */
+	if (busno == 0) {
+		if (slot >= 1)
+			return NULL;
+		writel(where & CFG_IND_ADDR_MASK,
+		       pcie->base + CFG_IND_ADDR_OFFSET);
+		return (pcie->base + CFG_IND_DATA_OFFSET);
+	}
+
+	if (fn > 1)
+		return NULL;
+
+	/* EP device access */
+	val = (busno << CFG_ADDR_BUS_NUM_SHIFT) |
+		(slot << CFG_ADDR_DEV_NUM_SHIFT) |
+		(fn << CFG_ADDR_FUNC_NUM_SHIFT) |
+		(where & CFG_ADDR_REG_NUM_MASK) |
+		(1 & CFG_ADDR_CFG_TYPE_MASK);
+	writel(val, pcie->base + CFG_ADDR_OFFSET);
+
+	return (pcie->base + CFG_DATA_OFFSET);
+}
+
+static struct pci_ops iproc_pcie_ops = {
+	.map_bus = iproc_pcie_map_cfg_bus,
+	.read = pci_generic_config_read32,
+	.write = pci_generic_config_write32,
+};
+
+static void iproc_pcie_reset(struct iproc_pcie *pcie)
+{
+	u32 val;
+
+	/*
+	 * Configure the PCIe controller as root complex and send a downstream
+	 * reset
+	 */
+	val = EP_MODE_SURVIVE_PERST | RC_PCIE_RST_OUTPUT;
+	writel(val, pcie->base + CLK_CONTROL_OFFSET);
+	udelay(250);
+	val &= ~EP_MODE_SURVIVE_PERST;
+	writel(val, pcie->base + CLK_CONTROL_OFFSET);
+	msleep(250);
+}
+
+static int iproc_pcie_check_link(struct iproc_pcie *pcie, struct pci_bus *bus)
+{
+	u8 hdr_type;
+	u32 link_ctrl;
+	u16 pos, link_status;
+	int link_is_active = 0;
+
+	/* make sure we are not in EP mode */
+	pci_bus_read_config_byte(bus, 0, PCI_HEADER_TYPE, &hdr_type);
+	if ((hdr_type & 0x7f) != PCI_HEADER_TYPE_BRIDGE) {
+		dev_err(pcie->dev, "in EP mode, hdr=0x08%x\n", hdr_type);
+		return -EFAULT;
+	}
+
+	/* force class to PCI_CLASS_BRIDGE_PCI (0x0604) */
+	pci_bus_write_config_word(bus, 0, PCI_CLASS_DEVICE,
+				  PCI_CLASS_BRIDGE_PCI);
+
+	/* check link status to see if link is active */
+	pos = pci_bus_find_capability(bus, 0, PCI_CAP_ID_EXP);
+	pci_bus_read_config_word(bus, 0, pos + PCI_EXP_LNKSTA, &link_status);
+	if (link_status & PCI_EXP_LNKSTA_NLW)
+		link_is_active = 1;
+
+	if (!link_is_active) {
+		/* try GEN 1 link speed */
+#define PCI_LINK_STATUS_CTRL_2_OFFSET 0x0dc
+#define PCI_TARGET_LINK_SPEED_MASK    0xf
+#define PCI_TARGET_LINK_SPEED_GEN2    0x2
+#define PCI_TARGET_LINK_SPEED_GEN1    0x1
+		pci_bus_read_config_dword(bus, 0,
+					  PCI_LINK_STATUS_CTRL_2_OFFSET,
+					  &link_ctrl);
+		if ((link_ctrl & PCI_TARGET_LINK_SPEED_MASK) ==
+		    PCI_TARGET_LINK_SPEED_GEN2) {
+			link_ctrl &= ~PCI_TARGET_LINK_SPEED_MASK;
+			link_ctrl |= PCI_TARGET_LINK_SPEED_GEN1;
+			pci_bus_write_config_dword(bus, 0,
+					   PCI_LINK_STATUS_CTRL_2_OFFSET,
+					   link_ctrl);
+			msleep(100);
+
+			pos = pci_bus_find_capability(bus, 0, PCI_CAP_ID_EXP);
+			pci_bus_read_config_word(bus, 0, pos + PCI_EXP_LNKSTA,
+						 &link_status);
+			if (link_status & PCI_EXP_LNKSTA_NLW)
+				link_is_active = 1;
+		}
+	}
+
+	dev_info(pcie->dev, "link: %s\n", link_is_active ? "UP" : "DOWN");
+
+	return link_is_active ? 0 : -ENODEV;
+}
+
+static void iproc_pcie_enable(struct iproc_pcie *pcie)
+{
+	writel(SYS_RC_INTX_MASK, pcie->base + SYS_RC_INTX_EN);
+}
+
+int iproc_pcie_setup(struct iproc_pcie *pcie)
+{
+	int ret;
+	struct pci_bus *bus;
+
+	if (!pcie || !pcie->dev || !pcie->base)
+		return -EINVAL;
+
+	if (pcie->phy) {
+		ret = phy_init(pcie->phy);
+		if (ret) {
+			dev_err(pcie->dev, "unable to initialize PCIe PHY\n");
+			return ret;
+		}
+
+		ret = phy_power_on(pcie->phy);
+		if (ret) {
+			dev_err(pcie->dev, "unable to power on PCIe PHY\n");
+			goto err_exit_phy;
+		}
+
+	}
+
+	iproc_pcie_reset(pcie);
+
+	pcie->sysdata.private_data = pcie;
+
+	bus = pci_create_root_bus(pcie->dev, 0, &iproc_pcie_ops,
+				  &pcie->sysdata, pcie->resources);
+	if (!bus) {
+		dev_err(pcie->dev, "unable to create PCI root bus\n");
+		ret = -ENOMEM;
+		goto err_power_off_phy;
+	}
+	pcie->root_bus = bus;
+
+	ret = iproc_pcie_check_link(pcie, bus);
+	if (ret) {
+		dev_err(pcie->dev, "no PCIe EP device detected\n");
+		goto err_rm_root_bus;
+	}
+
+	iproc_pcie_enable(pcie);
+
+	pci_scan_child_bus(bus);
+	pci_assign_unassigned_bus_resources(bus);
+	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
+	pci_bus_add_devices(bus);
+
+	return 0;
+
+err_rm_root_bus:
+	pci_stop_root_bus(bus);
+	pci_remove_root_bus(bus);
+
+err_power_off_phy:
+	if (pcie->phy)
+		phy_power_off(pcie->phy);
+err_exit_phy:
+	if (pcie->phy)
+		phy_exit(pcie->phy);
+
+	return ret;
+}
+EXPORT_SYMBOL(iproc_pcie_setup);
+
+int iproc_pcie_remove(struct iproc_pcie *pcie)
+{
+	pci_stop_root_bus(pcie->root_bus);
+	pci_remove_root_bus(pcie->root_bus);
+
+	if (pcie->phy) {
+		phy_power_off(pcie->phy);
+		phy_exit(pcie->phy);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(iproc_pcie_remove);
+
+MODULE_AUTHOR("Ray Jui <rjui@broadcom.com>");
+MODULE_DESCRIPTION("Broadcom iPROC PCIe common driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/pci/host/pcie-iproc.h b/drivers/pci/host/pcie-iproc.h
new file mode 100644
index 0000000..e28075e
--- /dev/null
+++ b/drivers/pci/host/pcie-iproc.h
@@ -0,0 +1,42 @@
+/*
+ * Copyright (C) 2014-2015 Broadcom Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _PCIE_IPROC_H
+#define _PCIE_IPROC_H
+
+#define IPROC_PCIE_MAX_NUM_IRQS 6
+
+/**
+ * iProc PCIe device
+ * @dev: pointer to device data structure
+ * @base: PCIe host controller I/O register base
+ * @resources: linked list of all PCI resources
+ * @sysdata: Per PCI controller data
+ * @root_bus: pointer to root bus
+ * @phy: optional PHY device that controls the Serdes
+ * @irqs: interrupt IDs
+ */
+struct iproc_pcie {
+	struct device *dev;
+	void __iomem *base;
+	struct list_head *resources;
+	struct pci_sys_data sysdata;
+	struct pci_bus *root_bus;
+	struct phy *phy;
+	int irqs[IPROC_PCIE_MAX_NUM_IRQS];
+};
+
+int iproc_pcie_setup(struct iproc_pcie *pcie);
+int iproc_pcie_remove(struct iproc_pcie *pcie);
+
+#endif /* _PCIE_IPROC_H */
-- 
1.7.9.5

