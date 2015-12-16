Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:40548 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932965AbbLPOPq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 16 Dec 2015 09:15:46 -0500
From: Joao Pinto <Joao.Pinto@synopsys.com>
To: helgaas@kernel.org, Vineet.Gupta1@synopsys.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	CARLOS.PALMINHA@synopsys.com, Alexey.Brodkin@synopsys.com,
	robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [PATCH v2 1/2] PCI support added to ARC
Date: Wed, 16 Dec 2015 14:14:55 +0000
Message-Id: <6080d7d4283d7aec6482d3f4236e536d36a1b7d2.1450274797.git.jpinto@synopsys.com>
In-Reply-To: <cover.1450274797.git.jpinto@synopsys.com>
References: <cover.1450274797.git.jpinto@synopsys.com>
In-Reply-To: <cover.1450274797.git.jpinto@synopsys.com>
References: <cover.1450274797.git.jpinto@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds PCI support to ARC and updates drivers/pci Makefile enabling
the ARC arch to use the generic PCI setup functions.

Signed-off-by: Joao Pinto <jpinto@synopsys.com>
---
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

 arch/arc/Kconfig                |  23 +++
 arch/arc/include/asm/dma.h      |   5 +
 arch/arc/include/asm/io.h       |  10 ++
 arch/arc/include/asm/mach/pci.h |  97 +++++++++++
 arch/arc/include/asm/pci.h      |  34 ++++
 arch/arc/kernel/Makefile        |   1 +
 arch/arc/kernel/pcibios.c       | 358 ++++++++++++++++++++++++++++++++++++++++
 arch/arc/mm/ioremap.c           |  10 +-
 arch/arc/plat-axs10x/Kconfig    |   1 +
 drivers/pci/Makefile            |   1 +
 10 files changed, 539 insertions(+), 1 deletion(-)
 create mode 100644 arch/arc/include/asm/mach/pci.h
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
index ca7c451..37942fa 100644
--- a/arch/arc/include/asm/dma.h
+++ b/arch/arc/include/asm/dma.h
@@ -10,5 +10,10 @@
 #define ASM_ARC_DMA_H
 
 #define MAX_DMA_ADDRESS 0xC0000000
+#ifdef CONFIG_PCI
+extern int isa_dma_bridge_buggy;
+#else
+#define isa_dma_bridge_buggy    (0)
+#endif
 
 #endif
diff --git a/arch/arc/include/asm/io.h b/arch/arc/include/asm/io.h
index 694ece8..2ec3cf4 100644
--- a/arch/arc/include/asm/io.h
+++ b/arch/arc/include/asm/io.h
@@ -16,7 +16,17 @@
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
+extern int pci_ioremap_io(unsigned int offset, phys_addr_t phys_addr);
 
 #define ioremap_nocache(phy, sz)	ioremap(phy, sz)
 #define ioremap_wc(phy, sz)		ioremap(phy, sz)
diff --git a/arch/arc/include/asm/mach/pci.h b/arch/arc/include/asm/mach/pci.h
new file mode 100644
index 0000000..9e75277
--- /dev/null
+++ b/arch/arc/include/asm/mach/pci.h
@@ -0,0 +1,97 @@
+/*
+ *  arch/arc/include/asm/mach/pci.h
+ *
+ *  Copyright (C) 2004-2014 Synopsys, Inc. (www.synopsys.com)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ASM_MACH_PCI_H
+#define __ASM_MACH_PCI_H
+
+#include <linux/ioport.h>
+
+struct pci_sys_data;
+struct pci_ops;
+struct pci_bus;
+struct device;
+
+struct hw_pci {
+#ifdef CONFIG_PCI_DOMAINS
+	int		domain;
+#endif
+	struct pci_ops	*ops;
+	int		nr_controllers;
+	void		**private_data;
+	int		(*setup)(int nr, struct pci_sys_data *);
+	struct pci_bus *(*scan)(int nr, struct pci_sys_data *);
+	void		(*preinit)(void);
+	void		(*postinit)(void);
+	u8		(*swizzle)(struct pci_dev *dev, u8 *pin);
+	int		(*map_irq)(const struct pci_dev *dev, u8 slot, u8 pin);
+	resource_size_t (*align_resource)(struct pci_dev *dev,
+					  const struct resource *res,
+					  resource_size_t start,
+					  resource_size_t size,
+					  resource_size_t align);
+	void		(*add_bus)(struct pci_bus *bus);
+	void		(*remove_bus)(struct pci_bus *bus);
+};
+
+/*
+ * Per-controller structure
+ */
+struct pci_sys_data {
+#ifdef CONFIG_PCI_DOMAINS
+	int		domain;
+#endif
+	struct list_head node;
+	int		busnr;		/* primary bus number		    */
+	u64		mem_offset;	/* bus->cpu memory mapping offset   */
+	unsigned long	io_offset;	/* bus->cpu IO mapping offset	    */
+	struct pci_bus	*bus;		/* PCI bus			    */
+	struct list_head resources;	/* root bus resources (apertures)   */
+	struct resource io_res;
+	char		io_res_name[12];
+					/* Bridge swizzling		    */
+	u8		(*swizzle)(struct pci_dev *, u8 *);
+					/* IRQ mapping			    */
+	int		(*map_irq)(const struct pci_dev *, u8, u8);
+					/* Resource alignement requirements */
+	resource_size_t (*align_resource)(struct pci_dev *dev,
+					  const struct resource *res,
+					  resource_size_t start,
+					  resource_size_t size,
+					  resource_size_t align);
+	void		(*add_bus)(struct pci_bus *bus);
+	void		(*remove_bus)(struct pci_bus *bus);
+	void		*private_data;	/* platform controller private data */
+};
+
+/*
+ * Call this with your hw_pci struct to initialise the PCI system.
+ */
+void pci_common_init_dev(struct device *, struct hw_pci *);
+
+/*
+ * Compatibility wrapper for older platforms that do not care about
+ * passing the parent device.
+ */
+static inline void pci_common_init(struct hw_pci *hw)
+{
+	pci_common_init_dev(NULL, hw);
+}
+
+/*
+ * Setup early fixed I/O mapping.
+ */
+#if defined(CONFIG_PCI)
+extern void pci_map_io_early(unsigned long pfn);
+#else
+static inline void pci_map_io_early(unsigned long pfn) {}
+#endif
+
+#endif /* __ASM_MACH_PCI_H */
+
diff --git a/arch/arc/include/asm/pci.h b/arch/arc/include/asm/pci.h
new file mode 100644
index 0000000..085b15f
--- /dev/null
+++ b/arch/arc/include/asm/pci.h
@@ -0,0 +1,34 @@
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
+#include <asm/mach/pci.h> /* for pci_sys_data */
+
+extern unsigned long pcibios_min_io;
+#define PCIBIOS_MIN_IO pcibios_min_io
+extern unsigned long pcibios_min_mem;
+#define PCIBIOS_MIN_MEM pcibios_min_mem
+
+#define pcibios_assign_all_busses()	1
+/*
+ * The PCI address space does equal the physical memory address space.
+ * The networking and block device layers use this boolean for bounce
+ * buffer decisions.
+ */
+#define PCI_DMA_BUS_IS_PHYS     (1)
+
+#endif /* __KERNEL__ */
+
+#endif /* _ASM_ARC_PCI_H */
+
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
index 0000000..5af7bf0
--- /dev/null
+++ b/arch/arc/kernel/pcibios.c
@@ -0,0 +1,358 @@
+/*
+ * Copyright (C) 2014-2015 Synopsys, Inc. (www.synopsys.com)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/delay.h>
+#include <linux/string.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/errno.h>
+#include <linux/bootmem.h>
+#include <linux/sizes.h>
+#include <linux/slab.h>
+
+#include <asm/pci.h>
+#include <asm/mach/pci.h>
+
+unsigned long pcibios_min_io = 0x100;
+EXPORT_SYMBOL(pcibios_min_io);
+
+unsigned long pcibios_min_mem = 0x100000;
+EXPORT_SYMBOL(pcibios_min_mem);
+
+static int pcibios_init_resources(int busnr, struct pci_sys_data *sys)
+{
+	int ret;
+	struct resource_entry *window;
+
+	if (list_empty(&sys->resources)) {
+		pci_add_resource_offset(&sys->resources,
+			 &iomem_resource, sys->mem_offset);
+	}
+
+	resource_list_for_each_entry(window, &sys->resources) {
+		if (resource_type(window->res) == IORESOURCE_IO)
+			return 0;
+	}
+
+	sys->io_res.start = (busnr * SZ_64K) ?  : pcibios_min_io;
+	sys->io_res.end = (busnr + 1) * SZ_64K - 1;
+	sys->io_res.flags = IORESOURCE_IO;
+	sys->io_res.name = sys->io_res_name;
+	sprintf(sys->io_res_name, "PCI%d I/O", busnr);
+
+	ret = request_resource(&ioport_resource, &sys->io_res);
+	if (ret) {
+		pr_err("PCI: unable to allocate I/O port region (%d)\n", ret);
+		return ret;
+	}
+	pci_add_resource_offset(&sys->resources, &sys->io_res,
+				sys->io_offset);
+
+	return 0;
+}
+
+
+static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
+			    struct list_head *head)
+{
+	struct pci_sys_data *sys = NULL;
+	int ret;
+	int nr, busnr;
+
+	for (nr = busnr = 0; nr < hw->nr_controllers; nr++) {
+		sys = kzalloc(sizeof(struct pci_sys_data), GFP_KERNEL);
+		if (!sys)
+			panic("PCI: unable to allocate sys data!");
+
+#ifdef CONFIG_PCI_DOMAINS
+		sys->domain  = hw->domain;
+#endif
+		sys->busnr   = busnr;
+		sys->swizzle = hw->swizzle;
+		sys->map_irq = hw->map_irq;
+		sys->align_resource = hw->align_resource;
+		sys->add_bus = hw->add_bus;
+		sys->remove_bus = hw->remove_bus;
+		INIT_LIST_HEAD(&sys->resources);
+
+
+		if (hw->private_data)
+			sys->private_data = hw->private_data[nr];
+
+		ret = hw->setup(nr, sys);
+
+		if (ret > 0) {
+			ret = pcibios_init_resources(nr, sys);
+			if (ret)  {
+				kfree(sys);
+				break;
+			}
+
+			if (hw->scan)
+				sys->bus = hw->scan(nr, sys);
+			else
+				sys->bus = pci_scan_root_bus(parent, sys->busnr,
+						hw->ops, sys, &sys->resources);
+
+			if (!sys->bus)
+				panic("PCI: unable to scan bus!");
+
+			busnr = sys->bus->busn_res.end + 1;
+
+			list_add(&sys->node, head);
+		} else {
+			kfree(sys);
+			if (ret < 0)
+				break;
+		}
+	}
+}
+
+int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
+{
+	return 0;
+}
+
+void pcibios_add_bus(struct pci_bus *bus)
+{
+}
+
+void pcibios_remove_bus(struct pci_bus *bus)
+{
+}
+
+/*
+ * Swizzle the device pin each time we cross a bridge.  If a platform does
+ * not provide a swizzle function, we perform the standard PCI swizzling.
+ *
+ * The default swizzling walks up the bus tree one level at a time, applying
+ * the standard swizzle function at each step, stopping when it finds the PCI
+ * root bus.  This will return the slot number of the bridge device on the
+ * root bus and the interrupt pin on that device which should correspond
+ * with the downstream device interrupt.
+ *
+ * Platforms may override this, in which case the slot and pin returned
+ * depend entirely on the platform code.  However, please note that the
+ * PCI standard swizzle is implemented on plug-in cards and Cardbus based
+ * PCI extenders, so it can not be ignored.
+ */
+static u8 pcibios_swizzle(struct pci_dev *dev, u8 *pin)
+{
+	int slot;
+	struct pci_sys_data *sys = dev->sysdata;
+
+	if (sys->swizzle)
+		slot = sys->swizzle(dev, pin);
+	else
+		slot = pci_common_swizzle(dev, pin);
+
+	return slot;
+}
+
+/*
+ * Map a slot/pin to an IRQ.
+ */
+static int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+{
+	struct pci_sys_data *sys = dev->sysdata;
+	int irq = -1;
+
+	if (sys->map_irq)
+		irq = sys->map_irq(dev, slot, pin);
+
+	return irq;
+}
+
+void pci_common_init_dev(struct device *parent, struct hw_pci *hw)
+{
+	struct pci_sys_data *sys;
+	LIST_HEAD(head);
+
+	pci_add_flags(PCI_REASSIGN_ALL_RSRC);
+	if (hw->preinit)
+		hw->preinit();
+	pcibios_init_hw(parent, hw, &head);
+	if (hw->postinit)
+		hw->postinit();
+
+	pci_fixup_irqs(pcibios_swizzle, pcibios_map_irq);
+
+	list_for_each_entry(sys, &head, node) {
+		struct pci_bus *bus = sys->bus;
+
+		if (!pci_has_flag(PCI_PROBE_ONLY)) {
+			/*
+			 * Size the bridge windows.
+			 */
+			pci_bus_size_bridges(bus);
+
+			/*
+			 * Assign resources.
+			 */
+			pci_bus_assign_resources(bus);
+		}
+
+		/*
+		 * Tell drivers about devices found.
+		 */
+		pci_bus_add_devices(bus);
+	}
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
+
+/**
+ * pcibios_enable_device - Enable I/O and memory.
+ * @dev: PCI device to be enabled
+ */
+int pcibios_enable_device(struct pci_dev *pci_dev, int mask)
+{
+	u16 cmd, old_cmd;
+	int idx;
+	struct resource *r;
+
+	pci_read_config_word(pci_dev, PCI_COMMAND, &cmd);
+	old_cmd = cmd;
+	for (idx = 0; idx < 6; idx++) {
+		/* Only set up the requested stuff */
+		if (!(mask & (1 << idx)))
+			continue;
+
+		r = pci_dev->resource + idx;
+		if (!r->start && r->end) {
+			dev_err(&pci_dev->dev, "PCI: Device %s not available\n",
+							pci_name(pci_dev));
+			return -EINVAL;
+		}
+		if (r->flags & IORESOURCE_IO)
+			cmd |= PCI_COMMAND_IO;
+		if (r->flags & IORESOURCE_MEM)
+			cmd |= PCI_COMMAND_MEMORY;
+	}
+
+	/*
+	 * Bridges (eg, cardbus bridges) need to be fully enabled
+	 */
+	if ((pci_dev->class >> 16) == PCI_BASE_CLASS_BRIDGE)
+		cmd |= PCI_COMMAND_IO | PCI_COMMAND_MEMORY;
+
+	if (cmd != old_cmd) {
+		pr_info("PCI: enabling device %s (%04x -> %04x)\n",
+		       pci_name(pci_dev), old_cmd, cmd);
+		pci_write_config_word(pci_dev, PCI_COMMAND, cmd);
+	}
+	return 0;
+}
+
+/*
+ * If the bus contains any of these devices, then we must not turn on
+ * parity checking of any kind.  Currently this is CyberPro 20x0 only.
+ */
+static inline int pdev_bad_for_parity(struct pci_dev *dev)
+{
+	return ((dev->vendor == PCI_VENDOR_ID_INTERG &&
+		 (dev->device == PCI_DEVICE_ID_INTERG_2000 ||
+		  dev->device == PCI_DEVICE_ID_INTERG_2010)) ||
+		(dev->vendor == PCI_VENDOR_ID_ITE &&
+		 dev->device == PCI_DEVICE_ID_ITE_8152));
+
+}
+
+/*
+ * pcibios_fixup_bus - Called after each bus is probed,
+ * but before its children are examined.
+ */
+void pcibios_fixup_bus(struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+	u16 features = PCI_COMMAND_SERR | PCI_COMMAND_PARITY
+			| PCI_COMMAND_FAST_BACK;
+
+	/*
+	 * Walk the devices on this bus, working out what we can
+	 * and can't support.
+	 */
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		u16 status;
+
+		pci_read_config_word(dev, PCI_STATUS, &status);
+
+		/*
+		 * If any device on this bus does not support fast back
+		 * to back transfers, then the bus as a whole is not able
+		 * to support them.  Having fast back to back transfers
+		 * on saves us one PCI cycle per transaction.
+		 */
+		if (!(status & PCI_STATUS_FAST_BACK))
+			features &= ~PCI_COMMAND_FAST_BACK;
+
+		if (pdev_bad_for_parity(dev))
+			features &= ~(PCI_COMMAND_SERR | PCI_COMMAND_PARITY);
+
+		switch (dev->class >> 8) {
+		case PCI_CLASS_BRIDGE_PCI:
+			pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &status);
+			status |= PCI_BRIDGE_CTL_PARITY
+					|PCI_BRIDGE_CTL_MASTER_ABORT;
+			status &= ~(PCI_BRIDGE_CTL_BUS_RESET
+					|PCI_BRIDGE_CTL_FAST_BACK);
+			pci_write_config_word(dev, PCI_BRIDGE_CONTROL, status);
+			break;
+
+		case PCI_CLASS_BRIDGE_CARDBUS:
+			pci_read_config_word(dev, PCI_CB_BRIDGE_CONTROL,
+						&status);
+			status |= PCI_CB_BRIDGE_CTL_PARITY
+					|PCI_CB_BRIDGE_CTL_MASTER_ABORT;
+			pci_write_config_word(dev, PCI_CB_BRIDGE_CONTROL,
+						status);
+			break;
+		}
+	}
+
+	/*
+	 * Now walk the devices again, this time setting them up.
+	 */
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		u16 cmd;
+
+		pci_read_config_word(dev, PCI_COMMAND, &cmd);
+		cmd |= features;
+		pci_write_config_word(dev, PCI_COMMAND, cmd);
+
+		pci_write_config_byte(dev, PCI_CACHE_LINE_SIZE,
+				      L1_CACHE_BYTES >> 2);
+	}
+
+	/*
+	 * Propagate the flags to the PCI bridge.
+	 */
+	if (bus->self && bus->self->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
+		if (features & PCI_COMMAND_FAST_BACK)
+			bus->bridge_ctl |= PCI_BRIDGE_CTL_FAST_BACK;
+		if (features & PCI_COMMAND_PARITY)
+			bus->bridge_ctl |= PCI_BRIDGE_CTL_PARITY;
+	}
+
+	/*
+	 * Report what we did for this bus
+	 */
+	pr_info("PCI: bus%d: Fast back to back transfers %sabled\n",
+		bus->number, (features & PCI_COMMAND_FAST_BACK) ? "en" : "dis");
+}
+EXPORT_SYMBOL(pcibios_fixup_bus);
diff --git a/arch/arc/mm/ioremap.c b/arch/arc/mm/ioremap.c
index 739e65f..fe807b0 100644
--- a/arch/arc/mm/ioremap.c
+++ b/arch/arc/mm/ioremap.c
@@ -13,6 +13,7 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/cache.h>
+#include <linux/sizes.h>
 
 void __iomem *ioremap(unsigned long paddr, unsigned long size)
 {
@@ -80,7 +81,6 @@ void __iomem *ioremap_prot(phys_addr_t paddr, unsigned long size,
 }
 EXPORT_SYMBOL(ioremap_prot);
 
-
 void iounmap(const void __iomem *addr)
 {
 	if (addr >= (void __force __iomem *)ARC_UNCACHED_ADDR_SPACE)
@@ -89,3 +89,11 @@ void iounmap(const void __iomem *addr)
 	vfree((void *)(PAGE_MASK & (unsigned long __force)addr));
 }
 EXPORT_SYMBOL(iounmap);
+
+#ifdef CONFIG_PCI
+int pci_ioremap_io(unsigned int offset, phys_addr_t phys_addr)
+{
+	return ioremap_nocache(phys_addr + offset,  SZ_64K);
+}
+EXPORT_SYMBOL_GPL(pci_ioremap_io);
+#endif
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

