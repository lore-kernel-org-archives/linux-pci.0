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
Subject: [RFC PATCH 1/3] pci, acpi: Match PCI config space accessors against platfrom specific ECAM quirks.
Date: Thu,  2 Jun 2016 10:41:01 +0200
Message-Id: <1464856864-18049-2-git-send-email-tn@semihalf.com>
In-Reply-To: <1464856864-18049-1-git-send-email-tn@semihalf.com>
References: <1464856864-18049-1-git-send-email-tn@semihalf.com>
List-ID: <linux-pci.vger.kernel.org>

Some platforms may not be fully compliant with generic set of PCI config
accessors. For these cases we implement the way to overwrite accessors
set. Algorithm traverses available quirk list, matches against
<oem_id, oem_rev, domain, bus number> tuple and returns corresponding
PCI config ops. oem_id and oem_rev come from MCFG table standard header.
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

DECLARE_ACPI_MCFG_FIXUP(&foo_pci_ops, <oem_id_str>, <oem_rev>, <domain_nr>, <bus_nr>);

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
---
 drivers/acpi/pci_mcfg.c           | 32 ++++++++++++++++++++++++++++++++
 include/asm-generic/vmlinux.lds.h |  7 +++++++
 include/linux/pci-acpi.h          | 19 +++++++++++++++++++
 3 files changed, 58 insertions(+)

diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
index 1847f74..f3d4570 100644
--- a/drivers/acpi/pci_mcfg.c
+++ b/drivers/acpi/pci_mcfg.c
@@ -22,11 +22,43 @@
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/pci-acpi.h>
+#include <linux/pci-ecam.h>
 
 /* Root pointer to the mapped MCFG table */
 static struct acpi_table_mcfg *mcfg_table;
 static int mcfg_entries;
 
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
+		    (f->oem_revision == mcfg_table->header.oem_revision))
+			return f->ops;
+	}
+	/* No quirks, use ECAM */
+	return &pci_generic_ecam_ops;
+}
+
 int pci_mcfg_lookup(struct acpi_pci_root *root)
 {
 	struct acpi_mcfg_allocation *mptr, *entry = NULL;
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
index e0e6dfc..b4e8106 100644
--- a/include/linux/pci-acpi.h
+++ b/include/linux/pci-acpi.h
@@ -25,6 +25,7 @@ static inline acpi_status pci_acpi_remove_pm_notifier(struct acpi_device *dev)
 extern phys_addr_t acpi_pci_root_get_mcfg_addr(acpi_handle handle);
 
 extern int pci_mcfg_lookup(struct acpi_pci_root *root);
+extern struct pci_ecam_ops *pci_mcfg_get_ops(struct acpi_pci_root *root);
 
 static inline acpi_handle acpi_find_root_bridge_handle(struct pci_dev *pdev)
 {
@@ -72,6 +73,24 @@ struct acpi_pci_root_ops {
 	int (*prepare_resources)(struct acpi_pci_root_info *info);
 };
 
+struct pci_cfg_fixup {
+	struct pci_ecam_ops *ops;
+	char *oem_id;
+	u32 oem_revision;
+	int domain;
+	int bus_num;
+};
+
+#define PCI_MCFG_DOMAIN_ANY	-1
+#define PCI_MCFG_BUS_ANY	-1
+
+/* Designate a routine to fix up buggy MCFG */
+#define DECLARE_ACPI_MCFG_FIXUP(ops, oem_id, rev, dom, bus)		\
+	static const struct pci_cfg_fixup __mcfg_fixup_##system##dom##bus\
+	 __used	__attribute__((__section__(".acpi_fixup_mcfg"),		\
+				aligned((sizeof(void *))))) =		\
+	{ ops, oem_id, rev, dom, bus };
+
 extern int acpi_pci_probe_root_resources(struct acpi_pci_root_info *info);
 extern struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 					    struct acpi_pci_root_ops *ops,
-- 
1.9.1
