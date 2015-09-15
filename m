Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:7915 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751673AbbIORLw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Sep 2015 13:11:52 -0400
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
Subject: [PATCH 14/22] swiotlb-xen: add map_peer_resource stub
Date: Tue, 15 Sep 2015 12:10:59 -0500
Message-ID: <1442337067-22964-15-git-send-email-wdavis@nvidia.com>
In-Reply-To: <1442337067-22964-1-git-send-email-wdavis@nvidia.com>
References: <1442337067-22964-1-git-send-email-wdavis@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add Xen stub of the map_peer_resource DMA API. Return an error to
indicate no bounce-buffer implementation is available yet.

Signed-off-by: Will Davis <wdavis@nvidia.com>
---
 drivers/xen/swiotlb-xen.c | 20 ++++++++++++++++++++
 include/xen/swiotlb-xen.h | 11 +++++++++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 4c54932..b9879dc 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -475,6 +475,26 @@ void xen_swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
 }
 EXPORT_SYMBOL_GPL(xen_swiotlb_unmap_page);
 
+#ifdef CONFIG_HAS_DMA_P2P
+/*
+ * Maps a single region from a peer device's resource for DMA streaming. This is
+ * currently unimplemented for Xen because the only peer DMA mappings we're
+ * capable of creating are direct mappings with no explicit synchronization,
+ * e.g., there's no bounce buffer abstraction for peer mappings.
+ */
+dma_peer_addr_t xen_swiotlb_map_peer_resource(struct device *hwdev,
+					      struct device *hwpeer,
+					      struct resource *res,
+					      unsigned long offset,
+					      size_t size,
+					      enum dma_data_direction dir,
+					      struct dma_attrs *attrs)
+{
+	return DMA_ERROR_CODE;
+}
+EXPORT_SYMBOL_GPL(xen_swiotlb_map_peer_resource);
+#endif
+
 /*
  * Make physical memory consistent for a single streaming mode DMA translation
  * after a transfer.
diff --git a/include/xen/swiotlb-xen.h b/include/xen/swiotlb-xen.h
index 8b2eb93..dc08a4f 100644
--- a/include/xen/swiotlb-xen.h
+++ b/include/xen/swiotlb-xen.h
@@ -24,6 +24,17 @@ extern dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
 extern void xen_swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
 				   size_t size, enum dma_data_direction dir,
 				   struct dma_attrs *attrs);
+
+#ifdef CONFIG_HAS_DMA_P2P
+extern dma_peer_addr_t xen_swiotlb_map_peer(struct device *hwdev,
+					    struct device *hwpeer,
+					    struct resource *res,
+					    unsigned long offset,
+					    size_t size,
+					    enum dma_data_direction dir,
+					    struct dma_attrs *attrs);
+#endif
+
 extern int
 xen_swiotlb_map_sg_attrs(struct device *hwdev, struct scatterlist *sgl,
 			 int nelems, enum dma_data_direction dir,
-- 
2.5.1

