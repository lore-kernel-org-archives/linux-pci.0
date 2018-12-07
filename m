Return-Path: <SRS0=SqGm=OQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 793F5C65BAF
	for <linux-pci@archiver.kernel.org>; Fri,  7 Dec 2018 19:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A532083D
	for <linux-pci@archiver.kernel.org>; Fri,  7 Dec 2018 19:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dDexeD96"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32A532083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbeLGTIM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 7 Dec 2018 14:08:12 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48496 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbeLGTIJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Dec 2018 14:08:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5bxE7/nVpI/7mlzaLJcxDeM0h4Y+t/nWwWlVgLKUuRA=; b=dDexeD96yAPO79Ix1tQz87OVpW
        G29DQAswPSuivne90/uGy9Xrw9h0kNG91Ce9Q+9tH9b8bfcUefZhyADffVs4AejMAPKrq+9PnosQH
        2r+i8pifikF+hU2ljTRS/MzifPsNqdi1jRvuhpIwNCWfow9R77feomnLAZr7XGx44OxQW+NhMHmGH
        ldYqtml/N4C6CFPXd6MeDAUfQ4nGThsgsJK1M7MRy+N5DvrSSYt/X4QZrfsWu1T0R1xT5uWWaBtOL
        mFLI6pXXfmoU5r255fb48XjhAo8QFLjjRCe47u1NccyrgRwAmyzxVmYmCuJ1YEOil2QnN4aCUIT8m
        R4ikW/pg==;
Received: from [199.255.44.128] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gVLTj-0006lz-3b; Fri, 07 Dec 2018 19:07:59 +0000
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
Subject: [PATCH 06/15] dma-mapping: simplify the dma_sync_single_range_for_{cpu,device} implementation
Date:   Fri,  7 Dec 2018 11:07:11 -0800
Message-Id: <20181207190720.18517-7-hch@lst.de>
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

We can just call the regular calls after adding offset the the address instead
of reimplementing them.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/dma-debug.h   | 27 ------------------------
 include/linux/dma-mapping.h | 34 +++++++++---------------------
 kernel/dma/debug.c          | 42 -------------------------------------
 3 files changed, 10 insertions(+), 93 deletions(-)

diff --git a/include/linux/dma-debug.h b/include/linux/dma-debug.h
index 30213adbb6b9..c85e097a984c 100644
--- a/include/linux/dma-debug.h
+++ b/include/linux/dma-debug.h
@@ -72,17 +72,6 @@ extern void debug_dma_sync_single_for_device(struct device *dev,
 					     dma_addr_t dma_handle,
 					     size_t size, int direction);
 
-extern void debug_dma_sync_single_range_for_cpu(struct device *dev,
-						dma_addr_t dma_handle,
-						unsigned long offset,
-						size_t size,
-						int direction);
-
-extern void debug_dma_sync_single_range_for_device(struct device *dev,
-						   dma_addr_t dma_handle,
-						   unsigned long offset,
-						   size_t size, int direction);
-
 extern void debug_dma_sync_sg_for_cpu(struct device *dev,
 				      struct scatterlist *sg,
 				      int nelems, int direction);
@@ -174,22 +163,6 @@ static inline void debug_dma_sync_single_for_device(struct device *dev,
 {
 }
 
-static inline void debug_dma_sync_single_range_for_cpu(struct device *dev,
-						       dma_addr_t dma_handle,
-						       unsigned long offset,
-						       size_t size,
-						       int direction)
-{
-}
-
-static inline void debug_dma_sync_single_range_for_device(struct device *dev,
-							  dma_addr_t dma_handle,
-							  unsigned long offset,
-							  size_t size,
-							  int direction)
-{
-}
-
 static inline void debug_dma_sync_sg_for_cpu(struct device *dev,
 					     struct scatterlist *sg,
 					     int nelems, int direction)
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 7799c2b27849..8916499d2805 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -360,6 +360,13 @@ static inline void dma_sync_single_for_cpu(struct device *dev, dma_addr_t addr,
 	debug_dma_sync_single_for_cpu(dev, addr, size, dir);
 }
 
+static inline void dma_sync_single_range_for_cpu(struct device *dev,
+		dma_addr_t addr, unsigned long offset, size_t size,
+		enum dma_data_direction dir)
+{
+	return dma_sync_single_for_cpu(dev, addr + offset, size, dir);
+}
+
 static inline void dma_sync_single_for_device(struct device *dev,
 					      dma_addr_t addr, size_t size,
 					      enum dma_data_direction dir)
@@ -372,32 +379,11 @@ static inline void dma_sync_single_for_device(struct device *dev,
 	debug_dma_sync_single_for_device(dev, addr, size, dir);
 }
 
-static inline void dma_sync_single_range_for_cpu(struct device *dev,
-						 dma_addr_t addr,
-						 unsigned long offset,
-						 size_t size,
-						 enum dma_data_direction dir)
-{
-	const struct dma_map_ops *ops = get_dma_ops(dev);
-
-	BUG_ON(!valid_dma_direction(dir));
-	if (ops->sync_single_for_cpu)
-		ops->sync_single_for_cpu(dev, addr + offset, size, dir);
-	debug_dma_sync_single_range_for_cpu(dev, addr, offset, size, dir);
-}
-
 static inline void dma_sync_single_range_for_device(struct device *dev,
-						    dma_addr_t addr,
-						    unsigned long offset,
-						    size_t size,
-						    enum dma_data_direction dir)
+		dma_addr_t addr, unsigned long offset, size_t size,
+		enum dma_data_direction dir)
 {
-	const struct dma_map_ops *ops = get_dma_ops(dev);
-
-	BUG_ON(!valid_dma_direction(dir));
-	if (ops->sync_single_for_device)
-		ops->sync_single_for_device(dev, addr + offset, size, dir);
-	debug_dma_sync_single_range_for_device(dev, addr, offset, size, dir);
+	return dma_sync_single_for_device(dev, addr + offset, size, dir);
 }
 
 static inline void
diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 231ca4628062..3214833b47e2 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -1662,48 +1662,6 @@ void debug_dma_sync_single_for_device(struct device *dev,
 }
 EXPORT_SYMBOL(debug_dma_sync_single_for_device);
 
-void debug_dma_sync_single_range_for_cpu(struct device *dev,
-					 dma_addr_t dma_handle,
-					 unsigned long offset, size_t size,
-					 int direction)
-{
-	struct dma_debug_entry ref;
-
-	if (unlikely(dma_debug_disabled()))
-		return;
-
-	ref.type         = dma_debug_single;
-	ref.dev          = dev;
-	ref.dev_addr     = dma_handle;
-	ref.size         = offset + size;
-	ref.direction    = direction;
-	ref.sg_call_ents = 0;
-
-	check_sync(dev, &ref, true);
-}
-EXPORT_SYMBOL(debug_dma_sync_single_range_for_cpu);
-
-void debug_dma_sync_single_range_for_device(struct device *dev,
-					    dma_addr_t dma_handle,
-					    unsigned long offset,
-					    size_t size, int direction)
-{
-	struct dma_debug_entry ref;
-
-	if (unlikely(dma_debug_disabled()))
-		return;
-
-	ref.type         = dma_debug_single;
-	ref.dev          = dev;
-	ref.dev_addr     = dma_handle;
-	ref.size         = offset + size;
-	ref.direction    = direction;
-	ref.sg_call_ents = 0;
-
-	check_sync(dev, &ref, false);
-}
-EXPORT_SYMBOL(debug_dma_sync_single_range_for_device);
-
 void debug_dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
 			       int nelems, int direction)
 {
-- 
2.19.1

