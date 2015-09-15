Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:7826 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005AbbIORLd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Sep 2015 13:11:33 -0400
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
Subject: [PATCH 06/22] DMA-API: Add peer resource mapping documentation
Date: Tue, 15 Sep 2015 12:10:51 -0500
Message-ID: <1442337067-22964-7-git-send-email-wdavis@nvidia.com>
In-Reply-To: <1442337067-22964-1-git-send-email-wdavis@nvidia.com>
References: <1442337067-22964-1-git-send-email-wdavis@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add references to both the general API documentation, as well as the HOWTO,
about the dma_(un)map_peer_resource() and dma_peer_mapping_error() APIs.

Signed-off-by: Will Davis <wdavis@nvidia.com>
---
 Documentation/DMA-API-HOWTO.txt | 69 +++++++++++++++++++++++++++++++++++++++++
 Documentation/DMA-API.txt       | 38 ++++++++++++++++++++---
 2 files changed, 102 insertions(+), 5 deletions(-)

diff --git a/Documentation/DMA-API-HOWTO.txt b/Documentation/DMA-API-HOWTO.txt
index 55b70b9..053a18f 100644
--- a/Documentation/DMA-API-HOWTO.txt
+++ b/Documentation/DMA-API-HOWTO.txt
@@ -143,6 +143,10 @@ What about block I/O and networking buffers?  The block I/O and
 networking subsystems make sure that the buffers they use are valid
 for you to DMA from/to.
 
+In some systems, it may also be possible to DMA to and/or from a peer
+device's MMIO region, as described by a 'struct resource'. This is
+referred to as a peer-to-peer mapping.
+
 			DMA addressing limitations
 
 Does your device have any DMA addressing limitations?  For example, is
@@ -653,6 +657,45 @@ Every dma_map_{single,sg}() call should have its dma_unmap_{single,sg}()
 counterpart, because the DMA address space is a shared resource and
 you could render the machine unusable by consuming all DMA addresses.
 
+Peer-to-peer DMA mappings can be obtained using dma_map_peer_resource() to
+map another device's MMIO region for the given device:
+
+	dma_peer_addr_t dma_handle = dma_map_peer_resource(dev, peer, res,
+							   offset, size,
+							   direction);
+	if (dma_peer_mapping_error(dev, dma_handle))
+	{
+		/*
+		 * reduce current DMA mapping usage,
+		 * delay and try again later or
+		 * reset driver. P2P DMA may not be
+		 * supported between the devices.
+		 */
+		goto map_error_handling;
+	}
+
+	...
+
+	dma_unmap_peer_resource(dev, dma_handle, size, direction);
+
+Here, "res" is the struct resource * of the MMIO region, and "offset" means
+byte offset within the given resource.
+
+You should call dma_peer_mapping_error() as dma_map_peer_resource() could fail
+and return error.
+
+Not all implementations support dma_map_peer_resource(), but those that do
+should also implement dma_peer_mapping_error(). dma_map_peer_resource() may
+fail for various reasons depending on the implementation, but generally
+may fail for the same reasons as those outlined under the dma_map_single()
+discussion. In addition, the success of dma_map_peer_resource() may depend
+on the physical topology between the two devices. For example, in the x86
+implementations, peer-to-peer mappings will fail if the devices are behind
+different host bridges.
+
+You should call dma_unmap_peer_resource() when DMA activity is finished,
+e.g., from the interrupt which told you that the DMA transfer is done.
+
 If you need to use the same streaming DMA region multiple times and touch
 the data in between the DMA transfers, the buffer needs to be synced
 properly in order for the CPU and device to see the most up-to-date and
@@ -785,6 +828,23 @@ failure can be determined by:
 		goto map_error_handling;
 	}
 
+- checking the dma_peer_addr_t returned from dma_map_peer_resource() by using
+  dma_peer_mapping_error():
+
+  	dma_peer_addr_t dma_handle;
+
+	dma_handle = dma_map_peer_resource(dev, peer, res, offset, size,
+					   direction);
+	if (dma_peer_mapping_error(dev, dma_handle)) {
+		/*
+		 * reduce current DMA mapping usage,
+		 * delay and try again later or
+		 * reset driver. P2P DMA may not be
+		 * supported between the devices.
+		 */
+		goto map_error_handling;
+	}
+
 - unmap pages that are already mapped, when mapping error occurs in the middle
   of a multiple page mapping attempt. These example are applicable to
   dma_map_page() as well.
@@ -956,6 +1016,15 @@ to "Closing".
    support multiple types of IOMMUs in a single system, the example of
    x86 or powerpc helps.
 
+4) Peer-to-peer requirements.
+
+   If your platform can support peer-to-peer DMA, enable HAS_DMA_P2P to
+   include the peer-resource mapping interfaces in the DMA API, and
+   provide an implementation of dma_peer_mapping_error(). The latter part
+   is necessary because on some platforms, the dma_addr_t is not as wide
+   as the full bus address, and therefore the existing dma_mapping_error()
+   API may not be sufficient.
+
 			   Closing
 
 This document, and the API itself, would not be in its current
diff --git a/Documentation/DMA-API.txt b/Documentation/DMA-API.txt
index 7eba542..c6f11a1 100644
--- a/Documentation/DMA-API.txt
+++ b/Documentation/DMA-API.txt
@@ -283,14 +283,42 @@ and <size> parameters are provided to do partial page mapping, it is
 recommended that you never use these unless you really know what the
 cache width is.
 
+dma_peer_addr_t
+dma_map_peer_resource(struct device *dev, struct device *peer,
+		      struct resource *res, unsigned long offset,
+		      size_t size, enum dma_data_direction_direction)
+
+API for mapping resources. This API allows a driver to map a peer
+device's resource for DMA. All the notes and warnings for the other
+APIs apply here. Also, the success of this API does not validate or
+guarantee that peer-to-peer transactions between the device and its
+peer will be functional. They only grant access so that if such
+transactions are possible, an IOMMU will not prevent them from
+succeeding. However, a failure of this API may indicate that peer-to-peer
+transactions are not expected to succeed across the underlying topology
+between the devices.
+
+void
+dma_unmap_peer_resource(struct device *dev, dma_peer_addr_t dma_address,
+			size_t size, enum dma_data_direction direction)
+
+Unmaps the resource previously mapped. All the parameters passed in
+must be identical to those passed in to (and returned by) the mapping
+API.
+
 int
 dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
 
-In some circumstances dma_map_single() and dma_map_page() will fail to create
-a mapping. A driver can check for these errors by testing the returned
-DMA address with dma_mapping_error(). A non-zero return value means the mapping
-could not be created and the driver should take appropriate action (e.g.
-reduce current DMA mapping usage or delay and try again later).
+int
+dma_peer_mapping_error(struct device *dev, dma_peer_addr_t dma_addr)
+
+In some circumstances dma_map_single(), dma_map_page() and
+dma_map_peer_resource() will fail to create a mapping. A driver can check for
+these errors by testing the returned DMA address with dma_mapping_error()
+(or dma_peer_mapping_error() for dma_map_peer_resource()). A non-zero return
+value means the mapping could not be created and the driver should take
+appropriate action (e.g. reduce current DMA mapping usage or delay and try
+again later).
 
 	int
 	dma_map_sg(struct device *dev, struct scatterlist *sg,
-- 
2.5.1

