Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:3515 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752940AbbHRTTM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Aug 2015 15:19:12 -0400
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
Subject: [PATCH v5 04/13] DMA-API: Introduce dma_(un)map_peer_resource
Date: Tue, 18 Aug 2015 14:04:00 -0500
Message-ID: <1439924649-29698-5-git-send-email-wdavis@nvidia.com>
In-Reply-To: <1439924649-29698-1-git-send-email-wdavis@nvidia.com>
References: <1439924649-29698-1-git-send-email-wdavis@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add functions to DMA-map and -unmap a peer device's resource for a given
device. This will allow devices to DMA-map, for example, another device's
BAR region on PCI to enable peer-to-peer transactions.

Guard these new functions behind CONFIG_HAS_DMA_P2P.

Signed-off-by: Will Davis <wdavis@nvidia.com>
---
 include/asm-generic/dma-mapping-common.h | 43 ++++++++++++++++++++++++++++++++
 include/linux/dma-mapping.h              | 12 +++++++++
 2 files changed, 55 insertions(+)

diff --git a/include/asm-generic/dma-mapping-common.h b/include/asm-generic/dma-mapping-common.h
index 940d5ec..45eec17 100644
--- a/include/asm-generic/dma-mapping-common.h
+++ b/include/asm-generic/dma-mapping-common.h
@@ -73,6 +73,42 @@ static inline void dma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg
 		ops->unmap_sg(dev, sg, nents, dir, attrs);
 }
 
+#ifdef CONFIG_HAS_DMA_P2P
+static inline dma_peer_addr_t dma_map_peer_resource_attrs(struct device *dev,
+							  struct device *peer,
+							  struct resource *res,
+							  size_t offset,
+							  size_t size,
+							  enum dma_data_direction dir,
+							  struct dma_attrs *attrs)
+{
+	struct dma_map_ops *ops = get_dma_ops(dev);
+	dma_peer_addr_t addr;
+
+	BUG_ON(!valid_dma_direction(dir));
+	BUG_ON(ops->map_peer_resource == NULL);
+	addr = ops->map_peer_resource(dev, peer, res, offset, size, dir,
+				      attrs);
+	debug_dma_map_peer_resource(dev, peer, res, offset, size, dir, addr);
+
+	return addr;
+}
+
+static inline void dma_unmap_peer_resource_attrs(struct device *dev,
+						 dma_peer_addr_t addr,
+						 size_t size,
+						 enum dma_data_direction dir,
+						 struct dma_attrs *attrs)
+{
+	struct dma_map_ops *ops = get_dma_ops(dev);
+
+	BUG_ON(!valid_dma_direction(dir));
+	if (ops->unmap_peer_resource)
+		ops->unmap_peer_resource(dev, addr, size, dir, attrs);
+	debug_dma_unmap_peer_resource(dev, addr, size, dir);
+}
+#endif
+
 static inline dma_addr_t dma_map_page(struct device *dev, struct page *page,
 				      size_t offset, size_t size,
 				      enum dma_data_direction dir)
@@ -181,6 +217,13 @@ dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
 #define dma_map_sg(d, s, n, r) dma_map_sg_attrs(d, s, n, r, NULL)
 #define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, NULL)
 
+#ifdef CONFIG_HAS_DMA_P2P
+#define dma_map_peer_resource(d, p, e, o, s, r) \
+	dma_map_peer_resource_attrs(d, p, e, o, s, r, NULL)
+#define dma_unmap_peer_resource(d, a, s, r) \
+	dma_unmap_peer_resource_attrs(d, a, s, r, NULL)
+#endif
+
 extern int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
 			   void *cpu_addr, dma_addr_t dma_addr, size_t size);
 
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index ac07ff0..7b8fddc 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -34,6 +34,18 @@ struct dma_map_ops {
 	void (*unmap_page)(struct device *dev, dma_addr_t dma_handle,
 			   size_t size, enum dma_data_direction dir,
 			   struct dma_attrs *attrs);
+#ifdef CONFIG_HAS_DMA_P2P
+	dma_peer_addr_t (*map_peer_resource)(struct device *dev,
+					     struct device *peer,
+					     struct resource *res,
+					     unsigned long offset, size_t size,
+					     enum dma_data_direction dir,
+					     struct dma_attrs *attrs);
+	void (*unmap_peer_resource)(struct device *dev,
+				    dma_peer_addr_t dma_handle,
+				    size_t size, enum dma_data_direction dir,
+				    struct dma_attrs *attrs);
+#endif
 	/*
 	 * map_sg returns 0 on error and a value > 0 on success.
 	 * It should never return a value < 0.
-- 
2.5.0

