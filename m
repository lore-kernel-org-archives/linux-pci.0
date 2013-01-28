Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:58326 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752523Ab3A1S5N (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 28 Jan 2013 13:57:13 -0500
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP systems
Date: Mon, 28 Jan 2013 19:56:28 +0100
Message-Id: <1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
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
 .../devicetree/bindings/pci/armada-370-xp-pcie.txt |  175 +++++++
 drivers/pci/host/Kconfig                           |    6 +
 drivers/pci/host/Makefile                          |    4 +
 drivers/pci/host/pci-mvebu.c                       |  500 ++++++++++++++++++++
 4 files changed, 685 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/armada-370-xp-pcie.txt
 create mode 100644 drivers/pci/host/Makefile
 create mode 100644 drivers/pci/host/pci-mvebu.c

diff --git a/Documentation/devicetree/bindings/pci/armada-370-xp-pcie.txt b/Documentation/devicetree/bindings/pci/armada-370-xp-pcie.txt
new file mode 100644
index 0000000..9313e92
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/armada-370-xp-pcie.txt
@@ -0,0 +1,175 @@
+* Marvell Armada 370/XP PCIe interfaces
+
+Mandatory properties:
+- compatible: must be "marvell,armada-370-xp-pcie"
+- status: either "disabled" or "okay"
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
index 0000000..34d6057
--- /dev/null
+++ b/drivers/pci/host/Makefile
@@ -0,0 +1,4 @@
+obj-$(CONFIG_PCI_MVEBU) += pci-mvebu.o
+ccflags-$(CONFIG_PCI_MVEBU) += \
+	-I$(srctree)/arch/arm/plat-orion/include \
+	-I$(srctree)/arch/arm/mach-mvebu/include
diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
new file mode 100644
index 0000000..4db09e1
--- /dev/null
+++ b/drivers/pci/host/pci-mvebu.c
@@ -0,0 +1,500 @@
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
+ * Those are the product IDs used for the emulated PCI Host bridge and
+ * emulated PCI-to-PCI bridges. They are temporary until we get
+ * official IDs assigned.
+ */
+#define MARVELL_EMULATED_HOST_BRIDGE_ID    4141
+#define MARVELL_EMULATED_PCI_PCI_BRIDGE_ID 4242
+
+struct mvebu_pcie_port;
+
+/* Structure representing all PCIe interfaces */
+struct mvebu_pcie {
+	struct pci_sw_host_bridge bridge;
+	struct platform_device *pdev;
+	struct mvebu_pcie_port *ports;
+	struct resource io;
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
+	struct pci_sw_pci_bridge bridge;
+	struct device_node *dn;
+};
+
+static inline struct mvebu_pcie *sys_to_pcie(struct pci_sys_data *sys)
+{
+	return sys->private_data;
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
+		 * Accessing a real PCIe interface, where the Linux
+		 * virtual bus number is equal to the hardware PCIe
+		 * interface number + 1
+		 */
+		struct mvebu_pcie_port *port;
+		unsigned long flags;
+		int porti, ret;
+
+		porti = bus->number - 1;
+		if (porti >= pcie->nports)
+			return PCIBIOS_DEVICE_NOT_FOUND;
+
+		port = &pcie->ports[porti];
+
+		if (!port->haslink)
+			return PCIBIOS_DEVICE_NOT_FOUND;
+
+		if (PCI_SLOT(devfn) != 0)
+			return PCIBIOS_DEVICE_NOT_FOUND;
+
+		spin_lock_irqsave(&port->conf_lock, flags);
+		ret = orion_pcie_wr_conf_bus(port->base, bus->number - 1,
+					     PCI_DEVFN(1, PCI_FUNC(devfn)),
+					     where, size, val);
+		spin_unlock_irqrestore(&port->conf_lock, flags);
+
+		return ret;
+	} else {
+		/*
+		 * Accessing the emulated PCIe devices. In the first
+		 * slot, the emulated host bridge, and in the next
+		 * slots, the PCI-to-PCI bridges that correspond to
+		 * each PCIe hardware interface
+		 */
+		if (PCI_SLOT(devfn) == 0 && PCI_FUNC(devfn) == 0)
+			return pci_sw_host_bridge_write(&pcie->bridge, where,
+							size, val);
+		else if (PCI_SLOT(devfn) >= 1 &&
+			 PCI_SLOT(devfn) <= pcie->nports) {
+			struct mvebu_pcie_port *port;
+			int porti = PCI_SLOT(devfn) - 1;
+			port = &pcie->ports[porti];
+			return pci_sw_pci_bridge_write(&port->bridge, where,
+						       size, val);
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
+		 * Accessing a real PCIe interface, where the Linux
+		 * virtual bus number is equal to the hardware PCIe
+		 * interface number + 1
+		 */
+		struct mvebu_pcie_port *port;
+		unsigned long flags;
+		int porti, ret;
+
+		porti = bus->number - 1;
+		if (porti >= pcie->nports) {
+			*val = 0xffffffff;
+			return PCIBIOS_DEVICE_NOT_FOUND;
+		}
+
+		port = &pcie->ports[porti];
+
+		if (!port->haslink || PCI_SLOT(devfn) != 0) {
+			*val = 0xffffffff;
+			return PCIBIOS_DEVICE_NOT_FOUND;
+		}
+
+		spin_lock_irqsave(&port->conf_lock, flags);
+		ret = orion_pcie_rd_conf_bus(port->base, bus->number - 1,
+					     PCI_DEVFN(1, PCI_FUNC(devfn)),
+					     where, size, val);
+		spin_unlock_irqrestore(&port->conf_lock, flags);
+
+		return ret;
+	} else {
+		/*
+		 * Accessing the emulated PCIe devices. In the first
+		 * slot, the emulated host bridge, and in the next
+		 * slots, the PCI-to-PCI bridges that correspond to
+		 * each PCIe hardware interface
+		 */
+		if (PCI_SLOT(devfn) == 0 && PCI_FUNC(devfn) == 0)
+			return pci_sw_host_bridge_read(&pcie->bridge, where,
+						       size, val);
+		else if (PCI_SLOT(devfn) >= 1 &&
+			 PCI_SLOT(devfn) <= pcie->nports) {
+			struct mvebu_pcie_port *port;
+			int porti = PCI_SLOT(devfn) - 1;
+			port = &pcie->ports[porti];
+			return pci_sw_pci_bridge_read(&port->bridge, where,
+						      size, val);
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
+	pci_add_resource_offset(&sys->resources, &pcie->io, sys->io_offset);
+	pci_add_resource_offset(&sys->resources, &pcie->mem, sys->mem_offset);
+	pci_add_resource(&sys->resources, &pcie->busn);
+
+	pci_ioremap_io(nr * SZ_64K, pcie->io.start);
+
+	for (i = 0; i < pcie->nports; i++) {
+		struct mvebu_pcie_port *port = &pcie->ports[i];
+		orion_pcie_set_local_bus_nr(port->base, i);
+		orion_pcie_setup(port->base);
+	}
+
+	return 1;
+}
+
+static int __init mvebu_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+{
+	struct mvebu_pcie *pcie = sys_to_pcie(dev->bus->sysdata);
+	struct mvebu_pcie_port *port;
+	struct of_irq oirq;
+	u32 laddr[3];
+	int ret;
+	__be32 intspec;
+
+	/*
+	 * Ignore requests related to the emulated host bridge or the
+	 * emulated pci-to-pci bridges
+	 */
+	if (!dev->bus->number)
+		return -1;
+
+	port = &pcie->ports[dev->bus->number - 1];
+
+	/*
+	 * Build an laddr array that describes the PCI device in a DT
+	 * way
+	 */
+	laddr[0] = cpu_to_be32(port->devfn << 8);
+	laddr[1] = laddr[2] = 0;
+	intspec = cpu_to_be32(pin);
+
+	ret = of_irq_map_raw(port->dn, &intspec, 1, laddr, &oirq);
+	if (ret) {
+		dev_err(&pcie->pdev->dev,
+			"%s: of_irq_map_raw() failed, %d\n",
+			__func__, ret);
+		return ret;
+	}
+
+	return irq_create_of_mapping(oirq.controller, oirq.specifier,
+				     oirq.size);
+}
+
+/*
+ * For a given PCIe interface (represented by a mvebu_pcie_port
+ * structure), we read the PCI configuration space of the
+ * corresponding PCI-to-PCI bridge in order to find out which range of
+ * I/O addresses and memory addresses have been assigned to this PCIe
+ * interface. Using these informations, we set up the appropriate
+ * address decoding windows so that the physical address are actually
+ * resolved to the right PCIe interface.
+ */
+static int mvebu_pcie_window_config_port(struct mvebu_pcie *pcie,
+					 struct mvebu_pcie_port *port)
+{
+	unsigned long iobase = 0;
+	int ret;
+
+	if (port->bridge.iolimit >= port->bridge.iobase) {
+		unsigned long iolimit = 0xFFF |
+			((port->bridge.iolimit & 0xF0) << 8) |
+			(port->bridge.iolimitupper << 16);
+		iobase = ((port->bridge.iobase & 0xF0) << 8) |
+			(port->bridge.iobaseupper << 16);
+		ret = armada_370_xp_alloc_pcie_window(port->port, port->lane,
+						      iobase, iolimit-iobase,
+						      IORESOURCE_IO);
+		if (ret) {
+			dev_err(&pcie->pdev->dev,
+				"%s: could not alloc PCIe %d:%d window for I/O [0x%lx; 0x%lx]\n",
+				__func__, port->port, port->lane,
+				iobase, iolimit);
+			goto out_io;
+		}
+	}
+
+	if (port->bridge.memlimit >= port->bridge.membase) {
+		unsigned long membase =
+			((port->bridge.membase & 0xFFF0) << 16);
+		unsigned long memlimit =
+			((port->bridge.memlimit & 0xFFF0) << 16) | 0xFFFFF;
+		ret = armada_370_xp_alloc_pcie_window(port->port, port->lane,
+						      membase, memlimit-membase,
+						      IORESOURCE_MEM);
+		if (ret) {
+			dev_err(&pcie->pdev->dev,
+				"%s: could not alloc PCIe %d:%d window for MEM [0x%lx; 0x%lx]\n",
+				__func__, port->port, port->lane,
+				membase, memlimit);
+			goto out_mem;
+		}
+	}
+
+out_mem:
+	if (port->bridge.iolimit >= port->bridge.iobase)
+		armada_370_xp_free_pcie_window(iobase);
+out_io:
+	return ret;
+}
+
+/*
+ * Set up the address decoding windows for all PCIe interfaces.
+ */
+static int mvebu_pcie_window_config(struct mvebu_pcie *pcie)
+{
+	int i, ret;
+
+	for (i = 0; i < pcie->nports; i++) {
+		struct mvebu_pcie_port *port = &pcie->ports[i];
+		if (!port->haslink)
+			continue;
+
+		ret = mvebu_pcie_window_config_port(pcie, port);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static resource_size_t mvebu_pcie_align_resource(struct pci_dev *dev,
+						 const struct resource *res,
+						 resource_size_t start,
+						 resource_size_t size,
+						 resource_size_t align)
+{
+	if (!(res->flags & IORESOURCE_IO))
+		return start;
+
+	/*
+	 * The I/O regions must be 64K aligned, because the
+	 * granularity of PCIe I/O address decoding windows is 64 K
+	 */
+	return round_up(start, SZ_64K);
+}
+
+static int mvebu_pcie_enable(struct mvebu_pcie *pcie)
+{
+	struct hw_pci hw;
+
+	memset(&hw, 0, sizeof(hw));
+
+	hw.nr_controllers = 1;
+	hw.private_data   = (void **)&pcie;
+	hw.setup          = mvebu_pcie_setup;
+	hw.map_irq        = mvebu_pcie_map_irq;
+	hw.align_resource = mvebu_pcie_align_resource;
+	hw.ops            = &mvebu_pcie_ops;
+
+	pci_common_init(&hw);
+
+	return mvebu_pcie_window_config(pcie);
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
+	pci_sw_host_bridge_init(&pcie->bridge);
+	pcie->bridge.vendor = PCI_VENDOR_ID_MARVELL;
+	pcie->bridge.device = MARVELL_EMULATED_HOST_BRIDGE_ID;
+
+	/* Get the I/O and memory ranges from DT */
+	while ((range = of_pci_process_ranges(np, &res, range)) != NULL) {
+		if (resource_type(&res) == IORESOURCE_IO) {
+			memcpy(&pcie->io, &res, sizeof(res));
+			pcie->io.name = "I/O";
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
+		pci_sw_pci_bridge_init(&port->bridge);
+		port->bridge.vendor = PCI_VENDOR_ID_MARVELL;
+		port->bridge.device = MARVELL_EMULATED_PCI_PCI_BRIDGE_ID;
+		port->bridge.primary_bus = 0;
+		port->bridge.secondary_bus = PCI_SLOT(port->devfn);
+		port->bridge.subordinate_bus = PCI_SLOT(port->devfn);
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
+MODULE_LICENSE("GPL");
-- 
1.7.9.5

