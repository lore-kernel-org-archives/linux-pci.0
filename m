Return-Path: <SRS0=ngrz=OZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B56C43444
	for <linux-pci@archiver.kernel.org>; Sun, 16 Dec 2018 09:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9997E217FA
	for <linux-pci@archiver.kernel.org>; Sun, 16 Dec 2018 09:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729821AbeLPJCo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 16 Dec 2018 04:02:44 -0500
Received: from verein.lst.de ([213.95.11.211]:56419 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729758AbeLPJCo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 16 Dec 2018 04:02:44 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 20CD068D93; Sun, 16 Dec 2018 10:02:42 +0100 (CET)
Date:   Sun, 16 Dec 2018 10:02:42 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Keith Busch <keith.busch@intel.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-pci@vger.kernel.org, linux-ia64@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [15/15] dma-mapping: bypass indirect calls for dma-direct
Message-ID: <20181216090242.GA30702@lst.de>
References: <20181207190720.18517-16-hch@lst.de> <20181215174654.GA25694@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181215174654.GA25694@roeck-us.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Dec 15, 2018 at 09:46:54AM -0800, Guenter Roeck wrote:
> Hi,
> 
> On Fri, Dec 07, 2018 at 11:07:20AM -0800, Christoph Hellwig wrote:
> > Avoid expensive indirect calls in the fast path DMA mapping
> > operations by directly calling the dma_direct_* ops if we are using
> > the directly mapped DMA operations.
> > 
> 
> This patch results in arm64 boot failures. Reverting the patch fixes
> the problem. Bisect results are attached. Per logs, the system fails
> to instantiate the root device. Examples from two logs:

This patch should fix it, it has already been sent out Friday and
I'm just waiting for an ACK from the arm64 maintainers before
applying it:

--
From e6dc770875bc551ff77fe5673f5dd3c8ac242536 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Fri, 14 Dec 2018 15:18:08 +0100
Subject: arm64: default to the direct mapping in get_arch_dma_ops

Otherwise the direct mapping won't work at all given that a NULL
dev->dma_ops causes a fallback.  Note that we already explicitly set
dev->dma_ops to dma_dummy_ops for dma-incapable devices, so this
fallback should not be needed anyway.

Fixes: 356da6d0cd ("dma-mapping: bypass indirect calls for dma-direct")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm64/include/asm/dma-mapping.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
index 273e778f7de2..95dbf3ef735a 100644
--- a/arch/arm64/include/asm/dma-mapping.h
+++ b/arch/arm64/include/asm/dma-mapping.h
@@ -26,11 +26,7 @@
 
 static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
-	/*
-	 * We expect no ISA devices, and all other DMA masters are expected to
-	 * have someone call arch_setup_dma_ops at device creation time.
-	 */
-	return &dma_dummy_ops;
+	return NULL;
 }
 
 void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
-- 
2.19.2

