Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:13419 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005AbbIORLm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Sep 2015 13:11:42 -0400
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
Subject: [PATCH 10/22] PCI: Add pci_resource_to_peer()
Date: Tue, 15 Sep 2015 12:10:55 -0500
Message-ID: <1442337067-22964-11-git-send-email-wdavis@nvidia.com>
In-Reply-To: <1442337067-22964-1-git-send-email-wdavis@nvidia.com>
References: <1442337067-22964-1-git-send-email-wdavis@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add helper to convert a struct resource to a peer DMA address.

Signed-off-by: Will Davis <wdavis@nvidia.com>
---
 include/linux/pci.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index db0cb51..2a9deff 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1508,6 +1508,22 @@ static inline void pci_resource_to_user(const struct pci_dev *dev, int bar,
 }
 #endif /* HAVE_ARCH_PCI_RESOURCE_TO_USER */
 
+#ifdef CONFIG_HAS_DMA_P2P
+static inline bool pci_resource_to_peer(struct pci_dev *dev,
+					struct pci_dev *peer,
+					struct resource *res,
+					dma_peer_addr_t *peer_addr) {
+	if (pci_peer_traffic_supported(dev, peer)) {
+		struct pci_bus_region region;
+
+		pcibios_resource_to_bus(dev->bus, &region, res);
+		*peer_addr = region.start;
+		return true;
+	}
+
+	return false;
+}
+#endif /* CONFIG_HAS_DMA_P2P */
 
 /*
  *  The world is not perfect and supplies us with broken PCI devices.
-- 
2.5.1

