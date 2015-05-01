Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:19632 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737AbbEASpY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 1 May 2015 14:45:24 -0400
From: <wdavis@nvidia.com>
To: joro@8bytes.org
CC: iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
	tripperda@nvidia.com, jhubbard@nvidia.com, jglisse@redhat.com,
	Will Davis <wdavis@nvidia.com>
Subject: [PATCH 4/6] iommu/amd: Implement (un)map_resource
Date: Fri, 1 May 2015 13:32:16 -0500
Message-ID: <1430505138-2877-5-git-send-email-wdavis@nvidia.com>
In-Reply-To: <1430505138-2877-1-git-send-email-wdavis@nvidia.com>
References: <1430505138-2877-1-git-send-email-wdavis@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Will Davis <wdavis@nvidia.com>

Implement 'map_resource' for the AMD IOMMU driver. Generalize the existing
map_page implementation to operate on a physical address, and make both
map_page and map_resource wrappers around that helper (and similiarly, for
unmap_page and unmap_resource).

This allows a device to map another's resource, to enable peer-to-peer
transactions.

Signed-off-by: Will Davis <wdavis@nvidia.com>
Reviewed-by: Terence Ripperda <tripperda@nvidia.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
---
 drivers/iommu/amd_iommu.c | 76 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 63 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index e43d489..ca2dac6 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -503,6 +503,8 @@ DECLARE_STATS_COUNTER(cnt_map_single);
 DECLARE_STATS_COUNTER(cnt_unmap_single);
 DECLARE_STATS_COUNTER(cnt_map_sg);
 DECLARE_STATS_COUNTER(cnt_unmap_sg);
+DECLARE_STATS_COUNTER(cnt_map_resource);
+DECLARE_STATS_COUNTER(cnt_unmap_resource);
 DECLARE_STATS_COUNTER(cnt_alloc_coherent);
 DECLARE_STATS_COUNTER(cnt_free_coherent);
 DECLARE_STATS_COUNTER(cross_page);
@@ -541,6 +543,8 @@ static void amd_iommu_stats_init(void)
 	amd_iommu_stats_add(&cnt_unmap_single);
 	amd_iommu_stats_add(&cnt_map_sg);
 	amd_iommu_stats_add(&cnt_unmap_sg);
+	amd_iommu_stats_add(&cnt_map_resource);
+	amd_iommu_stats_add(&cnt_unmap_resource);
 	amd_iommu_stats_add(&cnt_alloc_coherent);
 	amd_iommu_stats_add(&cnt_free_coherent);
 	amd_iommu_stats_add(&cross_page);
@@ -2752,20 +2756,16 @@ static void __unmap_single(struct dma_ops_domain *dma_dom,
 }
 
 /*
- * The exported map_single function for dma_ops.
+ * Wrapper function that contains code common to mapping a physical address
+ * range from a page or a resource.
  */
-static dma_addr_t map_page(struct device *dev, struct page *page,
-			   unsigned long offset, size_t size,
-			   enum dma_data_direction dir,
-			   struct dma_attrs *attrs)
+static dma_addr_t __map_phys(struct device *dev, phys_addr_t paddr,
+			     size_t size, enum dma_data_direction dir)
 {
 	unsigned long flags;
 	struct protection_domain *domain;
 	dma_addr_t addr;
 	u64 dma_mask;
-	phys_addr_t paddr = page_to_phys(page) + offset;
-
-	INC_STATS_COUNTER(cnt_map_single);
 
 	domain = get_domain(dev);
 	if (PTR_ERR(domain) == -EINVAL)
@@ -2791,16 +2791,15 @@ out:
 }
 
 /*
- * The exported unmap_single function for dma_ops.
+ * Wrapper function that contains code common to unmapping a physical address
+ * range from a page or a resource.
  */
-static void unmap_page(struct device *dev, dma_addr_t dma_addr, size_t size,
-		       enum dma_data_direction dir, struct dma_attrs *attrs)
+static void __unmap_phys(struct device *dev, dma_addr_t dma_addr, size_t size,
+			 enum dma_data_direction dir)
 {
 	unsigned long flags;
 	struct protection_domain *domain;
 
-	INC_STATS_COUNTER(cnt_unmap_single);
-
 	domain = get_domain(dev);
 	if (IS_ERR(domain))
 		return;
@@ -2815,6 +2814,55 @@ static void unmap_page(struct device *dev, dma_addr_t dma_addr, size_t size,
 }
 
 /*
+ * The exported map_single function for dma_ops.
+ */
+static dma_addr_t map_page(struct device *dev, struct page *page,
+			   unsigned long offset, size_t size,
+			   enum dma_data_direction dir,
+			   struct dma_attrs *attrs)
+{
+	INC_STATS_COUNTER(cnt_map_single);
+
+	return __map_phys(dev, page_to_phys(page) + offset, size, dir);
+}
+
+/*
+ * The exported unmap_single function for dma_ops.
+ */
+static void unmap_page(struct device *dev, dma_addr_t dma_addr, size_t size,
+		       enum dma_data_direction dir, struct dma_attrs *attrs)
+{
+	INC_STATS_COUNTER(cnt_unmap_single);
+
+	__unmap_phys(dev, dma_addr, size, dir);
+}
+
+/*
+ * The exported map_resource function for dma_ops.
+ */
+static dma_addr_t map_resource(struct device *dev, struct resource *res,
+			       unsigned long offset, size_t size,
+			       enum dma_data_direction dir,
+			       struct dma_attrs *attrs)
+{
+	INC_STATS_COUNTER(cnt_map_resource);
+
+	return __map_phys(dev, res->start + offset, size, dir);
+}
+
+/*
+ * The exported unmap_resource function for dma_ops.
+ */
+static void unmap_resource(struct device *dev, dma_addr_t dma_addr,
+			   size_t size, enum dma_data_direction dir,
+			   struct dma_attrs *attrs)
+{
+	INC_STATS_COUNTER(cnt_unmap_resource);
+
+	__unmap_phys(dev, dma_addr, size, dir);
+}
+
+/*
  * The exported map_sg function for dma_ops (handles scatter-gather
  * lists).
  */
@@ -3066,6 +3114,8 @@ static struct dma_map_ops amd_iommu_dma_ops = {
 	.unmap_page = unmap_page,
 	.map_sg = map_sg,
 	.unmap_sg = unmap_sg,
+	.map_resource = map_resource,
+	.unmap_resource = unmap_resource,
 	.dma_supported = amd_iommu_dma_supported,
 };
 
-- 
2.3.7

