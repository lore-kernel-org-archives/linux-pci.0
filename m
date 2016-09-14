Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:3850 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932843AbcINL7v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Sep 2016 07:59:51 -0400
From: Zhichang Yuan <yuanzhichang@hisilicon.com>
To: <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
CC: <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <will.deacon@arm.com>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <minyard@acm.org>, <benh@kernel.crashing.org>,
        <lorenzo.pieralisi@arm.com>, <liviu.dudau@arm.com>,
        <zourongrong@gmail.com>, <john.garry@huawei.com>,
        <gabriele.paoloni@huawei.com>, <zhichang.yuan02@gmail.com>,
        <kantyzc@163.com>, <xuwei5@hisilicon.com>,
        "zhichang.yuan" <yuanzhichang@hisilicon.com>
Subject: [PATCH V3 1/4] ARM64 LPC: Indirect ISA port IO introduced
Date: Wed, 14 Sep 2016 20:15:51 +0800
Message-ID: <1473855354-150093-2-git-send-email-yuanzhichang@hisilicon.com>
In-Reply-To: <1473855354-150093-1-git-send-email-yuanzhichang@hisilicon.com>
References: <1473855354-150093-1-git-send-email-yuanzhichang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: "zhichang.yuan" <yuanzhichang@hisilicon.com>

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

Signed-off-by: zhichang.yuan <yuanzhichang@hisilicon.com>
---
 arch/arm64/Kconfig          |  6 +++
 arch/arm64/include/asm/io.h | 90 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/bus/extio.c         | 66 +++++++++++++++++++++++++++++++++
 include/linux/extio.h       | 49 ++++++++++++++++++++++++
 4 files changed, 211 insertions(+)
 create mode 100644 drivers/bus/extio.c
 create mode 100644 include/linux/extio.h

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index bc3f00f..9579479 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -161,6 +161,12 @@ config ARCH_MMAP_RND_COMPAT_BITS_MIN
 config ARCH_MMAP_RND_COMPAT_BITS_MAX
        default 16
 
+config ARM64_INDIRECT_PIO
+	def_bool n
+	help
+	  Support to access the ISA I/O devices with the legacy X86 I/O port
+	  addresses in some SoCs, such as Hisilicon Hip06.
+
 config NO_IOPORT_MAP
 	def_bool y if !PCI
 
diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index 9b6e408..d3acf1f 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -34,6 +34,10 @@
 
 #include <xen/xen.h>
 
+#ifdef CONFIG_ARM64_INDIRECT_PIO
+#include <linux/extio.h>
+#endif
+
 /*
  * Generic IO read/write.  These perform native-endian accesses.
  */
@@ -142,6 +146,38 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
 #define writel(v,c)		({ __iowmb(); writel_relaxed((v),(c)); })
 #define writeq(v,c)		({ __iowmb(); writeq_relaxed((v),(c)); })
 
+
+#define BUILDS_RW(bwl, type)						\
+static inline void reads##bwl(const volatile void __iomem *addr,	\
+				void *buffer, unsigned int count)	\
+{									\
+	if (count) {							\
+		type *buf = buffer;					\
+									\
+		do {							\
+			type x = __raw_read##bwl(addr);			\
+			*buf++ = x;					\
+		} while (--count);					\
+	}								\
+}									\
+									\
+static inline void writes##bwl(volatile void __iomem *addr,		\
+				const void *buffer, unsigned int count)	\
+{									\
+	if (count) {							\
+		const type *buf = buffer;				\
+									\
+		do {							\
+			__raw_write##bwl(*buf++, addr);			\
+		} while (--count);					\
+	}								\
+}
+
+BUILDS_RW(b, u8)
+#define readsb readsb
+#define writesb writesb
+
+
 /*
  *  I/O port access primitives.
  */
@@ -149,6 +185,60 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
 #define IO_SPACE_LIMIT		(PCI_IO_SIZE - 1)
 #define PCI_IOBASE		((void __iomem *)PCI_IO_START)
 
+
+/*
+ * redefine the in(s)b/out(s)b for indirect-IO.
+ */
+#define inb inb
+static inline u8 inb(unsigned long addr)
+{
+#ifdef CONFIG_ARM64_INDIRECT_PIO
+	if (arm64_extio_ops && arm64_extio_ops->start <= addr &&
+			addr <= arm64_extio_ops->end)
+		return extio_inb(addr);
+#endif
+	return readb(PCI_IOBASE + addr);
+}
+
+
+#define outb outb
+static inline void outb(u8 value, unsigned long addr)
+{
+#ifdef CONFIG_ARM64_INDIRECT_PIO
+	if (arm64_extio_ops && arm64_extio_ops->start <= addr &&
+			addr <= arm64_extio_ops->end)
+		extio_outb(value, addr);
+	else
+#endif
+		writeb(value, PCI_IOBASE + addr);
+}
+
+#define insb insb
+static inline void insb(unsigned long addr, void *buffer, unsigned int count)
+{
+#ifdef CONFIG_ARM64_INDIRECT_PIO
+	if (arm64_extio_ops && arm64_extio_ops->start <= addr &&
+			addr <= arm64_extio_ops->end)
+		extio_insb(addr, buffer, count);
+	else
+#endif
+		readsb(PCI_IOBASE + addr, buffer, count);
+}
+
+#define outsb outsb
+static inline void outsb(unsigned long addr, const void *buffer,
+			 unsigned int count)
+{
+#ifdef CONFIG_ARM64_INDIRECT_PIO
+	if (arm64_extio_ops && arm64_extio_ops->start <= addr &&
+			addr <= arm64_extio_ops->end)
+		extio_outsb(addr, buffer, count);
+	else
+#endif
+		writesb(PCI_IOBASE + addr, buffer, count);
+}
+
+
 /*
  * String version of I/O memory access operations.
  */
diff --git a/drivers/bus/extio.c b/drivers/bus/extio.c
new file mode 100644
index 0000000..1e7a9c5
--- /dev/null
+++ b/drivers/bus/extio.c
@@ -0,0 +1,66 @@
+/*
+ * Copyright (C) 2016 Hisilicon Limited, All Rights Reserved.
+ * Author: Zhichang Yuan <yuanzhichang@hisilicon.com>
+ * Author: Zou Rongrong <@huawei.com>
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
+
+struct extio_ops *arm64_extio_ops;
+
+
+u8 __weak extio_inb(unsigned long addr)
+{
+	return arm64_extio_ops->pfin ?
+		arm64_extio_ops->pfin(arm64_extio_ops->devpara,
+			addr + arm64_extio_ops->ptoffset, NULL,
+			sizeof(u8), 1) : -1;
+}
+
+void __weak extio_outb(u8 value, unsigned long addr)
+{
+	if (!arm64_extio_ops->pfout)
+		return;
+
+	arm64_extio_ops->pfout(arm64_extio_ops->devpara,
+			addr + arm64_extio_ops->ptoffset, &value,
+			sizeof(u8), 1);
+}
+
+
+void __weak extio_insb(unsigned long addr, void *buffer,
+				unsigned int count)
+{
+	if (!arm64_extio_ops->pfin)
+		return;
+
+	arm64_extio_ops->pfin(arm64_extio_ops->devpara,
+			addr + arm64_extio_ops->ptoffset, buffer,
+			sizeof(u8), count);
+}
+
+void __weak extio_outsb(unsigned long addr, const void *buffer,
+			 unsigned int count)
+{
+	if (!arm64_extio_ops->pfout)
+		return;
+
+	arm64_extio_ops->pfout(arm64_extio_ops->devpara,
+			addr + arm64_extio_ops->ptoffset, buffer,
+			sizeof(u8), count);
+}
+
+
diff --git a/include/linux/extio.h b/include/linux/extio.h
new file mode 100644
index 0000000..08d1fca
--- /dev/null
+++ b/include/linux/extio.h
@@ -0,0 +1,49 @@
+/*
+ * Copyright (C) 2016 Hisilicon Limited, All Rights Reserved.
+ * Author: Zhichang Yuan <yuanzhichang@hisilicon.com>
+ * Author: Zou Rongrong <@huawei.com>
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
+
+typedef u64 (*inhook)(void *devobj, unsigned long ptaddr, void *inbuf,
+				size_t dlen, unsigned int count);
+typedef void (*outhook)(void *devobj, unsigned long ptaddr,
+				const void *outbuf, size_t dlen,
+				unsigned int count);
+
+struct extio_ops {
+	unsigned long start;/* inclusive, sys io addr */
+	unsigned long end;/* inclusive, sys io addr */
+	unsigned long ptoffset;/* port Io - system Io */
+
+	inhook	pfin;
+	outhook	pfout;
+	void *devpara;
+};
+
+
+extern struct extio_ops *arm64_extio_ops;
+
+extern u8 extio_inb(unsigned long addr);
+extern void extio_outb(u8 value, unsigned long addr);
+extern void extio_insb(unsigned long addr, void *buffer, unsigned int count);
+extern void extio_outsb(unsigned long addr, const void *buffer,
+				unsigned int count);
+
+
+#endif /* __LINUX_EXTIO_H*/
-- 
1.9.1

