Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Arnd Bergmann <arnd@linaro.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] arm64: dma_mapping: allow PCI host driver to limit
 DMA mask
Date: Tue, 10 Jan 2017 11:47:42 +0100
Message-ID: <1988852.3nyUoruEjG@wuerfel>
In-Reply-To: <20170109205746.GA6274@lst.de>
References: <1483044304-2085-1-git-send-email-nikita.yoush@cogentembedded.com>
 <b50e25af-3936-d22d-2e9b-5bf6be19c800@cogentembedded.com>
 <20170109205746.GA6274@lst.de>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
 Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
 Jens Axboe <axboe@fb.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
 Simon Horman <horms@verge.net.au>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, artemi.ivanov@cogentembedded.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Monday, January 9, 2017 9:57:46 PM CET Christoph Hellwig wrote:
> > - architecture should stop breaking 64-bit DMA when driver attempts to
> > set 64-bit dma mask,
> > 
> > - NVMe should issue proper blk_queue_bounce_limit() call based on what
> > is actually set mask,
> 
> Or even better remove the call to dma_set_mask_and_coherent with
> DMA_BIT_MASK(32).  NVMe is designed around having proper 64-bit DMA
> addressing, there is not point in trying to pretent it works without that

Agreed, let's just fail the probe() if DMA_BIT_MASK(64) fails, and
have swiotlb work around machines that for some reason need bounce
buffers.

> > - and blk_queue_bounce_limit() should also be fixed to actually set
> > 0xffffffff limit, instead of replacing it with (max_low_pfn <<
> > PAGE_SHIFT) as it does now.
> 
> We need to kill off BLK_BOUNCE_HIGH, it just doesn't make sense to
> mix the highmem aspect with the addressing limits.  In fact the whole
> block bouncing scheme doesn't make much sense at all these days, we
> should rely on swiotlb instead.

If we do this, we should probably have another look at the respective
NETIF_F_HIGHDMA support in the network stack, which does the same thing
and mixes up highmem on 32-bit architectures with the DMA address limit.
(side note: there are actually cases in which you have a 31-bit DMA
mask but 3 GB of lowmem using CONFIG_VMSPLIT_1G, so BLK_BOUNCE_HIGH
and !NETIF_F_HIGHDMA are both missing the limit, causing data corruption
without swiotlb).

Before we rely too much on swiotlb, we may also need to consider which
architectures today rely on bouncing in blk and network.

I see that we have CONFIG_ARCH_PHYS_ADDR_T_64BIT on a couple of
32-bit architectures without swiotlb (arc, arm, some mips32), and
there are several 64-bit architectures that do not have swiotlb
(alpha, parisc, s390, sparc). I believe that alpha, s390 and sparc
always use some form of IOMMU, but the other four apparently don't,
so we would need to add swiotlb support there to remove all the
bounce buffering in network and block layers.

	Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
