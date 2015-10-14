Return-Path: <linux-arch-owner@vger.kernel.org>
From: Ley Foon Tan <lftan@altera.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>
CC: <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, Ley Foon Tan <lftan@altera.com>,
	<lftan.linux@gmail.com>
Subject: [PATCH v2 4/4] nios2: Add architectural support for PCIe
Date: Wed, 14 Oct 2015 14:31:44 +0800
Message-ID: <1444804304-5213-5-git-send-email-lftan@altera.com>
In-Reply-To: <1444804304-5213-1-git-send-email-lftan@altera.com>
References: <1444804304-5213-1-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch add pcie support on nios2 platform.

Signed-off-by: Ley Foon Tan <lftan@altera.com>
---
 arch/nios2/Kconfig            | 21 +++++++++++++++++++++
 arch/nios2/include/asm/Kbuild |  1 +
 arch/nios2/include/asm/io.h   | 12 ++++++++++--
 arch/nios2/kernel/Makefile    |  1 +
 arch/nios2/kernel/pci.c       | 33 +++++++++++++++++++++++++++++++++
 5 files changed, 66 insertions(+), 2 deletions(-)
 create mode 100644 arch/nios2/kernel/pci.c

diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
index 4375554..bde323f 100644
--- a/arch/nios2/Kconfig
+++ b/arch/nios2/Kconfig
@@ -11,6 +11,7 @@ config NIOS2
 	select HAVE_ARCH_KGDB
 	select IRQ_DOMAIN
 	select MODULES_USE_ELF_RELA
+	select MIGHT_HAVE_PCI
 	select OF
 	select OF_EARLY_FLATTREE
 	select SOC_BUS
@@ -194,6 +195,26 @@ config NIOS2_IO_REGION_BASE
 
 endmenu
 
+menu "Bus support"
+config PCI
+	bool "PCI support"
+	select GENERIC_PCI_IOMAP
+	help
+	  This feature enables support for PCIe bus system. If you say Y
+	  here, the kernel will include drivers and infrastructure code
+	  to support PCIe bus devices.
+
+config PCI_DOMAINS
+	def_bool PCI
+
+config PCI_DOMAINS_GENERIC
+	def_bool PCI
+
+source "drivers/pci/Kconfig"
+source "drivers/pci/pcie/Kconfig"
+
+endmenu
+
 menu "Executable file formats"
 
 source "fs/Kconfig.binfmt"
diff --git a/arch/nios2/include/asm/Kbuild b/arch/nios2/include/asm/Kbuild
index d63330e..a7cace1 100644
--- a/arch/nios2/include/asm/Kbuild
+++ b/arch/nios2/include/asm/Kbuild
@@ -34,6 +34,7 @@ generic-y += mm-arch-hooks.h
 generic-y += mman.h
 generic-y += module.h
 generic-y += msgbuf.h
+generic-y += msi.h
 generic-y += param.h
 generic-y += pci.h
 generic-y += percpu.h
diff --git a/arch/nios2/include/asm/io.h b/arch/nios2/include/asm/io.h
index c5a62da..0ba8388 100644
--- a/arch/nios2/include/asm/io.h
+++ b/arch/nios2/include/asm/io.h
@@ -14,8 +14,7 @@
 #include <linux/types.h>
 #include <asm/pgtable-bits.h>
 
-/* PCI is not supported in nios2, set this to 0. */
-#define IO_SPACE_LIMIT 0
+#define IO_SPACE_LIMIT 0xffff
 
 #define readb_relaxed(addr)	readb(addr)
 #define readw_relaxed(addr)	readw(addr)
@@ -45,6 +44,15 @@ static inline void iounmap(void __iomem *addr)
 	__iounmap(addr);
 }
 
+static inline void __iomem *ioport_map(unsigned long port, unsigned int nr)
+{
+	return NULL;
+}
+
+static inline void ioport_unmap(void __iomem *p)
+{
+}
+
 #define ioremap_wc ioremap_nocache
 #define ioremap_wt ioremap_nocache
 
diff --git a/arch/nios2/kernel/Makefile b/arch/nios2/kernel/Makefile
index 1aae257..bb1ef81 100644
--- a/arch/nios2/kernel/Makefile
+++ b/arch/nios2/kernel/Makefile
@@ -10,6 +10,7 @@ obj-y	+= entry.o
 obj-y	+= insnemu.o
 obj-y	+= irq.o
 obj-y	+= nios2_ksyms.o
+obj-y	+= pci.o
 obj-y	+= process.o
 obj-y	+= prom.o
 obj-y	+= ptrace.o
diff --git a/arch/nios2/kernel/pci.c b/arch/nios2/kernel/pci.c
new file mode 100644
index 0000000..d28aed7
--- /dev/null
+++ b/arch/nios2/kernel/pci.c
@@ -0,0 +1,33 @@
+/* Copyright Altera Corporation (C) 2015. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2,
+ * as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+#include <linux/pci.h>
+
+/*
+ * Called after each bus is probed, but before its children are examined
+ */
+void pcibios_fixup_bus(struct pci_bus *bus)
+{
+	/* nothing to do, expected to be removed in the future */
+}
+
+/*
+ * We don't have to worry about legacy ISA devices, so nothing to do here
+ */
+resource_size_t pcibios_align_resource(void *data, const struct resource *res,
+				resource_size_t size, resource_size_t align)
+{
+	return res->start;
+}
-- 
1.8.2.1

