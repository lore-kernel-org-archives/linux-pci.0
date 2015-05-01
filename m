Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:18127 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751109AbbEASpX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 1 May 2015 14:45:23 -0400
From: <wdavis@nvidia.com>
To: joro@8bytes.org
CC: iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
	tripperda@nvidia.com, jhubbard@nvidia.com, jglisse@redhat.com,
	Will Davis <wdavis@nvidia.com>
Subject: [PATCH 3/6] dma-mapping: pci: add pci_(un)map_resource
Date: Fri, 1 May 2015 13:32:15 -0500
Message-ID: <1430505138-2877-4-git-send-email-wdavis@nvidia.com>
In-Reply-To: <1430505138-2877-1-git-send-email-wdavis@nvidia.com>
References: <1430505138-2877-1-git-send-email-wdavis@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Will Davis <wdavis@nvidia.com>

Simply route these through to the new dma_(un)map_resource APIs.

Signed-off-by: Will Davis <wdavis@nvidia.com>
Reviewed-by: Terence Ripperda <tripperda@nvidia.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
---
 include/asm-generic/pci-dma-compat.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/asm-generic/pci-dma-compat.h b/include/asm-generic/pci-dma-compat.h
index c110843..ac4a4ad 100644
--- a/include/asm-generic/pci-dma-compat.h
+++ b/include/asm-generic/pci-dma-compat.h
@@ -61,6 +61,20 @@ pci_unmap_page(struct pci_dev *hwdev, dma_addr_t dma_address,
 	dma_unmap_page(hwdev == NULL ? NULL : &hwdev->dev, dma_address, size, (enum dma_data_direction)direction);
 }
 
+static inline dma_addr_t
+pci_map_resource(struct pci_dev *hwdev, struct resource *resource,
+		 unsigned long offset, size_t size, int direction)
+{
+	return dma_map_resource(hwdev == NULL ? NULL : &hwdev->dev, resource, offset, size, (enum dma_data_direction)direction);
+}
+
+static inline void
+pci_unmap_resource(struct pci_dev *hwdev, dma_addr_t dma_address, size_t size,
+		   int direction)
+{
+	dma_unmap_resource(hwdev == NULL ? NULL : &hwdev->dev, dma_address, size, (enum dma_data_direction)direction);
+}
+
 static inline int
 pci_map_sg(struct pci_dev *hwdev, struct scatterlist *sg,
 	   int nents, int direction)
-- 
2.3.7

