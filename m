Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:35660 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753860AbbB0PAU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 27 Feb 2015 10:00:20 -0500
Received: by lbjb6 with SMTP id b6so17859834lbj.2
        for <linux-pci@vger.kernel.org>; Fri, 27 Feb 2015 07:00:18 -0800 (PST)
From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
To: bhelgaas@google.com, wangyijing@huawei.com, arnd@arndb.de,
	hanjun.guo@linaro.org, Liviu.Dudau@arm.com, tglx@linutronix.de,
	mingo@redhat.com, hpa@zytor.com, rjw@rjwysocki.net,
	al.stone@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org,
	Tomasz Nowicki <tomasz.nowicki@linaro.org>
Subject: [PATCH v2 7/9] x86, pci, ecam: mmconfig_64.c becomes default implementation for ECAM driver.
Date: Fri, 27 Feb 2015 16:00:42 +0100
Message-Id: <1425049244-19331-8-git-send-email-tomasz.nowicki@linaro.org>
In-Reply-To: <1425049244-19331-1-git-send-email-tomasz.nowicki@linaro.org>
References: <1425049244-19331-1-git-send-email-tomasz.nowicki@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Architectures which want to take advantage of ECAM generic goodness
should select CONFIG_PCI_ECAM_GENERIC. Otherwise, like x86 32bits machines,
are obligated to provide own low-level ECAM calls.

Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
---
 arch/x86/Kconfig           |   1 +
 arch/x86/pci/Makefile      |   5 +-
 arch/x86/pci/mmconfig_64.c | 127 ---------------------------------------------
 drivers/pci/Kconfig        |   3 ++
 drivers/pci/ecam.c         | 113 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 121 insertions(+), 128 deletions(-)
 delete mode 100644 arch/x86/pci/mmconfig_64.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 08d8f7f..71526ec 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -138,6 +138,7 @@ config X86
 	select HAVE_ACPI_APEI_NMI if ACPI
 	select ACPI_LEGACY_TABLES_LOOKUP if ACPI
 	select X86_FEATURE_NAMES if PROC_FS
+	select PCI_ECAM_GENERIC if X86_64
 
 config INSTRUCTION_DECODER
 	def_bool y
diff --git a/arch/x86/pci/Makefile b/arch/x86/pci/Makefile
index 5c6fc35..35c765b 100644
--- a/arch/x86/pci/Makefile
+++ b/arch/x86/pci/Makefile
@@ -1,7 +1,10 @@
 obj-y				:= i386.o init.o
 
 obj-$(CONFIG_PCI_BIOS)		+= pcbios.o
-obj-$(CONFIG_PCI_MMCONFIG)	+= mmconfig_$(BITS).o direct.o mmconfig-shared.o
+obj-$(CONFIG_PCI_MMCONFIG)	+= direct.o mmconfig-shared.o
+ifeq ($(BITS),32)
+obj-$(CONFIG_PCI_MMCONFIG)	+= mmconfig_32.o
+endif
 obj-$(CONFIG_PCI_DIRECT)	+= direct.o
 obj-$(CONFIG_PCI_OLPC)		+= olpc.o
 obj-$(CONFIG_PCI_XEN)		+= xen.o
diff --git a/arch/x86/pci/mmconfig_64.c b/arch/x86/pci/mmconfig_64.c
deleted file mode 100644
index fd857ea..0000000
--- a/arch/x86/pci/mmconfig_64.c
+++ /dev/null
@@ -1,127 +0,0 @@
-/*
- * mmconfig.c - Low-level direct PCI config space access via MMCONFIG
- *
- * This is an 64bit optimized version that always keeps the full mmconfig
- * space mapped. This allows lockless config space operation.
- */
-
-#include <linux/pci.h>
-#include <linux/init.h>
-#include <linux/acpi.h>
-#include <linux/bitmap.h>
-#include <linux/rcupdate.h>
-#include <linux/ecam.h>
-#include <asm/e820.h>
-#include <asm/pci_x86.h>
-
-#define PREFIX "PCI: "
-
-static char __iomem *pci_dev_base(unsigned int seg, unsigned int bus, unsigned int devfn)
-{
-	struct pci_mmcfg_region *cfg = pci_mmconfig_lookup(seg, bus);
-
-	if (cfg && cfg->virt)
-		return cfg->virt + (PCI_MMCFG_BUS_OFFSET(bus) | (devfn << 12));
-	return NULL;
-}
-
-int pci_mmcfg_read(unsigned int seg, unsigned int bus,
-			  unsigned int devfn, int reg, int len, u32 *value)
-{
-	char __iomem *addr;
-
-	/* Why do we have this when nobody checks it. How about a BUG()!? -AK */
-	if (unlikely((bus > 255) || (devfn > 255) || (reg > 4095))) {
-err:		*value = -1;
-		return -EINVAL;
-	}
-
-	rcu_read_lock();
-	addr = pci_dev_base(seg, bus, devfn);
-	if (!addr) {
-		rcu_read_unlock();
-		goto err;
-	}
-
-	*value = pci_mmio_read(len, addr + reg);
-	rcu_read_unlock();
-
-	return 0;
-}
-
-int pci_mmcfg_write(unsigned int seg, unsigned int bus,
-			   unsigned int devfn, int reg, int len, u32 value)
-{
-	char __iomem *addr;
-
-	/* Why do we have this when nobody checks it. How about a BUG()!? -AK */
-	if (unlikely((bus > 255) || (devfn > 255) || (reg > 4095)))
-		return -EINVAL;
-
-	rcu_read_lock();
-	addr = pci_dev_base(seg, bus, devfn);
-	if (!addr) {
-		rcu_read_unlock();
-		return -EINVAL;
-	}
-
-	pci_mmio_write(len, addr + reg, value);
-	rcu_read_unlock();
-
-	return 0;
-}
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
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index e2eb982..32e0a73 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -26,6 +26,9 @@ config PCI_ECAM
 	bool "Enhanced Configuration Access Mechanism (ECAM)"
 	depends on PCI
 
+config PCI_ECAM_GENERIC
+	bool
+
 config PCI_DEBUG
 	bool "PCI Debugging"
 	depends on PCI && DEBUG_KERNEL
diff --git a/drivers/pci/ecam.c b/drivers/pci/ecam.c
index f540184..f886796 100644
--- a/drivers/pci/ecam.c
+++ b/drivers/pci/ecam.c
@@ -21,6 +21,119 @@ static DEFINE_MUTEX(pci_mmcfg_lock);
 
 LIST_HEAD(pci_mmcfg_list);
 
+#ifdef CONFIG_PCI_ECAM_GENERIC
+static char __iomem *pci_dev_base(unsigned int seg, unsigned int bus,
+				  unsigned int devfn)
+{
+	struct pci_mmcfg_region *cfg = pci_mmconfig_lookup(seg, bus);
+
+	if (cfg && cfg->virt)
+		return cfg->virt + (PCI_MMCFG_BUS_OFFSET(bus) | (devfn << 12));
+	return NULL;
+}
+
+int pci_mmcfg_read(unsigned int seg, unsigned int bus,
+			  unsigned int devfn, int reg, int len, u32 *value)
+{
+	char __iomem *addr;
+
+	/* Why do we have this when nobody checks it. How about a BUG()!? -AK */
+	if (unlikely((bus > 255) || (devfn > 255) || (reg > 4095))) {
+err:		*value = -1;
+		return -EINVAL;
+	}
+
+	rcu_read_lock();
+	addr = pci_dev_base(seg, bus, devfn);
+	if (!addr) {
+		rcu_read_unlock();
+		goto err;
+	}
+
+	*value = pci_mmio_read(len, addr + reg);
+	rcu_read_unlock();
+
+	return 0;
+}
+
+int pci_mmcfg_write(unsigned int seg, unsigned int bus,
+			   unsigned int devfn, int reg, int len, u32 value)
+{
+	char __iomem *addr;
+
+	/* Why do we have this when nobody checks it. How about a BUG()!? -AK */
+	if (unlikely((bus > 255) || (devfn > 255) || (reg > 4095)))
+		return -EINVAL;
+
+	rcu_read_lock();
+	addr = pci_dev_base(seg, bus, devfn);
+	if (!addr) {
+		rcu_read_unlock();
+		return -EINVAL;
+	}
+
+	pci_mmio_write(len, addr + reg, value);
+	rcu_read_unlock();
+
+	return 0;
+}
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
 static u32
 pci_mmconfig_generic_read(int len, void __iomem *addr)
 {
-- 
1.9.1

