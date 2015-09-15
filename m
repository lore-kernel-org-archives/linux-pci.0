Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:7973 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751816AbbIORMK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Sep 2015 13:12:10 -0400
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
Subject: [PATCH 21/22] x86: add dma_peer_mapping_error()
Date: Tue, 15 Sep 2015 12:11:06 -0500
Message-ID: <1442337067-22964-22-git-send-email-wdavis@nvidia.com>
In-Reply-To: <1442337067-22964-1-git-send-email-wdavis@nvidia.com>
References: <1442337067-22964-1-git-send-email-wdavis@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Identical implementation to dma_mapping_error(), but accepts values
returned from the new dma_map_peer_resource() API.

Signed-off-by: Will Davis <wdavis@nvidia.com>
---
 arch/x86/include/asm/dma-mapping.h | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/dma-mapping.h b/arch/x86/include/asm/dma-mapping.h
index 1f5b728..64472d8 100644
--- a/arch/x86/include/asm/dma-mapping.h
+++ b/arch/x86/include/asm/dma-mapping.h
@@ -44,16 +44,30 @@ static inline struct dma_map_ops *get_dma_ops(struct device *dev)
 #include <asm-generic/dma-mapping-common.h>
 
 /* Make sure we keep the same behaviour */
-static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
+static inline int dma_mapping_error_common(struct device *dev, u64 dma_addr)
 {
 	struct dma_map_ops *ops = get_dma_ops(dev);
-	debug_dma_mapping_error(dev, dma_addr);
 	if (ops->mapping_error)
 		return ops->mapping_error(dev, dma_addr);
 
 	return (dma_addr == DMA_ERROR_CODE);
 }
 
+static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
+{
+	debug_dma_mapping_error(dev, dma_addr);
+	return dma_mapping_error_common(dev, (u64)dma_addr);
+}
+
+#ifdef CONFIG_HAS_DMA_P2P
+static inline int dma_peer_mapping_error(struct device *dev,
+					 dma_peer_addr_t dma_addr)
+{
+	debug_dma_peer_mapping_error(dev, dma_addr);
+	return dma_mapping_error_common(dev, (u64)dma_addr);
+}
+#endif
+
 #define dma_alloc_noncoherent(d, s, h, f) dma_alloc_coherent(d, s, h, f)
 #define dma_free_noncoherent(d, s, v, h) dma_free_coherent(d, s, v, h)
 
-- 
2.5.1

