Return-Path: <SRS0=SqGm=OQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E49C64EB1
	for <linux-pci@archiver.kernel.org>; Fri,  7 Dec 2018 19:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86F1420868
	for <linux-pci@archiver.kernel.org>; Fri,  7 Dec 2018 19:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Kp7OnWOc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86F1420868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbeLGTHx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 7 Dec 2018 14:07:53 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48386 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbeLGTHx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Dec 2018 14:07:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KDUsWhqtiK68OQ6enzSKjeJHX/RuYZSLZlpmVulYSRQ=; b=Kp7OnWOcPAfso13DkIHpnvUoeb
        yBZ0GnhBTC1QpVIupludR0Da2qdzCXvvZpb546JiNQqkbCl+gY7jkiv7aYWsdmLKFYHH6JbX1xFi9
        lcChq0dEV6Aw/F8OXtK519/BcQYw5ncoPQnOJqVcKJ4zOY9EnmQiKvpfeTmTfAoUsMJWOHWxfzGQU
        KSREG1v6Wr5UQzYRwogODSDjDjD2/WcSzP0IwWpPKKLWUpAL4Hij6cgGq7ALXRQQMwYZZ4zoNqWoe
        CmnmSo2ceqC9MU8bIwd8rXjt6fKaiZG9gf2pZcK6dYy6sOCZrssj+6ZQ/uPazcWC+UCBdVUQJNc5R
        E+WH3m4g==;
Received: from [199.255.44.128] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gVLTT-0006ga-91; Fri, 07 Dec 2018 19:07:43 +0000
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
Subject: [PATCH 03/15] dma-direct: improve addressability error reporting
Date:   Fri,  7 Dec 2018 11:07:08 -0800
Message-Id: <20181207190720.18517-4-hch@lst.de>
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

Only report report a DMA addressability report once to avoid spewing the
kernel log with repeated message.  Also provide a stack trace to make it
easy to find the actual caller that caused the problem.

Last but not least move the actual check into the fast path and only
leave the error reporting in a helper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/direct.c | 36 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 308f88a750c8..edb24f94ea1e 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -30,27 +30,16 @@ static inline bool force_dma_unencrypted(void)
 	return sev_active();
 }
 
-static bool
-check_addr(struct device *dev, dma_addr_t dma_addr, size_t size,
-		const char *caller)
+static void report_addr(struct device *dev, dma_addr_t dma_addr, size_t size)
 {
-	if (unlikely(dev && !dma_capable(dev, dma_addr, size))) {
-		if (!dev->dma_mask) {
-			dev_err(dev,
-				"%s: call on device without dma_mask\n",
-				caller);
-			return false;
-		}
-
-		if (*dev->dma_mask >= DMA_BIT_MASK(32) || dev->bus_dma_mask) {
-			dev_err(dev,
-				"%s: overflow %pad+%zu of device mask %llx bus mask %llx\n",
-				caller, &dma_addr, size,
-				*dev->dma_mask, dev->bus_dma_mask);
-		}
-		return false;
+	if (!dev->dma_mask) {
+		dev_err_once(dev, "DMA map on device without dma_mask\n");
+	} else if (*dev->dma_mask >= DMA_BIT_MASK(32) || dev->bus_dma_mask) {
+		dev_err_once(dev,
+			"overflow %pad+%zu of DMA mask %llx bus mask %llx\n",
+			&dma_addr, size, *dev->dma_mask, dev->bus_dma_mask);
 	}
-	return true;
+	WARN_ON_ONCE(1);
 }
 
 static inline dma_addr_t phys_to_dma_direct(struct device *dev,
@@ -288,8 +277,10 @@ dma_addr_t dma_direct_map_page(struct device *dev, struct page *page,
 	phys_addr_t phys = page_to_phys(page) + offset;
 	dma_addr_t dma_addr = phys_to_dma(dev, phys);
 
-	if (!check_addr(dev, dma_addr, size, __func__))
+	if (unlikely(dev && !dma_capable(dev, dma_addr, size))) {
+		report_addr(dev, dma_addr, size);
 		return DMA_MAPPING_ERROR;
+	}
 
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		dma_direct_sync_single_for_device(dev, dma_addr, size, dir);
@@ -306,8 +297,11 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 		BUG_ON(!sg_page(sg));
 
 		sg_dma_address(sg) = phys_to_dma(dev, sg_phys(sg));
-		if (!check_addr(dev, sg_dma_address(sg), sg->length, __func__))
+		if (unlikely(dev && !dma_capable(dev, sg_dma_address(sg),
+				sg->length))) {
+			report_addr(dev, sg_dma_address(sg), sg->length);
 			return 0;
+		}
 		sg_dma_len(sg) = sg->length;
 	}
 
-- 
2.19.1

