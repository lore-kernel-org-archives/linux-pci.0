Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:5859 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753388AbbHRTTN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Aug 2015 15:19:13 -0400
From: Will Davis <wdavis@nvidia.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Alex Williamson <alex.williamson@redhat.com>,
	Joerg Roedel <joro@8bytes.org>,
	<iommu@lists.linux-foundation.org>, <linux-pci@vger.kernel.org>,
	Konrad Wilk <konrad.wilk@oracle.com>,
	"Mark Hounschell" <markh@compro.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Terence Ripperda <tripperda@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Jerome Glisse <jglisse@redhat.com>,
	"Will Davis" <wdavis@nvidia.com>
Subject: [PATCH v5 05/13] dma-mapping: pci: add pci_(un)map_peer_resource
Date: Tue, 18 Aug 2015 14:04:01 -0500
Message-ID: <1439924649-29698-6-git-send-email-wdavis@nvidia.com>
In-Reply-To: <1439924649-29698-1-git-send-email-wdavis@nvidia.com>
References: <1439924649-29698-1-git-send-email-wdavis@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Simply route these through to the new dma_(un)map_peer_resource APIs.

Also route pci_peer_mapping_error through to the new dma_peer_mapping_error
API.

Guard these new functions behind CONFIG_HAS_DMA_P2P.

Signed-off-by: Will Davis <wdavis@nvidia.com>
Reviewed-by: Terence Ripperda <tripperda@nvidia.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
---
 include/asm-generic/pci-dma-compat.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/asm-generic/pci-dma-compat.h b/include/asm-generic/pci-dma-compat.h
index c110843..7baf09e 100644
--- a/include/asm-generic/pci-dma-compat.h
+++ b/include/asm-generic/pci-dma-compat.h
@@ -61,6 +61,29 @@ pci_unmap_page(struct pci_dev *hwdev, dma_addr_t dma_address,
 	dma_unmap_page(hwdev == NULL ? NULL : &hwdev->dev, dma_address, size, (enum dma_data_direction)direction);
 }
 
+#ifdef CONFIG_HAS_DMA_P2P
+static inline dma_peer_addr_t
+pci_map_peer_resource(struct pci_dev *hwdev, struct pci_dev *peer,
+		      int res, unsigned long offset, size_t size,
+		      int direction)
+{
+	return dma_map_peer_resource(hwdev == NULL ? NULL : &hwdev->dev, peer == NULL ? NULL : &peer->dev, peer == NULL ? NULL : &peer->resource[res], offset, size, (enum dma_data_direction)direction);
+}
+
+static inline int
+pci_dma_peer_mapping_error(struct pci_dev *pdev, dma_peer_addr_t dma_addr)
+{
+	return dma_peer_mapping_error(&pdev->dev, dma_addr);
+}
+
+static inline void
+pci_unmap_peer_resource(struct pci_dev *hwdev, dma_peer_addr_t dma_address,
+			size_t size, int direction)
+{
+	dma_unmap_peer_resource(hwdev == NULL ? NULL : &hwdev->dev, dma_address, size, (enum dma_data_direction)direction);
+}
+#endif
+
 static inline int
 pci_map_sg(struct pci_dev *hwdev, struct scatterlist *sg,
 	   int nents, int direction)
-- 
2.5.0

