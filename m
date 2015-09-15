Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:12044 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751699AbbIORL6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Sep 2015 13:11:58 -0400
From: Will Davis <wdavis@nvidia.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Alex Williamson <alex.williamson@redhat.com>,
	Joerg Roedel <joro@8bytes.org>,
	<iommu@lists.linux-foundation.org>, <linux-pci@vger.kernel.org>,
	Konrad Wilk <konrad.wilk@oracle.com>,
	Mark Hounschell <markh@compro.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Terence Ripperda <tripperda@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Jerome Glisse <jglisse@redhat.com>,
	Will Davis <wdavis@nvidia.com>
Subject: [PATCH 16/22] iommu/amd: Implement (un)map_peer_resource
Date: Tue, 15 Sep 2015 12:11:01 -0500
Message-ID: <1442337067-22964-17-git-send-email-wdavis@nvidia.com>
In-Reply-To: <1442337067-22964-1-git-send-email-wdavis@nvidia.com>
References: <1442337067-22964-1-git-send-email-wdavis@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Implement 'map_peer_resource' for the AMD IOMMU driver. Generalize the
existing map_page implementation to operate on a physical address, and
make both map_page and map_resource wrappers around that helper (and
similarly, for unmap_page and unmap_resource).

This allows a device to map another's resource, to enable peer-to-peer
transactions.

Add behind CONFIG_HAS_DMA_P2P guards, since the dma_map_ops members are
behind them as well.

Signed-off-by: Will Davis <wdavis@nvidia.com>
Reviewed-by: Terence Ripperda <tripperda@nvidia.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
---
 drivers/iommu/amd_iommu.c | 99 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 86 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index a57e9b7..13a47f283 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -471,6 +471,10 @@ DECLARE_STATS_COUNTER(cnt_map_single);
 DECLARE_STATS_COUNTER(cnt_unmap_single);
 DECLARE_STATS_COUNTER(cnt_map_sg);
 DECLARE_STATS_COUNTER(cnt_unmap_sg);
+#ifdef CONFIG_HAS_DMA_P2P
+DECLARE_STATS_COUNTER(cnt_map_peer_resource);
+DECLARE_STATS_COUNTER(cnt_unmap_peer_resource);
+#endif
 DECLARE_STATS_COUNTER(cnt_alloc_coherent);
 DECLARE_STATS_COUNTER(cnt_free_coherent);
 DECLARE_STATS_COUNTER(cross_page);
@@ -509,6 +513,10 @@ static void amd_iommu_stats_init(void)
 	amd_iommu_stats_add(&cnt_unmap_single);
 	amd_iommu_stats_add(&cnt_map_sg);
 	amd_iommu_stats_add(&cnt_unmap_sg);
+#ifdef CONFIG_HAS_DMA_P2P
+	amd_iommu_stats_add(&cnt_map_peer_resource);
+	amd_iommu_stats_add(&cnt_unmap_peer_resource);
+#endif
 	amd_iommu_stats_add(&cnt_alloc_coherent);
 	amd_iommu_stats_add(&cnt_free_coherent);
 	amd_iommu_stats_add(&cross_page);
@@ -2585,20 +2593,16 @@ static void __unmap_single(struct dma_ops_domain *dma_dom,
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
@@ -2624,16 +2628,15 @@ out:
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
@@ -2707,6 +2710,72 @@ unmap:
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
+#ifdef CONFIG_HAS_DMA_P2P
+/*
+ * The exported map_peer_resource function for dma_ops.
+ */
+static dma_peer_addr_t map_peer_resource(struct device *dev,
+					 struct device *peer,
+					 struct resource *res,
+					 unsigned long offset,
+					 size_t size,
+					 enum dma_data_direction dir,
+					 struct dma_attrs *attrs)
+{
+	struct pci_dev *pdev;
+	struct pci_dev *ppeer;
+
+	INC_STATS_COUNTER(cnt_map_peer_resource);
+
+	if (!dev_is_pci(dev) || !dev_is_pci(peer))
+		return DMA_ERROR_CODE;
+
+	pdev = to_pci_dev(dev);
+	ppeer = to_pci_dev(peer);
+
+	if (!pci_peer_traffic_supported(pdev, ppeer))
+		return DMA_ERROR_CODE;
+
+	return __map_phys(dev, res->start + offset, size, dir);
+}
+
+/*
+ * The exported unmap_peer_resource function for dma_ops.
+ */
+static void unmap_peer_resource(struct device *dev, dma_peer_addr_t dma_addr,
+				size_t size, enum dma_data_direction dir,
+				struct dma_attrs *attrs)
+{
+	INC_STATS_COUNTER(cnt_unmap_peer_resource);
+
+	__unmap_phys(dev, dma_addr, size, dir);
+}
+#endif
+
+/*
  * The exported map_sg function for dma_ops (handles scatter-gather
  * lists).
  */
@@ -2852,6 +2921,10 @@ static struct dma_map_ops amd_iommu_dma_ops = {
 	.unmap_page = unmap_page,
 	.map_sg = map_sg,
 	.unmap_sg = unmap_sg,
+#ifdef CONFIG_HAS_DMA_P2P
+	.map_peer_resource = map_peer_resource,
+	.unmap_peer_resource = unmap_peer_resource,
+#endif
 	.dma_supported = amd_iommu_dma_supported,
 };
 
-- 
2.5.1

