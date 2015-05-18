Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:12597 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752380AbbERSic (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 18 May 2015 14:38:32 -0400
From: <wdavis@nvidia.com>
To: <joro@8bytes.org>, <bhelgaas@google.com>
CC: <iommu@lists.linux-foundation.org>, <linux-pci@vger.kernel.org>,
	<tripperda@nvidia.com>, <jhubbard@nvidia.com>,
	<jglisse@redhat.com>, <konrad.wilk@oracle.com>,
	Will Davis <wdavis@nvidia.com>
Subject: [PATCH v2 1/7] dma-debug: add checking for map/unmap_resource
Date: Mon, 18 May 2015 13:24:58 -0500
Message-ID: <1431973504-5903-2-git-send-email-wdavis@nvidia.com>
In-Reply-To: <1431973504-5903-1-git-send-email-wdavis@nvidia.com>
References: <1431973504-5903-1-git-send-email-wdavis@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Will Davis <wdavis@nvidia.com>

Add debug callbacks for the new dma_map_resource and dma_unmap_resource
functions.

Signed-off-by: Will Davis <wdavis@nvidia.com>
Reviewed-by: Terence Ripperda <tripperda@nvidia.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/dma-debug.h | 20 ++++++++++++++++++++
 lib/dma-debug.c           | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/include/linux/dma-debug.h b/include/linux/dma-debug.h
index fe8cb61..19f328c 100644
--- a/include/linux/dma-debug.h
+++ b/include/linux/dma-debug.h
@@ -44,6 +44,13 @@ extern void debug_dma_mapping_error(struct device *dev, dma_addr_t dma_addr);
 extern void debug_dma_unmap_page(struct device *dev, dma_addr_t addr,
 				 size_t size, int direction, bool map_single);
 
+extern void debug_dma_map_resource(struct device *dev, struct resource *res,
+				   size_t offset, size_t size, int direction,
+				   dma_addr_t dma_addr);
+
+extern void debug_dma_unmap_resource(struct device *dev, dma_addr_t addr,
+				     size_t size, int direction);
+
 extern void debug_dma_map_sg(struct device *dev, struct scatterlist *sg,
 			     int nents, int mapped_ents, int direction);
 
@@ -120,6 +127,19 @@ static inline void debug_dma_unmap_page(struct device *dev, dma_addr_t addr,
 {
 }
 
+static inline void debug_dma_map_resource(struct device *dev,
+					  struct resource *res, size_t offset,
+					  size_t size, int direction,
+					  dma_addr_t dma_addr)
+{
+}
+
+static inline void debug_dma_unmap_resource(struct device *dev,
+					    dma_addr_t addr, size_t size,
+					    int direction)
+{
+}
+
 static inline void debug_dma_map_sg(struct device *dev, struct scatterlist *sg,
 				    int nents, int mapped_ents, int direction)
 {
diff --git a/lib/dma-debug.c b/lib/dma-debug.c
index ae4b65e..a6d8fa7 100644
--- a/lib/dma-debug.c
+++ b/lib/dma-debug.c
@@ -43,6 +43,7 @@ enum {
 	dma_debug_page,
 	dma_debug_sg,
 	dma_debug_coherent,
+	dma_debug_resource,
 };
 
 enum map_err_types {
@@ -1348,6 +1349,52 @@ void debug_dma_unmap_page(struct device *dev, dma_addr_t addr,
 }
 EXPORT_SYMBOL(debug_dma_unmap_page);
 
+void debug_dma_map_resource(struct device *dev, struct resource *resource,
+			    size_t offset, size_t size, int direction,
+			    dma_addr_t dma_addr)
+{
+	struct dma_debug_entry *entry;
+
+	if (unlikely(dma_debug_disabled()))
+		return;
+
+	if (dma_mapping_error(dev, dma_addr))
+		return;
+
+	entry = dma_entry_alloc();
+	if (!entry)
+		return;
+
+	entry->dev       = dev;
+	entry->type      = dma_debug_resource;
+	entry->pfn       = resource->start >> PAGE_SHIFT;
+	entry->offset    = offset,
+	entry->dev_addr  = dma_addr;
+	entry->size      = size;
+	entry->direction = direction;
+
+	add_dma_entry(entry);
+}
+EXPORT_SYMBOL(debug_dma_map_resource);
+
+void debug_dma_unmap_resource(struct device *dev, dma_addr_t addr,
+			      size_t size, int direction)
+{
+	struct dma_debug_entry ref = {
+		.type           = dma_debug_resource,
+		.dev            = dev,
+		.dev_addr       = addr,
+		.size           = size,
+		.direction      = direction,
+	};
+
+	if (unlikely(dma_debug_disabled()))
+		return;
+
+	check_unmap(&ref);
+}
+EXPORT_SYMBOL(debug_dma_unmap_resource);
+
 void debug_dma_map_sg(struct device *dev, struct scatterlist *sg,
 		      int nents, int mapped_ents, int direction)
 {
-- 
2.4.0

