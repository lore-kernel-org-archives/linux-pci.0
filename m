Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "zhichang.yuan" <yuanzhichang@hisilicon.com>
To: <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <robh+dt@kernel.org>, <frowand.list@gmail.com>,
        <bhelgaas@google.com>, <rafael@kernel.org>, <mark.rutland@arm.com>,
        <rjw@rjwysocki.net>, <arnd@arndb.de>,
        <linux-arm-kernel@lists.infradead.org>
CC: <linux-acpi@vger.kernel.org>, <lorenzo.pieralisi@arm.com>,
        <benh@kernel.crashing.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <minyard@acm.org>, <liviu.dudau@arm.com>, <zourongrong@gmail.com>,
        <john.garry@huawei.com>, <gabriele.paoloni@huawei.com>,
        <zhichang.yuan02@gmail.com>, <kantyzc@163.com>,
        <xuwei5@hisilicon.com>,
        "zhichang.yuan" <yuanzhichang@hisilicon.com>
Subject: [PATCH V7 1/7] LIBIO: Introduce a generic PIO mapping method
Date: Mon, 13 Mar 2017 10:42:37 +0800
Message-ID: <1489372963-9000-2-git-send-email-yuanzhichang@hisilicon.com>
In-Reply-To: <1489372963-9000-1-git-send-email-yuanzhichang@hisilicon.com>
References: <1489372963-9000-1-git-send-email-yuanzhichang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In commit 41f8bba7f55(of/pci: Add pci_register_io_range() and
pci_pio_to_address()), a new I/O space management was supported. With that
driver, the I/O ranges configured for PCI/PCIE hosts on some architectures can
be mapped to logical PIO, converted easily between CPU address and the
corresponding logicial PIO. Based on this, PCI I/O devices can be accessed in a
memory read/write way through the unified in/out accessors.

But on some archs/platforms, there are bus hosts which access I/O peripherals
with host-local I/O port addresses rather than memory addresses after
memory-mapped.
To support those devices, a more generic I/O mapping method is introduced here.
Through this patch, both the CPU addresses and the host-local port can be
mapped into logical PIO, then all the I/O accesses to either PCI MMIO devices or
host-local I/O peripherals can be unified into the existing I/O accessors
defined asm-generic/io.h and be redirected to the right device-specific hooks
based on the input logical PIO.

Signed-off-by: zhichang.yuan <yuanzhichang@hisilicon.com>
Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
---
 include/asm-generic/io.h |  50 ++++++++
 include/linux/io.h       |   1 +
 include/linux/libio.h    |  94 ++++++++++++++
 lib/Kconfig              |  14 ++
 lib/Makefile             |   2 +
 lib/libio.c              | 324 +++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 485 insertions(+)
 create mode 100644 include/linux/libio.h
 create mode 100644 lib/libio.c

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 7ef015e..91a7ed4 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -21,6 +21,8 @@
 
 #include <asm-generic/pci_iomap.h>
 
+#include <linux/libio.h>
+
 #ifndef mmiowb
 #define mmiowb() do {} while (0)
 #endif
@@ -358,51 +360,75 @@ static inline void writesq(volatile void __iomem *addr, const void *buffer,
  */
 
 #ifndef inb
+#ifdef CONFIG_LIBIO
+#define inb libio_inb
+#else
 #define inb inb
 static inline u8 inb(unsigned long addr)
 {
 	return readb(PCI_IOBASE + addr);
 }
+#endif /* CONFIG_LIBIO */
 #endif
 
 #ifndef inw
+#ifdef CONFIG_LIBIO
+#define inw libio_inw
+#else
 #define inw inw
 static inline u16 inw(unsigned long addr)
 {
 	return readw(PCI_IOBASE + addr);
 }
+#endif /* CONFIG_LIBIO */
 #endif
 
 #ifndef inl
+#ifdef CONFIG_LIBIO
+#define inl libio_inl
+#else
 #define inl inl
 static inline u32 inl(unsigned long addr)
 {
 	return readl(PCI_IOBASE + addr);
 }
+#endif /* CONFIG_LIBIO */
 #endif
 
 #ifndef outb
+#ifdef CONFIG_LIBIO
+#define outb libio_outb
+#else
 #define outb outb
 static inline void outb(u8 value, unsigned long addr)
 {
 	writeb(value, PCI_IOBASE + addr);
 }
+#endif /* CONFIG_LIBIO */
 #endif
 
 #ifndef outw
+#ifdef CONFIG_LIBIO
+#define outw libio_outw
+#else
 #define outw outw
 static inline void outw(u16 value, unsigned long addr)
 {
 	writew(value, PCI_IOBASE + addr);
 }
+#endif /* CONFIG_LIBIO */
 #endif
 
 #ifndef outl
+#ifdef CONFIG_LIBIO
+#define outl libio_outl
+#else
 #define outl outl
 static inline void outl(u32 value, unsigned long addr)
 {
 	writel(value, PCI_IOBASE + addr);
 }
+#endif /* CONFIG_LIBIO */
 #endif
 
 #ifndef inb_p
@@ -459,54 +485,78 @@ static inline void outl_p(u32 value, unsigned long addr)
  */
 
 #ifndef insb
+#ifdef CONFIG_LIBIO
+#define insb libio_insb
+#else
 #define insb insb
 static inline void insb(unsigned long addr, void *buffer, unsigned int count)
 {
 	readsb(PCI_IOBASE + addr, buffer, count);
 }
+#endif /* CONFIG_LIBIO */
 #endif
 
 #ifndef insw
+#ifdef CONFIG_LIBIO
+#define insw libio_insw
+#else
 #define insw insw
 static inline void insw(unsigned long addr, void *buffer, unsigned int count)
 {
 	readsw(PCI_IOBASE + addr, buffer, count);
 }
+#endif /* CONFIG_LIBIO */
 #endif
 
 #ifndef insl
+#ifdef CONFIG_LIBIO
+#define insl libio_insl
+#else
 #define insl insl
 static inline void insl(unsigned long addr, void *buffer, unsigned int count)
 {
 	readsl(PCI_IOBASE + addr, buffer, count);
 }
+#endif /* CONFIG_LIBIO */
 #endif
 
 #ifndef outsb
+#ifdef CONFIG_LIBIO
+#define outsb libio_outsb
+#else
 #define outsb outsb
 static inline void outsb(unsigned long addr, const void *buffer,
 			 unsigned int count)
 {
 	writesb(PCI_IOBASE + addr, buffer, count);
 }
+#endif /* CONFIG_LIBIO */
 #endif
 
 #ifndef outsw
+#ifdef CONFIG_LIBIO
+#define outsw libio_outsw
+#else
 #define outsw outsw
 static inline void outsw(unsigned long addr, const void *buffer,
 			 unsigned int count)
 {
 	writesw(PCI_IOBASE + addr, buffer, count);
 }
+#endif /* CONFIG_LIBIO */
 #endif
 
 #ifndef outsl
+#ifdef CONFIG_LIBIO
+#define outsl libio_outsl
+#else
 #define outsl outsl
 static inline void outsl(unsigned long addr, const void *buffer,
 			 unsigned int count)
 {
 	writesl(PCI_IOBASE + addr, buffer, count);
 }
+#endif /* CONFIG_LIBIO */
 #endif
 
 #ifndef insb_p
diff --git a/include/linux/io.h b/include/linux/io.h
index 82ef36e..51ec1aa 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -24,6 +24,7 @@
 #include <linux/err.h>
 #include <asm/io.h>
 #include <asm/page.h>
+#include <linux/libio.h>
 
 struct device;
 struct resource;
diff --git a/include/linux/libio.h b/include/linux/libio.h
new file mode 100644
index 0000000..91038aa
--- /dev/null
+++ b/include/linux/libio.h
@@ -0,0 +1,94 @@
+/*
+ * Copyright (C) 2017 Hisilicon Limited, All Rights Reserved.
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
+#ifndef __LINUX_LIBIO_H
+#define __LINUX_LIBIO_H
+
+#ifdef __KERNEL__
+
+#include <linux/fwnode.h>
+
+/* This is compatible to PCI MMIO. */
+#define IO_CPU_MMIO		0x01
+/* All hosts where there are no CPU addr */
+#define IO_HOST_INDIRECT	0x02
+
+struct libio_range {
+	struct list_head list;
+	struct fwnode_handle *node;
+	resource_size_t size; /* range size populated */
+	resource_size_t io_start;	/* logical pio start. inclusive */
+	resource_size_t hw_start;
+	unsigned long flags;
+	void *devpara;	/* private parameter of the host device */
+	struct libio_ops *ops;	/* ops operating on this node */
+};
+
+struct libio_ops {
+	u32 (*pfin)(void *devobj, unsigned long ptaddr,	size_t dlen);
+	void (*pfout)(void *devobj, unsigned long ptaddr, u32 outval,
+			size_t dlen);
+	u32 (*pfins)(void *devobj, unsigned long ptaddr, void *inbuf,
+			size_t dlen, unsigned int count);
+	void (*pfouts)(void *devobj, unsigned long ptaddr,
+			const void *outbuf, size_t dlen, unsigned int count);
+};
+
+extern u8 libio_inb(unsigned long addr);
+extern void libio_outb(u8 value, unsigned long addr);
+extern void libio_outw(u16 value, unsigned long addr);
+extern void libio_outl(u32 value, unsigned long addr);
+extern u16 libio_inw(unsigned long addr);
+extern u32 libio_inl(unsigned long addr);
+extern void libio_outb(u8 value, unsigned long addr);
+extern void libio_outw(u16 value, unsigned long addr);
+extern void libio_outl(u32 value, unsigned long addr);
+extern void libio_insb(unsigned long addr, void *buffer, unsigned int count);
+extern void libio_insl(unsigned long addr, void *buffer, unsigned int count);
+extern void libio_insw(unsigned long addr, void *buffer, unsigned int count);
+extern void libio_outsb(unsigned long addr, const void *buffer,
+			unsigned int count);
+extern void libio_outsw(unsigned long addr, const void *buffer,
+			unsigned int count);
+extern void libio_outsl(unsigned long addr, const void *buffer,
+			unsigned int count);
+#ifdef CONFIG_LIBIO
+extern struct libio_range
+*find_io_range_from_fwnode(struct fwnode_handle *fwnode);
+extern unsigned long libio_translate_hwaddr(struct fwnode_handle *fwnode,
+			resource_size_t hw_addr);
+#else
+static inline struct libio_range
+*find_io_range_from_fwnode(struct fwnode_handle *fwnode)
+{
+	return NULL;
+}
+
+static inline unsigned long libio_translate_hwaddr(struct fwnode_handle *fwnode,
+			resource_size_t hw_addr)
+{
+	return -1;
+}
+#endif
+
+extern struct libio_range *register_libio_range(struct libio_range *newrange);
+extern resource_size_t libio_to_hwaddr(unsigned long pio);
+
+extern unsigned long libio_translate_cpuaddr(resource_size_t hw_addr);
+
+#endif /* __KERNEL__ */
+#endif /* __LINUX_LIBIO_H */
diff --git a/lib/Kconfig b/lib/Kconfig
index 0c8b78a..ba9787d5 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -59,6 +59,20 @@ config ARCH_USE_CMPXCHG_LOCKREF
 config ARCH_HAS_FAST_MULTIPLIER
 	bool
 
+config LIBIO
+	bool "Generic logical IO management"
+	def_bool y if PCI && (ARM || ARC || UNICORE32 || SPARC || S390 || CRIS || BLACKFIN || XTENSA || ARM64)
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
 config CRC_CCITT
 	tristate "CRC-CCITT functions"
 	help
diff --git a/lib/Makefile b/lib/Makefile
index 320ac46a..9c4cd24 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -77,6 +77,8 @@ obj-$(CONFIG_HAS_IOMEM) += iomap_copy.o devres.o
 obj-$(CONFIG_CHECK_SIGNATURE) += check_signature.o
 obj-$(CONFIG_DEBUG_LOCKING_API_SELFTESTS) += locking-selftest.o
 
+obj-$(CONFIG_LIBIO) += libio.o
+
 obj-$(CONFIG_GENERIC_HWEIGHT) += hweight.o
 
 obj-$(CONFIG_BTREE) += btree.o
diff --git a/lib/libio.c b/lib/libio.c
new file mode 100644
index 0000000..e42f50b
--- /dev/null
+++ b/lib/libio.c
@@ -0,0 +1,324 @@
+/*
+ * Copyright (C) 2017 Hisilicon Limited, All Rights Reserved.
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
+#include <linux/mm.h>
+#include <linux/rculist.h>
+#include <linux/sizes.h>
+#include <linux/slab.h>
+
+/* A list of all the IO hosts registered. ONLY THE HOST nodes. */
+static LIST_HEAD(io_range_list);
+static DEFINE_MUTEX(io_range_mutex);
+
+/*
+ * allocate a free range for this registration.
+ *
+ * @new_range: point to the node awaiting this registration.
+ *		part of the fields are as input parameters. This node
+ *		is allocated and initialized by caller;
+ * @prev: points to the last node before the return;
+ *
+ * return 0 for success, other are fail.
+ */
+static int libio_alloc_range(struct libio_range *new_range,
+		struct list_head **prev)
+{
+	struct libio_range *entry;
+	unsigned long align = 1;
+	unsigned long tmp_start;
+	unsigned long idle_start, idle_end;
+
+	if (new_range->flags & IO_CPU_MMIO)
+		align = PAGE_SIZE;
+	idle_start = 0;
+	*prev = &io_range_list;
+	list_for_each_entry_rcu(entry, &io_range_list, list) {
+		if (idle_start > entry->io_start) {
+			WARN(1, "skip an invalid io range during traversal!\n");
+			goto nextentry;
+		}
+		/* set the end edge. */
+		if (idle_start == entry->io_start) {
+			struct libio_range *next;
+
+			idle_start = entry->io_start + entry->size;
+			next = list_next_or_null_rcu(&io_range_list,
+				&entry->list, struct libio_range, list);
+			if (next) {
+				entry = next;
+			} else {
+				*prev = &entry->list;
+				break;
+			}
+		}
+		idle_end = entry->io_start - 1;
+
+		/* contiguous range... */
+		if (idle_start > idle_end)
+			goto nextentry;
+
+		tmp_start = idle_start;
+		idle_start = ALIGN(idle_start, align);
+		if (idle_start >= tmp_start &&
+			idle_start + new_range->size <= idle_end) {
+			new_range->io_start = idle_start;
+			*prev = &entry->list;
+			return 0;
+		}
+
+nextentry:
+		idle_start = entry->io_start + entry->size;
+		*prev = &entry->list;
+	}
+	/* check the last free gap... */
+	idle_end = IO_SPACE_LIMIT;
+
+	tmp_start = idle_start;
+	idle_start = ALIGN(idle_start, align);
+	if (idle_start >= tmp_start &&
+		idle_start + new_range->size <= idle_end) {
+		new_range->io_start = idle_start;
+		return 0;
+	}
+
+	return -EBUSY;
+}
+
+/*
+ * traverse the io_range_list to find the registered node whose device node
+ * and/or physical IO address match to.
+ */
+struct libio_range *find_io_range_from_fwnode(struct fwnode_handle *fwnode)
+{
+	struct libio_range *range;
+
+	list_for_each_entry_rcu(range, &io_range_list, list) {
+		if (range->node == fwnode)
+			return range;
+	}
+	return NULL;
+}
+
+/*
+ * Search a io_range registered which match the fwnode and addr.
+ *
+ * @fwnode: the host fwnode which must be valid;
+ * @start: the start hardware address of this search;
+ * @end: the end hardware address of this search. can be equal to @start;
+ *
+ * return NULL when there is no matched node; IS_ERR() means ERROR;
+ * valid virtual address represent a matched node was found.
+ */
+static struct libio_range *
+libio_find_range_byaddr(struct fwnode_handle *fwnode,
+			resource_size_t start, resource_size_t end)
+{
+	struct libio_range *entry;
+
+	list_for_each_entry_rcu(entry, &io_range_list, list) {
+		if (entry->node != fwnode)
+			continue;
+		/* without any overlap with current range */
+		if (start >= entry->hw_start + entry->size ||
+			end < entry->hw_start)
+			continue;
+		/* overlap is not supported now. */
+		if (start < entry->hw_start ||
+			end >= entry->hw_start + entry->size)
+			return ERR_PTR(-EBUSY);
+		/* had been registered. */
+		return entry;
+	}
+
+	return NULL;
+}
+
+/*
+ * register a io range node in the io range list.
+ *
+ * @newrange: pointer to the io range to be registered.
+ *
+ * return 'newrange' when success, ERR_VALUE() is for failures.
+ * specially, return a valid pointer which is not equal to 'newrange' when
+ * the io range had been registered before.
+ */
+struct libio_range *register_libio_range(struct libio_range *newrange)
+{
+	int err;
+	struct libio_range *range;
+	struct list_head *prev;
+
+	if (!newrange || !newrange->node || !newrange->size)
+		return ERR_PTR(-EINVAL);
+
+	mutex_lock(&io_range_mutex);
+	range = libio_find_range_byaddr(newrange->node, newrange->hw_start,
+			newrange->hw_start + newrange->size - 1);
+	if (range) {
+		if (!IS_ERR(range))
+			pr_info("the request IO range had been registered!\n");
+		else
+			pr_err("registering IO[%pa - sz%pa) got failed!\n",
+				&newrange->hw_start, &newrange->size);
+		return range;
+	}
+
+	err = libio_alloc_range(newrange, &prev);
+	if (!err)
+		/* the bus IO range list is ordered by pio. */
+		list_add_rcu(&newrange->list, prev);
+	else
+		pr_err("can't find free %pa logical IO range!\n",
+			&newrange->size);
+
+	mutex_unlock(&io_range_mutex);
+	return err ? ERR_PTR(err) : newrange;
+}
+
+/*
+ * Translate the input logical pio to the corresponding hardware address.
+ * The input pio should be unique in the whole logical PIO space.
+ */
+resource_size_t libio_to_hwaddr(unsigned long pio)
+{
+	struct libio_range *range;
+
+	list_for_each_entry_rcu(range, &io_range_list, list) {
+		if (pio < range->io_start)
+			break;
+
+		if (pio < range->io_start + range->size)
+			return pio - range->io_start + range->hw_start;
+	}
+
+	return -1;
+}
+
+/*
+ * This function is generic for translating a hardware address to logical PIO.
+ * @hw_addr: the hardware address of host, can be CPU address or host-local
+ *		address;
+ */
+unsigned long
+libio_translate_hwaddr(struct fwnode_handle *fwnode, resource_size_t addr)
+{
+	struct libio_range *range;
+
+	range = libio_find_range_byaddr(fwnode, addr, addr);
+	if (!range)
+		return -1;
+
+	return addr - range->hw_start + range->io_start;
+}
+
+unsigned long
+libio_translate_cpuaddr(resource_size_t addr)
+{
+	struct libio_range *range;
+
+	list_for_each_entry_rcu(range, &io_range_list, list) {
+		if (!(range->flags & IO_CPU_MMIO))
+			continue;
+		if (addr >= range->hw_start &&
+			addr < range->hw_start + range->size)
+			return addr - range->hw_start + range->io_start;
+	}
+	return -1;
+}
+
+#ifdef PCI_IOBASE
+static struct libio_range *find_io_range(unsigned long pio)
+{
+	struct libio_range *range;
+
+	list_for_each_entry_rcu(range, &io_range_list, list) {
+		if (range->io_start > pio)
+			return NULL;
+		if (pio < range->io_start + range->size)
+			return range;
+	}
+	return NULL;
+}
+
+#define BUILD_IO(bw, type)						\
+type libio_in##bw(unsigned long addr)					\
+{									\
+	struct libio_range *entry = find_io_range(addr);		\
+									\
+	if (entry && entry->ops)					\
+		return entry->ops->pfin(entry->devpara,			\
+					addr, sizeof(type));		\
+	return read##bw(PCI_IOBASE + addr);				\
+}									\
+									\
+void libio_out##bw(type value, unsigned long addr)			\
+{									\
+	struct libio_range *entry = find_io_range(addr);		\
+									\
+	if (entry && entry->ops)					\
+		entry->ops->pfout(entry->devpara,			\
+					addr, value, sizeof(type));	\
+	else								\
+		write##bw(value, PCI_IOBASE + addr);			\
+}									\
+									\
+void libio_ins##bw(unsigned long addr, void *buffer, unsigned int count)\
+{									\
+	struct libio_range *entry = find_io_range(addr);		\
+									\
+	if (entry && entry->ops)					\
+		entry->ops->pfins(entry->devpara,			\
+				addr, buffer, sizeof(type), count);	\
+	else								\
+		reads##bw(PCI_IOBASE + addr, buffer, count);		\
+}									\
+									\
+void libio_outs##bw(unsigned long addr, const void *buffer,		\
+		    unsigned int count)					\
+{									\
+	struct libio_range *entry = find_io_range(addr);		\
+									\
+	if (entry && entry->ops)					\
+		entry->ops->pfouts(entry->devpara,			\
+				addr, buffer, sizeof(type), count);	\
+	else								\
+		writes##bw(PCI_IOBASE + addr, buffer, count);	\
+}
+
+BUILD_IO(b, u8)
+
+EXPORT_SYMBOL(libio_inb);
+EXPORT_SYMBOL(libio_outb);
+EXPORT_SYMBOL(libio_insb);
+EXPORT_SYMBOL(libio_outsb);
+
+BUILD_IO(w, u16)
+
+EXPORT_SYMBOL(libio_inw);
+EXPORT_SYMBOL(libio_outw);
+EXPORT_SYMBOL(libio_insw);
+EXPORT_SYMBOL(libio_outsw);
+
+BUILD_IO(l, u32)
+
+EXPORT_SYMBOL(libio_inl);
+EXPORT_SYMBOL(libio_outl);
+EXPORT_SYMBOL(libio_insl);
+EXPORT_SYMBOL(libio_outsl);
+#endif /* PCI_IOBASE */
-- 
1.9.1

