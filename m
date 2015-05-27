Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from xspv0103.northgrum.com ([134.223.120.78]:57497 "EHLO
	xspv0103.northgrum.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751760AbbE0VMN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 May 2015 17:12:13 -0400
From: "Tang, Jason (ES)" <Jason.Tang2@ngc.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>
Subject: [PATCH v0 11/13] PCI: Reassign device's MMIO BARs
Date: Wed, 27 May 2015 20:59:48 +0000
Message-ID: <0fdcbf1644314391b6dfd512b2975839@XCGVAG27.northgrum.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If the upstream bridge has a static enumeration profile, then reassign
all of the device's MMIO BARs to fit within the upstream bridge's
memory space. Use a first-fit algorithm to minimize memory holes.

Signed-off-by: Jason Tang <jason.tang2@ngc.com>
---
 drivers/pci/pci_static_enum.c |  175 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 175 insertions(+)

diff --git a/drivers/pci/pci_static_enum.c b/drivers/pci/pci_static_enum.c
index f000c7f..50f4db4 100644
--- a/drivers/pci/pci_static_enum.c
+++ b/drivers/pci/pci_static_enum.c
@@ -21,6 +21,12 @@
 
 static DEFINE_SPINLOCK(static_enum_lock);
 
+struct pci_static_enum_memspace {
+	struct list_head list;
+	resource_size_t start;
+	resource_size_t size;
+};
+
 struct pci_static_enum_setting {
 	struct list_head list;
 	int seg;
@@ -29,6 +35,7 @@ struct pci_static_enum_setting {
 	unsigned char secondary_bus;
 	unsigned char subordinate_bus;
 	resource_size_t bridgemem_start, bridgemem_end;
+	struct list_head memspace;
 };
 
 LIST_HEAD(settings_list);
@@ -124,6 +131,7 @@ static int pci_static_enum_parse_options(void)
 			setting->seg = seg;
 			setting->bus = bus;
 			setting->devfn = PCI_DEVFN(slot, func);
+			INIT_LIST_HEAD(&setting->memspace);
 			list_add(&setting->list, &settings_list);
 		}
 
@@ -138,9 +146,18 @@ static int pci_static_enum_parse_options(void)
 			} else
 			    if (sscanf(p, "M%llx-%llx%n", &start, &end, &count)
 				== 2 && count > 0) {
+				struct pci_static_enum_memspace *mem;
 				p += count;
 				setting->bridgemem_start = start;
 				setting->bridgemem_end = end;
+				mem = kmalloc(sizeof(*mem), GFP_KERNEL);
+				if (!mem) {
+					pr_err(PREFIX "Out of memory\n");
+					return -1;
+				}
+				mem->start = start;
+				mem->size = end - start + 1;
+				list_add_tail(&mem->list, &setting->memspace);
 			} else {
 				pr_err(PREFIX "Invalid enum option: `%s'\n", p);
 				return -1;
@@ -358,6 +375,149 @@ static void pci_static_enum_set_bridge_memory(struct pci_dev *dev, struct pci_st
 }
 
 /**
+ * pci_static_enum_assign_space() - search for aligned memory
+ * @setting: device's static enumeration profile
+ * @requested_size: number of bytes requested by a BAR
+ *
+ * Use a first-fit algorithm to find a memory that is properly
+ * aligned. Reserve that memory for a BAR, and then update the free
+ * space list.
+ *
+ * Return: starting 32-bit address for memory, or 0 if insufficient
+ * space.
+ */
+static u32 pci_static_enum_assign_space(struct pci_static_enum_setting *setting,
+					u32 requested_size)
+{
+	struct pci_static_enum_memspace *mem;
+	int found_space = 0;
+	resource_size_t start_addr;
+
+	list_for_each_entry(mem, &setting->memspace, list) {
+		/* make sure that free space is aligned */
+		start_addr = ALIGN(mem->start, requested_size);
+		if (start_addr + requested_size < mem->start + mem->size) {
+			found_space = 1;
+			break;
+		}
+	}
+
+	if (!found_space)
+		return 0;
+
+	/* update the free space list */
+	if (start_addr == mem->start && requested_size == mem->size) {
+		/* delete block */
+		list_del(&mem->list);
+		kfree(mem);
+	} else if (start_addr == mem->start) {
+		/* trim from start */
+		mem->start += requested_size;
+		mem->size -= requested_size;
+	} else if (start_addr + requested_size == mem->start + mem->size) {
+		/* trim from end */
+		mem->size -= requested_size;
+	} else {
+		/* split block */
+		struct pci_static_enum_memspace *mem2;
+
+		mem2 = kmalloc(sizeof(*mem), GFP_KERNEL);
+		mem2->start = start_addr + requested_size;
+		mem2->size = start_addr + mem->size - mem2->start;
+		mem->size = mem2->start - mem->start;
+		list_add(&mem2->list, &mem->list);
+	}
+	return (u32) start_addr;
+}
+
+#define PCI_COMMAND_DECODE_ENABLE	(PCI_COMMAND_MEMORY | PCI_COMMAND_IO)
+
+/**
+ * pci_static_enum_reset_mmio_bar() - scan a particular BAR on a PCI
+ * device, reassigning the BAR if it is for a MMIO memory space
+ * @dev: PCI device to override
+ * @setting: static enumeration profile of the device's upstream bus
+ * @reg: offset into dev's configuration space, from which to read BAR
+ * value
+ */
+static void pci_static_enum_reset_mmio_bar(struct pci_dev *dev, struct pci_static_enum_setting
+					   *setting, unsigned int reg)
+{
+	u32 orig_bar, sz;
+	u32 requested_size = 0;
+	u32 assigned_addr = 0;
+	u16 orig_cmd;
+
+	if (!dev->mmio_always_on) {
+		pci_read_config_word(dev, PCI_COMMAND, &orig_cmd);
+		if (orig_cmd & PCI_COMMAND_DECODE_ENABLE)
+			pci_write_config_word(dev, PCI_COMMAND,
+					      orig_cmd &
+					      ~PCI_COMMAND_DECODE_ENABLE);
+	}
+
+	/* fetch amount of address space needed by this PCI device */
+	pci_read_config_dword(dev, reg, &orig_bar);
+	pci_write_config_dword(dev, reg, ~0);
+	pci_read_config_dword(dev, reg, &sz);
+	pci_write_config_dword(dev, reg, orig_bar);
+
+	/* if no size is set, or size is invalid, or this BAR is for
+	   I/O, then leave this BAR untouched */
+	if (!sz || sz == 0xffffffff || (sz & PCI_BASE_ADDRESS_SPACE_IO))
+		goto out;
+
+	/* ignore prefetch memory and 64-bit BARs, for now */
+	if ((sz & PCI_BASE_ADDRESS_MEM_PREFETCH))
+		goto out;
+
+	if ((sz & PCI_BASE_ADDRESS_MEM_TYPE_MASK) ==
+	    PCI_BASE_ADDRESS_MEM_TYPE_64)
+		goto out;
+
+	requested_size = ~(((u32) PCI_BASE_ADDRESS_MEM_MASK) & sz) + 1;
+	assigned_addr = pci_static_enum_assign_space(setting, requested_size);
+	if (assigned_addr > 0)
+		pci_write_config_dword(dev, reg, assigned_addr);
+
+out:
+	if (!dev->mmio_always_on && (orig_cmd & PCI_COMMAND_DECODE_ENABLE))
+		pci_write_config_word(dev, PCI_COMMAND, orig_cmd);
+}
+
+/**
+ * pci_static_enum_set_mmio_bars() - scan each BAR for this device,
+ * reassigning MMIO memory spaces
+ * @dev: PCI device to override
+ * @setting: static enumeration profile of the device's upstream bus
+ */
+static void pci_static_enum_set_mmio_bars(struct pci_dev *dev, struct pci_static_enum_setting
+					  *setting)
+{
+	unsigned int howmany, pos, reg;
+
+	switch (dev->hdr_type) {
+	case PCI_HEADER_TYPE_NORMAL:
+		howmany = 6;
+		break;
+	case PCI_HEADER_TYPE_BRIDGE:
+		howmany = 2;
+		break;
+	default:
+		howmany = 1;
+		break;
+	}
+
+	/* for MMIO bars, find first allocation that fits within
+	   upstream's bus */
+	dev_dbg(&dev->dev, "Reassigning MMIO bars\n");
+	for (pos = 0; pos < howmany; pos++) {
+		reg = PCI_BASE_ADDRESS_0 + (pos << 2);
+		pci_static_enum_reset_mmio_bar(dev, setting, reg);
+	}
+}
+
+/**
  * pci_static_enum_device() - override a device's memory
  * configuration, according to its static enumeration profile
  * @dev: PCI device to override
@@ -365,6 +525,7 @@ static void pci_static_enum_set_bridge_memory(struct pci_dev *dev, struct pci_st
 void pci_static_enum_device(struct pci_dev *dev)
 {
 	struct pci_static_enum_setting *setting;
+	struct pci_dev *parent;
 
 	/* if dev is a bridge, set its memory regions */
 	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
@@ -374,4 +535,18 @@ void pci_static_enum_device(struct pci_dev *dev)
 		if (setting && setting->bridgemem_start)
 			pci_static_enum_set_bridge_memory(dev, setting);
 	}
+
+	/*
+	 * if dev's parent bus has a static enumeration profile, then
+	 * reassign BARS to fit within the parent's memory regions
+	 */
+	parent = pci_upstream_bridge(dev);
+
+	if (parent) {
+		setting = pci_static_enum_find_setting(pci_domain_nr(dev->bus),
+						       parent->bus->number,
+						       parent->devfn);
+		if (setting)
+			pci_static_enum_set_mmio_bars(dev, setting);
+	}
 }
-- 
1.7.9.5

