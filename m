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
	gabriele.paoloni@huawei.com,
	jhugo@codeaurora.org,
	Tomasz Nowicki <tn@semihalf.com>
Subject: [RFC PATCH v4 3/5] PCI: Check platform specific ECAM quirks
Date: Tue, 28 Jun 2016 09:54:00 +0200
Message-Id: <1467100442-28078-4-git-send-email-tn@semihalf.com>
In-Reply-To: <1467100442-28078-1-git-send-email-tn@semihalf.com>
References: <1467100442-28078-1-git-send-email-tn@semihalf.com>
List-ID: <linux-pci.vger.kernel.org>

Some platforms may not be fully compliant with generic set of PCI config
accessors. For these cases we implement the way to overwrite accessors
set. Algorithm traverses available quirk list (static array),
matches against <oem_id, oem_table_id, rev, domain, bus number range> and
returns pci_config_window structure with fancy PCI config ops.
oem_id, oem_table_id and rev come from MCFG table standard header.

It is possible to define custom init call which is responsible for
setting up PCI config access accordingly to quirk requirements.
If no custom init call defined, use standard pci_acpi_setup_ecam_mapping().

pci_generic_ecam_ops will be used for platforms free from quirks.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
Signed-off-by: Christopher Covington <cov@codeaurora.org>
---
 drivers/pci/host/Makefile      |  1 +
 drivers/pci/host/mcfg-quirks.c | 88 ++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/host/mcfg-quirks.h | 20 ++++++++++
 include/linux/pci-acpi.h       |  2 +
 4 files changed, 111 insertions(+)
 create mode 100644 drivers/pci/host/mcfg-quirks.c
 create mode 100644 drivers/pci/host/mcfg-quirks.h

diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
index 5bc0af2..e3d55a0 100644
--- a/drivers/pci/host/Makefile
+++ b/drivers/pci/host/Makefile
@@ -30,3 +30,4 @@ obj-$(CONFIG_PCI_HOST_THUNDER_ECAM) += pci-thunder-ecam.o
 obj-$(CONFIG_PCI_HOST_THUNDER_PEM) += pci-thunder-pem.o
 obj-$(CONFIG_PCIE_ARMADA_8K) += pcie-armada8k.o
 obj-$(CONFIG_PCIE_ARTPEC6) += pcie-artpec6.o
+obj-$(CONFIG_ACPI_MCFG) += mcfg-quirks.o
diff --git a/drivers/pci/host/mcfg-quirks.c b/drivers/pci/host/mcfg-quirks.c
new file mode 100644
index 0000000..fb2b184
--- /dev/null
+++ b/drivers/pci/host/mcfg-quirks.c
@@ -0,0 +1,88 @@
+/*
+ * Copyright (C) 2016 Semihalf
+ *	Author: Tomasz Nowicki <tn@semihalf.com>
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
+#include <linux/kernel.h>
+#include <linux/ioport.h>
+#include <linux/pci.h>
+#include <linux/pci-acpi.h>
+#include <linux/pci-ecam.h>
+
+#include "mcfg-quirks.h"
+
+struct pci_cfg_fixup {
+	char *oem_id;
+	char *oem_table_id;
+	u32 oem_revision;
+	struct resource domain_range;
+	struct resource bus_range;
+	struct pci_ops *ops;
+	struct pci_config_window *(*init)(struct acpi_pci_root *root,
+					  struct pci_ops *ops);
+};
+
+#define MCFG_DOM_RANGE(start, end)	DEFINE_RES_NAMED((start),	\
+						((end) - (start) + 1), NULL, 0)
+#define MCFG_DOM_ANY			MCFG_DOM_RANGE(0x0, 0xffff)
+#define MCFG_BUS_RANGE(start, end)	DEFINE_RES_NAMED((start),	\
+						((end) - (start) + 1),	\
+						NULL, IORESOURCE_BUS)
+#define MCFG_BUS_ANY			MCFG_BUS_RANGE(0x0, 0xff)
+
+static struct pci_cfg_fixup mcfg_qurks[] __initconst = {
+/*	{ OEM_ID, OEM_TABLE_ID, REV, DOMAIN, BUS_RANGE, pci_ops, init_hook }, */
+};
+
+static bool pci_mcfg_fixup_match(struct pci_cfg_fixup *f,
+				 struct acpi_table_header *mcfg_header)
+{
+	int olen = min_t(u8, strlen(f->oem_id), ACPI_OEM_ID_SIZE);
+	int tlen = min_t(u8, strlen(f->oem_table_id), ACPI_OEM_TABLE_ID_SIZE);
+
+	return (!strncmp(f->oem_id, mcfg_header->oem_id, olen) &&
+		!strncmp(f->oem_table_id, mcfg_header->oem_table_id, tlen) &&
+		f->oem_revision == mcfg_header->oem_revision);
+}
+
+struct pci_config_window *pci_mcfg_match_quirks(struct acpi_pci_root *root)
+{
+	struct resource dom_res = MCFG_DOM_RANGE(root->segment, root->segment);
+	struct resource *bus_res = &root->secondary;
+	struct pci_cfg_fixup *f = mcfg_qurks;
+	struct acpi_table_header *mcfg_header;
+	acpi_status status;
+	int i;
+
+	status = acpi_get_table(ACPI_SIG_MCFG, 0, &mcfg_header);
+	if (ACPI_FAILURE(status))
+		return NULL;
+
+	/*
+	 * First match against PCI topology <domain:bus> then use OEM ID, OEM
+	 * table ID, and OEM revision from MCFG table standard header.
+	 */
+	for (i = 0; i < ARRAY_SIZE(mcfg_qurks); i++, f++) {
+		if (resource_contains(&f->domain_range, &dom_res) &&
+		    resource_contains(&f->bus_range, bus_res) &&
+		    pci_mcfg_fixup_match(f, mcfg_header)) {
+			pr_info("Handling %s %s r%d PCI MCFG quirks\n",
+				f->oem_id, f->oem_table_id, f->oem_revision);
+			return f->init ? f->init(root, f->ops) :
+				pci_acpi_setup_ecam_mapping(root, f->ops);
+		}
+	}
+	return pci_acpi_setup_ecam_mapping(root, &pci_generic_ecam_ops.pci_ops);
+}
diff --git a/drivers/pci/host/mcfg-quirks.h b/drivers/pci/host/mcfg-quirks.h
new file mode 100644
index 0000000..45cbd16
--- /dev/null
+++ b/drivers/pci/host/mcfg-quirks.h
@@ -0,0 +1,20 @@
+/*
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
+#ifndef __MCFG_QUIRKS_H__
+#define __MCFG_QUIRKS_H__
+
+/* MCFG quirks initialize call list */
+
+#endif /* __MCFG_QUIRKS_H__ */
diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
index e9bfe00..28cdce4 100644
--- a/include/linux/pci-acpi.h
+++ b/include/linux/pci-acpi.h
@@ -25,6 +25,8 @@ static inline acpi_status pci_acpi_remove_pm_notifier(struct acpi_device *dev)
 extern phys_addr_t acpi_pci_root_get_mcfg_addr(acpi_handle handle);
 
 extern phys_addr_t pci_mcfg_lookup(u16 domain, struct resource *bus_res);
+extern struct pci_config_window *
+pci_mcfg_match_quirks(struct acpi_pci_root *root);
 
 extern struct pci_config_window *
 pci_acpi_setup_ecam_mapping(struct acpi_pci_root *root, struct pci_ops *ops);
-- 
1.9.1
