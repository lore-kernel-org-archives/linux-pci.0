Return-Path: <SRS0=+Ccl=UQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DAB4C31E5B
	for <linux-pci@archiver.kernel.org>; Mon, 17 Jun 2019 12:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5647A2084D
	for <linux-pci@archiver.kernel.org>; Mon, 17 Jun 2019 12:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FbRn9tnx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfFQM1r (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 Jun 2019 08:27:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42432 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfFQM1q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jun 2019 08:27:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7iZXhGqknpU44tD1MPjuSqDckdpKS/nLGoa4L7/1O94=; b=FbRn9tnxZ5wWW5q5U1pZRBVxXs
        CxGwGMXKAq/9Ihv+awdUqjfKfebfLDdbVNObc0HyuE8WXKatstvj5dw/HK/igbfwoSFPnkwWo7ebj
        rUGor0jqTaP/NW3YZeZfVSnvBwAlo3Lo8EiyGtMu2ND6pJBqRtA/O5D4bGF6fo8S0K5psWYBY5XxU
        2c+lcusAC9Bxse0Kr01AZ9/JkVgMHxvoDiwKVC1jNIBFfo+VKR+KrNeDEBaA0xzhkfYUvWAgWPrWC
        Lfcmv9DujdDUWC5tNLBcO6Ok6TTvo8HvDhBnnc9rcvR5/dgumLg41lBugJqDsgZ6cxqqK5EVO2485
        CgZI5zyQ==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hcqjf-0008Kt-OO; Mon, 17 Jun 2019 12:27:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     linux-mm@kvack.org, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-nvdimm@lists.01.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 03/25] mm: remove hmm_devmem_add_resource
Date:   Mon, 17 Jun 2019 14:27:11 +0200
Message-Id: <20190617122733.22432-4-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190617122733.22432-1-hch@lst.de>
References: <20190617122733.22432-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This function has never been used since it was first added to the kernel
more than a year and a half ago, and if we ever grow a consumer of the
MEMORY_DEVICE_PUBLIC infrastructure it can easily use devm_memremap_pages
directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/hmm.h |  3 ---
 mm/hmm.c            | 50 ---------------------------------------------
 2 files changed, 53 deletions(-)

diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index c92f353d701a..31e1c5347331 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -724,9 +724,6 @@ struct hmm_devmem {
 struct hmm_devmem *hmm_devmem_add(const struct hmm_devmem_ops *ops,
 				  struct device *device,
 				  unsigned long size);
-struct hmm_devmem *hmm_devmem_add_resource(const struct hmm_devmem_ops *ops,
-					   struct device *device,
-					   struct resource *res);
 
 /*
  * hmm_devmem_page_set_drvdata - set per-page driver data field
diff --git a/mm/hmm.c b/mm/hmm.c
index f3350fc567ab..dc251c51803a 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -1475,54 +1475,4 @@ struct hmm_devmem *hmm_devmem_add(const struct hmm_devmem_ops *ops,
 	return devmem;
 }
 EXPORT_SYMBOL_GPL(hmm_devmem_add);
-
-struct hmm_devmem *hmm_devmem_add_resource(const struct hmm_devmem_ops *ops,
-					   struct device *device,
-					   struct resource *res)
-{
-	struct hmm_devmem *devmem;
-	void *result;
-	int ret;
-
-	if (res->desc != IORES_DESC_DEVICE_PUBLIC_MEMORY)
-		return ERR_PTR(-EINVAL);
-
-	dev_pagemap_get_ops();
-
-	devmem = devm_kzalloc(device, sizeof(*devmem), GFP_KERNEL);
-	if (!devmem)
-		return ERR_PTR(-ENOMEM);
-
-	init_completion(&devmem->completion);
-	devmem->pfn_first = -1UL;
-	devmem->pfn_last = -1UL;
-	devmem->resource = res;
-	devmem->device = device;
-	devmem->ops = ops;
-
-	ret = percpu_ref_init(&devmem->ref, &hmm_devmem_ref_release,
-			      0, GFP_KERNEL);
-	if (ret)
-		return ERR_PTR(ret);
-
-	devmem->pfn_first = devmem->resource->start >> PAGE_SHIFT;
-	devmem->pfn_last = devmem->pfn_first +
-			   (resource_size(devmem->resource) >> PAGE_SHIFT);
-	devmem->page_fault = hmm_devmem_fault;
-
-	devmem->pagemap.type = MEMORY_DEVICE_PUBLIC;
-	devmem->pagemap.res = *devmem->resource;
-	devmem->pagemap.page_free = hmm_devmem_free;
-	devmem->pagemap.altmap_valid = false;
-	devmem->pagemap.ref = &devmem->ref;
-	devmem->pagemap.data = devmem;
-	devmem->pagemap.kill = hmm_devmem_ref_kill;
-	devmem->pagemap.cleanup = hmm_devmem_ref_exit;
-
-	result = devm_memremap_pages(devmem->device, &devmem->pagemap);
-	if (IS_ERR(result))
-		return result;
-	return devmem;
-}
-EXPORT_SYMBOL_GPL(hmm_devmem_add_resource);
 #endif /* CONFIG_DEVICE_PRIVATE || CONFIG_DEVICE_PUBLIC */
-- 
2.20.1

