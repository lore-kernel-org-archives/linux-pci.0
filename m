Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:45947 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933371Ab3BLQ3s (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Feb 2013 11:29:48 -0500
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Tawfik Bayouk <tawfik@marvell.com>
Subject: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
Date: Tue, 12 Feb 2013 17:28:58 +0100
Message-Id: <1360686546-24277-25-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This driver implements the support for the PCIe interfaces on the
Marvell Armada 370/XP ARM SoCs. In the future, it might be extended to
cover earlier families of Marvell SoCs, such as Dove, Orion and
Kirkwood.

The driver implements the hw_pci operations needed by the core ARM PCI
code to setup PCI devices and get their corresponding IRQs, and the
pci_ops operations that are used by the PCI core to read/write the
configuration space of PCI devices.

Since the PCIe interfaces of Marvell SoCs are completely separate and
not linked together in a bus, this driver sets up an emulated PCI host
bridge, with one PCI-to-PCI bridge as child for each hardware PCIe
interface.

In addition, this driver enumerates the different PCIe slots, and for
those having a device plugged in, it sets up the necessary address
decoding windows, using the new armada_370_xp_alloc_pcie_window()
function from mach-mvebu/addr-map.c.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 .../devicetree/bindings/pci/mvebu-pci.txt          |  174 +++++
 drivers/pci/host/Kconfig                           |    6 +
 drivers/pci/host/Makefile                          |    4 +
 drivers/pci/host/pci-mvebu.c                       |  688 ++++++++++++++++++++
 4 files changed, 872 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/mvebu-pci.txt
 create mode 100644 drivers/pci/host/Makefile
 create mode 100644 drivers/pci/host/pci-mvebu.c

diff --git a/Documentation/devicetree/bindings/pci/mvebu-pci.txt b/Documentation/devicetree/bindings/pci/mvebu-pci.txt
new file mode 100644
index 0000000..bd621c8
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/mvebu-pci.txt
@@ -0,0 +1,174 @@
+* Marvell EBU PCIe interfaces
+
+Mandatory properties:
+- compatible: for now only "marvell,armada-370-xp-pcie" is supported
+- #address-cells, set to <3>
+- #size-cells, set to <2>
+- #interrupt-cells, set to <1>
+- bus-range: PCI bus numbers covered
+- ranges: standard PCI-style address ranges, describing the PCIe
+  registers for each PCIe interface, and then ranges for the PCI
+  memory and I/O regions.
+- interrupt-map-mask and interrupt-map are standard PCI Device Tree
+  properties to describe the interrupts associated to each PCI
+  interface.
+
+In addition, the Device Tree node must have sub-nodes describing each
+PCIe interface, having the following mandatory properties:
+- reg: the address and size of the PCIe registers (translated
+  addresses according to the ranges property of the parent)
+- clocks: the clock associated to this PCIe interface
+- marvell,pcie-port: the physical PCIe port number
+- status: either "disabled" or "okay"
+
+and the following optional properties:
+- marvell,pcie-lane: the physical PCIe lane number, for ports having
+  multiple lanes. If this property is not found, we assume that the
+  value is 0.
+
+Example:
+
+pcie-controller {
+	compatible = "marvell,armada-370-xp-pcie";
+	status = "disabled";
+
+	#address-cells = <3>;
+	#size-cells = <2>;
+
+	bus-range = <0x00 0xff>;
+
+	ranges = <0x00000800 0 0xd0040000 0xd0040000 0 0x00002000   /* port 0.0 registers */
+	          0x00004800 0 0xd0042000 0xd0042000 0 0x00002000   /* port 2.0 registers */
+	          0x00001000 0 0xd0044000 0xd0044000 0 0x00002000   /* port 0.1 registers */
+	          0x00001800 0 0xd0048000 0xd0048000 0 0x00002000   /* port 0.2 registers */
+	          0x00002000 0 0xd004C000 0xd004C000 0 0x00002000   /* port 0.3 registers */
+		  0x00002800 0 0xd0080000 0xd0080000 0 0x00002000   /* port 1.0 registers */
+	          0x00005000 0 0xd0082000 0xd0082000 0 0x00002000   /* port 3.0 registers */
+		  0x00003000 0 0xd0084000 0xd0084000 0 0x00002000   /* port 1.1 registers */
+		  0x00003800 0 0xd0088000 0xd0088000 0 0x00002000   /* port 1.2 registers */
+		  0x00004000 0 0xd008C000 0xd008C000 0 0x00002000   /* port 1.3 registers */
+		  0x81000000 0 0	  0xc0000000 0 0x00100000   /* downstream I/O */
+		  0x82000000 0 0	  0xc1000000 0 0x08000000>; /* non-prefetchable memory */
+
+	#interrupt-cells = <1>;
+	interrupt-map-mask = <0xf800 0 0 1>;
+	interrupt-map = <0x0800 0 0 1 &mpic 58
+		         0x1000 0 0 1 &mpic 59
+			 0x1800 0 0 1 &mpic 60
+			 0x2000 0 0 1 &mpic 61
+			 0x2800 0 0 1 &mpic 62
+		         0x3000 0 0 1 &mpic 63
+			 0x3800 0 0 1 &mpic 64
+			 0x4000 0 0 1 &mpic 65
+			 0x4800 0 0 1 &mpic 99
+			 0x5000 0 0 1 &mpic 103>;
+
+	pcie@0,0 {
+		device_type = "pciex";
+		reg = <0x0800 0 0xd0040000 0 0x2000>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		marvell,pcie-port = <0>;
+		marvell,pcie-lane = <0>;
+		clocks = <&gateclk 5>;
+		status = "disabled";
+	};
+
+	pcie@0,1 {
+		device_type = "pciex";
+		reg = <0x1000 0 0xd0044000 0 0x2000>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		marvell,pcie-port = <0>;
+		marvell,pcie-lane = <1>;
+		clocks = <&gateclk 6>;
+		status = "disabled";
+	};
+
+	pcie@0,2 {
+		device_type = "pciex";
+		reg = <0x1800 0 0xd0048000 0 0x2000>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		marvell,pcie-port = <0>;
+		marvell,pcie-lane = <2>;
+		clocks = <&gateclk 7>;
+		status = "disabled";
+	};
+
+	pcie@0,3 {
+		device_type = "pciex";
+		reg = <0x2000 0 0xd004C000 0 0xC000>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		marvell,pcie-port = <0>;
+		marvell,pcie-lane = <3>;
+		clocks = <&gateclk 8>;
+		status = "disabled";
+	};
+
+	pcie@1,0 {
+		device_type = "pciex";
+		reg = <0x2800 0 0xd0080000 0 0x2000>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		marvell,pcie-port = <1>;
+		marvell,pcie-lane = <0>;
+		clocks = <&gateclk 9>;
+		status = "disabled";
+	};
+
+	pcie@1,1 {
+		device_type = "pciex";
+		reg = <0x3000 0 0xd0084000 0 0x2000>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		marvell,pcie-port = <1>;
+		marvell,pcie-lane = <1>;
+		clocks = <&gateclk 10>;
+		status = "disabled";
+	};
+
+	pcie@1,2 {
+		device_type = "pciex";
+		reg = <0x3800 0 0xd0088000 0 0x2000>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		marvell,pcie-port = <1>;
+		marvell,pcie-lane = <2>;
+		clocks = <&gateclk 11>;
+		status = "disabled";
+	};
+
+	pcie@1,3 {
+		device_type = "pciex";
+		reg = <0x4000 0 0xd008C000 0 0x2000>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		marvell,pcie-port = <1>;
+		marvell,pcie-lane = <3>;
+		clocks = <&gateclk 12>;
+		status = "disabled";
+	};
+	pcie@2,0 {
+		device_type = "pciex";
+		reg = <0x4800 0 0xd0042000 0 0x2000>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		marvell,pcie-port = <2>;
+		marvell,pcie-lane = <0>;
+		clocks = <&gateclk 26>;
+		status = "disabled";
+	};
+
+	pcie@3,0 {
+		device_type = "pciex";
+		reg = <0x5000 0 0xd0082000 0 0x2000>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		marvell,pcie-port = <3>;
+		marvell,pcie-lane = <0>;
+		clocks = <&gateclk 27>;
+		status = "disabled";
+	};
+};
diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index cc3a1af..03e15e7 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -1,4 +1,10 @@
 menu "PCI host controller drivers"
 	depends on PCI
 
+config PCI_MVEBU
+	bool "Marvell EBU PCIe controller"
+	depends on ARCH_MVEBU
+	select PCI_SW_HOST_BRIDGE
+	select PCI_SW_PCI_PCI_BRIDGE
+
 endmenu
diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
new file mode 100644
index 0000000..3ad563f
--- /dev/null
+++ b/drivers/pci/host/Makefile
@@ -0,0 +1,4 @@
+obj-$(CONFIG_PCI_MVEBU) += pci-mvebu.o
+CFLAGS_pci-mvebu.o += \
+	-I$(srctree)/arch/arm/plat-orion/include \
+	-I$(srctree)/arch/arm/mach-mvebu/include
diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
new file mode 100644
index 0000000..82d13da
--- /dev/null
+++ b/drivers/pci/host/pci-mvebu.c
@@ -0,0 +1,688 @@
+/*
+ * PCIe driver for Marvell Armada 370 and Armada XP SoCs
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/platform_device.h>
+#include <linux/of_address.h>
+#include <linux/of_pci.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <plat/pcie.h>
+#include <mach/addr-map.h>
+
+/*
+ * This product ID is registered by Marvell, and used when the Marvell
+ * SoC is not the root complex, but an endpoint on the PCIe bus. It is
+ * therefore safe to re-use this PCI ID for our emulated PCI-to-PCI
+ * bridge.
+ */
+#define MARVELL_EMULATED_PCI_PCI_BRIDGE_ID 0x7846
+
+/* PCI configuration space of a PCI-to-PCI bridge */
+struct mvebu_sw_pci_bridge {
+	u16 vendor;
+	u16 device;
+	u16 command;
+	u16 status;
+	u16 class;
+	u8 interface;
+	u8 revision;
+	u8 bist;
+	u8 header_type;
+	u8 latency_timer;
+	u8 cache_line_size;
+	u32 bar[2];
+	u8 primary_bus;
+	u8 secondary_bus;
+	u8 subordinate_bus;
+	u8 secondary_latency_timer;
+	u8 iobase;
+	u8 iolimit;
+	u16 secondary_status;
+	u16 membase;
+	u16 memlimit;
+	u16 prefmembase;
+	u16 prefmemlimit;
+	u32 prefbaseupper;
+	u32 preflimitupper;
+	u16 iobaseupper;
+	u16 iolimitupper;
+	u8 cappointer;
+	u8 reserved1;
+	u16 reserved2;
+	u32 romaddr;
+	u8 intline;
+	u8 intpin;
+	u16 bridgectrl;
+};
+
+struct mvebu_pcie_port;
+
+/* Structure representing all PCIe interfaces */
+struct mvebu_pcie {
+	struct platform_device *pdev;
+	struct mvebu_pcie_port *ports;
+	struct resource io;
+	struct resource realio;
+	struct resource mem;
+	struct resource busn;
+	int nports;
+};
+
+/* Structure representing one PCIe interface */
+struct mvebu_pcie_port {
+	void __iomem *base;
+	spinlock_t conf_lock;
+	int haslink;
+	u32 port;
+	u32 lane;
+	int devfn;
+	struct clk *clk;
+	struct mvebu_sw_pci_bridge bridge;
+	struct device_node *dn;
+	struct mvebu_pcie *pcie;
+};
+
+static void mvebu_pcie_setup_io_window(struct mvebu_pcie_port *port,
+				       int enable)
+{
+	unsigned long iobase, iolimit;
+
+	if (port->bridge.iolimit < port->bridge.iobase)
+		return;
+
+	iolimit = 0xFFF | ((port->bridge.iolimit & 0xF0) << 8) |
+		(port->bridge.iolimitupper << 16);
+	iobase = ((port->bridge.iobase & 0xF0) << 8) |
+		(port->bridge.iobaseupper << 16);
+
+	if (enable) {
+		unsigned long physbase = port->pcie->io.start + iobase;
+		armada_370_xp_alloc_pcie_window(port->port, port->lane,
+						physbase, iobase,
+						iolimit-iobase,
+						IORESOURCE_IO);
+		pci_ioremap_io(iobase, physbase);
+	}
+	else
+		armada_370_xp_free_pcie_window(iobase);
+}
+
+static void mvebu_pcie_setup_mem_window(struct mvebu_pcie_port *port,
+					int enable)
+{
+	unsigned long membase, memlimit;
+
+	if (port->bridge.memlimit < port->bridge.membase)
+		return;
+
+	membase = ((port->bridge.membase & 0xFFF0) << 16);
+	memlimit = ((port->bridge.memlimit & 0xFFF0) << 16) | 0xFFFFF;
+
+	if (enable)
+		armada_370_xp_alloc_pcie_window(port->port, port->lane,
+						membase, ORION_ADDR_MAP_NO_REMAP,
+						memlimit-membase,
+						IORESOURCE_MEM);
+	else
+		armada_370_xp_free_pcie_window(membase);
+}
+
+static void mvebu_handle_pcie_command(struct mvebu_pcie_port *port, u16 old,
+				      u16 new)
+{
+	/* Enabling an I/O window ? */
+	if (!(old & PCI_COMMAND_IO) && (new & PCI_COMMAND_IO))
+		mvebu_pcie_setup_io_window(port, 1);
+
+	/* Disabling an I/O window ? */
+	if ((old & PCI_COMMAND_IO) && !(new & PCI_COMMAND_IO))
+		mvebu_pcie_setup_io_window(port, 0);
+
+	/* Enabling a memory window ? */
+	if (!(old & PCI_COMMAND_MEMORY) && (new & PCI_COMMAND_MEMORY))
+		mvebu_pcie_setup_mem_window(port, 1);
+
+	/* Disabling a memory window ? */
+	if ((old & PCI_COMMAND_MEMORY) && !(new & PCI_COMMAND_MEMORY))
+		mvebu_pcie_setup_mem_window(port, 0);
+}
+
+/*
+ * Initialize the configuration space of the PCI-to-PCI bridge
+ * associated with the given PCIe interface.
+ */
+static void mvebu_sw_pci_bridge_init(struct mvebu_pcie_port *port)
+{
+	struct mvebu_sw_pci_bridge *bridge = &port->bridge;
+
+	memset(bridge, 0, sizeof(struct mvebu_sw_pci_bridge));
+
+	bridge->status = PCI_STATUS_CAP_LIST;
+	bridge->class = PCI_CLASS_BRIDGE_PCI;
+	bridge->vendor = PCI_VENDOR_ID_MARVELL;
+	bridge->device = MARVELL_EMULATED_PCI_PCI_BRIDGE_ID;
+	bridge->header_type = PCI_HEADER_TYPE_BRIDGE;
+	bridge->cache_line_size = 0x10;
+
+	/* We support 32 bits I/O addressing */
+	bridge->iobase = PCI_IO_RANGE_TYPE_32;
+	bridge->iolimit = PCI_IO_RANGE_TYPE_32;
+}
+
+/*
+ * Read the configuration space of the PCI-to-PCI bridge associated to
+ * the given PCIe interface.
+ */
+static int mvebu_sw_pci_bridge_read(struct mvebu_pcie_port *port,
+				  unsigned int where, int size, u32 *value)
+{
+	struct mvebu_sw_pci_bridge *bridge = &port->bridge;
+
+	switch (where & ~3) {
+	case PCI_VENDOR_ID:
+		*value = bridge->device << 16 | bridge->vendor;
+		break;
+
+	case PCI_COMMAND:
+		*value = bridge->status << 16 | bridge->command;
+		break;
+
+	case PCI_CLASS_REVISION:
+		*value = bridge->class << 16 | bridge->interface << 8 |
+			 bridge->revision;
+		break;
+
+	case PCI_CACHE_LINE_SIZE:
+		*value = bridge->bist << 24 | bridge->header_type << 16 |
+			 bridge->latency_timer << 8 | bridge->cache_line_size;
+		break;
+
+	case PCI_BASE_ADDRESS_0 ... PCI_BASE_ADDRESS_1:
+		*value = bridge->bar[((where & ~3) - PCI_BASE_ADDRESS_0) / 4];
+		break;
+
+	case PCI_PRIMARY_BUS:
+		*value = (bridge->secondary_latency_timer << 24 |
+			  bridge->subordinate_bus         << 16 |
+			  bridge->secondary_bus           <<  8 |
+			  bridge->primary_bus);
+		break;
+
+	case PCI_IO_BASE:
+		*value = (bridge->secondary_status << 16 |
+			  bridge->iolimit          <<  8 |
+			  bridge->iobase);
+		break;
+
+	case PCI_MEMORY_BASE:
+		*value = (bridge->memlimit << 16 | bridge->membase);
+		break;
+
+	case PCI_PREF_MEMORY_BASE:
+		*value = (bridge->prefmemlimit << 16 | bridge->prefmembase);
+		break;
+
+	case PCI_PREF_BASE_UPPER32:
+		*value = bridge->prefbaseupper;
+		break;
+
+	case PCI_PREF_LIMIT_UPPER32:
+		*value = bridge->preflimitupper;
+		break;
+
+	case PCI_IO_BASE_UPPER16:
+		*value = (bridge->iolimitupper << 16 | bridge->iobaseupper);
+		break;
+
+	case PCI_ROM_ADDRESS1:
+		*value = 0;
+		break;
+
+	default:
+		*value = 0xffffffff;
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+	}
+
+	if (size == 2)
+		*value = (*value >> (8 * (where & 3))) & 0xffff;
+	else if (size == 1)
+		*value = (*value >> (8 * (where & 3))) & 0xff;
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+/* Write to the PCI-to-PCI bridge configuration space */
+static int mvebu_sw_pci_bridge_write(struct mvebu_pcie_port *port,
+				     unsigned int where, int size, u32 value)
+{
+	struct mvebu_sw_pci_bridge *bridge = &port->bridge;
+	u32 mask, reg;
+	int err;
+
+	if (size == 4)
+		mask = 0x0;
+	else if (size == 2)
+		mask = ~(0xffff << ((where & 3) * 8));
+	else if (size == 1)
+		mask = ~(0xff << ((where & 3) * 8));
+	else
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+
+	err = mvebu_sw_pci_bridge_read(port, where & ~3, 4, &reg);
+	if (err)
+		return err;
+
+	value = (reg & mask) | value << ((where & 3) * 8);
+
+	switch (where & ~3) {
+	case PCI_COMMAND:
+		mvebu_handle_pcie_command(port, bridge->command,
+					  value & 0xffff);
+		bridge->command = value & 0xffff;
+		bridge->status = value >> 16;
+		break;
+
+	case PCI_BASE_ADDRESS_0 ... PCI_BASE_ADDRESS_1:
+		bridge->bar[((where & ~3) - PCI_BASE_ADDRESS_0) / 4] = value;
+		break;
+
+	case PCI_IO_BASE:
+		/*
+		 * We also keep bit 1 set, it is a read-only bit that
+		 * indicates we support 32 bits addressing for the
+		 * I/O
+		 */
+		bridge->iobase = (value & 0xff) | PCI_IO_RANGE_TYPE_32;
+		bridge->iolimit = ((value >> 8) & 0xff) | PCI_IO_RANGE_TYPE_32;
+		bridge->secondary_status = value >> 16;
+		break;
+
+	case PCI_MEMORY_BASE:
+		bridge->membase = value & 0xffff;
+		bridge->memlimit = value >> 16;
+		break;
+
+	case PCI_PREF_MEMORY_BASE:
+		bridge->prefmembase = value & 0xffff;
+		bridge->prefmemlimit = value >> 16;
+		break;
+
+	case PCI_PREF_BASE_UPPER32:
+		bridge->prefbaseupper = value;
+		break;
+
+	case PCI_PREF_LIMIT_UPPER32:
+		bridge->preflimitupper = value;
+		break;
+
+	case PCI_IO_BASE_UPPER16:
+		bridge->iobaseupper = value & 0xffff;
+		bridge->iolimitupper = value >> 16;
+		break;
+
+	case PCI_PRIMARY_BUS:
+		bridge->primary_bus             = value & 0xff;
+		bridge->secondary_bus           = (value >> 8) & 0xff;
+		bridge->subordinate_bus         = (value >> 16) & 0xff;
+		bridge->secondary_latency_timer = (value >> 24) & 0xff;
+		orion_pcie_set_local_bus_nr(port->base, bridge->secondary_bus);
+		break;
+
+	default:
+		break;
+	}
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static inline struct mvebu_pcie *sys_to_pcie(struct pci_sys_data *sys)
+{
+	return sys->private_data;
+}
+
+/* Find the PCIe interface that corresponds to the given bus */
+static struct mvebu_pcie_port *mvebu_find_port_from_bus(struct mvebu_pcie *pcie,
+							int bus)
+{
+	int porti;
+
+	for (porti = 0; porti < pcie->nports; porti++)
+		if (pcie->ports[porti].bridge.secondary_bus == bus)
+			return &pcie->ports[porti];
+
+	return NULL;
+}
+
+/* PCI configuration space write function */
+static int mvebu_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
+			      int where, int size, u32 val)
+{
+	struct mvebu_pcie *pcie = sys_to_pcie(bus->sysdata);
+
+	if (bus->number != 0) {
+		/*
+		 * Accessing a real PCIe interface.
+		 */
+		struct mvebu_pcie_port *port;
+		unsigned long flags;
+		int ret;
+
+		port = mvebu_find_port_from_bus(pcie, bus->number);
+		if (!port)
+			return PCIBIOS_DEVICE_NOT_FOUND;
+
+		if (!port->haslink)
+			return PCIBIOS_DEVICE_NOT_FOUND;
+
+		if (PCI_SLOT(devfn) != 0)
+			return PCIBIOS_DEVICE_NOT_FOUND;
+
+		spin_lock_irqsave(&port->conf_lock, flags);
+		ret = orion_pcie_wr_conf(port->base, bus,
+					 PCI_DEVFN(1, PCI_FUNC(devfn)),
+					 where, size, val);
+		spin_unlock_irqrestore(&port->conf_lock, flags);
+
+		return ret;
+	} else {
+		/*
+		 * Access the emulated PCI-to-PCI bridges.
+		 */
+		if (PCI_SLOT(devfn) >= 1 &&
+		    PCI_SLOT(devfn) <= pcie->nports) {
+			struct mvebu_pcie_port *port;
+			int porti = PCI_SLOT(devfn) - 1;
+			port = &pcie->ports[porti];
+			return mvebu_sw_pci_bridge_write(port, where, size, val);
+		} else {
+			return PCIBIOS_DEVICE_NOT_FOUND;
+		}
+	}
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+/* PCI configuration space read function */
+static int mvebu_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
+			      int size, u32 *val)
+{
+	struct mvebu_pcie *pcie = sys_to_pcie(bus->sysdata);
+
+	if (bus->number != 0) {
+		/*
+		 * Accessing a real PCIe interface.
+		 */
+		struct mvebu_pcie_port *port;
+		unsigned long flags;
+		int ret;
+
+		port = mvebu_find_port_from_bus(pcie, bus->number);
+		if (!port) {
+			*val = 0xffffffff;
+			return PCIBIOS_DEVICE_NOT_FOUND;
+		}
+
+		if (!port->haslink || PCI_SLOT(devfn) != 0) {
+			*val = 0xffffffff;
+			return PCIBIOS_DEVICE_NOT_FOUND;
+		}
+
+		spin_lock_irqsave(&port->conf_lock, flags);
+		ret = orion_pcie_rd_conf(port->base, bus,
+					 PCI_DEVFN(1, PCI_FUNC(devfn)),
+					 where, size, val);
+		spin_unlock_irqrestore(&port->conf_lock, flags);
+
+		return ret;
+	} else {
+		/*
+		 * Access the emulated PCI-to-PCI bridges.
+		 */
+		if (PCI_SLOT(devfn) >= 1 &&
+		    PCI_SLOT(devfn) <= pcie->nports) {
+			struct mvebu_pcie_port *port;
+			int porti = PCI_SLOT(devfn) - 1;
+			port = &pcie->ports[porti];
+			return mvebu_sw_pci_bridge_read(port, where, size, val);
+		} else {
+			*val = 0xffffffff;
+			return PCIBIOS_DEVICE_NOT_FOUND;
+		}
+	}
+}
+
+static struct pci_ops mvebu_pcie_ops = {
+	.read = mvebu_pcie_rd_conf,
+	.write = mvebu_pcie_wr_conf,
+};
+
+static int __init mvebu_pcie_setup(int nr, struct pci_sys_data *sys)
+{
+	struct mvebu_pcie *pcie = sys_to_pcie(sys);
+	int i;
+
+	pci_add_resource_offset(&sys->resources, &pcie->realio, sys->io_offset);
+	pci_add_resource_offset(&sys->resources, &pcie->mem, sys->mem_offset);
+	pci_add_resource(&sys->resources, &pcie->busn);
+
+	for (i = 0; i < pcie->nports; i++) {
+		struct mvebu_pcie_port *port = &pcie->ports[i];
+		orion_pcie_setup(port->base);
+	}
+
+	return 1;
+}
+
+static int __init mvebu_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+{
+	struct of_irq oirq;
+	int ret;
+
+	ret = of_irq_map_pci(dev, &oirq);
+	if (ret) {
+		return ret;
+	}
+
+	return irq_create_of_mapping(oirq.controller, oirq.specifier,
+				     oirq.size);
+}
+
+static struct pci_bus *mvebu_pcie_scan_bus(int nr, struct pci_sys_data *sys)
+{
+	struct mvebu_pcie *pcie = sys_to_pcie(sys);
+	return pci_scan_root_bus(&pcie->pdev->dev, sys->busnr,
+				 &mvebu_pcie_ops, sys, &sys->resources);
+}
+
+resource_size_t mvebu_pcie_align_resource(struct pci_dev *dev,
+					  const struct resource *res,
+					  resource_size_t start,
+					  resource_size_t size,
+					  resource_size_t align)
+{
+	if (dev->bus->number != 0)
+		return start;
+
+	/*
+	 * On the PCI-to-PCI bridge side, the I/O windows must have at
+	 * least a 64 KB size and be aligned on their size, and the
+	 * memory windows must have at least a 1 MB size and be
+	 * aligned on their size
+	 */
+	if (res->flags & IORESOURCE_IO)
+		return round_up(start, max((resource_size_t)SZ_64K, size));
+	else if (res->flags & IORESOURCE_MEM)
+		return round_up(start, max((resource_size_t)SZ_1M, size));
+	else
+		return start;
+}
+
+static void mvebu_pcie_enable(struct mvebu_pcie *pcie)
+{
+	struct hw_pci hw;
+
+	memset(&hw, 0, sizeof(hw));
+
+	hw.nr_controllers = 1;
+	hw.private_data   = (void **)&pcie;
+	hw.setup          = mvebu_pcie_setup;
+	hw.scan           = mvebu_pcie_scan_bus;
+	hw.map_irq        = mvebu_pcie_map_irq;
+	hw.ops            = &mvebu_pcie_ops;
+	hw.align_resource = mvebu_pcie_align_resource;
+
+	pci_common_init(&hw);
+}
+
+static int __init mvebu_pcie_probe(struct platform_device *pdev)
+{
+	struct mvebu_pcie *pcie;
+	struct device_node *np = pdev->dev.of_node;
+	struct device_node *child;
+	const __be32 *range = NULL;
+	struct resource res;
+	int i, ret;
+
+	pcie = devm_kzalloc(&pdev->dev, sizeof(struct mvebu_pcie),
+			    GFP_KERNEL);
+	if (!pcie)
+		return -ENOMEM;
+
+	pcie->pdev = pdev;
+
+	/* Get the I/O and memory ranges from DT */
+	while ((range = of_pci_process_ranges(np, &res, range)) != NULL) {
+		if (resource_type(&res) == IORESOURCE_IO) {
+			memcpy(&pcie->io, &res, sizeof(res));
+			memcpy(&pcie->realio, &res, sizeof(res));
+			pcie->io.name = "I/O";
+			pcie->realio.start &= 0xFFFFF;
+			pcie->realio.end   &= 0xFFFFF;
+		}
+		if (resource_type(&res) == IORESOURCE_MEM) {
+			memcpy(&pcie->mem, &res, sizeof(res));
+			pcie->mem.name = "MEM";
+		}
+	}
+
+	/* Get the bus range */
+	ret = of_pci_parse_bus_range(np, &pcie->busn);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to parse bus-range property: %d\n",
+			ret);
+		return ret;
+	}
+
+	for_each_child_of_node(pdev->dev.of_node, child) {
+		if (!of_device_is_available(child))
+			continue;
+		pcie->nports++;
+	}
+
+	pcie->ports = devm_kzalloc(&pdev->dev, pcie->nports *
+				   sizeof(struct mvebu_pcie_port),
+				   GFP_KERNEL);
+	if (!pcie->ports)
+		return -ENOMEM;
+
+	i = 0;
+	for_each_child_of_node(pdev->dev.of_node, child) {
+		struct mvebu_pcie_port *port = &pcie->ports[i];
+
+		if (!of_device_is_available(child))
+			continue;
+
+		port->pcie = pcie;
+
+		if (of_property_read_u32(child, "marvell,pcie-port",
+					 &port->port)) {
+			dev_warn(&pdev->dev,
+				 "ignoring PCIe DT node, missing pcie-port property\n");
+			continue;
+		}
+
+		if (of_property_read_u32(child, "marvell,pcie-lane",
+					 &port->lane))
+			port->lane = 0;
+
+		port->devfn = of_pci_get_devfn(child);
+		if (port->devfn < 0)
+			continue;
+
+		port->base = of_iomap(child, 0);
+		if (!port->base) {
+			dev_err(&pdev->dev, "PCIe%d.%d: cannot map registers\n",
+				port->port, port->lane);
+			continue;
+		}
+
+		if (orion_pcie_link_up(port->base)) {
+			port->haslink = 1;
+			dev_info(&pdev->dev, "PCIe%d.%d: link up\n",
+				 port->port, port->lane);
+		} else {
+			port->haslink = 0;
+			dev_info(&pdev->dev, "PCIe%d.%d: link down\n",
+				 port->port, port->lane);
+		}
+
+		port->clk = of_clk_get_by_name(child, NULL);
+		if (!port->clk) {
+			dev_err(&pdev->dev, "PCIe%d.%d: cannot get clock\n",
+			       port->port, port->lane);
+			iounmap(port->base);
+			port->haslink = 0;
+			continue;
+		}
+
+		port->dn = child;
+
+		clk_prepare_enable(port->clk);
+		spin_lock_init(&port->conf_lock);
+
+		mvebu_sw_pci_bridge_init(port);
+
+		i++;
+	}
+
+	mvebu_pcie_enable(pcie);
+
+	return 0;
+}
+
+static const struct of_device_id mvebu_pcie_of_match_table[] = {
+	{ .compatible = "marvell,armada-370-xp-pcie", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, mvebu_pcie_of_match_table);
+
+static struct platform_driver mvebu_pcie_driver = {
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "mvebu-pcie",
+		.of_match_table =
+		   of_match_ptr(mvebu_pcie_of_match_table),
+	},
+};
+
+static int mvebu_pcie_init(void)
+{
+	return platform_driver_probe(&mvebu_pcie_driver,
+				     mvebu_pcie_probe);
+}
+
+subsys_initcall(mvebu_pcie_init);
+
+MODULE_AUTHOR("Thomas Petazzoni <thomas.petazzoni@free-electrons.com>");
+MODULE_DESCRIPTION("Marvell EBU PCIe driver");
+MODULE_LICENSE("GPLv2");
-- 
1.7.9.5

