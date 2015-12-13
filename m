Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:36758 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932115AbbLMV21 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 13 Dec 2015 16:28:27 -0500
Received: by pfbu66 with SMTP id u66so50287886pfb.3
        for <linux-pci@vger.kernel.org>; Sun, 13 Dec 2015 13:28:26 -0800 (PST)
Subject: [RFC PATCH 2/3] xen/swiotlb: Fold static unmap and sync calls into
 calling functions
From: Alexander Duyck <aduyck@mirantis.com>
To: kvm@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, alexander.duyck@gmail.com,
	qemu-devel@nongnu.org
Cc: tianyu.lan@intel.com, yang.zhang.wz@gmail.com, mst@redhat.com,
	konrad.wilk@oracle.com, dgilbert@redhat.com, agraf@suse.de,
	alex.williamson@redhat.com
Date: Sun, 13 Dec 2015 13:28:24 -0800
Message-ID: <20151213212823.5410.12367.stgit@localhost.localdomain>
In-Reply-To: <20151213212557.5410.48577.stgit@localhost.localdomain>
References: <20151213212557.5410.48577.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
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
 drivers/xen/swiotlb-xen.c |   90 ++++++++++++++++++---------------------------
 1 file changed, 36 insertions(+), 54 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 7399782c0998..2154c70e47da 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -432,9 +432,9 @@ EXPORT_SYMBOL_GPL(xen_swiotlb_map_page);
  * After this call, reads by the cpu to the buffer are guaranteed to see
  * whatever the device wrote there.
  */
-static void xen_unmap_single(struct device *hwdev, dma_addr_t dev_addr,
-			     size_t size, enum dma_data_direction dir,
-				 struct dma_attrs *attrs)
+void xen_swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
+			    size_t size, enum dma_data_direction dir,
+			    struct dma_attrs *attrs)
 {
 	phys_addr_t paddr = xen_bus_to_phys(dev_addr);
 
@@ -448,23 +448,14 @@ static void xen_unmap_single(struct device *hwdev, dma_addr_t dev_addr,
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
-void xen_swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
-			    size_t size, enum dma_data_direction dir,
-			    struct dma_attrs *attrs)
-{
-	xen_unmap_single(hwdev, dev_addr, size, dir, attrs);
+	if (dir == DMA_FROM_DEVICE)
+		dma_mark_clean(phys_to_virt(paddr), size);
 }
 EXPORT_SYMBOL_GPL(xen_swiotlb_unmap_page);
 
@@ -478,36 +469,22 @@ EXPORT_SYMBOL_GPL(xen_swiotlb_unmap_page);
  * address back to the card, you must first perform a
  * xen_swiotlb_dma_sync_for_device, and then the device again owns the buffer
  */
-static void
-xen_swiotlb_sync_single(struct device *hwdev, dma_addr_t dev_addr,
-			size_t size, enum dma_data_direction dir,
-			enum dma_sync_target target)
+void
+xen_swiotlb_sync_single_for_cpu(struct device *hwdev, dma_addr_t dev_addr,
+				size_t size, enum dma_data_direction dir)
 {
 	phys_addr_t paddr = xen_bus_to_phys(dev_addr);
 
 	BUG_ON(dir == DMA_NONE);
 
-	if (target == SYNC_FOR_CPU)
-		xen_dma_sync_single_for_cpu(hwdev, dev_addr, size, dir);
+	xen_dma_sync_single_for_cpu(hwdev, dev_addr, size, dir);
 
 	/* NOTE: We use dev_addr here, not paddr! */
 	if (is_xen_swiotlb_buffer(dev_addr))
-		swiotlb_tbl_sync_single(hwdev, paddr, size, dir, target);
-
-	if (target == SYNC_FOR_DEVICE)
-		xen_dma_sync_single_for_device(hwdev, dev_addr, size, dir);
-
-	if (dir != DMA_FROM_DEVICE)
-		return;
+		swiotlb_tbl_sync_single(hwdev, paddr, size, dir, SYNC_FOR_CPU);
 
-	dma_mark_clean(phys_to_virt(paddr), size);
-}
-
-void
-xen_swiotlb_sync_single_for_cpu(struct device *hwdev, dma_addr_t dev_addr,
-				size_t size, enum dma_data_direction dir)
-{
-	xen_swiotlb_sync_single(hwdev, dev_addr, size, dir, SYNC_FOR_CPU);
+	if (dir == DMA_FROM_DEVICE)
+		dma_mark_clean(phys_to_virt(paddr), size);
 }
 EXPORT_SYMBOL_GPL(xen_swiotlb_sync_single_for_cpu);
 
@@ -515,7 +492,16 @@ void
 xen_swiotlb_sync_single_for_device(struct device *hwdev, dma_addr_t dev_addr,
 				   size_t size, enum dma_data_direction dir)
 {
-	xen_swiotlb_sync_single(hwdev, dev_addr, size, dir, SYNC_FOR_DEVICE);
+	phys_addr_t paddr = xen_bus_to_phys(dev_addr);
+
+	BUG_ON(dir == DMA_NONE);
+
+	/* NOTE: We use dev_addr here, not paddr! */
+	if (is_xen_swiotlb_buffer(dev_addr))
+		swiotlb_tbl_sync_single(hwdev, paddr, size, dir,
+					SYNC_FOR_DEVICE);
+
+	xen_dma_sync_single_for_device(hwdev, dev_addr, size, dir);
 }
 EXPORT_SYMBOL_GPL(xen_swiotlb_sync_single_for_device);
 
@@ -604,10 +590,9 @@ xen_swiotlb_unmap_sg_attrs(struct device *hwdev, struct scatterlist *sgl,
 	struct scatterlist *sg;
 	int i;
 
-	BUG_ON(dir == DMA_NONE);
-
 	for_each_sg(sgl, sg, nelems, i)
-		xen_unmap_single(hwdev, sg->dma_address, sg_dma_len(sg), dir, attrs);
+		xen_swiotlb_unmap_page(hwdev, sg->dma_address, sg_dma_len(sg),
+				       dir, attrs);
 
 }
 EXPORT_SYMBOL_GPL(xen_swiotlb_unmap_sg_attrs);
@@ -619,32 +604,29 @@ EXPORT_SYMBOL_GPL(xen_swiotlb_unmap_sg_attrs);
  * The same as swiotlb_sync_single_* but for a scatter-gather list, same rules
  * and usage.
  */
-static void
-xen_swiotlb_sync_sg(struct device *hwdev, struct scatterlist *sgl,
-		    int nelems, enum dma_data_direction dir,
-		    enum dma_sync_target target)
+void
+xen_swiotlb_sync_sg_for_cpu(struct device *hwdev, struct scatterlist *sgl,
+			    int nelems, enum dma_data_direction dir)
 {
 	struct scatterlist *sg;
 	int i;
 
 	for_each_sg(sgl, sg, nelems, i)
-		xen_swiotlb_sync_single(hwdev, sg->dma_address,
-					sg_dma_len(sg), dir, target);
-}
-
-void
-xen_swiotlb_sync_sg_for_cpu(struct device *hwdev, struct scatterlist *sg,
-			    int nelems, enum dma_data_direction dir)
-{
-	xen_swiotlb_sync_sg(hwdev, sg, nelems, dir, SYNC_FOR_CPU);
+		xen_swiotlb_sync_single_for_cpu(hwdev, sg->dma_address,
+						sg_dma_len(sg), dir);
 }
 EXPORT_SYMBOL_GPL(xen_swiotlb_sync_sg_for_cpu);
 
 void
-xen_swiotlb_sync_sg_for_device(struct device *hwdev, struct scatterlist *sg,
+xen_swiotlb_sync_sg_for_device(struct device *hwdev, struct scatterlist *sgl,
 			       int nelems, enum dma_data_direction dir)
 {
-	xen_swiotlb_sync_sg(hwdev, sg, nelems, dir, SYNC_FOR_DEVICE);
+	struct scatterlist *sg;
+	int i;
+
+	for_each_sg(sgl, sg, nelems, i)
+		xen_swiotlb_sync_single_for_device(hwdev, sg->dma_address,
+						   sg_dma_len(sg), dir);
 }
 EXPORT_SYMBOL_GPL(xen_swiotlb_sync_sg_for_device);
 

