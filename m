Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:48048 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422860AbcFMMuB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jun 2016 08:50:01 -0400
From: Dongdong Liu <liudongdong3@huawei.com>
To: <helgaas@kernel.org>, <arnd@arndb.de>, <will.deacon@arm.com>,
	<catalin.marinas@arm.com>, <rafael@kernel.org>,
	<hanjun.guo@linaro.org>, <Lorenzo.Pieralisi@arm.com>,
	<okaya@codeaurora.org>, <jchandra@broadcom.com>, <tn@semihalf.com>
CC: <robert.richter@caviumnetworks.com>, <mw@semihalf.com>,
	<Liviu.Dudau@arm.com>, <ddaney@caviumnetworks.com>,
	<wangyijing@huawei.com>, <Suravee.Suthikulpanit@amd.com>,
	<msalter@redhat.com>, <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linaro-acpi@lists.linaro.org>, <jcm@redhat.com>,
	<andrea.gallo@linaro.org>, <dhdang@apm.com>,
	<jeremy.linton@arm.com>, <liudongdong3@huawei.com>,
	<cov@codeaurora.org>, <gabriele.paoloni@huawei.com>,
	<charles.chenxin@huawei.com>, <linuxarm@huawei.com>
Subject: [RFC PATCH V2 1/2] ACPI/PCI: Match PCI config space accessors against platfrom specific ECAM quirks
Date: Mon, 13 Jun 2016 21:02:02 +0800
Message-ID: <1465822923-33599-2-git-send-email-liudongdong3@huawei.com>
In-Reply-To: <1465822923-33599-1-git-send-email-liudongdong3@huawei.com>
References: <1465822923-33599-1-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Tomasz Nowicki <tn@semihalf.com>

Some platforms may not be fully compliant with generic set of PCI config
accessors. For these cases we implement the way to overwrite accessors
set. Algorithm traverses available quirk list, matches against
<oem_id, oem_table_id, domain, bus number> tuple and returns corresponding
PCI config ops. oem_id and oem_table_id come from MCFG table standard header.
All quirks can be defined using DECLARE_ACPI_MCFG_FIXUP() macro and
kept self contained. Example:

/* Custom PCI config ops */
static struct pci_generic_ecam_ops foo_pci_ops = {
	.bus_shift	= 24,
	.pci_ops = {
		.map_bus = pci_ecam_map_bus,
		.read = foo_ecam_config_read,
		.write = foo_ecam_config_write,
	}
};

DECLARE_ACPI_MCFG_FIXUP(&foo_pci_ops, <oem_id_str>, <oem_table_id>, <domain_nr>, <bus_nr>);

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
---
 drivers/acpi/pci_mcfg.c           | 41 ++++++++++++++++++++++++++++++++++++---
 include/asm-generic/vmlinux.lds.h |  7 +++++++
 include/linux/pci-acpi.h          | 20 +++++++++++++++++++
 3 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
index d3c3e85..49612b3 100644
--- a/drivers/acpi/pci_mcfg.c
+++ b/drivers/acpi/pci_mcfg.c
@@ -22,6 +22,10 @@
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/pci-acpi.h>
+#include <linux/pci-ecam.h>
+
+/* Root pointer to the mapped MCFG table */
+static struct acpi_table_mcfg *mcfg_table;
 
 /* Structure to hold entries from the MCFG table */
 struct mcfg_entry {
@@ -35,6 +39,38 @@ struct mcfg_entry {
 /* List to save mcfg entries */
 static LIST_HEAD(pci_mcfg_list);
 
+extern struct pci_cfg_fixup __start_acpi_mcfg_fixups[];
+extern struct pci_cfg_fixup __end_acpi_mcfg_fixups[];
+
+struct pci_ecam_ops *pci_mcfg_get_ops(struct acpi_pci_root *root)
+{
+	int bus_num = root->secondary.start;
+	int domain = root->segment;
+	struct pci_cfg_fixup *f;
+
+	if (!mcfg_table)
+		return &pci_generic_ecam_ops;
+
+	/*
+	 * Match against platform specific quirks and return corresponding
+	 * CAM ops.
+	 *
+	 * First match against PCI topology <domain:bus> then use OEM ID and
+	 * OEM revision from MCFG table standard header.
+	 */
+	for (f = __start_acpi_mcfg_fixups; f < __end_acpi_mcfg_fixups; f++) {
+		if ((f->domain == domain || f->domain == PCI_MCFG_DOMAIN_ANY) &&
+		    (f->bus_num == bus_num || f->bus_num == PCI_MCFG_BUS_ANY) &&
+		    (!strncmp(f->oem_id, mcfg_table->header.oem_id,
+			      ACPI_OEM_ID_SIZE)) &&
+		    (!strncmp(f->oem_table_id, mcfg_table->header.oem_table_id,
+			      ACPI_OEM_TABLE_ID_SIZE)))
+			return f->ops;
+	}
+	/* No quirks, use ECAM */
+	return &pci_generic_ecam_ops;
+}
+
 phys_addr_t pci_mcfg_lookup(u16 seg, struct resource *bus_res)
 {
 	struct mcfg_entry *e;
@@ -54,7 +90,6 @@ phys_addr_t pci_mcfg_lookup(u16 seg, struct resource *bus_res)
 
 static __init int pci_mcfg_parse(struct acpi_table_header *header)
 {
-	struct acpi_table_mcfg *mcfg;
 	struct acpi_mcfg_allocation *mptr;
 	struct mcfg_entry *e, *arr;
 	int i, n;
@@ -64,8 +99,8 @@ static __init int pci_mcfg_parse(struct acpi_table_header *header)
 
 	n = (header->length - sizeof(struct acpi_table_mcfg)) /
 					sizeof(struct acpi_mcfg_allocation);
-	mcfg = (struct acpi_table_mcfg *)header;
-	mptr = (struct acpi_mcfg_allocation *) &mcfg[1];
+	mcfg_table = (struct acpi_table_mcfg *)header;
+	mptr = (struct acpi_mcfg_allocation *) &mcfg_table[1];
 
 	arr = kcalloc(n, sizeof(*arr), GFP_KERNEL);
 	if (!arr)
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 6a67ab9..43604fc 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -300,6 +300,13 @@
 		VMLINUX_SYMBOL(__end_pci_fixups_suspend_late) = .;	\
 	}								\
 									\
+	/* ACPI MCFG quirks */						\
+	.acpi_fixup        : AT(ADDR(.acpi_fixup) - LOAD_OFFSET) {	\
+		VMLINUX_SYMBOL(__start_acpi_mcfg_fixups) = .;		\
+		*(.acpi_fixup_mcfg)					\
+		VMLINUX_SYMBOL(__end_acpi_mcfg_fixups) = .;		\
+	}								\
+									\
 	/* Built-in firmware blobs */					\
 	.builtin_fw        : AT(ADDR(.builtin_fw) - LOAD_OFFSET) {	\
 		VMLINUX_SYMBOL(__start_builtin_fw) = .;			\
diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
index 7d63a66..088a1da 100644
--- a/include/linux/pci-acpi.h
+++ b/include/linux/pci-acpi.h
@@ -25,6 +25,7 @@ static inline acpi_status pci_acpi_remove_pm_notifier(struct acpi_device *dev)
 extern phys_addr_t acpi_pci_root_get_mcfg_addr(acpi_handle handle);
 
 extern phys_addr_t pci_mcfg_lookup(u16 domain, struct resource *bus_res);
+extern struct pci_ecam_ops *pci_mcfg_get_ops(struct acpi_pci_root *root);
 
 static inline acpi_handle acpi_find_root_bridge_handle(struct pci_dev *pdev)
 {
@@ -72,6 +73,25 @@ struct acpi_pci_root_ops {
 	int (*prepare_resources)(struct acpi_pci_root_info *info);
 };
 
+struct pci_cfg_fixup {
+	struct pci_ecam_ops *ops;
+	char *oem_id;
+	char *oem_table_id;
+	int domain;
+	int bus_num;
+};
+
+#define PCI_MCFG_DOMAIN_ANY	-1
+#define PCI_MCFG_BUS_ANY	-1
+
+/* Designate a routine to fix up buggy MCFG */
+#define DECLARE_ACPI_MCFG_FIXUP(ops, oem_id, oem_table_id, dom, bus)	\
+	static const struct pci_cfg_fixup				\
+	__mcfg_fixup_##oem_id##oem_table_id##dom##bus			\
+	__used	__attribute__((__section__(".acpi_fixup_mcfg"),		\
+				aligned((sizeof(void *))))) =		\
+	{ ops, oem_id, oem_table_id, dom, bus };
+
 extern int acpi_pci_probe_root_resources(struct acpi_pci_root_info *info);
 extern struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 					    struct acpi_pci_root_ops *ops,
-- 
1.9.1

