Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:7815 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074AbbIORLZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Sep 2015 13:11:25 -0400
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
Subject: [PATCH 03/22] dma-debug: add checking for map/unmap_peer_resource
Date: Tue, 15 Sep 2015 12:10:48 -0500
Message-ID: <1442337067-22964-4-git-send-email-wdavis@nvidia.com>
In-Reply-To: <1442337067-22964-1-git-send-email-wdavis@nvidia.com>
References: <1442337067-22964-1-git-send-email-wdavis@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add debug callbacks for the new dma_map_peer_resource and
dma_unmap_peer_resource functions.

Also add a callback for dma_peer_mapping_error. Most of the time this will
be identical to dma_mapping_error, except where the dma_addr_t is not as
wide as dma_peer_addr_t.

Guard these new callbacks behind a CONFIG_HAS_DMA_P2P check.

Signed-off-by: Will Davis <wdavis@nvidia.com>
Reviewed-by: Terence Ripperda <tripperda@nvidia.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/dma-debug.h | 39 ++++++++++++++++++++-
 lib/dma-debug.c           | 86 +++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 122 insertions(+), 3 deletions(-)

diff --git a/include/linux/dma-debug.h b/include/linux/dma-debug.h
index fe8cb61..4ff8364 100644
--- a/include/linux/dma-debug.h
+++ b/include/linux/dma-debug.h
@@ -43,7 +43,21 @@ extern void debug_dma_mapping_error(struct device *dev, dma_addr_t dma_addr);
 
 extern void debug_dma_unmap_page(struct device *dev, dma_addr_t addr,
 				 size_t size, int direction, bool map_single);
-
+#ifdef CONFIG_HAS_DMA_P2P
+extern void debug_dma_map_peer_resource(struct device *dev,
+					struct device *peer,
+					struct resource *resource,
+					size_t offset, size_t size,
+					int direction,
+					dma_peer_addr_t dma_addr);
+
+extern void debug_dma_peer_mapping_error(struct device *dev,
+					 dma_peer_addr_t dma_addr);
+
+extern void debug_dma_unmap_peer_resource(struct device *dev,
+					  dma_peer_addr_t addr,
+					  size_t size, int direction);
+#endif
 extern void debug_dma_map_sg(struct device *dev, struct scatterlist *sg,
 			     int nents, int mapped_ents, int direction);
 
@@ -120,6 +134,29 @@ static inline void debug_dma_unmap_page(struct device *dev, dma_addr_t addr,
 {
 }
 
+#ifdef CONFIG_HAS_DMA_P2P
+static inline void debug_dma_map_peer_resource(struct device *dev,
+					       struct device *peer,
+					       struct resource *resource,
+					       size_t offset, size_t size,
+					       int direction,
+					       dma_peer_addr_t dma_addr)
+{
+}
+
+static inline void debug_dma_peer_mapping_error(struct device *dev,
+						dma_peer_addr_t dma_addr)
+{
+}
+
+static inline void debug_dma_unmap_peer_resource(struct device *dev,
+						 dma_peer_addr_t addr,
+						 size_t size,
+						 int direction)
+{
+}
+#endif
+
 static inline void debug_dma_map_sg(struct device *dev, struct scatterlist *sg,
 				    int nents, int mapped_ents, int direction)
 {
diff --git a/lib/dma-debug.c b/lib/dma-debug.c
index ae4b65e..622f569 100644
--- a/lib/dma-debug.c
+++ b/lib/dma-debug.c
@@ -43,6 +43,7 @@ enum {
 	dma_debug_page,
 	dma_debug_sg,
 	dma_debug_coherent,
+	dma_debug_peer_resource,
 };
 
 enum map_err_types {
@@ -64,7 +65,8 @@ enum map_err_types {
  * @direction: enum dma_data_direction
  * @sg_call_ents: 'nents' from dma_map_sg
  * @sg_mapped_ents: 'mapped_ents' from dma_map_sg
- * @map_err_type: track whether dma_mapping_error() was checked
+ * @map_err_type: track whether dma_mapping_error() or dma_peer_mapping_error()
+ *		  was called
  * @stacktrace: support backtraces when a violation is detected
  */
 struct dma_debug_entry {
@@ -1250,6 +1252,23 @@ out:
 	put_hash_bucket(bucket, &flags);
 }
 
+static void check_mapping_error(struct dma_debug_entry *entry, bool peer)
+{
+	if (peer && !(entry->type == dma_debug_peer_resource))
+		err_printk(entry->dev, entry, "DMA-API: device driver calls "
+				"dma_peer_mapping_error() on dma_addr_t "
+				"[device address=0x%016llx] [size=%llu bytes]\n",
+				(unsigned long long)entry->dev_addr,
+				entry->size);
+
+	if (!peer && (entry->type == dma_debug_peer_resource))
+		err_printk(entry->dev, entry, "DMA-API: device driver calls "
+				"dma_mapping_error() on dma_peer_addr_t "
+				"[device address=0x%016llx] [size=%llu bytes]\n",
+				(unsigned long long)entry->dev_addr,
+				entry->size);
+}
+
 void debug_dma_map_page(struct device *dev, struct page *page, size_t offset,
 			size_t size, int direction, dma_addr_t dma_addr,
 			bool map_single)
@@ -1289,7 +1308,9 @@ void debug_dma_map_page(struct device *dev, struct page *page, size_t offset,
 }
 EXPORT_SYMBOL(debug_dma_map_page);
 
-void debug_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
+static void debug_dma_mapping_error_common(struct device *dev,
+					   u64 dma_addr,
+					   bool peer)
 {
 	struct dma_debug_entry ref;
 	struct dma_debug_entry *entry;
@@ -1319,12 +1340,18 @@ void debug_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
 		 */
 		if (entry->map_err_type == MAP_ERR_NOT_CHECKED) {
 			entry->map_err_type = MAP_ERR_CHECKED;
+			check_mapping_error(entry, peer);
 			break;
 		}
 	}
 
 	put_hash_bucket(bucket, &flags);
 }
+
+void debug_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
+{
+	debug_dma_mapping_error_common(dev, (u64)dma_addr, false);
+}
 EXPORT_SYMBOL(debug_dma_mapping_error);
 
 void debug_dma_unmap_page(struct device *dev, dma_addr_t addr,
@@ -1348,6 +1375,61 @@ void debug_dma_unmap_page(struct device *dev, dma_addr_t addr,
 }
 EXPORT_SYMBOL(debug_dma_unmap_page);
 
+#ifdef CONFIG_HAS_DMA_P2P
+void debug_dma_map_peer_resource(struct device *dev, struct device *peer,
+				 struct resource *resource, size_t offset,
+				 size_t size, int direction,
+				 dma_peer_addr_t dma_addr)
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
+	entry->type      = dma_debug_peer_resource;
+	entry->pfn       = resource->start >> PAGE_SHIFT;
+	entry->offset    = offset,
+	entry->dev_addr  = dma_addr;
+	entry->size      = size;
+	entry->direction = direction;
+
+	add_dma_entry(entry);
+}
+EXPORT_SYMBOL(debug_dma_map_peer_resource);
+
+void debug_dma_peer_mapping_error(struct device *dev, dma_peer_addr_t dma_addr)
+{
+	debug_dma_mapping_error_common(dev, (u64)dma_addr, true);
+}
+EXPORT_SYMBOL(debug_dma_peer_mapping_error);
+
+void debug_dma_unmap_peer_resource(struct device *dev, dma_peer_addr_t addr,
+				   size_t size, int direction)
+{
+	struct dma_debug_entry ref = {
+		.type           = dma_debug_peer_resource,
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
+EXPORT_SYMBOL(debug_dma_unmap_peer_resource);
+#endif
+
 void debug_dma_map_sg(struct device *dev, struct scatterlist *sg,
 		      int nents, int mapped_ents, int direction)
 {
-- 
2.5.1

