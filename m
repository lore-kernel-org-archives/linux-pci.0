Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:40352 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756326AbbLGQ7s (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 7 Dec 2015 11:59:48 -0500
From: Jayachandran C <jchandra@broadcom.com>
To: <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-acpi@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	<linux-arm-kernel@lists.infradead.org>
CC: Jayachandran C <jchandra@broadcom.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Tomasz Nowicki <tn@semihalf.com>
Subject: [RFC PATCH v2 3/4] PCI: ACPI: Add a generic ACPI based host controller
Date: Mon, 7 Dec 2015 22:50:28 +0530
Message-ID: <1449508829-10797-4-git-send-email-jchandra@broadcom.com>
In-Reply-To: <1449508829-10797-1-git-send-email-jchandra@broadcom.com>
References: <1449508829-10797-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add a simple ACPI based PCI host controller. This is done by
providing a simple implementation for pci_acpi_scan_root().
The MCFG table is parsed early and saved so that it can be
mapped when ACPI calls pci_acpi_scan_root.

This is enabled only for ARM64 now.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 drivers/pci/host/Kconfig         |   7 ++
 drivers/pci/host/Makefile        |   1 +
 drivers/pci/host/pci-host-acpi.c | 209 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 217 insertions(+)
 create mode 100644 drivers/pci/host/pci-host-acpi.c

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index f131ba9..8321efc 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -53,6 +53,13 @@ config PCI_RCAR_GEN2_PCIE
 	help
 	  Say Y here if you want PCIe controller support on R-Car Gen2 SoCs.
 
+config PCI_HOST_GENERIC_ACPI
+	bool "Generic ACPI PCI host controller"
+	depends on ARM64 && ACPI
+	help
+	  Say Y here if you want to support a simple generic ACPI PCI host
+	  controller.
+
 config PCI_HOST_GENERIC
 	bool "Generic PCI host controller"
 	depends on (ARM || ARM64) && OF
diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
index 9d4d3c6..bc31852 100644
--- a/drivers/pci/host/Makefile
+++ b/drivers/pci/host/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_PCI_MVEBU) += pci-mvebu.o
 obj-$(CONFIG_PCI_TEGRA) += pci-tegra.o
 obj-$(CONFIG_PCI_RCAR_GEN2) += pci-rcar-gen2.o
 obj-$(CONFIG_PCI_RCAR_GEN2_PCIE) += pcie-rcar.o
+obj-$(CONFIG_PCI_HOST_GENERIC_ACPI) += pci-host-acpi.o
 obj-$(CONFIG_PCI_HOST_GENERIC) += pci-host-generic.o
 obj-$(CONFIG_PCIE_SPEAR13XX) += pcie-spear13xx.o
 obj-$(CONFIG_PCI_KEYSTONE) += pci-keystone-dw.o pci-keystone.o
diff --git a/drivers/pci/host/pci-host-acpi.c b/drivers/pci/host/pci-host-acpi.c
new file mode 100644
index 0000000..38fb589
--- /dev/null
+++ b/drivers/pci/host/pci-host-acpi.c
@@ -0,0 +1,209 @@
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
+#define MCFG_NAMELEN		32
+#define MCFG_SHIFT		20
+
+/* ECFG window for this root bus */
+struct gen_mcfg_window {
+	struct resource		res;
+	unsigned int		domain_nr;
+	unsigned int		bus_start;
+	unsigned int		bus_end;
+	char			name[MCFG_NAMELEN];
+	void __iomem		*win;
+};
+
+/* sysdata pointer is ->root_info */
+struct gen_acpi_pci {
+	struct acpi_pci_root_info	root_info;
+	struct gen_mcfg_window		cfg;
+};
+
+/* MCFG entries  */
+struct mcfg_entry {
+	int			segment;
+	int			bus_start;
+	int			bus_end;
+	u64			addr;
+};
+
+/* Globals */
+static struct mcfg_entries {
+	int			size;
+	struct mcfg_entry	*entries;
+} mcfg_sav;
+
+/* find mapping of a MCFG area */
+static void __iomem *gen_acpi_map_cfg_bus(struct pci_bus *bus,
+			unsigned int devfn, int where)
+{
+	struct gen_acpi_pci *pci = bus->sysdata;
+	struct gen_mcfg_window *cfg = &pci->cfg;
+
+	if (bus->number < cfg->bus_start || bus->number > cfg->bus_end)
+		return NULL;
+
+	return cfg->win + ((bus->number - cfg->bus_start) << MCFG_SHIFT) +
+			((devfn << 12) | where);
+}
+
+/* Map the ECFG area for a root bus */
+static int gen_acpi_pci_map_mcfg(struct acpi_pci_root *root,
+				struct gen_acpi_pci *pci)
+{
+	struct gen_mcfg_window *cfg = &pci->cfg;
+	struct acpi_device *device = root->device;
+	void __iomem  *vaddr;
+
+	/* if there is info from _CBA, use that, otherwise use MCFG table */
+	if (root->mcfg_addr) {
+		cfg->bus_start = root->secondary.start;
+		cfg->bus_end = root->secondary.end;
+		cfg->res.start = root->mcfg_addr;
+	} else {
+		struct mcfg_entry *e = mcfg_sav.entries;
+		int i, n = mcfg_sav.size;
+
+		for (i = 0; i < n; i++, e++)
+			if (e->segment == root->segment)
+				break;
+		if (i >= n)
+			return -ENODEV;
+		cfg->bus_start = e->bus_start;
+		cfg->bus_end = e->bus_end;
+		cfg->res.start = e->addr;
+	}
+
+	cfg->res.flags = IORESOURCE_MEM;
+	cfg->res.name = cfg->name;
+	cfg->res.end = cfg->res.start +
+			((cfg->bus_end - cfg->bus_start + 1) << MCFG_SHIFT) - 1;
+	snprintf(cfg->name, MCFG_NAMELEN, "PCI MMCONFIG %04x [bus %02x-%02x]",
+		 root->segment, cfg->bus_start, cfg->bus_end);
+
+	/* map ECFG space for the bus range */
+	vaddr = devm_ioremap_resource(&device->dev, &cfg->res);
+	if (IS_ERR(vaddr))
+		return PTR_ERR(vaddr);
+
+	cfg->win = vaddr;
+	return 0;
+}
+
+static struct pci_ops gen_acpi_pci_ops = {
+	.map_bus	= gen_acpi_map_cfg_bus,
+	.read		= pci_generic_config_read,
+	.write		= pci_generic_config_write,
+};
+
+static struct acpi_pci_root_ops pci_acpi_root_ops = {
+	.pci_ops = &gen_acpi_pci_ops,
+};
+
+struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
+{
+	struct acpi_device *device = root->device;
+	struct gen_acpi_pci *pci;
+	struct pci_bus *bus, *child;
+	int err;
+
+	/* allocate acpi_info/sysdata */
+	pci = devm_kzalloc(&device->dev, sizeof(*pci), GFP_KERNEL);
+	if (!pci) {
+		dev_err(&device->dev,
+			"pci_bus %04x:%02x: ignored (out of memory)\n",
+			root->segment, (int)root->secondary.start);
+		return NULL;
+	}
+
+	err = gen_acpi_pci_map_mcfg(root, pci);
+	if (err) {
+		dev_err(&device->dev, "MCFG lookup for domain %d failed",
+			root->segment);
+		return NULL;
+	}
+	bus =  acpi_pci_root_create(root, &pci_acpi_root_ops,
+					&pci->root_info, pci);
+	if (!bus) {
+		dev_err(&device->dev, "Scanning rootbus failed");
+		return NULL;
+	}
+
+	list_for_each_entry(child, &bus->children, node)
+		pcie_bus_configure_settings(child);
+
+	return bus;
+}
+
+/* save MCFG entries */
+static __init int handle_mcfg(struct acpi_table_header *header)
+{
+	struct acpi_table_mcfg *mcfg;
+	struct acpi_mcfg_allocation *mptr;
+	struct mcfg_entry *e;
+	int i, n;
+
+	if (!header)
+		return -EINVAL;
+
+	mcfg = (struct acpi_table_mcfg *)header;
+	mptr = (struct acpi_mcfg_allocation *) &mcfg[1];
+	n = (header->length - sizeof(*mcfg)) / sizeof(*mptr);
+	if (n <= 0 || n > 255) {
+		pr_err(PREFIX " MCFG has incorrect entries (%d).\n", n);
+		return -EINVAL;
+	}
+	mcfg_sav.entries = e = kcalloc(n, sizeof(*e), GFP_KERNEL);
+	if (e == NULL)
+		return -ENOMEM;
+	mcfg_sav.size = n;
+	for (i = 0; i < n; i++, e++, mptr++) {
+		e->segment = mptr->pci_segment;
+		e->bus_start = mptr->start_bus_number;
+		e->bus_end = mptr->end_bus_number;
+		e->addr = mptr->address;
+	}
+	return 0;
+}
+
+void __init pci_mmcfg_late_init(void)
+{
+	int err;
+
+	err = acpi_sfi_table_parse(ACPI_SIG_MCFG, handle_mcfg);
+	if (err) {
+		pr_err(PREFIX " Failed to parse MCFG (%d)\n", err);
+		mcfg_sav.size = -1;
+	} else {
+		pr_info(PREFIX " MCFG table at %p, %d entries.\n",
+			mcfg_sav.entries, mcfg_sav.size);
+	}
+}
-- 
1.9.1

