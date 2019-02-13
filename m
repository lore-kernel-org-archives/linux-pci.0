Return-Path: <SRS0=kgfr=QU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6378FC4151A
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 17:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AB54222B2
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 17:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404684AbfBMRzO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:55:14 -0500
Received: from ale.deltatee.com ([207.54.116.67]:54764 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727511AbfBMRzM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Feb 2019 12:55:12 -0500
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1gtykN-0001z7-5Q; Wed, 13 Feb 2019 10:55:10 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1gtykK-0001y0-VP; Wed, 13 Feb 2019 10:54:57 -0700
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kselftest@vger.kernel.org, Jon Mason <jdmason@kudzu.us>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Allen Hubbe <allenbh@gmail.com>, Dave Jiang <dave.jiang@intel.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Eric Pilmore <epilmore@gigaio.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        David Woodhouse <dwmw2@infradead.org>
Date:   Wed, 13 Feb 2019 10:54:43 -0700
Message-Id: <20190213175454.7506-2-logang@deltatee.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20190213175454.7506-1-logang@deltatee.com>
References: <20190213175454.7506-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-ntb@googlegroups.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org, jdmason@kudzu.us, bhelgaas@google.com, joro@8bytes.org, dave.jiang@intel.com, allenbh@gmail.com, fancer.lancer@gmail.com, epilmore@gigaio.com, logang@deltatee.com, dwmw2@infradead.org
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v2 01/12] iommu/vt-d: Implement dma_[un]map_resource()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently the Intel IOMMU uses the default dma_[un]map_resource()
implementations does nothing and simply returns the physical address
unmodified.

However, this doesn't create the IOVA entries necessary for addresses
mapped this way to work when the IOMMU is enabled. Thus, when the
IOMMU is enabled, drivers relying on dma_map_resource() will trigger
DMAR errors. We see this when running ntb_transport with the IOMMU
enabled, DMA, and switchtec hardware.

The implementation for intel_map_resource() is nearly identical to
intel_map_page(), we just have to re-create __intel_map_single().
dma_unmap_resource() uses intel_unmap_page() directly as the
functions are identical.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Joerg Roedel <joro@8bytes.org>
---
 drivers/iommu/intel-iommu.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 78188bf7e90d..ad737e16575b 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3649,11 +3649,9 @@ static int iommu_no_mapping(struct device *dev)
 	return 0;
 }
 
-static dma_addr_t __intel_map_page(struct device *dev, struct page *page,
-				   unsigned long offset, size_t size, int dir,
-				   u64 dma_mask)
+static dma_addr_t __intel_map_single(struct device *dev, phys_addr_t paddr,
+				     size_t size, int dir, u64 dma_mask)
 {
-	phys_addr_t paddr = page_to_phys(page) + offset;
 	struct dmar_domain *domain;
 	phys_addr_t start_paddr;
 	unsigned long iova_pfn;
@@ -3715,7 +3713,15 @@ static dma_addr_t intel_map_page(struct device *dev, struct page *page,
 				 enum dma_data_direction dir,
 				 unsigned long attrs)
 {
-	return __intel_map_page(dev, page, offset, size, dir, *dev->dma_mask);
+	return __intel_map_single(dev, page_to_phys(page) + offset, size,
+				  dir, *dev->dma_mask);
+}
+
+static dma_addr_t intel_map_resource(struct device *dev, phys_addr_t phys_addr,
+				     size_t size, enum dma_data_direction dir,
+				     unsigned long attrs)
+{
+	return __intel_map_single(dev, phys_addr, size, dir, *dev->dma_mask);
 }
 
 static void intel_unmap(struct device *dev, dma_addr_t dev_addr, size_t size)
@@ -3806,8 +3812,9 @@ static void *intel_alloc_coherent(struct device *dev, size_t size,
 		return NULL;
 	memset(page_address(page), 0, size);
 
-	*dma_handle = __intel_map_page(dev, page, 0, size, DMA_BIDIRECTIONAL,
-				       dev->coherent_dma_mask);
+	*dma_handle = __intel_map_single(dev, page_to_phys(page), size,
+					 DMA_BIDIRECTIONAL,
+					 dev->coherent_dma_mask);
 	if (*dma_handle != DMA_MAPPING_ERROR)
 		return page_address(page);
 	if (!dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT))
@@ -3924,6 +3931,8 @@ static const struct dma_map_ops intel_dma_ops = {
 	.unmap_sg = intel_unmap_sg,
 	.map_page = intel_map_page,
 	.unmap_page = intel_unmap_page,
+	.map_resource = intel_map_resource,
+	.unmap_resource = intel_unmap_page,
 	.dma_supported = dma_direct_supported,
 };
 
-- 
2.19.0

