Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: "zhichang.yuan" <yuanzhichang@hisilicon.com>
To: <catalin.marinas@arm.com>, <will.deacon@arm.com>, <robh+dt@kernel.org>,
 <frowand.list@gmail.com>, <bhelgaas@google.com>, <rafael@kernel.org>,
 <arnd@arndb.de>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH V8 1/6] LIBIO: Introduce a generic PIO mapping method
Date: Thu, 30 Mar 2017 23:26:54 +0800
Message-ID: <1490887619-61732-2-git-send-email-yuanzhichang@hisilicon.com>
In-Reply-To: <1490887619-61732-1-git-send-email-yuanzhichang@hisilicon.com>
References: <1490887619-61732-1-git-send-email-yuanzhichang@hisilicon.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com,
 gabriele.paoloni@huawei.com, minyard@acm.org, benh@kernel.crashing.org,
 john.garry@huawei.com, linux-kernel@vger.kernel.org, xuwei5@hisilicon.com,
 linuxarm@huawei.com, "zhichang.yuan" <yuanzhichang@hisilicon.com>,
 linux-acpi@vger.kernel.org, zourongrong@gmail.com, linux-pci@vger.kernel.org,
 olof@lixom.net, zhichang.yuan02@gmail.com, kantyzc@163.com,
 brian.starkey@arm.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
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
mapped into the logical PIO space with different logical/fake PIOs. After this,
all the I/O accesses to either PCI MMIO devices or host-local I/O peripherals
can be unified into the existing I/O accessors defined in asm-generic/io.h and
be redirected to the right device-specific hooks based on the input logical PIO.

Signed-off-by: zhichang.yuan <yuanzhichang@hisilicon.com>
Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
---
 include/asm-generic/io.h  |  50 ++++++
 include/linux/logic_pio.h | 174 +++++++++++++++++++
 lib/Kconfig               |  26 +++
 lib/Makefile              |   2 +
 lib/logic_pio.c           | 413 ++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 665 insertions(+)
 create mode 100644 include/linux/logic_pio.h
 create mode 100644 lib/logic_pio.c

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 7ef015e..f7fbec3 100644
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
@@ -459,54 +485,78 @@ static inline void outl_p(u32 value, unsigned long addr)
  */
 
 #ifndef insb
+#ifdef CONFIG_INDIRECT_PIO
+#define insb logic_insb
+#else
 #define insb insb
 static inline void insb(unsigned long addr, void *buffer, unsigned int count)
 {
 	readsb(PCI_IOBASE + addr, buffer, count);
 }
+#endif /* CONFIG_INDIRECT_PIO */
 #endif
 
 #ifndef insw
+#ifdef CONFIG_INDIRECT_PIO
+#define insw logic_insw
+#else
 #define insw insw
 static inline void insw(unsigned long addr, void *buffer, unsigned int count)
 {
 	readsw(PCI_IOBASE + addr, buffer, count);
 }
+#endif /* CONFIG_INDIRECT_PIO */
 #endif
 
 #ifndef insl
+#ifdef CONFIG_INDIRECT_PIO
+#define insl logic_insl
+#else
 #define insl insl
 static inline void insl(unsigned long addr, void *buffer, unsigned int count)
 {
 	readsl(PCI_IOBASE + addr, buffer, count);
 }
+#endif /* CONFIG_INDIRECT_PIO */
 #endif
 
 #ifndef outsb
+#ifdef CONFIG_INDIRECT_PIO
+#define outsb logic_outsb
+#else
 #define outsb outsb
 static inline void outsb(unsigned long addr, const void *buffer,
 			 unsigned int count)
 {
 	writesb(PCI_IOBASE + addr, buffer, count);
 }
+#endif /* CONFIG_INDIRECT_PIO */
 #endif
 
 #ifndef outsw
+#ifdef CONFIG_INDIRECT_PIO
+#define outsw logic_outsw
+#else
 #define outsw outsw
 static inline void outsw(unsigned long addr, const void *buffer,
 			 unsigned int count)
 {
 	writesw(PCI_IOBASE + addr, buffer, count);
 }
+#endif /* CONFIG_INDIRECT_PIO */
 #endif
 
 #ifndef outsl
+#ifdef CONFIG_INDIRECT_PIO
+#define outsl logic_outsl
+#else
 #define outsl outsl
 static inline void outsl(unsigned long addr, const void *buffer,
 			 unsigned int count)
 {
 	writesl(PCI_IOBASE + addr, buffer, count);
 }
+#endif /* CONFIG_INDIRECT_PIO */
 #endif
 
 #ifndef insb_p
diff --git a/include/linux/logic_pio.h b/include/linux/logic_pio.h
new file mode 100644
index 0000000..e9f5644
--- /dev/null
+++ b/include/linux/logic_pio.h
@@ -0,0 +1,174 @@
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
+/*
+ *		Total IO space is 0 to IO_SPACE_LIMIT
+ *
+ *    section			pio
+ * |________|________________________________________|
+ *
+ * In this division, the benefits are:
+ * 1) The MMIO PIO space is consecutive, then ioport_map() still works well
+ * for MMIO;
+ * 2) The search happened in inX/outX with input PIO will have better
+ * performance for indirect_IO. For MMIO, the performance is nearly same
+ * even when CONFIG_INDIRECT_PIO is enabled;
+ *
+ * Some notes:
+ * 1) Don't increase the IO_SPACE_LIMIT to avoid modification on so many
+ * architectural files;
+ * 2) To reduce the impact on the original I/O space to a minimum, we only
+ * apply this IO space division when CONFIG_INDIRECT_PIO is enabled; And
+ * only allocate the last section to INDIRECT_PIO, all the other PIO space are
+ * for MMIO;
+ * 3) For better efficiency, one more I/O segment can be separated from 'pio'
+ * bit section. But it will make the IO space size decreased. Won't apply at
+ * this moment;
+ */
+#ifdef CONFIG_INDIRECT_PIO
+#define PIO_SECT_BITS		2
+#else
+#define PIO_SECT_BITS		0
+#endif
+#define PIO_MAX_SECT		(0x01UL << PIO_SECT_BITS)
+#define PIO_SECT_MASK		(PIO_MAX_SECT - 1)
+
+/* The last section. */
+#define PIO_INDIRECT		(PIO_MAX_SECT - 1)
+/* This one is for MMIO(PCI) to keep compatibility */
+#define PIO_CPU_MMIO		0x00UL
+
+struct logic_pio_root {
+	struct list_head sec_head;
+	resource_size_t sec_min;
+	resource_size_t sec_max;
+};
+
+#if ((IO_SPACE_LIMIT + 1) & IO_SPACE_LIMIT)
+#error "(IO_SPACE_LIMIT + 1) must be power of 2!"
+#endif
+
+#define PIO_VAL_MASK		(IO_SPACE_LIMIT >> PIO_SECT_BITS)
+#define PIO_VAL_BIT_LEN		(ilog2(PIO_VAL_MASK) + 1)
+
+#define PIO_SECT_MIN(sec_id)	((sec_id) << PIO_VAL_BIT_LEN)
+#define PIO_SECT_MAX(sec_id)	(PIO_SECT_MIN(sec_id) | PIO_VAL_MASK)
+
+#define PIO_SECT_ID(pio)	((pio >> PIO_VAL_BIT_LEN) & PIO_SECT_MASK)
+
+struct logic_pio_sect {
+	struct list_head list;
+	resource_size_t io_start;
+
+	struct logic_pio_hwaddr *hwpeer;
+};
+#define to_pio_sect(node) container_of(node, struct logic_pio_sect, list)
+
+struct logic_pio_hwaddr {
+	struct list_head list;
+	struct fwnode_handle *fwnode;
+	resource_size_t hw_start;
+	resource_size_t size; /* range size populated */
+	unsigned long flags;
+
+	struct logic_pio_sect *pio_peer;
+
+	void *devpara;	/* private parameter of the host device */
+	struct hostio_ops *ops;	/* ops operating on this node */
+};
+#define to_pio_hwaddr(node) container_of(node, struct logic_pio_hwaddr, list)
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
+#define LPC_MIN_BUS_RANGE	0x0
+
+/*
+ * The default maximal IO size for Hip06/Hip07 LPC bus.
+ * Defining the I/O range size as 0x400 here should be sufficient for
+ * all peripherals under the bus.
+ */
+#define LPC_BUS_IO_SIZE		0x400
+#endif
+
+extern u8 logic_inb(unsigned long addr);
+extern void logic_outb(u8 value, unsigned long addr);
+extern void logic_outw(u16 value, unsigned long addr);
+extern void logic_outl(u32 value, unsigned long addr);
+extern u16 logic_inw(unsigned long addr);
+extern u32 logic_inl(unsigned long addr);
+extern void logic_outb(u8 value, unsigned long addr);
+extern void logic_outw(u16 value, unsigned long addr);
+extern void logic_outl(u32 value, unsigned long addr);
+extern void logic_insb(unsigned long addr, void *buffer, unsigned int count);
+extern void logic_insl(unsigned long addr, void *buffer, unsigned int count);
+extern void logic_insw(unsigned long addr, void *buffer, unsigned int count);
+extern void logic_outsb(unsigned long addr, const void *buffer,
+			unsigned int count);
+extern void logic_outsw(unsigned long addr, const void *buffer,
+			unsigned int count);
+extern void logic_outsl(unsigned long addr, const void *buffer,
+			unsigned int count);
+#ifdef CONFIG_LOGIC_PIO
+extern struct logic_pio_hwaddr
+*find_io_range_by_fwnode(struct fwnode_handle *fwnode);
+
+extern unsigned long logic_pio_trans_hwaddr(struct fwnode_handle *fwnode,
+			resource_size_t hw_addr);
+#else
+static inline struct logic_pio_hwaddr
+*find_io_range_by_fwnode(struct fwnode_handle *fwnode)
+{
+	return NULL;
+}
+
+static inline unsigned long
+logic_pio_trans_hwaddr(struct fwnode_handle *fwnode, resource_size_t hw_addr)
+{
+	return -1;
+}
+#endif
+
+/*
+ * These are used by pci. As LOGIC_PIO is bound with PCI, no need to add dummy
+ * functions for them.
+ */
+extern struct logic_pio_hwaddr
+*logic_pio_register_range(struct logic_pio_hwaddr *newrange,
+	unsigned long align);
+
+extern resource_size_t logic_pio_to_hwaddr(unsigned long pio);
+
+extern unsigned long logic_pio_trans_cpuaddr(resource_size_t hw_addr);
+
+#endif /* __KERNEL__ */
+#endif /* __LINUX_LIBIO_H */
diff --git a/lib/Kconfig b/lib/Kconfig
index 0c8b78a..503c2e0 100644
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
index 320ac46a..26dcec0 100644
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
index 0000000..ca247e3
--- /dev/null
+++ b/lib/logic_pio.c
@@ -0,0 +1,413 @@
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
+/* The unique hardware address list. */
+static LIST_HEAD(io_range_list);
+static DEFINE_MUTEX(io_range_mutex);
+
+/*
+ * These are the lists for PIO. The highest PIO_SECT_BITS of PIO is the index.
+ */
+static struct logic_pio_root logic_pio_root_list[PIO_MAX_SECT] = {
+#ifdef CONFIG_INDIRECT_PIO
+	/*
+	 * At this moment, assign all the other logic PIO space to MMIO.
+	 * If more elements added, please adjust the ending index and .sec_max;
+	 * Please keep MMIO element started from index ZERO.
+	 */
+	[PIO_CPU_MMIO ... PIO_INDIRECT - 1] = {
+		.sec_head = LIST_HEAD_INIT(logic_pio_root_list[PIO_CPU_MMIO].sec_head),
+		.sec_min = PIO_SECT_MIN(PIO_CPU_MMIO),
+		.sec_max = PIO_SECT_MAX(PIO_INDIRECT - 1),
+	},
+
+	/* The last element */
+	[PIO_INDIRECT] = {
+		.sec_head = LIST_HEAD_INIT(logic_pio_root_list[PIO_INDIRECT].sec_head),
+		.sec_min = PIO_SECT_MIN(PIO_INDIRECT),
+		.sec_max = PIO_SECT_MAX(PIO_INDIRECT),
+	},
+#else
+	[PIO_CPU_MMIO] = {
+		.sec_head = LIST_HEAD_INIT(logic_pio_root_list[PIO_CPU_MMIO].sec_head),
+		.sec_min = PIO_SECT_MIN(PIO_CPU_MMIO),
+		.sec_max = PIO_SECT_MAX(PIO_CPU_MMIO),
+	},
+
+#endif
+};
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
+static struct logic_pio_hwaddr *
+logic_pio_find_range_byaddr(struct fwnode_handle *fwnode,
+			resource_size_t start, resource_size_t end)
+{
+	struct logic_pio_hwaddr *range;
+
+	list_for_each_entry_rcu(range, &io_range_list, list) {
+		if (!range->pio_peer) {
+			pr_warn("Invalid cpu addr node(%pa) in list!\n",
+				&range->hw_start);
+			continue;
+		}
+		if (range->fwnode != fwnode)
+			continue;
+		/* without any overlap with current range */
+		if (start >= range->hw_start + range->size ||
+			end < range->hw_start)
+			continue;
+		/* overlap is not supported now. */
+		if (start < range->hw_start ||
+			end >= range->hw_start + range->size)
+			return ERR_PTR(-EBUSY);
+		/* had been registered. */
+		return range;
+	}
+
+	return NULL;
+}
+
+
+static int logic_pio_alloc_range(struct logic_pio_root *root,
+		resource_size_t size, unsigned long align,
+		struct list_head **prev, resource_size_t *pio_alloc)
+{
+	struct logic_pio_sect *entry;
+	resource_size_t tmp_start;
+	resource_size_t idle_start, idle_end;
+
+	idle_start = root->sec_min;
+	*prev = &root->sec_head;
+	list_for_each_entry_rcu(entry, &root->sec_head, list) {
+		if (!entry->hwpeer ||
+			idle_start > entry->io_start) {
+			WARN(1, "skip an invalid io range during traversal!\n");
+			goto nextentry;
+		}
+		/* set the end edge. */
+		if (idle_start == entry->io_start) {
+			struct logic_pio_sect *next;
+
+			idle_start = entry->io_start + entry->hwpeer->size;
+			next = list_next_or_null_rcu(&root->sec_head,
+				&entry->list, struct logic_pio_sect, list);
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
+			idle_start + size <= idle_end) {
+			*prev = &entry->list;
+			*pio_alloc = idle_start;
+			return 0;
+		}
+
+nextentry:
+		idle_start = entry->io_start + entry->hwpeer->size;
+		*prev = &entry->list;
+	}
+	/* check the last free gap... */
+	idle_end = root->sec_max;
+
+	tmp_start = idle_start;
+	idle_start = ALIGN(idle_start, align);
+	if (idle_start >= tmp_start &&
+		idle_start + size <= idle_end) {
+		*pio_alloc = idle_start;
+		return 0;
+	}
+
+	return -EBUSY;
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
+struct logic_pio_hwaddr
+*logic_pio_register_range(struct logic_pio_hwaddr *newrange,
+		unsigned long align)
+{
+	struct logic_pio_hwaddr *range;
+	struct logic_pio_sect *newsect;
+	resource_size_t pio_alloc;
+	struct list_head *prev, *hwprev;
+	unsigned long sect_id;
+	int err;
+
+	if (!newrange || !newrange->fwnode || !newrange->size)
+		return ERR_PTR(-EINVAL);
+
+	sect_id = newrange->flags;
+	if (sect_id >= PIO_MAX_SECT)
+		return ERR_PTR(-EINVAL);
+
+	mutex_lock(&io_range_mutex);
+	range = logic_pio_find_range_byaddr(newrange->fwnode,
+			newrange->hw_start,
+			newrange->hw_start + newrange->size - 1);
+	if (range) {
+		if (!IS_ERR(range))
+			pr_info("the request IO range had been registered!\n");
+		else
+			pr_err("registering IO[%pa - sz%pa) got failed!\n",
+				&newrange->hw_start, &newrange->size);
+		mutex_unlock(&io_range_mutex);
+		return range;
+	}
+
+	err = logic_pio_alloc_range(&logic_pio_root_list[sect_id],
+			newrange->size, align, &prev, &pio_alloc);
+	if (err) {
+		pr_err("can't find free %pa logical IO range!\n",
+			&newrange->size);
+		goto exitproc;
+	}
+
+	if (prev == &logic_pio_root_list[sect_id].sec_head) {
+		hwprev = &io_range_list;
+	} else {
+		newsect = to_pio_sect(prev);
+		hwprev = &newsect->hwpeer->list;
+	}
+
+	newsect = kzalloc(sizeof(*newsect), GFP_KERNEL);
+	if (!newsect) {
+		err = -ENOMEM;
+		goto exitproc;
+	}
+	newsect->io_start = pio_alloc;
+	newsect->hwpeer = newrange;
+	list_add_rcu(&newsect->list, prev);
+
+	newrange->pio_peer = newsect;
+	list_add_rcu(&newrange->list, hwprev);
+
+exitproc:
+	mutex_unlock(&io_range_mutex);
+	return err ? ERR_PTR(err) : newrange;
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
+/*
+ * Translate the input logical pio to the corresponding hardware address.
+ * The input pio should be unique in the whole logical PIO space.
+ */
+resource_size_t logic_pio_to_hwaddr(unsigned long pio)
+{
+	struct logic_pio_sect *entry;
+	struct logic_pio_root *root;
+
+	/* The caller should check the section id is valid. */
+	root = &logic_pio_root_list[PIO_SECT_ID(pio)];
+	list_for_each_entry_rcu(entry, &root->sec_head, list) {
+		if (!entry->hwpeer) {
+			pr_warn("Invalid PIO entry(%pa) in list!\n",
+				&entry->io_start);
+			continue;
+		}
+		if (pio < entry->io_start)
+			break;
+
+		if (pio < entry->io_start + entry->hwpeer->size)
+			return pio - entry->io_start + entry->hwpeer->hw_start;
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
+logic_pio_trans_hwaddr(struct fwnode_handle *fwnode, resource_size_t addr)
+{
+	struct logic_pio_hwaddr *range;
+
+	range = logic_pio_find_range_byaddr(fwnode, addr, addr);
+	if (!range)
+		return -1;
+
+	return addr - range->hw_start + range->pio_peer->io_start;
+}
+
+unsigned long
+logic_pio_trans_cpuaddr(resource_size_t addr)
+{
+	struct logic_pio_hwaddr *range;
+
+	list_for_each_entry_rcu(range, &io_range_list, list) {
+		if (!range->pio_peer) {
+			pr_warn("Invalid cpu addr node(%pa) in list!\n",
+				&range->hw_start);
+			continue;
+		}
+		if (range->flags != PIO_CPU_MMIO)
+			continue;
+		if (addr >= range->hw_start &&
+			addr < range->hw_start + range->size)
+			return addr - range->hw_start +
+				range->pio_peer->io_start;
+	}
+	return -1;
+}
+
+#if defined(CONFIG_INDIRECT_PIO) && defined(PCI_IOBASE)
+static struct logic_pio_hwaddr *find_io_range(unsigned long pio)
+{
+	struct logic_pio_sect *entry;
+	struct logic_pio_root *root;
+
+	root = &logic_pio_root_list[PIO_SECT_ID(pio)];
+	if (pio < root->sec_min || pio > root->sec_max)
+		return NULL;
+	/*
+	 * non indirectIO section, no need to convert the addr. Jump to mmio ops
+	 * directly.
+	 */
+	if (&root->sec_head == &logic_pio_root_list[PIO_CPU_MMIO].sec_head)
+		return NULL;
+	list_for_each_entry_rcu(entry, &root->sec_head, list) {
+		if (!entry->hwpeer) {
+			pr_warn("Invalid PIO entry(%pa) in list!\n",
+				&entry->io_start);
+			continue;
+		}
+		if (pio < entry->io_start)
+			break;
+
+		if (pio < entry->io_start + entry->hwpeer->size)
+			return entry->hwpeer;
+	}
+
+	return NULL;
+}
+
+#define BUILD_LOGIC_IO(bw, type)					\
+type logic_in##bw(unsigned long addr)					\
+{									\
+	struct logic_pio_hwaddr *entry = find_io_range(addr);		\
+									\
+	if (entry && entry->ops)					\
+		return entry->ops->pfin(entry->devpara,			\
+					addr, sizeof(type));		\
+	return read##bw(PCI_IOBASE + addr);				\
+}									\
+									\
+void logic_out##bw(type value, unsigned long addr)			\
+{									\
+	struct logic_pio_hwaddr *entry = find_io_range(addr);		\
+									\
+	if (entry && entry->ops)					\
+		entry->ops->pfout(entry->devpara,			\
+					addr, value, sizeof(type));	\
+	else								\
+		write##bw(value, PCI_IOBASE + addr);			\
+}									\
+									\
+void logic_ins##bw(unsigned long addr, void *buffer, unsigned int count)\
+{									\
+	struct logic_pio_hwaddr *entry = find_io_range(addr);		\
+									\
+	if (entry && entry->ops)					\
+		entry->ops->pfins(entry->devpara,			\
+				addr, buffer, sizeof(type), count);	\
+	else								\
+		reads##bw(PCI_IOBASE + addr, buffer, count);		\
+}									\
+									\
+void logic_outs##bw(unsigned long addr, const void *buffer,		\
+		    unsigned int count)					\
+{									\
+	struct logic_pio_hwaddr *entry = find_io_range(addr);		\
+									\
+	if (entry && entry->ops)					\
+		entry->ops->pfouts(entry->devpara,			\
+				addr, buffer, sizeof(type), count);	\
+	else								\
+		writes##bw(PCI_IOBASE + addr, buffer, count);	\
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
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
