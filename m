Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:5889 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754100AbbHRTTU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Aug 2015 15:19:20 -0400
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
Subject: [PATCH v5 12/13] x86: add pci-nommu implementation of map_peer_resource
Date: Tue, 18 Aug 2015 14:04:08 -0500
Message-ID: <1439924649-29698-13-git-send-email-wdavis@nvidia.com>
In-Reply-To: <1439924649-29698-1-git-send-email-wdavis@nvidia.com>
References: <1439924649-29698-1-git-send-email-wdavis@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add Intel nommu implementation of 'map_peer_resource', which simply checks
whether peer traffic should be allowed and converts the resource to a bus
address.

Add behind CONFIG_HAS_DMA_P2P guards, since the dma_map_ops members are
behind them as well.

Signed-off-by: Will Davis <wdavis@nvidia.com>
---
 arch/x86/kernel/pci-nommu.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/x86/kernel/pci-nommu.c b/arch/x86/kernel/pci-nommu.c
index da15918..4b45cc6 100644
--- a/arch/x86/kernel/pci-nommu.c
+++ b/arch/x86/kernel/pci-nommu.c
@@ -38,6 +38,39 @@ static dma_addr_t nommu_map_page(struct device *dev, struct page *page,
 	return bus;
 }
 
+#ifdef CONFIG_HAS_DMA_P2P
+static dma_peer_addr_t nommu_map_peer_resource(struct device *dev,
+					       struct device *peer,
+					       struct resource *res,
+					       unsigned long offset,
+					       size_t size,
+					       enum dma_data_direction dir,
+					       struct dma_attrs *attrs)
+{
+	struct pci_dev *pdev;
+	struct pci_dev *ppeer;
+	struct pci_bus_region region;
+	dma_peer_addr_t dma_address;
+
+	if (!dev_is_pci(dev) || !dev_is_pci(peer))
+		return DMA_ERROR_CODE;
+
+	pdev = to_pci_dev(dev);
+	ppeer = to_pci_dev(peer);
+
+	if (!pci_peer_traffic_supported(pdev, ppeer))
+		return DMA_ERROR_CODE;
+
+	pcibios_resource_to_bus(pdev->bus, &region, res);
+	dma_address = region.start + offset;
+	WARN_ON(size == 0);
+	if (!check_addr("map_peer_resource", dev, dma_address, size))
+		return DMA_ERROR_CODE;
+	flush_write_buffers();
+	return dma_address;
+}
+#endif
+
 /* Map a set of buffers described by scatterlist in streaming
  * mode for DMA.  This is the scatter-gather version of the
  * above pci_map_single interface.  Here the scatter gather list
@@ -93,6 +126,9 @@ struct dma_map_ops nommu_dma_ops = {
 	.free			= dma_generic_free_coherent,
 	.map_sg			= nommu_map_sg,
 	.map_page		= nommu_map_page,
+#ifdef CONFIG_HAS_DMA_P2P
+	.map_peer_resource	= nommu_map_peer_resource,
+#endif
 	.sync_single_for_device = nommu_sync_single_for_device,
 	.sync_sg_for_device	= nommu_sync_sg_for_device,
 	.is_phys		= 1,
-- 
2.5.0

