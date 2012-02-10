Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: [PATCH v2 15/18] sh/PCI: get rid of device resource fixups
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arch@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>
Date: Thu, 09 Feb 2012 19:37:38 -0700
Message-ID: <20120210023738.10311.36556.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120210023424.10311.82445.stgit@bhelgaas.mtv.corp.google.com>
References: <20120210023424.10311.82445.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Tell the PCI core about host bridge address translation so it can take
care of bus-to-resource conversion for us.

CC: Paul Mundt <lethal@linux-sh.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/sh/drivers/pci/pci.c |   75 +++++++--------------------------------------
 arch/sh/include/asm/pci.h |    6 +---
 2 files changed, 12 insertions(+), 69 deletions(-)

diff --git a/arch/sh/drivers/pci/pci.c b/arch/sh/drivers/pci/pci.c
index 1e7b0e2..9d10a3c 100644
--- a/arch/sh/drivers/pci/pci.c
+++ b/arch/sh/drivers/pci/pci.c
@@ -37,11 +37,20 @@ static void __devinit pcibios_scanbus(struct pci_channel *hose)
 	static int next_busno;
 	static int need_domain_info;
 	LIST_HEAD(resources);
+	struct resource *res;
+	resource_size_t offset;
 	int i;
 	struct pci_bus *bus;
 
-	for (i = 0; i < hose->nr_resources; i++)
-		pci_add_resource(&resources, hose->resources + i);
+	for (i = 0; i < hose->nr_resources; i++) {
+		res = hose->resources + i;
+		offset = 0;
+		if (res->flags & IORESOURCE_IO)
+			offset = hose->io_offset;
+		else if (res->flags & IORESOURCE_MEM)
+			offset = hose->mem_offset;
+		pci_add_resource_offset(&resources, res, offset);
+	}
 
 	bus = pci_scan_root_bus(NULL, next_busno, hose->pci_ops, hose,
 				&resources);
@@ -143,42 +152,12 @@ static int __init pcibios_init(void)
 }
 subsys_initcall(pcibios_init);
 
-static void pcibios_fixup_device_resources(struct pci_dev *dev,
-	struct pci_bus *bus)
-{
-	/* Update device resources.  */
-	struct pci_channel *hose = bus->sysdata;
-	unsigned long offset = 0;
-	int i;
-
-	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
-		if (!dev->resource[i].start)
-			continue;
-		if (dev->resource[i].flags & IORESOURCE_IO)
-			offset = hose->io_offset;
-		else if (dev->resource[i].flags & IORESOURCE_MEM)
-			offset = hose->mem_offset;
-
-		dev->resource[i].start += offset;
-		dev->resource[i].end += offset;
-	}
-}
-
 /*
  *  Called after each bus is probed, but before its children
  *  are examined.
  */
 void __devinit pcibios_fixup_bus(struct pci_bus *bus)
 {
-	struct pci_dev *dev;
-	struct list_head *ln;
-
-	for (ln = bus->devices.next; ln != &bus->devices; ln = ln->next) {
-		dev = pci_dev_b(ln);
-
-		if ((dev->class >> 8) != PCI_CLASS_BRIDGE_PCI)
-			pcibios_fixup_device_resources(dev, bus);
-	}
 }
 
 /*
@@ -208,36 +187,6 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 	return start;
 }
 
-void pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
-			     struct resource *res)
-{
-	struct pci_channel *hose = dev->sysdata;
-	unsigned long offset = 0;
-
-	if (res->flags & IORESOURCE_IO)
-		offset = hose->io_offset;
-	else if (res->flags & IORESOURCE_MEM)
-		offset = hose->mem_offset;
-
-	region->start = res->start - offset;
-	region->end = res->end - offset;
-}
-
-void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
-			     struct pci_bus_region *region)
-{
-	struct pci_channel *hose = dev->sysdata;
-	unsigned long offset = 0;
-
-	if (res->flags & IORESOURCE_IO)
-		offset = hose->io_offset;
-	else if (res->flags & IORESOURCE_MEM)
-		offset = hose->mem_offset;
-
-	res->start = region->start + offset;
-	res->end = region->end + offset;
-}
-
 int pcibios_enable_device(struct pci_dev *dev, int mask)
 {
 	return pci_enable_resources(dev, mask);
@@ -381,8 +330,6 @@ EXPORT_SYMBOL(pci_iounmap);
 #endif /* CONFIG_GENERIC_IOMAP */
 
 #ifdef CONFIG_HOTPLUG
-EXPORT_SYMBOL(pcibios_resource_to_bus);
-EXPORT_SYMBOL(pcibios_bus_to_resource);
 EXPORT_SYMBOL(PCIBIOS_MIN_IO);
 EXPORT_SYMBOL(PCIBIOS_MIN_MEM);
 #endif
diff --git a/arch/sh/include/asm/pci.h b/arch/sh/include/asm/pci.h
index cb21e23..3b5b6ab 100644
--- a/arch/sh/include/asm/pci.h
+++ b/arch/sh/include/asm/pci.h
@@ -114,11 +114,7 @@ static inline void pci_dma_burst_advice(struct pci_dev *pdev,
 /* Board-specific fixup routines. */
 int pcibios_map_platform_irq(const struct pci_dev *dev, u8 slot, u8 pin);
 
-extern void pcibios_resource_to_bus(struct pci_dev *dev,
-	struct pci_bus_region *region, struct resource *res);
-
-extern void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
-				    struct pci_bus_region *region);
+#define ARCH_HAS_GENERIC_PCI_OFFSETS
 
 #define pci_domain_nr(bus) ((struct pci_channel *)(bus)->sysdata)->index
 

