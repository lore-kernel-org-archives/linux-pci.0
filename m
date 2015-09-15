Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:13455 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751699AbbIORLz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Sep 2015 13:11:55 -0400
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
Subject: [PATCH 15/22] pci-swiotlb-xen: add xen_swiotlb_map_peer_resource to xen_swiotlb_dma_ops
Date: Tue, 15 Sep 2015 12:11:00 -0500
Message-ID: <1442337067-22964-16-git-send-email-wdavis@nvidia.com>
In-Reply-To: <1442337067-22964-1-git-send-email-wdavis@nvidia.com>
References: <1442337067-22964-1-git-send-email-wdavis@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Only available if CONFIG_HAS_DMA_P2P is set.

Signed-off-by: Will Davis <wdavis@nvidia.com>
---
 arch/x86/xen/pci-swiotlb-xen.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/xen/pci-swiotlb-xen.c b/arch/x86/xen/pci-swiotlb-xen.c
index 0e98e5d..84a9285 100644
--- a/arch/x86/xen/pci-swiotlb-xen.c
+++ b/arch/x86/xen/pci-swiotlb-xen.c
@@ -30,6 +30,9 @@ static struct dma_map_ops xen_swiotlb_dma_ops = {
 	.unmap_sg = xen_swiotlb_unmap_sg_attrs,
 	.map_page = xen_swiotlb_map_page,
 	.unmap_page = xen_swiotlb_unmap_page,
+#ifdef CONFIG_HAS_DMA_P2P
+	.map_peer_resource = xen_swiotlb_map_peer_resource,
+#endif
 	.dma_supported = xen_swiotlb_dma_supported,
 };
 
-- 
2.5.1

