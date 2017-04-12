Return-Path: <linux-arch-owner@vger.kernel.org>
From: David Woodhouse <dwmw2@infradead.org>
To: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 27/27] pci: Kill ARCH_GENERIC_PCI_MMAP_RESOURCE
Date: Wed, 12 Apr 2017 13:26:16 +0100
Message-Id: <7745c507f4b29cd3ea451e2498a33e5bcbbd227b.1491999859.git.dwmw2@infradead.org>
In-Reply-To: <cover.1491999859.git.dwmw2@infradead.org>
References: <cover.1491999859.git.dwmw2@infradead.org>
In-Reply-To: <cover.1491999859.git.dwmw2@infradead.org>
References: <cover.1491999859.git.dwmw2@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: David Woodhouse <dwmw@amazon.co.uk>

Now that every architecture does it, we can kill the #define. This does have
the side-effect that other architectures which previously didn't support
mmap on sysfs resource files now get it.

We have an exemption for !MMU (obviously) and for Alpha (with its bizarre
setup for pre-BWX CPUs).

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 Documentation/filesystems/sysfs-pci.txt | 11 +++--------
 arch/arm/include/asm/pci.h              |  1 -
 arch/arm64/include/asm/pci.h            |  2 --
 arch/cris/include/asm/pci.h             |  1 -
 arch/ia64/include/asm/pci.h             |  1 -
 arch/microblaze/include/asm/pci.h       |  1 -
 arch/mips/include/asm/pci.h             |  1 -
 arch/mn10300/include/asm/pci.h          |  1 -
 arch/parisc/include/asm/pci.h           |  1 -
 arch/powerpc/include/asm/pci.h          |  1 -
 arch/sh/include/asm/pci.h               |  1 -
 arch/sparc/include/asm/pci_64.h         |  1 -
 arch/unicore32/include/asm/pci.h        |  1 -
 arch/x86/include/asm/pci.h              |  1 -
 arch/xtensa/include/asm/pci.h           |  1 -
 drivers/pci/Makefile                    |  3 ++-
 drivers/pci/mmap.c                      | 20 --------------------
 drivers/pci/pci-sysfs.c                 |  2 +-
 18 files changed, 6 insertions(+), 45 deletions(-)

diff --git a/Documentation/filesystems/sysfs-pci.txt b/Documentation/filesystems/sysfs-pci.txt
index 06f1d64..0aff2fe 100644
--- a/Documentation/filesystems/sysfs-pci.txt
+++ b/Documentation/filesystems/sysfs-pci.txt
@@ -112,14 +112,9 @@ to access legacy memory space.
 Supporting PCI access on new platforms
 --------------------------------------
 
-In order to support PCI resource mapping as described above, Linux platform
-code should ideally define ARCH_GENERIC_PCI_MMAP_RESOURCE and use the generic
-implementation of that functionality. To support the historical interface of
-mmap() through files in /proc/bus/pci, platforms may also set HAVE_PCI_MMAP.
-
-Alternatively, platforms which set HAVE_PCI_MMAP may provide their own
-implementation of pci_mmap_page_range() instead of defining
-ARCH_GENERIC_PCI_MMAP_RESOURCE.
+To support the historical interface of mmap() through files in /proc/bus/pci,
+platforms may also set HAVE_PCI_MMAP. The mapping through sysfs is supported
+through generic code.
 
 Platforms which support write-combining maps of PCI resources must define
 arch_can_pci_mmap_wc() which shall evaluate to non-zero at runtime when
diff --git a/arch/arm/include/asm/pci.h b/arch/arm/include/asm/pci.h
index 396c92b..51118a0 100644
--- a/arch/arm/include/asm/pci.h
+++ b/arch/arm/include/asm/pci.h
@@ -29,7 +29,6 @@ static inline int pci_proc_domain(struct pci_bus *bus)
 #define PCI_DMA_BUS_IS_PHYS     (1)
 
 #define HAVE_PCI_MMAP
-#define ARCH_GENERIC_PCI_MMAP_RESOURCE
 
 static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
 {
diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
index 1fc1974..b9a7ba9 100644
--- a/arch/arm64/include/asm/pci.h
+++ b/arch/arm64/include/asm/pci.h
@@ -22,8 +22,6 @@
  */
 #define PCI_DMA_BUS_IS_PHYS	(0)
 
-#define ARCH_GENERIC_PCI_MMAP_RESOURCE	1
-
 extern int isa_dma_bridge_buggy;
 
 #ifdef CONFIG_PCI
diff --git a/arch/cris/include/asm/pci.h b/arch/cris/include/asm/pci.h
index 6e50533..65198cb 100644
--- a/arch/cris/include/asm/pci.h
+++ b/arch/cris/include/asm/pci.h
@@ -42,7 +42,6 @@ struct pci_dev;
 #define PCI_DMA_BUS_IS_PHYS	(1)
 
 #define HAVE_PCI_MMAP
-#define ARCH_GENERIC_PCI_MMAP_RESOURCE
 
 #endif /* __KERNEL__ */
 
diff --git a/arch/ia64/include/asm/pci.h b/arch/ia64/include/asm/pci.h
index 6459f2d..fc60b3d 100644
--- a/arch/ia64/include/asm/pci.h
+++ b/arch/ia64/include/asm/pci.h
@@ -51,7 +51,6 @@ extern unsigned long ia64_max_iommu_merge_mask;
 #define PCI_DMA_BUS_IS_PHYS	(ia64_max_iommu_merge_mask == ~0UL)
 
 #define HAVE_PCI_MMAP
-#define ARCH_GENERIC_PCI_MMAP_RESOURCE
 #define arch_can_pci_mmap_wc()	1
 
 #define HAVE_PCI_LEGACY
diff --git a/arch/microblaze/include/asm/pci.h b/arch/microblaze/include/asm/pci.h
index 97452c0..9080e40 100644
--- a/arch/microblaze/include/asm/pci.h
+++ b/arch/microblaze/include/asm/pci.h
@@ -49,7 +49,6 @@ struct vm_area_struct;
 
 /* Tell PCI code what kind of PCI resource mappings we support */
 #define HAVE_PCI_MMAP			1
-#define ARCH_GENERIC_PCI_MMAP_RESOURCE	1
 #define arch_can_pci_mmap_io()		1
 
 extern int pci_legacy_read(struct pci_bus *bus, loff_t port, u32 *val,
diff --git a/arch/mips/include/asm/pci.h b/arch/mips/include/asm/pci.h
index 1000c1b..15e9fe9 100644
--- a/arch/mips/include/asm/pci.h
+++ b/arch/mips/include/asm/pci.h
@@ -110,7 +110,6 @@ extern unsigned long PCIBIOS_MIN_MEM;
 extern void pcibios_set_master(struct pci_dev *dev);
 
 #define HAVE_PCI_MMAP
-#define ARCH_GENERIC_PCI_MMAP_RESOURCE
 #define HAVE_ARCH_PCI_RESOURCE_TO_USER
 
 /*
diff --git a/arch/mn10300/include/asm/pci.h b/arch/mn10300/include/asm/pci.h
index d276549..082b6de 100644
--- a/arch/mn10300/include/asm/pci.h
+++ b/arch/mn10300/include/asm/pci.h
@@ -74,7 +74,6 @@ static inline int pci_controller_num(struct pci_dev *dev)
 }
 
 #define HAVE_PCI_MMAP
-#define ARCH_GENERIC_PCI_MMAP_RESOURCE
 
 #endif /* __KERNEL__ */
 
diff --git a/arch/parisc/include/asm/pci.h b/arch/parisc/include/asm/pci.h
index 1de1a3f..bb9ea90 100644
--- a/arch/parisc/include/asm/pci.h
+++ b/arch/parisc/include/asm/pci.h
@@ -200,6 +200,5 @@ static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
 }
 
 #define HAVE_PCI_MMAP
-#define ARCH_GENERIC_PCI_MMAP_RESOURCE
 
 #endif /* __ASM_PARISC_PCI_H */
diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
index edd5b0d..cce93be 100644
--- a/arch/powerpc/include/asm/pci.h
+++ b/arch/powerpc/include/asm/pci.h
@@ -80,7 +80,6 @@ struct vm_area_struct;
 
 /* Tell PCI code what kind of PCI resource mappings we support */
 #define HAVE_PCI_MMAP			1
-#define ARCH_GENERIC_PCI_MMAP_RESOURCE	1
 #define arch_can_pci_mmap_io()		1
 #define arch_can_pci_mmap_wc()		1
 
diff --git a/arch/sh/include/asm/pci.h b/arch/sh/include/asm/pci.h
index 17fa69b..46abbc9 100644
--- a/arch/sh/include/asm/pci.h
+++ b/arch/sh/include/asm/pci.h
@@ -66,7 +66,6 @@ extern unsigned long PCIBIOS_MIN_IO, PCIBIOS_MIN_MEM;
 struct pci_dev;
 
 #define HAVE_PCI_MMAP
-#define ARCH_GENERIC_PCI_MMAP_RESOURCE
 
 extern void pcibios_set_master(struct pci_dev *dev);
 
diff --git a/arch/sparc/include/asm/pci_64.h b/arch/sparc/include/asm/pci_64.h
index b8206d5..b957ca5 100644
--- a/arch/sparc/include/asm/pci_64.h
+++ b/arch/sparc/include/asm/pci_64.h
@@ -42,7 +42,6 @@ static inline int pci_proc_domain(struct pci_bus *bus)
 /* Platform support for /proc/bus/pci/X/Y mmap()s. */
 
 #define HAVE_PCI_MMAP
-#define ARCH_GENERIC_PCI_MMAP_RESOURCE
 #define arch_can_pci_mmap_io()	1
 #define HAVE_ARCH_PCI_GET_UNMAPPED_AREA
 #define get_pci_unmapped_area get_fb_unmapped_area
diff --git a/arch/unicore32/include/asm/pci.h b/arch/unicore32/include/asm/pci.h
index ac5acdf..a5129086 100644
--- a/arch/unicore32/include/asm/pci.h
+++ b/arch/unicore32/include/asm/pci.h
@@ -17,7 +17,6 @@
 #include <mach/hardware.h> /* for PCIBIOS_MIN_* */
 
 #define HAVE_PCI_MMAP
-#define ARCH_GENERIC_PCI_MMAP_RESOURCE
 
 #endif /* __KERNEL__ */
 #endif
diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
index f513cc2..734cc94 100644
--- a/arch/x86/include/asm/pci.h
+++ b/arch/x86/include/asm/pci.h
@@ -104,7 +104,6 @@ int pcibios_set_irq_routing(struct pci_dev *dev, int pin, int irq);
 
 #define HAVE_PCI_MMAP
 #define arch_can_pci_mmap_wc()	pat_enabled()
-#define ARCH_GENERIC_PCI_MMAP_RESOURCE
 
 #ifdef CONFIG_PCI
 extern void early_quirks(void);
diff --git a/arch/xtensa/include/asm/pci.h b/arch/xtensa/include/asm/pci.h
index 0ddb411..50bf4e1 100644
--- a/arch/xtensa/include/asm/pci.h
+++ b/arch/xtensa/include/asm/pci.h
@@ -48,7 +48,6 @@ struct pci_dev;
 
 /* Tell PCI code what kind of PCI resource mappings we support */
 #define HAVE_PCI_MMAP			1
-#define ARCH_GENERIC_PCI_MMAP_RESOURCE	1
 #define arch_can_pci_mmap_io()		1
 
 #endif /* __KERNEL__ */
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 3d40e41..39fafe2 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -4,7 +4,8 @@
 
 obj-y		+= access.o bus.o probe.o host-bridge.o remove.o pci.o \
 			pci-driver.o search.o pci-sysfs.o rom.o setup-res.o \
-			irq.o vpd.o setup-bus.o vc.o mmap.o
+			irq.o vpd.o setup-bus.o vc.o
+obj-$(CONFIG_MMU) += mmap.o
 obj-$(CONFIG_PROC_FS) += proc.o
 obj-$(CONFIG_SYSFS) += slot.o
 
diff --git a/drivers/pci/mmap.c b/drivers/pci/mmap.c
index 16e1d70..090902c4 100644
--- a/drivers/pci/mmap.c
+++ b/drivers/pci/mmap.c
@@ -15,7 +15,6 @@
 #include <linux/mm.h>
 #include <linux/pci.h>
 
-#ifdef ARCH_GENERIC_PCI_MMAP_RESOURCE
 /* Modern setup: generic pci_mmap_resource_range(), and implement the legacy
  * pci_mmap_page_range() (if needed) as a wrapper round it. */
 
@@ -66,22 +65,3 @@ int pci_mmap_resource_range(struct pci_dev *pdev, int bar,
 	return io_remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
 				  vma->vm_end - vma->vm_start, vma->vm_page_prot);
 }
-
-#elif defined(HAVE_PCI_MMAP) /* && !ARCH_GENERIC_PCI_MMAP_RESOURCE */
-/* Legacy setup: Impement pci_mmap_resource_range() as a wrapper around
-   the architecture's pci_mmap_page_range(), converting to "user visible"
-   addresses as necessary. */
-int pci_mmap_resource_range(struct pci_dev *pdev, int bar,
-			    struct vm_area_struct *vma,
-			    enum pci_mmap_state mmap_state, int write_combine)
-{
-	resource_size_t start, end;
-	/* pci_mmap_page_range() expects the same kind of entry as coming
-	 * from /proc/bus/pci/ which is a "user visible" value. If this is
-	 * different from the resource itself, arch will do necessary fixup.
-	 */
-	pci_resource_to_user(pdev, bar, &pdev->resource[bar], &start, &end);
-	vma->vm_pgoff += start >> PAGE_SHIFT;
-	return pci_mmap_page_range(pdev, bar, vma, mmap_state, write_combine);
-}
-#endif
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 10feb98..fe32ef8 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -980,7 +980,7 @@ void pci_remove_legacy_files(struct pci_bus *b)
 }
 #endif /* HAVE_PCI_LEGACY */
 
-#if defined(HAVE_PCI_MMAP) || defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)
+#if defined(CONFIG_MMU) && !defined(__alpha__)
 
 int pci_mmap_fits(struct pci_dev *pdev, int resno, struct vm_area_struct *vma,
 		  enum pci_mmap_api mmap_api)
-- 
2.9.3
