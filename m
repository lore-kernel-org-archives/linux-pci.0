Return-Path: <SRS0=mKou=PM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92257C43387
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 08:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6409720665
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 08:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbfADIJM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 4 Jan 2019 03:09:12 -0500
Received: from verein.lst.de ([213.95.11.211]:38433 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725931AbfADIJM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Jan 2019 03:09:12 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id A853368AFE; Fri,  4 Jan 2019 09:09:10 +0100 (CET)
Date:   Fri, 4 Jan 2019 09:09:10 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Tony Luck <tony.luck@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Keith Busch <keith.busch@intel.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-pci@vger.kernel.org,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        X86-ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/15] swiotlb: remove dma_mark_clean
Message-ID: <20190104080910.GA15221@lst.de>
References: <20181207190720.18517-1-hch@lst.de> <20181207190720.18517-3-hch@lst.de> <CA+8MBb+9prWYSmp25K-LMUv1_0eekvFqXhoj87CV9zcaXfMDGg@mail.gmail.com> <20190103072356.GA24163@lst.de> <CA+8MBbKXTRGLn1Wvpp1avQCZ186i5Cbo0puvSoNNuKO7_AcwZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+8MBbKXTRGLn1Wvpp1avQCZ186i5Cbo0puvSoNNuKO7_AcwZg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

One more ifdef to rescue..

Btw, do you know why we only play these mark clean bits for swiotlb
and not for the various iommus?

Also do you have any good receipe to build an ia64 cross compiler on
a recent Debian system?  Unlike most architectures Debian doesn't have
a pre-built one, and the script from the kernel buіldbot doesn't work
either unfortunately.

---
From 3f5f3297aa989cf27b3fe10e2d010422332574b3 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Fri, 4 Jan 2019 09:06:05 +0100
Subject: ia64: fix compile without swiotlb

Some non-generic ia64 configs don't build swiotlb, and thus should not
pull in the generic non-coherent DMA infrastructure.

Fixes: 68c608345c ("swiotlb: remove dma_mark_clean")
Reported-by: Tony Luck <tony.luck@gmail.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/ia64/Kconfig   | 2 +-
 arch/ia64/mm/init.c | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index ccd56f5df8cd..8d7396bd1790 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -31,7 +31,7 @@ config IA64
 	select HAVE_MEMBLOCK_NODE_MAP
 	select HAVE_VIRT_CPU_ACCOUNTING
 	select ARCH_HAS_DMA_COHERENT_TO_PFN if SWIOTLB
-	select ARCH_HAS_SYNC_DMA_FOR_CPU
+	select ARCH_HAS_SYNC_DMA_FOR_CPU if SWIOTLB
 	select VIRT_TO_BUS
 	select ARCH_DISCARD_MEMBLOCK
 	select GENERIC_IRQ_PROBE
diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
index 055382622f07..29d841525ca1 100644
--- a/arch/ia64/mm/init.c
+++ b/arch/ia64/mm/init.c
@@ -67,6 +67,7 @@ __ia64_sync_icache_dcache (pte_t pte)
 	set_bit(PG_arch_1, &page->flags);	/* mark page as clean */
 }
 
+#ifdef CONFIG_SWIOTLB
 /*
  * Since DMA is i-cache coherent, any (complete) pages that were written via
  * DMA can be marked as "clean" so that lazy_mmu_prot_update() doesn't have to
@@ -81,6 +82,7 @@ void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
 		set_bit(PG_arch_1, &pfn_to_page(pfn)->flags);
 	} while (++pfn <= PHYS_PFN(paddr + size - 1));
 }
+#endif
 
 inline void
 ia64_set_rbs_bot (void)
-- 
2.20.1

