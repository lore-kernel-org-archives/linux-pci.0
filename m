Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Tomasz Nowicki <tn@semihalf.com>
To: bhelgaas@google.com, arnd@arndb.de, will.deacon@arm.com,
	catalin.marinas@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org,
	Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org,
	jiang.liu@linux.intel.com, Stefano.Stabellini@eu.citrix.com
Cc: robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com, tglx@linutronix.de,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jchandra@broadcom.com, jcm@redhat.com,
	Tomasz Nowicki <tn@semihalf.com>
Subject: [PATCH V2 21/23] pci, acpi: Support for ACPI based PCI hostbridge init
Date: Wed, 16 Dec 2015 16:16:31 +0100
Message-Id: <1450278993-12664-22-git-send-email-tn@semihalf.com>
In-Reply-To: <1450278993-12664-1-git-send-email-tn@semihalf.com>
References: <1450278993-12664-1-git-send-email-tn@semihalf.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Because of two patch series:
1. Jiang Liu's common interface to support PCI host bridge init
2. MMCONFIG refactoring (part of this patch set)
now we can think about generic ACPI based PCI host bridge driver
out of arch/ directory.

This driver use information from MCFG table (PCI config space regions)
and _CRS method (IO/irq resources) to initialize PCI hostbridge.

TBD: We are still not sure whether we should reassign resources
after PCI bus enumeration or trust firmware to do all that work for
us properly.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
CC: Arnd Bergmann <arnd@arndb.de>
CC: Catalin Marinas <catalin.marinas@arm.com>
CC: Liviu Dudau <Liviu.Dudau@arm.com>
CC: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
CC: Will Deacon <will.deacon@arm.com>
Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
---
 drivers/pci/host/Kconfig         |   6 ++
 drivers/pci/host/Makefile        |   1 +
 drivers/pci/host/pci-host-acpi.c | 138 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 145 insertions(+)
 create mode 100644 drivers/pci/host/pci-host-acpi.c

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index f131ba9..0e5e339 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -60,6 +60,12 @@ config PCI_HOST_GENERIC
 	  Say Y here if you want to support a simple generic PCI host
 	  controller, such as the one emulated by kvmtool.
 
+config PCI_HOST_GENERIC_ACPI
+	bool "Generic ACPI PCI host controller"
+	depends on ACPI && ARCH_PCI_HOST_GENERIC_ACPI
+	help
+	  Say Y here if you want to support generic ACPI PCI host controller.
+
 config PCIE_SPEAR13XX
 	bool "STMicroelectronics SPEAr PCIe controller"
 	depends on ARCH_SPEAR13XX
diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
index 9d4d3c6..9117894 100644
--- a/drivers/pci/host/Makefile
+++ b/drivers/pci/host/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_PCI_TEGRA) += pci-tegra.o
 obj-$(CONFIG_PCI_RCAR_GEN2) += pci-rcar-gen2.o
 obj-$(CONFIG_PCI_RCAR_GEN2_PCIE) += pcie-rcar.o
 obj-$(CONFIG_PCI_HOST_GENERIC) += pci-host-generic.o
+obj-$(CONFIG_PCI_HOST_GENERIC_ACPI) += pci-host-acpi.o
 obj-$(CONFIG_PCIE_SPEAR13XX) += pcie-spear13xx.o
 obj-$(CONFIG_PCI_KEYSTONE) += pci-keystone-dw.o pci-keystone.o
 obj-$(CONFIG_PCIE_XILINX) += pcie-xilinx.o
diff --git a/drivers/pci/host/pci-host-acpi.c b/drivers/pci/host/pci-host-acpi.c
new file mode 100644
index 0000000..29175f5
--- /dev/null
+++ b/drivers/pci/host/pci-host-acpi.c
@@ -0,0 +1,138 @@
+/*
+ * ACPI based generic PCI host controller driver
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
+ * Copyright (C) 2015 Semihalf
+ * Author: Tomasz Nowicki <tn@semihalf.com>
+ */
+
+#include <linux/acpi.h>
+#include <linux/ecam.h>
+#include <linux/of_address.h>
+#include <linux/pci.h>
+#include <linux/pci-acpi.h>
+
+static int pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
+{
+	if (pci_dev_msi_enabled(dev))
+		return 0;
+
+	return acpi_pci_irq_enable(dev);
+}
+
+int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
+{
+	bridge->map_irq = pcibios_map_irq;
+	return 0;
+}
+
+static void pci_mcfg_release_info(struct acpi_pci_root_info *ci)
+{
+	pci_mmcfg_teardown_map(ci);
+	kfree(ci);
+}
+
+static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
+{
+	struct resource_entry *entry, *tmp;
+	int ret;
+
+	ret = acpi_pci_probe_root_resources(ci);
+	if (ret <= 0)
+		return ret;
+
+	resource_list_for_each_entry_safe(entry, tmp, &ci->resources) {
+		struct resource *res = entry->res;
+
+		/*
+		 * TODO: need to move pci_register_io_range() function out
+		 * of drivers/of/address.c for both used by DT and ACPI
+		 */
+		if (res->flags & IORESOURCE_IO) {
+			resource_size_t cpu_addr = res->start + entry->offset;
+			resource_size_t pci_addr = res->start;
+			resource_size_t length = res->end - res->start;
+			unsigned long port;
+			int err;
+
+			err = pci_register_io_range(cpu_addr, length);
+			if (err) {
+				resource_list_destroy_entry(entry);
+				continue;
+			}
+
+			port = pci_address_to_pio(cpu_addr);
+			if (port == (unsigned long)-1) {
+				resource_list_destroy_entry(entry);
+				continue;
+			}
+
+			res->start = port;
+			res->end = port + length;
+			entry->offset = port - pci_addr;
+
+			if (pci_remap_iospace(res, cpu_addr) < 0)
+				resource_list_destroy_entry(entry);
+		}
+	}
+
+	return ret;
+}
+
+static struct acpi_pci_root_ops acpi_pci_root_ops = {
+	.init_info = pci_mmcfg_setup_map,
+	.release_info = pci_mcfg_release_info,
+	.prepare_resources = pci_acpi_root_prepare_resources,
+};
+
+/* Root bridge scanning */
+struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
+{
+	int node = acpi_get_node(root->device->handle);
+	int domain = root->segment;
+	int busnum = root->secondary.start;
+	struct acpi_pci_root_info *info;
+	struct pci_bus *bus;
+
+	if (domain && !pci_domains_supported) {
+		pr_warn("PCI %04x:%02x: multiple domains not supported.\n",
+			domain, busnum);
+		return NULL;
+	}
+
+	info = kzalloc_node(sizeof(*info), GFP_KERNEL, node);
+	if (!info) {
+		dev_err(&root->device->dev,
+			"pci_bus %04x:%02x: ignored (out of memory)\n",
+			domain, busnum);
+		return NULL;
+	}
+
+	acpi_pci_root_ops.pci_ops = pci_mcfg_get_ops(domain, busnum);
+	bus = acpi_pci_root_create(root, &acpi_pci_root_ops, info, root);
+
+	/* After the PCI-E bus has been walked and all devices discovered,
+	 * configure any settings of the fabric that might be necessary.
+	 */
+	if (bus) {
+		struct pci_bus *child;
+		pci_bus_size_bridges(bus);
+		pci_bus_assign_resources(bus);
+
+		list_for_each_entry(child, &bus->children, node)
+			pcie_bus_configure_settings(child);
+	}
+
+	return bus;
+}
-- 
1.9.1

