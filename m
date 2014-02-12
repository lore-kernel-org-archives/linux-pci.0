Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:52832 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752537AbaBLUQu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 12 Feb 2014 15:16:50 -0500
From: Will Deacon <will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: arnd@arndb.de, linux-pci@vger.kernel.org, bhelgaas@google.com,
	jgunthorpe@obsidianresearch.com, Will Deacon <will.deacon@arm.com>
Subject: [PATCH v2 3/3] PCI: ARM: add support for generic PCI host controller
Date: Wed, 12 Feb 2014 20:16:11 +0000
Message-Id: <1392236171-10512-4-git-send-email-will.deacon@arm.com>
In-Reply-To: <1392236171-10512-1-git-send-email-will.deacon@arm.com>
References: <1392236171-10512-1-git-send-email-will.deacon@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds support for a generic PCI host controller, such as a
firmware-initialised device with static windows or an emulation by
something such as kvmtool.

The controller itself has no configuration registers and has its address
spaces described entirely by the device-tree (using the bindings from
ePAPR). Both CAM and ECAM are supported for Config Space accesses.

Corresponding documentation is added for the DT binding.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 .../devicetree/bindings/pci/arm-generic-pci.txt    |  51 ++++
 drivers/pci/host/Kconfig                           |   7 +
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pci-arm-generic.c                 | 318 +++++++++++++++++++++
 4 files changed, 377 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/arm-generic-pci.txt
 create mode 100644 drivers/pci/host/pci-arm-generic.c

diff --git a/Documentation/devicetree/bindings/pci/arm-generic-pci.txt b/Documentation/devicetree/bindings/pci/arm-generic-pci.txt
new file mode 100644
index 000000000000..cc7a35ecfa2d
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/arm-generic-pci.txt
@@ -0,0 +1,51 @@
+* ARM generic PCI host controller
+
+Firmware-initialised PCI host controllers and PCI emulations, such as the
+virtio-pci implementations found in kvmtool and other para-virtualised
+systems, do not require driver support for complexities such as regulator and
+clock management. In fact, the controller may not even require the
+configuration of a control interface by the operating system, instead
+presenting a set of fixed windows describing a subset of IO, Memory and
+Configuration Spaces.
+
+Such a controller can be described purely in terms of the standardized device
+tree bindings communicated in pci.txt:
+
+- compatible     : Must be "arm,pci-cam-generic" or "arm,pci-ecam-generic"
+                   depending on the layout of configuration space (CAM vs
+                   ECAM respectively)
+
+- ranges         : As described in IEEE Std 1275-1994, but must provide
+                   at least a definition of one or both of IO and Memory
+                   Space.
+
+- #address-cells : Must be 3
+
+- #size-cells    : Must be 2
+
+- reg            : The Configuration Space base address, as accessed by the
+                   parent bus.
+
+Configuration Space is assumed to be memory-mapped (as opposed to being
+accessed via an ioport) and laid out with a direct correspondence to the
+geography of a PCI bus address by concatenating the various components to form
+an offset.
+
+For CAM, this 24-bit offset is:
+
+        cfg_offset(bus, device, function, register) =
+                   bus << 16 | device << 11 | function << 8 | register
+
+Whilst ECAM extends this by 4 bits to accomodate 4k of function space:
+
+        cfg_offset(bus, device, function, register) =
+                   bus << 20 | device << 15 | function << 12 | register
+
+Interrupt mapping is exactly as described in `Open Firmware Recommended
+Practice: Interrupt Mapping' and requires the following properties:
+
+- #interrupt-cells   : Must be 1
+
+- interrupt-map      : <see aforementioned specification>
+
+- interrupt-map-mask : <see aforementioned specification>
diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 47d46c6d8468..491d74c36f6a 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -33,4 +33,11 @@ config PCI_RCAR_GEN2
 	  There are 3 internal PCI controllers available with a single
 	  built-in EHCI/OHCI host controller present on each one.
 
+config PCI_ARM_GENERIC
+	bool "ARM generic PCI host controller"
+	depends on ARM && OF
+	help
+	  Say Y here if you want to support a simple generic PCI host
+	  controller, such as the one emulated by kvmtool.
+
 endmenu
diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
index 13fb3333aa05..17f5555f8a29 100644
--- a/drivers/pci/host/Makefile
+++ b/drivers/pci/host/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_PCI_IMX6) += pci-imx6.o
 obj-$(CONFIG_PCI_MVEBU) += pci-mvebu.o
 obj-$(CONFIG_PCI_TEGRA) += pci-tegra.o
 obj-$(CONFIG_PCI_RCAR_GEN2) += pci-rcar-gen2.o
+obj-$(CONFIG_PCI_ARM_GENERIC) += pci-arm-generic.o
diff --git a/drivers/pci/host/pci-arm-generic.c b/drivers/pci/host/pci-arm-generic.c
new file mode 100644
index 000000000000..31ce03ee2607
--- /dev/null
+++ b/drivers/pci/host/pci-arm-generic.c
@@ -0,0 +1,318 @@
+/*
+ * Simple, generic PCI host controller driver targetting firmware-initialised
+ * systems and virtual machines (e.g. the PCI emulation provided by kvmtool).
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ * Copyright (C) 2014 ARM Limited
+ *
+ * The current driver is limited to one I/O space per controller, and
+ * only supports a single controller.
+ *
+ * Author: Will Deacon <will.deacon@arm.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_pci.h>
+#include <linux/platform_device.h>
+
+struct gen_pci_cfg_accessors {
+	void __iomem *(*map_bus)(struct pci_bus *, unsigned int, int);
+	void (*unmap_bus)(struct pci_bus *);
+};
+
+struct gen_pci_cfg_window {
+	u64					cpu_phys;
+	void __iomem				*base;
+	u8					bus;
+	spinlock_t				lock;
+	const struct gen_pci_cfg_accessors	*accessors;
+};
+
+struct gen_pci_resource {
+	struct list_head			list;
+	struct resource				cpu_res;
+	resource_size_t				offset;
+};
+
+struct gen_pci {
+	struct device				*dev;
+	struct resource				*io_res;
+	struct list_head			mem_res;
+	struct gen_pci_cfg_window		cfg;
+};
+
+/*
+ * Configuration space accessors. We support CAM (simply map the entire
+ * 16M space) or ECAM (map a single 1M bus at a time).
+ */
+static void __iomem *gen_pci_map_cfg_bus_cam(struct pci_bus *bus,
+					     unsigned int devfn,
+					     int where)
+{
+	struct pci_sys_data *sys = bus->sysdata;
+	struct gen_pci *pci = sys->private_data;
+	u32 busn = bus->number;
+
+	return pci->cfg.base + ((busn << 16) | (devfn << 8) | where);
+}
+
+static void gen_pci_unmap_cfg_bus_cam(struct pci_bus *bus)
+{
+}
+
+static struct gen_pci_cfg_accessors gen_pci_cfg_cam_accessors = {
+	.map_bus	= gen_pci_map_cfg_bus_cam,
+	.unmap_bus	= gen_pci_unmap_cfg_bus_cam,
+};
+
+static void __iomem *gen_pci_map_cfg_bus_ecam(struct pci_bus *bus,
+					      unsigned int devfn,
+					      int where)
+{
+	struct pci_sys_data *sys = bus->sysdata;
+	struct gen_pci *pci = sys->private_data;
+	u32 busn = bus->number;
+
+	spin_lock(&pci->cfg.lock);
+	if (pci->cfg.bus != busn) {
+		resource_size_t offset;
+
+		devm_iounmap(pci->dev, pci->cfg.base);
+		offset = pci->cfg.cpu_phys + (busn << 20);
+		pci->cfg.base = devm_ioremap(pci->dev, offset, SZ_1M);
+		pci->cfg.bus = busn;
+	}
+
+	return pci->cfg.base + ((devfn << 12) | where);
+}
+
+static void gen_pci_unmap_cfg_bus_ecam(struct pci_bus *bus)
+{
+	struct pci_sys_data *sys = bus->sysdata;
+	struct gen_pci *pci = sys->private_data;
+
+	spin_unlock(&pci->cfg.lock);
+}
+
+static struct gen_pci_cfg_accessors gen_pci_cfg_ecam_accessors = {
+	.map_bus	= gen_pci_map_cfg_bus_ecam,
+	.unmap_bus	= gen_pci_unmap_cfg_bus_ecam,
+};
+
+static int gen_pci_config_read(struct pci_bus *bus, unsigned int devfn,
+				int where, int size, u32 *val)
+{
+	struct pci_sys_data *sys = bus->sysdata;
+	struct gen_pci *pci = sys->private_data;
+	void __iomem *addr = pci->cfg.accessors->map_bus(bus, devfn, where);
+
+	switch (size) {
+	case 1:
+		*val = readb(addr);
+		break;
+	case 2:
+		*val = readw(addr);
+		break;
+	default:
+		*val = readl(addr);
+	}
+
+	pci->cfg.accessors->unmap_bus(bus);
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int gen_pci_config_write(struct pci_bus *bus, unsigned int devfn,
+				 int where, int size, u32 val)
+{
+	struct pci_sys_data *sys = bus->sysdata;
+	struct gen_pci *pci = sys->private_data;
+	void __iomem *addr = pci->cfg.accessors->map_bus(bus, devfn, where);
+
+	switch (size) {
+	case 1:
+		writeb(val, addr);
+		break;
+	case 2:
+		writew(val, addr);
+		break;
+	default:
+		writel(val, addr);
+	}
+
+	pci->cfg.accessors->unmap_bus(bus);
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static struct pci_ops gen_pci_ops = {
+	.read	= gen_pci_config_read,
+	.write	= gen_pci_config_write,
+};
+
+static int gen_pci_setup(int nr, struct pci_sys_data *sys)
+{
+	int err;
+	struct gen_pci_resource *res;
+	struct gen_pci *pci = sys->private_data;
+
+	/* Map an initial Configuration Space window */
+	pci->cfg.base = devm_ioremap(pci->dev, pci->cfg.cpu_phys, SZ_1M);
+	if (!pci->cfg.base)
+		return -ENOMEM;
+
+	/* Register our I/O space */
+	if (pci->io_res) {
+		resource_size_t offset = nr * SZ_64K;
+
+		err = request_resource(&ioport_resource, pci->io_res);
+		if (err)
+			goto out_unmap_cfg_space;
+
+		err = pci_ioremap_io(offset, pci->io_res->start);
+		if (err)
+			goto out_release_io_res;
+
+		pci_add_resource_offset(&sys->resources, pci->io_res, offset);
+	}
+
+	/* Register our memory resources */
+	list_for_each_entry(res, &pci->mem_res, list) {
+		err = request_resource(&iomem_resource, &res->cpu_res);
+		if (err)
+			goto out_release_mem_res;
+
+		pci_add_resource_offset(&sys->resources,
+					&res->cpu_res,
+					res->offset);
+	}
+
+	return 1;
+out_release_mem_res:
+	list_for_each_entry_continue_reverse(res, &pci->mem_res, list)
+		release_resource(&res->cpu_res);
+out_release_io_res:
+	release_resource(pci->io_res);
+out_unmap_cfg_space:
+	devm_iounmap(pci->dev, pci->cfg.base);
+	return err;
+}
+
+static const struct of_device_id gen_pci_of_match[] = {
+	{ .compatible = "arm,pci-cam-generic",
+	  .data = &gen_pci_cfg_cam_accessors },
+
+	{ .compatible = "arm,pci-ecam-generic",
+	  .data = &gen_pci_cfg_ecam_accessors },
+
+	{ },
+};
+MODULE_DEVICE_TABLE(of, gen_pci_of_match);
+
+static int gen_pci_probe(struct platform_device *pdev)
+{
+	struct hw_pci hw;
+	struct of_pci_range range;
+	struct of_pci_range_parser parser;
+	struct gen_pci *pci;
+	const __be32 *reg;
+	const struct of_device_id *of_id;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+
+	if (!np)
+		return -ENODEV;
+
+	if (of_pci_range_parser_init(&parser, np)) {
+		dev_err(dev, "missing \"ranges\" property\n");
+		return -EINVAL;
+	}
+
+	reg = of_get_property(np, "reg", NULL);
+	if (!reg) {
+		dev_err(dev, "missing \"reg\" property\n");
+		return -EINVAL;
+	}
+
+	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
+	if (!pci)
+		return -ENOMEM;
+
+	pci->cfg.cpu_phys = of_translate_address(np, reg);
+	if (pci->cfg.cpu_phys == OF_BAD_ADDR)
+		return -EINVAL;
+
+	of_id = of_match_node(gen_pci_of_match, np);
+	pci->cfg.accessors = of_id->data;
+	spin_lock_init(&pci->cfg.lock);
+	INIT_LIST_HEAD(&pci->mem_res);
+	pci->dev = dev;
+
+	for_each_of_pci_range(&parser, &range) {
+		struct gen_pci_resource *res;
+		u32 restype = range.flags & IORESOURCE_TYPE_BITS;
+
+		res = devm_kzalloc(dev, sizeof(*res), GFP_KERNEL);
+		if (!res)
+			return -ENOMEM;
+
+		INIT_LIST_HEAD(&res->list);
+		of_pci_range_to_resource(&range, np, &res->cpu_res);
+
+		switch (restype) {
+		case IORESOURCE_IO:
+			if (pci->io_res) {
+				dev_warn(dev,
+					 "ignoring additional io resource\n");
+				devm_kfree(dev, res);
+			} else {
+				pci->io_res = &res->cpu_res;
+			}
+			break;
+		case IORESOURCE_MEM:
+			res->offset = range.cpu_addr - range.pci_addr;
+			list_add(&res->list, &pci->mem_res);
+			break;
+		default:
+			dev_warn(dev,
+				"ignoring unknown/unsupported resource type %x\n",
+				 restype);
+		}
+	}
+
+	hw = (struct hw_pci) {
+		.nr_controllers	= 1,
+		.private_data	= (void **)&pci,
+		.setup		= gen_pci_setup,
+		.map_irq	= of_irq_parse_and_map_pci,
+		.ops		= &gen_pci_ops,
+	};
+
+	pci_common_init_dev(dev, &hw);
+	return 0;
+}
+
+static struct platform_driver gen_pci_driver = {
+	.driver = {
+		.name = "pci-arm-generic",
+		.owner = THIS_MODULE,
+		.of_match_table = gen_pci_of_match,
+	},
+	.probe = gen_pci_probe,
+};
+module_platform_driver(gen_pci_driver);
+
+MODULE_DESCRIPTION("ARM generic PCI host driver");
+MODULE_AUTHOR("Will Deacon <will.deacon@arm.com>");
+MODULE_LICENSE("GPLv2");
-- 
1.8.2.2

