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
Subject: [PATCH V8 7/9] acpi: Add generic MCFG table handling
Date: Mon, 30 May 2016 17:14:20 +0200
Message-Id: <1464621262-26770-8-git-send-email-tn@semihalf.com>
In-Reply-To: <1464621262-26770-1-git-send-email-tn@semihalf.com>
References: <1464621262-26770-1-git-send-email-tn@semihalf.com>
List-ID: <linux-pci.vger.kernel.org>

In order to handle PCI config space regions properly in ACPI, new MCFG
interface is defined which does sanity checks on MCFG table and keeps its
root pointer. The user is able to lookup MCFG regions based on
host bridge root structure and domain:bus_start:bus_end touple.
Use pci_mmcfg_late_init old prototype to avoid another function name.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 drivers/acpi/Kconfig     |  3 ++
 drivers/acpi/Makefile    |  1 +
 drivers/acpi/pci_mcfg.c  | 94 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci-acpi.h |  2 ++
 include/linux/pci.h      |  2 +-
 5 files changed, 101 insertions(+), 1 deletion(-)
 create mode 100644 drivers/acpi/pci_mcfg.c

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index b7e2e77..f98c328 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -217,6 +217,9 @@ config ACPI_PROCESSOR_IDLE
 	bool
 	select CPU_IDLE
 
+config ACPI_MCFG
+	bool
+
 config ACPI_CPPC_LIB
 	bool
 	depends on ACPI_PROCESSOR
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 251ce85..632e81f 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -40,6 +40,7 @@ acpi-$(CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC) += processor_pdc.o
 acpi-y				+= ec.o
 acpi-$(CONFIG_ACPI_DOCK)	+= dock.o
 acpi-y				+= pci_root.o pci_link.o pci_irq.o
+obj-$(CONFIG_ACPI_MCFG)		+= pci_mcfg.o
 acpi-y				+= acpi_lpss.o acpi_apd.o
 acpi-y				+= acpi_platform.o
 acpi-y				+= acpi_pnp.o
diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
new file mode 100644
index 0000000..1847f74
--- /dev/null
+++ b/drivers/acpi/pci_mcfg.c
@@ -0,0 +1,94 @@
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
+
+#define pr_fmt(fmt) "ACPI: " fmt
+
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/pci-acpi.h>
+
+/* Root pointer to the mapped MCFG table */
+static struct acpi_table_mcfg *mcfg_table;
+static int mcfg_entries;
+
+int pci_mcfg_lookup(struct acpi_pci_root *root)
+{
+	struct acpi_mcfg_allocation *mptr, *entry = NULL;
+	struct resource *bus_res = &root->secondary;
+	int i;
+
+	if (mcfg_table) {
+		mptr = (struct acpi_mcfg_allocation *) &mcfg_table[1];
+		for (i = 0; i < mcfg_entries && !entry; i++, mptr++)
+			if (mptr->pci_segment == root->segment &&
+			    mptr->start_bus_number == bus_res->start)
+				entry = mptr;
+	}
+
+	/* not found, use _CBA if available, else error */
+	if (!entry) {
+		if (root->mcfg_addr)
+			return root->mcfg_addr;
+		pr_err("%04x:%pR MCFG lookup failed\n", root->segment, bus_res);
+		return -ENOENT;
+	} else if (root->mcfg_addr && entry->address != root->mcfg_addr) {
+		pr_warn("%04x:%pR CBA %pa != MCFG %lx, using CBA\n",
+			root->segment, bus_res, &root->mcfg_addr,
+			(unsigned long)entry->address);
+		return 0;
+	}
+
+	/* found matching entry, bus range check */
+	if (entry->end_bus_number != bus_res->end) {
+		resource_size_t bus_end = min_t(resource_size_t,
+					entry->end_bus_number, bus_res->end);
+		pr_warn("%04x:%pR bus end mismatch, using %02lx\n",
+			root->segment, bus_res, (unsigned long)bus_end);
+		bus_res->end = bus_end;
+	}
+
+	if (!root->mcfg_addr)
+		root->mcfg_addr = entry->address;
+	return 0;
+}
+
+static __init int pci_mcfg_parse(struct acpi_table_header *header)
+{
+	if (header->length < sizeof(struct acpi_table_mcfg))
+		return -EINVAL;
+
+	mcfg_entries = (header->length - sizeof(struct acpi_table_mcfg)) /
+					sizeof(struct acpi_mcfg_allocation);
+	if (mcfg_entries == 0) {
+		pr_err("MCFG has no entries\n");
+		return -EINVAL;
+	}
+
+	mcfg_table = (struct acpi_table_mcfg *)header;
+	pr_info("MCFG table detected, %d entries\n", mcfg_entries);
+	return 0;
+}
+
+/* Interface called by ACPI - parse and save MCFG table */
+void __init pci_mmcfg_late_init(void)
+{
+	int err = acpi_table_parse(ACPI_SIG_MCFG, pci_mcfg_parse);
+	if (err)
+		pr_err("Failed to parse MCFG (%d)\n", err);
+}
diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
index 89ab057..e0e6dfc 100644
--- a/include/linux/pci-acpi.h
+++ b/include/linux/pci-acpi.h
@@ -24,6 +24,8 @@ static inline acpi_status pci_acpi_remove_pm_notifier(struct acpi_device *dev)
 }
 extern phys_addr_t acpi_pci_root_get_mcfg_addr(acpi_handle handle);
 
+extern int pci_mcfg_lookup(struct acpi_pci_root *root);
+
 static inline acpi_handle acpi_find_root_bridge_handle(struct pci_dev *pdev)
 {
 	struct pci_bus *pbus = pdev->bus;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index bba4053..9661c85 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1724,7 +1724,7 @@ void pcibios_free_irq(struct pci_dev *dev);
 extern struct dev_pm_ops pcibios_pm_ops;
 #endif
 
-#ifdef CONFIG_PCI_MMCONFIG
+#if defined(CONFIG_PCI_MMCONFIG) || defined(CONFIG_ACPI_MCFG)
 void __init pci_mmcfg_early_init(void);
 void __init pci_mmcfg_late_init(void);
 #else
-- 
1.9.1
