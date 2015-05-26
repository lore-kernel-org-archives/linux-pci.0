Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:32802 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752886AbbEZMwr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 May 2015 08:52:47 -0400
Received: by padbw4 with SMTP id bw4so92201400pad.0
        for <linux-pci@vger.kernel.org>; Tue, 26 May 2015 05:50:44 -0700 (PDT)
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
Subject: [PATCH 08/11] x86, pci, ecam: mmconfig_64.c becomes default implementation for ECAM driver.
Date: Tue, 26 May 2015 20:49:21 +0800
Message-Id: <1432644564-24746-9-git-send-email-hanjun.guo@linaro.org>
In-Reply-To: <1432644564-24746-1-git-send-email-hanjun.guo@linaro.org>
References: <1432644564-24746-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Tomasz Nowicki <tomasz.nowicki@linaro.org>

Host which want to take advantage of ECAM generic goodness
should select CONFIG_PCI_ECAM_GENERIC. Otherwise, machines like 32bits x86,
are obligated to provide own low-level ECAM calls.

Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
---
 arch/x86/Kconfig           |   1 +
 arch/x86/pci/Makefile      |   4 +-
 arch/x86/pci/mmconfig_64.c | 127 ---------------------------------------------
 drivers/pci/Kconfig        |   3 ++
 drivers/pci/ecam.c         | 113 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 120 insertions(+), 128 deletions(-)
 delete mode 100644 arch/x86/pci/mmconfig_64.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4e3dcb3..87a6393 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -144,6 +144,7 @@ config X86
 	select X86_FEATURE_NAMES if PROC_FS
 	select SRCU
 	select HAVE_PCI_ECAM
+	select GENERIC_PCI_ECAM if X86_64
 
 config INSTRUCTION_DECODER
 	def_bool y
diff --git a/arch/x86/pci/Makefile b/arch/x86/pci/Makefile
index 5c6fc35..efc193d 100644
--- a/arch/x86/pci/Makefile
+++ b/arch/x86/pci/Makefile
@@ -1,7 +1,9 @@
 obj-y				:= i386.o init.o
 
 obj-$(CONFIG_PCI_BIOS)		+= pcbios.o
-obj-$(CONFIG_PCI_MMCONFIG)	+= mmconfig_$(BITS).o direct.o mmconfig-shared.o
+mmconfig-y			:= direct.o mmconfig-shared.o
+mmconfig-$(CONFIG_X86_32)	+= mmconfig_32.o
+obj-$(CONFIG_PCI_MMCONFIG)	+= $(mmconfig-y)
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
index 90a5fb9..fae4aa7 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -29,6 +29,9 @@ config PCI_ECAM
 config HAVE_PCI_ECAM
 	bool
 
+config GENERIC_PCI_ECAM
+	bool
+
 config PCI_DEBUG
 	bool "PCI Debugging"
 	depends on PCI && DEBUG_KERNEL
diff --git a/drivers/pci/ecam.c b/drivers/pci/ecam.c
index c588234..796b6e7 100644
--- a/drivers/pci/ecam.c
+++ b/drivers/pci/ecam.c
@@ -23,6 +23,119 @@ static DEFINE_MUTEX(pci_mmcfg_lock);
 
 LIST_HEAD(pci_mmcfg_list);
 
+#ifdef CONFIG_GENERIC_PCI_ECAM
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

