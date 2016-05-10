Return-Path: <tn@semihalf.com>
Return-Path: <tn@semihalf.com>
From: Tomasz Nowicki <tn@semihalf.com>
To: helgaas@kernel.org,
	arnd@arndb.de,
	will.deacon@arm.com,
	catalin.marinas@arm.com,
	rafael@kernel.org,
	hanjun.guo@linaro.org,
	Lorenzo.Pieralisi@arm.com,
	okaya@codeaurora.org,
	jchandra@broadcom.com
Cc: robert.richter@caviumnetworks.com,
	mw@semihalf.com,
	Liviu.Dudau@arm.com,
	ddaney@caviumnetworks.com,
	wangyijing@huawei.com,
	Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linaro-acpi@lists.linaro.org,
	jcm@redhat.com,
	andrea.gallo@linaro.org,
	dhdang@apm.com,
	jeremy.linton@arm.com,
	liudongdong3@huawei.com,
	cov@codeaurora.org,
	Tomasz Nowicki <tn@semihalf.com>
Subject: [PATCH V7 08/11] pci, acpi: Support for ACPI based generic PCI host controller
Date: Tue, 10 May 2016 17:19:58 +0200
Message-Id: <1462893601-8937-9-git-send-email-tn@semihalf.com>
In-Reply-To: <1462893601-8937-1-git-send-email-tn@semihalf.com>
References: <1462893601-8937-1-git-send-email-tn@semihalf.com>
List-ID: <linux-pci.vger.kernel.org>

This patch is going to implement generic PCI host controller for
ACPI world, similar to what pci-host-generic.c driver does for DT world.

All such drivers, which we have seen so far, were implemented within
arch/ directory since they had some arch assumptions (x86 and ia64).
However, they all are doing similar thing, so it makes sense to find
some common code and abstract it into the generic driver.

In order to handle PCI config space regions properly, we define new
MCFG interface which does sanity checks on MCFG table and keeps its
root pointer. User is able to lookup MCFG regions based on that root
pointer and specified domain:bus_start:bus_end touple. We are using
pci_mmcfg_late_init old prototype to avoid another function name.

The implementation of pci_acpi_scan_root() looks up the MCFG entries
and sets up a new mapping (regions are not mapped until host controller ask
for it). Generic PCI functions are used for accessing config space.
Driver selects PCI_ECAM and uses functions from drivers/pci/ecam.h
to create and access ECAM mappings.

As mentioned in Kconfig help section, ACPI_PCI_HOST_GENERIC choice
should be made on a per-architecture basis.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 drivers/acpi/Kconfig            |   8 +++
 drivers/acpi/Makefile           |   1 +
 drivers/acpi/pci_mcfg.c         |  97 ++++++++++++++++++++++++++
 drivers/acpi/pci_root_generic.c | 149 ++++++++++++++++++++++++++++++++++++++++
 drivers/pci/ecam.h              |   5 ++
 include/linux/pci-acpi.h        |   5 ++
 include/linux/pci.h             |   5 +-
 7 files changed, 269 insertions(+), 1 deletion(-)
 create mode 100644 drivers/acpi/pci_mcfg.c
 create mode 100644 drivers/acpi/pci_root_generic.c

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 183ffa3..44afc76 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -346,6 +346,14 @@ config ACPI_PCI_SLOT
 	  i.e., segment/bus/device/function tuples, with physical slots in
 	  the system.  If you are unsure, say N.
 
+config ACPI_PCI_HOST_GENERIC
+	bool
+	select PCI_ECAM
+	help
+	  Select this config option from the architecture Kconfig,
+	  if it is preferred to enable ACPI PCI host controller driver which
+	  has no arch-specific assumptions.
+
 config X86_PM_TIMER
 	bool "Power Management Timer Support" if EXPERT
 	depends on X86
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 81e5cbc..627a2b7 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -40,6 +40,7 @@ acpi-$(CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC) += processor_pdc.o
 acpi-y				+= ec.o
 acpi-$(CONFIG_ACPI_DOCK)	+= dock.o
 acpi-y				+= pci_root.o pci_link.o pci_irq.o
+obj-$(CONFIG_ACPI_PCI_HOST_GENERIC)	+= pci_root_generic.o pci_mcfg.o
 acpi-y				+= acpi_lpss.o acpi_apd.o
 acpi-y				+= acpi_platform.o
 acpi-y				+= acpi_pnp.o
diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
new file mode 100644
index 0000000..373d079
--- /dev/null
+++ b/drivers/acpi/pci_mcfg.c
@@ -0,0 +1,97 @@
+/*
+ * Copyright (C) 2016 Broadcom
+ *	Author: Jayachandran C <jchandra@broadcom.com>
+ * Copyright (C) 2016 Semihalf
+ * 	Author: Tomasz Nowicki <tn@semihalf.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation (the "GPL").
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License version 2 (GPLv2) for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * version 2 (GPLv2) along with this source code.
+ */
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/pci-acpi.h>
+
+#define PREFIX	"ACPI: "
+
+/* Root pointer to the mapped MCFG table */
+static struct acpi_table_mcfg *mcfg_table;
+
+#define MCFG_ENTRIES(mcfg_ptr)	(((mcfg_ptr)->header.length -		\
+				sizeof(struct acpi_table_mcfg)) /	\
+				sizeof(struct acpi_mcfg_allocation))
+
+static phys_addr_t pci_mcfg_lookup_static(u16 seg, u8 bus_start, u8 bus_end)
+{
+	struct acpi_mcfg_allocation *mptr;
+	int i;
+
+	if (!mcfg_table) {
+		pr_err(PREFIX "MCFG table not available, lookup failed\n");
+		return -ENXIO;
+	}
+
+	mptr = (struct acpi_mcfg_allocation *) &mcfg_table[1];
+
+	/*
+	 * We expect exact match, unless MCFG entry end bus covers more than
+	 * specified by caller.
+	 */
+	for (i = 0; i < MCFG_ENTRIES(mcfg_table); i++, mptr++) {
+		if (mptr->pci_segment == seg &&
+		    mptr->start_bus_number == bus_start &&
+		    mptr->end_bus_number >= bus_end) {
+			return mptr->address;
+		}
+	}
+
+	return -ENXIO;
+}
+
+phys_addr_t pci_mcfg_lookup(struct acpi_device *device, u16 seg,
+			    struct resource *bus_res)
+{
+	phys_addr_t addr;
+
+	addr = acpi_pci_root_get_mcfg_addr(device->handle);
+	if (addr)
+		return addr;
+
+	return pci_mcfg_lookup_static(seg, bus_res->start, bus_res->end);
+}
+
+static __init int pci_mcfg_parse(struct acpi_table_header *header)
+{
+	struct acpi_table_mcfg *mcfg;
+	int n;
+
+	if (!header)
+		return -EINVAL;
+
+	mcfg = (struct acpi_table_mcfg *)header;
+	n = MCFG_ENTRIES(mcfg);
+	if (n <= 0 || n > 255) {
+		pr_err(PREFIX "MCFG has incorrect entries (%d).\n", n);
+		return -EINVAL;
+	}
+
+	mcfg_table = mcfg;
+	pr_info(PREFIX "MCFG table loaded, %d entries detected\n", n);
+	return 0;
+}
+
+/* Interface called by ACPI - parse and save MCFG table */
+void __init pci_mmcfg_late_init(void)
+{
+	int err = acpi_table_parse(ACPI_SIG_MCFG, pci_mcfg_parse);
+	if (err)
+		pr_err(PREFIX "Failed to parse MCFG (%d)\n", err);
+}
diff --git a/drivers/acpi/pci_root_generic.c b/drivers/acpi/pci_root_generic.c
new file mode 100644
index 0000000..6f4940a
--- /dev/null
+++ b/drivers/acpi/pci_root_generic.c
@@ -0,0 +1,149 @@
+/*
+ * Copyright (C) 2016 Broadcom
+ *	Author: Jayachandran C <jchandra@broadcom.com>
+ * Copyright (C) 2016 Semihalf
+ * 	Author: Tomasz Nowicki <tn@semihalf.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation (the "GPL").
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License version 2 (GPLv2) for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * version 2 (GPLv2) along with this source code.
+ */
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/pci-acpi.h>
+#include <linux/slab.h>
+
+#include "../pci/ecam.h"
+
+#define PREFIX	"ACPI PCI: "
+
+/* ACPI info for generic ACPI PCI controller */
+struct acpi_pci_generic_root_info {
+	struct acpi_pci_root_info	common;
+	struct pci_config_window	*cfg;	/* config space mapping */
+};
+
+void acpi_pci_set_companion(struct pci_host_bridge *bridge)
+{
+	struct pci_config_window *cfg = bridge->bus->sysdata;
+
+	ACPI_COMPANION_SET(&bridge->dev, cfg->companion);
+}
+
+int acpi_pci_bus_domain_nr(struct pci_bus *bus)
+{
+	struct pci_config_window *cfg = bus->sysdata;
+
+	return cfg->domain;
+}
+
+/*
+ * Lookup the bus range for the domain in MCFG, and set up config space
+ * mapping.
+ */
+static int pci_acpi_setup_ecam_mapping(struct acpi_pci_root *root,
+				       struct acpi_pci_generic_root_info *ri)
+{
+	struct resource *bus_res = &root->secondary;
+	u16 seg = root->segment;
+	struct pci_config_window *cfg;
+	struct resource cfgres;
+	unsigned int bsz;
+	phys_addr_t addr;
+
+	addr = pci_mcfg_lookup(root->device, seg, bus_res);
+	if (IS_ERR_VALUE(addr)) {
+		pr_err(PREFIX"%04x:%pR MCFG region not found\n", seg, bus_res);
+		return addr;
+	}
+
+	bsz = 1 << pci_generic_ecam_ops.bus_shift;
+	cfgres.start = addr + bus_res->start * bsz;
+	cfgres.end = addr + (bus_res->end + 1) * bsz - 1;
+	cfgres.flags = IORESOURCE_MEM;
+	cfg = pci_ecam_create(&root->device->dev, &cfgres, bus_res,
+						  &pci_generic_ecam_ops);
+	if (IS_ERR(cfg)) {
+		pr_err("%04x:%pR error %ld mapping CAM\n", seg, bus_res,
+		       PTR_ERR(cfg));
+		return PTR_ERR(cfg);
+	}
+
+	cfg->domain = seg;
+	cfg->companion = root->device;
+	ri->cfg = cfg;
+	return 0;
+}
+
+/* release_info: free resrouces allocated by init_info */
+static void pci_acpi_generic_release_info(struct acpi_pci_root_info *ci)
+{
+	struct acpi_pci_generic_root_info *ri;
+
+	ri = container_of(ci, struct acpi_pci_generic_root_info, common);
+	pci_ecam_free(ri->cfg);
+	kfree(ri);
+}
+
+static struct acpi_pci_root_ops acpi_pci_root_ops = {
+	.release_info = pci_acpi_generic_release_info,
+};
+
+/* Interface called from ACPI code to setup PCI host controller */
+struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
+{
+	int node = acpi_get_node(root->device->handle);
+	struct acpi_pci_generic_root_info *ri;
+	struct pci_bus *bus, *child;
+	int err;
+
+	ri = kzalloc_node(sizeof(*ri), GFP_KERNEL, node);
+	if (!ri)
+		return NULL;
+
+	err = pci_acpi_setup_ecam_mapping(root, ri);
+	if (err)
+		return NULL;
+
+	acpi_pci_root_ops.pci_ops = &ri->cfg->ops->pci_ops;
+	bus = acpi_pci_root_create(root, &acpi_pci_root_ops, &ri->common,
+				   ri->cfg);
+	if (!bus)
+		return NULL;
+
+	pci_bus_size_bridges(bus);
+	pci_bus_assign_resources(bus);
+
+	list_for_each_entry(child, &bus->children, node)
+		pcie_bus_configure_settings(child);
+
+	return bus;
+}
+
+int raw_pci_read(unsigned int domain, unsigned int busn, unsigned int devfn,
+		 int reg, int len, u32 *val)
+{
+	struct pci_bus *bus = pci_find_bus(domain, busn);
+
+	if (!bus)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	return bus->ops->read(bus, devfn, reg, len, val);
+}
+
+int raw_pci_write(unsigned int domain, unsigned int busn, unsigned int devfn,
+		  int reg, int len, u32 val)
+{
+	struct pci_bus *bus = pci_find_bus(domain, busn);
+
+	if (!bus)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	return bus->ops->write(bus, devfn, reg, len, val);
+}
diff --git a/drivers/pci/ecam.h b/drivers/pci/ecam.h
index 1ad2176..1cccf57 100644
--- a/drivers/pci/ecam.h
+++ b/drivers/pci/ecam.h
@@ -45,6 +45,11 @@ struct pci_config_window {
 		void __iomem		*win;	/* 64-bit single mapping */
 		void __iomem		**winp; /* 32-bit per bus mapping */
 	};
+#ifdef CONFIG_ACPI_PCI_HOST_GENERIC
+	struct acpi_device		*companion; /* ACPI companion device */
+#endif
+	int				domain;
+
 };
 
 /* create and free for pci_config_window */
diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
index 1baa515..42ff844 100644
--- a/include/linux/pci-acpi.h
+++ b/include/linux/pci-acpi.h
@@ -111,6 +111,10 @@ static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
 static inline void acpi_pci_remove_bus(struct pci_bus *bus) { }
 #endif	/* CONFIG_ACPI */
 
+#ifdef CONFIG_ACPI_PCI_HOST_GENERIC
+void acpi_pci_set_companion(struct pci_host_bridge *bridge);
+int acpi_pci_bus_domain_nr(struct pci_bus *bus);
+#else
 static inline void acpi_pci_set_companion(struct pci_host_bridge *bridge)
 {
 }
@@ -119,6 +123,7 @@ static inline int acpi_pci_bus_domain_nr(struct pci_bus *bus)
 {
 	return 0;
 }
+#endif
 
 #ifdef CONFIG_ACPI_APEI
 extern bool aer_acpi_firmware_first(void);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d6ea6ce..b2e8886 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1722,7 +1722,10 @@ void pcibios_free_irq(struct pci_dev *dev);
 extern struct dev_pm_ops pcibios_pm_ops;
 #endif
 
-#ifdef CONFIG_PCI_MMCONFIG
+#if defined(CONFIG_PCI_MMCONFIG) || defined(CONFIG_ACPI_PCI_HOST_GENERIC)
+struct acpi_device;
+phys_addr_t pci_mcfg_lookup(struct acpi_device *device, u16 seg,
+			    struct resource *bus_res);
 void __init pci_mmcfg_early_init(void);
 void __init pci_mmcfg_late_init(void);
 #else
-- 
1.9.1
