Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Joao Pinto <Joao.Pinto@synopsys.com>
To: Vineet.Gupta1@synopsys.com, helgaas@kernel.org
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org, CARLOS.PALMINHA@synopsys.com,
	Alexey.Brodkin@synopsys.com, robh+dt@kernel.org,
	pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org, arnd@arndb.de,
	Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [PATCH v7 1/2] PCI support added to ARC
Date: Mon,  1 Feb 2016 18:07:44 +0000
Message-Id: <cd8c068e6a2adca346769f0f9c1e0c291d001048.1454349430.git.jpinto@synopsys.com>
In-Reply-To: <cover.1454349430.git.jpinto@synopsys.com>
References: <cover.1454349430.git.jpinto@synopsys.com>
In-Reply-To: <cover.1454349430.git.jpinto@synopsys.com>
References: <cover.1454349430.git.jpinto@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds PCI support to ARC and updates drivers/pci Makefile
enabling the ARC arch to use the generic PCI setup functions.

Signed-off-by: Joao Pinto <jpinto@synopsys.com>
---
Change v6 -> v7 (Bjorn Helgaas):
- Parenthesis removed from definitions
Change v5 -> v6 (Vineet Gupta):
- Removed EXPORT_SYMBOL(pcibios_fixup_bus) from pcibios.c
Change v4 -> v5 (Vineet Gupta):
- pcibios.c unused functions, variables and includes were removed
- ioremap.c has no need for changes (no patch is necessary)
- pci.h unused functions and variables were removed
Change v3 -> v4:
- Nothing changed (just to keep up with patch set version).
Change v2 -> v3 (Bjorn Helgaas):
- arch/arc/kernel/pcibios.c unused functions were removed and also the
arch/arc/include/asm/mach/pci.h was removed because was no longer necessary
Change v1 -> v2:
- In arch/arc/Kconfig, the new menu entry (Bus Configuration) was moved to the
slot between sourcing of drivers/Kconfig and fs/Kconfig (Vineet Gupta)
- In arch/arc/plat-axs10x/Kconfig the "select MIGHT_HAVE_PCI" option was placed
in order as suggested (Vineet Gupta)
- ioport_map() and ioport_unmap() were static inlined and included in
the io.h (Vineet Gupta)
- pcibios_min_io and pcibios_min_mem declaration moved to
pcibios.c (Vineet Gupta)
- pr_err() replaced by dev_err() in pcibios_enable_device() (Bjorn Helgaas)
- string simplified in pcibios_enable_device() (Vineet Gupta)
- pci_host_bridge_window structure was replaced by resource_entry structure, and
list_for_each_entry() for resource_list_for_each_entry() in pcibios.c

 arch/arc/Kconfig             | 23 +++++++++++++++++++++++
 arch/arc/include/asm/dma.h   |  5 +++++
 arch/arc/include/asm/io.h    |  9 +++++++++
 arch/arc/include/asm/pci.h   | 31 +++++++++++++++++++++++++++++++
 arch/arc/kernel/Makefile     |  1 +
 arch/arc/kernel/pcibios.c    | 23 +++++++++++++++++++++++
 arch/arc/plat-axs10x/Kconfig |  1 +
 drivers/pci/Makefile         |  1 +
 8 files changed, 94 insertions(+)
 create mode 100644 arch/arc/include/asm/pci.h
 create mode 100644 arch/arc/kernel/pcibios.c

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 2c2ac3f..98b32c1 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -19,6 +19,7 @@ config ARC
 	select GENERIC_FIND_FIRST_BIT
 	# for now, we don't need GENERIC_IRQ_PROBE, CONFIG_GENERIC_IRQ_CHIP
 	select GENERIC_IRQ_SHOW
+	select GENERIC_PCI_IOMAP
 	select GENERIC_PENDING_IRQ if SMP
 	select GENERIC_SMP_IDLE_THREAD
 	select HAVE_ARCH_KGDB
@@ -39,6 +40,9 @@ config ARC
 	select PERF_USE_VMALLOC
 	select HAVE_DEBUG_STACKOVERFLOW
 
+config MIGHT_HAVE_PCI
+	bool
+
 config TRACE_IRQFLAGS_SUPPORT
 	def_bool y
 
@@ -570,6 +574,25 @@ endmenu	 # "ARC Architecture Configuration"
 source "mm/Kconfig"
 source "net/Kconfig"
 source "drivers/Kconfig"
+
+menu "Bus Support"
+
+config PCI
+	bool "PCI support" if MIGHT_HAVE_PCI
+	help
+	  PCI is the name of a bus system, i.e. the way the CPU talks to the other stuff inside
+	  your box.Find out if your board/platform have PCI.
+	  Note: PCIE support for Synopsys Device will be available only when
+	  HAPS DX is configured with PCIE RC bitmap. If you have PCI, say Y, otherwise N.
+
+config PCI_SYSCALL
+	def_bool PCI
+
+source "drivers/pci/Kconfig"
+source "drivers/pci/pcie/Kconfig"
+
+endmenu
+
 source "fs/Kconfig"
 source "arch/arc/Kconfig.debug"
 source "security/Kconfig"
diff --git a/arch/arc/include/asm/dma.h b/arch/arc/include/asm/dma.h
index ca7c451..01e47a6 100644
--- a/arch/arc/include/asm/dma.h
+++ b/arch/arc/include/asm/dma.h
@@ -10,5 +10,10 @@
 #define ASM_ARC_DMA_H
 
 #define MAX_DMA_ADDRESS 0xC0000000
+#ifdef CONFIG_PCI
+extern int isa_dma_bridge_buggy;
+#else
+#define isa_dma_bridge_buggy	0
+#endif
 
 #endif
diff --git a/arch/arc/include/asm/io.h b/arch/arc/include/asm/io.h
index 694ece8..947bf0c 100644
--- a/arch/arc/include/asm/io.h
+++ b/arch/arc/include/asm/io.h
@@ -16,6 +16,15 @@
 extern void __iomem *ioremap(unsigned long physaddr, unsigned long size);
 extern void __iomem *ioremap_prot(phys_addr_t offset, unsigned long size,
 				  unsigned long flags);
+static inline void __iomem *ioport_map(unsigned long port, unsigned int nr)
+{
+	return (void __iomem *)port;
+}
+
+static inline void ioport_unmap(void __iomem *addr)
+{
+}
+
 extern void iounmap(const void __iomem *addr);
 
 #define ioremap_nocache(phy, sz)	ioremap(phy, sz)
diff --git a/arch/arc/include/asm/pci.h b/arch/arc/include/asm/pci.h
new file mode 100644
index 0000000..2f2011c
--- /dev/null
+++ b/arch/arc/include/asm/pci.h
@@ -0,0 +1,31 @@
+/*
+ * Copyright (C) 2015-2016 Synopsys, Inc. (www.synopsys.com)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _ASM_ARC_PCI_H
+#define _ASM_ARC_PCI_H
+
+#ifdef __KERNEL__
+#include <asm-generic/pci-dma-compat.h>
+#include <asm-generic/pci-bridge.h>
+
+#include <linux/ioport.h>
+
+#define PCIBIOS_MIN_IO 0x100
+#define PCIBIOS_MIN_MEM 0x100000
+
+#define pcibios_assign_all_busses()	1
+/*
+ * The PCI address space does equal the physical memory address space.
+ * The networking and block device layers use this boolean for bounce
+ * buffer decisions.
+ */
+#define PCI_DMA_BUS_IS_PHYS	1
+
+#endif /* __KERNEL__ */
+
+#endif /* _ASM_ARC_PCI_H */
diff --git a/arch/arc/kernel/Makefile b/arch/arc/kernel/Makefile
index e7f3625..1bc2036 100644
--- a/arch/arc/kernel/Makefile
+++ b/arch/arc/kernel/Makefile
@@ -12,6 +12,7 @@ obj-y	:= arcksyms.o setup.o irq.o time.o reset.o ptrace.o process.o devtree.o
 obj-y	+= signal.o traps.o sys.o troubleshoot.o stacktrace.o disasm.o clk.o
 obj-$(CONFIG_ISA_ARCOMPACT)		+= entry-compact.o intc-compact.o
 obj-$(CONFIG_ISA_ARCV2)			+= entry-arcv2.o intc-arcv2.o
+obj-$(CONFIG_PCI)  			+= pcibios.o
 
 obj-$(CONFIG_MODULES)			+= arcksyms.o module.o
 obj-$(CONFIG_SMP) 			+= smp.o
diff --git a/arch/arc/kernel/pcibios.c b/arch/arc/kernel/pcibios.c
new file mode 100644
index 0000000..7bc3a42
--- /dev/null
+++ b/arch/arc/kernel/pcibios.c
@@ -0,0 +1,23 @@
+/*
+ * Copyright (C) 2014-2015 Synopsys, Inc. (www.synopsys.com)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/pci.h>
+
+/*
+ * We don't have to worry about legacy ISA devices, so nothing to do here
+ */
+resource_size_t pcibios_align_resource(void *data, const struct resource *res,
+				resource_size_t size, resource_size_t align)
+{
+	return res->start;
+}
+
+void pcibios_fixup_bus(struct pci_bus *bus)
+{
+}
diff --git a/arch/arc/plat-axs10x/Kconfig b/arch/arc/plat-axs10x/Kconfig
index d475f9d..426ac4b 100644
--- a/arch/arc/plat-axs10x/Kconfig
+++ b/arch/arc/plat-axs10x/Kconfig
@@ -11,6 +11,7 @@ menuconfig ARC_PLAT_AXS10X
 	select DW_APB_ICTL
 	select GPIO_DWAPB
 	select OF_GPIO
+	select MIGHT_HAVE_PCI
 	select GENERIC_IRQ_CHIP
 	select ARCH_REQUIRE_GPIOLIB
 	help
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index be3f631..2154092 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_PCI_IOV) += iov.o
 # Some architectures use the generic PCI setup functions
 #
 obj-$(CONFIG_ALPHA) += setup-irq.o
+obj-$(CONFIG_ARC) += setup-irq.o
 obj-$(CONFIG_ARM) += setup-irq.o
 obj-$(CONFIG_ARM64) += setup-irq.o
 obj-$(CONFIG_UNICORE32) += setup-irq.o
-- 
1.8.1.5
