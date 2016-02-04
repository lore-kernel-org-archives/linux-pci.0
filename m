Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Tomasz Nowicki <tn@semihalf.com>
To: bhelgaas@google.com, arnd@arndb.de, will.deacon@arm.com,
	catalin.marinas@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org,
	Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org,
	jiang.liu@linux.intel.com, Stefano.Stabellini@eu.citrix.com
Cc: robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jchandra@broadcom.com, jcm@redhat.com,
	Tomasz Nowicki <tn@semihalf.com>
Subject: [PATCH V4 05/23] x86, pci, ecam: mmconfig_64.c becomes default implementation for ECAM driver.
Date: Thu,  4 Feb 2016 18:28:43 +0100
Message-Id: <1454606941-9523-6-git-send-email-tn@semihalf.com>
In-Reply-To: <1454606941-9523-1-git-send-email-tn@semihalf.com>
References: <1454606941-9523-1-git-send-email-tn@semihalf.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

mmconfig_64.c functions responsible for ECAM regions mapping
are generic enough to use them for other architectures, GENERIC_ECAM_MAP
should be selected in that case (like 64bit x86). Some hosts may need
arch-specific mapping logic, thus they are obligated to provide own
implementation and resign GENERIC_ECAM_MAP feature (like 32bit x86 does).

Note, we leaved x86-specific PCI config accessors in the corresponding files.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Tested-by: Jeremy Linton <jeremy.linton@arm.com>
Tested-by: Duc Dang <dhdang@apm.com>
Tested-by: Dongdong Liu <liudongdong3@huawei.com>
Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
Tested-by: Graeme Gregory <graeme.gregory@linaro.org>
Tested-by: Sinan Kaya <okaya@codeaurora.org>
---
 arch/x86/Kconfig               |  1 +
 arch/x86/include/asm/pci_x86.h |  4 ---
 arch/x86/pci/mmconfig_64.c     | 55 ---------------------------------------
 drivers/acpi/mcfg.c            |  2 --
 drivers/pci/Kconfig            |  3 +++
 drivers/pci/ecam.c             | 59 +++++++++++++++++++++++++++++++++++++++++-
 include/linux/ecam.h           |  6 +++++
 7 files changed, 68 insertions(+), 62 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index a74acce..15674b9 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -65,6 +65,7 @@ config X86
 	select GENERIC_CMOS_UPDATE
 	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_EARLY_IOREMAP
+	select GENERIC_ECAM_MAP			if X86_64
 	select GENERIC_FIND_FIRST_BIT
 	select GENERIC_IOMAP
 	select GENERIC_IRQ_PROBE
diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
index 26e7dd4..6e14518 100644
--- a/arch/x86/include/asm/pci_x86.h
+++ b/arch/x86/include/asm/pci_x86.h
@@ -122,10 +122,6 @@ extern int pci_legacy_init(void);
 extern void pcibios_fixup_irqs(void);
 
 /* pci-mmconfig.c */
-extern int __init pci_mmcfg_arch_init(void);
-extern void __init pci_mmcfg_arch_free(void);
-extern int pci_mmcfg_arch_map(struct pci_mmcfg_region *cfg);
-extern void pci_mmcfg_arch_unmap(struct pci_mmcfg_region *cfg);
 extern int pci_mmconfig_insert(struct device *dev, u16 seg, u8 start, u8 end,
 			       phys_addr_t addr);
 
diff --git a/arch/x86/pci/mmconfig_64.c b/arch/x86/pci/mmconfig_64.c
index d0c48eb..fd356cc 100644
--- a/arch/x86/pci/mmconfig_64.c
+++ b/arch/x86/pci/mmconfig_64.c
@@ -90,58 +90,3 @@ int pci_mmcfg_write(unsigned int seg, unsigned int bus,
 
 	return 0;
 }
-
-static void __iomem *mcfg_ioremap(struct pci_mmcfg_region *cfg)
-{
-	void __iomem *addr;
-	u64 start, size;
-	int num_buses;
-
-	start = cfg->address + PCI_MMCFG_BUS_OFFSET(cfg->start_bus);
-	num_buses = cfg->end_bus - cfg->start_bus + 1;
-	size = PCI_MMCFG_BUS_OFFSET(num_buses);
-	addr = ioremap_nocache(start, size);
-	if (addr)
-		addr -= PCI_MMCFG_BUS_OFFSET(cfg->start_bus);
-	return addr;
-}
-
-int __init pci_mmcfg_arch_init(void)
-{
-	struct pci_mmcfg_region *cfg;
-
-	list_for_each_entry(cfg, &pci_mmcfg_list, list)
-		if (pci_mmcfg_arch_map(cfg)) {
-			pci_mmcfg_arch_free();
-			return 0;
-		}
-
-	return 1;
-}
-
-void __init pci_mmcfg_arch_free(void)
-{
-	struct pci_mmcfg_region *cfg;
-
-	list_for_each_entry(cfg, &pci_mmcfg_list, list)
-		pci_mmcfg_arch_unmap(cfg);
-}
-
-int pci_mmcfg_arch_map(struct pci_mmcfg_region *cfg)
-{
-	cfg->virt = mcfg_ioremap(cfg);
-	if (!cfg->virt) {
-		pr_err(PREFIX "can't map MMCONFIG at %pR\n", &cfg->res);
-		return -ENOMEM;
-	}
-
-	return 0;
-}
-
-void pci_mmcfg_arch_unmap(struct pci_mmcfg_region *cfg)
-{
-	if (cfg && cfg->virt) {
-		iounmap(cfg->virt + PCI_MMCFG_BUS_OFFSET(cfg->start_bus));
-		cfg->virt = NULL;
-	}
-}
diff --git a/drivers/acpi/mcfg.c b/drivers/acpi/mcfg.c
index fad9917..745b83e 100644
--- a/drivers/acpi/mcfg.c
+++ b/drivers/acpi/mcfg.c
@@ -10,8 +10,6 @@
 #include <linux/acpi.h>
 #include <linux/ecam.h>
 
-#include <asm/pci_x86.h> /* Temp hack before refactoring arch-specific calls */
-
 #define	PREFIX	"MCFG: "
 
 int __init acpi_parse_mcfg(struct acpi_table_header *header)
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 9950248..dd26f39 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -33,6 +33,9 @@ config PCI_ECAM
 config HAVE_PCI_ECAM
 	bool
 
+config GENERIC_ECAM_MAP
+	bool
+
 config PCI_DEBUG
 	bool "PCI Debugging"
 	depends on PCI && DEBUG_KERNEL
diff --git a/drivers/pci/ecam.c b/drivers/pci/ecam.c
index d221dba..7bc75af 100644
--- a/drivers/pci/ecam.c
+++ b/drivers/pci/ecam.c
@@ -16,7 +16,6 @@
 #include <linux/ecam.h>
 
 #include <asm/io.h>
-#include <asm/pci_x86.h> /* Temp hack before refactoring arch-specific calls */
 
 #define PREFIX "PCI: "
 
@@ -24,6 +23,64 @@ static DEFINE_MUTEX(pci_mmcfg_lock);
 
 LIST_HEAD(pci_mmcfg_list);
 
+#ifdef CONFIG_GENERIC_ECAM_MAP
+
+static void __iomem *mcfg_ioremap(struct pci_mmcfg_region *cfg)
+{
+	void __iomem *addr;
+	u64 start, size;
+	int num_buses;
+
+	start = cfg->address + PCI_MMCFG_BUS_OFFSET(cfg->start_bus);
+	num_buses = cfg->end_bus - cfg->start_bus + 1;
+	size = PCI_MMCFG_BUS_OFFSET(num_buses);
+	addr = ioremap_nocache(start, size);
+	if (addr)
+		addr -= PCI_MMCFG_BUS_OFFSET(cfg->start_bus);
+	return addr;
+}
+
+int __init pci_mmcfg_arch_init(void)
+{
+	struct pci_mmcfg_region *cfg;
+
+	list_for_each_entry(cfg, &pci_mmcfg_list, list)
+		if (pci_mmcfg_arch_map(cfg)) {
+			pci_mmcfg_arch_free();
+			return 0;
+		}
+
+	return 1;
+}
+
+void __init pci_mmcfg_arch_free(void)
+{
+	struct pci_mmcfg_region *cfg;
+
+	list_for_each_entry(cfg, &pci_mmcfg_list, list)
+		pci_mmcfg_arch_unmap(cfg);
+}
+
+int pci_mmcfg_arch_map(struct pci_mmcfg_region *cfg)
+{
+	cfg->virt = mcfg_ioremap(cfg);
+	if (!cfg->virt) {
+		pr_err(PREFIX "can't map MMCONFIG at %pR\n", &cfg->res);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+void pci_mmcfg_arch_unmap(struct pci_mmcfg_region *cfg)
+{
+	if (cfg && cfg->virt) {
+		iounmap(cfg->virt + PCI_MMCFG_BUS_OFFSET(cfg->start_bus));
+		cfg->virt = NULL;
+	}
+}
+#endif /* CONFIG_GENERIC_ECAM_MAP */
+
 static void __init pci_mmconfig_remove(struct pci_mmcfg_region *cfg)
 {
 	if (cfg->res.parent)
diff --git a/include/linux/ecam.h b/include/linux/ecam.h
index dec3b52..813acd1 100644
--- a/include/linux/ecam.h
+++ b/include/linux/ecam.h
@@ -29,6 +29,12 @@ void list_add_sorted(struct pci_mmcfg_region *new);
 void free_all_mmcfg(void);
 int pci_mmconfig_delete(u16 seg, u8 start, u8 end);
 
+/* Arch specific calls */
+int pci_mmcfg_arch_init(void);
+void pci_mmcfg_arch_free(void);
+int pci_mmcfg_arch_map(struct pci_mmcfg_region *cfg);
+void pci_mmcfg_arch_unmap(struct pci_mmcfg_region *cfg);
+
 extern struct list_head pci_mmcfg_list;
 
 #define PCI_MMCFG_BUS_OFFSET(bus)      ((bus) << 20)
-- 
1.9.1
