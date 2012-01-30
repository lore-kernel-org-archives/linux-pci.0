Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: [RFC PATCH v1 11/18] mips/PCI: get rid of device resource fixups
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arch@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
	Yoichi Yuasa <yuasa@linux-mips.org>
Date: Mon, 30 Jan 2012 09:58:05 -0700
Message-ID: <20120130165805.3231.99160.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120130165430.3231.97740.stgit@bhelgaas.mtv.corp.google.com>
References: <20120130165430.3231.97740.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Tell the PCI core about host bridge address translation so it can take
care of bus-to-resource conversion for us.

N.B. cobalt_legacy_ide_fixup() does scary things with resources, but I
*think* it will still work because we're still making the same adjustments,
just in the opposite order.  Here are the legacy IDE resource.start
values I expect:

         current                                        new

           0x1f0   (pci_setup_device)                 0x1f0
                   (pci_bus_to_resource)       + 0xf0000000
    - 0xf0000000   (cobalt_legacy_ide_fixup)   - 0xf0000000
    + 0xf0000000   (pcibios_fixup_bus)
    ------------                               ------------
           0x1f0    final value                       0x1f0

CC: Ralf Baechle <ralf@linux-mips.org>
CC: Yoichi Yuasa <yuasa@linux-mips.org>
---
 arch/mips/include/asm/pci.h |    6 +---
 arch/mips/pci/pci.c         |   70 ++-----------------------------------------
 2 files changed, 4 insertions(+), 72 deletions(-)

diff --git a/arch/mips/include/asm/pci.h b/arch/mips/include/asm/pci.h
index 576397c..2be0c69 100644
--- a/arch/mips/include/asm/pci.h
+++ b/arch/mips/include/asm/pci.h
@@ -112,11 +112,7 @@ static inline void pci_dma_burst_advice(struct pci_dev *pdev,
 }
 #endif
 
-extern void pcibios_resource_to_bus(struct pci_dev *dev,
-	struct pci_bus_region *region, struct resource *res);
-
-extern void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
-				    struct pci_bus_region *region);
+#define ARCH_HAS_GENERIC_PCI_OFFSETS
 
 #define pci_domain_nr(bus) ((struct pci_controller *)(bus)->sysdata)->index
 
diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index aec2b11..cab58e6 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -95,8 +95,9 @@ static void __devinit pcibios_scanbus(struct pci_controller *hose)
 	if (hose->get_busno && pci_probe_only)
 		next_busno = (*hose->get_busno)();
 
-	pci_add_resource(&resources, hose->mem_resource);
-	pci_add_resource(&resources, hose->io_resource);
+	pci_add_resource_offset(&resources,
+				hose->mem_resource, hose->mem_offset);
+	pci_add_resource_offset(&resources, hose->io_resource, hose->io_offset);
 	bus = pci_scan_root_bus(NULL, next_busno, hose->pci_ops, hose,
 				&resources);
 	if (!bus)
@@ -254,45 +255,13 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
 	return pcibios_plat_dev_init(dev);
 }
 
-static void pcibios_fixup_device_resources(struct pci_dev *dev,
-	struct pci_bus *bus)
-{
-	/* Update device resources.  */
-	struct pci_controller *hose = (struct pci_controller *)bus->sysdata;
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
 void __devinit pcibios_fixup_bus(struct pci_bus *bus)
 {
-	/* Propagate hose info into the subordinate devices.  */
-
-	struct list_head *ln;
 	struct pci_dev *dev = bus->self;
 
 	if (pci_probe_only && dev &&
 	    (dev->class >> 8) == PCI_CLASS_BRIDGE_PCI) {
 		pci_read_bridge_bases(bus);
-		pcibios_fixup_device_resources(dev, bus);
-	}
-
-	for (ln = bus->devices.next; ln != &bus->devices; ln = ln->next) {
-		dev = pci_dev_b(ln);
-
-		if ((dev->class >> 8) != PCI_CLASS_BRIDGE_PCI)
-			pcibios_fixup_device_resources(dev, bus);
 	}
 }
 
@@ -302,40 +271,7 @@ pcibios_update_irq(struct pci_dev *dev, int irq)
 	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq);
 }
 
-void pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
-			 struct resource *res)
-{
-	struct pci_controller *hose = (struct pci_controller *)dev->sysdata;
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
-void __devinit
-pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
-			struct pci_bus_region *region)
-{
-	struct pci_controller *hose = (struct pci_controller *)dev->sysdata;
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
 #ifdef CONFIG_HOTPLUG
-EXPORT_SYMBOL(pcibios_resource_to_bus);
-EXPORT_SYMBOL(pcibios_bus_to_resource);
 EXPORT_SYMBOL(PCIBIOS_MIN_IO);
 EXPORT_SYMBOL(PCIBIOS_MIN_MEM);
 #endif

