Return-Path: <linux-kernel-owner@vger.kernel.org>
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
Subject: [RFC PATCHv3 3/4] x86/pci: Initial commit for new VMD device driver
Date: Tue, 27 Oct 2015 11:34:06 -0600
Message-Id: <1445967247-24310-4-git-send-email-keith.busch@intel.com>
In-Reply-To: <1445967247-24310-1-git-send-email-keith.busch@intel.com>
References: <1445967247-24310-1-git-send-email-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Intel Volume Management Device (VMD) is an integrated endpoint on the
platform's PCIe root complex that acts as a host bridge to a secondary
PCIe domain. BIOS can reassign one or more root ports to appear within
a VMD domain instead of the primary domain. The immediate benefit is
that additional PCI-e domains allow more than 256 buses in a system by
letting bus number reuse across different domains.

VMD domains do not define ACPI _SEG, so to avoid domain clashing with
host bridges defining this segment, VMD domains start at 0x10000 which
is greater than the highest possible 16-bit ACPI defined _SEG.

This driver enumerates and enables the domain using the root bus
configuration interface provided by the PCI subsystem. The driver
provides configuration space accessor functions (pci_ops), bus and
memory resources, a chained MSI irq domain, irq_chip implementation,
and dma operations necessary to support the domain through the VMD
endpoint's interface.

VMD routes I/O as follows:

   1) Configuration Space: BAR 0 ("CFGBAR") of VMD provides the base
   address and size for configuration space register access to VMD-owned
   root ports. It works similarly to MMCONFIG for extended configuration
   space. Bus numbering is independent and does not conflict with the
   primary domain.

   2) MMIO Space: BARs 2 and 4 ("MEMBAR1" and "MEMBAR2") of VMD provide the
   base address, size, and type for MMIO register access. These addresses
   are not translated by VMD hardware; they are simply reservations to be
   distributed to root ports' memory base/limit registers and subdivided
   among devices downstream.

   3) DMA: To interact appropriately with IOMMU, the source ID DMA read
   and write requests are translated to the bus-device-function of the
   VMD endpoint. Otherwise, DMA operates normally without VMD-specific
   address translation.

   4) Interrupts: Part of VMD's BAR 4 is reserved for VMD's MSI-X Table and
   PBA. MSIs from VMD domain devices and ports are remapped to appear if
   they were issued using one of VMD's MSI-X table entries. Each MSI and
   MSI-X addresses of VMD-owned devices and ports have a special format
   where the address refers specific entries in VMD's MSI-X table.  As with
   DMA, the interrupt source id is translated to VMD's bus-device-function.

   The driver provides its own MSI and MSI-X configuration functions
   specific to how MSI messages are used within the VMD domain, and
   it provides an irq_chip for independent IRQ allocation and to relay
   interrupts from VMD's interrupt handler to the appropriate device
   driver's handler.

   5) Errors: PCIe error message are intercepted by the root ports normally
   (e.g. AER), except with VMD, system errors (i.e. firmware first) are
   disabled by default. AER and hotplug interrupts are translated in the
   same way as endpoint interrupts.

   6) VMD does not support INTx interrupts or IO ports. Devices or drivers
   requiring these features should either not be placed below VMD-owned
   root ports, or VMD should be disabled by BIOS for such endpoints.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 arch/x86/Kconfig           |   17 ++
 arch/x86/include/asm/vmd.h |   10 +
 arch/x86/kernel/apic/msi.c |   38 +++
 arch/x86/pci/Makefile      |    2 +
 arch/x86/pci/vmd.c         |  619 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/irq/chip.c          |    1 +
 kernel/irq/irqdomain.c     |    3 +
 7 files changed, 690 insertions(+)
 create mode 100644 arch/x86/include/asm/vmd.h
 create mode 100644 arch/x86/pci/vmd.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 96d058a..53c53f7 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2632,6 +2632,23 @@ config PMC_ATOM
 	def_bool y
         depends on PCI
 
+config HAVE_VMDDEV
+	bool
+
+config VMDDEV
+	depends on PCI && PCI_DOMAINS && PCI_MSI && GENERIC_MSI_IRQ_DOMAIN && IRQ_DOMAIN_HIERARCHY
+	tristate "Volume Management Device Driver"
+	default N
+	select HAVE_VMDDEV
+	---help---
+	Adds support for the Intel Volume Manage Device (VMD). VMD is
+	a secondary PCI host bridge that allows PCI Express root ports,
+	and devices attached to them, to be removed from the default PCI
+	domain and placed within the VMD domain This provides additional
+	bus resources to allow more devices than are otherwise possible
+	with a single domain. If your system provides one of these and
+	has devices attached to it, say "Y".
+
 source "net/Kconfig"
 
 source "drivers/Kconfig"
diff --git a/arch/x86/include/asm/vmd.h b/arch/x86/include/asm/vmd.h
new file mode 100644
index 0000000..35429f0
--- /dev/null
+++ b/arch/x86/include/asm/vmd.h
@@ -0,0 +1,10 @@
+#ifndef _ASM_X86_VMD_H
+#define _ASM_X86_VMD_H
+
+#ifdef CONFIG_HAVE_VMDDEV
+struct irq_domain_ops;
+struct irq_domain *vmd_create_irq_domain(struct pci_dev *dev,
+				const struct irq_domain_ops *domain_ops);
+#endif
+
+#endif /* _ASM_X86_VMD_H */
diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 5f1feb6..dc773de 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -22,6 +22,7 @@
 #include <asm/hw_irq.h>
 #include <asm/apic.h>
 #include <asm/irq_remapping.h>
+#include <asm/vmd.h>
 
 static struct irq_domain *msi_default_domain;
 
@@ -134,6 +135,43 @@ static struct msi_domain_info pci_msi_domain_info = {
 	.handler_name	= "edge",
 };
 
+#ifdef CONFIG_HAVE_VMDDEV
+static struct irq_chip pci_chained_msi_controller = {
+	.name			= "PCI-MSI-chained",
+};
+
+static struct msi_domain_info pci_chained_msi_domain_info = {
+	.flags		= MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
+			  MSI_FLAG_PCI_MSIX,
+	.ops		= &pci_msi_domain_ops,
+	.chip		= &pci_chained_msi_controller,
+};
+
+struct irq_domain *vmd_create_irq_domain(struct pci_dev *dev,
+				const struct irq_domain_ops *domain_ops)
+{
+	int count = 0;
+	struct msi_desc *msi_desc;
+	struct irq_domain *vmd_irqdomain, *msi_irqdomain;
+
+	if (!dev->msix_enabled)
+		return NULL;
+
+	for_each_pci_msi_entry(msi_desc, dev)
+		count += msi_desc->nvec_used;
+	vmd_irqdomain = irq_domain_add_linear(NULL, count,
+						  domain_ops, dev);
+	if (!vmd_irqdomain)
+		return NULL;
+	msi_irqdomain = pci_msi_create_irq_domain(NULL, &pci_chained_msi_domain_info,
+						  vmd_irqdomain);
+	if (!msi_irqdomain)
+		irq_domain_remove(vmd_irqdomain);
+	return msi_irqdomain;
+}
+EXPORT_SYMBOL_GPL(vmd_create_irq_domain);
+#endif
+
 void arch_init_msi_domain(struct irq_domain *parent)
 {
 	if (disable_apic)
diff --git a/arch/x86/pci/Makefile b/arch/x86/pci/Makefile
index 5c6fc35..c204079 100644
--- a/arch/x86/pci/Makefile
+++ b/arch/x86/pci/Makefile
@@ -23,6 +23,8 @@ obj-y				+= bus_numa.o
 obj-$(CONFIG_AMD_NB)		+= amd_bus.o
 obj-$(CONFIG_PCI_CNB20LE_QUIRK)	+= broadcom_bus.o
 
+obj-$(CONFIG_VMDDEV) += vmd.o
+
 ifeq ($(CONFIG_PCI_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
 endif
diff --git a/arch/x86/pci/vmd.c b/arch/x86/pci/vmd.c
new file mode 100644
index 0000000..7d98d84
--- /dev/null
+++ b/arch/x86/pci/vmd.c
@@ -0,0 +1,619 @@
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
+#include <linux/irqchip/chained_irq.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/rculist.h>
+#include <linux/rcupdate.h>
+#include <asm/device.h>
+#include <asm/irqdomain.h>
+#include <asm/hpet.h>
+#include <asm/msidef.h>
+#include <asm/vmd.h>
+
+struct vmd_dev {
+	struct pci_dev *dev;
+
+	spinlock_t cfg_lock;
+	char __iomem *cfgbar;
+
+	int msix_count;
+	struct msix_entry *msix_entries;
+	struct vmd_irq_list *irqs;
+
+	struct pci_sysdata sysdata;
+	struct pci_bus *bus;
+	struct irq_domain *irq_domain;
+	struct resource resources[3];
+
+#ifdef CONFIG_X86_DEV_DMA_OPS
+	struct dma_map_ops dma_ops;
+	struct dma_domain dma_domain;
+#endif
+};
+
+struct vmd_irq {
+	struct list_head node;
+	struct vmd_irq_list *irq;
+	unsigned int virq;
+};
+
+static DEFINE_SPINLOCK(list_lock);
+struct vmd_irq_list {
+	struct list_head irq_list;
+	unsigned int vmd_vector;
+	unsigned int index;
+};
+
+static inline struct vmd_dev *vmd_from_bus(struct pci_bus *bus)
+{
+	return container_of(bus->sysdata, struct vmd_dev, sysdata);
+}
+
+static void vmd_msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
+{
+	struct vmd_irq *vmdirq = data->chip_data;
+
+	msg->address_hi = MSI_ADDR_BASE_HI;
+	msg->address_lo = MSI_ADDR_BASE_LO | MSI_ADDR_DEST_ID(vmdirq->irq->index);
+	msg->data = MSI_DATA_VECTOR(vmdirq->irq->vmd_vector);
+}
+
+static void vmd_msi_write_msg(struct irq_data *data, struct msi_msg *msg)
+{
+	pci_write_msi_msg(data->irq, msg);
+}
+
+/*
+ * Function is required when using irq hierarchy domains, but we don't have a
+ * good way to not create conflicts with other devices sharing the same vector.
+ */
+int vmd_irq_set_affinity(struct irq_data *data, const struct cpumask *dest,
+								bool force)
+{
+	return 0;
+}
+
+static struct irq_chip vmd_chip = {
+	.name 			= "VMD-MSI",
+	.irq_compose_msi_msg	= vmd_msi_compose_msg,
+	.irq_write_msi_msg	= vmd_msi_write_msg,
+	.irq_set_affinity	= vmd_irq_set_affinity,
+};
+
+static void vmd_msi_free_irqs(struct irq_domain *domain,
+				 unsigned int virq, unsigned int nr_irqs)
+{
+	struct vmd_irq *vmdirq;
+	struct irq_data *irq_data;
+
+	irq_data = irq_domain_get_irq_data(domain, virq);
+	if (!irq_data)
+		return;
+	vmdirq = irq_data->chip_data;
+	kfree(vmdirq);
+}
+
+static int vmd_msi_alloc_irqs(struct irq_domain *domain, unsigned int virq,
+				 unsigned int nr_irqs, void *arg)
+{
+	struct vmd_dev *vmd;
+	struct vmd_irq *vmdirq;
+	struct irq_data *irq_data;
+	struct pci_dev *dev = domain->host_data;
+
+	irq_data = irq_domain_get_irq_data(domain, virq);
+	if (!irq_data)
+		return -EINVAL;
+
+	vmd = pci_get_drvdata(dev);
+	vmdirq = kzalloc(sizeof(*vmdirq), GFP_KERNEL);
+	if (!vmdirq)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&vmdirq->node);
+	vmdirq->irq = &vmd->irqs[virq % vmd->msix_count];
+	vmdirq->virq = virq;
+
+	irq_domain_set_hwirq_and_chip(domain, virq, vmdirq->irq->vmd_vector,
+							&vmd_chip, vmdirq);
+	irq_set_chip(virq, &vmd_chip);
+	irq_set_handler_data(virq, vmdirq);
+	__irq_set_handler(virq, handle_simple_irq, 0, NULL);
+
+	return 0;
+}
+
+static void vmd_msi_activate(struct irq_domain *domain,
+					struct irq_data *data)
+{
+	struct msi_msg msg;
+	struct vmd_irq *vmdirq = data->chip_data;
+	struct vmd_irq_list *irq = vmdirq->irq;
+
+	BUG_ON(irq_chip_compose_msi_msg(data, &msg));
+	data->chip->irq_write_msi_msg(data, &msg);
+
+	spin_lock(&list_lock);
+	list_add_tail_rcu(&vmdirq->node, &irq->irq_list);
+	spin_unlock(&list_lock);
+}
+
+static void vmd_msi_deactivate(struct irq_domain *domain,
+				   struct irq_data *data)
+{
+	struct msi_msg msg;
+	struct vmd_irq *vmdirq = data->chip_data;
+
+	memset(&msg, 0, sizeof(msg));
+	data->chip->irq_write_msi_msg(data, &msg);
+
+	spin_lock(&list_lock);
+	list_del_rcu(&vmdirq->node);
+	spin_unlock(&list_lock);
+}
+
+static const struct irq_domain_ops vmd_domain_ops = {
+	.alloc = vmd_msi_alloc_irqs,
+	.free = vmd_msi_free_irqs,
+	.activate = vmd_msi_activate,
+	.deactivate = vmd_msi_deactivate,
+};
+
+#ifdef CONFIG_X86_DEV_DMA_OPS
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
+	if (source->alloc)
+		dest->alloc = vmd_alloc;
+	if (source->free)
+		dest->free = vmd_free;
+	if (source->mmap)
+		dest->mmap = vmd_mmap;
+	if (source->get_sgtable)
+		dest->get_sgtable = vmd_get_sgtable;
+	if (source->map_page)
+		dest->map_page = vmd_map_page;
+	if (source->unmap_page)
+		dest->unmap_page = vmd_unmap_page;
+	if (source->map_sg)
+		dest->map_sg = vmd_map_sg;
+	if (source->unmap_sg)
+		dest->unmap_sg = vmd_unmap_sg;
+	if (source->sync_single_for_cpu)
+		dest->sync_single_for_cpu = vmd_sync_single_for_cpu;
+	if (source->sync_single_for_device)
+		dest->sync_single_for_device = vmd_sync_single_for_device;
+	if (source->sync_sg_for_cpu)
+		dest->sync_sg_for_cpu = vmd_sync_sg_for_cpu;
+	if (source->sync_sg_for_device)
+		dest->sync_sg_for_device = vmd_sync_sg_for_device;
+	if (source->mapping_error)
+		dest->mapping_error = vmd_mapping_error;
+	if (source->dma_supported)
+		dest->dma_supported = vmd_dma_supported;
+#ifdef ARCH_HAS_DMA_GET_REQUIRED_MASK
+	if (source->get_required_mask)
+		dest->get_required_mask = vmd_get_required_mask;
+#endif
+	add_dma_domain(domain);
+}
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
+	.read = vmd_pci_read,
+	.write = vmd_pci_write,
+};
+
+static int vmd_find_free_domain(void)
+{
+	/*
+	 * VMD Domains start at 10000h to not clash with domains defining
+	 * ACPI _SEG.
+	 */
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
+
+	LIST_HEAD(resources);
+	struct resource cfgbar = {
+		.name = "VMD CFGBAR",
+		.start = 0,
+		.end = (resource_size(&vmd->dev->resource[0]) >> 20) - 1,
+		.flags = IORESOURCE_BUS | IORESOURCE_PCI_FIXED,
+	};
+	struct resource membar1 = {
+		.name = "VMD MEMBAR1",
+		.start = vmd->dev->resource[2].start,
+		.end = vmd->dev->resource[2].end,
+		.flags = (vmd->dev->resource[2].flags & ~IORESOURCE_SIZEALIGN) &
+				(!upper_32_bits(vmd->dev->resource[2].end) ?
+							~IORESOURCE_MEM_64 : ~0),
+	};
+	struct resource membar2 = {
+		.name = "VMD MEMBAR2",
+		.start = vmd->dev->resource[4].start + 0x2000,
+		.end = vmd->dev->resource[4].end,
+		.flags = (vmd->dev->resource[4].flags & ~IORESOURCE_SIZEALIGN) &
+			(!upper_32_bits(vmd->dev->resource[4].end) ?
+							~IORESOURCE_MEM_64 : ~0),
+	};
+
+	vmd->resources[0] = cfgbar;
+	vmd->resources[1] = membar1;
+	vmd->resources[2] = membar2;
+
+	sd->domain = vmd_find_free_domain();
+	if (sd->domain < 0)
+		return sd->domain;
+	sd->node = pcibus_to_node(vmd->dev->bus);
+
+	vmd->irq_domain = vmd_create_irq_domain(vmd->dev, &vmd_domain_ops);
+	if (!vmd->irq_domain)
+		return -ENODEV;
+
+	vmd_setup_dma_ops(vmd);
+
+	pci_add_resource(&resources, &vmd->resources[0]);
+	pci_add_resource(&resources, &vmd->resources[1]);
+	pci_add_resource(&resources, &vmd->resources[2]);
+
+	vmd->bus = pci_create_root_bus(NULL, 0, &vmd_ops, sd, &resources);
+	if (!vmd->bus) {
+		irq_domain_remove(vmd->irq_domain);
+		pci_free_resource_list(&resources);
+		return -ENODEV;
+	}
+	dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
+
+	pci_rescan_bus(vmd->bus);
+	WARN(sysfs_create_link(&vmd->dev->dev.kobj, &vmd->bus->dev.kobj, "domain"),
+			"Can't create symlink to domain\n");
+	return 0;
+}
+
+static void vmd_flow_handler(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct vmd_irq_list *irqs = irq_desc_get_handler_data(desc);
+	struct vmd_irq *vmdirq;
+
+	chained_irq_enter(chip, desc);
+	rcu_read_lock();
+	list_for_each_entry_rcu(vmdirq, &irqs->irq_list, node)
+		generic_handle_irq(vmdirq->virq);
+	rcu_read_unlock();
+	chained_irq_exit(chip, desc);
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
+	if (!vmd->msix_count)
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
+		irq_set_chained_handler_and_data(vmd->msix_entries[i].vector,
+					vmd_flow_handler, &vmd->irqs[i]);
+	}
+	spin_lock_init(&vmd->cfg_lock);
+	err = vmd_enable_domain(vmd);
+	if (err)
+		return err;
+
+	pci_set_drvdata(dev, vmd);
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
+static const struct pci_device_id vmd_ids[] = {
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x201d),},
+	{0,}
+};
+MODULE_DEVICE_TABLE(pci, vmd_ids);
+
+struct pci_driver vmd_drv = {
+	.name		= "vmd",
+	.id_table	= vmd_ids,
+	.probe		= vmd_probe,
+	.remove		= vmd_remove,
+};
+module_pci_driver(vmd_drv);
+
+MODULE_AUTHOR("Intel Corporation");
+MODULE_LICENSE("GPL v2");
+MODULE_VERSION("0.2");
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index e28169d..e566a6b 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1062,3 +1062,4 @@ int irq_chip_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(irq_chip_compose_msi_msg);
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index dc9d27c..8303ccb 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -910,6 +910,7 @@ struct irq_data *irq_domain_get_irq_data(struct irq_domain *domain,
 
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(irq_domain_get_irq_data);
 
 /**
  * irq_domain_set_hwirq_and_chip - Set hwirq and irqchip of @virq at @domain
@@ -934,6 +935,7 @@ int irq_domain_set_hwirq_and_chip(struct irq_domain *domain, unsigned int virq,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(irq_domain_set_hwirq_and_chip);
 
 /**
  * irq_domain_set_info - Set the complete data for a @virq in @domain
@@ -1240,6 +1242,7 @@ struct irq_data *irq_domain_get_irq_data(struct irq_domain *domain,
 
 	return (irq_data && irq_data->domain == domain) ? irq_data : NULL;
 }
+EXPORT_SYMBOL_GPL(irq_domain_get_irq_data);
 
 /**
  * irq_domain_set_info - Set the complete data for a @virq in @domain
-- 
1.7.10.4

