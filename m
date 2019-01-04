Return-Path: <SRS0=mKou=PM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A95C43387
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 17:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6084218CD
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 17:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbfADRet (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 4 Jan 2019 12:34:49 -0500
Received: from verein.lst.de ([213.95.11.211]:40889 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbfADRet (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Jan 2019 12:34:49 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 1D0EB68D93; Fri,  4 Jan 2019 18:34:47 +0100 (CET)
Date:   Fri, 4 Jan 2019 18:34:47 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Liviu Dudau <liviu@dudau.co.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org,
        LAKML <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [REGRESSION, BISECTED] pci: nvme device with HMB fails on arm64
Message-ID: <20190104173446.GA24554@lst.de>
References: <20190104125735.GF20342@bart.dudau.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190104125735.GF20342@bart.dudau.co.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Liviu,

please try the patch below.  Note that this is in top of mainline,
as the commit you found already needed another fixup, which has
made it to Linus already.

--
From a959cc1a8ee00dcb274922f9d74f6ed632709047 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Fri, 4 Jan 2019 18:31:48 +0100
Subject: dma-direct: fix DMA_ATTR_NO_KERNEL_MAPPING for remapped allocations

We need to return a dma_addr_t even if we don't have a kernel mapping.
Do so by consolidating the phys_to_dma call in a single place and jump
to it from all the branches that return successfully.

Fixes: bfd56cd60521 ("dma-mapping: support highmem in the generic remap allocator")
Reported-by: Liviu Dudau <liviu@dudau.co.uk
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/remap.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
index 18cc09fc27b9..7a723194ecbe 100644
--- a/kernel/dma/remap.c
+++ b/kernel/dma/remap.c
@@ -204,8 +204,7 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		ret = dma_alloc_from_pool(size, &page, flags);
 		if (!ret)
 			return NULL;
-		*dma_handle = phys_to_dma(dev, page_to_phys(page));
-		return ret;
+		goto done;
 	}
 
 	page = __dma_direct_alloc_pages(dev, size, dma_handle, flags, attrs);
@@ -215,8 +214,10 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	/* remove any dirty cache lines on the kernel alias */
 	arch_dma_prep_coherent(page, size);
 
-	if (attrs & DMA_ATTR_NO_KERNEL_MAPPING)
-		return page; /* opaque cookie */
+	if (attrs & DMA_ATTR_NO_KERNEL_MAPPING) {
+		ret = page; /* opaque cookie */
+		goto done;
+	}
 
 	/* create a coherent mapping */
 	ret = dma_common_contiguous_remap(page, size, VM_USERMAP,
@@ -227,9 +228,9 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		return ret;
 	}
 
-	*dma_handle = phys_to_dma(dev, page_to_phys(page));
 	memset(ret, 0, size);
-
+done:
+	*dma_handle = phys_to_dma(dev, page_to_phys(page));
 	return ret;
 }
 
-- 
2.20.1

