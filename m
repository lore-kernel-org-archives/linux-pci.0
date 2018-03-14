Return-Path: <linux-arch-owner@vger.kernel.org>
From: John Garry <john.garry@huawei.com>
To: <mika.westerberg@linux.intel.com>, <rafael@kernel.org>,
        <lorenzo.pieralisi@arm.com>, <rjw@rjwysocki.net>,
        <hanjun.guo@linaro.org>, <robh+dt@kernel.org>,
        <bhelgaas@google.com>, <arnd@arndb.de>, <mark.rutland@arm.com>,
        <olof@lixom.net>, <dann.frazier@canonical.com>,
        <andy.shevchenko@gmail.com>, <robh@kernel.org>,
        <andriy.shevchenko@linux.intel.com>
CC: <joe@perches.com>, <benh@kernel.crashing.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linuxarm@huawei.com>,
        <minyard@acm.org>, <devicetree@vger.kernel.org>,
        <linux-arch@vger.kernel.org>, <rdunlap@infradead.org>,
        <gregkh@linuxfoundation.org>, <akpm@linux-foundation.org>,
        <frowand.list@gmail.com>, <agraf@suse.de>
Subject: [PATCH v17 01/10] LIB: Introduce a generic PIO mapping method
Date: Thu, 15 Mar 2018 02:15:50 +0800
Message-ID: <1521051359-34473-2-git-send-email-john.garry@huawei.com>
In-Reply-To: <1521051359-34473-1-git-send-email-john.garry@huawei.com>
References: <1521051359-34473-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Zhichang Yuan <yuanzhichang@hisilicon.com>

In commit 41f8bba7f555 ("of/pci: Add pci_register_io_range() and
pci_pio_to_address()"), a new I/O space management was supported. With
that driver, the I/O ranges configured for PCI/PCIe hosts on some
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

Signed-off-by: Zhichang Yuan <yuanzhichang@hisilicon.com>
Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Tested-by: dann frazier <dann.frazier@canonical.com>
---
 include/asm-generic/io.h  |   2 +
 include/linux/logic_pio.h | 124 ++++++++++++++++++++
 lib/Kconfig               |  15 +++
 lib/Makefile              |   2 +
 lib/logic_pio.c           | 282 ++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 425 insertions(+)
 create mode 100644 include/linux/logic_pio.h
 create mode 100644 lib/logic_pio.c

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 7c6a39e..f76fbd6 100644
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
diff --git a/include/linux/logic_pio.h b/include/linux/logic_pio.h
new file mode 100644
index 0000000..8c78ff4
--- /dev/null
+++ b/include/linux/logic_pio.h
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2017 Hisilicon Limited, All Rights Reserved.
+ * Author: Gabriele Paoloni <gabriele.paoloni@huawei.com>
+ * Author: Zhichang Yuan <yuanzhichang@hisilicon.com>
+ *
+ */
+
+#ifndef __LINUX_LOGIC_PIO_H
+#define __LINUX_LOGIC_PIO_H
+
+#include <linux/fwnode.h>
+
+enum {
+	LOGIC_PIO_INDIRECT,		/* Indirect IO flag */
+	LOGIC_PIO_CPU_MMIO,		/* Memory mapped IO flag */
+};
+
+struct logic_pio_hwaddr {
+	struct list_head list;
+	struct fwnode_handle *fwnode;
+	resource_size_t hw_start;
+	resource_size_t io_start;
+	resource_size_t size; /* range size populated */
+	unsigned long flags;
+
+	void *hostdata;
+	const struct logic_pio_host_ops *ops;
+};
+
+struct logic_pio_host_ops {
+	u32 (*in)(void *hostdata, unsigned long addr, size_t dwidth);
+	void (*out)(void *hostdata, unsigned long addr, u32 val,
+		    size_t dwidth);
+	u32 (*ins)(void *hostdata, unsigned long addr, void *buffer,
+		   size_t dwidth, unsigned int count);
+	void (*outs)(void *hostdata, unsigned long addr, const void *buffer,
+		     size_t dwidth, unsigned int count);
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
+#ifndef inb
+#define inb logic_inb
+#endif
+
+#ifndef inw
+#define inw logic_inw
+#endif
+
+#ifndef inl
+#define inl logic_inl
+#endif
+
+#ifndef outb
+#define outb logic_outb
+#endif
+
+#ifndef outw
+#define outw logic_outw
+#endif
+
+#ifndef outl
+#define outl logic_outl
+#endif
+
+#ifndef insb
+#define insb logic_insb
+#endif
+
+#ifndef insw
+#define insw logic_insw
+#endif
+
+#ifndef insl
+#define insl logic_insl
+#endif
+
+#ifndef outsb
+#define outsb logic_outsb
+#endif
+
+#ifndef outsw
+#define outsw logic_outsw
+#endif
+
+#ifndef outsl
+#define outsl logic_outsl
+#endif
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
+#endif /* CONFIG_INDIRECT_PIO */
+
+struct logic_pio_hwaddr *find_io_range_by_fwnode(struct fwnode_handle *fwnode);
+unsigned long logic_pio_trans_hwaddr(struct fwnode_handle *fwnode,
+			resource_size_t hw_addr, resource_size_t size);
+int logic_pio_register_range(struct logic_pio_hwaddr *newrange);
+extern resource_size_t logic_pio_to_hwaddr(unsigned long pio);
+extern unsigned long logic_pio_trans_cpuaddr(resource_size_t hw_addr);
+
+#endif /* __LINUX_LOGIC_PIO_H */
diff --git a/lib/Kconfig b/lib/Kconfig
index e960894..d9dd02c 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -55,6 +55,21 @@ config ARCH_USE_CMPXCHG_LOCKREF
 config ARCH_HAS_FAST_MULTIPLIER
 	bool
 
+config INDIRECT_PIO
+	bool "Access I/O in non-MMIO mode"
+	depends on ARM64
+	help
+	  On some platforms where no separate I/O space exists, there are I/O
+	  hosts which can not be accessed in MMIO mode. Using the logical PIO
+	  mechanism, the host-local I/O resource can be mapped into system
+	  logic PIO space shared with MMIO hosts, such as PCI/PCIE, then the
+	  system can access the I/O devices with the mapped logic PIO through
+	  I/O accessors.
+	  This way has relatively little I/O performance cost. Please make
+	  sure your devices really need this configure item enabled.
+
+	  When in doubt, say N.
+
 config CRC_CCITT
 	tristate "CRC-CCITT functions"
 	help
diff --git a/lib/Makefile b/lib/Makefile
index 0bd50d71f..8fc0d3a 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -82,6 +82,8 @@ obj-$(CONFIG_HAS_IOMEM) += iomap_copy.o devres.o
 obj-$(CONFIG_CHECK_SIGNATURE) += check_signature.o
 obj-$(CONFIG_DEBUG_LOCKING_API_SELFTESTS) += locking-selftest.o
 
+obj-y += logic_pio.o
+
 obj-$(CONFIG_GENERIC_HWEIGHT) += hweight.o
 
 obj-$(CONFIG_BTREE) += btree.o
diff --git a/lib/logic_pio.c b/lib/logic_pio.c
new file mode 100644
index 0000000..8394c2d
--- /dev/null
+++ b/lib/logic_pio.c
@@ -0,0 +1,282 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2017 Hisilicon Limited, All Rights Reserved.
+ * Author: Gabriele Paoloni <gabriele.paoloni@huawei.com>
+ * Author: Zhichang Yuan <yuanzhichang@hisilicon.com>
+ *
+ */
+
+#define pr_fmt(fmt)	"LOGIC PIO: " fmt
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
+/* Consider a kernel general helper for this */
+#define in_range(b, first, len)        ((b) >= (first) && (b) < (first) + (len))
+
+/**
+ * logic_pio_register_range - register logical PIO range for a host
+ * @new_range: pointer to the io range to be registered.
+ *
+ * returns 0 on success, the error code in case of failure
+ *
+ * Register a new io range node in the io range list.
+ */
+int logic_pio_register_range(struct logic_pio_hwaddr *new_range)
+{
+	struct logic_pio_hwaddr *range;
+	resource_size_t start = new_range->hw_start;
+	resource_size_t end = new_range->hw_start + new_range->size;
+	resource_size_t mmio_sz = 0;
+	resource_size_t iio_sz = MMIO_UPPER_LIMIT;
+	int ret = 0;
+
+	if (!new_range || !new_range->fwnode || !new_range->size)
+		return -EINVAL;
+
+	mutex_lock(&io_range_mutex);
+	list_for_each_entry_rcu(range, &io_range_list, list) {
+		if (range->fwnode == new_range->fwnode) {
+			/* range already there */
+			ret = -EFAULT;
+			goto end_register;
+		}
+		if (range->flags == LOGIC_PIO_CPU_MMIO &&
+		    new_range->flags == LOGIC_PIO_CPU_MMIO) {
+			/* for MMIO ranges we need to check for overlap */
+			if (start >= range->hw_start + range->size ||
+			    end < range->hw_start) {
+				mmio_sz += range->size;
+			} else {
+				ret = -EFAULT;
+				goto end_register;
+			}
+		} else if (range->flags == LOGIC_PIO_INDIRECT &&
+			   new_range->flags == LOGIC_PIO_INDIRECT) {
+			iio_sz += range->size;
+		}
+	}
+
+	/* range not registered yet, check for available space */
+	if (new_range->flags == LOGIC_PIO_CPU_MMIO) {
+		if (mmio_sz + new_range->size - 1 > MMIO_UPPER_LIMIT) {
+			/* if it's too big check if 64K space can be reserved */
+			if (mmio_sz + SZ_64K - 1 > MMIO_UPPER_LIMIT) {
+				ret = -E2BIG;
+				goto end_register;
+			}
+			new_range->size = SZ_64K;
+			pr_warn("Requested IO range too big, new size set to 64K\n");
+		}
+		new_range->io_start = mmio_sz;
+	} else if (new_range->flags == LOGIC_PIO_INDIRECT) {
+		if (iio_sz + new_range->size - 1 > IO_SPACE_LIMIT) {
+			ret = -E2BIG;
+			goto end_register;
+		}
+		new_range->io_start = iio_sz;
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
+/**
+ * find_io_range_by_fwnode - find logical PIO range for given FW node
+ * @fwnode: FW node handle associated with logical PIO range
+ *
+ * Returns pointer to node on success, NULL otherwise
+ *
+ * Traverse the io_range_list to find the registered node whose device node
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
+/* Return a registered range given an input PIO token */
+static struct logic_pio_hwaddr *find_io_range(unsigned long pio)
+{
+	struct logic_pio_hwaddr *range;
+
+	list_for_each_entry_rcu(range, &io_range_list, list) {
+		if (in_range(pio, range->io_start, range->size))
+			return range;
+	}
+	pr_err("PIO entry token invalid\n");
+	return NULL;
+}
+
+/**
+ * logic_pio_to_hwaddr - translate logical PIO to HW address
+ * @pio: logical PIO value
+ *
+ * Returns HW address if valid, ~0 otherwise
+ *
+ * Translate the input logical pio to the corresponding hardware address.
+ * The input pio should be unique in the whole logical PIO space.
+ */
+resource_size_t logic_pio_to_hwaddr(unsigned long pio)
+{
+	struct logic_pio_hwaddr *range;
+	resource_size_t hwaddr = (resource_size_t)~0;
+
+	range = find_io_range(pio);
+	if (range)
+		hwaddr = range->hw_start + pio - range->io_start;
+
+	return hwaddr;
+}
+
+/**
+ * logic_pio_trans_hwaddr - translate HW address to logical PIO
+ * @fwnode: FW node reference for the host
+ * @addr: Host-relative HW address
+ * @size: size to translate
+ *
+ * Returns Logical PIO value if successful, ~0UL otherwise
+ */
+unsigned long
+logic_pio_trans_hwaddr(struct fwnode_handle *fwnode, resource_size_t addr,
+		       resource_size_t size)
+{
+	struct logic_pio_hwaddr *range;
+
+	range = find_io_range_by_fwnode(fwnode);
+	if (!range || range->flags == LOGIC_PIO_CPU_MMIO) {
+		pr_err("range not found or invalid\n");
+		return ~0UL;
+	}
+	if (range->size < size) {
+		pr_err("resource size %pa cannot fit in IO range size %pa\n",
+		       &size, &range->size);
+		return ~0UL;
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
+		if (range->flags != LOGIC_PIO_CPU_MMIO)
+			continue;
+		if (in_range(addr, range->hw_start, range->size))
+			return addr - range->hw_start + range->io_start;
+	}
+	pr_err("addr not registered in io_range_list\n");
+	return ~0UL;
+}
+
+#if defined(CONFIG_INDIRECT_PIO) && defined(PCI_IOBASE)
+#define BUILD_LOGIC_IO(bw, type)					\
+type logic_in##bw(unsigned long addr)					\
+{									\
+	type ret = (type)~0;						\
+									\
+	if (addr < MMIO_UPPER_LIMIT) {					\
+		ret = read##bw(PCI_IOBASE + addr);			\
+	} else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) { \
+		struct logic_pio_hwaddr *entry = find_io_range(addr);	\
+									\
+		if (entry && entry->ops)				\
+			ret = entry->ops->in(entry->hostdata,		\
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
+	} else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) {	\
+		struct logic_pio_hwaddr *entry = find_io_range(addr);	\
+									\
+		if (entry && entry->ops)				\
+			entry->ops->out(entry->hostdata,		\
+					addr, value, sizeof(type));	\
+		else							\
+			WARN_ON_ONCE(1);				\
+	}								\
+}									\
+									\
+void logic_ins##bw(unsigned long addr, void *buffer,		\
+		   unsigned int count)					\
+{									\
+	if (addr < MMIO_UPPER_LIMIT) {					\
+		reads##bw(PCI_IOBASE + addr, buffer, count);		\
+	} else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) {	\
+		struct logic_pio_hwaddr *entry = find_io_range(addr);	\
+									\
+		if (entry && entry->ops)				\
+			entry->ops->ins(entry->hostdata,		\
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
+	if (addr < MMIO_UPPER_LIMIT) {					\
+		writes##bw(PCI_IOBASE + addr, buffer, count);		\
+	} else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) {	\
+		struct logic_pio_hwaddr *entry = find_io_range(addr);	\
+									\
+		if (entry && entry->ops)				\
+			entry->ops->outs(entry->hostdata,		\
+				addr, buffer, sizeof(type), count);	\
+		else							\
+			WARN_ON_ONCE(1);				\
+	}								\
+}
+
+BUILD_LOGIC_IO(b, u8)
+EXPORT_SYMBOL(logic_inb);
+EXPORT_SYMBOL(logic_insb);
+EXPORT_SYMBOL(logic_outb);
+EXPORT_SYMBOL(logic_outsb);
+
+BUILD_LOGIC_IO(w, u16)
+EXPORT_SYMBOL(logic_inw);
+EXPORT_SYMBOL(logic_insw);
+EXPORT_SYMBOL(logic_outw);
+EXPORT_SYMBOL(logic_outsw);
+
+BUILD_LOGIC_IO(l, u32)
+EXPORT_SYMBOL(logic_inl);
+EXPORT_SYMBOL(logic_insl);
+EXPORT_SYMBOL(logic_outl);
+EXPORT_SYMBOL(logic_outsl);
+
+#endif /* CONFIG_INDIRECT_PIO && PCI_IOBASE */
-- 
1.9.1
