Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:12978 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752868AbbHRTTT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Aug 2015 15:19:19 -0400
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
Subject: [PATCH v5 11/13] iommu/vt-d: implement (un)map_peer_resource
Date: Tue, 18 Aug 2015 14:04:07 -0500
Message-ID: <1439924649-29698-12-git-send-email-wdavis@nvidia.com>
In-Reply-To: <1439924649-29698-1-git-send-email-wdavis@nvidia.com>
References: <1439924649-29698-1-git-send-email-wdavis@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Implement 'map_peer_resource' for the Intel IOMMU driver. Simply translate
the resource to a physical address and route it to the same handlers used
by the 'map_page' API.

This allows a device to map another's resource, to enable peer-to-peer
transactions.

Add behind CONFIG_HAS_DMA_P2P guards, since the dma_map_ops members are
behind them as well.

Signed-off-by: Will Davis <wdavis@nvidia.com>
Reviewed-by: Terence Ripperda <tripperda@nvidia.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
---
 drivers/iommu/intel-iommu.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index a98a7b2..0d3746f 100644
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
+	struct pci_dev *pdev;
+	struct pci_dev *ppeer;
+
+	if (!dev_is_pci(dev) || !dev_is_pci(peer))
+		return 0;
+
+	pdev = to_pci_dev(dev);
+	ppeer = to_pci_dev(peer);
+
+	if (!pci_peer_traffic_supported(pdev, ppeer))
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
2.5.0

