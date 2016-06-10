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
Subject: [PATCH V9 05/11] ACPI/PCI: Add generic MCFG table handling
Date: Fri, 10 Jun 2016 21:55:13 +0200
Message-Id: <1465588519-11334-6-git-send-email-tn@semihalf.com>
In-Reply-To: <1465588519-11334-1-git-send-email-tn@semihalf.com>
References: <1465588519-11334-1-git-send-email-tn@semihalf.com>
List-ID: <linux-pci.vger.kernel.org>

According to PCI firmware specifications, on systems booting with ACPI,
PCI configuration for a host bridge must be set-up through the MCFG table
regions for non-hotpluggable bridges and _CBA method for hotpluggable ones.

Current MCFG table handling code, as implemented for x86, cannot be
easily generalized owing to x86 specific quirks handling and related
code, which makes it hard to reuse on other architectures.

In order to implement MCFG PCI configuration handling for new platforms
booting with ACPI (eg ARM64) this patch re-implements MCFG handling from
scratch in a streamlined fashion and provides (through a generic
interface available to all arches):

- Simplified MCFG table parsing (executed through the pci_mmcfg_late_init()
  hook as in current x86)
- MCFG regions look-up interface through domain:bus_start:bus_end tuple

The new MCFG regions handling interface is added to generic ACPI code
so that existing architectures (eg x86) can be moved over to it and
architectures relying on MCFG for ACPI PCI config space can rely on it
without having to resort to arch specific implementations.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
Signed-off-by: Jayachandran C <jchandra@broadcom.com>
Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 drivers/acpi/Kconfig     |  3 ++
 drivers/acpi/Makefile    |  1 +
 drivers/acpi/pci_mcfg.c  | 92 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci-acpi.h |  2 ++
 include/linux/pci.h      |  2 +-
 5 files changed, 99 insertions(+), 1 deletion(-)
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
index 0000000..d3c3e85
--- /dev/null
+++ b/drivers/acpi/pci_mcfg.c
@@ -0,0 +1,92 @@
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
+/* Structure to hold entries from the MCFG table */
+struct mcfg_entry {
+	struct list_head	list;
+	phys_addr_t		addr;
+	u16			segment;
+	u8			bus_start;
+	u8			bus_end;
+};
+
+/* List to save mcfg entries */
+static LIST_HEAD(pci_mcfg_list);
+
+phys_addr_t pci_mcfg_lookup(u16 seg, struct resource *bus_res)
+{
+	struct mcfg_entry *e;
+
+	/*
+	 * We expect exact match, unless MCFG entry end bus covers more than
+	 * specified by caller.
+	 */
+	list_for_each_entry(e, &pci_mcfg_list, list) {
+		if (e->segment == seg && e->bus_start == bus_res->start &&
+		    e->bus_end >= bus_res->end)
+			return e->addr;
+	}
+
+	return 0;
+}
+
+static __init int pci_mcfg_parse(struct acpi_table_header *header)
+{
+	struct acpi_table_mcfg *mcfg;
+	struct acpi_mcfg_allocation *mptr;
+	struct mcfg_entry *e, *arr;
+	int i, n;
+
+	if (header->length < sizeof(struct acpi_table_mcfg))
+		return -EINVAL;
+
+	n = (header->length - sizeof(struct acpi_table_mcfg)) /
+					sizeof(struct acpi_mcfg_allocation);
+	mcfg = (struct acpi_table_mcfg *)header;
+	mptr = (struct acpi_mcfg_allocation *) &mcfg[1];
+
+	arr = kcalloc(n, sizeof(*arr), GFP_KERNEL);
+	if (!arr)
+		return -ENOMEM;
+
+	for (i = 0, e = arr; i < n; i++, mptr++, e++) {
+		e->segment = mptr->pci_segment;
+		e->addr =  mptr->address;
+		e->bus_start = mptr->start_bus_number;
+		e->bus_end = mptr->end_bus_number;
+		list_add(&e->list, &pci_mcfg_list);
+	}
+
+	pr_info("MCFG table detected, %d entries\n", n);
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
index 89ab057..7d63a66 100644
--- a/include/linux/pci-acpi.h
+++ b/include/linux/pci-acpi.h
@@ -24,6 +24,8 @@ static inline acpi_status pci_acpi_remove_pm_notifier(struct acpi_device *dev)
 }
 extern phys_addr_t acpi_pci_root_get_mcfg_addr(acpi_handle handle);
 
+extern phys_addr_t pci_mcfg_lookup(u16 domain, struct resource *bus_res);
+
 static inline acpi_handle acpi_find_root_bridge_handle(struct pci_dev *pdev)
 {
 	struct pci_bus *pbus = pdev->bus;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 12349de..ce03d65 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1723,7 +1723,7 @@ void pcibios_free_irq(struct pci_dev *dev);
 extern struct dev_pm_ops pcibios_pm_ops;
 #endif
 
-#ifdef CONFIG_PCI_MMCONFIG
+#if defined(CONFIG_PCI_MMCONFIG) || defined(CONFIG_ACPI_MCFG)
 void __init pci_mmcfg_early_init(void);
 void __init pci_mmcfg_late_init(void);
 #else
-- 
1.9.1
