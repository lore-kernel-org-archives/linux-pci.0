Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: [PATCH v3 19/34] alpha/PCI: get rid of device resource fixups
To: Jesse Barnes <jbarnes@virtuousgeek.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arch@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-alpha@vger.kernel.org
Date: Wed, 07 Mar 2012 15:33:41 -0700
Message-ID: <20120307223341.25669.45002.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120307222436.25669.52282.stgit@bhelgaas.mtv.corp.google.com>
References: <20120307222436.25669.52282.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Tell the PCI core about host bridge address translation so it can take
care of bus-to-resource conversion for us.

CC: linux-alpha@vger.kernel.org
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/alpha/include/asm/pci.h |    6 +---
 arch/alpha/kernel/pci.c      |   71 ++----------------------------------------
 2 files changed, 5 insertions(+), 72 deletions(-)

diff --git a/arch/alpha/include/asm/pci.h b/arch/alpha/include/asm/pci.h
index 6a3fe07..121c797 100644
--- a/arch/alpha/include/asm/pci.h
+++ b/arch/alpha/include/asm/pci.h
@@ -100,11 +100,7 @@ static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
 	return channel ? 15 : 14;
 }
 
-extern void pcibios_resource_to_bus(struct pci_dev *, struct pci_bus_region *,
-				    struct resource *);
-
-extern void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
-				    struct pci_bus_region *region);
+#define ARCH_HAS_GENERIC_PCI_OFFSETS
 
 #define pci_domain_nr(bus) ((struct pci_controller *)(bus)->sysdata)->index
 
diff --git a/arch/alpha/kernel/pci.c b/arch/alpha/kernel/pci.c
index 3a5cdf2..1a62963 100644
--- a/arch/alpha/kernel/pci.c
+++ b/arch/alpha/kernel/pci.c
@@ -251,32 +251,6 @@ pci_restore_srm_config(void)
 #endif
 
 void __devinit
-pcibios_fixup_resource(struct resource *res, struct resource *root)
-{
-	res->start += root->start;
-	res->end += root->start;
-}
-
-void __devinit
-pcibios_fixup_device_resources(struct pci_dev *dev, struct pci_bus *bus)
-{
-	/* Update device resources.  */
-	struct pci_controller *hose = (struct pci_controller *)bus->sysdata;
-	int i;
-
-	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
-		if (!dev->resource[i].start)
-			continue;
-		if (dev->resource[i].flags & IORESOURCE_IO)
-			pcibios_fixup_resource(&dev->resource[i],
-					       hose->io_space);
-		else if (dev->resource[i].flags & IORESOURCE_MEM)
-			pcibios_fixup_resource(&dev->resource[i],
-					       hose->mem_space);
-	}
-}
-
-void __devinit
 pcibios_fixup_bus(struct pci_bus *bus)
 {
 	struct pci_dev *dev = bus->self;
@@ -284,13 +258,10 @@ pcibios_fixup_bus(struct pci_bus *bus)
 	if (pci_has_flag(PCI_PROBE_ONLY) && dev &&
  		   (dev->class >> 8) == PCI_CLASS_BRIDGE_PCI) {
  		pci_read_bridge_bases(bus);
- 		pcibios_fixup_device_resources(dev, bus);
 	} 
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		pdev_save_srm_config(dev);
-		if ((dev->class >> 8) != PCI_CLASS_BRIDGE_PCI)
-			pcibios_fixup_device_resources(dev, bus);
 	}
 }
 
@@ -300,42 +271,6 @@ pcibios_update_irq(struct pci_dev *dev, int irq)
 	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq);
 }
 
-void
-pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
-			 struct resource *res)
-{
-	struct pci_controller *hose = (struct pci_controller *)dev->sysdata;
-	unsigned long offset = 0;
-
-	if (res->flags & IORESOURCE_IO)
-		offset = hose->io_space->start;
-	else if (res->flags & IORESOURCE_MEM)
-		offset = hose->mem_space->start;
-
-	region->start = res->start - offset;
-	region->end = res->end - offset;
-}
-
-void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
-			     struct pci_bus_region *region)
-{
-	struct pci_controller *hose = (struct pci_controller *)dev->sysdata;
-	unsigned long offset = 0;
-
-	if (res->flags & IORESOURCE_IO)
-		offset = hose->io_space->start;
-	else if (res->flags & IORESOURCE_MEM)
-		offset = hose->mem_space->start;
-
-	res->start = region->start + offset;
-	res->end = region->end + offset;
-}
-
-#ifdef CONFIG_HOTPLUG
-EXPORT_SYMBOL(pcibios_resource_to_bus);
-EXPORT_SYMBOL(pcibios_bus_to_resource);
-#endif
-
 int
 pcibios_enable_device(struct pci_dev *dev, int mask)
 {
@@ -415,8 +350,10 @@ common_init_pci(void)
 			hose->mem_space->end = end;
 
 		INIT_LIST_HEAD(&resources);
-		pci_add_resource(&resources, hose->io_space);
-		pci_add_resource(&resources, hose->mem_space);
+		pci_add_resource_offset(&resources, hose->io_space,
+					hose->io_space->start);
+		pci_add_resource_offset(&resources, hose->mem_space,
+					hose->mem_space->start);
 
 		bus = pci_scan_root_bus(NULL, next_busno, alpha_mv.pci_ops,
 					hose, &resources);

