Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from [209.85.220.52] ([209.85.220.52]:33626 "EHLO
	mail-pa0-f52.google.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753174AbbEZMxZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 May 2015 08:53:25 -0400
Received: by padbw4 with SMTP id bw4so92197290pad.0
        for <linux-pci@vger.kernel.org>; Tue, 26 May 2015 05:50:29 -0700 (PDT)
From: Hanjun Guo <hanjun.guo@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yijing Wang <wangyijing@huawei.com>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Tomasz Nowicki <tomasz.nowicki@linaro.org>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Mark Salter <msalter@redhat.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH 05/11] x86, pci, acpi: Move arch-agnostic MMCONFIG (aka ECAM) and ACPI code out of arch/x86/ directory
Date: Tue, 26 May 2015 20:49:18 +0800
Message-Id: <1432644564-24746-6-git-send-email-hanjun.guo@linaro.org>
In-Reply-To: <1432644564-24746-1-git-send-email-hanjun.guo@linaro.org>
References: <1432644564-24746-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Tomasz Nowicki <tomasz.nowicki@linaro.org>

ECAM standard and MCFG table are architecture independent and it makes
sense to share common code across all architectures. Both are going to
corresponding files - ecam.c and mcfg.c

While we are here, rename pci_parse_mcfg to acpi_parse_mcfg.
We already have acpi_parse_mcfg prototype which is used nowhere.
At the same time, we need pci_parse_mcfg been global so acpi_parse_mcfg
can be used perfectly here.

Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
---
 arch/x86/Kconfig               |   3 +
 arch/x86/include/asm/pci_x86.h |  33 ------
 arch/x86/pci/acpi.c            |   1 +
 arch/x86/pci/mmconfig-shared.c | 244 +---------------------------------------
 arch/x86/pci/mmconfig_32.c     |   1 +
 arch/x86/pci/mmconfig_64.c     |   1 +
 arch/x86/pci/numachip.c        |   1 +
 drivers/acpi/Makefile          |   1 +
 drivers/acpi/mcfg.c            |  57 ++++++++++
 drivers/pci/Kconfig            |   7 ++
 drivers/pci/Makefile           |   5 +
 drivers/pci/ecam.c             | 245 +++++++++++++++++++++++++++++++++++++++++
 drivers/xen/pci.c              |   1 +
 include/linux/acpi.h           |   2 +
 include/linux/ecam.h           |  51 +++++++++
 15 files changed, 381 insertions(+), 272 deletions(-)
 create mode 100644 drivers/acpi/mcfg.c
 create mode 100644 drivers/pci/ecam.c
 create mode 100644 include/linux/ecam.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 226d569..4e3dcb3 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -143,6 +143,7 @@ config X86
 	select ACPI_LEGACY_TABLES_LOOKUP if ACPI
 	select X86_FEATURE_NAMES if PROC_FS
 	select SRCU
+	select HAVE_PCI_ECAM
 
 config INSTRUCTION_DECODER
 	def_bool y
@@ -2276,6 +2277,7 @@ config PCI_DIRECT
 
 config PCI_MMCONFIG
 	def_bool y
+	select PCI_ECAM
 	depends on X86_32 && PCI && (ACPI || SFI) && (PCI_GOMMCONFIG || PCI_GOANY)
 
 config PCI_OLPC
@@ -2293,6 +2295,7 @@ config PCI_DOMAINS
 
 config PCI_MMCONFIG
 	bool "Support mmconfig PCI config space access"
+	select PCI_ECAM
 	depends on X86_64 && PCI && ACPI
 
 config PCI_CNB20LE_QUIRK
diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
index f7f3b6a..2ea44a7 100644
--- a/arch/x86/include/asm/pci_x86.h
+++ b/arch/x86/include/asm/pci_x86.h
@@ -124,41 +124,8 @@ extern int pci_legacy_init(void);
 extern void pcibios_fixup_irqs(void);
 
 /* pci-mmconfig.c */
-
-/* "PCI MMCONFIG %04x [bus %02x-%02x]" */
-#define PCI_MMCFG_RESOURCE_NAME_LEN (22 + 4 + 2 + 2)
-
-struct pci_mmcfg_region {
-	struct list_head list;
-	struct resource res;
-	u64 address;
-	char __iomem *virt;
-	u16 segment;
-	u8 start_bus;
-	u8 end_bus;
-	char name[PCI_MMCFG_RESOURCE_NAME_LEN];
-};
-
-struct pci_mmcfg_mmio_ops {
-	u32 (*read)(int len, void __iomem *addr);
-	void (*write)(int len, void __iomem *addr, u32 value);
-};
-
-extern int __init pci_mmcfg_arch_init(void);
-extern void __init pci_mmcfg_arch_free(void);
-extern int pci_mmcfg_arch_map(struct pci_mmcfg_region *cfg);
-extern void pci_mmcfg_arch_unmap(struct pci_mmcfg_region *cfg);
 extern int pci_mmconfig_insert(struct device *dev, u16 seg, u8 start, u8 end,
 			       phys_addr_t addr);
-extern int pci_mmconfig_delete(u16 seg, u8 start, u8 end);
-extern struct pci_mmcfg_region *pci_mmconfig_lookup(int segment, int bus);
-extern u32 pci_mmio_read(int len, void __iomem *addr);
-extern void pci_mmio_write(int len, void __iomem *addr, u32 value);
-extern void pci_mmconfig_register_mmio(struct pci_mmcfg_mmio_ops *ops);
-
-extern struct list_head pci_mmcfg_list;
-
-#define PCI_MMCFG_BUS_OFFSET(bus)      ((bus) << 20)
 
 /*
  * AMD Fam10h CPUs are buggy, and cannot access MMIO config space
diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index 89bd79b..217508e 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -5,6 +5,7 @@
 #include <linux/dmi.h>
 #include <linux/slab.h>
 #include <linux/pci-acpi.h>
+#include <linux/ecam.h>
 #include <asm/numa.h>
 #include <asm/pci_x86.h>
 
diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index e770b70..6fa3080 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -18,6 +18,7 @@
 #include <linux/slab.h>
 #include <linux/mutex.h>
 #include <linux/rculist.h>
+#include <linux/ecam.h>
 #include <asm/e820.h>
 #include <asm/pci_x86.h>
 #include <asm/acpi.h>
@@ -27,52 +28,6 @@
 /* Indicate if the mmcfg resources have been placed into the resource table. */
 static bool pci_mmcfg_running_state;
 static bool pci_mmcfg_arch_init_failed;
-static DEFINE_MUTEX(pci_mmcfg_lock);
-
-LIST_HEAD(pci_mmcfg_list);
-
-static u32
-pci_mmconfig_generic_read(int len, void __iomem *addr)
-{
-	u32 data = 0;
-
-	switch (len) {
-	case 1:
-		data = readb(addr);
-		break;
-	case 2:
-		data = readw(addr);
-		break;
-	case 4:
-		data = readl(addr);
-		break;
-	}
-
-	return data;
-}
-
-static void
-pci_mmconfig_generic_write(int len, void __iomem *addr, u32 value)
-{
-	switch (len) {
-	case 1:
-		writeb(value, addr);
-		break;
-	case 2:
-		writew(value, addr);
-		break;
-	case 4:
-		writel(value, addr);
-		break;
-	}
-}
-
-static struct pci_mmcfg_mmio_ops pci_mmcfg_mmio_default = {
-	.read = pci_mmconfig_generic_read,
-	.write = pci_mmconfig_generic_write,
-};
-
-static struct pci_mmcfg_mmio_ops *pci_mmcfg_mmio = &pci_mmcfg_mmio_default;
 
 static u32
 pci_mmconfig_amd_read(int len, void __iomem *addr)
@@ -115,128 +70,6 @@ static struct pci_mmcfg_mmio_ops pci_mmcfg_mmio_amd_fam10h = {
 	.write = pci_mmconfig_amd_write,
 };
 
-void
-pci_mmconfig_register_mmio(struct pci_mmcfg_mmio_ops *ops)
-{
-	pci_mmcfg_mmio = ops;
-}
-
-u32
-pci_mmio_read(int len, void __iomem *addr)
-{
-	if (!pci_mmcfg_mmio) {
-		pr_err("PCI config space has no accessors !");
-		return 0;
-	}
-
-	return pci_mmcfg_mmio->read(len, addr);
-}
-
-void
-pci_mmio_write(int len, void __iomem *addr, u32 value)
-{
-	if (!pci_mmcfg_mmio) {
-		pr_err("PCI config space has no accessors !");
-		return;
-	}
-
-	pci_mmcfg_mmio->write(len, addr, value);
-}
-
-static void __init pci_mmconfig_remove(struct pci_mmcfg_region *cfg)
-{
-	if (cfg->res.parent)
-		release_resource(&cfg->res);
-	list_del(&cfg->list);
-	kfree(cfg);
-}
-
-static void __init free_all_mmcfg(void)
-{
-	struct pci_mmcfg_region *cfg, *tmp;
-
-	pci_mmcfg_arch_free();
-	list_for_each_entry_safe(cfg, tmp, &pci_mmcfg_list, list)
-		pci_mmconfig_remove(cfg);
-}
-
-static void list_add_sorted(struct pci_mmcfg_region *new)
-{
-	struct pci_mmcfg_region *cfg;
-
-	/* keep list sorted by segment and starting bus number */
-	list_for_each_entry_rcu(cfg, &pci_mmcfg_list, list) {
-		if (cfg->segment > new->segment ||
-		    (cfg->segment == new->segment &&
-		     cfg->start_bus >= new->start_bus)) {
-			list_add_tail_rcu(&new->list, &cfg->list);
-			return;
-		}
-	}
-	list_add_tail_rcu(&new->list, &pci_mmcfg_list);
-}
-
-static struct pci_mmcfg_region *pci_mmconfig_alloc(int segment, int start,
-						   int end, u64 addr)
-{
-	struct pci_mmcfg_region *new;
-	struct resource *res;
-
-	if (addr == 0)
-		return NULL;
-
-	new = kzalloc(sizeof(*new), GFP_KERNEL);
-	if (!new)
-		return NULL;
-
-	new->address = addr;
-	new->segment = segment;
-	new->start_bus = start;
-	new->end_bus = end;
-
-	res = &new->res;
-	res->start = addr + PCI_MMCFG_BUS_OFFSET(start);
-	res->end = addr + PCI_MMCFG_BUS_OFFSET(end + 1) - 1;
-	res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
-	snprintf(new->name, PCI_MMCFG_RESOURCE_NAME_LEN,
-		 "PCI MMCONFIG %04x [bus %02x-%02x]", segment, start, end);
-	res->name = new->name;
-
-	return new;
-}
-
-static struct pci_mmcfg_region *__init pci_mmconfig_add(int segment, int start,
-							int end, u64 addr)
-{
-	struct pci_mmcfg_region *new;
-
-	new = pci_mmconfig_alloc(segment, start, end, addr);
-	if (new) {
-		mutex_lock(&pci_mmcfg_lock);
-		list_add_sorted(new);
-		mutex_unlock(&pci_mmcfg_lock);
-
-		pr_info(PREFIX
-		       "MMCONFIG for domain %04x [bus %02x-%02x] at %pR "
-		       "(base %#lx)\n",
-		       segment, start, end, &new->res, (unsigned long)addr);
-	}
-
-	return new;
-}
-
-struct pci_mmcfg_region *pci_mmconfig_lookup(int segment, int bus)
-{
-	struct pci_mmcfg_region *cfg;
-
-	list_for_each_entry_rcu(cfg, &pci_mmcfg_list, list)
-		if (cfg->segment == segment &&
-		    cfg->start_bus <= bus && bus <= cfg->end_bus)
-			return cfg;
-
-	return NULL;
-}
-
 static const char *__init pci_mmcfg_e7520(void)
 {
 	u32 win;
@@ -657,8 +490,8 @@ static void __init pci_mmcfg_reject_broken(int early)
 	}
 }
 
-static int __init acpi_mcfg_check_entry(struct acpi_table_mcfg *mcfg,
-					struct acpi_mcfg_allocation *cfg)
+int __init acpi_mcfg_check_entry(struct acpi_table_mcfg *mcfg,
+				 struct acpi_mcfg_allocation *cfg)
 {
 	int year;
 
@@ -680,50 +513,6 @@ static int __init acpi_mcfg_check_entry(struct acpi_table_mcfg *mcfg,
 	return -EINVAL;
 }
 
-static int __init pci_parse_mcfg(struct acpi_table_header *header)
-{
-	struct acpi_table_mcfg *mcfg;
-	struct acpi_mcfg_allocation *cfg_table, *cfg;
-	unsigned long i;
-	int entries;
-
-	if (!header)
-		return -EINVAL;
-
-	mcfg = (struct acpi_table_mcfg *)header;
-
-	/* how many config structures do we have */
-	free_all_mmcfg();
-	entries = 0;
-	i = header->length - sizeof(struct acpi_table_mcfg);
-	while (i >= sizeof(struct acpi_mcfg_allocation)) {
-		entries++;
-		i -= sizeof(struct acpi_mcfg_allocation);
-	}
-	if (entries == 0) {
-		pr_err(PREFIX "MMCONFIG has no entries\n");
-		return -ENODEV;
-	}
-
-	cfg_table = (struct acpi_mcfg_allocation *) &mcfg[1];
-	for (i = 0; i < entries; i++) {
-		cfg = &cfg_table[i];
-		if (acpi_mcfg_check_entry(mcfg, cfg)) {
-			free_all_mmcfg();
-			return -ENODEV;
-		}
-
-		if (pci_mmconfig_add(cfg->pci_segment, cfg->start_bus_number,
-				   cfg->end_bus_number, cfg->address) == NULL) {
-			pr_warn(PREFIX "no memory for MCFG entries\n");
-			free_all_mmcfg();
-			return -ENOMEM;
-		}
-	}
-
-	return 0;
-}
-
 #ifdef CONFIG_ACPI_APEI
 extern int (*arch_apei_filter_addr)(int (*func)(__u64 start, __u64 size,
 				     void *data), void *data);
@@ -782,7 +571,7 @@ void __init pci_mmcfg_early_init(void)
 		if (pci_mmcfg_check_hostbridge())
 			known_bridge = 1;
 		else
-			acpi_sfi_table_parse(ACPI_SIG_MCFG, pci_parse_mcfg);
+			acpi_sfi_table_parse(ACPI_SIG_MCFG, acpi_parse_mcfg);
 		__pci_mmcfg_init(1);
 
 		set_apei_filter();
@@ -800,7 +589,7 @@ void __init pci_mmcfg_late_init(void)
 
 	/* MMCONFIG hasn't been enabled yet, try again */
 	if (pci_probe & PCI_PROBE_MASK & ~PCI_PROBE_MMCONF) {
-		acpi_sfi_table_parse(ACPI_SIG_MCFG, pci_parse_mcfg);
+		acpi_sfi_table_parse(ACPI_SIG_MCFG, acpi_parse_mcfg);
 		__pci_mmcfg_init(0);
 	}
 }
@@ -916,26 +705,3 @@ error:
 	kfree(cfg);
 	return rc;
 }
-
-/* Delete MMCFG information for host bridges */
-int pci_mmconfig_delete(u16 seg, u8 start, u8 end)
-{
-	struct pci_mmcfg_region *cfg;
-
-	mutex_lock(&pci_mmcfg_lock);
-	list_for_each_entry_rcu(cfg, &pci_mmcfg_list, list)
-		if (cfg->segment == seg && cfg->start_bus == start &&
-		    cfg->end_bus == end) {
-			list_del_rcu(&cfg->list);
-			synchronize_rcu();
-			pci_mmcfg_arch_unmap(cfg);
-			if (cfg->res.parent)
-				release_resource(&cfg->res);
-			mutex_unlock(&pci_mmcfg_lock);
-			kfree(cfg);
-			return 0;
-		}
-	mutex_unlock(&pci_mmcfg_lock);
-
-	return -ENOENT;
-}
diff --git a/arch/x86/pci/mmconfig_32.c b/arch/x86/pci/mmconfig_32.c
index 4b3d025..5cf6291 100644
--- a/arch/x86/pci/mmconfig_32.c
+++ b/arch/x86/pci/mmconfig_32.c
@@ -12,6 +12,7 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/rcupdate.h>
+#include <linux/ecam.h>
 #include <asm/e820.h>
 #include <asm/pci_x86.h>
 
diff --git a/arch/x86/pci/mmconfig_64.c b/arch/x86/pci/mmconfig_64.c
index 032593d..b62ff18 100644
--- a/arch/x86/pci/mmconfig_64.c
+++ b/arch/x86/pci/mmconfig_64.c
@@ -10,6 +10,7 @@
 #include <linux/acpi.h>
 #include <linux/bitmap.h>
 #include <linux/rcupdate.h>
+#include <linux/ecam.h>
 #include <asm/e820.h>
 #include <asm/pci_x86.h>
 
diff --git a/arch/x86/pci/numachip.c b/arch/x86/pci/numachip.c
index 5047e9b..01868b6 100644
--- a/arch/x86/pci/numachip.c
+++ b/arch/x86/pci/numachip.c
@@ -13,6 +13,7 @@
  *
  */
 
+#include <linux/ecam.h>
 #include <linux/pci.h>
 #include <asm/pci_x86.h>
 
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 3e4aec3..576fbb1 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -68,6 +68,7 @@ obj-$(CONFIG_ACPI_BUTTON)	+= button.o
 obj-$(CONFIG_ACPI_FAN)		+= fan.o
 obj-$(CONFIG_ACPI_VIDEO)	+= video.o
 obj-$(CONFIG_ACPI_PCI_SLOT)	+= pci_slot.o
+obj-$(CONFIG_PCI_MMCONFIG)	+= mcfg.o
 obj-$(CONFIG_ACPI_PROCESSOR)	+= processor.o
 obj-y				+= container.o
 obj-$(CONFIG_ACPI_THERMAL)	+= thermal.o
diff --git a/drivers/acpi/mcfg.c b/drivers/acpi/mcfg.c
new file mode 100644
index 0000000..63775af
--- /dev/null
+++ b/drivers/acpi/mcfg.c
@@ -0,0 +1,57 @@
+/*
+ * MCFG ACPI table parser.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/acpi.h>
+#include <linux/ecam.h>
+
+#define	PREFIX	"MCFG: "
+
+int __init acpi_parse_mcfg(struct acpi_table_header *header)
+{
+	struct acpi_table_mcfg *mcfg;
+	struct acpi_mcfg_allocation *cfg_table, *cfg;
+	unsigned long i;
+	int entries;
+
+	if (!header)
+		return -EINVAL;
+
+	mcfg = (struct acpi_table_mcfg *)header;
+
+	/* how many config structures do we have */
+	free_all_mmcfg();
+	entries = 0;
+	i = header->length - sizeof(struct acpi_table_mcfg);
+	while (i >= sizeof(struct acpi_mcfg_allocation)) {
+		entries++;
+		i -= sizeof(struct acpi_mcfg_allocation);
+	}
+	if (entries == 0) {
+		pr_err(PREFIX "MCFG table has no entries\n");
+		return -ENODEV;
+	}
+
+	cfg_table = (struct acpi_mcfg_allocation *) &mcfg[1];
+	for (i = 0; i < entries; i++) {
+		cfg = &cfg_table[i];
+		if (acpi_mcfg_check_entry(mcfg, cfg)) {
+			free_all_mmcfg();
+			return -ENODEV;
+		}
+
+		if (pci_mmconfig_add(cfg->pci_segment, cfg->start_bus_number,
+				 cfg->end_bus_number, cfg->address) == NULL) {
+			pr_warn(PREFIX "no memory for MCFG entries\n");
+			free_all_mmcfg();
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 7a8f1c5..90a5fb9 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -22,6 +22,13 @@ config PCI_MSI_IRQ_DOMAIN
 	depends on PCI_MSI
 	select GENERIC_MSI_IRQ_DOMAIN
 
+config PCI_ECAM
+	bool "Enhanced Configuration Access Mechanism (ECAM)"
+	depends on PCI && HAVE_PCI_ECAM
+
+config HAVE_PCI_ECAM
+	bool
+
 config PCI_DEBUG
 	bool "PCI Debugging"
 	depends on PCI && DEBUG_KERNEL
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 73e4af4..ce7b630 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -41,6 +41,11 @@ obj-$(CONFIG_SPARC_LEON) += setup-irq.o
 obj-$(CONFIG_M68K) += setup-irq.o
 
 #
+# Enhanced Configuration Access Mechanism (ECAM)
+#
+obj-$(CONFIG_PCI_ECAM)	+= ecam.o
+
+#
 # ACPI Related PCI FW Functions
 # ACPI _DSM provided firmware instance and string name
 #
diff --git a/drivers/pci/ecam.c b/drivers/pci/ecam.c
new file mode 100644
index 0000000..c588234
--- /dev/null
+++ b/drivers/pci/ecam.c
@@ -0,0 +1,245 @@
+/*
+ * Arch agnostic direct PCI config space access via
+ * ECAM (Enhanced Configuration Access Mechanism)
+ *
+ * Per-architecture code takes care of the mappings, region validation and
+ * accesses themselves.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/mutex.h>
+#include <linux/rculist.h>
+#include <linux/ecam.h>
+
+#include <asm/io.h>
+
+#define PREFIX "PCI: "
+
+static DEFINE_MUTEX(pci_mmcfg_lock);
+
+LIST_HEAD(pci_mmcfg_list);
+
+static u32
+pci_mmconfig_generic_read(int len, void __iomem *addr)
+{
+	u32 data = 0;
+
+	switch (len) {
+	case 1:
+		data = readb(addr);
+		break;
+	case 2:
+		data = readw(addr);
+		break;
+	case 4:
+		data = readl(addr);
+		break;
+	}
+
+	return data;
+}
+
+static void
+pci_mmconfig_generic_write(int len, void __iomem *addr, u32 value)
+{
+	switch (len) {
+	case 1:
+		writeb(value, addr);
+		break;
+	case 2:
+		writew(value, addr);
+		break;
+	case 4:
+		writel(value, addr);
+		break;
+	}
+}
+
+static struct pci_mmcfg_mmio_ops pci_mmcfg_mmio_default = {
+	.read = pci_mmconfig_generic_read,
+	.write = pci_mmconfig_generic_write,
+};
+
+static struct pci_mmcfg_mmio_ops *pci_mmcfg_mmio = &pci_mmcfg_mmio_default;
+
+void
+pci_mmconfig_register_mmio(struct pci_mmcfg_mmio_ops *ops)
+{
+	pci_mmcfg_mmio = ops;
+}
+
+u32
+pci_mmio_read(int len, void __iomem *addr)
+{
+	if (!pci_mmcfg_mmio) {
+		pr_err("PCI config space has no accessors !");
+		return 0;
+	}
+
+	return pci_mmcfg_mmio->read(len, addr);
+}
+
+void
+pci_mmio_write(int len, void __iomem *addr, u32 value)
+{
+	if (!pci_mmcfg_mmio) {
+		pr_err("PCI config space has no accessors !");
+		return;
+	}
+
+	pci_mmcfg_mmio->write(len, addr, value);
+}
+
+static void __init pci_mmconfig_remove(struct pci_mmcfg_region *cfg)
+{
+	if (cfg->res.parent)
+		release_resource(&cfg->res);
+	list_del(&cfg->list);
+	kfree(cfg);
+}
+
+void __init free_all_mmcfg(void)
+{
+	struct pci_mmcfg_region *cfg, *tmp;
+
+	pci_mmcfg_arch_free();
+	list_for_each_entry_safe(cfg, tmp, &pci_mmcfg_list, list)
+		pci_mmconfig_remove(cfg);
+}
+
+void list_add_sorted(struct pci_mmcfg_region *new)
+{
+	struct pci_mmcfg_region *cfg;
+
+	/* keep list sorted by segment and starting bus number */
+	list_for_each_entry_rcu(cfg, &pci_mmcfg_list, list) {
+		if (cfg->segment > new->segment ||
+		    (cfg->segment == new->segment &&
+		     cfg->start_bus >= new->start_bus)) {
+			list_add_tail_rcu(&new->list, &cfg->list);
+			return;
+		}
+	}
+	list_add_tail_rcu(&new->list, &pci_mmcfg_list);
+}
+
+struct pci_mmcfg_region *pci_mmconfig_alloc(int segment, int start,
+					    int end, u64 addr)
+{
+	struct pci_mmcfg_region *new;
+	struct resource *res;
+
+	if (addr == 0)
+		return NULL;
+
+	new = kzalloc(sizeof(*new), GFP_KERNEL);
+	if (!new)
+		return NULL;
+
+	new->address = addr;
+	new->segment = segment;
+	new->start_bus = start;
+	new->end_bus = end;
+
+	res = &new->res;
+	res->start = addr + PCI_MMCFG_BUS_OFFSET(start);
+	res->end = addr + PCI_MMCFG_BUS_OFFSET(end + 1) - 1;
+	res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
+	snprintf(new->name, PCI_MMCFG_RESOURCE_NAME_LEN,
+		 "PCI MMCONFIG %04x [bus %02x-%02x]", segment, start, end);
+	res->name = new->name;
+
+	return new;
+}
+
+struct pci_mmcfg_region *pci_mmconfig_add(int segment, int start,
+					  int end, u64 addr)
+{
+	struct pci_mmcfg_region *new;
+
+	new = pci_mmconfig_alloc(segment, start, end, addr);
+	if (new) {
+		mutex_lock(&pci_mmcfg_lock);
+		list_add_sorted(new);
+		mutex_unlock(&pci_mmcfg_lock);
+
+		pr_info(PREFIX
+		       "MMCONFIG for domain %04x [bus %02x-%02x] at %pR "
+		       "(base %#lx)\n",
+		       segment, start, end, &new->res, (unsigned long)addr);
+	}
+
+	return new;
+}
+
+struct pci_mmcfg_region *pci_mmconfig_lookup(int segment, int bus)
+{
+	struct pci_mmcfg_region *cfg;
+
+	list_for_each_entry_rcu(cfg, &pci_mmcfg_list, list)
+		if (cfg->segment == segment &&
+		    cfg->start_bus <= bus && bus <= cfg->end_bus)
+			return cfg;
+
+	return NULL;
+}
+
+/* Delete MMCFG information for host bridges */
+int pci_mmconfig_delete(u16 seg, u8 start, u8 end)
+{
+	struct pci_mmcfg_region *cfg;
+
+	mutex_lock(&pci_mmcfg_lock);
+	list_for_each_entry_rcu(cfg, &pci_mmcfg_list, list)
+		if (cfg->segment == seg && cfg->start_bus == start &&
+		    cfg->end_bus == end) {
+			list_del_rcu(&cfg->list);
+			synchronize_rcu();
+			pci_mmcfg_arch_unmap(cfg);
+			if (cfg->res.parent)
+				release_resource(&cfg->res);
+			mutex_unlock(&pci_mmcfg_lock);
+			kfree(cfg);
+			return 0;
+		}
+	mutex_unlock(&pci_mmcfg_lock);
+
+	return -ENOENT;
+}
+
+int pci_mmconfig_inject(struct pci_mmcfg_region *cfg)
+{
+	struct pci_mmcfg_region *cfg_conflict;
+	int err = 0;
+
+	mutex_lock(&pci_mmcfg_lock);
+	cfg_conflict = pci_mmconfig_lookup(cfg->segment, cfg->start_bus);
+	if (cfg_conflict) {
+		if (cfg_conflict->end_bus < cfg->end_bus)
+			pr_info(FW_INFO "MMCONFIG for "
+				"domain %04x [bus %02x-%02x] "
+				"only partially covers this bridge\n",
+				cfg_conflict->segment, cfg_conflict->start_bus,
+				cfg_conflict->end_bus);
+		err = -EEXIST;
+		goto out;
+	}
+
+	if (pci_mmcfg_arch_map(cfg)) {
+		pr_warn("fail to map MMCONFIG %pR.\n", &cfg->res);
+		err = -ENOMEM;
+		goto out;
+	} else {
+		list_add_sorted(cfg);
+		pr_info("MMCONFIG at %pR (base %#lx)\n",
+			&cfg->res, (unsigned long)cfg->address);
+
+	}
+out:
+	mutex_unlock(&pci_mmcfg_lock);
+	return err;
+}
diff --git a/drivers/xen/pci.c b/drivers/xen/pci.c
index 7494dbe..6785ebb 100644
--- a/drivers/xen/pci.c
+++ b/drivers/xen/pci.c
@@ -20,6 +20,7 @@
 #include <linux/pci.h>
 #include <linux/acpi.h>
 #include <linux/pci-acpi.h>
+#include <linux/ecam.h>
 #include <xen/xen.h>
 #include <xen/interface/physdev.h>
 #include <xen/interface/xen.h>
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index b904af3..5063429 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -144,6 +144,8 @@ int acpi_table_parse_madt(enum acpi_madt_type id,
 			  acpi_tbl_entry_handler handler,
 			  unsigned int max_entries);
 int acpi_parse_mcfg (struct acpi_table_header *header);
+int acpi_mcfg_check_entry(struct acpi_table_mcfg *mcfg,
+			  struct acpi_mcfg_allocation *cfg);
 void acpi_table_print_madt_entry (struct acpi_subtable_header *madt);
 
 /* the following four functions are architecture-dependent */
diff --git a/include/linux/ecam.h b/include/linux/ecam.h
new file mode 100644
index 0000000..2387df5
--- /dev/null
+++ b/include/linux/ecam.h
@@ -0,0 +1,51 @@
+#ifndef __ECAM_H
+#define __ECAM_H
+#ifdef __KERNEL__
+
+#include <linux/types.h>
+#include <linux/acpi.h>
+
+/* "PCI MMCONFIG %04x [bus %02x-%02x]" */
+#define PCI_MMCFG_RESOURCE_NAME_LEN (22 + 4 + 2 + 2)
+
+struct pci_mmcfg_region {
+	struct list_head list;
+	struct resource res;
+	u64 address;
+	char __iomem *virt;
+	u16 segment;
+	u8 start_bus;
+	u8 end_bus;
+	char name[PCI_MMCFG_RESOURCE_NAME_LEN];
+};
+
+struct pci_mmcfg_mmio_ops {
+	u32 (*read)(int len, void __iomem *addr);
+	void (*write)(int len, void __iomem *addr, u32 value);
+};
+
+struct pci_mmcfg_region *pci_mmconfig_lookup(int segment, int bus);
+struct pci_mmcfg_region *pci_mmconfig_alloc(int segment, int start,
+						   int end, u64 addr);
+int pci_mmconfig_inject(struct pci_mmcfg_region *cfg);
+struct pci_mmcfg_region *pci_mmconfig_add(int segment, int start,
+						 int end, u64 addr);
+void list_add_sorted(struct pci_mmcfg_region *new);
+void free_all_mmcfg(void);
+int pci_mmconfig_delete(u16 seg, u8 start, u8 end);
+
+/* Arch specific calls */
+int pci_mmcfg_arch_init(void);
+void pci_mmcfg_arch_free(void);
+int pci_mmcfg_arch_map(struct pci_mmcfg_region *cfg);
+void pci_mmcfg_arch_unmap(struct pci_mmcfg_region *cfg);
+extern u32 pci_mmio_read(int len, void __iomem *addr);
+extern void pci_mmio_write(int len, void __iomem *addr, u32 value);
+extern void pci_mmconfig_register_mmio(struct pci_mmcfg_mmio_ops *ops);
+
+extern struct list_head pci_mmcfg_list;
+
+#define PCI_MMCFG_BUS_OFFSET(bus)      ((bus) << 20)
+
+#endif  /* __KERNEL__ */
+#endif  /* __ECAM_H */
-- 
1.9.1

