Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [RFC PATCH 1/3] swiotlb: Fold static unmap and sync calls into
 calling functions
From: Alexander Duyck <aduyck@mirantis.com>
To: kvm@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, alexander.duyck@gmail.com,
	qemu-devel@nongnu.org
Cc: tianyu.lan@intel.com, yang.zhang.wz@gmail.com, mst@redhat.com,
	konrad.wilk@oracle.com, dgilbert@redhat.com, agraf@suse.de,
	alex.williamson@redhat.com
Date: Sun, 13 Dec 2015 13:28:16 -0800
Message-ID: <20151213212816.5410.19754.stgit@localhost.localdomain>
In-Reply-To: <20151213212557.5410.48577.stgit@localhost.localdomain>
References: <20151213212557.5410.48577.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This change essentially does two things.  First it folds the swiotlb_unmap
and swiotlb_sync calls into their callers.  The goal behind this is three
fold.  First this helps to reduce execution time and improves performance
since we aren't having to call into as many functions.  Second it allows us
to split up some of the sync functionality as there is the dma_mark_clean
portion of the sync call that is only really needed for dma_sync_for_cpu
since we don't actually want to mark the page as clean if we are syncing
for the device.

The second change is to move dma_mark_clean inside the if statement instead
of using a return in the case of sync and unmap.  By doing this we make it
so that we can also add a dma_mark_dirty function later.

Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---
 lib/swiotlb.c |   81 +++++++++++++++++++++++----------------------------------
 1 file changed, 33 insertions(+), 48 deletions(-)

diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index 76f29ecba8f4..384ac06217b2 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -781,8 +781,9 @@ EXPORT_SYMBOL_GPL(swiotlb_map_page);
  * After this call, reads by the cpu to the buffer are guaranteed to see
  * whatever the device wrote there.
  */
-static void unmap_single(struct device *hwdev, dma_addr_t dev_addr,
-			 size_t size, enum dma_data_direction dir)
+void swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
+			size_t size, enum dma_data_direction dir,
+			struct dma_attrs *attrs)
 {
 	phys_addr_t paddr = dma_to_phys(hwdev, dev_addr);
 
@@ -793,23 +794,14 @@ static void unmap_single(struct device *hwdev, dma_addr_t dev_addr,
 		return;
 	}
 
-	if (dir != DMA_FROM_DEVICE)
-		return;
-
 	/*
 	 * phys_to_virt doesn't work with hihgmem page but we could
 	 * call dma_mark_clean() with hihgmem page here. However, we
 	 * are fine since dma_mark_clean() is null on POWERPC. We can
 	 * make dma_mark_clean() take a physical address if necessary.
 	 */
-	dma_mark_clean(phys_to_virt(paddr), size);
-}
-
-void swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
-			size_t size, enum dma_data_direction dir,
-			struct dma_attrs *attrs)
-{
-	unmap_single(hwdev, dev_addr, size, dir);
+	if (dir == DMA_FROM_DEVICE)
+		dma_mark_clean(phys_to_virt(paddr), size);
 }
 EXPORT_SYMBOL_GPL(swiotlb_unmap_page);
 
@@ -823,31 +815,21 @@ EXPORT_SYMBOL_GPL(swiotlb_unmap_page);
  * address back to the card, you must first perform a
  * swiotlb_dma_sync_for_device, and then the device again owns the buffer
  */
-static void
-swiotlb_sync_single(struct device *hwdev, dma_addr_t dev_addr,
-		    size_t size, enum dma_data_direction dir,
-		    enum dma_sync_target target)
+void
+swiotlb_sync_single_for_cpu(struct device *hwdev, dma_addr_t dev_addr,
+			    size_t size, enum dma_data_direction dir)
 {
 	phys_addr_t paddr = dma_to_phys(hwdev, dev_addr);
 
 	BUG_ON(dir == DMA_NONE);
 
 	if (is_swiotlb_buffer(paddr)) {
-		swiotlb_tbl_sync_single(hwdev, paddr, size, dir, target);
+		swiotlb_tbl_sync_single(hwdev, paddr, size, dir, SYNC_FOR_CPU);
 		return;
 	}
 
-	if (dir != DMA_FROM_DEVICE)
-		return;
-
-	dma_mark_clean(phys_to_virt(paddr), size);
-}
-
-void
-swiotlb_sync_single_for_cpu(struct device *hwdev, dma_addr_t dev_addr,
-			    size_t size, enum dma_data_direction dir)
-{
-	swiotlb_sync_single(hwdev, dev_addr, size, dir, SYNC_FOR_CPU);
+	if (dir == DMA_FROM_DEVICE)
+		dma_mark_clean(phys_to_virt(paddr), size);
 }
 EXPORT_SYMBOL(swiotlb_sync_single_for_cpu);
 
@@ -855,7 +837,14 @@ void
 swiotlb_sync_single_for_device(struct device *hwdev, dma_addr_t dev_addr,
 			       size_t size, enum dma_data_direction dir)
 {
-	swiotlb_sync_single(hwdev, dev_addr, size, dir, SYNC_FOR_DEVICE);
+	phys_addr_t paddr = dma_to_phys(hwdev, dev_addr);
+
+	BUG_ON(dir == DMA_NONE);
+
+	if (!is_swiotlb_buffer(paddr))
+		return;
+
+	swiotlb_tbl_sync_single(hwdev, paddr, size, dir, SYNC_FOR_DEVICE);
 }
 EXPORT_SYMBOL(swiotlb_sync_single_for_device);
 
@@ -929,10 +918,9 @@ swiotlb_unmap_sg_attrs(struct device *hwdev, struct scatterlist *sgl,
 	struct scatterlist *sg;
 	int i;
 
-	BUG_ON(dir == DMA_NONE);
-
 	for_each_sg(sgl, sg, nelems, i)
-		unmap_single(hwdev, sg->dma_address, sg_dma_len(sg), dir);
+		swiotlb_unmap_page(hwdev, sg->dma_address, sg_dma_len(sg),
+				   dir, attrs);
 
 }
 EXPORT_SYMBOL(swiotlb_unmap_sg_attrs);
@@ -952,32 +940,29 @@ EXPORT_SYMBOL(swiotlb_unmap_sg);
  * The same as swiotlb_sync_single_* but for a scatter-gather list, same rules
  * and usage.
  */
-static void
-swiotlb_sync_sg(struct device *hwdev, struct scatterlist *sgl,
-		int nelems, enum dma_data_direction dir,
-		enum dma_sync_target target)
+void
+swiotlb_sync_sg_for_cpu(struct device *hwdev, struct scatterlist *sgl,
+			int nelems, enum dma_data_direction dir)
 {
 	struct scatterlist *sg;
 	int i;
 
 	for_each_sg(sgl, sg, nelems, i)
-		swiotlb_sync_single(hwdev, sg->dma_address,
-				    sg_dma_len(sg), dir, target);
-}
-
-void
-swiotlb_sync_sg_for_cpu(struct device *hwdev, struct scatterlist *sg,
-			int nelems, enum dma_data_direction dir)
-{
-	swiotlb_sync_sg(hwdev, sg, nelems, dir, SYNC_FOR_CPU);
+		swiotlb_sync_single_for_cpu(hwdev, sg->dma_address,
+					    sg_dma_len(sg), dir);
 }
 EXPORT_SYMBOL(swiotlb_sync_sg_for_cpu);
 
 void
-swiotlb_sync_sg_for_device(struct device *hwdev, struct scatterlist *sg,
+swiotlb_sync_sg_for_device(struct device *hwdev, struct scatterlist *sgl,
 			   int nelems, enum dma_data_direction dir)
 {
-	swiotlb_sync_sg(hwdev, sg, nelems, dir, SYNC_FOR_DEVICE);
+	struct scatterlist *sg;
+	int i;
+
+	for_each_sg(sgl, sg, nelems, i)
+		swiotlb_sync_single_for_device(hwdev, sg->dma_address,
+					       sg_dma_len(sg), dir);
 }
 EXPORT_SYMBOL(swiotlb_sync_sg_for_device);
 

