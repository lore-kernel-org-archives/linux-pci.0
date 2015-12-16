Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:33979 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965724AbbLPPRt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 16 Dec 2015 10:17:49 -0500
Received: by mail-wm0-f47.google.com with SMTP id l126so44166314wml.1
        for <linux-pci@vger.kernel.org>; Wed, 16 Dec 2015 07:17:48 -0800 (PST)
From: Tomasz Nowicki <tn@semihalf.com>
To: bhelgaas@google.com, arnd@arndb.de, will.deacon@arm.com,
	catalin.marinas@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org,
	Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org,
	jiang.liu@linux.intel.com, Stefano.Stabellini@eu.citrix.com
Cc: robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com, tglx@linutronix.de,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jchandra@broadcom.com, jcm@redhat.com,
	Tomasz Nowicki <tn@semihalf.com>
Subject: [PATCH V2 05/23] x86, pci, ecam: mmconfig_64.c becomes default implementation for ECAM driver.
Date: Wed, 16 Dec 2015 16:16:15 +0100
Message-Id: <1450278993-12664-6-git-send-email-tn@semihalf.com>
In-Reply-To: <1450278993-12664-1-git-send-email-tn@semihalf.com>
References: <1450278993-12664-1-git-send-email-tn@semihalf.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hosts with custom ECAM hooks (like 32bit x86) should select
ARCH_HAS_CUSTOM_PCI_ECAM. Otherwise, host will use generic version
provided by this patch (like 64bit x86 does).

Note, we leaved x86-specific PCI config accessors in corresponding files.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
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
index 350bd52..102d7d1 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -30,6 +30,7 @@ config X86
 	select ARCH_HAS_PMEM_API		if X86_64
 	select ARCH_HAS_MMIO_FLUSH
 	select ARCH_HAS_SG_CHAIN
+	select ARCH_HAS_CUSTOM_PCI_ECAM		if X86_32
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select ARCH_MIGHT_HAVE_ACPI_PDC		if ACPI
 	select ARCH_MIGHT_HAVE_PC_PARPORT
diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
index 0482807..be091b4 100644
--- a/arch/x86/include/asm/pci_x86.h
+++ b/arch/x86/include/asm/pci_x86.h
@@ -123,10 +123,6 @@ extern int pci_legacy_init(void);
 extern int pcibios_fixup_irq(struct pci_dev *dev, u8 pin);
 
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
index 9950248..b2e27c8 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -33,6 +33,9 @@ config PCI_ECAM
 config HAVE_PCI_ECAM
 	bool
 
+config ARCH_HAS_CUSTOM_PCI_ECAM
+	bool
+
 config PCI_DEBUG
 	bool "PCI Debugging"
 	depends on PCI && DEBUG_KERNEL
diff --git a/drivers/pci/ecam.c b/drivers/pci/ecam.c
index d221dba..8a5eef7 100644
--- a/drivers/pci/ecam.c
+++ b/drivers/pci/ecam.c
@@ -16,7 +16,6 @@
 #include <linux/ecam.h>
 
 #include <asm/io.h>
-#include <asm/pci_x86.h> /* Temp hack before refactoring arch-specific calls */
 
 #define PREFIX "PCI: "
 
@@ -24,6 +23,64 @@ static DEFINE_MUTEX(pci_mmcfg_lock);
 
 LIST_HEAD(pci_mmcfg_list);
 
+#ifndef CONFIG_ARCH_HAS_CUSTOM_PCI_ECAM
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
+#endif
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

