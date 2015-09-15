Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:12021 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074AbbIORLo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Sep 2015 13:11:44 -0400
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
Subject: [PATCH 11/22] swiotlb: Add map_peer_resource stub
Date: Tue, 15 Sep 2015 12:10:56 -0500
Message-ID: <1442337067-22964-12-git-send-email-wdavis@nvidia.com>
In-Reply-To: <1442337067-22964-1-git-send-email-wdavis@nvidia.com>
References: <1442337067-22964-1-git-send-email-wdavis@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add swiotlb stub of the 'map_peer_resource' DMA operation.

Signed-off-by: Will Davis <wdavis@nvidia.com>
---
 include/linux/swiotlb.h |  8 ++++++++
 lib/swiotlb.c           | 17 +++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index e7a018e..872463a 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -87,6 +87,14 @@ swiotlb_unmap_sg_attrs(struct device *hwdev, struct scatterlist *sgl,
 		       int nelems, enum dma_data_direction dir,
 		       struct dma_attrs *attrs);
 
+#ifdef CONFIG_HAS_DMA_P2P
+extern dma_peer_addr_t
+swiotlb_map_peer_resource(struct device *hwdev, struct device *hwpeer,
+			  struct resource *res, unsigned long offset,
+			  size_t size, enum dma_data_direction dir,
+			  struct dma_attrs *attrs);
+#endif
+
 extern void
 swiotlb_sync_single_for_cpu(struct device *hwdev, dma_addr_t dev_addr,
 			    size_t size, enum dma_data_direction dir);
diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index 76f29ec..61522a7 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -945,6 +945,23 @@ swiotlb_unmap_sg(struct device *hwdev, struct scatterlist *sgl, int nelems,
 }
 EXPORT_SYMBOL(swiotlb_unmap_sg);
 
+#ifdef CONFIG_HAS_DMA_P2P
+/*
+ * Maps a single region from a peer device's resource for DMA streaming. This
+ * is currently unimplemented because there's no bounce buffer abstraction for
+ * peer mappings.
+ */
+dma_peer_addr_t
+swiotlb_map_peer_resource(struct device *hwdev, struct device *hwpeer,
+			  struct resource *res, unsigned long offset,
+			  size_t size, enum dma_data_direction dir,
+			  struct dma_attrs *attrs)
+{
+	return phys_to_dma(hwdev, io_tlb_overflow_buffer);
+}
+EXPORT_SYMBOL(swiotlb_map_peer_resource);
+#endif
+
 /*
  * Make physical memory consistent for a set of streaming mode DMA translations
  * after a transfer.
-- 
2.5.1

