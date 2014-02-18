Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:55203 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755213AbaBRMV2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Feb 2014 07:21:28 -0500
From: Will Deacon <will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: arnd@arndb.de, linux-pci@vger.kernel.org, bhelgaas@google.com,
	jgunthorpe@obsidianresearch.com, Will Deacon <will.deacon@arm.com>
Subject: [PATCH v3 3/3] PCI: ARM: add support for generic PCI host controller
Date: Tue, 18 Feb 2014 12:20:43 +0000
Message-Id: <1392726043-31088-4-git-send-email-will.deacon@arm.com>
In-Reply-To: <1392726043-31088-1-git-send-email-will.deacon@arm.com>
References: <1392726043-31088-1-git-send-email-will.deacon@arm.com>
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
 .../devicetree/bindings/pci/host-generic-pci.txt   |  88 +++++
 drivers/pci/host/Kconfig                           |   7 +
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pci-host-generic.c                | 381 +++++++++++++++++++++
 4 files changed, 477 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/host-generic-pci.txt
 create mode 100644 drivers/pci/host/pci-host-generic.c

diff --git a/Documentation/devicetree/bindings/pci/host-generic-pci.txt b/Documentation/devicetree/bindings/pci/host-generic-pci.txt
new file mode 100644
index 000000000000..03e1640a7602
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/host-generic-pci.txt
@@ -0,0 +1,88 @@
+* Generic PCI host controller
+
+Firmware-initialised PCI host controllers and PCI emulations, such as the
+virtio-pci implementations found in kvmtool and other para-virtualised
+systems, do not require driver support for complexities such as regulator
+and clock management. In fact, the controller may not even require the
+configuration of a control interface by the operating system, instead
+presenting a set of fixed windows describing a subset of IO, Memory and
+Configuration Spaces.
+
+Such a controller can be described purely in terms of the standardized device
+tree bindings communicated in pci.txt:
+
+- compatible     : Must be "pci-host-cam-generic" or "pci-host-ecam-generic"
+                   depending on the layout of configuration space (CAM vs
+                   ECAM respectively).
+
+- device_type    : Must be "pci".
+
+- ranges         : As described in IEEE Std 1275-1994, but must provide
+                   at least a definition of non-prefetchable memory. One
+                   or both of prefetchable Memory and IO Space may also
+                   be provided.
+
+- bus-range      : Optional property (also described in IEEE Std 1275-1994)
+                   to indicate the range of bus numbers for this controller.
+                   If absent, defaults to <0 255> (i.e. all buses).
+
+- #address-cells : Must be 3.
+
+- #size-cells    : Must be 2.
+
+- reg            : The Configuration Space base address and size, as accessed
+                   from the parent bus.
+
+Configuration Space is assumed to be memory-mapped (as opposed to being
+accessed via an ioport) and laid out with a direct correspondence to the
+geography of a PCI bus address by concatenating the various components to
+form an offset.
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
+
+
+Example:
+
+pci {
+    compatible = "pci-host-cam-generic"
+    device_type = "pci";
+    #address-cells = <3>;
+    #size-cells = <2>;
+    bus-range = <0x0 0x1>;
+
+    // CPU_PHYSICAL(2)  SIZE(2)
+    reg = <0x0 0x40000000  0x0 0x1000000>;
+
+    // BUS_ADDRESS(3)  CPU_PHYSICAL(2)  SIZE(2)
+    ranges = <0x1000000 0x0 0x00000000  0x0 0x00000000  0x0 0x00010000>,
+             <0x2000000 0x0 0x41000000  0x0 0x41000000  0x0 0x3f000000>;
+
+
+    #interrupt-cells = <0x1>;
+
+    // PCI_DEVICE(3)  INT#(1)  CONTROLLER(PHANDLE)  CONTROLLER_DATA(3)
+    interrupt-map = <  0x0 0x0 0x0  0x1  &gic  0x0 0x4 0x1
+                     0x800 0x0 0x0  0x1  &gic  0x0 0x5 0x1
+                    0x1000 0x0 0x0  0x1  &gic  0x0 0x6 0x1
+                    0x1800 0x0 0x0  0x1  &gic  0x0 0x7 0x1>;
+
+    // PCI_DEVICE(3)  INT#(1)
+    interrupt-map-mask = <0xf800 0x0 0x0  0x7>;
+}
diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 47d46c6d8468..f91637d47065 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -33,4 +33,11 @@ config PCI_RCAR_GEN2
 	  There are 3 internal PCI controllers available with a single
 	  built-in EHCI/OHCI host controller present on each one.
 
+config PCI_HOST_GENERIC
+	bool "Generic PCI host controller"
+	depends on ARM && OF
+	help
+	  Say Y here if you want to support a simple generic PCI host
+	  controller, such as the one emulated by kvmtool.
+
 endmenu
diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
index 13fb3333aa05..bd1bf1ab4ac8 100644
--- a/drivers/pci/host/Makefile
+++ b/drivers/pci/host/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_PCI_IMX6) += pci-imx6.o
 obj-$(CONFIG_PCI_MVEBU) += pci-mvebu.o
 obj-$(CONFIG_PCI_TEGRA) += pci-tegra.o
 obj-$(CONFIG_PCI_RCAR_GEN2) += pci-rcar-gen2.o
+obj-$(CONFIG_PCI_HOST_GENERIC) += pci-host-generic.o
diff --git a/drivers/pci/host/pci-host-generic.c b/drivers/pci/host/pci-host-generic.c
new file mode 100644
index 000000000000..d843b546a8a1
--- /dev/null
+++ b/drivers/pci/host/pci-host-generic.c
@@ -0,0 +1,381 @@
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
+ * Author: Will Deacon <will.deacon@arm.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_pci.h>
+#include <linux/platform_device.h>
+
+struct gen_pci_cfg_bus_ops {
+	u32 bus_shift;
+	void __iomem *(*map_bus)(struct pci_bus *, unsigned int, int);
+};
+
+struct gen_pci_cfg_windows {
+	struct resource				res;
+	struct resource				bus_range;
+	void __iomem				**win;
+
+	const struct gen_pci_cfg_bus_ops	*ops;
+};
+
+struct gen_pci {
+	struct pci_host_bridge			host;
+	struct gen_pci_cfg_windows		cfg;
+};
+
+static void __iomem *gen_pci_map_cfg_bus_cam(struct pci_bus *bus,
+					     unsigned int devfn,
+					     int where)
+{
+	struct pci_sys_data *sys = bus->sysdata;
+	struct gen_pci *pci = sys->private_data;
+	resource_size_t idx = bus->number - pci->cfg.bus_range.start;
+
+	return pci->cfg.win[idx] + ((devfn << 8) | where);
+}
+
+static struct gen_pci_cfg_bus_ops gen_pci_cfg_cam_bus_ops = {
+	.bus_shift	= 16,
+	.map_bus	= gen_pci_map_cfg_bus_cam,
+};
+
+static void __iomem *gen_pci_map_cfg_bus_ecam(struct pci_bus *bus,
+					      unsigned int devfn,
+					      int where)
+{
+	struct pci_sys_data *sys = bus->sysdata;
+	struct gen_pci *pci = sys->private_data;
+	resource_size_t idx = bus->number - pci->cfg.bus_range.start;
+
+	return pci->cfg.win[idx] + ((devfn << 12) | where);
+}
+
+static struct gen_pci_cfg_bus_ops gen_pci_cfg_ecam_bus_ops = {
+	.bus_shift	= 20,
+	.map_bus	= gen_pci_map_cfg_bus_ecam,
+};
+
+static int gen_pci_config_read(struct pci_bus *bus, unsigned int devfn,
+				int where, int size, u32 *val)
+{
+	void __iomem *addr;
+	struct pci_sys_data *sys = bus->sysdata;
+	struct gen_pci *pci = sys->private_data;
+
+	addr = pci->cfg.ops->map_bus(bus, devfn, where);
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
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int gen_pci_config_write(struct pci_bus *bus, unsigned int devfn,
+				 int where, int size, u32 val)
+{
+	void __iomem *addr;
+	struct pci_sys_data *sys = bus->sysdata;
+	struct gen_pci *pci = sys->private_data;
+
+	addr = pci->cfg.ops->map_bus(bus, devfn, where);
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
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static struct pci_ops gen_pci_ops = {
+	.read	= gen_pci_config_read,
+	.write	= gen_pci_config_write,
+};
+
+static struct pci_host_bridge_window *
+gen_pci_alloc_init_window(struct device *dev, struct of_pci_range *range,
+			  struct device_node *np)
+{
+	struct pci_host_bridge_window *win;
+
+	win = devm_kzalloc(dev, sizeof(*win), GFP_KERNEL);
+	if (!win)
+		return NULL;
+
+	win->res = devm_kmalloc(dev, sizeof(*win->res), GFP_KERNEL);
+	if (!win->res)
+		goto out_free_win;
+
+	of_pci_range_to_resource(range, np, win->res);
+	INIT_LIST_HEAD(&win->list);
+	return win;
+
+out_free_win:
+	devm_kfree(dev, win);
+	return NULL;
+}
+
+static void gen_pci_free_window(struct device *dev,
+				struct pci_host_bridge_window *win)
+{
+	devm_kfree(dev, win->res);
+	devm_kfree(dev, win);
+}
+
+static int gen_pci_alloc_io_offset(u32 sz, resource_size_t *offset)
+{
+	static DECLARE_BITMAP(io_map, (IO_SPACE_LIMIT + 1) / SZ_64K);
+	int idx, num_wins;
+
+	if (sz > SZ_64K)
+		return -ENOSPC;
+
+	num_wins = (IO_SPACE_LIMIT + 1) / SZ_64K;
+	idx = 0;
+	do {
+		idx = find_next_zero_bit(io_map, num_wins, idx);
+		if (idx == num_wins)
+			return -ENOSPC;
+	} while (test_and_set_bit(idx, io_map));
+
+	*offset = idx * SZ_64K;
+	return 0;
+}
+
+static const struct of_device_id gen_pci_of_match[] = {
+	{ .compatible = "pci-host-cam-generic",
+	  .data = &gen_pci_cfg_cam_bus_ops },
+
+	{ .compatible = "pci-host-ecam-generic",
+	  .data = &gen_pci_cfg_ecam_bus_ops },
+
+	{ },
+};
+MODULE_DEVICE_TABLE(of, gen_pci_of_match);
+
+static int gen_pci_setup(int nr, struct pci_sys_data *sys)
+{
+	int err, res_valid;
+	u8 bus_max;
+	struct pci_host_bridge_window *win, *tmp;
+	struct resource *bus_range;
+	resource_size_t busn;
+	const char *type;
+	struct of_pci_range range;
+	struct of_pci_range_parser parser;
+	const struct of_device_id *of_id;
+	struct gen_pci *pci = sys->private_data;
+	struct device *dev = pci->host.dev.parent;
+	struct device_node *np = dev->of_node;
+
+	type = of_get_property(np, "device_type", NULL);
+	if (!type || strcmp(type, "pci")) {
+		dev_err(dev, "invalid \"device_type\" %s\n", type);
+		return -EINVAL;
+	}
+
+	if (of_pci_range_parser_init(&parser, np)) {
+		dev_err(dev, "missing \"ranges\" property\n");
+		return -EINVAL;
+	}
+
+	if (of_pci_parse_bus_range(np, &pci->cfg.bus_range))
+		pci->cfg.bus_range = (struct resource) {
+			.name	= np->name,
+			.start	= 0,
+			.end	= 0xff,
+			.flags	= IORESOURCE_BUS,
+		};
+
+	err = of_address_to_resource(np, 0, &pci->cfg.res);
+	if (err) {
+		dev_err(dev, "missing \"reg\" property\n");
+		return err;
+	}
+
+	pci->cfg.win = devm_kcalloc(dev, resource_size(&pci->cfg.bus_range),
+				    sizeof(*pci->cfg.win), GFP_KERNEL);
+	if (!pci->cfg.win)
+		return -ENOMEM;
+
+	of_id = of_match_node(gen_pci_of_match, np);
+	pci->cfg.ops = of_id->data;
+	INIT_LIST_HEAD(&pci->host.windows);
+
+	/* Limit the bus-range to fit within reg */
+	bus_max = pci->cfg.bus_range.start +
+		  (resource_size(&pci->cfg.res) >> pci->cfg.ops->bus_shift) - 1;
+	pci->cfg.bus_range.end = min_t(resource_size_t, pci->cfg.bus_range.end,
+				       bus_max);
+
+	/* Create windows from the ranges property */
+	for_each_of_pci_range(&parser, &range) {
+		resource_size_t offset;
+		u32 restype = range.flags & IORESOURCE_TYPE_BITS;
+
+		if (restype == IORESOURCE_IO) {
+			err = gen_pci_alloc_io_offset(range.size, &offset);
+			if (err) {
+				dev_warn(dev,
+					 "failed to allocate IO window of %lld bytes\n",
+					 range.size);
+				continue;
+			}
+		} else if (restype == IORESOURCE_MEM) {
+			offset = range.cpu_addr - range.pci_addr;
+		} else {
+			dev_warn(dev,
+				"ignoring unknown/unsupported resource type %x\n",
+				 restype);
+			continue;
+		}
+
+		win = gen_pci_alloc_init_window(dev, &range, np);
+		if (!win) {
+			err = -ENOMEM;
+			goto out_free_res;
+		}
+
+		win->offset = offset;
+		list_add(&win->list, &pci->host.windows);
+	}
+
+	/* Map our Configuration Space windows */
+	if (!request_mem_region(pci->cfg.res.start,
+				resource_size(&pci->cfg.res),
+				"Configuration Space"))
+		goto out_free_res;
+
+	bus_range = &pci->cfg.bus_range;
+	for (busn = bus_range->start; busn <= bus_range->end; ++busn) {
+		u32 idx = busn - bus_range->start;
+		u32 sz = 1 << pci->cfg.ops->bus_shift;
+
+		pci->cfg.win[idx] = devm_ioremap(dev,
+						 pci->cfg.res.start + busn * sz,
+						 sz);
+		if (!pci->cfg.win[idx]) {
+			err = -ENOMEM;
+			goto out_unmap_cfg;
+		}
+	}
+
+	/* Register our I/O and Memory resources */
+	res_valid = 0;
+	list_for_each_entry(win, &pci->host.windows, list) {
+		struct resource *parent;
+
+		if (resource_type(win->res) == IORESOURCE_IO) {
+			parent = &ioport_resource;
+			err = pci_ioremap_io(win->offset, win->res->start);
+			if (err)
+				goto out_release_res;
+		} else {
+			res_valid |= !(win->res->flags & IORESOURCE_PREFETCH);
+			parent = &iomem_resource;
+		}
+
+		err = request_resource(parent, win->res);
+		if (err)
+			goto out_release_res;
+
+		pci_add_resource_offset(&sys->resources, win->res, win->offset);
+	}
+
+	if (!res_valid) {
+		dev_err(dev, "non-prefetchable memory resource required\n");
+		err = -EINVAL;
+		goto out_release_res;
+	}
+
+	/* Register bus resource */
+	pci_add_resource(&sys->resources, bus_range);
+	return 1;
+
+out_release_res:
+	list_for_each_entry_continue_reverse(win, &pci->host.windows, list)
+		release_resource(win->res);
+out_unmap_cfg:
+	while (busn-- > bus_range->start)
+		devm_iounmap(dev, pci->cfg.win[busn-bus_range->start]);
+	release_resource(&pci->cfg.res);
+out_free_res:
+	list_for_each_entry_safe(win, tmp, &pci->host.windows, list)
+		gen_pci_free_window(dev, win);
+	devm_kfree(dev, pci->cfg.win);
+	return err;
+}
+
+static int gen_pci_probe(struct platform_device *pdev)
+{
+	struct hw_pci hw;
+	struct gen_pci *pci;
+	struct device *dev = &pdev->dev;
+
+	if (!dev->of_node)
+		return -ENODEV;
+
+	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
+	if (!pci)
+		return -ENOMEM;
+
+	pci->host.dev.parent = dev;
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
+		.name = "pci-host-generic",
+		.owner = THIS_MODULE,
+		.of_match_table = gen_pci_of_match,
+	},
+	.probe = gen_pci_probe,
+};
+module_platform_driver(gen_pci_driver);
+
+MODULE_DESCRIPTION("Generic PCI host driver");
+MODULE_AUTHOR("Will Deacon <will.deacon@arm.com>");
+MODULE_LICENSE("GPLv2");
-- 
1.8.2.2

