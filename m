Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 9 Jan 2017 21:57:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: Re: [PATCH 1/2] arm64: dma_mapping: allow PCI host driver to limit
 DMA mask
Message-ID: <20170109205746.GA6274@lst.de>
References: <1483044304-2085-1-git-send-email-nikita.yoush@cogentembedded.com>
 <2723285.JORgusvJv4@wuerfel>
 <9a03c05d-ad4c-0547-d1fe-01edb8b082d6@cogentembedded.com>
 <6374144.HVL0QxNJiT@wuerfel>
 <b50e25af-3936-d22d-2e9b-5bf6be19c800@cogentembedded.com>
MIME-Version: 1.0
In-Reply-To: <b50e25af-3936-d22d-2e9b-5bf6be19c800@cogentembedded.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
 Jens Axboe <axboe@fb.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 artemi.ivanov@cogentembedded.com, Arnd Bergmann <arnd@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 09, 2017 at 11:34:55PM +0300, Nikita Yushchenko wrote:
> I believe the bounce buffering code you refer to is not in SATA/SCSI/MMC
> but in block layer, in particular it should be controlled by
> blk_queue_bounce_limit().  [Yes there is CONFIG_MMC_BLOCK_BOUNCE but it
> is something completely different, namely it is for request merging for
> hw not supporting scatter-gather].  And NVMe also uses block layer and
> thus should get same support.

NVMe shouldn't have to call blk_queue_bounce_limit - 
blk_queue_bounce_limit is to set the DMA addressing limit of the device.
NVMe devices must support unlimited 64-bit addressing and thus calling
blk_queue_bounce_limit from NVMe does not make sense.

That being said currently the default for a queue without a call
to blk_queue_make_request which does the wrong thing on highmem
setups, so we should fix it.  In fact BLK_BOUNCE_HIGH as-is doesn't
really make much sense these days as no driver should ever dereference
pages passed to it directly.

> Maybe fixing that, together with making NVMe use this API, could stop it
> from issuing dma_map()s of addresses beyond mask.

NVMe should never bounce, the fact that it currently possibly does
for highmem pages is a bug.

> As for PCI_DMA_BUS_IS_PHYS - ironically, what all current usages of this
> macro in the kernel do is - *disable* bounce buffers in block layer if
> PCI_DMA_BUS_IS_PHYS is zero.

That's not ironic but the whole point of the macro (horrible name and
the fact that it should be a dma_ops setting aside).

> - architecture should stop breaking 64-bit DMA when driver attempts to
> set 64-bit dma mask,
> 
> - NVMe should issue proper blk_queue_bounce_limit() call based on what
> is actually set mask,

Or even better remove the call to dma_set_mask_and_coherent with
DMA_BIT_MASK(32).  NVMe is designed around having proper 64-bit DMA
addressing, there is not point in trying to pretent it works without that

> - and blk_queue_bounce_limit() should also be fixed to actually set
> 0xffffffff limit, instead of replacing it with (max_low_pfn <<
> PAGE_SHIFT) as it does now.

We need to kill off BLK_BOUNCE_HIGH, it just doesn't make sense to
mix the highmem aspect with the addressing limits.  In fact the whole
block bouncing scheme doesn't make much sense at all these days, we
should rely on swiotlb instead.

> What I mean is some API to allocate memory for use with streaming DMA in
> such way that bounce buffers won't be needed. There are many cases when
> at buffer allocation time, it is already known that buffer will be used
> for DMA with particular device. Bounce buffers will still be needed
> cases when no such information is available at allocation time, or when
> there is no directly-DMAable memory available at allocation time.

For block I/O that is never the case.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
