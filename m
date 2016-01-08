Return-Path: <linux-kernel-owner@vger.kernel.org>
From: David Daney <ddaney.cavm@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH v3 2/2] pci, pci-thunder-pem: Add PCIe host driver for ThunderX processors.
Date: Fri,  8 Jan 2016 15:59:13 -0800
Message-Id: <1452297553-19911-3-git-send-email-ddaney.cavm@gmail.com>
In-Reply-To: <1452297553-19911-1-git-send-email-ddaney.cavm@gmail.com>
References: <1452297553-19911-1-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: David Daney <david.daney@cavium.com>

Some Cavium ThunderX processors require quirky access methods for the
config space of the PCIe bridge.  Add a driver to provide these config
space accessor functions.  The pci-host-common code is used to
configure the PCI machinery.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 .../devicetree/bindings/pci/pci-thunder-pem.txt    |  43 ++++
 MAINTAINERS                                        |   8 +
 drivers/pci/host/Kconfig                           |   7 +
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pci-thunder-pem.c                 | 283 +++++++++++++++++++++
 5 files changed, 342 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/pci-thunder-pem.txt
 create mode 100644 drivers/pci/host/pci-thunder-pem.c

diff --git a/Documentation/devicetree/bindings/pci/pci-thunder-pem.txt b/Documentation/devicetree/bindings/pci/pci-thunder-pem.txt
new file mode 100644
index 0000000..f131fae
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/pci-thunder-pem.txt
@@ -0,0 +1,43 @@
+* ThunderX PEM PCIe host controller
+
+Firmware-initialized PCI host controller found on some Cavium
+ThunderX processors.
+
+The properties and their meanings are identical to those described in
+host-generic-pci.txt except as listed below.
+
+Properties of the host controller node that differ from
+host-generic-pci.txt:
+
+- compatible     : Must be "cavium,pci-host-thunder-pem"
+
+- reg            : Two entries: First the configuration space for down
+                   stream devices base address and size, as accessed
+                   from the parent bus. Second, the register bank of
+                   the PEM device PCIe bridge.
+
+Example:
+
+    pci@87e0,c2000000 {
+	compatible = "cavium,pci-host-thunder-pem";
+	device_type = "pci";
+	msi-parent = <&its>;
+	msi-map = <0 &its 0x10000 0x10000>;
+	bus-range = <0x8f 0xc7>;
+	#size-cells = <2>;
+	#address-cells = <3>;
+
+	reg = <0x8880 0x8f000000 0x0 0x39000000>,  /* Configuration space */
+	      <0x87e0 0xc2000000 0x0 0x00010000>; /* PEM space */
+	ranges = <0x01000000 0x00 0x00020000 0x88b0 0x00020000 0x00 0x00010000>, /* I/O */
+		 <0x03000000 0x00 0x10000000 0x8890 0x10000000 0x0f 0xf0000000>, /* mem64 */
+		 <0x43000000 0x10 0x00000000 0x88a0 0x00000000 0x10 0x00000000>, /* mem64-pref */
+		 <0x03000000 0x87e0 0xc2f00000 0x87e0 0xc2000000 0x00 0x00100000>; /* mem64 PEM BAR4 */
+
+	#interrupt-cells = <1>;
+	interrupt-map-mask = <0 0 0 7>;
+	interrupt-map = <0 0 0 1 &gic0 0 0 0 24 4>, /* INTA */
+			<0 0 0 2 &gic0 0 0 0 25 4>, /* INTB */
+			<0 0 0 3 &gic0 0 0 0 26 4>, /* INTC */
+			<0 0 0 4 &gic0 0 0 0 27 4>; /* INTD */
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index a3fc8b4..24a04cc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8249,6 +8249,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
 F:	drivers/pci/host/pcie-hisi.c
 
+PCIE DRIVER FOR CAVIUM THUNDERX
+M:	David Daney <david.daney@cavium.com>
+L:	linux-pci@vger.kernel.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Supported
+F:	Documentation/devicetree/bindings/pci/pci-thunder-pem.txt
+F:	drivers/pci/host/pci-thunder-pem.c
+
 PCMCIA SUBSYSTEM
 P:	Linux PCMCIA Team
 L:	linux-pcmcia@lists.infradead.org
diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index f171459..ad32f251 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -176,4 +176,11 @@ config PCI_HISI
 	help
 	  Say Y here if you want PCIe controller support on HiSilicon HIP05 SoC
 
+config PCI_HOST_THUNDER_PEM
+	bool "Cavium Thunder PCIe controller to off-chip devices"
+	depends on OF && ARM64
+	select PCI_HOST_COMMON
+	help
+	  Say Y here if you want PCIe support for CN88XX Cavium Thunder SoCs.
+
 endmenu
diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
index ba2c51f..a068d10 100644
--- a/drivers/pci/host/Makefile
+++ b/drivers/pci/host/Makefile
@@ -21,3 +21,4 @@ obj-$(CONFIG_PCIE_IPROC_BCMA) += pcie-iproc-bcma.o
 obj-$(CONFIG_PCIE_ALTERA) += pcie-altera.o
 obj-$(CONFIG_PCIE_ALTERA_MSI) += pcie-altera-msi.o
 obj-$(CONFIG_PCI_HISI) += pcie-hisi.o
+obj-$(CONFIG_PCI_HOST_THUNDER_PEM) += pci-thunder-pem.o
diff --git a/drivers/pci/host/pci-thunder-pem.c b/drivers/pci/host/pci-thunder-pem.c
new file mode 100644
index 0000000..43fa6f5
--- /dev/null
+++ b/drivers/pci/host/pci-thunder-pem.c
@@ -0,0 +1,283 @@
+/*
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
+ * Copyright (C) 2015 Cavium, Inc.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_pci.h>
+#include <linux/platform_device.h>
+
+#include "pci-host-common.h"
+
+#define PEM_CFG_WR 0x28
+#define PEM_CFG_RD 0x30
+
+struct thunder_pem_pci {
+	struct gen_pci	gen_pci;
+	u32		ea_entry[3];
+	void __iomem	*pem_reg_base;
+};
+
+static int thunder_pem_config_read(struct pci_bus *bus, unsigned int devfn,
+				   int where, int size, u32 *val)
+{
+	int r;
+	struct thunder_pem_pci *pem_pci;
+	struct gen_pci *pci = bus->sysdata;
+
+	pem_pci = container_of(pci, struct thunder_pem_pci, gen_pci);
+
+	/*
+	 * The first device on the bus in the PEM PCIe bridge.
+	 * Special case its config access.
+	 */
+	if (bus->number == pci->cfg.bus_range->start) {
+		u64 read_val;
+
+		if (devfn != 0 || where >= 2048) {
+			*val = ~0;
+			return PCIBIOS_DEVICE_NOT_FOUND;
+		}
+
+		/*
+		 * 32-bit accesses only.  Write the address to the low
+		 * order bits of PEM_CFG_RD, then trigger the read by
+		 * reading back.  The config data lands in the upper
+		 * 32-bits of PEM_CFG_RD.
+		 */
+		read_val = where & ~3ull;
+		writeq(read_val, pem_pci->pem_reg_base + PEM_CFG_RD);
+		read_val = readq(pem_pci->pem_reg_base + PEM_CFG_RD);
+		read_val >>= 32;
+
+		/*
+		 * The config space contains some garbage, fix it up.
+		 * Also synthesize an EA capability for the BAR used
+		 * by MSI-X.
+		 */
+		switch (where & ~3u) {
+		case 0x40:
+			read_val &= 0xffff00ff;
+			read_val |= 0x00007000; /* Skip MSI CAP */
+			break;
+		case 0x70: /* Express Cap */
+			/* PME interrupt on vector 2*/
+			read_val |= (2u << 25);
+			break;
+		case 0xb0: /* MSI-X Cap */
+			/* TableSize=4, Next Cap is EA */
+			read_val &= 0xc00000ff;
+			read_val |= 0x0003bc00;
+			break;
+		case 0xb4:
+			/* Table offset=0, BIR=0 */
+			read_val = 0x00000000;
+			break;
+		case 0xb8:
+			/* BPA offset=0xf0000, BIR=0 */
+			read_val = 0x000f0000;
+			break;
+		case 0xbc:
+			/* EA, 1 entry, no next Cap */
+			read_val = 0x00010014;
+			break;
+		case 0xc0:
+			/* DW2 for type-1 */
+			read_val = 0x00000000;
+			break;
+		case 0xc4:
+			/* Entry BEI=0, PP=0x00, SP=0xff, ES=3 */
+			read_val = 0x80ff0003;
+			break;
+		case 0xc8:
+			read_val = pem_pci->ea_entry[0];
+			break;
+		case 0xcc:
+			read_val = pem_pci->ea_entry[1];
+			break;
+		case 0xd0:
+			read_val = pem_pci->ea_entry[2];
+			break;
+		default:
+			break;
+		}
+		read_val >>= (8 * (where & 3));
+		switch (size) {
+		case 1:
+			read_val &= 0xff;
+			break;
+		case 2:
+			read_val &= 0xffff;
+			break;
+		default:
+			break;
+		}
+		*val = read_val;
+		return PCIBIOS_SUCCESSFUL;
+	}
+	if (bus->number < pci->cfg.bus_range->start ||
+	    bus->number > pci->cfg.bus_range->end)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	r = pci_generic_config_read(bus, devfn, where, size, val);
+	return r;
+}
+
+static int thunder_pem_config_write(struct pci_bus *bus, unsigned int devfn,
+				    int where, int size, u32 val)
+{
+	struct gen_pci *pci = bus->sysdata;
+	struct thunder_pem_pci *pem_pci;
+
+	pem_pci = container_of(pci, struct thunder_pem_pci, gen_pci);
+
+	/*
+	 * The first device on the bus in the PEM PCIe bridge.
+	 * Special case its config access.
+	 */
+	if (bus->number == pci->cfg.bus_range->start) {
+		u64 write_val, read_val;
+
+		if (devfn != 0 || where >= 2048)
+			return PCIBIOS_DEVICE_NOT_FOUND;
+
+		/*
+		 * 32-bit accesses only.  If the write is for a size
+		 * smaller than 32-bits, we must first read the 32-bit
+		 * value and merge in the desired bits and then write
+		 * the whole 32-bits back out.
+		 */
+		switch (size) {
+		case 1:
+			read_val = where & ~3ull;
+			writeq(read_val, pem_pci->pem_reg_base + PEM_CFG_RD);
+			read_val = readq(pem_pci->pem_reg_base + PEM_CFG_RD);
+			read_val >>= 32;
+			read_val &= ~(0xff << (8 * (where & 3)));
+			val = (val & 0xff) << (8 * (where & 3));
+			val |= (u32)read_val;
+			break;
+		case 2:
+			read_val = where & ~3ull;
+			writeq(read_val, pem_pci->pem_reg_base + PEM_CFG_RD);
+			read_val = readq(pem_pci->pem_reg_base + PEM_CFG_RD);
+			read_val >>= 32;
+			read_val &= ~(0xffff << (8 * (where & 3)));
+			val = (val & 0xffff) << (8 * (where & 3));
+			val |= (u32)read_val;
+			break;
+		default:
+			break;
+
+		}
+		/*
+		 * Low order bits are the config address, the high
+		 * order 32 bits are the data to be written.
+		 */
+		write_val = where & ~3ull;
+		write_val |= (((u64)val) << 32);
+		writeq(write_val, pem_pci->pem_reg_base + PEM_CFG_WR);
+		return PCIBIOS_SUCCESSFUL;
+	}
+	if (bus->number < pci->cfg.bus_range->start ||
+	    bus->number > pci->cfg.bus_range->end)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	return pci_generic_config_write(bus, devfn, where, size, val);
+}
+
+static void __iomem *map_cfg_bus_thunder_pem(struct pci_bus *bus,
+					     unsigned int devfn,
+					     int where)
+{
+	struct gen_pci *pci = bus->sysdata;
+	resource_size_t idx = bus->number - pci->cfg.bus_range->start;
+
+	return pci->cfg.win[idx] + ((devfn << 16) | where);
+}
+
+static struct gen_pci_cfg_bus_ops thunder_pem_bus_ops = {
+	.bus_shift	= 24,
+	.ops		= {
+		.map_bus	= map_cfg_bus_thunder_pem,
+		.read		= thunder_pem_config_read,
+		.write		= thunder_pem_config_write,
+	}
+};
+
+static const struct of_device_id thunder_pem_of_match[] = {
+	{ .compatible = "cavium,pci-host-thunder-pem",
+	  .data = &thunder_pem_bus_ops },
+
+	{ },
+};
+MODULE_DEVICE_TABLE(of, thunder_pem_of_match);
+
+static int thunder_pem_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	const struct of_device_id *of_id;
+	resource_size_t bar4_start;
+	struct resource *res_pem;
+	struct thunder_pem_pci *pem_pci;
+
+	pem_pci = devm_kzalloc(dev, sizeof(*pem_pci), GFP_KERNEL);
+	if (!pem_pci)
+		return -ENOMEM;
+
+	of_id = of_match_node(thunder_pem_of_match, dev->of_node);
+	pem_pci->gen_pci.cfg.ops = (struct gen_pci_cfg_bus_ops *)of_id->data;
+
+	/*
+	 * The second register range is the PEM bridge to the PCIe
+	 * bus.  It has a different config access method than those
+	 * devices behind the bridge.
+	 */
+	res_pem = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (!res_pem) {
+		dev_err(dev, "missing \"reg[1]\"property\n");
+		return -EINVAL;
+	}
+
+	pem_pci->pem_reg_base = devm_ioremap(dev, res_pem->start, 0x10000);
+	if (!pem_pci->pem_reg_base)
+		return -ENOMEM;
+
+	/*
+	 * The MSI-X BAR for the PEM and AER interrupts is located at
+	 * a fixed offset from the PEM register base.  Generate a
+	 * fragment of the synthesized Enhanced Allocation capability
+	 * structure here for the BAR.
+	 */
+	bar4_start = res_pem->start + 0xf00000;
+	pem_pci->ea_entry[0] = (u32)bar4_start | 2;
+	pem_pci->ea_entry[1] = (u32)(res_pem->end - bar4_start) & ~3u;
+	pem_pci->ea_entry[2] = (u32)(bar4_start >> 32);
+
+	return pci_host_common_probe(pdev, &pem_pci->gen_pci);
+}
+
+static struct platform_driver thunder_pem_driver = {
+	.driver = {
+		.name = KBUILD_MODNAME,
+		.of_match_table = thunder_pem_of_match,
+	},
+	.probe = thunder_pem_probe,
+};
+module_platform_driver(thunder_pem_driver);
+
+MODULE_DESCRIPTION("Thunder PEM PCIe host driver");
+MODULE_LICENSE("GPL v2");
-- 
1.8.3.1
