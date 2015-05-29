Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:10252 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756151AbbE2R2K (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 29 May 2015 13:28:10 -0400
From: <wdavis@nvidia.com>
To: Joerg Roedel <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>
CC: Terence Ripperda <tripperda@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Jerome Glisse <jglisse@redhat.com>,
	Mark Hounschell <markh@compro.net>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"David S. Miller" <davem@davemloft.net>,
	Yijing Wang <wangyijing@huawei.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	"Dave Jiang" <dave.jiang@intel.com>,
	<iommu@lists.linux-foundation.org>, <linux-pci@vger.kernel.org>,
	Will Davis <wdavis@nvidia.com>
Subject: [PATCH v3 4/7] DMA-API: Add dma_(un)map_resource() documentation
Date: Fri, 29 May 2015 12:14:43 -0500
Message-ID: <1432919686-32306-5-git-send-email-wdavis@nvidia.com>
In-Reply-To: <1432919686-32306-1-git-send-email-wdavis@nvidia.com>
References: <1432919686-32306-1-git-send-email-wdavis@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Will Davis <wdavis@nvidia.com>

Add references to both the general API documentation as well as the HOWTO.

Signed-off-by: Will Davis <wdavis@nvidia.com>
---
 Documentation/DMA-API-HOWTO.txt | 36 ++++++++++++++++++++++++++++++++++--
 Documentation/DMA-API.txt       | 31 ++++++++++++++++++++++++++-----
 2 files changed, 60 insertions(+), 7 deletions(-)

diff --git a/Documentation/DMA-API-HOWTO.txt b/Documentation/DMA-API-HOWTO.txt
index 0f7afb2..837af63 100644
--- a/Documentation/DMA-API-HOWTO.txt
+++ b/Documentation/DMA-API-HOWTO.txt
@@ -138,6 +138,10 @@ What about block I/O and networking buffers?  The block I/O and
 networking subsystems make sure that the buffers they use are valid
 for you to DMA from/to.
 
+In some systems, it may also be possible to DMA to and/or from a peer
+device's MMIO region, as described by a 'struct resource'. This is
+referred to as a peer-to-peer mapping.
+
 			DMA addressing limitations
 
 Does your device have any DMA addressing limitations?  For example, is
@@ -648,6 +652,34 @@ Every dma_map_{single,sg}() call should have its dma_unmap_{single,sg}()
 counterpart, because the bus address space is a shared resource and
 you could render the machine unusable by consuming all bus addresses.
 
+Peer-to-peer DMA mappings can be obtained using dma_map_resource() to map
+another device's MMIO region for the given device:
+
+	struct resource *peer_mmio_res = &other_dev->resource[0];
+	dma_addr_t dma_handle = dma_map_resource(dev, peer_mmio_res,
+						 offset, size, direction);
+	if (dma_mapping_error(dev, dma_handle))
+	{
+		/*
+		 * reduce current DMA mapping usage,
+		 * delay and try again later or
+		 * reset driver.
+		 */
+		goto map_error_handling;
+	}
+
+	...
+
+	dma_unmap_resource(dev, dma_handle, size, direction);
+
+Here, "offset" means byte offset within the given resource.
+
+You should call dma_mapping_error() as dma_map_resource() could fail and
+return error as outlined under the dma_map_single() discussion.
+
+You should call dma_unmap_resource() when DMA activity is finished, e.g.,
+from the interrupt which told you that the DMA transfer is done.
+
 If you need to use the same streaming DMA region multiple times and touch
 the data in between the DMA transfers, the buffer needs to be synced
 properly in order for the CPU and device to see the most up-to-date and
@@ -765,8 +797,8 @@ failure can be determined by:
 
 - checking if dma_alloc_coherent() returns NULL or dma_map_sg returns 0
 
-- checking the dma_addr_t returned from dma_map_single() and dma_map_page()
-  by using dma_mapping_error():
+- checking the dma_addr_t returned from dma_map_single(), dma_map_resource(),
+  and dma_map_page() by using dma_mapping_error():
 
 	dma_addr_t dma_handle;
 
diff --git a/Documentation/DMA-API.txt b/Documentation/DMA-API.txt
index 5208840..8158f4c 100644
--- a/Documentation/DMA-API.txt
+++ b/Documentation/DMA-API.txt
@@ -283,14 +283,35 @@ and <size> parameters are provided to do partial page mapping, it is
 recommended that you never use these unless you really know what the
 cache width is.
 
+dma_addr_t
+dma_map_resource(struct device *dev, struct resource *res,
+		 unsigned long offset, size_t size,
+		 enum dma_data_direction_direction)
+
+API for mapping resources. This API allows a driver to map a peer
+device's resource for DMA. All the notes and warnings for the other
+APIs apply here. Also, the success of this API does not validate or
+guarantee that peer-to-peer transactions between the device and its
+peer will be functional. They only grant access so that if such
+transactions are possible, an IOMMU will not prevent them from
+succeeding.
+
+void
+dma_unmap_resource(struct device *dev, dma_addr_t dma_address, size_t size,
+		   enum dma_data_direction direction)
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
+In some circumstances dma_map_single(), dma_map_page() and dma_map_resource()
+will fail to create a mapping. A driver can check for these errors by testing
+the returned DMA address with dma_mapping_error(). A non-zero return value
+means the mapping could not be created and the driver should take appropriate
+action (e.g. reduce current DMA mapping usage or delay and try again later).
 
 	int
 	dma_map_sg(struct device *dev, struct scatterlist *sg,
-- 
2.4.0

