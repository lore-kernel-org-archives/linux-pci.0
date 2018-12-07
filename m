Return-Path: <SRS0=SqGm=OQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1734EC64EB1
	for <linux-pci@archiver.kernel.org>; Fri,  7 Dec 2018 19:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF7D520868
	for <linux-pci@archiver.kernel.org>; Fri,  7 Dec 2018 19:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sI0r7/6e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF7D520868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbeLGTIU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 7 Dec 2018 14:08:20 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48556 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbeLGTIU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Dec 2018 14:08:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=glz+b8z0nShY9w1RbIdMqc4DyDTui7DptyDzyYZ7dHk=; b=sI0r7/6ewt1zj8XJy5koE2cXft
        uh/mQ2EgQaOyBUBhQWS03X9ZWZpE5At3YA6/Fk/tVhIku30j7h16wQpP/gp6RNaOhwUyKkp5B+hu7
        CpLfr41z58bZy5M3Lm23jHMRYUBrBjmdmYUKs58upUK5SsPYQRzmMcGJ+B1prCWUbrWO2cMATYbHP
        LTVDtKlbgFpuldsO7LCVGYEGTlDT87kOzKPsiO0EsH2vA96M87cCGvKVCOyRKKxNe8s6CMgznvuet
        YjaOY2Pq3lDVrWNoH+SCod4Z9Z3KnGFgYV0eXXN1ij30cN8VRLUAp+CKDC0gprq19r2SjWfLG/jB+
        t0pzCqVQ==;
Received: from [199.255.44.128] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gVLTt-0006pu-MZ; Fri, 07 Dec 2018 19:08:09 +0000
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
Subject: [PATCH 08/15] dma-mapping: move dma_get_required_mask to kernel/dma
Date:   Fri,  7 Dec 2018 11:07:13 -0800
Message-Id: <20181207190720.18517-9-hch@lst.de>
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

dma_get_required_mask should really be with the rest of the DMA mapping
implementation instead of in drivers/base as a lone outlier.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/base/platform.c | 31 -------------------------------
 kernel/dma/mapping.c    | 34 +++++++++++++++++++++++++++++++++-
 2 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 41b91af95afb..eae841935a45 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1179,37 +1179,6 @@ int __init platform_bus_init(void)
 	return error;
 }
 
-#ifndef ARCH_HAS_DMA_GET_REQUIRED_MASK
-static u64 dma_default_get_required_mask(struct device *dev)
-{
-	u32 low_totalram = ((max_pfn - 1) << PAGE_SHIFT);
-	u32 high_totalram = ((max_pfn - 1) >> (32 - PAGE_SHIFT));
-	u64 mask;
-
-	if (!high_totalram) {
-		/* convert to mask just covering totalram */
-		low_totalram = (1 << (fls(low_totalram) - 1));
-		low_totalram += low_totalram - 1;
-		mask = low_totalram;
-	} else {
-		high_totalram = (1 << (fls(high_totalram) - 1));
-		high_totalram += high_totalram - 1;
-		mask = (((u64)high_totalram) << 32) + 0xffffffff;
-	}
-	return mask;
-}
-
-u64 dma_get_required_mask(struct device *dev)
-{
-	const struct dma_map_ops *ops = get_dma_ops(dev);
-
-	if (ops->get_required_mask)
-		return ops->get_required_mask(dev);
-	return dma_default_get_required_mask(dev);
-}
-EXPORT_SYMBOL_GPL(dma_get_required_mask);
-#endif
-
 static __initdata LIST_HEAD(early_platform_driver_list);
 static __initdata LIST_HEAD(early_platform_device_list);
 
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index dfbc3deb95cd..dfe29d18dba1 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -5,7 +5,7 @@
  * Copyright (c) 2006  SUSE Linux Products GmbH
  * Copyright (c) 2006  Tejun Heo <teheo@suse.de>
  */
-
+#include <linux/memblock.h> /* for max_pfn */
 #include <linux/acpi.h>
 #include <linux/dma-noncoherent.h>
 #include <linux/export.h>
@@ -262,3 +262,35 @@ int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
 #endif /* !CONFIG_ARCH_NO_COHERENT_DMA_MMAP */
 }
 EXPORT_SYMBOL(dma_common_mmap);
+
+#ifndef ARCH_HAS_DMA_GET_REQUIRED_MASK
+static u64 dma_default_get_required_mask(struct device *dev)
+{
+	u32 low_totalram = ((max_pfn - 1) << PAGE_SHIFT);
+	u32 high_totalram = ((max_pfn - 1) >> (32 - PAGE_SHIFT));
+	u64 mask;
+
+	if (!high_totalram) {
+		/* convert to mask just covering totalram */
+		low_totalram = (1 << (fls(low_totalram) - 1));
+		low_totalram += low_totalram - 1;
+		mask = low_totalram;
+	} else {
+		high_totalram = (1 << (fls(high_totalram) - 1));
+		high_totalram += high_totalram - 1;
+		mask = (((u64)high_totalram) << 32) + 0xffffffff;
+	}
+	return mask;
+}
+
+u64 dma_get_required_mask(struct device *dev)
+{
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+
+	if (ops->get_required_mask)
+		return ops->get_required_mask(dev);
+	return dma_default_get_required_mask(dev);
+}
+EXPORT_SYMBOL_GPL(dma_get_required_mask);
+#endif
+
-- 
2.19.1

