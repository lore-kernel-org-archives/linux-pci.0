Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:17983 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933374AbbLGVci (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 7 Dec 2015 16:32:38 -0500
From: Keith Busch <keith.busch@intel.com>
To: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	linux-pci@vger.kernel.org
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bryan Veal <bryan.e.veal@intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Martin Mares <mj@ucw.cz>,
	Jon Derrick <jonathan.derrick@intel.com>,
	Keith Busch <keith.busch@intel.com>
Subject: [PATCHv6 5/7] x86/pci: Initial commit for new VMD device driver
Date: Mon,  7 Dec 2015 14:32:27 -0700
Message-Id: <1449523949-21898-6-git-send-email-keith.busch@intel.com>
In-Reply-To: <1449523949-21898-1-git-send-email-keith.busch@intel.com>
References: <1449523949-21898-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Intel Volume Management Device (VMD) is an integrated endpoint on the
platform's PCIe root complex that acts as a host bridge to a secondary
PCIe domain. BIOS can reassign one or more root ports to appear within
a VMD domain instead of the primary domain. The immediate benefit is
that additional PCI-e domains allow more than 256 buses in a system by
letting bus number be reused across different domains.

VMD domains do not define ACPI _SEG, so to avoid domain clashing with
host bridges defining this segment, VMD domains start at 0x10000 which
is greater than the highest possible 16-bit ACPI defined _SEG.

This driver enumerates and enables the domain using the root bus
configuration interface provided by the PCI subsystem. The driver
provides configuration space accessor functions (pci_ops), bus and
memory resources, an MSI irq domain with irq_chip implementation, and
dma operations necessary to use devices in through the VMD endpoint's
interface.

VMD routes I/O as follows:

   1) Configuration Space: BAR 0 ("CFGBAR") of VMD provides the base
   address and size for configuration space register access to VMD-owned
   root ports. It works similarly to MMCONFIG for extended configuration
   space. Bus numbering is independent and does not conflict with the
   primary domain.

   2) MMIO Space: BARs 2 and 4 ("MEMBAR1" and "MEMBAR2") of VMD provide
   the base address, size, and type for MMIO register access. These
   addresses are not translated by VMD hardware; they are simply
   reservations to be distributed to root ports' memory base/limit
   registers and subdivided among devices downstream.

   3) DMA: To interact appropriately with IOMMU, the source ID DMA read
   and write requests are translated to the bus-device-function of the
   VMD endpoint. Otherwise, DMA operates normally without VMD-specific
   address translation.

   4) Interrupts: Part of VMD's BAR 4 is reserved for VMD's MSI-X Table
   and PBA. MSIs from VMD domain devices and ports are remapped to appear
   if they were issued using one of VMD's MSI-X table entries. Each MSI
   and MSI-X addresses of VMD-owned devices and ports have a special
   format where the address refers to specific entries in VMD's MSI-X
   table. As with DMA, the interrupt source id is translated to VMD's
   bus-device-function.

   The driver provides its own MSI and MSI-X configuration functions
   specific to how MSI messages are used within the VMD domain,
   and provides an irq_chip for independent IRQ allocation to relay
   interrupts from VMD's interrupt handler to the appropriate device
   driver's handler.

   5) Errors: PCIe error message are intercepted by the root ports
   normally (e.g. AER), except with VMD, system errors (i.e. firmware
   first) are disabled by default. AER and hotplug interrupts are
   translated in the same way as endpoint interrupts.

   6) VMD does not support INTx interrupts or IO ports. Devices or drivers
   requiring these features should either not be placed below VMD-owned
   root ports, or VMD should be disabled by BIOS for such endpoints.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 arch/x86/Kconfig              |  13 +
 arch/x86/include/asm/hw_irq.h |   5 +
 arch/x86/pci/Makefile         |   2 +
 arch/x86/pci/vmd.c            | 695 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 715 insertions(+)
 create mode 100644 arch/x86/pci/vmd.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index db3622f..9a5ab69 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2665,6 +2665,19 @@ config PMC_ATOM
 	def_bool y
         depends on PCI
 
+config VMD
+	depends on PCI_MSI
+	tristate "Volume Management Device Driver"
+	default N
+	---help---
+	  Adds support for the Intel Volume Manage Device (VMD). VMD is a
+	  secondary PCI host bridge that allows PCI Express root ports,
+	  and devices attached to them, to be removed from the default
+	  PCI domain and placed within the VMD domain. This provides
+	  additional bus resources than are otherwise possible with a
+	  single domain. If you know your system provides one of these and
+	  have devices attached to it, say Y; if you are not sure, say N.
+
 source "net/Kconfig"
 
 source "drivers/Kconfig"
diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index 1e3408e..79c35c4 100644
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -108,6 +108,11 @@ struct irq_alloc_info {
 			struct IO_APIC_route_entry *ioapic_entry;
 		};
 #endif
+#if IS_ENABLED(CONFIG_VMD)
+		struct {
+			struct msi_desc	*desc;
+		};
+#endif
 #ifdef	CONFIG_DMAR_TABLE
 		struct {
 			int		dmar_id;
diff --git a/arch/x86/pci/Makefile b/arch/x86/pci/Makefile
index 5c6fc35..97062a6 100644
--- a/arch/x86/pci/Makefile
+++ b/arch/x86/pci/Makefile
@@ -23,6 +23,8 @@ obj-y				+= bus_numa.o
 obj-$(CONFIG_AMD_NB)		+= amd_bus.o
 obj-$(CONFIG_PCI_CNB20LE_QUIRK)	+= broadcom_bus.o
 
+obj-$(CONFIG_VMD) += vmd.o
+
 ifeq ($(CONFIG_PCI_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
 endif
diff --git a/arch/x86/pci/vmd.c b/arch/x86/pci/vmd.c
new file mode 100644
index 0000000..d9b1c8d
--- /dev/null
+++ b/arch/x86/pci/vmd.c
@@ -0,0 +1,695 @@
+/*
+ * Volume Management Device driver
+ * Copyright (c) 2015, Intel Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#include <linux/device.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/msi.h>
+#include <linux/pci.h>
+#include <linux/rculist.h>
+#include <linux/rcupdate.h>
+
+#include <asm/irqdomain.h>
+#include <asm/device.h>
+#include <asm/msi.h>
+#include <asm/msidef.h>
+
+/*
+ * Lock for manipulating vmd irq lists.
+ */
+static DEFINE_RAW_SPINLOCK(list_lock);
+
+/**
+ * struct vmd_irq - private data to map driver irq to the VMD shared vector
+ * @node:	list item for parent traversal.
+ * @rcu:	rcu callback item for freeing.
+ * @irq: 	back pointer to parent.
+ * @virq:	the virtual irq value provided to the requesting driver.
+ *
+ * Every MSI/MSI-x irq requested for a device in a VMD domain will be mapped to
+ * a VMD irq using this structure.
+ */
+struct vmd_irq {
+	struct list_head	node;
+	struct rcu_head		rcu;
+	struct vmd_irq_list	*irq;
+	unsigned int		virq;
+};
+
+/**
+ * struct vmd_irq_list - list of driver requested irq's mapping to a vmd vector
+ * @irq_list:	the list of irq's the VMD one demuxes to.
+ * @vmd_vector:	the h/w irq assigned to the VMD device.
+ * @index:	index into the VMD MSI-x table; used for message routing.
+ * @count:	number of child irqs assigned to this vector; used to track
+ * 		sharing.
+ */
+struct vmd_irq_list {
+	struct list_head	irq_list;
+	unsigned int		vmd_vector;
+	unsigned int		index;
+	unsigned int		count;
+};
+
+struct vmd_dev {
+	struct pci_dev		*dev;
+
+	spinlock_t		cfg_lock;
+	char __iomem		*cfgbar;
+
+	int msix_count;
+	struct msix_entry	*msix_entries;
+	struct vmd_irq_list	*irqs;
+
+	struct pci_sysdata	sysdata;
+	struct resource		resources[3];
+	struct irq_domain	*irq_domain;
+	struct pci_bus		*bus;
+
+#ifdef CONFIG_X86_DEV_DMA_OPS
+	struct dma_map_ops	dma_ops;
+	struct dma_domain	dma_domain;
+#endif
+};
+
+static inline struct vmd_dev *vmd_from_bus(struct pci_bus *bus)
+{
+	return container_of(bus->sysdata, struct vmd_dev, sysdata);
+}
+
+/*
+ * Drivers managing a device in a VMD domain allocate their own irqs as before,
+ * but the MSI entry for the hardware it's driving will be programmed with a
+ * destination id for the VMD MSI-x table. The VMD device muxes interrupts in
+ * its domain into one of its own, and the VMD driver de-muxes these for the
+ * handlers sharing that VMD irq. The vmd irq_domain provides the operations
+ * and irq_chip to set this up.
+ */
+static void vmd_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
+{
+	struct vmd_irq *vmdirq = data->chip_data;
+	struct vmd_irq_list *irq = vmdirq->irq;
+
+	msg->address_hi = MSI_ADDR_BASE_HI;
+	msg->address_lo = MSI_ADDR_BASE_LO | MSI_ADDR_DEST_ID(irq->index);
+	msg->data = 0;
+}
+
+/*
+ * We rely on MSI_FLAG_USE_DEF_CHIP_OPS to set the irq mask/unmask ops.
+ */
+static void vmd_irq_enable(struct irq_data *data)
+{
+	struct vmd_irq *vmdirq = data->chip_data;
+
+	raw_spin_lock(&list_lock);
+	list_add_tail_rcu(&vmdirq->node, &vmdirq->irq->irq_list);
+	raw_spin_unlock(&list_lock);
+
+	data->chip->irq_unmask(data);
+}
+
+static void vmd_irq_disable(struct irq_data *data)
+{
+	struct vmd_irq *vmdirq = data->chip_data;
+
+	data->chip->irq_mask(data);
+
+	raw_spin_lock(&list_lock);
+	list_del_rcu(&vmdirq->node);
+	raw_spin_unlock(&list_lock);
+}
+
+/*
+ * XXX: Stubbed until we develop acceptable way to not create conflicts with
+ * other devices sharing the same vector.
+ */
+static int vmd_irq_set_affinity(struct irq_data *data, const struct cpumask *dest,
+								bool force)
+{
+	return -EINVAL;
+}
+
+static struct irq_chip vmd_msi_controller = {
+	.name			= "VMD-MSI",
+	.irq_enable		= vmd_irq_enable,
+	.irq_disable		= vmd_irq_disable,
+	.irq_compose_msi_msg	= vmd_compose_msi_msg,
+	.irq_set_affinity	= vmd_irq_set_affinity,
+};
+
+static irq_hw_number_t vmd_get_hwirq(struct msi_domain_info *info,
+				     msi_alloc_info_t *arg)
+{
+	return 0;
+}
+
+/*
+ * XXX: We can be even smarter selecting the best irq once we solve the
+ * affinity problem.
+ */
+static struct vmd_irq_list *vmd_next_irq(struct vmd_dev *vmd)
+{
+	int i, best = 0;
+
+	raw_spin_lock(&list_lock);
+	for (i = 1; i < vmd->msix_count; i++)
+		if (vmd->irqs[i].count < vmd->irqs[best].count)
+			best = i;
+	vmd->irqs[best].count++;
+	raw_spin_unlock(&list_lock);
+
+	return &vmd->irqs[best];
+}
+
+static int vmd_msi_init(struct irq_domain *domain,
+			struct msi_domain_info *info,
+			unsigned int virq, irq_hw_number_t hwirq,
+			msi_alloc_info_t *arg)
+{
+	struct vmd_dev *vmd = vmd_from_bus(msi_desc_to_pci_dev(arg->desc)->bus);
+	struct vmd_irq *vmdirq = kzalloc(sizeof(*vmdirq), GFP_KERNEL);
+
+	if (!vmdirq)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&vmdirq->node);
+	vmdirq->irq = vmd_next_irq(vmd);
+	vmdirq->virq = virq;
+
+	irq_domain_set_info(domain, virq, vmdirq->irq->vmd_vector,
+			info->chip, vmdirq, handle_simple_irq, vmd, NULL);
+	return 0;
+}
+
+static void vmd_msi_free(struct irq_domain *domain,
+			struct msi_domain_info *info,
+			unsigned int virq)
+{
+	struct vmd_irq *vmdirq = irq_get_chip_data(virq);
+
+	/* XXX: Potential optimization to rebalance */
+	raw_spin_lock(&list_lock);
+	vmdirq->irq->count--;
+	raw_spin_unlock(&list_lock);
+
+	kfree_rcu(vmdirq, rcu);
+}
+
+static int vmd_msi_prepare(struct irq_domain *domain,
+			struct device *dev, int nvec,
+			msi_alloc_info_t *arg)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct vmd_dev *vmd = vmd_from_bus(pdev->bus);
+
+	if (nvec > vmd->msix_count)
+		return vmd->msix_count;
+	memset(arg, 0, sizeof(*arg));
+	return 0;
+}
+
+static void vmd_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
+{
+	arg->desc = desc;
+}
+
+static struct msi_domain_ops vmd_msi_domain_ops = {
+	.get_hwirq	= vmd_get_hwirq,
+	.msi_init	= vmd_msi_init,
+	.msi_free	= vmd_msi_free,
+	.msi_prepare	= vmd_msi_prepare,
+	.set_desc	= vmd_set_desc,
+};
+
+static struct msi_domain_info vmd_msi_domain_info = {
+	.flags		= MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
+			  MSI_FLAG_PCI_MSIX,
+	.ops		= &vmd_msi_domain_ops,
+	.chip		= &vmd_msi_controller,
+};
+
+#ifdef CONFIG_X86_DEV_DMA_OPS
+/*
+ * VMD replaces the requester id with its own. DMA mappings for devices in a
+ * VMD domain need to be mapped for the VMD device, not the device requiring
+ * the mapping.
+ */
+static struct device *dev_to_vmd_dev(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct vmd_dev *vmd = vmd_from_bus(pdev->bus);
+	return &vmd->dev->dev;
+}
+
+static void *vmd_alloc(struct device *dev, size_t size, dma_addr_t *addr,
+				gfp_t flag, struct dma_attrs *attrs)
+{
+	struct device *vdev = dev_to_vmd_dev(dev);
+	return vdev->archdata.dma_ops->alloc(vdev, size, addr, flag, attrs);
+}
+
+static void vmd_free(struct device *dev, size_t size, void *vaddr,
+				dma_addr_t addr, struct dma_attrs *attrs)
+{
+	struct device *vdev = dev_to_vmd_dev(dev);
+	vdev->archdata.dma_ops->free(vdev, size, vaddr, addr, attrs);
+}
+
+static int vmd_mmap(struct device *dev, struct vm_area_struct *vma,
+				void *cpu_addr, dma_addr_t addr,
+				size_t size, struct dma_attrs *attrs)
+{
+	struct device *vdev = dev_to_vmd_dev(dev);
+	return vdev->archdata.dma_ops->mmap(vdev, vma, cpu_addr, addr, size,
+									attrs);
+}
+
+static int vmd_get_sgtable(struct device *dev, struct sg_table *sgt,
+				void *cpu_addr, dma_addr_t addr,
+				size_t size, struct dma_attrs *attrs)
+{
+	struct device *vdev = dev_to_vmd_dev(dev);
+	return vdev->archdata.dma_ops->get_sgtable(vdev, sgt, cpu_addr, addr,
+								size, attrs);
+}
+
+static dma_addr_t vmd_map_page(struct device *dev, struct page *page,
+				unsigned long offset, size_t size,
+				enum dma_data_direction dir,
+				struct dma_attrs *attrs)
+{
+	struct device *vdev = dev_to_vmd_dev(dev);
+	return vdev->archdata.dma_ops->map_page(vdev, page, offset, size, dir,
+									attrs);
+}
+
+static void vmd_unmap_page(struct device *dev, dma_addr_t addr, size_t size,
+				enum dma_data_direction dir,
+				struct dma_attrs *attrs)
+{
+	struct device *vdev = dev_to_vmd_dev(dev);
+	vdev->archdata.dma_ops->unmap_page(vdev, addr, size, dir, attrs);
+}
+
+static int vmd_map_sg(struct device *dev, struct scatterlist *sg, int nents,
+				enum dma_data_direction dir,
+				struct dma_attrs *attrs)
+{
+	struct device *vdev = dev_to_vmd_dev(dev);
+	return vdev->archdata.dma_ops->map_sg(vdev, sg, nents, dir, attrs);
+}
+
+static void vmd_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
+				enum dma_data_direction dir,
+				struct dma_attrs *attrs)
+{
+	struct device *vdev = dev_to_vmd_dev(dev);
+	vdev->archdata.dma_ops->unmap_sg(vdev, sg, nents, dir, attrs);
+}
+
+static void vmd_sync_single_for_cpu(struct device *dev, dma_addr_t addr,
+				size_t size, enum dma_data_direction dir)
+{
+	struct device *vdev = dev_to_vmd_dev(dev);
+	vdev->archdata.dma_ops->sync_single_for_cpu(vdev, addr, size, dir);
+}
+
+static void vmd_sync_single_for_device(struct device *dev, dma_addr_t addr,
+				size_t size, enum dma_data_direction dir)
+{
+	struct device *vdev = dev_to_vmd_dev(dev);
+	vdev->archdata.dma_ops->sync_single_for_device(vdev, addr, size, dir);
+}
+
+static void vmd_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
+				int nents, enum dma_data_direction dir)
+{
+	struct device *vdev = dev_to_vmd_dev(dev);
+	vdev->archdata.dma_ops->sync_sg_for_cpu(vdev, sg, nents, dir);
+}
+
+static void vmd_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
+				int nents, enum dma_data_direction dir)
+{
+	struct device *vdev = dev_to_vmd_dev(dev);
+	vdev->archdata.dma_ops->sync_sg_for_device(vdev, sg, nents, dir);
+}
+
+static int vmd_mapping_error(struct device *dev, dma_addr_t addr)
+{
+	struct device *vdev = dev_to_vmd_dev(dev);
+	return vdev->archdata.dma_ops->mapping_error(vdev, addr);
+}
+
+static int vmd_dma_supported(struct device *dev, u64 mask)
+{
+	struct device *vdev = dev_to_vmd_dev(dev);
+	return vdev->archdata.dma_ops->dma_supported(vdev, mask);
+}
+
+#ifdef ARCH_HAS_DMA_GET_REQUIRED_MASK
+u64 vmd_get_required_mask(struct device *dev)
+{
+	struct device *vdev = dev_to_vmd_dev(dev);
+	return vdev->archdata.dma_ops->get_required_mask(vdev);
+}
+#endif
+
+static void vmd_teardown_dma_ops(struct vmd_dev *vmd)
+{
+	struct dma_domain *domain = &vmd->dma_domain;
+
+	if (vmd->dev->dev.archdata.dma_ops)
+		del_dma_domain(domain);
+}
+
+#define ASSIGN_VMD_DMA_OPS(source, dest, fn) \
+	if (source->fn) dest->fn = vmd_##fn;
+static void vmd_setup_dma_ops(struct vmd_dev *vmd)
+{
+	struct dma_domain *domain = &vmd->dma_domain;
+	struct dma_map_ops *source = vmd->dev->dev.archdata.dma_ops;
+	struct dma_map_ops *dest = &vmd->dma_ops;
+
+	domain->domain_nr = vmd->sysdata.domain;
+	domain->dma_ops = dest;
+
+	if (!source)
+		return;
+	ASSIGN_VMD_DMA_OPS(source, dest, alloc);
+	ASSIGN_VMD_DMA_OPS(source, dest, free);
+	ASSIGN_VMD_DMA_OPS(source, dest, mmap);
+	ASSIGN_VMD_DMA_OPS(source, dest, get_sgtable);
+	ASSIGN_VMD_DMA_OPS(source, dest, map_page);
+	ASSIGN_VMD_DMA_OPS(source, dest, unmap_page);
+	ASSIGN_VMD_DMA_OPS(source, dest, map_sg);
+	ASSIGN_VMD_DMA_OPS(source, dest, unmap_sg);
+	ASSIGN_VMD_DMA_OPS(source, dest, sync_single_for_cpu);
+	ASSIGN_VMD_DMA_OPS(source, dest, sync_single_for_device);
+	ASSIGN_VMD_DMA_OPS(source, dest, sync_sg_for_cpu);
+	ASSIGN_VMD_DMA_OPS(source, dest, sync_sg_for_device);
+	ASSIGN_VMD_DMA_OPS(source, dest, mapping_error);
+	ASSIGN_VMD_DMA_OPS(source, dest, dma_supported);
+#ifdef ARCH_HAS_DMA_GET_REQUIRED_MASK
+	ASSIGN_VMD_DMA_OPS(source, dest, get_required_mask);
+#endif
+	add_dma_domain(domain);
+}
+#undef ASSIGN_VMD_DMA_OPS
+#else
+static void vmd_teardown_dma_ops(struct vmd_dev *vmd) {}
+static void vmd_setup_dma_ops(struct vmd_dev *vmd) {}
+#endif
+
+/*
+ * CPU may deadlock if config space is not serialized on some versions of this
+ * hardware, so all config space access is done under a spinlock.
+ */
+static int vmd_pci_read(struct pci_bus *bus, unsigned int devfn, int reg,
+							int len, u32 *value)
+{
+	int ret = 0;
+	unsigned long flags;
+	struct vmd_dev *vmd = vmd_from_bus(bus);
+	char __iomem *addr = vmd->cfgbar + (bus->number << 20) +
+						(devfn << 12) + reg;
+
+	if ((addr - vmd->cfgbar) + len >= resource_size(&vmd->dev->resource[0]))
+		return -EFAULT;
+
+	spin_lock_irqsave(&vmd->cfg_lock, flags);
+	switch (len) {
+	case 1:
+		*value = readb(addr);
+		break;
+	case 2:
+		*value = readw(addr);
+		break;
+	case 4:
+		*value = readl(addr);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	spin_unlock_irqrestore(&vmd->cfg_lock, flags);
+	return ret;
+}
+
+/*
+ * VMD h/w converts posted config writes to non-posted. The read-back in this
+ * function forces the completion so it returns only after the config space was
+ * written, as expected.
+ */
+static int vmd_pci_write(struct pci_bus *bus, unsigned int devfn, int reg,
+							int len, u32 value)
+{
+	int ret = 0;
+	unsigned long flags;
+	struct vmd_dev *vmd = vmd_from_bus(bus);
+	char __iomem *addr = vmd->cfgbar + (bus->number << 20) +
+						(devfn << 12) + reg;
+
+	if ((addr - vmd->cfgbar) + len >= resource_size(&vmd->dev->resource[0]))
+		return -EFAULT;
+
+	spin_lock_irqsave(&vmd->cfg_lock, flags);
+	switch (len) {
+	case 1:
+		writeb(value, addr);
+		readb(addr);
+		break;
+	case 2:
+		writew(value, addr);
+		readw(addr);
+		break;
+	case 4:
+		writel(value, addr);
+		readl(addr);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	spin_unlock_irqrestore(&vmd->cfg_lock, flags);
+	return ret;
+}
+
+static struct pci_ops vmd_ops = {
+	.read		= vmd_pci_read,
+	.write		= vmd_pci_write,
+};
+
+/*
+ * VMD domains start at 10000h to not clash with domains defining ACPI _SEG.
+ */
+static int vmd_find_free_domain(void)
+{
+	int domain = 0xffff;
+	struct pci_bus *bus = NULL;
+
+	while ((bus = pci_find_next_bus(bus)) != NULL)
+		domain = max_t(int, domain, pci_domain_nr(bus));
+	return domain + 1;
+}
+
+static int vmd_enable_domain(struct vmd_dev *vmd)
+{
+	struct pci_sysdata *sd = &vmd->sysdata;
+	LIST_HEAD(resources);
+
+	vmd->resources[0] = (struct resource) {
+		.name	= "VMD CFGBAR",
+		.start	= 0,
+		.end	= (resource_size(&vmd->dev->resource[0]) >> 20) - 1,
+		.flags	= IORESOURCE_BUS | IORESOURCE_PCI_FIXED,
+	};
+	vmd->resources[1] = (struct resource) {
+		.name	= "VMD MEMBAR1",
+		.start	= vmd->dev->resource[2].start,
+		.end	= vmd->dev->resource[2].end,
+		.flags	= (vmd->dev->resource[2].flags & ~IORESOURCE_SIZEALIGN) &
+				(!upper_32_bits(vmd->dev->resource[2].end) ?
+							~IORESOURCE_MEM_64 : ~0),
+	};
+	vmd->resources[2] = (struct resource) {
+		.name	= "VMD MEMBAR2",
+		.start	= vmd->dev->resource[4].start + 0x2000,
+		.end	= vmd->dev->resource[4].end,
+		.flags	= (vmd->dev->resource[4].flags & ~IORESOURCE_SIZEALIGN) &
+				(!upper_32_bits(vmd->dev->resource[4].end) ?
+							~IORESOURCE_MEM_64 : ~0),
+	};
+
+	sd->domain = vmd_find_free_domain();
+	if (sd->domain < 0)
+		return sd->domain;
+	sd->node = pcibus_to_node(vmd->dev->bus);
+
+	vmd->irq_domain = pci_msi_create_irq_domain(NULL, &vmd_msi_domain_info,
+									NULL);
+	if (!vmd->irq_domain)
+		return -ENODEV;
+
+	pci_add_resource(&resources, &vmd->resources[0]);
+	pci_add_resource(&resources, &vmd->resources[1]);
+	pci_add_resource(&resources, &vmd->resources[2]);
+	vmd->bus = pci_create_root_bus(NULL, 0, &vmd_ops, sd, &resources);
+	if (!vmd->bus) {
+		pci_free_resource_list(&resources);
+		irq_domain_remove(vmd->irq_domain);
+		return -ENODEV;
+	}
+
+	vmd_setup_dma_ops(vmd);
+	dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
+	pci_rescan_bus(vmd->bus);
+
+	WARN(sysfs_create_link(&vmd->dev->dev.kobj, &vmd->bus->dev.kobj, "domain"),
+			"Can't create symlink to domain\n");
+	return 0;
+}
+
+static irqreturn_t vmd_irq(int irq, void *data)
+{
+	struct vmd_irq_list *irqs = data;
+	struct vmd_irq *vmdirq;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(vmdirq, &irqs->irq_list, node)
+		generic_handle_irq(vmdirq->virq);
+	rcu_read_unlock();
+
+	return IRQ_HANDLED;
+}
+
+static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
+{
+	struct vmd_dev *vmd;
+	int i, err;
+
+	if (resource_size(&dev->resource[0]) < (1 << 20))
+		return -ENOMEM;
+
+	vmd = devm_kzalloc(&dev->dev, sizeof(*vmd), GFP_KERNEL);
+	if (!vmd)
+		return -ENOMEM;
+
+	vmd->dev = dev;
+	err = pcim_enable_device(dev);
+	if (err < 0)
+		return err;
+
+	vmd->cfgbar = pcim_iomap(dev, 0, 0);
+	if (!vmd->cfgbar)
+		return -ENOMEM;
+
+	pci_set_master(dev);
+	if (dma_set_mask_and_coherent(&dev->dev, DMA_BIT_MASK(64)) &&
+	    dma_set_mask_and_coherent(&dev->dev, DMA_BIT_MASK(32)))
+		return -ENODEV;
+
+	vmd->msix_count = pci_msix_vec_count(dev);
+	if (vmd->msix_count < 0)
+		return -ENODEV;
+
+	vmd->irqs = devm_kcalloc(&dev->dev, vmd->msix_count, sizeof(*vmd->irqs),
+							GFP_KERNEL);
+	if (!vmd->irqs)
+		return -ENOMEM;
+
+	vmd->msix_entries = devm_kcalloc(&dev->dev, vmd->msix_count,
+					sizeof(*vmd->msix_entries), GFP_KERNEL);
+	if(!vmd->msix_entries)
+		return -ENOMEM;
+	for (i = 0; i < vmd->msix_count; i++)
+		vmd->msix_entries[i].entry = i;
+
+	vmd->msix_count = pci_enable_msix_range(vmd->dev, vmd->msix_entries, 1,
+							vmd->msix_count);
+	if (vmd->msix_count < 0)
+		return vmd->msix_count;
+
+	for (i = 0; i < vmd->msix_count; i++) {
+		INIT_LIST_HEAD(&vmd->irqs[i].irq_list);
+		vmd->irqs[i].vmd_vector = vmd->msix_entries[i].vector;
+		vmd->irqs[i].index = i;
+
+		err = devm_request_irq(&dev->dev, vmd->irqs[i].vmd_vector,
+				vmd_irq, 0, "vmd", &vmd->irqs[i]);
+		if (err)
+			return err;
+	}
+	spin_lock_init(&vmd->cfg_lock);
+	pci_set_drvdata(dev, vmd);
+	err = vmd_enable_domain(vmd);
+	if (err)
+		return err;
+	return 0;
+}
+
+static void vmd_remove(struct pci_dev *dev)
+{
+	struct vmd_dev *vmd = pci_get_drvdata(dev);
+
+	pci_set_drvdata(dev, NULL);
+	sysfs_remove_link(&vmd->dev->dev.kobj, "domain");
+	pci_stop_root_bus(vmd->bus);
+	pci_remove_root_bus(vmd->bus);
+	vmd_teardown_dma_ops(vmd);
+	irq_domain_remove(vmd->irq_domain);
+}
+
+#ifdef CONFIG_PM
+static int vmd_suspend(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	pci_save_state(pdev);
+	return 0;
+}
+
+static int vmd_resume(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	pci_restore_state(pdev);
+	return 0;
+}
+#endif
+static SIMPLE_DEV_PM_OPS(vmd_dev_pm_ops, vmd_suspend, vmd_resume);
+
+static const struct pci_device_id vmd_ids[] = {
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x201d),},
+	{0,}
+};
+MODULE_DEVICE_TABLE(pci, vmd_ids);
+
+static struct pci_driver vmd_drv = {
+	.name		= "vmd",
+	.id_table	= vmd_ids,
+	.probe		= vmd_probe,
+	.remove		= vmd_remove,
+	.driver		= {
+		.pm	= &vmd_dev_pm_ops,
+	},
+};
+module_pci_driver(vmd_drv);
+
+MODULE_AUTHOR("Intel Corporation");
+MODULE_LICENSE("GPL v2");
+MODULE_VERSION("0.5");
-- 
2.6.2.307.g37023ba

