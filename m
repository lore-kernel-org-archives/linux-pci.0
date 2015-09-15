Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:12060 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785AbbIORMF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Sep 2015 13:12:05 -0400
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
Subject: [PATCH 19/22] x86: Calgary: Add map_peer_resource stub
Date: Tue, 15 Sep 2015 12:11:04 -0500
Message-ID: <1442337067-22964-20-git-send-email-wdavis@nvidia.com>
In-Reply-To: <1442337067-22964-1-git-send-email-wdavis@nvidia.com>
References: <1442337067-22964-1-git-send-email-wdavis@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Return DMA_ERROR_CODE to indicate no support.

Signed-off-by: Will Davis <wdavis@nvidia.com>
---
 arch/x86/kernel/pci-calgary_64.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/kernel/pci-calgary_64.c b/arch/x86/kernel/pci-calgary_64.c
index 0497f71..ec3d998 100644
--- a/arch/x86/kernel/pci-calgary_64.c
+++ b/arch/x86/kernel/pci-calgary_64.c
@@ -431,6 +431,19 @@ static void calgary_unmap_page(struct device *dev, dma_addr_t dma_addr,
 	iommu_free(tbl, dma_addr, npages);
 }
 
+#ifdef CONFIG_HAS_DMA_P2P
+static dma_peer_addr_t calgary_map_peer_resource(struct device *dev,
+						 struct device *peer,
+						 struct resource *res,
+						 unsigned long offset,
+						 size_t size,
+						 enum dma_data_direction dir,
+						 struct dma_attrs *attrs)
+{
+	return DMA_ERROR_CODE;
+}
+#endif
+
 static void* calgary_alloc_coherent(struct device *dev, size_t size,
 	dma_addr_t *dma_handle, gfp_t flag, struct dma_attrs *attrs)
 {
@@ -485,6 +498,9 @@ static struct dma_map_ops calgary_dma_ops = {
 	.unmap_sg = calgary_unmap_sg,
 	.map_page = calgary_map_page,
 	.unmap_page = calgary_unmap_page,
+#ifdef CONFIG_HAS_DMA_P2P
+	.map_peer_resource = calgary_map_peer_resource,
+#endif
 };
 
 static inline void __iomem * busno_to_bbar(unsigned char num)
-- 
2.5.1

