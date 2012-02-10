Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: [PATCH v2 11/18] mips/PCI: get rid of device resource fixups
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arch@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
	Yoichi Yuasa <yuasa@linux-mips.org>
Date: Thu, 09 Feb 2012 19:37:17 -0700
Message-ID: <20120210023717.10311.37310.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120210023424.10311.82445.stgit@bhelgaas.mtv.corp.google.com>
References: <20120210023424.10311.82445.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Tell the PCI core about host bridge address translation so it can take
care of bus-to-resource conversion for us.

Here's the wrinkle on Cobalt: we can't generate normal I/O port addresses
on PCI because the GT-64111 doesn't do any address translation, so we have
this:

  CPU I/O port addresses		[io 0x0000-0xffffff]
  PCI bus I/O port addresses	[io 0x10000000-0x10ffffff]

Legacy-mode IDE controllers start out with the legacy bus addresses, e.g.,
0x1f0, assigned by pci_setup_device().  These are outside the range of
addresses GT-64111 can generate on PCI, but pcibios_fixup_device_resources()
converted them to CPU addresses anyway by adding io_offset.  Therefore, we
had to pre-adjust them in cobalt_legacy_ide_fixup().

With io_offset = 0xf0000000, we had this:

  res->start = 0x1f0	initialized in pci_setup_device()
  res->start = 0x100001f0	-= io_offset in cobalt_legacy_ide_fixup()
  res->start = 0x1f0	+= io_offset in pcibios_fixup_device_resources()

The difference after this patch is that the generic pci_bus_to_resource()
only adds the offset if the bus address is inside a host bridge window.
Since 0x1f0 is not a valid bus address and is not inside any windows, it is
unaffected, so we now have this:

  region->start = 0x1f0	initialized in pci_setup_device()
  res->start = 0x1f0	no offset by pci_bus_to_resource()

That means we can remove both pcibios_fixup_device_resources() and
cobalt_legacy_ide_fixup().

I would *rather* set the host bridge offset to zero (which corresponds
to what the GT-64111 actually does), and have both CPU and PCI addresses
of [io 0x10000000-0x10ffffff].  However, that would require changes to
generic code that assumes legacy I/O addresses, such as pic1_io_resource
([io 0x0020-0x00021]), and we'd have to keep a Cobalt IDE fixup.

Of course, none of this changes the fact that references to I/O port
0x1f0 actually go to port 0x100001f0, not 0x1f0, on the Cobalt PCI bus.
Fortunately the VT82C586 IDE controller only decodes the low 24 address
bits, so it does work.

CC: Ralf Baechle <ralf@linux-mips.org>
CC: Yoichi Yuasa <yuasa@linux-mips.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/mips/include/asm/pci.h  |    6 +---
 arch/mips/pci/fixup-cobalt.c |   61 -------------------------------------
 arch/mips/pci/pci.c          |   70 ++----------------------------------------
 3 files changed, 4 insertions(+), 133 deletions(-)

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
 
diff --git a/arch/mips/pci/fixup-cobalt.c b/arch/mips/pci/fixup-cobalt.c
index acacd14..9553b14 100644
--- a/arch/mips/pci/fixup-cobalt.c
+++ b/arch/mips/pci/fixup-cobalt.c
@@ -51,67 +51,6 @@ static void qube_raq_galileo_early_fixup(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_MARVELL, PCI_DEVICE_ID_MARVELL_GT64111,
 	 qube_raq_galileo_early_fixup);
 
-static void __devinit cobalt_legacy_ide_resource_fixup(struct pci_dev *dev,
-						       struct resource *res)
-{
-	struct pci_controller *hose = (struct pci_controller *)dev->sysdata;
-	unsigned long offset = hose->io_offset;
-	struct resource orig = *res;
-
-	if (!(res->flags & IORESOURCE_IO) ||
-	    !(res->flags & IORESOURCE_PCI_FIXED))
-		return;
-
-	res->start -= offset;
-	res->end -= offset;
-	dev_printk(KERN_DEBUG, &dev->dev, "converted legacy %pR to bus %pR\n",
-		   &orig, res);
-}
-
-static void __devinit cobalt_legacy_ide_fixup(struct pci_dev *dev)
-{
-	u32 class;
-	u8 progif;
-
-	/*
-	 * If the IDE controller is in legacy mode, pci_setup_device() fills in
-	 * the resources with the legacy addresses that normally appear on the
-	 * PCI bus, just as if we had read them from a BAR.
-	 *
-	 * However, with the GT-64111, those legacy addresses, e.g., 0x1f0,
-	 * will never appear on the PCI bus because it converts memory accesses
-	 * in the PCI I/O region (which is never at address zero) into I/O port
-	 * accesses with no address translation.
-	 *
-	 * For example, if GT_DEF_PCI0_IO_BASE is 0x10000000, a load or store
-	 * to physical address 0x100001f0 will become a PCI access to I/O port
-	 * 0x100001f0.  There's no way to generate an access to I/O port 0x1f0,
-	 * but the VT82C586 IDE controller does respond at 0x100001f0 because
-	 * it only decodes the low 24 bits of the address.
-	 *
-	 * When this quirk runs, the pci_dev resources should contain bus
-	 * addresses, not Linux I/O port numbers, so convert legacy addresses
-	 * like 0x1f0 to bus addresses like 0x100001f0.  Later, we'll convert
-	 * them back with pcibios_fixup_bus() or pcibios_bus_to_resource().
-	 */
-	class = dev->class >> 8;
-	if (class != PCI_CLASS_STORAGE_IDE)
-		return;
-
-	pci_read_config_byte(dev, PCI_CLASS_PROG, &progif);
-	if ((progif & 1) == 0) {
-		cobalt_legacy_ide_resource_fixup(dev, &dev->resource[0]);
-		cobalt_legacy_ide_resource_fixup(dev, &dev->resource[1]);
-	}
-	if ((progif & 4) == 0) {
-		cobalt_legacy_ide_resource_fixup(dev, &dev->resource[2]);
-		cobalt_legacy_ide_resource_fixup(dev, &dev->resource[3]);
-	}
-}
-
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_1,
-	  cobalt_legacy_ide_fixup);
-
 static void qube_raq_via_bmIDE_fixup(struct pci_dev *dev)
 {
 	unsigned short cfgword;
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

