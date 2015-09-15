Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:7883 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558AbbIORLr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Sep 2015 13:11:47 -0400
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
Subject: [PATCH 12/22] x86, swiotlb: Add swiotlb_map_peer_resource() to swiotlb_dma_ops
Date: Tue, 15 Sep 2015 12:10:57 -0500
Message-ID: <1442337067-22964-13-git-send-email-wdavis@nvidia.com>
In-Reply-To: <1442337067-22964-1-git-send-email-wdavis@nvidia.com>
References: <1442337067-22964-1-git-send-email-wdavis@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Will Davis <wdavis@nvidia.com>
---
 arch/x86/kernel/pci-swiotlb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/pci-swiotlb.c b/arch/x86/kernel/pci-swiotlb.c
index adf0392..844b89b 100644
--- a/arch/x86/kernel/pci-swiotlb.c
+++ b/arch/x86/kernel/pci-swiotlb.c
@@ -57,6 +57,9 @@ static struct dma_map_ops swiotlb_dma_ops = {
 	.unmap_sg = swiotlb_unmap_sg_attrs,
 	.map_page = swiotlb_map_page,
 	.unmap_page = swiotlb_unmap_page,
+#ifdef CONFIG_HAS_DMA_P2P
+	.map_peer_resource = swiotlb_map_peer_resource,
+#endif
 	.dma_supported = NULL,
 };
 
-- 
2.5.1

