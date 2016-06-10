Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:12696 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161019AbcFJKNb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jun 2016 06:13:31 -0400
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: hch@infradead.org, Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	David Vrabel <david.vrabel@citrix.com>,
	Juergen Gross <jgross@suse.com>,
	Muli Ben-Yehuda <muli@il.ibm.com>,
	"Jon D. Mason" <jdmason@kudzu.us>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Keith Busch <keith.busch@intel.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Valentin Rothberg <valentinrothberg@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mel Gorman <mgorman@techsingularity.net>,
	Junichi Nomura <j-nomura@ce.jp.nec.com>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?=
	<ville.syrjala@linux.intel.com>, linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org, discuss@x86-64.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v4 23/44] x86: dma-mapping: Use unsigned long for dma_attrs
Date: Fri, 10 Jun 2016 12:11:40 +0200
Message-id: <1465553521-27303-24-git-send-email-k.kozlowski@samsung.com>
In-reply-to: <1465553521-27303-1-git-send-email-k.kozlowski@samsung.com>
References: <1465553521-27303-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Split out subsystem specific changes for easier reviews. This will be
squashed with main commit.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/x86/include/asm/dma-mapping.h       |  5 ++---
 arch/x86/include/asm/swiotlb.h           |  4 ++--
 arch/x86/include/asm/xen/page-coherent.h |  9 ++++-----
 arch/x86/kernel/amd_gart_64.c            | 20 ++++++++++----------
 arch/x86/kernel/pci-calgary_64.c         | 14 +++++++-------
 arch/x86/kernel/pci-dma.c                |  4 ++--
 arch/x86/kernel/pci-nommu.c              |  4 ++--
 arch/x86/kernel/pci-swiotlb.c            |  4 ++--
 arch/x86/pci/sta2x11-fixup.c             |  2 +-
 arch/x86/pci/vmd.c                       | 16 ++++++++--------
 10 files changed, 40 insertions(+), 42 deletions(-)

diff --git a/arch/x86/include/asm/dma-mapping.h b/arch/x86/include/asm/dma-mapping.h
index 3a27b93e6261..44461626830e 100644
--- a/arch/x86/include/asm/dma-mapping.h
+++ b/arch/x86/include/asm/dma-mapping.h
@@ -9,7 +9,6 @@
 #include <linux/kmemcheck.h>
 #include <linux/scatterlist.h>
 #include <linux/dma-debug.h>
-#include <linux/dma-attrs.h>
 #include <asm/io.h>
 #include <asm/swiotlb.h>
 #include <linux/dma-contiguous.h>
@@ -48,11 +47,11 @@ extern int dma_supported(struct device *hwdev, u64 mask);
 
 extern void *dma_generic_alloc_coherent(struct device *dev, size_t size,
 					dma_addr_t *dma_addr, gfp_t flag,
-					struct dma_attrs *attrs);
+					unsigned long attrs);
 
 extern void dma_generic_free_coherent(struct device *dev, size_t size,
 				      void *vaddr, dma_addr_t dma_addr,
-				      struct dma_attrs *attrs);
+				      unsigned long attrs);
 
 #ifdef CONFIG_X86_DMA_REMAP /* Platform code defines bridge-specific code */
 extern bool dma_capable(struct device *dev, dma_addr_t addr, size_t size);
diff --git a/arch/x86/include/asm/swiotlb.h b/arch/x86/include/asm/swiotlb.h
index ab05d73e2bb7..d2f69b9ff732 100644
--- a/arch/x86/include/asm/swiotlb.h
+++ b/arch/x86/include/asm/swiotlb.h
@@ -31,9 +31,9 @@ static inline void dma_mark_clean(void *addr, size_t size) {}
 
 extern void *x86_swiotlb_alloc_coherent(struct device *hwdev, size_t size,
 					dma_addr_t *dma_handle, gfp_t flags,
-					struct dma_attrs *attrs);
+					unsigned long attrs);
 extern void x86_swiotlb_free_coherent(struct device *dev, size_t size,
 					void *vaddr, dma_addr_t dma_addr,
-					struct dma_attrs *attrs);
+					unsigned long attrs);
 
 #endif /* _ASM_X86_SWIOTLB_H */
diff --git a/arch/x86/include/asm/xen/page-coherent.h b/arch/x86/include/asm/xen/page-coherent.h
index acd844c017d3..f02f025ff988 100644
--- a/arch/x86/include/asm/xen/page-coherent.h
+++ b/arch/x86/include/asm/xen/page-coherent.h
@@ -2,12 +2,11 @@
 #define _ASM_X86_XEN_PAGE_COHERENT_H
 
 #include <asm/page.h>
-#include <linux/dma-attrs.h>
 #include <linux/dma-mapping.h>
 
 static inline void *xen_alloc_coherent_pages(struct device *hwdev, size_t size,
 		dma_addr_t *dma_handle, gfp_t flags,
-		struct dma_attrs *attrs)
+		unsigned long attrs)
 {
 	void *vstart = (void*)__get_free_pages(flags, get_order(size));
 	*dma_handle = virt_to_phys(vstart);
@@ -16,18 +15,18 @@ static inline void *xen_alloc_coherent_pages(struct device *hwdev, size_t size,
 
 static inline void xen_free_coherent_pages(struct device *hwdev, size_t size,
 		void *cpu_addr, dma_addr_t dma_handle,
-		struct dma_attrs *attrs)
+		unsigned long attrs)
 {
 	free_pages((unsigned long) cpu_addr, get_order(size));
 }
 
 static inline void xen_dma_map_page(struct device *hwdev, struct page *page,
 	     dma_addr_t dev_addr, unsigned long offset, size_t size,
-	     enum dma_data_direction dir, struct dma_attrs *attrs) { }
+	     enum dma_data_direction dir, unsigned long attrs) { }
 
 static inline void xen_dma_unmap_page(struct device *hwdev, dma_addr_t handle,
 		size_t size, enum dma_data_direction dir,
-		struct dma_attrs *attrs) { }
+		unsigned long attrs) { }
 
 static inline void xen_dma_sync_single_for_cpu(struct device *hwdev,
 		dma_addr_t handle, size_t size, enum dma_data_direction dir) { }
diff --git a/arch/x86/kernel/amd_gart_64.c b/arch/x86/kernel/amd_gart_64.c
index 8e3842fc8bea..4aff288e37a4 100644
--- a/arch/x86/kernel/amd_gart_64.c
+++ b/arch/x86/kernel/amd_gart_64.c
@@ -242,7 +242,7 @@ static dma_addr_t dma_map_area(struct device *dev, dma_addr_t phys_mem,
 static dma_addr_t gart_map_page(struct device *dev, struct page *page,
 				unsigned long offset, size_t size,
 				enum dma_data_direction dir,
-				struct dma_attrs *attrs)
+				unsigned long attrs)
 {
 	unsigned long bus;
 	phys_addr_t paddr = page_to_phys(page) + offset;
@@ -264,7 +264,7 @@ static dma_addr_t gart_map_page(struct device *dev, struct page *page,
  */
 static void gart_unmap_page(struct device *dev, dma_addr_t dma_addr,
 			    size_t size, enum dma_data_direction dir,
-			    struct dma_attrs *attrs)
+			    unsigned long attrs)
 {
 	unsigned long iommu_page;
 	int npages;
@@ -286,7 +286,7 @@ static void gart_unmap_page(struct device *dev, dma_addr_t dma_addr,
  * Wrapper for pci_unmap_single working with scatterlists.
  */
 static void gart_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
-			  enum dma_data_direction dir, struct dma_attrs *attrs)
+			  enum dma_data_direction dir, unsigned long attrs)
 {
 	struct scatterlist *s;
 	int i;
@@ -294,7 +294,7 @@ static void gart_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
 	for_each_sg(sg, s, nents, i) {
 		if (!s->dma_length || !s->length)
 			break;
-		gart_unmap_page(dev, s->dma_address, s->dma_length, dir, NULL);
+		gart_unmap_page(dev, s->dma_address, s->dma_length, dir, 0);
 	}
 }
 
@@ -316,7 +316,7 @@ static int dma_map_sg_nonforce(struct device *dev, struct scatterlist *sg,
 			addr = dma_map_area(dev, addr, s->length, dir, 0);
 			if (addr == bad_dma_addr) {
 				if (i > 0)
-					gart_unmap_sg(dev, sg, i, dir, NULL);
+					gart_unmap_sg(dev, sg, i, dir, 0);
 				nents = 0;
 				sg[0].dma_length = 0;
 				break;
@@ -387,7 +387,7 @@ dma_map_cont(struct device *dev, struct scatterlist *start, int nelems,
  * Merge chunks that have page aligned sizes into a continuous mapping.
  */
 static int gart_map_sg(struct device *dev, struct scatterlist *sg, int nents,
-		       enum dma_data_direction dir, struct dma_attrs *attrs)
+		       enum dma_data_direction dir, unsigned long attrs)
 {
 	struct scatterlist *s, *ps, *start_sg, *sgmap;
 	int need = 0, nextneed, i, out, start;
@@ -457,7 +457,7 @@ static int gart_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 
 error:
 	flush_gart();
-	gart_unmap_sg(dev, sg, out, dir, NULL);
+	gart_unmap_sg(dev, sg, out, dir, 0);
 
 	/* When it was forced or merged try again in a dumb way */
 	if (force_iommu || iommu_merge) {
@@ -477,7 +477,7 @@ error:
 /* allocate and map a coherent mapping */
 static void *
 gart_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_addr,
-		    gfp_t flag, struct dma_attrs *attrs)
+		    gfp_t flag, unsigned long attrs)
 {
 	dma_addr_t paddr;
 	unsigned long align_mask;
@@ -509,9 +509,9 @@ gart_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_addr,
 /* free a coherent mapping */
 static void
 gart_free_coherent(struct device *dev, size_t size, void *vaddr,
-		   dma_addr_t dma_addr, struct dma_attrs *attrs)
+		   dma_addr_t dma_addr, unsigned long attrs)
 {
-	gart_unmap_page(dev, dma_addr, size, DMA_BIDIRECTIONAL, NULL);
+	gart_unmap_page(dev, dma_addr, size, DMA_BIDIRECTIONAL, 0);
 	dma_generic_free_coherent(dev, size, vaddr, dma_addr, attrs);
 }
 
diff --git a/arch/x86/kernel/pci-calgary_64.c b/arch/x86/kernel/pci-calgary_64.c
index 833b1d329c47..5d400ba1349d 100644
--- a/arch/x86/kernel/pci-calgary_64.c
+++ b/arch/x86/kernel/pci-calgary_64.c
@@ -340,7 +340,7 @@ static inline struct iommu_table *find_iommu_table(struct device *dev)
 
 static void calgary_unmap_sg(struct device *dev, struct scatterlist *sglist,
 			     int nelems,enum dma_data_direction dir,
-			     struct dma_attrs *attrs)
+			     unsigned long attrs)
 {
 	struct iommu_table *tbl = find_iommu_table(dev);
 	struct scatterlist *s;
@@ -364,7 +364,7 @@ static void calgary_unmap_sg(struct device *dev, struct scatterlist *sglist,
 
 static int calgary_map_sg(struct device *dev, struct scatterlist *sg,
 			  int nelems, enum dma_data_direction dir,
-			  struct dma_attrs *attrs)
+			  unsigned long attrs)
 {
 	struct iommu_table *tbl = find_iommu_table(dev);
 	struct scatterlist *s;
@@ -396,7 +396,7 @@ static int calgary_map_sg(struct device *dev, struct scatterlist *sg,
 
 	return nelems;
 error:
-	calgary_unmap_sg(dev, sg, nelems, dir, NULL);
+	calgary_unmap_sg(dev, sg, nelems, dir, 0);
 	for_each_sg(sg, s, nelems, i) {
 		sg->dma_address = DMA_ERROR_CODE;
 		sg->dma_length = 0;
@@ -407,7 +407,7 @@ error:
 static dma_addr_t calgary_map_page(struct device *dev, struct page *page,
 				   unsigned long offset, size_t size,
 				   enum dma_data_direction dir,
-				   struct dma_attrs *attrs)
+				   unsigned long attrs)
 {
 	void *vaddr = page_address(page) + offset;
 	unsigned long uaddr;
@@ -422,7 +422,7 @@ static dma_addr_t calgary_map_page(struct device *dev, struct page *page,
 
 static void calgary_unmap_page(struct device *dev, dma_addr_t dma_addr,
 			       size_t size, enum dma_data_direction dir,
-			       struct dma_attrs *attrs)
+			       unsigned long attrs)
 {
 	struct iommu_table *tbl = find_iommu_table(dev);
 	unsigned int npages;
@@ -432,7 +432,7 @@ static void calgary_unmap_page(struct device *dev, dma_addr_t dma_addr,
 }
 
 static void* calgary_alloc_coherent(struct device *dev, size_t size,
-	dma_addr_t *dma_handle, gfp_t flag, struct dma_attrs *attrs)
+	dma_addr_t *dma_handle, gfp_t flag, unsigned long attrs)
 {
 	void *ret = NULL;
 	dma_addr_t mapping;
@@ -466,7 +466,7 @@ error:
 
 static void calgary_free_coherent(struct device *dev, size_t size,
 				  void *vaddr, dma_addr_t dma_handle,
-				  struct dma_attrs *attrs)
+				  unsigned long attrs)
 {
 	unsigned int npages;
 	struct iommu_table *tbl = find_iommu_table(dev);
diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
index 6ba014c61d62..d30c37750765 100644
--- a/arch/x86/kernel/pci-dma.c
+++ b/arch/x86/kernel/pci-dma.c
@@ -77,7 +77,7 @@ void __init pci_iommu_alloc(void)
 }
 void *dma_generic_alloc_coherent(struct device *dev, size_t size,
 				 dma_addr_t *dma_addr, gfp_t flag,
-				 struct dma_attrs *attrs)
+				 unsigned long attrs)
 {
 	unsigned long dma_mask;
 	struct page *page;
@@ -120,7 +120,7 @@ again:
 }
 
 void dma_generic_free_coherent(struct device *dev, size_t size, void *vaddr,
-			       dma_addr_t dma_addr, struct dma_attrs *attrs)
+			       dma_addr_t dma_addr, unsigned long attrs)
 {
 	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	struct page *page = virt_to_page(vaddr);
diff --git a/arch/x86/kernel/pci-nommu.c b/arch/x86/kernel/pci-nommu.c
index da15918d1c81..00e71ce396a8 100644
--- a/arch/x86/kernel/pci-nommu.c
+++ b/arch/x86/kernel/pci-nommu.c
@@ -28,7 +28,7 @@ check_addr(char *name, struct device *hwdev, dma_addr_t bus, size_t size)
 static dma_addr_t nommu_map_page(struct device *dev, struct page *page,
 				 unsigned long offset, size_t size,
 				 enum dma_data_direction dir,
-				 struct dma_attrs *attrs)
+				 unsigned long attrs)
 {
 	dma_addr_t bus = page_to_phys(page) + offset;
 	WARN_ON(size == 0);
@@ -55,7 +55,7 @@ static dma_addr_t nommu_map_page(struct device *dev, struct page *page,
  */
 static int nommu_map_sg(struct device *hwdev, struct scatterlist *sg,
 			int nents, enum dma_data_direction dir,
-			struct dma_attrs *attrs)
+			unsigned long attrs)
 {
 	struct scatterlist *s;
 	int i;
diff --git a/arch/x86/kernel/pci-swiotlb.c b/arch/x86/kernel/pci-swiotlb.c
index 7c577a178859..db88bfe56a77 100644
--- a/arch/x86/kernel/pci-swiotlb.c
+++ b/arch/x86/kernel/pci-swiotlb.c
@@ -16,7 +16,7 @@ int swiotlb __read_mostly;
 
 void *x86_swiotlb_alloc_coherent(struct device *hwdev, size_t size,
 					dma_addr_t *dma_handle, gfp_t flags,
-					struct dma_attrs *attrs)
+					unsigned long attrs)
 {
 	void *vaddr;
 
@@ -37,7 +37,7 @@ void *x86_swiotlb_alloc_coherent(struct device *hwdev, size_t size,
 
 void x86_swiotlb_free_coherent(struct device *dev, size_t size,
 				      void *vaddr, dma_addr_t dma_addr,
-				      struct dma_attrs *attrs)
+				      unsigned long attrs)
 {
 	if (is_swiotlb_buffer(dma_to_phys(dev, dma_addr)))
 		swiotlb_free_coherent(dev, size, vaddr, dma_addr);
diff --git a/arch/x86/pci/sta2x11-fixup.c b/arch/x86/pci/sta2x11-fixup.c
index 5ceda85b8687..052c1cb76305 100644
--- a/arch/x86/pci/sta2x11-fixup.c
+++ b/arch/x86/pci/sta2x11-fixup.c
@@ -169,7 +169,7 @@ static void *sta2x11_swiotlb_alloc_coherent(struct device *dev,
 					    size_t size,
 					    dma_addr_t *dma_handle,
 					    gfp_t flags,
-					    struct dma_attrs *attrs)
+					    unsigned long attrs)
 {
 	void *vaddr;
 
diff --git a/arch/x86/pci/vmd.c b/arch/x86/pci/vmd.c
index 7792aba266df..d5834cc658c0 100644
--- a/arch/x86/pci/vmd.c
+++ b/arch/x86/pci/vmd.c
@@ -265,14 +265,14 @@ static struct dma_map_ops *vmd_dma_ops(struct device *dev)
 }
 
 static void *vmd_alloc(struct device *dev, size_t size, dma_addr_t *addr,
-		       gfp_t flag, struct dma_attrs *attrs)
+		       gfp_t flag, unsigned long attrs)
 {
 	return vmd_dma_ops(dev)->alloc(to_vmd_dev(dev), size, addr, flag,
 				       attrs);
 }
 
 static void vmd_free(struct device *dev, size_t size, void *vaddr,
-		     dma_addr_t addr, struct dma_attrs *attrs)
+		     dma_addr_t addr, unsigned long attrs)
 {
 	return vmd_dma_ops(dev)->free(to_vmd_dev(dev), size, vaddr, addr,
 				      attrs);
@@ -280,7 +280,7 @@ static void vmd_free(struct device *dev, size_t size, void *vaddr,
 
 static int vmd_mmap(struct device *dev, struct vm_area_struct *vma,
 		    void *cpu_addr, dma_addr_t addr, size_t size,
-		    struct dma_attrs *attrs)
+		    unsigned long attrs)
 {
 	return vmd_dma_ops(dev)->mmap(to_vmd_dev(dev), vma, cpu_addr, addr,
 				      size, attrs);
@@ -288,7 +288,7 @@ static int vmd_mmap(struct device *dev, struct vm_area_struct *vma,
 
 static int vmd_get_sgtable(struct device *dev, struct sg_table *sgt,
 			   void *cpu_addr, dma_addr_t addr, size_t size,
-			   struct dma_attrs *attrs)
+			   unsigned long attrs)
 {
 	return vmd_dma_ops(dev)->get_sgtable(to_vmd_dev(dev), sgt, cpu_addr,
 					     addr, size, attrs);
@@ -297,26 +297,26 @@ static int vmd_get_sgtable(struct device *dev, struct sg_table *sgt,
 static dma_addr_t vmd_map_page(struct device *dev, struct page *page,
 			       unsigned long offset, size_t size,
 			       enum dma_data_direction dir,
-			       struct dma_attrs *attrs)
+			       unsigned long attrs)
 {
 	return vmd_dma_ops(dev)->map_page(to_vmd_dev(dev), page, offset, size,
 					  dir, attrs);
 }
 
 static void vmd_unmap_page(struct device *dev, dma_addr_t addr, size_t size,
-			   enum dma_data_direction dir, struct dma_attrs *attrs)
+			   enum dma_data_direction dir, unsigned long attrs)
 {
 	vmd_dma_ops(dev)->unmap_page(to_vmd_dev(dev), addr, size, dir, attrs);
 }
 
 static int vmd_map_sg(struct device *dev, struct scatterlist *sg, int nents,
-		      enum dma_data_direction dir, struct dma_attrs *attrs)
+		      enum dma_data_direction dir, unsigned long attrs)
 {
 	return vmd_dma_ops(dev)->map_sg(to_vmd_dev(dev), sg, nents, dir, attrs);
 }
 
 static void vmd_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
-			 enum dma_data_direction dir, struct dma_attrs *attrs)
+			 enum dma_data_direction dir, unsigned long attrs)
 {
 	vmd_dma_ops(dev)->unmap_sg(to_vmd_dev(dev), sg, nents, dir, attrs);
 }
-- 
1.9.1

