Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:10281 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756151AbbE2R2M (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 29 May 2015 13:28:12 -0400
From: <wdavis@nvidia.com>
To: Joerg Roedel <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>
CC: Terence Ripperda <tripperda@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Jerome Glisse <jglisse@redhat.com>,
	Mark Hounschell <markh@compro.net>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"David S. Miller" <davem@davemloft.net>,
	Yijing Wang <wangyijing@huawei.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Dave Jiang <dave.jiang@intel.com>,
	<iommu@lists.linux-foundation.org>, <linux-pci@vger.kernel.org>,
	Will Davis <wdavis@nvidia.com>
Subject: [PATCH v3 6/7] iommu/vt-d: implement (un)map_resource
Date: Fri, 29 May 2015 12:14:45 -0500
Message-ID: <1432919686-32306-7-git-send-email-wdavis@nvidia.com>
In-Reply-To: <1432919686-32306-1-git-send-email-wdavis@nvidia.com>
References: <1432919686-32306-1-git-send-email-wdavis@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Will Davis <wdavis@nvidia.com>

Implement 'map_resource' for the Intel IOMMU driver. Simply translate the
resource to a physical address and route it to the same handlers used by
the 'map_page' API.

This allows a device to map another's resource, to enable peer-to-peer
transactions.

Signed-off-by: Will Davis <wdavis@nvidia.com>
Reviewed-by: Terence Ripperda <tripperda@nvidia.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
---
 drivers/iommu/intel-iommu.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 68d43be..0f49eff 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3095,6 +3095,15 @@ static dma_addr_t intel_map_page(struct device *dev, struct page *page,
 				  dir, *dev->dma_mask);
 }
 
+static dma_addr_t intel_map_resource(struct device *dev, struct resource *res,
+				     unsigned long offset, size_t size,
+				     enum dma_data_direction dir,
+				     struct dma_attrs *attrs)
+{
+	return __intel_map_single(dev, res->start + offset, size,
+				  dir, *dev->dma_mask);
+}
+
 static void flush_unmaps(void)
 {
 	int i, j;
@@ -3226,6 +3235,13 @@ static void intel_unmap_page(struct device *dev, dma_addr_t dev_addr,
 	intel_unmap(dev, dev_addr);
 }
 
+static void intel_unmap_resource(struct device *dev, dma_addr_t dev_addr,
+				 size_t size, enum dma_data_direction dir,
+				 struct dma_attrs *attrs)
+{
+	intel_unmap(dev, dev_addr);
+}
+
 static void *intel_alloc_coherent(struct device *dev, size_t size,
 				  dma_addr_t *dma_handle, gfp_t flags,
 				  struct dma_attrs *attrs)
@@ -3382,6 +3398,8 @@ struct dma_map_ops intel_dma_ops = {
 	.unmap_sg = intel_unmap_sg,
 	.map_page = intel_map_page,
 	.unmap_page = intel_unmap_page,
+	.map_resource = intel_map_resource,
+	.unmap_resource = intel_unmap_resource,
 	.mapping_error = intel_mapping_error,
 };
 
-- 
2.4.0

