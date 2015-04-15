Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bon0119.outbound.protection.outlook.com ([157.56.111.119]:19781
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932184AbbDOJq6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 15 Apr 2015 05:46:58 -0400
From: Minghuan Lian <Minghuan.Lian@freescale.com>
To: <linux-pci@vger.kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>,
	Zang Roy-R61911 <r61911@freescale.com>,
	Hu Mingkai-B21284 <B21284@freescale.com>,
	Scott Wood <scottwood@freescale.com>,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Jingoo Han" <jg1.han@samsung.com>,
	Minghuan Lian <Minghuan.Lian@freescale.com>
Subject: [PATCH v2 2/3] pci/designware: Add base driver for Designware PCIe
Date: Wed, 15 Apr 2015 17:48:34 +0800
Message-ID: <1429091315-31891-3-git-send-email-Minghuan.Lian@freescale.com>
In-Reply-To: <1429091315-31891-1-git-send-email-Minghuan.Lian@freescale.com>
References: <1429091315-31891-1-git-send-email-Minghuan.Lian@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Synopsys Designware IP is shared with couples of platforms
under multiple architectures. The patch is to provide basic
architecture-independent Designware PCIe host driver including
ATU initialization and PCI OPS. Currently, which supports arm
and arm64 simultaneously.

Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
---
change log:
v1-v2:
1. Get MSI chip according to dts property 'msi-parent'
2. Simplify platform_get_resource_byname() failure checking   

 drivers/pci/host/Kconfig                |   3 +
 drivers/pci/host/Makefile               |   1 +
 drivers/pci/host/pcie-designware-base.c | 293 ++++++++++++++++++++++++++++++++
 drivers/pci/host/pcie-designware-base.h |  63 +++++++
 4 files changed, 360 insertions(+)
 create mode 100644 drivers/pci/host/pcie-designware-base.c
 create mode 100644 drivers/pci/host/pcie-designware-base.h

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 1dfb567..2a697c0a 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -18,6 +18,9 @@ config PCI_MVEBU
 config PCIE_DW
 	bool
 
+config PCIE_DW_BASE
+	bool
+
 config PCI_EXYNOS
 	bool "Samsung Exynos PCIe controller"
 	depends on SOC_EXYNOS5440
diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
index f733b4e..da985e1 100644
--- a/drivers/pci/host/Makefile
+++ b/drivers/pci/host/Makefile
@@ -1,3 +1,4 @@
+obj-$(CONFIG_PCIE_DW_BASE) += pcie-designware-base.o
 obj-$(CONFIG_PCIE_DW) += pcie-designware.o
 obj-$(CONFIG_PCI_DRA7XX) += pci-dra7xx.o
 obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
diff --git a/drivers/pci/host/pcie-designware-base.c b/drivers/pci/host/pcie-designware-base.c
new file mode 100644
index 0000000..10b4002
--- /dev/null
+++ b/drivers/pci/host/pcie-designware-base.c
@@ -0,0 +1,293 @@
+/*
+ * Synopsys Designware PCIe host controller base driver
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_pci.h>
+#include <linux/pci.h>
+#include <linux/pci_regs.h>
+#include <linux/platform_device.h>
+
+#include "pcie-designware-base.h"
+
+void dw_pcie_dbi_write(struct dw_pcie_port *pp, u32 value, u32 offset)
+{
+	iowrite32(value, pp->dbi + offset);
+}
+
+u32 dw_pcie_dbi_read(struct dw_pcie_port *pp, u32 offset)
+{
+	return ioread32(pp->dbi + offset);
+}
+
+int dw_pcie_host_link_up(struct dw_pcie_port *pp)
+{
+	if (pp->dw_ops->link_up)
+		return pp->dw_ops->link_up(pp);
+	else
+		return 0;
+}
+
+void dw_pcie_atu_outbound_set(struct dw_pcie_port *pp, int idx, int type,
+			      u64 cpu_addr, u64 pci_addr, u32 size)
+{
+	if (idx >= pp->atu_num)
+		return;
+
+	dw_pcie_dbi_write(pp, PCIE_ATU_REGION_OUTBOUND | idx,
+			  PCIE_ATU_VIEWPORT);
+	dw_pcie_dbi_write(pp, lower_32_bits(cpu_addr),
+			  PCIE_ATU_LOWER_BASE);
+	dw_pcie_dbi_write(pp, upper_32_bits(cpu_addr),
+			  PCIE_ATU_UPPER_BASE);
+	dw_pcie_dbi_write(pp, lower_32_bits(cpu_addr + size - 1),
+			  PCIE_ATU_LIMIT);
+	dw_pcie_dbi_write(pp, lower_32_bits(pci_addr),
+			  PCIE_ATU_LOWER_TARGET);
+	dw_pcie_dbi_write(pp, upper_32_bits(pci_addr),
+			  PCIE_ATU_UPPER_TARGET);
+	dw_pcie_dbi_write(pp, type, PCIE_ATU_CR1);
+	dw_pcie_dbi_write(pp, PCIE_ATU_ENABLE, PCIE_ATU_CR2);
+}
+
+static void __iomem *
+dw_pcie_map_bus(struct pci_bus *bus, unsigned int devfn, int offset)
+{
+	struct dw_pcie_port *pp = bus->sysdata;
+	u32 type, busdev;
+
+	/* If there is no link, then there is no device */
+	if (!pci_is_root_bus(bus) && !dw_pcie_host_link_up(pp))
+		return NULL;
+
+	/* access only one slot on each root port */
+	if (pci_is_root_bus(bus) && devfn > 0)
+		return NULL;
+
+	if (pci_is_root_bus(bus))
+		return pp->dbi + offset;
+
+	busdev = PCIE_ATU_BUS(bus->number) |
+		 PCIE_ATU_DEV(PCI_SLOT(devfn)) |
+		 PCIE_ATU_FUNC(PCI_FUNC(devfn));
+
+	if (pci_is_root_bus(bus->parent))
+		type = PCIE_ATU_TYPE_CFG0;
+	else
+		type = PCIE_ATU_TYPE_CFG1;
+
+	dw_pcie_atu_outbound_set(pp,
+				 PCIE_ATU_REGION_INDEX0,
+				 type,
+				 pp->cfg_addr,
+				 busdev,
+				 pp->cfg_size);
+
+	return pp->cfg + offset;
+}
+
+static int dw_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
+			       int where, int size, u32 *val)
+{
+	struct dw_pcie_port *pp = bus->sysdata;
+	int ret;
+
+	ret = pci_generic_config_read32(bus, devfn, where, size, val);
+
+	if (pp->atu_num == 2 && !pci_is_root_bus(bus))
+		/* reassign ATU0 to map IO space */
+		dw_pcie_atu_outbound_set(pp,
+					 PCIE_ATU_REGION_INDEX0,
+					 PCIE_ATU_TYPE_IO,
+					 pp->io_cpu_addr,
+					 pp->io_pci_addr,
+					 pp->io_size);
+
+	return ret;
+}
+
+static int dw_pcie_config_write(struct pci_bus *bus, unsigned int devfn,
+			       int where, int size, u32 val)
+{
+	struct dw_pcie_port *pp = bus->sysdata;
+	int ret;
+
+	ret = pci_generic_config_write32(bus, devfn, where, size, val);
+
+	if (pp->atu_num == 2 && !pci_is_root_bus(bus))
+		/* reassign ATU0 to map IO space */
+		dw_pcie_atu_outbound_set(pp,
+					 PCIE_ATU_REGION_INDEX0,
+					 PCIE_ATU_TYPE_IO,
+					 pp->io_cpu_addr,
+					 pp->io_pci_addr,
+					 pp->io_size);
+
+	return ret;
+}
+
+static struct pci_ops dw_pcie_ops = {
+	.map_bus = dw_pcie_map_bus,
+	.read = dw_pcie_config_read,
+	.write = dw_pcie_config_write,
+};
+
+static int dw_pcie_map_reg(struct dw_pcie_port *pp)
+{
+	struct platform_device *pdev = to_platform_device(pp->dev);
+	struct resource *res;
+
+	if (!pp->dbi) {
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+						   "dbi");
+		pp->dbi = devm_ioremap_resource(pp->dev, res);
+		if (IS_ERR(pp->dbi)) {
+			dev_err(pp->dev, "missing *dbi* reg space\n");
+			return PTR_ERR(pp->dbi);
+		}
+	}
+
+	if (!pp->cfg) {
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+						   "config");
+		pp->cfg = devm_ioremap_resource(pp->dev, res);
+		if (IS_ERR(pp->cfg)) {
+			dev_err(pp->dev, "missing *config* reg space\n");
+			return PTR_ERR(pp->cfg);
+		}
+
+		pp->cfg_addr = res->start;
+		pp->cfg_size = resource_size(res);
+	}
+
+	return 0;
+}
+
+/*
+ * If ATU number = 2, ATU0 is shared by transaction CFG and IO,
+ * ATU1 is used for transaction MEM
+ * If ATU number > 2, ATU0 is used for transaction CFG
+ * the other ATUs are used for MEM and IO separately.
+ */
+static int dw_pcie_atu_init(struct dw_pcie_port *pp,
+			    struct list_head *res,
+			    resource_size_t io_base)
+{
+	struct resource_entry *window;
+	struct device *dev = pp->dev;
+	int idx = 1, ret;
+
+	if (pp->atu_num < 2)
+		pp->atu_num = 2;
+
+	resource_list_for_each_entry(window, res) {
+		struct resource *res = window->res;
+		unsigned long restype = resource_type(res);
+
+		switch (restype) {
+		case IORESOURCE_IO:
+			if (pp->atu_num == 2)
+				idx = 0;
+
+			pp->io_cpu_addr = io_base;
+			pp->io_pci_addr = res->start - window->offset;
+			pp->io_size = resource_size(res);
+			dw_pcie_atu_outbound_set(pp,
+						 idx,
+						 PCIE_ATU_TYPE_IO,
+						 pp->io_cpu_addr,
+						 pp->io_pci_addr,
+						 pp->io_size);
+			ret = pci_remap_iospace(res, io_base);
+			if (ret < 0)
+				return ret;
+			idx++;
+			break;
+		case IORESOURCE_MEM:
+			if (pp->atu_num == 2)
+				idx = 1;
+
+			dw_pcie_atu_outbound_set(pp,
+						 idx,
+						 PCIE_ATU_TYPE_MEM,
+						 res->start,
+						 res->start - window->offset,
+						 resource_size(res));
+			idx++;
+			break;
+		case IORESOURCE_BUS:
+			break;
+		default:
+			dev_err(dev, "invalid resource %pR\n", res);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static void dw_pcie_msi_init(struct dw_pcie_port *pp)
+{
+	struct device_node *msi_node;
+
+	if (pp->msi_chip)
+		return;
+
+	msi_node = of_parse_phandle(pp->dev->of_node, "msi-parent", 0);
+	if (msi_node)
+		pp->msi_chip = of_pci_find_msi_chip_by_node(msi_node);
+}
+
+int dw_pcie_port_init(struct dw_pcie_port *pp)
+{
+	struct device_node *dn = pp->dev->of_node;
+	resource_size_t iobase = 0;
+	struct pci_bus *bus;
+	int ret;
+	LIST_HEAD(res);
+
+	ret = dw_pcie_map_reg(pp);
+	if (ret)
+		return ret;
+
+	ret = of_pci_get_host_bridge_resources(dn, 0, 0xff, &res, &iobase);
+	if (ret)
+		return ret;
+
+	ret = dw_pcie_atu_init(pp, &res, iobase);
+	if (ret)
+		return ret;
+
+	dw_pcie_msi_init(pp);
+
+	if (!pp->pci_ops)
+		pp->pci_ops = &dw_pcie_ops;
+
+	if (pp->dw_ops->host_init) {
+		if (pp->dw_ops->host_init(pp))
+			return ret;
+	}
+
+	bus = pci_create_root_bus(pp->dev, 0, pp->pci_ops,
+				  pp, &res);
+	if (!bus)
+		return -ENOMEM;
+
+	bus->msi = pp->msi_chip;
+
+	pci_scan_child_bus(bus);
+	pci_assign_unassigned_bus_resources(bus);
+	pci_bus_add_devices(bus);
+
+	return 0;
+}
+
+MODULE_AUTHOR("Minghuan Lian <Minghuan.Lian@freescale.com>");
+MODULE_DESCRIPTION("Designware PCIe controller driver with Multiarch support");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/pci/host/pcie-designware-base.h b/drivers/pci/host/pcie-designware-base.h
new file mode 100644
index 0000000..60c82de
--- /dev/null
+++ b/drivers/pci/host/pcie-designware-base.h
@@ -0,0 +1,63 @@
+/*
+ * Synopsys Designware PCIe host controller base driver
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _PCIE_DESIGNWARE_BASE_H
+#define _PCIE_DESIGNWARE_BASE_H
+
+/* Synopsis specific PCIE configuration registers */
+#define PCIE_ATU_VIEWPORT		0x900
+#define PCIE_ATU_REGION_INBOUND		(0x1 << 31)
+#define PCIE_ATU_REGION_OUTBOUND	(0x0 << 31)
+#define PCIE_ATU_REGION_INDEX0		(0x0 << 0)
+#define PCIE_ATU_CR1			0x904
+#define PCIE_ATU_TYPE_MEM		(0x0 << 0)
+#define PCIE_ATU_TYPE_IO		(0x2 << 0)
+#define PCIE_ATU_TYPE_CFG0		(0x4 << 0)
+#define PCIE_ATU_TYPE_CFG1		(0x5 << 0)
+#define PCIE_ATU_CR2			0x908
+#define PCIE_ATU_ENABLE			(0x1 << 31)
+#define PCIE_ATU_BAR_MODE_ENABLE	(0x1 << 30)
+#define PCIE_ATU_LOWER_BASE		0x90C
+#define PCIE_ATU_UPPER_BASE		0x910
+#define PCIE_ATU_LIMIT			0x914
+#define PCIE_ATU_LOWER_TARGET		0x918
+#define PCIE_ATU_BUS(x)			(((x) & 0xff) << 24)
+#define PCIE_ATU_DEV(x)			(((x) & 0x1f) << 19)
+#define PCIE_ATU_FUNC(x)		(((x) & 0x7) << 16)
+#define PCIE_ATU_UPPER_TARGET		0x91C
+
+struct dw_pcie_port;
+
+struct dw_host_ops {
+	int (*link_up)(struct dw_pcie_port *pp);
+	int (*host_init)(struct dw_pcie_port *pp);
+};
+
+struct dw_pcie_port {
+	struct device		*dev;
+	void __iomem		*dbi;
+	void __iomem		*cfg;
+	u64			cfg_addr;
+	u32			cfg_size;
+	u64			io_cpu_addr;
+	u64			io_pci_addr;
+	u32			io_size;
+	u32			atu_num;
+	struct dw_host_ops	*dw_ops;
+	struct pci_ops		*pci_ops;
+	struct msi_controller	*msi_chip;
+};
+
+void dw_pcie_dbi_write(struct dw_pcie_port *pp, u32 value, u32 offset);
+u32 dw_pcie_dbi_read(struct dw_pcie_port *pp, u32 offset);
+int dw_pcie_host_link_up(struct dw_pcie_port *pp);
+void dw_pcie_atu_outbound_set(struct dw_pcie_port *pp, int idx, int type,
+			      u64 cpu_addr, u64 pci_addr, u32 size);
+int dw_pcie_port_init(struct dw_pcie_port *pp);
+
+#endif /* _PCIE_DESIGNWARE_BASE_H */
-- 
1.9.1

