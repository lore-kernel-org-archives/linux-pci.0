Return-Path: <SRS0=SqGm=OQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5C1C07E85
	for <linux-pci@archiver.kernel.org>; Fri,  7 Dec 2018 19:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12E3D2083D
	for <linux-pci@archiver.kernel.org>; Fri,  7 Dec 2018 19:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i3URQ+ZA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12E3D2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbeLGTIv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 7 Dec 2018 14:08:51 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48784 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbeLGTIv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Dec 2018 14:08:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=j8kRsJw70M7YKAAZfbVQseC0kaDxQ/DGemeMqiqndBk=; b=i3URQ+ZAqWua8SBrTNvkz/sVuK
        ACjzb8bBtcWEM5z4o7pTvx/q9gRnU59CAR4SchdXqJUtANBD3BiH+vPL7RUGMnTCud2zbgukosHhd
        IIgVs99YgI4OE6qoCbqi+7ZeVaa2i7VDLo0JQALG6HxSFDlzh4IRytp+MYtFZcY0AvJI7VDriCdHA
        D89SDvIilWFfvwB4NoNgiiqRwoopvDtWgrXey4xVYtzkzieZUihGmSviYyt3aZrTjcqqGlit1fCSl
        mHHbb6i2T3PPaNqZRotKTPSI4e9L2fali0Cux/U+TLMtVsAOFSF2KHy7TAMEE+RkToY2HbdJQa0Pu
        ivqgOGEA==;
Received: from [199.255.44.128] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gVLUP-00070U-G4; Fri, 07 Dec 2018 19:08:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     Tariq Toukan <tariqt@mellanox.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Keith Busch <keith.busch@intel.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-pci@vger.kernel.org, linux-ia64@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 14/15] vmd: use the proper dma_* APIs instead of direct methods calls
Date:   Fri,  7 Dec 2018 11:07:19 -0800
Message-Id: <20181207190720.18517-15-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181207190720.18517-1-hch@lst.de>
References: <20181207190720.18517-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

With the bypass support for the direct mapping we might not always have
methods to call, so use the proper APIs instead.  The only downside is
that we will create two dma-debug entries for each mapping if
CONFIG_DMA_DEBUG is enabled.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/pci/controller/vmd.c | 42 +++++++++++++++---------------------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 98ce79eac128..3890812cdf87 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -307,39 +307,32 @@ static struct device *to_vmd_dev(struct device *dev)
 	return &vmd->dev->dev;
 }
 
-static const struct dma_map_ops *vmd_dma_ops(struct device *dev)
-{
-	return get_dma_ops(to_vmd_dev(dev));
-}
-
 static void *vmd_alloc(struct device *dev, size_t size, dma_addr_t *addr,
 		       gfp_t flag, unsigned long attrs)
 {
-	return vmd_dma_ops(dev)->alloc(to_vmd_dev(dev), size, addr, flag,
-				       attrs);
+	return dma_alloc_attrs(to_vmd_dev(dev), size, addr, flag, attrs);
 }
 
 static void vmd_free(struct device *dev, size_t size, void *vaddr,
 		     dma_addr_t addr, unsigned long attrs)
 {
-	return vmd_dma_ops(dev)->free(to_vmd_dev(dev), size, vaddr, addr,
-				      attrs);
+	return dma_free_attrs(to_vmd_dev(dev), size, vaddr, addr, attrs);
 }
 
 static int vmd_mmap(struct device *dev, struct vm_area_struct *vma,
 		    void *cpu_addr, dma_addr_t addr, size_t size,
 		    unsigned long attrs)
 {
-	return vmd_dma_ops(dev)->mmap(to_vmd_dev(dev), vma, cpu_addr, addr,
-				      size, attrs);
+	return dma_mmap_attrs(to_vmd_dev(dev), vma, cpu_addr, addr, size,
+			attrs);
 }
 
 static int vmd_get_sgtable(struct device *dev, struct sg_table *sgt,
 			   void *cpu_addr, dma_addr_t addr, size_t size,
 			   unsigned long attrs)
 {
-	return vmd_dma_ops(dev)->get_sgtable(to_vmd_dev(dev), sgt, cpu_addr,
-					     addr, size, attrs);
+	return dma_get_sgtable_attrs(to_vmd_dev(dev), sgt, cpu_addr, addr, size,
+			attrs);
 }
 
 static dma_addr_t vmd_map_page(struct device *dev, struct page *page,
@@ -347,61 +340,60 @@ static dma_addr_t vmd_map_page(struct device *dev, struct page *page,
 			       enum dma_data_direction dir,
 			       unsigned long attrs)
 {
-	return vmd_dma_ops(dev)->map_page(to_vmd_dev(dev), page, offset, size,
-					  dir, attrs);
+	return dma_map_page_attrs(to_vmd_dev(dev), page, offset, size, dir,
+			attrs);
 }
 
 static void vmd_unmap_page(struct device *dev, dma_addr_t addr, size_t size,
 			   enum dma_data_direction dir, unsigned long attrs)
 {
-	vmd_dma_ops(dev)->unmap_page(to_vmd_dev(dev), addr, size, dir, attrs);
+	dma_unmap_page_attrs(to_vmd_dev(dev), addr, size, dir, attrs);
 }
 
 static int vmd_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 		      enum dma_data_direction dir, unsigned long attrs)
 {
-	return vmd_dma_ops(dev)->map_sg(to_vmd_dev(dev), sg, nents, dir, attrs);
+	return dma_map_sg_attrs(to_vmd_dev(dev), sg, nents, dir, attrs);
 }
 
 static void vmd_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
 			 enum dma_data_direction dir, unsigned long attrs)
 {
-	vmd_dma_ops(dev)->unmap_sg(to_vmd_dev(dev), sg, nents, dir, attrs);
+	dma_unmap_sg_attrs(to_vmd_dev(dev), sg, nents, dir, attrs);
 }
 
 static void vmd_sync_single_for_cpu(struct device *dev, dma_addr_t addr,
 				    size_t size, enum dma_data_direction dir)
 {
-	vmd_dma_ops(dev)->sync_single_for_cpu(to_vmd_dev(dev), addr, size, dir);
+	dma_sync_single_for_cpu(to_vmd_dev(dev), addr, size, dir);
 }
 
 static void vmd_sync_single_for_device(struct device *dev, dma_addr_t addr,
 				       size_t size, enum dma_data_direction dir)
 {
-	vmd_dma_ops(dev)->sync_single_for_device(to_vmd_dev(dev), addr, size,
-						 dir);
+	dma_sync_single_for_device(to_vmd_dev(dev), addr, size, dir);
 }
 
 static void vmd_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
 				int nents, enum dma_data_direction dir)
 {
-	vmd_dma_ops(dev)->sync_sg_for_cpu(to_vmd_dev(dev), sg, nents, dir);
+	dma_sync_sg_for_cpu(to_vmd_dev(dev), sg, nents, dir);
 }
 
 static void vmd_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
 				   int nents, enum dma_data_direction dir)
 {
-	vmd_dma_ops(dev)->sync_sg_for_device(to_vmd_dev(dev), sg, nents, dir);
+	dma_sync_sg_for_device(to_vmd_dev(dev), sg, nents, dir);
 }
 
 static int vmd_dma_supported(struct device *dev, u64 mask)
 {
-	return vmd_dma_ops(dev)->dma_supported(to_vmd_dev(dev), mask);
+	return dma_supported(to_vmd_dev(dev), mask);
 }
 
 static u64 vmd_get_required_mask(struct device *dev)
 {
-	return vmd_dma_ops(dev)->get_required_mask(to_vmd_dev(dev));
+	return dma_get_required_mask(to_vmd_dev(dev));
 }
 
 static void vmd_teardown_dma_ops(struct vmd_dev *vmd)
-- 
2.19.1

