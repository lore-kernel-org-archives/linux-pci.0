Return-Path: <SRS0=SqGm=OQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02051C07E85
	for <linux-pci@archiver.kernel.org>; Fri,  7 Dec 2018 19:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9DE520868
	for <linux-pci@archiver.kernel.org>; Fri,  7 Dec 2018 19:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oApWgdKc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9DE520868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbeLGTIN (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 7 Dec 2018 14:08:13 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48526 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbeLGTIN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Dec 2018 14:08:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PwQJIeLVy0CrwfGDElRmW57KtintlTa2SeqZtzsURfE=; b=oApWgdKcaWmPlw4Ph8w25tRJfR
        /ZTcLBabdJsHh+H83IxFyYvzgTy6nJ4b54u3RjIogavcE5NoYd2EiZZ9eWv3ur4HOlb2WNAZ6Y6Ng
        WWIzV3HiWrbMZIdcTlatSSgdWlOflY1nSpl1/ey8jwwOEoZUyWMMbIVOAxukzIJA7iEGOSTjG3SKK
        0WQWDqNz1n6CJolYM6nGy6pHDIpCUqM3dI6lUtNZJCgvI9I154MQ1slw8jCqp2oSR7jibN655o5vf
        8sPqo38ZbAmRLD+QczLqnnQ1Dsb8HJiOFQ9di+ls+ahkgrKPjGEvkYUVduIFBTTsN4TI0Un7MfMLb
        T/cBAAAQ==;
Received: from [199.255.44.128] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gVLTo-0006oJ-DO; Fri, 07 Dec 2018 19:08:04 +0000
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
Subject: [PATCH 07/15] dma-mapping: merge dma_unmap_page_attrs and dma_unmap_single_attrs
Date:   Fri,  7 Dec 2018 11:07:12 -0800
Message-Id: <20181207190720.18517-8-hch@lst.de>
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

The two functions are exactly the same, so don't bother implementing
them twice.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/dma-mapping.h | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 8916499d2805..3b431cc58794 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -253,6 +253,12 @@ static inline void dma_unmap_single_attrs(struct device *dev, dma_addr_t addr,
 	debug_dma_unmap_page(dev, addr, size, dir, true);
 }
 
+static inline void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr,
+		size_t size, enum dma_data_direction dir, unsigned long attrs)
+{
+	return dma_unmap_single_attrs(dev, addr, size, dir, attrs);
+}
+
 /*
  * dma_maps_sg_attrs returns 0 on error and > 0 on success.
  * It should never return a value < 0.
@@ -300,19 +306,6 @@ static inline dma_addr_t dma_map_page_attrs(struct device *dev,
 	return addr;
 }
 
-static inline void dma_unmap_page_attrs(struct device *dev,
-					dma_addr_t addr, size_t size,
-					enum dma_data_direction dir,
-					unsigned long attrs)
-{
-	const struct dma_map_ops *ops = get_dma_ops(dev);
-
-	BUG_ON(!valid_dma_direction(dir));
-	if (ops->unmap_page)
-		ops->unmap_page(dev, addr, size, dir, attrs);
-	debug_dma_unmap_page(dev, addr, size, dir, false);
-}
-
 static inline dma_addr_t dma_map_resource(struct device *dev,
 					  phys_addr_t phys_addr,
 					  size_t size,
-- 
2.19.1

