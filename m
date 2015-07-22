Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:8765 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753496AbbGVVyH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 22 Jul 2015 17:54:07 -0400
From: Will Davis <wdavis@nvidia.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Joerg Roedel <joro@8bytes.org>
CC: <iommu@lists.linux-foundation.org>, <linux-pci@vger.kernel.org>,
	"Konrad Wilk" <konrad.wilk@oracle.com>,
	Mark Hounschell <markh@compro.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jonathan Corbet <corbet@lwn.net>,
	"Terence Ripperda" <tripperda@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	"Jerome Glisse" <jglisse@redhat.com>
Subject: [PATCH v4 09/12] iommu/vt-d: implement (un)map_peer_resource
Date: Wed, 22 Jul 2015 16:39:54 -0500
Message-ID: <1437601197-6481-10-git-send-email-wdavis@nvidia.com>
In-Reply-To: <1437601197-6481-1-git-send-email-wdavis@nvidia.com>
References: <1437601197-6481-1-git-send-email-wdavis@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Implement 'map_peer_resource' for the Intel IOMMU driver. Simply translate
the resource to a physical address and route it to the same handlers used
by the 'map_page' API.

This allows a device to map another's resource, to enable peer-to-peer
transactions.

These functions are guarded behind CONFIG_HAS_DMA_P2P, since the
dma_map_ops members are as well.

Signed-off-by: Will Davis <wdavis@nvidia.com>
Reviewed-by: Terence Ripperda <tripperda@nvidia.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
---
 drivers/iommu/intel-iommu.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index a98a7b2..66b371c 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3544,6 +3544,40 @@ static void intel_unmap_page(struct device *dev, dma_addr_t dev_addr,
 	intel_unmap(dev, dev_addr);
 }
 
+#ifdef CONFIG_HAS_DMA_P2P
+static dma_peer_addr_t intel_map_peer_resource(struct device *dev,
+					       struct device *peer,
+					       struct resource *res,
+					       unsigned long offset,
+					       size_t size,
+					       enum dma_data_direction dir,
+					       struct dma_attrs *attrs)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pci_dev *ppeer = to_pci_dev(peer);
+	struct pci_host_bridge *hbdev = pci_find_host_bridge(pdev->bus);
+	struct pci_host_bridge *hbpeer = pci_find_host_bridge(ppeer->bus);
+
+	/*
+	 * Disallow the peer-to-peer mapping if the devices do not share a host
+	 * bridge.
+	 */
+	if (hbdev != hbpeer)
+		return 0;
+
+	return __intel_map_single(dev, res->start + offset, size,
+				  dir, *dev->dma_mask);
+}
+
+static void intel_unmap_peer_resource(struct device *dev,
+				      dma_peer_addr_t dev_addr,
+				      size_t size, enum dma_data_direction dir,
+				      struct dma_attrs *attrs)
+{
+	intel_unmap(dev, dev_addr);
+}
+#endif
+
 static void *intel_alloc_coherent(struct device *dev, size_t size,
 				  dma_addr_t *dma_handle, gfp_t flags,
 				  struct dma_attrs *attrs)
@@ -3700,6 +3734,10 @@ struct dma_map_ops intel_dma_ops = {
 	.unmap_sg = intel_unmap_sg,
 	.map_page = intel_map_page,
 	.unmap_page = intel_unmap_page,
+#ifdef CONFIG_HAS_DMA_P2P
+	.map_peer_resource = intel_map_peer_resource,
+	.unmap_peer_resource = intel_unmap_peer_resource,
+#endif
 	.mapping_error = intel_mapping_error,
 };
 
-- 
2.4.6

