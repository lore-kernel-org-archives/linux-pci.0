Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:49535 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932095AbaBDQxl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 4 Feb 2014 11:53:41 -0500
From: Will Deacon <will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: arnd@arndb.de, Liviu.Dudau@arm.com, linux-pci@vger.kernel.org,
	bhelgaas@google.com, mohit.kumar@st.com,
	Will Deacon <will.deacon@arm.com>
Subject: [PATCH 2/3] PCI: ARM: add support for virtual PCI host controller
Date: Tue,  4 Feb 2014 16:53:03 +0000
Message-Id: <1391532784-1953-3-git-send-email-will.deacon@arm.com>
In-Reply-To: <1391532784-1953-1-git-send-email-will.deacon@arm.com>
References: <1391532784-1953-1-git-send-email-will.deacon@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds support for an extremely simple virtual PCI host
controller. The controller itself has no configuration registers, and
has its address spaces described entirely by the device-tree (using the
bindings described by ePAPR). This allows emulations, such as kvmtool,
to provide a simple means for a guest Linux instance to make use of
PCI devices.

Corresponding documentation is added for the DT binding.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 .../devicetree/bindings/pci/linux,pci-virt.txt     |  38 ++++
 drivers/pci/host/Kconfig                           |   7 +
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pci-virt.c                        | 200 +++++++++++++++++++++
 4 files changed, 246 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/linux,pci-virt.txt
 create mode 100644 drivers/pci/host/pci-virt.c

diff --git a/Documentation/devicetree/bindings/pci/linux,pci-virt.txt b/Documentation/devicetree/bindings/pci/linux,pci-virt.txt
new file mode 100644
index 000000000000..54668a283498
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/linux,pci-virt.txt
@@ -0,0 +1,38 @@
+* ARM Basic Virtual PCI controller
+
+PCI emulations, such as the virtio-pci implementations found in kvmtool
+and other para-virtualised systems, do not require driver support for
+complexities such as regulator and clock management. In fact, the
+controller may not even have a control interface visible to the
+operating system, instead presenting a set of fixed windows describing a
+subset of IO, Memory and Configuration spaces.
+
+Such a controller can be described purely in terms of the standardized
+device tree bindings communicated in pci.txt:
+
+- compatible     : Must be "linux,pci-virt"
+
+- ranges         : As described in IEEE Std 1275-1994, but must provide
+                   at least a definition of the Configuration Space plus
+                   one or both of IO and Memory Space.
+
+- #address-cells : Must be 3
+
+- #size-cells    : Must be 2
+
+Configuration Space is assumed to be memory-mapped (as opposed to being
+accessed via an ioport) and laid out with a direct correspondence to the
+geography of a PCI bus address, by concatenating the various components
+to form a 24-bit offset:
+
+        cfg_offset(bus, device, function, register) =
+                bus << 16 | device << 11 | function << 8 | register
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
index 47d46c6d8468..fd4460573b81 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -33,4 +33,11 @@ config PCI_RCAR_GEN2
 	  There are 3 internal PCI controllers available with a single
 	  built-in EHCI/OHCI host controller present on each one.
 
+config PCI_VIRT_HOST
+	bool "Virtual PCI host controller"
+	depends on ARM && OF
+	help
+	  Say Y here if you want to support a very simple virtual PCI
+	  host controller, such as the one emulated by kvmtool.
+
 endmenu
diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
index 13fb3333aa05..9b6775d95d3b 100644
--- a/drivers/pci/host/Makefile
+++ b/drivers/pci/host/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_PCI_IMX6) += pci-imx6.o
 obj-$(CONFIG_PCI_MVEBU) += pci-mvebu.o
 obj-$(CONFIG_PCI_TEGRA) += pci-tegra.o
 obj-$(CONFIG_PCI_RCAR_GEN2) += pci-rcar-gen2.o
+obj-$(CONFIG_PCI_VIRT_HOST) += pci-virt.o
diff --git a/drivers/pci/host/pci-virt.c b/drivers/pci/host/pci-virt.c
new file mode 100644
index 000000000000..ded01474453b
--- /dev/null
+++ b/drivers/pci/host/pci-virt.c
@@ -0,0 +1,200 @@
+/*
+ * Very basic PCI host controller driver targetting virtual machines
+ * (e.g. the PCI emulation provided by kvmtool).
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
+ *
+ * This driver currently supports (per instance):
+ *	- A single controller
+ *	- A single memory space and/or port space
+ *	- A memory-mapped configuration space
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_pci.h>
+#include <linux/platform_device.h>
+
+struct virt_pci {
+	struct device	*dev;
+
+	struct resource	cfg;
+	struct resource	io;
+	struct resource	mem;
+
+	void __iomem	*cfg_base;
+};
+
+static void __iomem *virt_pci_config_address(struct pci_bus *bus,
+					     unsigned int devfn,
+					     int where)
+{
+	struct pci_sys_data *sys = bus->sysdata;
+	struct virt_pci *pci = sys->private_data;
+	void __iomem *addr = pci->cfg_base;
+
+	/*
+	 * We construct config space addresses by simply sandwiching
+	 * together all of the PCI address components and using the
+	 * result as an offset into a 16M region.
+	 */
+	return addr + (((u32)bus->number << 16) | (devfn << 8) | where);
+}
+
+
+static int virt_pci_config_read(struct pci_bus *bus, unsigned int devfn,
+				int where, int size, u32 *val)
+{
+	void __iomem *addr = virt_pci_config_address(bus, devfn, where);
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
+static int virt_pci_config_write(struct pci_bus *bus, unsigned int devfn,
+				 int where, int size, u32 val)
+{
+	void __iomem *addr = virt_pci_config_address(bus, devfn, where);
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
+static struct pci_ops virt_pci_ops = {
+	.read	= virt_pci_config_read,
+	.write	= virt_pci_config_write,
+};
+
+static int virt_pci_setup(int nr, struct pci_sys_data *sys)
+{
+	struct virt_pci *pci = sys->private_data;
+
+	if (resource_type(&pci->io)) {
+		pci_add_resource(&sys->resources, &pci->io);
+		pci_ioremap_io(nr * resource_size(&pci->io), pci->io.start);
+	}
+
+	if (resource_type(&pci->mem))
+		pci_add_resource(&sys->resources, &pci->mem);
+
+	pci->cfg_base = devm_ioremap_resource(pci->dev, &pci->cfg);
+	return !IS_ERR(pci->cfg_base);
+}
+
+static const struct of_device_id virt_pci_of_match[] = {
+	{ .compatible = "linux,pci-virt" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, virt_pci_of_match);
+
+static int virt_pci_probe(struct platform_device *pdev)
+{
+	struct hw_pci hw;
+	struct of_pci_range range;
+	struct of_pci_range_parser parser;
+	struct virt_pci *pci;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+
+	if (of_pci_range_parser_init(&parser, np)) {
+		dev_err(dev, "missing \"ranges\" property\n");
+		return -EINVAL;
+	}
+
+	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
+	if (!pci)
+		return -ENOMEM;
+
+	pci->dev = dev;
+	for_each_of_pci_range(&parser, &range) {
+		u32 restype = range.flags & IORESOURCE_TYPE_BITS;
+
+		switch (restype) {
+		case IORESOURCE_IO:
+			if (resource_type(&pci->io))
+				dev_warn(dev,
+					 "ignoring additional io resource\n");
+			else
+				of_pci_range_to_resource(&range, np, &pci->io);
+			break;
+		case IORESOURCE_MEM:
+			if (resource_type(&pci->mem))
+				dev_warn(dev,
+					 "ignoring additional mem resource\n");
+			else
+				of_pci_range_to_resource(&range, np, &pci->mem);
+			break;
+		case 0:	/* cfg */
+			if (resource_type(&pci->cfg)) {
+				dev_warn(dev,
+					 "ignoring additional cfg resource\n");
+			} else {
+				of_pci_range_to_resource(&range, np, &pci->cfg);
+				pci->cfg.flags |= IORESOURCE_MEM;
+			}
+			break;
+		default:
+			dev_warn(dev,
+				"ignoring unknown/unsupported resource type %x\n",
+				 restype);
+		}
+	}
+
+	memset(&hw, 0, sizeof(hw));
+	hw.nr_controllers	= 1;
+	hw.private_data		= (void **)&pci;
+	hw.setup		= virt_pci_setup;
+	hw.map_irq		= of_irq_parse_and_map_pci;
+	hw.ops			= &virt_pci_ops;
+	pci_common_init_dev(dev, &hw);
+	return 0;
+}
+
+static struct platform_driver virt_pci_driver = {
+	.driver = {
+		.name = "pci-virt",
+		.owner = THIS_MODULE,
+		.of_match_table = virt_pci_of_match,
+	},
+	.probe = virt_pci_probe,
+};
+module_platform_driver(virt_pci_driver);
+
+MODULE_DESCRIPTION("Virtual PCI host driver");
+MODULE_AUTHOR("Will Deacon <will.deacon@arm.com>");
+MODULE_LICENSE("GPLv2");
-- 
1.8.2.2

