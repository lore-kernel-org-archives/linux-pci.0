Return-Path: <SRS0=ToWj=PL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0D8C43387
	for <linux-pci@archiver.kernel.org>; Thu,  3 Jan 2019 07:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DD6B20883
	for <linux-pci@archiver.kernel.org>; Thu,  3 Jan 2019 07:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729895AbfACHX7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 3 Jan 2019 02:23:59 -0500
Received: from verein.lst.de ([213.95.11.211]:60755 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728613AbfACHX6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Jan 2019 02:23:58 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 58BE667357; Thu,  3 Jan 2019 08:23:56 +0100 (CET)
Date:   Thu, 3 Jan 2019 08:23:56 +0100
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
Message-ID: <20190103072356.GA24163@lst.de>
References: <20181207190720.18517-1-hch@lst.de> <20181207190720.18517-3-hch@lst.de> <CA+8MBb+9prWYSmp25K-LMUv1_0eekvFqXhoj87CV9zcaXfMDGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+8MBb+9prWYSmp25K-LMUv1_0eekvFqXhoj87CV9zcaXfMDGg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 02, 2019 at 01:53:33PM -0800, Tony Luck wrote:
> On Fri, Dec 7, 2018 at 11:08 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > Instead of providing a special dma_mark_clean hook just for ia64, switch
> > ia64 to use the normal arch_sync_dma_for_cpu hooks instead.
> >
> > This means that we now also set the PG_arch_1 bit for pages in the
> > swiotlb buffer, which isn't stricly needed as we will never execute code
> > out of the swiotlb buffer, but otherwise harmless.
> 
> ia64 build based on arch/ia64/configs/zx1_defconfig now fails with undefined
> symbols arch_dma_alloc and arch_dma_free (used by kernel/dma/direct.c).
> 
> This config doesn't define CONFIG_SWIOTLB, so we don't get the
> benefit of the routines in arch/ia64/kernel/dma-mapping.c

I think something like the patch below should fix it:

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
