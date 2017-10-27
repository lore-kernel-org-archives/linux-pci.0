Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <robh+dt@kernel.org>, <frowand.list@gmail.com>,
        <bhelgaas@google.com>, <rafael@kernel.org>, <arnd@arndb.de>,
        <linux-arm-kernel@lists.infradead.org>, <lorenzo.pieralisi@arm.com>
CC: <gabriele.paoloni@huawei.com>, <mark.rutland@arm.com>,
        <brian.starkey@arm.com>, <olof@lixom.net>,
        <benh@kernel.crashing.org>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-pci@vger.kernel.org>, <minyard@acm.org>,
        <john.garry@huawei.com>, <xuwei5@hisilicon.com>,
        "zhichang.yuan" <yuanzhichang@hisilicon.com>
Subject: [PATCH v10 1/9] LIB: Introduce a generic PIO mapping method
Date: Fri, 27 Oct 2017 17:11:19 +0100
Message-ID: <1509120687-7352-2-git-send-email-gabriele.paoloni@huawei.com>
In-Reply-To: <1509120687-7352-1-git-send-email-gabriele.paoloni@huawei.com>
References: <1509120687-7352-1-git-send-email-gabriele.paoloni@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: "zhichang.yuan" <yuanzhichang@hisilicon.com>

In commit 41f8bba7f555 ("of/pci: Add pci_register_io_range() and
pci_pio_to_address()"), a new I/O space management was supported. With
that driver, the I/O ranges configured for PCI/PCIE hosts on some
architectures can be mapped to logical PIO, converted easily between
CPU address and the corresponding logicial PIO. Based on this, PCI
I/O devices can be accessed in a memory read/write way through the
unified in/out accessors.

But on some archs/platforms, there are bus hosts which access I/O
peripherals with host-local I/O port addresses rather than memory
addresses after memory-mapped.
To support those devices, a more generic I/O mapping method is introduced
here. Through this patch, both the CPU addresses and the host-local port
can be mapped into the logical PIO space with different logical/fake PIOs.
After this, all the I/O accesses to either PCI MMIO devices or host-local
I/O peripherals can be unified into the existing I/O accessors defined in
asm-generic/io.h and be redirected to the right device-specific hooks
based on the input logical PIO.

Signed-off-by: zhichang.yuan <yuanzhichang@hisilicon.com>
Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
---
 include/asm-generic/io.h  |  26 +++++
 include/linux/logic_pio.h | 118 +++++++++++++++++++
 lib/Kconfig               |  26 +++++
 lib/Makefile              |   2 +
 lib/logic_pio.c           | 286 ++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 458 insertions(+)
 create mode 100644 include/linux/logic_pio.h
 create mode 100644 lib/logic_pio.c

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 7ef015e..334e5db 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -351,6 +351,8 @@ static inline void writesq(volatile void __iomem *addr, const void *buffer,
 #define IO_SPACE_LIMIT 0xffff
 #endif
 
+#include <linux/logic_pio.h>
+
 /*
  * {in,out}{b,w,l}() access little endian I/O. {in,out}{b,w,l}_p() can be
  * implemented on hardware that needs an additional delay for I/O accesses to
@@ -358,51 +360,75 @@ static inline void writesq(volatile void __iomem *addr, const void *buffer,
  */
 
 #ifndef inb
+#ifdef CONFIG_INDIRECT_PIO
+#define inb logic_inb
+#else
 #define inb inb
 static inline u8 inb(unsigned long addr)
 {
 	return readb(PCI_IOBASE + addr);
 }
+#endif /* CONFIG_INDIRECT_PIO */
 #endif
 
 #ifndef inw
+#ifdef CONFIG_INDIRECT_PIO
+#define inw logic_inw
+#else
 #define inw inw
 static inline u16 inw(unsigned long addr)
 {
 	return readw(PCI_IOBASE + addr);
 }
+#endif /* CONFIG_INDIRECT_PIO */
 #endif
 
 #ifndef inl
+#ifdef CONFIG_INDIRECT_PIO
+#define inl logic_inl
+#else
 #define inl inl
 static inline u32 inl(unsigned long addr)
 {
 	return readl(PCI_IOBASE + addr);
 }
+#endif /* CONFIG_INDIRECT_PIO */
 #endif
 
 #ifndef outb
+#ifdef CONFIG_INDIRECT_PIO
+#define outb logic_outb
+#else
 #define outb outb
 static inline void outb(u8 value, unsigned long addr)
 {
 	writeb(value, PCI_IOBASE + addr);
 }
+#endif /* CONFIG_INDIRECT_PIO */
 #endif
 
 #ifndef outw
+#ifdef CONFIG_INDIRECT_PIO
+#define outw logic_outw
+#else
 #define outw outw
 static inline void outw(u16 value, unsigned long addr)
 {
 	writew(value, PCI_IOBASE + addr);
 }
+#endif /* CONFIG_INDIRECT_PIO */
 #endif
 
 #ifndef outl
+#ifdef CONFIG_INDIRECT_PIO
+#define outl logic_outl
+#else
 #define outl outl
 static inline void outl(u32 value, unsigned long addr)
 {
 	writel(value, PCI_IOBASE + addr);
 }
+#endif /* CONFIG_INDIRECT_PIO */
 #endif
 
 #ifndef inb_p
diff --git a/include/linux/logic_pio.h b/include/linux/logic_pio.h
new file mode 100644
index 0000000..f0a6f15
--- /dev/null
+++ b/include/linux/logic_pio.h
@@ -0,0 +1,118 @@
+/*
+ * Copyright (C) 2017 Hisilicon Limited, All Rights Reserved.
+ * Author: Gabriele Paoloni <gabriele.paoloni@huawei.com>
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
+#ifndef __LINUX_LOGIC_PIO_H
+#define __LINUX_LOGIC_PIO_H
+
+#ifdef __KERNEL__
+
+#include <linux/fwnode.h>
+
+#define PIO_INDIRECT		0x01UL /* indirect IO flag */
+#define PIO_CPU_MMIO		0x00UL /* memory mapped io flag */
+
+struct logic_pio_hwaddr {
+	struct list_head list;
+	struct fwnode_handle *fwnode;
+	resource_size_t hw_start;
+	resource_size_t io_start;
+	resource_size_t size; /* range size populated */
+	unsigned long flags;
+
+	void *devpara;	/* private parameter of the host device */
+	struct hostio_ops *ops;	/* ops operating on this node */
+};
+
+struct hostio_ops {
+	u32 (*pfin)(void *devobj, unsigned long ptaddr,	size_t dlen);
+	void (*pfout)(void *devobj, unsigned long ptaddr, u32 outval,
+			size_t dlen);
+	u32 (*pfins)(void *devobj, unsigned long ptaddr, void *inbuf,
+			size_t dlen, unsigned int count);
+	void (*pfouts)(void *devobj, unsigned long ptaddr,
+			const void *outbuf, size_t dlen, unsigned int count);
+};
+
+#ifdef CONFIG_INDIRECT_PIO
+u8 logic_inb(unsigned long addr);
+void logic_outb(u8 value, unsigned long addr);
+void logic_outw(u16 value, unsigned long addr);
+void logic_outl(u32 value, unsigned long addr);
+u16 logic_inw(unsigned long addr);
+u32 logic_inl(unsigned long addr);
+void logic_outb(u8 value, unsigned long addr);
+void logic_outw(u16 value, unsigned long addr);
+void logic_outl(u32 value, unsigned long addr);
+void logic_insb(unsigned long addr, void *buffer, unsigned int count);
+void logic_insl(unsigned long addr, void *buffer, unsigned int count);
+void logic_insw(unsigned long addr, void *buffer, unsigned int count);
+void logic_outsb(unsigned long addr, const void *buffer, unsigned int count);
+void logic_outsw(unsigned long addr, const void *buffer, unsigned int count);
+void logic_outsl(unsigned long addr, const void *buffer, unsigned int count);
+
+#define insb logic_insb
+#define insw logic_insw
+#define insl logic_insl
+#define outsb logic_outsb
+#define outsw logic_outsw
+#define outsl logic_outsl
+
+/*
+ * Below we reserve 0x4000 bytes for Indirect IO as so far this library is only
+ * used by Hisilicon LPC Host. If needed in future we may reserve a wider IO
+ * area by redefining the macro below.
+ */
+#define PIO_INDIRECT_SIZE 0x4000
+#define MMIO_UPPER_LIMIT (IO_SPACE_LIMIT - PIO_INDIRECT_SIZE)
+#else
+#define MMIO_UPPER_LIMIT IO_SPACE_LIMIT
+#endif
+
+#ifdef CONFIG_LOGIC_PIO
+struct logic_pio_hwaddr *find_io_range_by_fwnode(struct fwnode_handle *fwnode);
+
+unsigned long logic_pio_trans_hwaddr(struct fwnode_handle *fwnode,
+			resource_size_t hw_addr, resource_size_t size);
+
+int logic_pio_register_range(struct logic_pio_hwaddr *newrange);
+#else
+static inline struct logic_pio_hwaddr
+*find_io_range_by_fwnode(struct fwnode_handle *fwnode)
+{
+	return NULL;
+}
+
+static inline unsigned long logic_pio_trans_hwaddr(struct fwnode_handle *fwnode,
+			resource_size_t hw_addr, resource_size_t size);
+{
+	return -1;
+}
+
+static inline struct logic_pio_hwaddr
+*logic_pio_register_range(struct logic_pio_hwaddr *newrange);
+{
+	return NULL;
+}
+#endif
+
+extern resource_size_t logic_pio_to_hwaddr(unsigned long pio);
+
+extern unsigned long logic_pio_trans_cpuaddr(resource_size_t hw_addr);
+
+#endif /* __KERNEL__ */
+#endif /* __LINUX_LOGIC_PIO_H */
diff --git a/lib/Kconfig b/lib/Kconfig
index 6762529..d7443a6 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -59,6 +59,32 @@ config ARCH_USE_CMPXCHG_LOCKREF
 config ARCH_HAS_FAST_MULTIPLIER
 	bool
 
+config LOGIC_PIO
+	bool "Generic logical I/O management"
+	def_bool y if PCI && !X86 && !IA64 && !POWERPC
+	help
+	  For some architectures, there are no IO space. To support the
+	  accesses to legacy I/O devices on those architectures, kernel
+	  implemented the memory mapped I/O mechanism based on bridge bus
+	  supports. But for some buses which do not support MMIO, the
+	  peripherals there should be accessed with device-specific way.
+	  To abstract those different I/O accesses into unified I/O accessors,
+	  this option provide a generic I/O space management way after mapping
+	  the device I/O to system logical/fake I/O and help to hide all the
+	  hardware detail.
+
+config INDIRECT_PIO
+	bool "Access I/O in non-MMIO mode" if LOGIC_PIO
+	help
+	  On some platforms where no separate I/O space exist, there are I/O
+	  hosts which can not be accessed in MMIO mode. Based on LOGIC_PIO
+	  mechanism, the host-local I/O resource can be mapped into system
+	  logic PIO space shared with MMIO hosts, such as PCI/PCIE, then system
+	  can access the I/O devices with the mapped logic PIO through I/O
+	  accessors.
+	  This way has a little I/O performance cost. Please make sure your
+	  devices really need this configure item enabled.
+
 config CRC_CCITT
 	tristate "CRC-CCITT functions"
 	help
diff --git a/lib/Makefile b/lib/Makefile
index 40c1837..e0246ad 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -77,6 +77,8 @@ obj-$(CONFIG_HAS_IOMEM) += iomap_copy.o devres.o
 obj-$(CONFIG_CHECK_SIGNATURE) += check_signature.o
 obj-$(CONFIG_DEBUG_LOCKING_API_SELFTESTS) += locking-selftest.o
 
+obj-$(CONFIG_LOGIC_PIO) += logic_pio.o
+
 obj-$(CONFIG_GENERIC_HWEIGHT) += hweight.o
 
 obj-$(CONFIG_BTREE) += btree.o
diff --git a/lib/logic_pio.c b/lib/logic_pio.c
new file mode 100644
index 0000000..f8427cb
--- /dev/null
+++ b/lib/logic_pio.c
@@ -0,0 +1,286 @@
+/*
+ * Copyright (C) 2017 Hisilicon Limited, All Rights Reserved.
+ * Author: Gabriele Paoloni <gabriele.paoloni@huawei.com>
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
+#include <linux/of.h>
+#include <linux/io.h>
+#include <linux/logic_pio.h>
+#include <linux/mm.h>
+#include <linux/rculist.h>
+#include <linux/sizes.h>
+#include <linux/slab.h>
+
+/* The unique hardware address list. */
+static LIST_HEAD(io_range_list);
+static DEFINE_MUTEX(io_range_mutex);
+
+/*
+ * register a new io range node in the io range list.
+ *
+ * @newrange: pointer to the io range to be registered.
+ *
+ * returns 0 on success, the error code in case of failure
+ */
+int logic_pio_register_range(struct logic_pio_hwaddr *new_range)
+{
+	struct logic_pio_hwaddr *range;
+	int ret = 0;
+	resource_size_t start = new_range->hw_start;
+	resource_size_t end = new_range->hw_start + new_range->size;
+	resource_size_t allocated_mmio_size = 0;
+	resource_size_t allocated_iio_size = MMIO_UPPER_LIMIT;
+
+	if (!new_range || !new_range->fwnode || !new_range->size)
+		return -EINVAL;
+
+	mutex_lock(&io_range_mutex);
+	list_for_each_entry_rcu(range, &io_range_list, list) {
+
+		if (range->fwnode == new_range->fwnode) {
+			/* range already there */
+			ret = -EFAULT;
+			goto end_register;
+		}
+		if (range->flags == PIO_CPU_MMIO &&
+				new_range->flags == PIO_CPU_MMIO) {
+			/* for MMIO ranges we need to check for overlap */
+			if (start >= range->hw_start + range->size ||
+				end < range->hw_start)
+				allocated_mmio_size += range->size;
+			else {
+				ret = -EFAULT;
+				goto end_register;
+			}
+		} else if (range->flags == PIO_INDIRECT &&
+				new_range->flags == PIO_INDIRECT) {
+			allocated_iio_size += range->size;
+		}
+	}
+
+	/* range not registered yet, check for available space */
+	if (new_range->flags == PIO_CPU_MMIO) {
+
+		if (allocated_mmio_size + new_range->size - 1 >
+			MMIO_UPPER_LIMIT) {
+			/* if it's too big check if 64K space can be reserved */
+			if (allocated_mmio_size + SZ_64K - 1 >
+			MMIO_UPPER_LIMIT) {
+				ret = -E2BIG;
+				goto end_register;
+			}
+			new_range->size = SZ_64K;
+			pr_warn("Requested IO range too big, new size set to 64K\n");
+		}
+
+		new_range->io_start = allocated_mmio_size;
+
+	} else if (new_range->flags == PIO_INDIRECT) {
+
+		if (allocated_iio_size + new_range->size - 1 >
+		IO_SPACE_LIMIT) {
+			ret = -E2BIG;
+			goto end_register;
+		}
+		new_range->io_start = allocated_iio_size;
+
+	} else {
+		/* invalid flag */
+		ret = -EINVAL;
+		goto end_register;
+	}
+
+	list_add_tail_rcu(&new_range->list, &io_range_list);
+
+end_register:
+	mutex_unlock(&io_range_mutex);
+	return ret;
+}
+
+/*
+ * traverse the io_range_list to find the registered node whose device node
+ * and/or physical IO address match to.
+ */
+struct logic_pio_hwaddr *find_io_range_by_fwnode(struct fwnode_handle *fwnode)
+{
+	struct logic_pio_hwaddr *range;
+
+	list_for_each_entry_rcu(range, &io_range_list, list) {
+		if (range->fwnode == fwnode)
+			return range;
+	}
+	return NULL;
+}
+
+/* return a registered range given an input PIO token */
+static struct logic_pio_hwaddr *find_io_range(unsigned long pio)
+{
+	struct logic_pio_hwaddr *range;
+
+	list_for_each_entry_rcu(range, &io_range_list, list) {
+		if (pio >= range->io_start &&
+				pio < range->io_start + range->size)
+			return range;
+	}
+	pr_err("PIO entry token invalid\n");
+	return NULL;
+}
+
+/*
+ * Translate the input logical pio to the corresponding hardware address.
+ * The input pio should be unique in the whole logical PIO space.
+ */
+resource_size_t logic_pio_to_hwaddr(unsigned long pio)
+{
+	struct logic_pio_hwaddr *range;
+	resource_size_t hwaddr = -1;
+
+	range = find_io_range(pio);
+	if (range)
+		hwaddr = range->hw_start + pio - range->io_start;
+
+	return hwaddr;
+}
+
+/*
+ * This function is generic for translating a hardware address to logical PIO.
+ * @hw_addr: the hardware address of host, can be CPU address or host-local
+ *		address;
+ */
+unsigned long
+logic_pio_trans_hwaddr(struct fwnode_handle *fwnode, resource_size_t addr,
+		       resource_size_t size)
+{
+	struct logic_pio_hwaddr *range;
+
+	range = find_io_range_by_fwnode(fwnode);
+	if (!range || range->flags == PIO_CPU_MMIO) {
+		pr_err("range not found or invalid\n");
+		return -1;
+	}
+	if (range->size < size) {
+		pr_err("resource size 0x%llx cannot fit in IO range size 0x%llx\n",
+		       size, range->size);
+		return -1;
+	}
+	return addr - range->hw_start + range->io_start;
+}
+
+unsigned long
+logic_pio_trans_cpuaddr(resource_size_t addr)
+{
+	struct logic_pio_hwaddr *range;
+
+	list_for_each_entry_rcu(range, &io_range_list, list) {
+		if (range->flags != PIO_CPU_MMIO)
+			continue;
+		if (addr >= range->hw_start &&
+			addr < range->hw_start + range->size)
+			return addr - range->hw_start +
+				range->io_start;
+	}
+	pr_err("addr not registered in io_range_list\n");
+	return -1;
+}
+
+#if defined(CONFIG_INDIRECT_PIO) && defined(PCI_IOBASE)
+#define BUILD_LOGIC_IO(bw, type)					\
+type logic_in##bw(unsigned long addr)					\
+{									\
+	type ret = -1;							\
+									\
+	if (addr < MMIO_UPPER_LIMIT) {					\
+		ret = read##bw(PCI_IOBASE + addr);			\
+	} else {							\
+		struct logic_pio_hwaddr *entry = find_io_range(addr);	\
+									\
+		if (entry && entry->ops)				\
+			ret = entry->ops->pfin(entry->devpara,		\
+					addr, sizeof(type));		\
+		else							\
+			WARN_ON_ONCE(1);				\
+	}								\
+	return ret;							\
+}									\
+									\
+void logic_out##bw(type value, unsigned long addr)			\
+{									\
+	if (addr < MMIO_UPPER_LIMIT) {					\
+		write##bw(value, PCI_IOBASE + addr);			\
+	} else {							\
+		struct logic_pio_hwaddr *entry = find_io_range(addr);	\
+									\
+		if (entry && entry->ops)				\
+			entry->ops->pfout(entry->devpara,		\
+					addr, value, sizeof(type));	\
+		else							\
+			WARN_ON_ONCE(1);				\
+	}								\
+}									\
+									\
+void logic_ins##bw(unsigned long addr, void *buffer, unsigned int count)\
+{									\
+	if (addr < MMIO_UPPER_LIMIT) {					\
+		reads##bw(PCI_IOBASE + addr, buffer, count);		\
+	} else {							\
+		struct logic_pio_hwaddr *entry = find_io_range(addr);	\
+									\
+		if (entry && entry->ops)				\
+			entry->ops->pfins(entry->devpara,		\
+				addr, buffer, sizeof(type), count);	\
+		else							\
+			WARN_ON_ONCE(1);				\
+	}								\
+									\
+}									\
+									\
+void logic_outs##bw(unsigned long addr, const void *buffer,		\
+		    unsigned int count)					\
+{									\
+	if (addr < MMIO_UPPER_LIMIT)					\
+		writes##bw(PCI_IOBASE + addr, buffer, count);		\
+	else {								\
+		struct logic_pio_hwaddr *entry = find_io_range(addr);	\
+									\
+		if (entry && entry->ops)				\
+			entry->ops->pfouts(entry->devpara,		\
+				addr, buffer, sizeof(type), count);	\
+		else							\
+			WARN_ON_ONCE(1);				\
+	}								\
+}
+
+BUILD_LOGIC_IO(b, u8)
+
+EXPORT_SYMBOL(logic_inb);
+EXPORT_SYMBOL(logic_outb);
+EXPORT_SYMBOL(logic_insb);
+EXPORT_SYMBOL(logic_outsb);
+
+BUILD_LOGIC_IO(w, u16)
+
+EXPORT_SYMBOL(logic_inw);
+EXPORT_SYMBOL(logic_outw);
+EXPORT_SYMBOL(logic_insw);
+EXPORT_SYMBOL(logic_outsw);
+
+BUILD_LOGIC_IO(l, u32)
+
+EXPORT_SYMBOL(logic_inl);
+EXPORT_SYMBOL(logic_outl);
+EXPORT_SYMBOL(logic_insl);
+EXPORT_SYMBOL(logic_outsl);
+#endif /* CONFIG_INDIRECT_PIO && PCI_IOBASE */
-- 
2.7.4


