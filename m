Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:24367 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159AbcANHIm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jan 2016 02:08:42 -0500
From: Jayachandran C <jchandra@broadcom.com>
To: <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-acpi@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	<linux-arm-kernel@lists.infradead.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: Jayachandran C <jchandra@broadcom.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Tomasz Nowicki <tn@semihalf.com>,
	<xen-devel@lists.xenproject.org>
Subject: [PATCH v6 5/5] PCI: ACPI: Add a generic ACPI based host controller
Date: Thu, 14 Jan 2016 13:02:41 +0530
Message-ID: <1452756761-29584-6-git-send-email-jchandra@broadcom.com>
In-Reply-To: <1452756761-29584-1-git-send-email-jchandra@broadcom.com>
References: <1452756761-29584-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add a simple ACPI based PCI host controller. This is done by
providing a simple implementation for pci_acpi_scan_root().

The pci_mmcfg_list handling is done by the ACPI code, we
keep a reference to the pci_mmcfg_region which is already
mapped.

Provide implementations of raw_pci_read and raw_pci_write based
on the pci_mmcfg_list

This is enabled only for ARM64 now.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 drivers/acpi/Kconfig         |   8 ++
 drivers/acpi/Makefile        |   1 +
 drivers/acpi/pci_host_acpi.c | 186 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 195 insertions(+)
 create mode 100644 drivers/acpi/pci_host_acpi.c

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 5eef4cb..c5738be 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -283,6 +283,14 @@ config ACPI_NUMA
 	depends on (X86 || IA64)
 	default y if IA64_GENERIC || IA64_SGI_SN2
 
+config ACPI_PCI_HOST_GENERIC
+	bool "Generic ACPI PCI host controller"
+	depends on ARM64 && ACPI
+	help
+	  Say Y here if you want to support a simple generic ACPI PCI host
+	  controller.
+
+
 config ACPI_CUSTOM_DSDT_FILE
 	string "Custom DSDT Table file to include"
 	default ""
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 3f65311..9fffdf2 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -41,6 +41,7 @@ acpi-y				+= ec.o
 acpi-$(CONFIG_ACPI_DOCK)	+= dock.o
 acpi-y				+= pci_root.o pci_link.o pci_irq.o
 acpi-$(CONFIG_PCI_MMCONFIG)	+= pci_mcfg.o
+acpi-$(CONFIG_ACPI_PCI_HOST_GENERIC) += pci_host_acpi.o
 acpi-y				+= acpi_lpss.o acpi_apd.o
 acpi-y				+= acpi_platform.o
 acpi-y				+= acpi_pnp.o
diff --git a/drivers/acpi/pci_host_acpi.c b/drivers/acpi/pci_host_acpi.c
new file mode 100644
index 0000000..9dbdd81
--- /dev/null
+++ b/drivers/acpi/pci_host_acpi.c
@@ -0,0 +1,186 @@
+/*
+ * Generic PCI host controller driver for ACPI based systems
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
+ * Copyright (c) 2015 Broadcom Corporation
+ *
+ * Based on drivers/pci/host/pci-host-generic.c
+ * Copyright (C) 2014 ARM Limited
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/acpi.h>
+#include <linux/pci-acpi.h>
+#include <linux/sfi_acpi.h>
+#include <linux/slab.h>
+
+#define PREFIX			"pci-host-acpi:"
+
+/* sysdata pointer is ->root_info */
+struct gen_acpi_root_info {
+	struct acpi_pci_root_info	common;
+	struct pci_mmcfg_region		*mcfg;
+	bool				mcfg_added;
+};
+
+/* find mapping of a MCFG area */
+static void __iomem *gen_acpi_map_cfg_bus(struct pci_bus *bus,
+			unsigned int devfn, int where)
+{
+	struct gen_acpi_root_info *pci = bus->sysdata;
+	struct pci_mmcfg_region *mcfg = pci->mcfg;
+
+	if (bus->number < mcfg->start_bus || bus->number > mcfg->end_bus)
+		return NULL;
+
+	return mcfg->virt +
+		PCI_MMCFG_OFFSET(bus->number - mcfg->start_bus, devfn) +
+		where;
+}
+
+static struct pci_ops gen_acpi_pci_ops = {
+	.map_bus	= gen_acpi_map_cfg_bus,
+	.read		= pci_generic_config_read,
+	.write		= pci_generic_config_write,
+};
+
+/* Insert the ECFG area for a root bus */
+static int pci_acpi_root_init_info(struct acpi_pci_root_info *ci)
+{
+	struct gen_acpi_root_info *info;
+	struct acpi_pci_root *root = ci->root;
+	struct device *dev = &ci->bridge->dev;
+	int err;
+
+	info = container_of(ci, struct gen_acpi_root_info, common);
+	err = pci_mmconfig_insert(dev, root->segment, root->secondary.start,
+			root->secondary.end, root->mcfg_addr);
+	if (err && err != -EEXIST)
+		return err;
+
+	info->mcfg = pci_mmconfig_lookup(root->segment, root->secondary.start);
+	WARN_ON(info->mcfg == NULL);
+	info->mcfg_added = (err == -EEXIST);
+	return 0;
+}
+
+static void pci_acpi_root_release_info(struct acpi_pci_root_info *ci)
+{
+	struct gen_acpi_root_info *info;
+	struct acpi_pci_root *root = ci->root;
+
+	info = container_of(ci, struct gen_acpi_root_info, common);
+	if (info->mcfg_added)
+		pci_mmconfig_delete(root->segment, root->secondary.start,
+					root->secondary.end);
+	info->mcfg = NULL;
+}
+
+static struct acpi_pci_root_ops pci_acpi_root_ops = {
+	.pci_ops = &gen_acpi_pci_ops,
+	.init_info = pci_acpi_root_init_info,
+	.release_info = pci_acpi_root_release_info,
+};
+
+struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
+{
+	struct acpi_device *device = root->device;
+	struct gen_acpi_root_info *ri;
+	struct pci_bus *bus, *child;
+
+	/* allocate acpi_info/sysdata */
+	ri = devm_kzalloc(&device->dev, sizeof(*ri), GFP_KERNEL);
+	if (!ri) {
+		dev_err(&device->dev,
+			"pci_bus %04x:%02x: ignored (out of memory)\n",
+			root->segment, (int)root->secondary.start);
+		return NULL;
+	}
+
+	bus =  acpi_pci_root_create(root, &pci_acpi_root_ops,
+					&ri->common, ri);
+	if (!bus) {
+		dev_err(&device->dev, "Scanning rootbus failed");
+		return NULL;
+	}
+
+	pci_bus_size_bridges(bus);
+	pci_bus_assign_resources(bus);
+	list_for_each_entry(child, &bus->children, node)
+		pcie_bus_configure_settings(child);
+
+	return bus;
+}
+
+int raw_pci_read(unsigned int seg, unsigned int bus,
+		  unsigned int devfn, int reg, int len, u32 *val)
+{
+	struct pci_mmcfg_region *mcfg;
+	void __iomem *addr;
+	int err = -EINVAL;
+
+	rcu_read_lock();
+	mcfg = pci_mmconfig_lookup(seg, bus);
+	if (!mcfg || !mcfg->virt)
+		goto err;
+
+	addr = mcfg->virt + PCI_MMCFG_OFFSET(bus, devfn);
+	switch (len) {
+	case 1:
+		*val = readb(addr + reg);
+		break;
+	case 2:
+		*val = readw(addr + reg);
+		break;
+	case 4:
+		*val = readl(addr + reg);
+		break;
+	}
+	err = 0;
+err:
+	rcu_read_unlock();
+	return err;
+}
+
+int raw_pci_write(unsigned int seg, unsigned int bus,
+		unsigned int devfn, int reg, int len, u32 val)
+{
+	struct pci_mmcfg_region *mcfg;
+	void __iomem *addr;
+	int err = -EINVAL;
+
+	rcu_read_lock();
+	mcfg = pci_mmconfig_lookup(seg, bus);
+	if (!mcfg || !mcfg->virt)
+		goto err;
+
+	addr = mcfg->virt + PCI_MMCFG_OFFSET(bus, devfn);
+	switch (len) {
+	case 1:
+		writeb(val, addr + reg);
+		break;
+	case 2:
+		writew(val, addr + reg);
+		break;
+	case 4:
+		writel(val, addr + reg);
+		break;
+	}
+	err = 0;
+err:
+	rcu_read_unlock();
+	return err;
+}
-- 
1.9.1

