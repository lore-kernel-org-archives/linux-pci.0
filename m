Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:19627 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839AbbEASpW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 1 May 2015 14:45:22 -0400
From: <wdavis@nvidia.com>
To: joro@8bytes.org
CC: iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
	tripperda@nvidia.com, jhubbard@nvidia.com, jglisse@redhat.com,
	Will Davis <wdavis@nvidia.com>
Subject: [PATCH 2/6] DMA-API: Introduce dma_(un)map_resource
Date: Fri, 1 May 2015 13:32:14 -0500
Message-ID: <1430505138-2877-3-git-send-email-wdavis@nvidia.com>
In-Reply-To: <1430505138-2877-1-git-send-email-wdavis@nvidia.com>
References: <1430505138-2877-1-git-send-email-wdavis@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Will Davis <wdavis@nvidia.com>

Add functions to DMA-map and -unmap a resource for a given device. This
will allow devices to DMA-map a peer device's resource (for example,
another device's BAR region on PCI) to enable peer-to-peer transactions.

Signed-off-by: Will Davis <wdavis@nvidia.com>
Reviewed-by: Terence Ripperda <tripperda@nvidia.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
---
 include/asm-generic/dma-mapping-broken.h |  9 +++++++++
 include/asm-generic/dma-mapping-common.h | 34 ++++++++++++++++++++++++++++++++
 include/linux/dma-mapping.h              |  7 +++++++
 3 files changed, 50 insertions(+)

diff --git a/include/asm-generic/dma-mapping-broken.h b/include/asm-generic/dma-mapping-broken.h
index 6c32af9..d171f01 100644
--- a/include/asm-generic/dma-mapping-broken.h
+++ b/include/asm-generic/dma-mapping-broken.h
@@ -59,6 +59,15 @@ extern void
 dma_unmap_page(struct device *dev, dma_addr_t dma_address, size_t size,
 	       enum dma_data_direction direction);
 
+extern dma_addr_t
+dma_map_resource(struct device *dev, struct resource *res,
+		 unsigned long offset, size_t size,
+		 enum dma_data_direction direction);
+
+extern void
+dma_unmap_resource(struct device *dev, dma_addr_t dma_address, size_t size,
+		   enum dma_data_direction direction);
+
 extern void
 dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle, size_t size,
 			enum dma_data_direction direction);
diff --git a/include/asm-generic/dma-mapping-common.h b/include/asm-generic/dma-mapping-common.h
index 940d5ec..cd9948d 100644
--- a/include/asm-generic/dma-mapping-common.h
+++ b/include/asm-generic/dma-mapping-common.h
@@ -73,6 +73,36 @@ static inline void dma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg
 		ops->unmap_sg(dev, sg, nents, dir, attrs);
 }
 
+static inline dma_addr_t dma_map_resource_attrs(struct device *dev,
+						struct resource *res,
+						size_t offset, size_t size,
+						enum dma_data_direction dir,
+						struct dma_attrs *attrs)
+{
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+	dma_addr_t addr = 0;
+
+	BUG_ON(!valid_dma_direction(dir));
+	if (ops->map_resource)
+		addr = ops->map_resource(dev, res, offset, size, dir, attrs);
+	debug_dma_map_resource(dev, res, offset, size, dir, addr);
+
+	return addr;
+}
+
+static inline void dma_unmap_resource_attrs(struct device *dev, dma_addr_t addr,
+					    size_t size,
+					    enum dma_data_direction dir,
+					    struct dma_attrs *attrs)
+{
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+
+	BUG_ON(!valid_dma_direction(dir));
+	if (ops->unmap_resource)
+		ops->unmap_resource(dev, addr, size, dir, attrs);
+	debug_dma_unmap_resource(dev, addr, size, dir);
+}
+
 static inline dma_addr_t dma_map_page(struct device *dev, struct page *page,
 				      size_t offset, size_t size,
 				      enum dma_data_direction dir)
@@ -180,6 +210,10 @@ dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
 #define dma_unmap_single(d, a, s, r) dma_unmap_single_attrs(d, a, s, r, NULL)
 #define dma_map_sg(d, s, n, r) dma_map_sg_attrs(d, s, n, r, NULL)
 #define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, NULL)
+#define dma_map_resource(d, e, o, s, r) \
+	dma_map_resource_attrs(d, e, o, s, r, NULL)
+#define dma_unmap_resource(d, a, s, r) \
+	dma_unmap_resource_attrs(d, a, s, r, NULL)
 
 extern int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
 			   void *cpu_addr, dma_addr_t dma_addr, size_t size);
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index ac07ff0..05b0b51 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -34,6 +34,13 @@ struct dma_map_ops {
 	void (*unmap_page)(struct device *dev, dma_addr_t dma_handle,
 			   size_t size, enum dma_data_direction dir,
 			   struct dma_attrs *attrs);
+	dma_addr_t (*map_resource)(struct device *dev, struct resource *res,
+				   unsigned long offset, size_t size,
+				   enum dma_data_direction dir,
+				   struct dma_attrs *attrs);
+	void (*unmap_resource)(struct device *dev, dma_addr_t dma_handle,
+			       size_t size, enum dma_data_direction dir,
+			       struct dma_attrs *attrs);
 	/*
 	 * map_sg returns 0 on error and a value > 0 on success.
 	 * It should never return a value < 0.
-- 
2.3.7

