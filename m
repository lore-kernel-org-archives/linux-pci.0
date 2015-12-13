Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33568 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932138AbbLMV2e (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 13 Dec 2015 16:28:34 -0500
Received: by pabur14 with SMTP id ur14so93248577pab.0
        for <linux-pci@vger.kernel.org>; Sun, 13 Dec 2015 13:28:33 -0800 (PST)
Subject: [RFC PATCH 3/3] x86: Create dma_mark_dirty to dirty pages used for
 DMA by VM guest
From: Alexander Duyck <aduyck@mirantis.com>
To: kvm@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, alexander.duyck@gmail.com,
	qemu-devel@nongnu.org
Cc: tianyu.lan@intel.com, yang.zhang.wz@gmail.com, mst@redhat.com,
	konrad.wilk@oracle.com, dgilbert@redhat.com, agraf@suse.de,
	alex.williamson@redhat.com
Date: Sun, 13 Dec 2015 13:28:31 -0800
Message-ID: <20151213212831.5410.84365.stgit@localhost.localdomain>
In-Reply-To: <20151213212557.5410.48577.stgit@localhost.localdomain>
References: <20151213212557.5410.48577.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch is meant to provide the guest with a way of flagging DMA pages
as being dirty to the host when using a direct-assign device within a
guest.  The advantage to this approach is that it is fairly simple, however
It currently has a singificant impact on device performance in all the
scenerios where it won't be needed.

As such this is really meant only as a proof of concept and to get the ball
rolling in terms of figuring out how best to approach the issue of dirty
page tracking for a guest that is using a direct assigned device.  In
addition with just this patch it should be possible to modify current
migration approaches so that instead of having to hot-remove the device
before starting the migration this can instead be delayed until the period
before the final stop and copy.

Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---
 arch/arm/include/asm/dma-mapping.h       |    3 ++-
 arch/arm64/include/asm/dma-mapping.h     |    5 ++---
 arch/ia64/include/asm/dma.h              |    1 +
 arch/mips/include/asm/dma-mapping.h      |    1 +
 arch/powerpc/include/asm/swiotlb.h       |    1 +
 arch/tile/include/asm/dma-mapping.h      |    1 +
 arch/unicore32/include/asm/dma-mapping.h |    1 +
 arch/x86/Kconfig                         |   11 +++++++++++
 arch/x86/include/asm/swiotlb.h           |   26 ++++++++++++++++++++++++++
 drivers/xen/swiotlb-xen.c                |    6 ++++++
 lib/swiotlb.c                            |    6 ++++++
 11 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index ccb3aa64640d..1962d7b471c7 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -167,7 +167,8 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 	return 1;
 }
 
-static inline void dma_mark_clean(void *addr, size_t size) { }
+static inline void dma_mark_clean(void *addr, size_t size) {}
+static inline void dma_mark_dirty(void *addr, size_t size) {}
 
 extern int arm_dma_set_mask(struct device *dev, u64 dma_mask);
 
diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
index 61e08f360e31..8d24fe11c8a3 100644
--- a/arch/arm64/include/asm/dma-mapping.h
+++ b/arch/arm64/include/asm/dma-mapping.h
@@ -84,9 +84,8 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 	return addr + size - 1 <= *dev->dma_mask;
 }
 
-static inline void dma_mark_clean(void *addr, size_t size)
-{
-}
+static inline void dma_mark_clean(void *addr, size_t size) {}
+static inline void dma_mark_dirty(void *addr, size_t size) {}
 
 #endif	/* __KERNEL__ */
 #endif	/* __ASM_DMA_MAPPING_H */
diff --git a/arch/ia64/include/asm/dma.h b/arch/ia64/include/asm/dma.h
index 4d97f60f1ef5..d92ebeb2758e 100644
--- a/arch/ia64/include/asm/dma.h
+++ b/arch/ia64/include/asm/dma.h
@@ -20,5 +20,6 @@ extern unsigned long MAX_DMA_ADDRESS;
 #define free_dma(x)
 
 void dma_mark_clean(void *addr, size_t size);
+static inline void dma_mark_dirty(void *addr, size_t size) {}
 
 #endif /* _ASM_IA64_DMA_H */
diff --git a/arch/mips/include/asm/dma-mapping.h b/arch/mips/include/asm/dma-mapping.h
index e604f760c4a0..567f6e03e337 100644
--- a/arch/mips/include/asm/dma-mapping.h
+++ b/arch/mips/include/asm/dma-mapping.h
@@ -28,6 +28,7 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 }
 
 static inline void dma_mark_clean(void *addr, size_t size) {}
+static inline void dma_mark_dirty(void *addr, size_t size) {}
 
 #include <asm-generic/dma-mapping-common.h>
 
diff --git a/arch/powerpc/include/asm/swiotlb.h b/arch/powerpc/include/asm/swiotlb.h
index de99d6e29430..b694e8399e28 100644
--- a/arch/powerpc/include/asm/swiotlb.h
+++ b/arch/powerpc/include/asm/swiotlb.h
@@ -16,6 +16,7 @@
 extern struct dma_map_ops swiotlb_dma_ops;
 
 static inline void dma_mark_clean(void *addr, size_t size) {}
+static inline void dma_mark_dirty(void *addr, size_t size) {}
 
 extern unsigned int ppc_swiotlb_enable;
 int __init swiotlb_setup_bus_notifier(void);
diff --git a/arch/tile/include/asm/dma-mapping.h b/arch/tile/include/asm/dma-mapping.h
index 96ac6cce4a32..79953f09e938 100644
--- a/arch/tile/include/asm/dma-mapping.h
+++ b/arch/tile/include/asm/dma-mapping.h
@@ -58,6 +58,7 @@ static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr)
 }
 
 static inline void dma_mark_clean(void *addr, size_t size) {}
+static inline void dma_mark_dirty(void *addr, size_t size) {}
 
 static inline void set_dma_ops(struct device *dev, struct dma_map_ops *ops)
 {
diff --git a/arch/unicore32/include/asm/dma-mapping.h b/arch/unicore32/include/asm/dma-mapping.h
index 8140e053ccd3..b9d357ab122d 100644
--- a/arch/unicore32/include/asm/dma-mapping.h
+++ b/arch/unicore32/include/asm/dma-mapping.h
@@ -49,6 +49,7 @@ static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr)
 }
 
 static inline void dma_mark_clean(void *addr, size_t size) {}
+static inline void dma_mark_dirty(void *addr, size_t size) {}
 
 static inline void dma_cache_sync(struct device *dev, void *vaddr,
 		size_t size, enum dma_data_direction direction)
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index db3622f22b61..f0b09156d7d8 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -841,6 +841,17 @@ config SWIOTLB
 	  with more than 3 GB of memory.
 	  If unsure, say Y.
 
+config SWIOTLB_PAGE_DIRTYING
+	bool "SWIOTLB page dirtying"
+	depends on SWIOTLB
+	default n
+	---help---
+	  SWIOTLB page dirtying support provides a means for the guest to
+	  trigger write faults on pages which received DMA from the device
+	  without changing the data contained within.  By doing this the
+	  guest can then support migration assuming the device and any
+	  remaining pages are unmapped prior to the CPU itself being halted.
+
 config IOMMU_HELPER
 	def_bool y
 	depends on CALGARY_IOMMU || GART_IOMMU || SWIOTLB || AMD_IOMMU
diff --git a/arch/x86/include/asm/swiotlb.h b/arch/x86/include/asm/swiotlb.h
index ab05d73e2bb7..7f9f2e76d081 100644
--- a/arch/x86/include/asm/swiotlb.h
+++ b/arch/x86/include/asm/swiotlb.h
@@ -29,6 +29,32 @@ static inline void pci_swiotlb_late_init(void)
 
 static inline void dma_mark_clean(void *addr, size_t size) {}
 
+/*
+ * Make certain that the pages get marked as dirty
+ * now that the device has completed the DMA transaction.
+ *
+ * Without this we run the risk of a guest migration missing
+ * the pages that the device has written to as they are not
+ * tracked as a part of the dirty page tracking.
+ */
+static inline void dma_mark_dirty(void *addr, size_t size)
+{
+#ifdef CONFIG_SWIOTLB_PAGE_DIRTYING
+	unsigned long pg_addr, start;
+
+	start = (unsigned long)addr;
+	pg_addr = PAGE_ALIGN(start + size);
+	start &= ~(sizeof(atomic_t) - 1);
+
+	/* trigger a write fault on each page, excluding first page */
+	while ((pg_addr -= PAGE_SIZE) > start)
+		atomic_add(0, (atomic_t *)pg_addr);
+
+	/* trigger a write fault on first word of DMA */
+	atomic_add(0, (atomic_t *)start);
+#endif /* CONFIG_SWIOTLB_PAGE_DIRTYING */
+}
+
 extern void *x86_swiotlb_alloc_coherent(struct device *hwdev, size_t size,
 					dma_addr_t *dma_handle, gfp_t flags,
 					struct dma_attrs *attrs);
diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 2154c70e47da..1533b3eefb67 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -456,6 +456,9 @@ void xen_swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
 	 */
 	if (dir == DMA_FROM_DEVICE)
 		dma_mark_clean(phys_to_virt(paddr), size);
+
+	if (dir != DMA_TO_DEVICE)
+		dma_mark_dirty(phys_to_virt(paddr), size);
 }
 EXPORT_SYMBOL_GPL(xen_swiotlb_unmap_page);
 
@@ -485,6 +488,9 @@ xen_swiotlb_sync_single_for_cpu(struct device *hwdev, dma_addr_t dev_addr,
 
 	if (dir == DMA_FROM_DEVICE)
 		dma_mark_clean(phys_to_virt(paddr), size);
+
+	if (dir != DMA_TO_DEVICE)
+		dma_mark_dirty(phys_to_virt(paddr), size);
 }
 EXPORT_SYMBOL_GPL(xen_swiotlb_sync_single_for_cpu);
 
diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index 384ac06217b2..4223d6c54724 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -802,6 +802,9 @@ void swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
 	 */
 	if (dir == DMA_FROM_DEVICE)
 		dma_mark_clean(phys_to_virt(paddr), size);
+
+	if (dir != DMA_TO_DEVICE)
+		dma_mark_dirty(phys_to_virt(paddr), size);
 }
 EXPORT_SYMBOL_GPL(swiotlb_unmap_page);
 
@@ -830,6 +833,9 @@ swiotlb_sync_single_for_cpu(struct device *hwdev, dma_addr_t dev_addr,
 
 	if (dir == DMA_FROM_DEVICE)
 		dma_mark_clean(phys_to_virt(paddr), size);
+
+	if (dir != DMA_TO_DEVICE)
+		dma_mark_dirty(phys_to_virt(paddr), size);
 }
 EXPORT_SYMBOL(swiotlb_sync_single_for_cpu);
 

