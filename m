Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: NVMe vs DMA addressing limitations
To: Christoph Hellwig <hch@lst.de>
References: <1483044304-2085-1-git-send-email-nikita.yoush@cogentembedded.com>
 <2723285.JORgusvJv4@wuerfel>
 <9a03c05d-ad4c-0547-d1fe-01edb8b082d6@cogentembedded.com>
 <6374144.HVL0QxNJiT@wuerfel>
 <b50e25af-3936-d22d-2e9b-5bf6be19c800@cogentembedded.com>
 <20170109205746.GA6274@lst.de>
Cc: Arnd Bergmann <arnd@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Simon Horman <horms@verge.net.au>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        artemi.ivanov@cogentembedded.com,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Message-ID: <e084dbad-29ab-25bd-5e17-da0fcd92f7ac@cogentembedded.com>
Date: Tue, 10 Jan 2017 09:47:21 +0300
MIME-Version: 1.0
In-Reply-To: <20170109205746.GA6274@lst.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>> I believe the bounce buffering code you refer to is not in SATA/SCSI/MMC
>> but in block layer, in particular it should be controlled by
>> blk_queue_bounce_limit().  [Yes there is CONFIG_MMC_BLOCK_BOUNCE but it
>> is something completely different, namely it is for request merging for
>> hw not supporting scatter-gather].  And NVMe also uses block layer and
>> thus should get same support.
> 
> NVMe shouldn't have to call blk_queue_bounce_limit - 
> blk_queue_bounce_limit is to set the DMA addressing limit of the device.
> NVMe devices must support unlimited 64-bit addressing and thus calling
> blk_queue_bounce_limit from NVMe does not make sense.

I'm now working with HW that:
- is now way "low end" or "obsolete", it has 4G of RAM and 8 CPU cores,
and is being manufactured and developed,
- has 75% of it's RAM located beyond first 4G of address space,
- can't physically handle incoming PCIe transactions addressed to memory
beyond 4G.

Swiotlb is used there, sure (once a bug in arm64 arch is patched). But
that setup still has at least two issues.

(1) it constantly runs of swiotlb space, logs are full of warnings
despite of rate limiting,

(2) it runs far suboptimal due to bounce-buffering almost all i/o,
despite of lots of free memory in area where direct DMA is possible.

I'm looking for proper way to address these. Shooting HW designer as you
suggested elsewhere doesn't look like a practical solution. Any better
ideas?


Per my current understanding, blk-level bounce buffering will at least
help with (1) - if done properly it will allocate bounce buffers within
entire memory below 4G, not within dedicated swiotlb space (that is
small and enlarging it makes memory permanently unavailable for other
use).  This looks simple and safe (in sense of not anyhow breaking
unrelated use cases).

Addressing (2) looks much more difficult because different memory
allocation policy is required for that.


> That being said currently the default for a queue without a call
> to blk_queue_make_request which does the wrong thing on highmem
> setups, so we should fix it.  In fact BLK_BOUNCE_HIGH as-is doesn't
> really make much sense these days as no driver should ever dereference
> pages passed to it directly.
> 
>> Maybe fixing that, together with making NVMe use this API, could stop it
>> from issuing dma_map()s of addresses beyond mask.
> 
> NVMe should never bounce, the fact that it currently possibly does
> for highmem pages is a bug.

The entire topic is absolutely not related to highmem (i.e. memory not
directly addressable by 32-bit kernel).

What we are discussing is hw-originated restriction on where DMA is
possible.


> Or even better remove the call to dma_set_mask_and_coherent with
> DMA_BIT_MASK(32).  NVMe is designed around having proper 64-bit DMA
> addressing, there is not point in trying to pretent it works without that

Are you claiming that NVMe driver in mainline is intentionally designed
to not work on HW that can't do DMA to entire 64-bit space?

Such setups do exist and there is interest to make them working.


> We need to kill off BLK_BOUNCE_HIGH, it just doesn't make sense to
> mix the highmem aspect with the addressing limits.  In fact the whole
> block bouncing scheme doesn't make much sense at all these days, we
> should rely on swiotlb instead.

I agree that centralized bounce buffering is better than
subsystem-implemented bounce buffering.

I still claim that even better - especially from performance point of
view - is some memory allocation policy that is aware of HW limitations
and avoids bounce buffering at least when it is possible.


>> What I mean is some API to allocate memory for use with streaming DMA in
>> such way that bounce buffers won't be needed. There are many cases when
>> at buffer allocation time, it is already known that buffer will be used
>> for DMA with particular device. Bounce buffers will still be needed
>> cases when no such information is available at allocation time, or when
>> there is no directly-DMAable memory available at allocation time.
> 
> For block I/O that is never the case.

Quite a few pages used for block I/O are allocated by filemap code - and
at allocation point it is known what inode page is being allocated for.
If this inode is from filesystem located on a known device with known
DMA limitations, this knowledge can be used to allocate page that can be
DMAed directly.

Sure there are lots of cases when at allocation time there is no idea
what device will run DMA on page being allocated, or perhaps page is
going to be shared, or whatever. Such cases unavoidably require bounce
buffers if page ends to be used with device with DMA limitations. But
still there are cases when better allocation can remove need for bounce
buffers - without any hurt for other cases.


Nikita
