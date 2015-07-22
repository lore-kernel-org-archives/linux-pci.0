Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:2971 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751820AbbGVVyE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 22 Jul 2015 17:54:04 -0400
From: Will Davis <wdavis@nvidia.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Joerg Roedel <joro@8bytes.org>
CC: <iommu@lists.linux-foundation.org>, <linux-pci@vger.kernel.org>,
	Konrad Wilk <konrad.wilk@oracle.com>,
	Mark Hounschell <markh@compro.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Terence Ripperda <tripperda@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Jerome Glisse <jglisse@redhat.com>
Subject: [PATCH v4 05/12] dma-mapping: pci: add pci_(un)map_peer_resource
Date: Wed, 22 Jul 2015 16:39:50 -0500
Message-ID: <1437601197-6481-6-git-send-email-wdavis@nvidia.com>
In-Reply-To: <1437601197-6481-1-git-send-email-wdavis@nvidia.com>
References: <1437601197-6481-1-git-send-email-wdavis@nvidia.com>
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
2.4.6

