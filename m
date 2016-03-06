Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:42207 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751727AbcCFPSD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 6 Mar 2016 10:18:03 -0500
From: Christoph Hellwig <hch@lst.de>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] pci: move pci_dma_* helpers to common code
Date: Sun,  6 Mar 2016 16:17:55 +0100
Message-Id: <1457277475-8913-4-git-send-email-hch@lst.de>
In-Reply-To: <1457277475-8913-1-git-send-email-hch@lst.de>
References: <1457277475-8913-1-git-send-email-hch@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

For a long time all architectures implement the pci_dma_* functions
using the generic DMA API, and they all use the same header to do
so.  This patch moves this header, pci-dma-compat.h, to include/linux
and includes it from the generic pci.h instead of having each arch
duplicate this include.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/alpha/include/asm/pci.h         |   7 ---
 arch/arm/include/asm/pci.h           |   1 -
 arch/arm64/include/asm/pci.h         |   1 -
 arch/avr32/include/asm/pci.h         |   2 -
 arch/blackfin/include/asm/pci.h      |   1 -
 arch/cris/include/asm/pci.h          |   3 -
 arch/frv/include/asm/pci.h           |   1 -
 arch/ia64/include/asm/pci.h          |   2 -
 arch/m68k/include/asm/pci.h          |   1 -
 arch/microblaze/include/asm/pci.h    |   2 -
 arch/mips/include/asm/pci.h          |   3 -
 arch/mn10300/include/asm/pci.h       |   3 -
 arch/parisc/include/asm/pci.h        |   3 -
 arch/powerpc/include/asm/pci.h       |   2 -
 arch/s390/include/asm/pci.h          |   1 -
 arch/sh/include/asm/pci.h            |   3 -
 arch/sparc/include/asm/pci.h         |   3 -
 arch/tile/include/asm/pci.h          |   3 -
 arch/unicore32/include/asm/pci.h     |   1 -
 arch/x86/include/asm/pci.h           |   3 -
 arch/xtensa/include/asm/pci.h        |   3 -
 include/asm-generic/pci-dma-compat.h | 118 -----------------------------------
 include/linux/pci-dma-compat.h       | 118 +++++++++++++++++++++++++++++++++++
 include/linux/pci.h                  |   4 ++
 24 files changed, 122 insertions(+), 167 deletions(-)
 delete mode 100644 include/asm-generic/pci-dma-compat.h
 create mode 100644 include/linux/pci-dma-compat.h

diff --git a/arch/alpha/include/asm/pci.h b/arch/alpha/include/asm/pci.h
index a742497..c4f0884 100644
--- a/arch/alpha/include/asm/pci.h
+++ b/arch/alpha/include/asm/pci.h
@@ -66,13 +66,6 @@ extern void pcibios_set_master(struct pci_dev *dev);
    decisions.  */
 #define PCI_DMA_BUS_IS_PHYS  0
 
-#ifdef CONFIG_PCI
-
-/* implement the pci_ DMA API in terms of the generic device dma_ one */
-#include <asm-generic/pci-dma-compat.h>
-
-#endif
-
 /* TODO: integrate with include/asm-generic/pci.h ? */
 static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
 {
diff --git a/arch/arm/include/asm/pci.h b/arch/arm/include/asm/pci.h
index f869627..0860d1c 100644
--- a/arch/arm/include/asm/pci.h
+++ b/arch/arm/include/asm/pci.h
@@ -2,7 +2,6 @@
 #define ASMARM_PCI_H
 
 #ifdef __KERNEL__
-#include <asm-generic/pci-dma-compat.h>
 #include <linux/pci-bridge.h>
 
 #include <asm/mach/pci.h> /* for pci_sys_data */
diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
index a44f008..349b927 100644
--- a/arch/arm64/include/asm/pci.h
+++ b/arch/arm64/include/asm/pci.h
@@ -8,7 +8,6 @@
 
 #include <asm/io.h>
 #include <linux/pci-bridge.h>
-#include <asm-generic/pci-dma-compat.h>
 
 #define PCIBIOS_MIN_IO		0x1000
 #define PCIBIOS_MIN_MEM		0
diff --git a/arch/avr32/include/asm/pci.h b/arch/avr32/include/asm/pci.h
index a32a023..0f5f134 100644
--- a/arch/avr32/include/asm/pci.h
+++ b/arch/avr32/include/asm/pci.h
@@ -5,6 +5,4 @@
 
 #define PCI_DMA_BUS_IS_PHYS	(1)
 
-#include <asm-generic/pci-dma-compat.h>
-
 #endif /* __ASM_AVR32_PCI_H__ */
diff --git a/arch/blackfin/include/asm/pci.h b/arch/blackfin/include/asm/pci.h
index 14efc0d..11ea1cb 100644
--- a/arch/blackfin/include/asm/pci.h
+++ b/arch/blackfin/include/asm/pci.h
@@ -4,7 +4,6 @@
 #define _ASM_BFIN_PCI_H
 
 #include <linux/scatterlist.h>
-#include <asm-generic/pci-dma-compat.h>
 #include <asm-generic/pci.h>
 
 #define PCIBIOS_MIN_IO 0x00001000
diff --git a/arch/cris/include/asm/pci.h b/arch/cris/include/asm/pci.h
index c15b4b4..b1b289d 100644
--- a/arch/cris/include/asm/pci.h
+++ b/arch/cris/include/asm/pci.h
@@ -48,9 +48,6 @@ extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
 
 #endif /* __KERNEL__ */
 
-/* implement the pci_ DMA API in terms of the generic device dma_ one */
-#include <asm-generic/pci-dma-compat.h>
-
 /* generic pci stuff */
 #include <asm-generic/pci.h>
 
diff --git a/arch/frv/include/asm/pci.h b/arch/frv/include/asm/pci.h
index 7e96b57..809cfc6 100644
--- a/arch/frv/include/asm/pci.h
+++ b/arch/frv/include/asm/pci.h
@@ -15,7 +15,6 @@
 
 #include <linux/mm.h>
 #include <linux/scatterlist.h>
-#include <asm-generic/pci-dma-compat.h>
 #include <asm-generic/pci.h>
 
 struct pci_dev;
diff --git a/arch/ia64/include/asm/pci.h b/arch/ia64/include/asm/pci.h
index 07039d1..c0835b0 100644
--- a/arch/ia64/include/asm/pci.h
+++ b/arch/ia64/include/asm/pci.h
@@ -50,8 +50,6 @@ struct pci_dev;
 extern unsigned long ia64_max_iommu_merge_mask;
 #define PCI_DMA_BUS_IS_PHYS	(ia64_max_iommu_merge_mask == ~0UL)
 
-#include <asm-generic/pci-dma-compat.h>
-
 #define HAVE_PCI_MMAP
 extern int pci_mmap_page_range (struct pci_dev *dev, struct vm_area_struct *vma,
 				enum pci_mmap_state mmap_state, int write_combine);
diff --git a/arch/m68k/include/asm/pci.h b/arch/m68k/include/asm/pci.h
index 848c3df..3a3dbcf4 100644
--- a/arch/m68k/include/asm/pci.h
+++ b/arch/m68k/include/asm/pci.h
@@ -1,7 +1,6 @@
 #ifndef _ASM_M68K_PCI_H
 #define _ASM_M68K_PCI_H
 
-#include <asm-generic/pci-dma-compat.h>
 #include <asm-generic/pci.h>
 
 /* The PCI address space does equal the physical memory
diff --git a/arch/microblaze/include/asm/pci.h b/arch/microblaze/include/asm/pci.h
index dc9eb66..fc3ecb5 100644
--- a/arch/microblaze/include/asm/pci.h
+++ b/arch/microblaze/include/asm/pci.h
@@ -22,8 +22,6 @@
 #include <asm/prom.h>
 #include <asm/pci-bridge.h>
 
-#include <asm-generic/pci-dma-compat.h>
-
 #define PCIBIOS_MIN_IO		0x1000
 #define PCIBIOS_MIN_MEM		0x10000000
 
diff --git a/arch/mips/include/asm/pci.h b/arch/mips/include/asm/pci.h
index bb94de4..731ada1 100644
--- a/arch/mips/include/asm/pci.h
+++ b/arch/mips/include/asm/pci.h
@@ -125,9 +125,6 @@ static inline int pci_proc_domain(struct pci_bus *bus)
 
 #endif /* __KERNEL__ */
 
-/* implement the pci_ DMA API in terms of the generic device dma_ one */
-#include <asm-generic/pci-dma-compat.h>
-
 /* Do platform specific device initialization at pci_enable_device() time */
 extern int pcibios_plat_dev_init(struct pci_dev *dev);
 
diff --git a/arch/mn10300/include/asm/pci.h b/arch/mn10300/include/asm/pci.h
index be3debb..51159ff 100644
--- a/arch/mn10300/include/asm/pci.h
+++ b/arch/mn10300/include/asm/pci.h
@@ -80,9 +80,6 @@ extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
 
 #endif /* __KERNEL__ */
 
-/* implement the pci_ DMA API in terms of the generic device dma_ one */
-#include <asm-generic/pci-dma-compat.h>
-
 static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
 {
 	return channel ? 15 : 14;
diff --git a/arch/parisc/include/asm/pci.h b/arch/parisc/include/asm/pci.h
index 89c53bf..defebd9 100644
--- a/arch/parisc/include/asm/pci.h
+++ b/arch/parisc/include/asm/pci.h
@@ -194,9 +194,6 @@ extern void pcibios_init_bridge(struct pci_dev *);
 #define PCIBIOS_MIN_IO          0x10
 #define PCIBIOS_MIN_MEM         0x1000 /* NBPG - but pci/setup-res.c dies */
 
-/* export the pci_ DMA API in terms of the dma_ one */
-#include <asm-generic/pci-dma-compat.h>
-
 static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
 {
 	return channel ? 15 : 14;
diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
index 6f8065a..a6f3ac0 100644
--- a/arch/powerpc/include/asm/pci.h
+++ b/arch/powerpc/include/asm/pci.h
@@ -20,8 +20,6 @@
 #include <asm/prom.h>
 #include <asm/pci-bridge.h>
 
-#include <asm-generic/pci-dma-compat.h>
-
 /* Return values for pci_controller_ops.probe_mode function */
 #define PCI_PROBE_NONE		-1	/* Don't look at this bus at all */
 #define PCI_PROBE_NORMAL	0	/* Do normal PCI probing */
diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index c873e68..fdba308 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -9,7 +9,6 @@
 #include <linux/pci.h>
 #include <linux/mutex.h>
 #include <asm-generic/pci.h>
-#include <asm-generic/pci-dma-compat.h>
 #include <asm/pci_clp.h>
 #include <asm/pci_debug.h>
 
diff --git a/arch/sh/include/asm/pci.h b/arch/sh/include/asm/pci.h
index e343dbd0..644314f 100644
--- a/arch/sh/include/asm/pci.h
+++ b/arch/sh/include/asm/pci.h
@@ -105,9 +105,6 @@ static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
 	return channel ? 15 : 14;
 }
 
-/* generic DMA-mapping stuff */
-#include <asm-generic/pci-dma-compat.h>
-
 #endif /* __KERNEL__ */
 #endif /* __ASM_SH_PCI_H */
 
diff --git a/arch/sparc/include/asm/pci.h b/arch/sparc/include/asm/pci.h
index d9c031f..6e14fd1 100644
--- a/arch/sparc/include/asm/pci.h
+++ b/arch/sparc/include/asm/pci.h
@@ -5,7 +5,4 @@
 #else
 #include <asm/pci_32.h>
 #endif
-
-#include <asm-generic/pci-dma-compat.h>
-
 #endif
diff --git a/arch/tile/include/asm/pci.h b/arch/tile/include/asm/pci.h
index dfedd7a..fe3de50 100644
--- a/arch/tile/include/asm/pci.h
+++ b/arch/tile/include/asm/pci.h
@@ -226,7 +226,4 @@ static inline int pcibios_assign_all_busses(void)
 /* Use any cpu for PCI. */
 #define cpumask_of_pcibus(bus) cpu_online_mask
 
-/* implement the pci_ DMA API in terms of the generic device dma_ one */
-#include <asm-generic/pci-dma-compat.h>
-
 #endif /* _ASM_TILE_PCI_H */
diff --git a/arch/unicore32/include/asm/pci.h b/arch/unicore32/include/asm/pci.h
index e36ca77..2f03304 100644
--- a/arch/unicore32/include/asm/pci.h
+++ b/arch/unicore32/include/asm/pci.h
@@ -13,7 +13,6 @@
 #define __UNICORE_PCI_H__
 
 #ifdef __KERNEL__
-#include <asm-generic/pci-dma-compat.h>
 #include <linux/pci-bridge.h>
 #include <asm-generic/pci.h>
 #include <mach/hardware.h> /* for PCIBIOS_MIN_* */
diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
index 4625943..7fd8eaa 100644
--- a/arch/x86/include/asm/pci.h
+++ b/arch/x86/include/asm/pci.h
@@ -105,9 +105,6 @@ void native_restore_msi_irqs(struct pci_dev *dev);
 #include <asm/pci_64.h>
 #endif
 
-/* implement the pci_ DMA API in terms of the generic device dma_ one */
-#include <asm-generic/pci-dma-compat.h>
-
 /* generic pci stuff */
 #include <asm-generic/pci.h>
 
diff --git a/arch/xtensa/include/asm/pci.h b/arch/xtensa/include/asm/pci.h
index e438a00..5d6bd93 100644
--- a/arch/xtensa/include/asm/pci.h
+++ b/arch/xtensa/include/asm/pci.h
@@ -55,9 +55,6 @@ int pci_mmap_page_range(struct pci_dev *pdev, struct vm_area_struct *vma,
 
 #endif /* __KERNEL__ */
 
-/* Implement the pci_ DMA API in terms of the generic device dma_ one */
-#include <asm-generic/pci-dma-compat.h>
-
 /* Generic PCI */
 #include <asm-generic/pci.h>
 
diff --git a/include/asm-generic/pci-dma-compat.h b/include/asm-generic/pci-dma-compat.h
deleted file mode 100644
index eafce7b..0000000
--- a/include/asm-generic/pci-dma-compat.h
+++ /dev/null
@@ -1,118 +0,0 @@
-/* include this file if the platform implements the dma_ DMA Mapping API
- * and wants to provide the pci_ DMA Mapping API in terms of it */
-
-#ifndef _ASM_GENERIC_PCI_DMA_COMPAT_H
-#define _ASM_GENERIC_PCI_DMA_COMPAT_H
-
-#include <linux/dma-mapping.h>
-
-static inline void *
-pci_alloc_consistent(struct pci_dev *hwdev, size_t size,
-		     dma_addr_t *dma_handle)
-{
-	return dma_alloc_coherent(hwdev == NULL ? NULL : &hwdev->dev, size, dma_handle, GFP_ATOMIC);
-}
-
-static inline void *
-pci_zalloc_consistent(struct pci_dev *hwdev, size_t size,
-		      dma_addr_t *dma_handle)
-{
-	return dma_zalloc_coherent(hwdev == NULL ? NULL : &hwdev->dev,
-				   size, dma_handle, GFP_ATOMIC);
-}
-
-static inline void
-pci_free_consistent(struct pci_dev *hwdev, size_t size,
-		    void *vaddr, dma_addr_t dma_handle)
-{
-	dma_free_coherent(hwdev == NULL ? NULL : &hwdev->dev, size, vaddr, dma_handle);
-}
-
-static inline dma_addr_t
-pci_map_single(struct pci_dev *hwdev, void *ptr, size_t size, int direction)
-{
-	return dma_map_single(hwdev == NULL ? NULL : &hwdev->dev, ptr, size, (enum dma_data_direction)direction);
-}
-
-static inline void
-pci_unmap_single(struct pci_dev *hwdev, dma_addr_t dma_addr,
-		 size_t size, int direction)
-{
-	dma_unmap_single(hwdev == NULL ? NULL : &hwdev->dev, dma_addr, size, (enum dma_data_direction)direction);
-}
-
-static inline dma_addr_t
-pci_map_page(struct pci_dev *hwdev, struct page *page,
-	     unsigned long offset, size_t size, int direction)
-{
-	return dma_map_page(hwdev == NULL ? NULL : &hwdev->dev, page, offset, size, (enum dma_data_direction)direction);
-}
-
-static inline void
-pci_unmap_page(struct pci_dev *hwdev, dma_addr_t dma_address,
-	       size_t size, int direction)
-{
-	dma_unmap_page(hwdev == NULL ? NULL : &hwdev->dev, dma_address, size, (enum dma_data_direction)direction);
-}
-
-static inline int
-pci_map_sg(struct pci_dev *hwdev, struct scatterlist *sg,
-	   int nents, int direction)
-{
-	return dma_map_sg(hwdev == NULL ? NULL : &hwdev->dev, sg, nents, (enum dma_data_direction)direction);
-}
-
-static inline void
-pci_unmap_sg(struct pci_dev *hwdev, struct scatterlist *sg,
-	     int nents, int direction)
-{
-	dma_unmap_sg(hwdev == NULL ? NULL : &hwdev->dev, sg, nents, (enum dma_data_direction)direction);
-}
-
-static inline void
-pci_dma_sync_single_for_cpu(struct pci_dev *hwdev, dma_addr_t dma_handle,
-		    size_t size, int direction)
-{
-	dma_sync_single_for_cpu(hwdev == NULL ? NULL : &hwdev->dev, dma_handle, size, (enum dma_data_direction)direction);
-}
-
-static inline void
-pci_dma_sync_single_for_device(struct pci_dev *hwdev, dma_addr_t dma_handle,
-		    size_t size, int direction)
-{
-	dma_sync_single_for_device(hwdev == NULL ? NULL : &hwdev->dev, dma_handle, size, (enum dma_data_direction)direction);
-}
-
-static inline void
-pci_dma_sync_sg_for_cpu(struct pci_dev *hwdev, struct scatterlist *sg,
-		int nelems, int direction)
-{
-	dma_sync_sg_for_cpu(hwdev == NULL ? NULL : &hwdev->dev, sg, nelems, (enum dma_data_direction)direction);
-}
-
-static inline void
-pci_dma_sync_sg_for_device(struct pci_dev *hwdev, struct scatterlist *sg,
-		int nelems, int direction)
-{
-	dma_sync_sg_for_device(hwdev == NULL ? NULL : &hwdev->dev, sg, nelems, (enum dma_data_direction)direction);
-}
-
-static inline int
-pci_dma_mapping_error(struct pci_dev *pdev, dma_addr_t dma_addr)
-{
-	return dma_mapping_error(&pdev->dev, dma_addr);
-}
-
-#ifdef CONFIG_PCI
-static inline int pci_set_dma_mask(struct pci_dev *dev, u64 mask)
-{
-	return dma_set_mask(&dev->dev, mask);
-}
-
-static inline int pci_set_consistent_dma_mask(struct pci_dev *dev, u64 mask)
-{
-	return dma_set_coherent_mask(&dev->dev, mask);
-}
-#endif
-
-#endif
diff --git a/include/linux/pci-dma-compat.h b/include/linux/pci-dma-compat.h
new file mode 100644
index 0000000..eafce7b
--- /dev/null
+++ b/include/linux/pci-dma-compat.h
@@ -0,0 +1,118 @@
+/* include this file if the platform implements the dma_ DMA Mapping API
+ * and wants to provide the pci_ DMA Mapping API in terms of it */
+
+#ifndef _ASM_GENERIC_PCI_DMA_COMPAT_H
+#define _ASM_GENERIC_PCI_DMA_COMPAT_H
+
+#include <linux/dma-mapping.h>
+
+static inline void *
+pci_alloc_consistent(struct pci_dev *hwdev, size_t size,
+		     dma_addr_t *dma_handle)
+{
+	return dma_alloc_coherent(hwdev == NULL ? NULL : &hwdev->dev, size, dma_handle, GFP_ATOMIC);
+}
+
+static inline void *
+pci_zalloc_consistent(struct pci_dev *hwdev, size_t size,
+		      dma_addr_t *dma_handle)
+{
+	return dma_zalloc_coherent(hwdev == NULL ? NULL : &hwdev->dev,
+				   size, dma_handle, GFP_ATOMIC);
+}
+
+static inline void
+pci_free_consistent(struct pci_dev *hwdev, size_t size,
+		    void *vaddr, dma_addr_t dma_handle)
+{
+	dma_free_coherent(hwdev == NULL ? NULL : &hwdev->dev, size, vaddr, dma_handle);
+}
+
+static inline dma_addr_t
+pci_map_single(struct pci_dev *hwdev, void *ptr, size_t size, int direction)
+{
+	return dma_map_single(hwdev == NULL ? NULL : &hwdev->dev, ptr, size, (enum dma_data_direction)direction);
+}
+
+static inline void
+pci_unmap_single(struct pci_dev *hwdev, dma_addr_t dma_addr,
+		 size_t size, int direction)
+{
+	dma_unmap_single(hwdev == NULL ? NULL : &hwdev->dev, dma_addr, size, (enum dma_data_direction)direction);
+}
+
+static inline dma_addr_t
+pci_map_page(struct pci_dev *hwdev, struct page *page,
+	     unsigned long offset, size_t size, int direction)
+{
+	return dma_map_page(hwdev == NULL ? NULL : &hwdev->dev, page, offset, size, (enum dma_data_direction)direction);
+}
+
+static inline void
+pci_unmap_page(struct pci_dev *hwdev, dma_addr_t dma_address,
+	       size_t size, int direction)
+{
+	dma_unmap_page(hwdev == NULL ? NULL : &hwdev->dev, dma_address, size, (enum dma_data_direction)direction);
+}
+
+static inline int
+pci_map_sg(struct pci_dev *hwdev, struct scatterlist *sg,
+	   int nents, int direction)
+{
+	return dma_map_sg(hwdev == NULL ? NULL : &hwdev->dev, sg, nents, (enum dma_data_direction)direction);
+}
+
+static inline void
+pci_unmap_sg(struct pci_dev *hwdev, struct scatterlist *sg,
+	     int nents, int direction)
+{
+	dma_unmap_sg(hwdev == NULL ? NULL : &hwdev->dev, sg, nents, (enum dma_data_direction)direction);
+}
+
+static inline void
+pci_dma_sync_single_for_cpu(struct pci_dev *hwdev, dma_addr_t dma_handle,
+		    size_t size, int direction)
+{
+	dma_sync_single_for_cpu(hwdev == NULL ? NULL : &hwdev->dev, dma_handle, size, (enum dma_data_direction)direction);
+}
+
+static inline void
+pci_dma_sync_single_for_device(struct pci_dev *hwdev, dma_addr_t dma_handle,
+		    size_t size, int direction)
+{
+	dma_sync_single_for_device(hwdev == NULL ? NULL : &hwdev->dev, dma_handle, size, (enum dma_data_direction)direction);
+}
+
+static inline void
+pci_dma_sync_sg_for_cpu(struct pci_dev *hwdev, struct scatterlist *sg,
+		int nelems, int direction)
+{
+	dma_sync_sg_for_cpu(hwdev == NULL ? NULL : &hwdev->dev, sg, nelems, (enum dma_data_direction)direction);
+}
+
+static inline void
+pci_dma_sync_sg_for_device(struct pci_dev *hwdev, struct scatterlist *sg,
+		int nelems, int direction)
+{
+	dma_sync_sg_for_device(hwdev == NULL ? NULL : &hwdev->dev, sg, nelems, (enum dma_data_direction)direction);
+}
+
+static inline int
+pci_dma_mapping_error(struct pci_dev *pdev, dma_addr_t dma_addr)
+{
+	return dma_mapping_error(&pdev->dev, dma_addr);
+}
+
+#ifdef CONFIG_PCI
+static inline int pci_set_dma_mask(struct pci_dev *dev, u64 mask)
+{
+	return dma_set_mask(&dev->dev, mask);
+}
+
+static inline int pci_set_consistent_dma_mask(struct pci_dev *dev, u64 mask)
+{
+	return dma_set_coherent_mask(&dev->dev, mask);
+}
+#endif
+
+#endif
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2771625..a3d22a5d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1972,4 +1972,8 @@ static inline bool pci_ari_enabled(struct pci_bus *bus)
 {
 	return bus->self && bus->self->ari_enabled;
 }
+
+/* provide the legacy pci_dma_* API */
+#include <linux/pci-dma-compat.h>
+
 #endif /* LINUX_PCI_H */
-- 
2.1.4

