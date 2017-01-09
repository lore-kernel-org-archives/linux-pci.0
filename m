Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH 1/2] arm64: dma_mapping: allow PCI host driver to limit
 DMA mask
To: Arnd Bergmann <arnd@linaro.org>, linux-arm-kernel@lists.infradead.org
References: <1483044304-2085-1-git-send-email-nikita.yoush@cogentembedded.com>
 <2723285.JORgusvJv4@wuerfel>
 <9a03c05d-ad4c-0547-d1fe-01edb8b082d6@cogentembedded.com>
 <6374144.HVL0QxNJiT@wuerfel>
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Message-ID: <b50e25af-3936-d22d-2e9b-5bf6be19c800@cogentembedded.com>
Date: Mon, 9 Jan 2017 23:34:55 +0300
MIME-Version: 1.0
In-Reply-To: <6374144.HVL0QxNJiT@wuerfel>
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
 linux-nvme@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
 Simon Horman <horms@verge.net.au>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, artemi.ivanov@cogentembedded.com,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

[CCing NVMe maintainers since we are discussion issues in that driver]

>> With my patch applied and thus 32bit dma_mask set for NVMe device, I do
>> see high addresses passed to dma_map_*() routines and handled by
>> swiotlb. Thus your statement that behavior "succeed 64bit dma_set_mask()
>> operation but silently replace mask behind the scene" is required for
>> swiotlb to be used, does not match reality.
> 
> See my point about drivers that don't implement bounce buffering.
> Apparently NVMe is one of them, unlike the SATA/SCSI/MMC storage
> drivers that do their own thing.

I believe the bounce buffering code you refer to is not in SATA/SCSI/MMC
but in block layer, in particular it should be controlled by
blk_queue_bounce_limit().  [Yes there is CONFIG_MMC_BLOCK_BOUNCE but it
is something completely different, namely it is for request merging for
hw not supporting scatter-gather].  And NVMe also uses block layer and
thus should get same support.

But blk_queue_bounce_limit() is somewhat broken, it has very strange
code under #if BITS_PER_LONG == 64 that makes setting max_addr to
0xffffffff not working if max_low_pfn is above 4G.

Maybe fixing that, together with making NVMe use this API, could stop it
from issuing dma_map()s of addresses beyond mask.


> What I think happened here in chronological order is:
> 
> - In the old days, 64-bit architectures tended to use an IOMMU 
>   all the time to work around 32-bit limitations on DMA masters
> - Some architectures had no IOMMU that fully solved this and the
>   dma-mapping API required drivers to set the right mask and check
>   the return code. If this failed, the driver needed to use its
>   own bounce buffers as network and scsi do. See also the
>   grossly misnamed "PCI_DMA_BUS_IS_PHYS" macro.
> - As we never had support for bounce buffers in all drivers, and
>   early 64-bit Intel machines had no IOMMU, the swiotlb code was
>   introduced as a workaround, so we can use the IOMMU case without
>   driver specific bounce buffers everywhere
> - As most of the important 64-bit architectures (x86, arm64, powerpc)
>   now always have either IOMMU or swiotlb enabled, drivers like
>   NVMe started relying on it, and no longer handle a dma_set_mask
>   failure properly.

... and architectures started to add to this breakage, not handling
dma_set_mask() as documented.


As for PCI_DMA_BUS_IS_PHYS - ironically, what all current usages of this
macro in the kernel do is - *disable* bounce buffers in block layer if
PCI_DMA_BUS_IS_PHYS is zero.  Defining it to zero (as arm64 currently
does) on system with memory above 4G makes all block drivers to depend
on swiotlb (or iommu). Affected drivers are SCSI and IDE.

> We may need to audit how drivers typically handle dma_set_mask()
> failure. The NVMe driver in its current state will probably cause
> silent data corruption when used on a 64-bit architecture that has
> a 32-bit bus but neither swiotlb nor iommu enabled at runtime.

With current code NVME causes system memory breakage even if swiotlb is
there - because it's dma_set_mask_and_coherent(DMA_BIT_MASK(64)) call
has effect of silent disable of swiotlb.


> I would argue that the driver should be fixed to either refuse
> working in that configuration to avoid data corruption, or that
> it should implement bounce buffering like SCSI does.

Difference from "SCSI" (actually - from block drivers that work) is in
that dma_set_mask_and_coherent(DMA_BIT_MASK(64)) call: driver that does
not do it works, driver that does it fails.

Per documentation, driver *should* do it if it's hardware supports
64-bit dma, and platform *should* either fail this call, or ensure that
64-bit addresses can be dma_map()ed successfully.

So what we have on arm64 is - drivers that follow documented procedure
fail, drivers that don't follow it work, That's nonsense.

> If we make it
> simply not work, then your suggestion of making dma_set_mask()
> fail will break your system in a different way.

Proper fix should fix *both* architecture and NVMe.

- architecture should stop breaking 64-bit DMA when driver attempts to
set 64-bit dma mask,

- NVMe should issue proper blk_queue_bounce_limit() call based on what
is actually set mask,

- and blk_queue_bounce_limit() should also be fixed to actually set
0xffffffff limit, instead of replacing it with (max_low_pfn <<
PAGE_SHIFT) as it does now.


>> Still current code does not work, thus fix is needed.
>>
>> Perhaps need to introduce some generic API to "allocate memory best
>> suited for DMA to particular device", and fix allocation points (in
>> drivers, filesystems, etc) to use it. Such an API could try to allocate
>> area that can be DMAed by hardware, and fallback to other memory that
>> can be used via swiotlb or other bounce buffer implementation.
> 
> The DMA mapping API is meant to do this, but we can definitely improve
> it or clarify some of the rules.

DMA mapping API can't help here, it's about mapping, not about allocation.

What I mean is some API to allocate memory for use with streaming DMA in
such way that bounce buffers won't be needed. There are many cases when
at buffer allocation time, it is already known that buffer will be used
for DMA with particular device. Bounce buffers will still be needed
cases when no such information is available at allocation time, or when
there is no directly-DMAable memory available at allocation time.

>> But for now, have to stay with dma masks. Will follow-up with a patch
>> based on your but with coherent mask handling added.
> 
> Ok.

Already posted. Can we have that merged? At least it will make things to
stop breaking memory and start working.

Nikita

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
