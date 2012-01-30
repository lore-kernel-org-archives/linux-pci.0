Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: [RFC PATCH v1 13/18] parisc/PCI: get rid of device resource fixups
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arch@vger.kernel.org, linux-parisc@vger.kernel.org
Date: Mon, 30 Jan 2012 09:58:15 -0700
Message-ID: <20120130165815.3231.81322.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120130165430.3231.97740.stgit@bhelgaas.mtv.corp.google.com>
References: <20120130165430.3231.97740.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Tell the PCI core about host bridge address translation so it can take
care of bus-to-resource conversion for us.

N.B. parisc has far more complicated code for bus/resource conversion than
most arches.  I don't think the actual hardware behavior is any more
complicated, and I tried to compute the simple offset between the bus
address and the CPU address, but it's likely that I didn't get all the
details just right here, and I haven't been able to test it.

CC: linux-parisc@vger.kernel.org
---
 arch/parisc/include/asm/pci.h |   38 +-----------------------------
 arch/parisc/kernel/pci.c      |   52 -----------------------------------------
 drivers/parisc/dino.c         |   27 +++++----------------
 drivers/parisc/lba_pci.c      |   31 +++++-------------------
 4 files changed, 13 insertions(+), 135 deletions(-)

diff --git a/arch/parisc/include/asm/pci.h b/arch/parisc/include/asm/pci.h
index 2242a5c..a8b591f 100644
--- a/arch/parisc/include/asm/pci.h
+++ b/arch/parisc/include/asm/pci.h
@@ -82,38 +82,8 @@ struct pci_hba_data {
 
 #ifdef CONFIG_64BIT
 #define PCI_F_EXTEND		0xffffffff00000000UL
-#define PCI_IS_LMMIO(hba,a)	pci_is_lmmio(hba,a)
-
-/* We need to know if an address is LMMMIO or GMMIO.
- * LMMIO requires mangling and GMMIO we must use as-is.
- */
-static __inline__  int pci_is_lmmio(struct pci_hba_data *hba, unsigned long a)
-{
-	return(((a) & PCI_F_EXTEND) == PCI_F_EXTEND);
-}
-
-/*
-** Convert between PCI (IO_VIEW) addresses and processor (PA_VIEW) addresses.
-** See pci.c for more conversions used by Generic PCI code.
-**
-** Platform characteristics/firmware guarantee that
-**	(1) PA_VIEW - IO_VIEW = lmmio_offset for both LMMIO and ELMMIO
-**	(2) PA_VIEW == IO_VIEW for GMMIO
-*/
-#define PCI_BUS_ADDR(hba,a)	(PCI_IS_LMMIO(hba,a)	\
-		?  ((a) - hba->lmmio_space_offset)	/* mangle LMMIO */ \
-		: (a))					/* GMMIO */
-#define PCI_HOST_ADDR(hba,a)	(((a) & PCI_F_EXTEND) == 0 \
-		? (a) + hba->lmmio_space_offset \
-		: (a))
-
 #else	/* !CONFIG_64BIT */
-
-#define PCI_BUS_ADDR(hba,a)	(a)
-#define PCI_HOST_ADDR(hba,a)	(a)
 #define PCI_F_EXTEND		0UL
-#define PCI_IS_LMMIO(hba,a)	(1)	/* 32-bit doesn't support GMMIO */
-
 #endif /* !CONFIG_64BIT */
 
 /*
@@ -245,13 +215,7 @@ static inline void pci_dma_burst_advice(struct pci_dev *pdev,
 }
 #endif
 
-extern void
-pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
-			 struct resource *res);
-
-extern void
-pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
-			struct pci_bus_region *region);
+#define ARCH_HAS_GENERIC_PCI_OFFSETS
 
 static inline void pcibios_penalize_isa_irq(int irq, int active)
 {
diff --git a/arch/parisc/kernel/pci.c b/arch/parisc/kernel/pci.c
index 9efd974..74d544b 100644
--- a/arch/parisc/kernel/pci.c
+++ b/arch/parisc/kernel/pci.c
@@ -195,58 +195,6 @@ void __init pcibios_init_bus(struct pci_bus *bus)
 	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, bridge_ctl);
 }
 
-/* called by drivers/pci/setup-bus.c:pci_setup_bridge().  */
-void __devinit pcibios_resource_to_bus(struct pci_dev *dev,
-		struct pci_bus_region *region, struct resource *res)
-{
-#ifdef CONFIG_64BIT
-	struct pci_hba_data *hba = HBA_DATA(dev->bus->bridge->platform_data);
-#endif
-
-	if (res->flags & IORESOURCE_IO) {
-		/*
-		** I/O space may see busnumbers here. Something
-		** in the form of 0xbbxxxx where bb is the bus num
-		** and xxxx is the I/O port space address.
-		** Remaining address translation are done in the
-		** PCI Host adapter specific code - ie dino_out8.
-		*/
-		region->start = PCI_PORT_ADDR(res->start);
-		region->end   = PCI_PORT_ADDR(res->end);
-	} else if (res->flags & IORESOURCE_MEM) {
-		/* Convert MMIO addr to PCI addr (undo global virtualization) */
-		region->start = PCI_BUS_ADDR(hba, res->start);
-		region->end   = PCI_BUS_ADDR(hba, res->end);
-	}
-
-	DBG_RES("pcibios_resource_to_bus(%02x %s [%lx,%lx])\n",
-		dev->bus->number, res->flags & IORESOURCE_IO ? "IO" : "MEM",
-		region->start, region->end);
-}
-
-void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
-			      struct pci_bus_region *region)
-{
-#ifdef CONFIG_64BIT
-	struct pci_hba_data *hba = HBA_DATA(dev->bus->bridge->platform_data);
-#endif
-
-	if (res->flags & IORESOURCE_MEM) {
-		res->start = PCI_HOST_ADDR(hba, region->start);
-		res->end = PCI_HOST_ADDR(hba, region->end);
-	}
-
-	if (res->flags & IORESOURCE_IO) {
-		res->start = region->start;
-		res->end = region->end;
-	}
-}
-
-#ifdef CONFIG_HOTPLUG
-EXPORT_SYMBOL(pcibios_resource_to_bus);
-EXPORT_SYMBOL(pcibios_bus_to_resource);
-#endif
-
 /*
  * pcibios align resources() is called every time generic PCI code
  * wants to generate a new address. The process of looking for
diff --git a/drivers/parisc/dino.c b/drivers/parisc/dino.c
index 7ff10c1..0610e91 100644
--- a/drivers/parisc/dino.c
+++ b/drivers/parisc/dino.c
@@ -553,7 +553,6 @@ dino_fixup_bus(struct pci_bus *bus)
 	struct list_head *ln;
         struct pci_dev *dev;
         struct dino_device *dino_dev = DINO_DEV(parisc_walk_tree(bus->bridge));
-	int port_base = HBA_PORT_BASE(dino_dev->hba.hba_num);
 
 	DBG(KERN_WARNING "%s(0x%p) bus %d platform_data 0x%p\n",
 	    __func__, bus, bus->secondary,
@@ -599,8 +598,6 @@ dino_fixup_bus(struct pci_bus *bus)
 
 
 	list_for_each(ln, &bus->devices) {
-		int i;
-
 		dev = pci_dev_b(ln);
 		if (is_card_dino(&dino_dev->hba.dev->id))
 			dino_card_fixup(dev);
@@ -612,21 +609,6 @@ dino_fixup_bus(struct pci_bus *bus)
 		if ((dev->class >> 8) == PCI_CLASS_BRIDGE_PCI)
 			continue;
 
-		/* Adjust the I/O Port space addresses */
-		for (i = 0; i < PCI_NUM_RESOURCES; i++) {
-			struct resource *res = &dev->resource[i];
-			if (res->flags & IORESOURCE_IO) {
-				res->start |= port_base;
-				res->end |= port_base;
-			}
-#ifdef __LP64__
-			/* Sign Extend MMIO addresses */
-			else if (res->flags & IORESOURCE_MEM) {
-				res->start |= F_EXTEND(0UL);
-				res->end   |= F_EXTEND(0UL);
-			}
-#endif
-		}
 		/* null out the ROM resource if there is one (we don't
 		 * care about an expansion rom on parisc, since it
 		 * usually contains (x86) bios code) */
@@ -991,11 +973,14 @@ static int __init dino_probe(struct parisc_device *dev)
 
 	dev->dev.platform_data = dino_dev;
 
-	pci_add_resource(&resources, &dino_dev->hba.io_space);
+	pci_add_resource_offset(&resources, &dino_dev->hba.io_space,
+				HBA_PORT_BASE(dino_dev->hba.hba_num));
 	if (dino_dev->hba.lmmio_space.flags)
-		pci_add_resource(&resources, &dino_dev->hba.lmmio_space);
+		pci_add_resource_offset(&resources, &dino_dev->hba.lmmio_space,
+					dino_dev->hba.lmmio_space_offset);
 	if (dino_dev->hba.elmmio_space.flags)
-		pci_add_resource(&resources, &dino_dev->hba.elmmio_space);
+		pci_add_resource_offset(&resources, &dino_dev->hba.elmmio_space,
+					dino_dev->hba.lmmio_space_offset);
 	if (dino_dev->hba.gmmio_space.flags)
 		pci_add_resource(&resources, &dino_dev->hba.gmmio_space);
 
diff --git a/drivers/parisc/lba_pci.c b/drivers/parisc/lba_pci.c
index d5f3d75..e885764 100644
--- a/drivers/parisc/lba_pci.c
+++ b/drivers/parisc/lba_pci.c
@@ -635,7 +635,6 @@ lba_fixup_bus(struct pci_bus *bus)
 	u16 status;
 #endif
 	struct lba_device *ldev = LBA_DEV(parisc_walk_tree(bus->bridge));
-	int lba_portbase = HBA_PORT_BASE(ldev->hba.hba_num);
 
 	DBG("lba_fixup_bus(0x%p) bus %d platform_data 0x%p\n",
 		bus, bus->secondary, bus->bridge->platform_data);
@@ -726,27 +725,6 @@ lba_fixup_bus(struct pci_bus *bus)
 			if (!res->start)
 				continue;
 
-			if (res->flags & IORESOURCE_IO) {
-				DBG("lba_fixup_bus() I/O Ports [%lx/%lx] -> ",
-					res->start, res->end);
-				res->start |= lba_portbase;
-				res->end   |= lba_portbase;
-				DBG("[%lx/%lx]\n", res->start, res->end);
-			} else if (res->flags & IORESOURCE_MEM) {
-				/*
-				** Convert PCI (IO_VIEW) addresses to
-				** processor (PA_VIEW) addresses
-				 */
-				DBG("lba_fixup_bus() MMIO [%lx/%lx] -> ",
-					res->start, res->end);
-				res->start = PCI_HOST_ADDR(HBA_DATA(ldev), res->start);
-				res->end   = PCI_HOST_ADDR(HBA_DATA(ldev), res->end);
-				DBG("[%lx/%lx]\n", res->start, res->end);
-			} else {
-				DBG("lba_fixup_bus() WTF? 0x%lx [%lx/%lx] XXX",
-					res->flags, res->start, res->end);
-			}
-
 			/*
 			** FIXME: this will result in whinging for devices
 			** that share expansion ROMs (think quad tulip), but
@@ -1514,11 +1492,14 @@ lba_driver_probe(struct parisc_device *dev)
 		lba_dev->hba.lmmio_space.flags = 0;
 	}
 
-	pci_add_resource(&resources, &lba_dev->hba.io_space);
+	pci_add_resource_offset(&resources, &lba_dev->hba.io_space,
+				HBA_PORT_BASE(lba_dev->hba.hba_num));
 	if (lba_dev->hba.elmmio_space.start)
-		pci_add_resource(&resources, &lba_dev->hba.elmmio_space);
+		pci_add_resource_offset(&resources, &lba_dev->hba.elmmio_space,
+					lba_dev->hba.lmmio_space_offset);
 	if (lba_dev->hba.lmmio_space.flags)
-		pci_add_resource(&resources, &lba_dev->hba.lmmio_space);
+		pci_add_resource_offset(&resources, &lba_dev->hba.lmmio_space,
+					lba_dev->hba.lmmio_space_offset);
 	if (lba_dev->hba.gmmio_space.flags)
 		pci_add_resource(&resources, &lba_dev->hba.gmmio_space);
 

