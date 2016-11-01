Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:45872 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423978AbcKANC5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Nov 2016 09:02:57 -0400
From: "zhichang.yuan" <yuanzhichang@hisilicon.com>
To: <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <robh+dt@kernel.org>, <bhelgaas@google.com>,
        <mark.rutland@arm.com>, <arnd@arndb.de>,
        <linux-arm-kernel@lists.infradead.org>
CC: <lorenzo.pieralisi@arm.com>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <minyard@acm.org>, <benh@kernel.crashing.org>,
        <liviu.dudau@arm.com>, <zourongrong@gmail.com>,
        <john.garry@huawei.com>, <gabriele.paoloni@huawei.com>,
        <zhichang.yuan02@gmail.com>, <kantyzc@163.com>,
        <xuwei5@hisilicon.com>,
        "zhichang.yuan" <yuanzhichang@hisilicon.com>
Subject: [PATCH/RESEND V4 1/3] ARM64 LPC: Indirect ISA port IO introduced
Date: Tue, 1 Nov 2016 21:28:44 +0800
Message-ID: <1478006926-240933-2-git-send-email-yuanzhichang@hisilicon.com>
In-Reply-To: <1478006926-240933-1-git-send-email-yuanzhichang@hisilicon.com>
References: <1478006926-240933-1-git-send-email-yuanzhichang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

For arm64, there is no I/O space as other architectural platforms, such as
X86. Most I/O accesses are achieved based on MMIO. But for some arm64 SoCs,
such as Hip06, when accessing some legacy ISA devices connected to LPC, those
known port addresses are used to control the corresponding target devices, for
example, 0x2f8 is for UART, 0xe4 is for ipmi-bt. It is different from the
normal MMIO mode in using.

To drive these devices, this patch introduces a method named indirect-IO.
In this method the in/out pair in arch/arm64/include/asm/io.h will be
redefined. When upper layer drivers call in/out with those known legacy port
addresses to access the peripherals, the hooking functions corrresponding to
those target peripherals will be called. Through this way, those upper layer
drivers which depend on in/out can run on Hip06 without any changes.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: zhichang.yuan <yuanzhichang@hisilicon.com>
Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
---
 arch/arm64/Kconfig             |  6 +++
 arch/arm64/include/asm/extio.h | 94 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/io.h    | 29 +++++++++++++
 arch/arm64/kernel/Makefile     |  1 +
 arch/arm64/kernel/extio.c      | 29 +++++++++++++
 5 files changed, 159 insertions(+)
 create mode 100644 arch/arm64/include/asm/extio.h
 create mode 100644 arch/arm64/kernel/extio.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 30398db..103dbea 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -163,6 +163,12 @@ config ARCH_MMAP_RND_COMPAT_BITS_MIN
 config ARCH_MMAP_RND_COMPAT_BITS_MAX
        default 16
 
+config ARM64_INDIRECT_PIO
+	bool "access peripherals with legacy I/O port"
+	help
+	  Support special accessors for ISA I/O devices. This is needed for
+	  SoCs that do not support standard read/write for the ISA range.
+
 config NO_IOPORT_MAP
 	def_bool y if !PCI
 
diff --git a/arch/arm64/include/asm/extio.h b/arch/arm64/include/asm/extio.h
new file mode 100644
index 0000000..6ae0787
--- /dev/null
+++ b/arch/arm64/include/asm/extio.h
@@ -0,0 +1,94 @@
+/*
+ * Copyright (C) 2016 Hisilicon Limited, All Rights Reserved.
+ * Author: Zhichang Yuan <yuanzhichang@hisilicon.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __LINUX_EXTIO_H
+#define __LINUX_EXTIO_H
+
+struct extio_ops {
+	unsigned long start;/* inclusive, sys io addr */
+	unsigned long end;/* inclusive, sys io addr */
+
+	u64 (*pfin)(void *devobj, unsigned long ptaddr,	size_t dlen);
+	void (*pfout)(void *devobj, unsigned long ptaddr, u32 outval,
+					size_t dlen);
+	u64 (*pfins)(void *devobj, unsigned long ptaddr, void *inbuf,
+				size_t dlen, unsigned int count);
+	void (*pfouts)(void *devobj, unsigned long ptaddr,
+				const void *outbuf, size_t dlen,
+				unsigned int count);
+	void *devpara;
+};
+
+extern struct extio_ops *arm64_extio_ops;
+
+#define DECLARE_EXTIO(bw, type)						\
+extern type in##bw(unsigned long addr);					\
+extern void out##bw(type value, unsigned long addr);			\
+extern void ins##bw(unsigned long addr, void *buffer, unsigned int count);\
+extern void outs##bw(unsigned long addr, const void *buffer, unsigned int count);
+
+#define BUILD_EXTIO(bw, type)						\
+type in##bw(unsigned long addr)						\
+{									\
+	if (!arm64_extio_ops || arm64_extio_ops->start > addr ||	\
+			arm64_extio_ops->end < addr)			\
+		return read##bw(PCI_IOBASE + addr);			\
+	return arm64_extio_ops->pfin ?					\
+		arm64_extio_ops->pfin(arm64_extio_ops->devpara,		\
+			addr, sizeof(type)) : -1;			\
+}									\
+									\
+void out##bw(type value, unsigned long addr)				\
+{									\
+	if (!arm64_extio_ops || arm64_extio_ops->start > addr ||	\
+			arm64_extio_ops->end < addr)			\
+		write##bw(value, PCI_IOBASE + addr);			\
+	else								\
+		if (arm64_extio_ops->pfout)				\
+			arm64_extio_ops->pfout(arm64_extio_ops->devpara,\
+				addr, value, sizeof(type));		\
+}									\
+									\
+void ins##bw(unsigned long addr, void *buffer, unsigned int count)	\
+{									\
+	if (!arm64_extio_ops || arm64_extio_ops->start > addr ||	\
+			arm64_extio_ops->end < addr)			\
+		reads##bw(PCI_IOBASE + addr, buffer, count);		\
+	else								\
+		if (arm64_extio_ops->pfins)				\
+			arm64_extio_ops->pfins(arm64_extio_ops->devpara,\
+				addr, buffer, sizeof(type), count);	\
+}									\
+									\
+void outs##bw(unsigned long addr, const void *buffer, unsigned int count)	\
+{									\
+	if (!arm64_extio_ops || arm64_extio_ops->start > addr ||	\
+			arm64_extio_ops->end < addr)			\
+		writes##bw(PCI_IOBASE + addr, buffer, count);		\
+	else								\
+		if (arm64_extio_ops->pfouts)				\
+			arm64_extio_ops->pfouts(arm64_extio_ops->devpara,\
+				addr, buffer, sizeof(type), count);	\
+}
+
+static inline void arm64_set_extops(struct extio_ops *ops)
+{
+	if (ops)
+		WRITE_ONCE(arm64_extio_ops, ops);
+}
+
+#endif /* __LINUX_EXTIO_H*/
diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index 0bba427..136735d 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -31,6 +31,7 @@
 #include <asm/early_ioremap.h>
 #include <asm/alternative.h>
 #include <asm/cpufeature.h>
+#include <asm/extio.h>
 
 #include <xen/xen.h>
 
@@ -149,6 +150,34 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
 #define IO_SPACE_LIMIT		(PCI_IO_SIZE - 1)
 #define PCI_IOBASE		((void __iomem *)PCI_IO_START)
 
+
+/*
+ * redefine the in(s)b/out(s)b for indirect-IO.
+ */
+#ifdef CONFIG_ARM64_INDIRECT_PIO
+#define inb inb
+#define outb outb
+#define insb insb
+#define outsb outsb
+/* external declaration */
+DECLARE_EXTIO(b, u8)
+
+#define inw inw
+#define outw outw
+#define insw insw
+#define outsw outsw
+
+DECLARE_EXTIO(w, u16)
+
+#define inl inl
+#define outl outl
+#define insl insl
+#define outsl outsl
+
+DECLARE_EXTIO(l, u32)
+#endif
+
+
 /*
  * String version of I/O memory access operations.
  */
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 7d66bba..60e0482 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -31,6 +31,7 @@ arm64-obj-$(CONFIG_COMPAT)		+= sys32.o kuser32.o signal32.o 	\
 					   sys_compat.o entry32.o
 arm64-obj-$(CONFIG_FUNCTION_TRACER)	+= ftrace.o entry-ftrace.o
 arm64-obj-$(CONFIG_MODULES)		+= arm64ksyms.o module.o
+arm64-obj-$(CONFIG_ARM64_INDIRECT_PIO)	+= extio.o
 arm64-obj-$(CONFIG_ARM64_MODULE_PLTS)	+= module-plts.o
 arm64-obj-$(CONFIG_PERF_EVENTS)		+= perf_regs.o perf_callchain.o
 arm64-obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event.o
diff --git a/arch/arm64/kernel/extio.c b/arch/arm64/kernel/extio.c
new file mode 100644
index 0000000..80cafd5
--- /dev/null
+++ b/arch/arm64/kernel/extio.c
@@ -0,0 +1,29 @@
+/*
+ * Copyright (C) 2016 Hisilicon Limited, All Rights Reserved.
+ * Author: Zhichang Yuan <yuanzhichang@hisilicon.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/io.h>
+
+struct extio_ops *arm64_extio_ops;
+
+
+BUILD_EXTIO(b, u8)
+
+BUILD_EXTIO(w, u16)
+
+BUILD_EXTIO(l, u32)
+
+#endif
-- 
1.9.1

