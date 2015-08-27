Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:50945 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932121AbbH0WjK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 27 Aug 2015 18:39:10 -0400
From: Keith Busch <keith.busch@intel.com>
To: x86@kernel.org, linux-kernel@vger.kernel.org
Cc: Keith Busch <keith.busch@intel.com>,
	Bryan Veal <bryan.e.veal@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-pci@vger.kernel.org
Subject: [RFC PATCH 2/2] x86/pci: Initial commit for new VMD device driver
Date: Thu, 27 Aug 2015 16:39:06 -0600
Message-Id: <1440715146-16578-3-git-send-email-keith.busch@intel.com>
In-Reply-To: <1440715146-16578-1-git-send-email-keith.busch@intel.com>
References: <1440715146-16578-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Intel Volume Management Device (VMD) is an integrated endpoint on the
platform's PCIe root complex that acts as a host bridge to a secondary
PCIe domain. BIOS can reassign one or more root ports to appear within
the VMD domain instead of the primary domain.

This driver enumerates and enables the domain using the root bus
configuration interface provided by the PCI subsystem. The driver
provides configuration space accessor functions (pci_ops), bus and memory
resources, MSI configuration functions, and irq_chip implementation
necessary to support the domain through the VMD endpoint's interface.

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
  specific to how MSi messages are used within the VMD domain, and
  it provides an irq_chip for indepdent IRQ allocation and to relay
  interrupts from VMD's interrupt handler to the appropriate device
  driver's handler.

  5) Errors: PCIe error message are intercepted by the root ports normally
  (e.g. AER), except with VMD, system errors (i.e. firmware first) are
  disabled by default. AER and hotplug interrupts are translated in the
  same way as endpoint interrupts.

  6) VMD does not support INTx interrupts or IO ports. Devices or drivers
  requiring these features should either not be placed below VMD-owned
  root ports, or VMD should be disabled by BIOS for such enpdoints.

Contributers to this patch include:

  Artur Paszkiewicz <artur.paszkiewicz@intel.com>
  Bryan Veal <bryan.e.veal@intel.com>
  Jon Derrick <jonathan.derrick@intel.coM>

Signed-off-by: Keith Busch <keith.busch@intel.com>
CC: Bryan Veal <bryan.e.veal@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>
CC: x86@kernel.org
CC: linux-kernel@vger.kernel.org
CC: linux-pci@vger.kernel.org
---
 arch/x86/Kconfig      |   11 ++
 arch/x86/pci/Makefile |    2 +
 arch/x86/pci/vmd.c    |  412 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 425 insertions(+)
 create mode 100644 arch/x86/pci/vmd.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index b3a1a5d..a8cad59 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2584,6 +2584,17 @@ config PMC_ATOM
 	def_bool y
         depends on PCI
 
+config VMDDEV
+	depends on PCI && PCI_DOMAINS && PCI_MSI
+	tristate "Volume Management Device Driver"
+	default N
+	---help---
+	Adds support for the Intel Volume Manage Device (VMD). VMD is
+	a secondary PCI host bridge that allows PCI Express root ports,
+	and devices attached to them, to be removed from the default PCI
+	domain and placed within the VMD domain. If your system provides
+	one of these, and you have devices attached to it, say "Y".
+
 source "net/Kconfig"
 
 source "drivers/Kconfig"
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
index 0000000..ea8bb4c
--- /dev/null
+++ b/arch/x86/pci/vmd.c
@@ -0,0 +1,412 @@
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
+#include <linux/pci.h>
+#include <asm/hpet.h>
+#include <asm/msidef.h>
+
+struct vmd_irq {
+	struct list_head node;
+	struct vmd_irq_list *irq;
+	unsigned int virq;
+};
+
+struct vmd_irq_list {
+	struct list_head irq_list;
+	spinlock_t irq_lock;
+};
+
+struct vmd_dev {
+	spinlock_t cfg_lock;
+	char __iomem *cfgbar;
+
+	int msix_count;
+	struct msix_entry *msix_entries;
+	struct vmd_irq_list *irqs;
+
+	int domain;
+	struct pci_sysdata sysdata;
+	struct pci_bus *bus;
+	struct pci_dev *dev;
+};
+
+static inline struct vmd_dev *vmd_from_bus(struct pci_bus *bus)
+{
+	return container_of(bus->sysdata, struct vmd_dev, sysdata);
+}
+
+static void vmd_irq_enable(struct irq_data *data)
+{
+	unsigned long flags;
+	struct irq_desc *desc = irq_to_desc(data->irq);
+	struct msi_desc *msidesc = irq_desc_get_msi_desc(desc);
+	struct vmd_irq *vmdirq = (struct vmd_irq *)
+				irq_data_get_irq_handler_data(data);
+	struct vmd_irq_list *irq = vmdirq->irq;
+
+	spin_lock_irqsave(&irq->irq_lock, flags);
+	list_add_tail(&vmdirq->node, &irq->irq_list);
+	spin_unlock_irqrestore(&irq->irq_lock, flags);
+
+	msidesc->irq = data->irq;
+	dev_info(&msidesc->dev->dev, "%s: virq:%d\n", __func__, data->irq);
+}
+
+static void vmd_irq_disable(struct irq_data *data)
+{
+	unsigned long flags;
+	struct irq_desc *desc = irq_to_desc(data->irq);
+	struct msi_desc *msidesc = irq_desc_get_msi_desc(desc);
+	struct vmd_irq *vmdirq = (struct vmd_irq *)
+				irq_data_get_irq_handler_data(data);
+	struct vmd_irq_list *irq = vmdirq->irq;
+
+	spin_lock_irqsave(&irq->irq_lock, flags);
+	list_del_init(&vmdirq->node);
+	spin_unlock_irqrestore(&irq->irq_lock, flags);
+
+	msidesc->irq = 0;
+	dev_info(&msidesc->dev->dev, "%s: virq:%d\n", __func__, data->irq);
+}
+
+static struct irq_chip vmd_chip = {
+	.name			= "VMD-MSI",
+	.irq_enable		= vmd_irq_enable,
+	.irq_disable		= vmd_irq_disable,
+};
+
+static int vmd_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
+{
+	int i = 0;
+	unsigned int irq, virq;
+	struct msi_desc *msidesc;
+	struct irq_desc *desc;
+	struct vmd_dev *vmd = vmd_from_bus(dev->bus);
+
+	if (type == PCI_CAP_ID_MSI && nvec > 1)
+		return 1;
+	if (nvec > vmd->msix_count)
+		return vmd->msix_count;
+	if (nvec <= 0)
+		return -EINVAL;
+
+	irq = irq_alloc_descs(-1, 0, nvec, -1);
+	if (irq < 0)
+		return irq;
+
+	list_for_each_entry(msidesc, &dev->msi_list, list) {
+		struct vmd_irq *vmdirq;
+		struct msi_msg msg;
+
+		vmdirq = kzalloc(sizeof(*vmdirq), GFP_KERNEL);
+		if (!vmdirq)
+			return -ENOMEM;
+
+		virq = i + irq;
+		desc = irq_to_desc(virq);
+		desc->irq_data.msi_desc = msidesc;
+
+		INIT_LIST_HEAD(&vmdirq->node);
+		vmdirq->irq = &vmd->irqs[i];
+		vmdirq->virq = virq;
+
+		irq_set_handler_data(virq, vmdirq);
+		irq_set_chip_and_handler(virq, &vmd_chip, handle_simple_irq);
+
+		msg.address_hi = MSI_ADDR_BASE_HI;
+		msg.address_lo = MSI_ADDR_BASE_LO | MSI_ADDR_DEST_ID(i);
+		msg.data = MSI_DATA_VECTOR(vmd->msix_entries[i].vector);
+
+		msidesc->irq = virq;
+		msidesc->msg = msg;
+		pci_write_msi_msg(virq, &msg);
+
+		dev_info(&dev->dev, "irq %d mapped to %d for MSI\n",
+				virq, vmd->msix_entries[i].vector);
+		i++;
+	}
+	return 0;
+}
+
+static void vmd_teardown_msi_irq(unsigned int irq)
+{
+	struct vmd_irq *vmdirq = irq_get_handler_data(irq);
+
+	BUG_ON(!vmdirq || !list_empty(&vmdirq->node));
+	kfree(vmdirq);
+	irq_free_desc(irq);
+}
+
+static struct x86_msi_ops vmd_msi = {
+	.setup_msi_irqs		= vmd_setup_msi_irqs,
+	.teardown_msi_irq	= vmd_teardown_msi_irq,
+};
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
+ * function forces the completion so it returns only after the device config
+ * space was written, as expected.
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
+	int domain = -1;
+	struct pci_bus *bus = NULL;
+
+	while ((bus = pci_find_next_bus(bus)) != NULL)
+		domain = max_t(int, domain, pci_domain_nr(bus));
+	if (domain < 0)
+		return -ENODEV;
+	return domain + 1;
+}
+
+static int vmd_enable_domain(struct vmd_dev *vmd)
+{
+	static const u8 vmd_membars[] = {2, 4};
+	static const u64 vmd_membar_offsets[] = {0, 0x2000};
+	int i = 0;
+	LIST_HEAD(resources);
+	struct pci_sysdata *sd = &vmd->sysdata;
+	struct resource_entry *entry;
+
+	sd->domain = vmd_find_free_domain();
+	if (sd->domain < 0)
+		return sd->domain;
+	sd->node = pcibus_to_node(vmd->dev->bus);
+	sd->msi_ops = &vmd_msi;
+
+	pci_add_resource(&resources, NULL);
+	pci_add_resource(&resources, NULL);
+	pci_add_resource(&resources, NULL);
+	resource_list_for_each_entry(entry, &resources) {
+		struct resource *source, *resource = entry->res;
+
+		if (!i) {
+			resource->start = 0;
+			resource->end = (resource_size(
+					&vmd->dev->resource[0]) >> 20) - 1;
+			resource->flags = IORESOURCE_BUS | IORESOURCE_PCI_FIXED;
+		} else {
+			source = &vmd->dev->resource[vmd_membars[i - 1]];
+			resource->start = source->start +
+						vmd_membar_offsets[i - 1];
+			resource->end = source->end;
+			resource->flags = source->flags & ~IORESOURCE_SIZEALIGN;
+			resource->parent = source;
+			if (!upper_32_bits(resource->end))
+				resource->flags &= ~IORESOURCE_MEM_64;
+		}
+		i++;
+	}
+
+	vmd->bus = pci_scan_root_bus(NULL, 0, &vmd_ops, sd, &resources);
+	if (!vmd->bus) {
+		pci_free_resource_list(&resources);
+		return -ENODEV;
+	}
+	pci_bus_size_bridges(vmd->bus);
+	pci_bus_assign_resources(vmd->bus);
+	pci_bus_add_devices(vmd->bus);
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
+	spin_lock(&irqs->irq_lock);
+	list_for_each_entry(vmdirq, &irqs->irq_list, node)
+		generic_handle_irq(vmdirq->virq);
+	spin_unlock(&irqs->irq_lock);
+
+	return IRQ_HANDLED;
+}
+
+static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
+{
+	struct vmd_dev *vmd;
+	int i, err;
+
+	vmd = devm_kzalloc(&dev->dev, sizeof(*vmd), GFP_KERNEL);
+	if (!vmd)
+		return -ENOMEM;
+
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
+	vmd->dev = dev;
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
+		err = devm_request_irq(&dev->dev,
+				vmd->msix_entries[i].vector, vmd_irq,
+				IRQF_SHARED, "vmd", &vmd->irqs[i]);
+		if (err)
+			return err;
+		INIT_LIST_HEAD(&vmd->irqs[i].irq_list);
+		spin_lock_init(&vmd->irqs[i].irq_lock);
+	}
+
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
+	struct pci_bus *bus;
+	struct pci_dev *child, *tmp;
+	struct vmd_dev *vmd = pci_get_drvdata(dev);
+
+	if (!vmd)
+		return;
+	sysfs_remove_link(&vmd->dev->dev.kobj, "domain");
+	pci_set_drvdata(dev, NULL);
+	bus = vmd->bus;
+	list_for_each_entry_safe(child, tmp, &bus->devices, bus_list)
+		pci_stop_and_remove_bus_device(child);
+	pci_remove_bus(bus);
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
+
+static int __init vmd_init(void)
+{
+	return pci_register_driver(&vmd_drv);
+}
+module_init(vmd_init);
+
+MODULE_AUTHOR("Intel Corporation");
+MODULE_LICENSE("GPL v2");
+MODULE_VERSION("0.1");
-- 
1.7.10.4

