Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yw0-f74.google.com ([209.85.213.74]:38186 "EHLO
	mail-yw0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752867Ab2A3Q6m (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 30 Jan 2012 11:58:42 -0500
Received: by mail-yw0-f74.google.com with SMTP id j52so395332yhj.1
        for <linux-pci@vger.kernel.org>; Mon, 30 Jan 2012 08:58:42 -0800 (PST)
Subject: [RFC PATCH v1 18/18] PCI: collapse pcibios_resource_to_bus
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arch@vger.kernel.org
Date: Mon, 30 Jan 2012 09:58:41 -0700
Message-ID: <20120130165841.3231.32371.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120130165430.3231.97740.stgit@bhelgaas.mtv.corp.google.com>
References: <20120130165430.3231.97740.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Everybody uses the generic pcibios_resource_to_bus() supplied by the core
now, so remove the ARCH_HAS_GENERIC_PCI_OFFSETS used during conversion.
---
 arch/alpha/include/asm/pci.h      |    2 --
 arch/arm/include/asm/pci.h        |    2 --
 arch/ia64/include/asm/pci.h       |    2 --
 arch/microblaze/include/asm/pci.h |    2 --
 arch/mips/include/asm/pci.h       |    2 --
 arch/mn10300/include/asm/pci.h    |    2 --
 arch/parisc/include/asm/pci.h     |    2 --
 arch/powerpc/include/asm/pci.h    |    2 --
 arch/sh/include/asm/pci.h         |    2 --
 arch/sparc/include/asm/pci_32.h   |    2 --
 arch/sparc/include/asm/pci_64.h   |    2 --
 drivers/pci/probe.c               |   44 +++++++++++++------------------------
 include/asm-generic/pci.h         |    2 --
 13 files changed, 15 insertions(+), 53 deletions(-)

diff --git a/arch/alpha/include/asm/pci.h b/arch/alpha/include/asm/pci.h
index dace435..b781200 100644
--- a/arch/alpha/include/asm/pci.h
+++ b/arch/alpha/include/asm/pci.h
@@ -99,8 +99,6 @@ static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
 	return channel ? 15 : 14;
 }
 
-#define ARCH_HAS_GENERIC_PCI_OFFSETS
-
 #define pci_domain_nr(bus) ((struct pci_controller *)(bus)->sysdata)->index
 
 static inline int pci_proc_domain(struct pci_bus *bus)
diff --git a/arch/arm/include/asm/pci.h b/arch/arm/include/asm/pci.h
index 4748a75..a98a2e1 100644
--- a/arch/arm/include/asm/pci.h
+++ b/arch/arm/include/asm/pci.h
@@ -57,8 +57,6 @@ static inline void pci_dma_burst_advice(struct pci_dev *pdev,
 extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
                                enum pci_mmap_state mmap_state, int write_combine);
 
-#define ARCH_HAS_GENERIC_PCI_OFFSETS
-
 /*
  * Dummy implementation; always return 0.
  */
diff --git a/arch/ia64/include/asm/pci.h b/arch/ia64/include/asm/pci.h
index 519bb5c..b22e5f5 100644
--- a/arch/ia64/include/asm/pci.h
+++ b/arch/ia64/include/asm/pci.h
@@ -108,8 +108,6 @@ static inline int pci_proc_domain(struct pci_bus *bus)
 	return (pci_domain_nr(bus) != 0);
 }
 
-#define ARCH_HAS_GENERIC_PCI_OFFSETS
-
 static inline struct resource *
 pcibios_select_root(struct pci_dev *pdev, struct resource *res)
 {
diff --git a/arch/microblaze/include/asm/pci.h b/arch/microblaze/include/asm/pci.h
index 8db01f7..a0da88b 100644
--- a/arch/microblaze/include/asm/pci.h
+++ b/arch/microblaze/include/asm/pci.h
@@ -94,8 +94,6 @@ extern int pci_mmap_legacy_page_range(struct pci_bus *bus,
  */
 #define PCI_DMA_BUS_IS_PHYS     (1)
 
-#define ARCH_HAS_GENERIC_PCI_OFFSETS
-
 static inline struct resource *pcibios_select_root(struct pci_dev *pdev,
 			struct resource *res)
 {
diff --git a/arch/mips/include/asm/pci.h b/arch/mips/include/asm/pci.h
index 2be0c69..a573bf6 100644
--- a/arch/mips/include/asm/pci.h
+++ b/arch/mips/include/asm/pci.h
@@ -112,8 +112,6 @@ static inline void pci_dma_burst_advice(struct pci_dev *pdev,
 }
 #endif
 
-#define ARCH_HAS_GENERIC_PCI_OFFSETS
-
 #define pci_domain_nr(bus) ((struct pci_controller *)(bus)->sysdata)->index
 
 static inline int pci_proc_domain(struct pci_bus *bus)
diff --git a/arch/mn10300/include/asm/pci.h b/arch/mn10300/include/asm/pci.h
index dfe1581..8137c25 100644
--- a/arch/mn10300/include/asm/pci.h
+++ b/arch/mn10300/include/asm/pci.h
@@ -85,8 +85,6 @@ extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
 /* implement the pci_ DMA API in terms of the generic device dma_ one */
 #include <asm-generic/pci-dma-compat.h>
 
-#define ARCH_HAS_GENERIC_PCI_OFFSETS
-
 static inline struct resource *
 pcibios_select_root(struct pci_dev *pdev, struct resource *res)
 {
diff --git a/arch/parisc/include/asm/pci.h b/arch/parisc/include/asm/pci.h
index a8b591f..3234f49 100644
--- a/arch/parisc/include/asm/pci.h
+++ b/arch/parisc/include/asm/pci.h
@@ -215,8 +215,6 @@ static inline void pci_dma_burst_advice(struct pci_dev *pdev,
 }
 #endif
 
-#define ARCH_HAS_GENERIC_PCI_OFFSETS
-
 static inline void pcibios_penalize_isa_irq(int irq, int active)
 {
 	/* We don't need to penalize isa irq's */
diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
index 839178b..201e352 100644
--- a/arch/powerpc/include/asm/pci.h
+++ b/arch/powerpc/include/asm/pci.h
@@ -154,8 +154,6 @@ extern int pci_mmap_legacy_page_range(struct pci_bus *bus,
 
 #endif /* CONFIG_PPC64 */
 
-#define ARCH_HAS_GENERIC_PCI_OFFSETS
-
 extern void pcibios_claim_one_bus(struct pci_bus *b);
 
 extern void pcibios_finish_adding_to_bus(struct pci_bus *bus);
diff --git a/arch/sh/include/asm/pci.h b/arch/sh/include/asm/pci.h
index 3b5b6ab..bff96c2 100644
--- a/arch/sh/include/asm/pci.h
+++ b/arch/sh/include/asm/pci.h
@@ -114,8 +114,6 @@ static inline void pci_dma_burst_advice(struct pci_dev *pdev,
 /* Board-specific fixup routines. */
 int pcibios_map_platform_irq(const struct pci_dev *dev, u8 slot, u8 pin);
 
-#define ARCH_HAS_GENERIC_PCI_OFFSETS
-
 #define pci_domain_nr(bus) ((struct pci_channel *)(bus)->sysdata)->index
 
 static inline int pci_proc_domain(struct pci_bus *bus)
diff --git a/arch/sparc/include/asm/pci_32.h b/arch/sparc/include/asm/pci_32.h
index 6384f30..dc50329 100644
--- a/arch/sparc/include/asm/pci_32.h
+++ b/arch/sparc/include/asm/pci_32.h
@@ -52,8 +52,6 @@ static inline void pci_dma_burst_advice(struct pci_dev *pdev,
  * 64Kbytes by the Host controller.
  */
 
-#define ARCH_HAS_GENERIC_PCI_OFFSETS
-
 static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
 {
 	return PCI_IRQ_NONE;
diff --git a/arch/sparc/include/asm/pci_64.h b/arch/sparc/include/asm/pci_64.h
index 2918bd1..1633b71 100644
--- a/arch/sparc/include/asm/pci_64.h
+++ b/arch/sparc/include/asm/pci_64.h
@@ -73,8 +73,6 @@ extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
 			       enum pci_mmap_state mmap_state,
 			       int write_combine);
 
-#define ARCH_HAS_GENERIC_PCI_OFFSETS
-
 static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
 {
 	return PCI_IRQ_NONE;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 6aefa5a..e479033 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -66,8 +66,8 @@ static bool resource_contains(struct resource *res1, struct resource *res2)
 	return res1->start <= res2->start && res1->end >= res2->end;
 }
 
-void pci_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
-			struct resource *res)
+void pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
+			     struct resource *res)
 {
 	struct pci_host_bridge *bridge = pci_host_bridge(dev);
 	struct pci_host_bridge_window *window;
@@ -86,6 +86,7 @@ void pci_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
 	region->start = res->start - offset;
 	region->end = res->end - offset;
 }
+EXPORT_SYMBOL(pcibios_resource_to_bus);
 
 static bool region_contains(struct pci_bus_region *region1,
 			    struct pci_bus_region *region2)
@@ -93,8 +94,8 @@ static bool region_contains(struct pci_bus_region *region1,
 	return region1->start <= region2->start && region1->end >= region2->end;
 }
 
-void pci_bus_to_resource(struct pci_dev *dev, struct resource *res,
-			 struct pci_bus_region *region)
+void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
+			     struct pci_bus_region *region)
 {
 	struct pci_host_bridge *bridge = pci_host_bridge(dev);
 	struct pci_host_bridge_window *window;
@@ -117,22 +118,7 @@ void pci_bus_to_resource(struct pci_dev *dev, struct resource *res,
 	res->start = region->start + offset;
 	res->end = region->end + offset;
 }
-
-#ifdef ARCH_HAS_GENERIC_PCI_OFFSETS
-void pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
-			     struct resource *res)
-{
-	pci_resource_to_bus(dev, region, res);
-}
-EXPORT_SYMBOL(pcibios_resource_to_bus);
-
-void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
-			     struct pci_bus_region *region)
-{
-	pci_bus_to_resource(dev, res, region);
-}
 EXPORT_SYMBOL(pcibios_bus_to_resource);
-#endif
 
 /*
  * PCI Bus Class
@@ -309,11 +295,11 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 			pci_write_config_dword(dev, pos + 4, 0);
 			region.start = 0;
 			region.end = sz64;
-			pci_bus_to_resource(dev, res, &region);
+			pcibios_bus_to_resource(dev, res, &region);
 		} else {
 			region.start = l64;
 			region.end = l64 + sz64;
-			pci_bus_to_resource(dev, res, &region);
+			pcibios_bus_to_resource(dev, res, &region);
 			dev_printk(KERN_DEBUG, &dev->dev, "reg %x: %pR\n",
 				   pos, res);
 		}
@@ -325,7 +311,7 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 
 		region.start = l;
 		region.end = l + sz;
-		pci_bus_to_resource(dev, res, &region);
+		pcibios_bus_to_resource(dev, res, &region);
 
 		dev_printk(KERN_DEBUG, &dev->dev, "reg %x: %pR\n", pos, res);
 	}
@@ -383,7 +369,7 @@ static void __devinit pci_read_bridge_io(struct pci_bus *child)
 		res->flags = (io_base_lo & PCI_IO_RANGE_TYPE_MASK) | IORESOURCE_IO;
 		region.start = base;
 		region.end = limit + 0xfff;
-		pci_bus_to_resource(dev, &res2, &region);
+		pcibios_bus_to_resource(dev, &res2, &region);
 		if (!res->start)
 			res->start = res2.start;
 		if (!res->end)
@@ -409,7 +395,7 @@ static void __devinit pci_read_bridge_mmio(struct pci_bus *child)
 		res->flags = (mem_base_lo & PCI_MEMORY_RANGE_TYPE_MASK) | IORESOURCE_MEM;
 		region.start = base;
 		region.end = limit + 0xfffff;
-		pci_bus_to_resource(dev, res, &region);
+		pcibios_bus_to_resource(dev, res, &region);
 		dev_printk(KERN_DEBUG, &dev->dev, "  bridge window %pR\n", res);
 	}
 }
@@ -458,7 +444,7 @@ static void __devinit pci_read_bridge_mmio_pref(struct pci_bus *child)
 			res->flags |= IORESOURCE_MEM_64;
 		region.start = base;
 		region.end = limit + 0xfffff;
-		pci_bus_to_resource(dev, res, &region);
+		pcibios_bus_to_resource(dev, res, &region);
 		dev_printk(KERN_DEBUG, &dev->dev, "  bridge window %pR\n", res);
 	}
 }
@@ -1068,24 +1054,24 @@ int pci_setup_device(struct pci_dev *dev)
 				region.end = 0x1F7;
 				res = &dev->resource[0];
 				res->flags = LEGACY_IO_RESOURCE;
-				pci_bus_to_resource(dev, res, &region);
+				pcibios_bus_to_resource(dev, res, &region);
 				region.start = 0x3F6;
 				region.end = 0x3F6;
 				res = &dev->resource[1];
 				res->flags = LEGACY_IO_RESOURCE;
-				pci_bus_to_resource(dev, res, &region);
+				pcibios_bus_to_resource(dev, res, &region);
 			}
 			if ((progif & 4) == 0) {
 				region.start = 0x170;
 				region.end = 0x177;
 				res = &dev->resource[2];
 				res->flags = LEGACY_IO_RESOURCE;
-				pci_bus_to_resource(dev, res, &region);
+				pcibios_bus_to_resource(dev, res, &region);
 				region.start = 0x376;
 				region.end = 0x376;
 				res = &dev->resource[3];
 				res->flags = LEGACY_IO_RESOURCE;
-				pci_bus_to_resource(dev, res, &region);
+				pcibios_bus_to_resource(dev, res, &region);
 			}
 		}
 		break;
diff --git a/include/asm-generic/pci.h b/include/asm-generic/pci.h
index 0410346..e80a049 100644
--- a/include/asm-generic/pci.h
+++ b/include/asm-generic/pci.h
@@ -6,8 +6,6 @@
 #ifndef _ASM_GENERIC_PCI_H
 #define _ASM_GENERIC_PCI_H
 
-#define ARCH_HAS_GENERIC_PCI_OFFSETS
-
 static inline struct resource *
 pcibios_select_root(struct pci_dev *pdev, struct resource *res)
 {

