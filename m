Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 10 Jan 2017 08:07:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: Re: NVMe vs DMA addressing limitations
Message-ID: <20170110070719.GA17208@lst.de>
References: <1483044304-2085-1-git-send-email-nikita.yoush@cogentembedded.com>
 <2723285.JORgusvJv4@wuerfel>
 <9a03c05d-ad4c-0547-d1fe-01edb8b082d6@cogentembedded.com>
 <6374144.HVL0QxNJiT@wuerfel>
 <b50e25af-3936-d22d-2e9b-5bf6be19c800@cogentembedded.com>
 <20170109205746.GA6274@lst.de>
 <e084dbad-29ab-25bd-5e17-da0fcd92f7ac@cogentembedded.com>
MIME-Version: 1.0
In-Reply-To: <e084dbad-29ab-25bd-5e17-da0fcd92f7ac@cogentembedded.com>
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
 linux-nvme@lists.infradead.org, Arnd Bergmann <arnd@linaro.org>,
 linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 artemi.ivanov@cogentembedded.com, Christoph Hellwig <hch@lst.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 10, 2017 at 09:47:21AM +0300, Nikita Yushchenko wrote:
> I'm now working with HW that:
> - is now way "low end" or "obsolete", it has 4G of RAM and 8 CPU cores,
> and is being manufactured and developed,
> - has 75% of it's RAM located beyond first 4G of address space,
> - can't physically handle incoming PCIe transactions addressed to memory
> beyond 4G.

It might not be low end or obselete, but it's absolutely braindead.
Your I/O performance will suffer badly for the life of the platform
because someone tries to save 2 cents, and there is not much we can do
about it.

> (1) it constantly runs of swiotlb space, logs are full of warnings
> despite of rate limiting,

> Per my current understanding, blk-level bounce buffering will at least
> help with (1) - if done properly it will allocate bounce buffers within
> entire memory below 4G, not within dedicated swiotlb space (that is
> small and enlarging it makes memory permanently unavailable for other
> use).  This looks simple and safe (in sense of not anyhow breaking
> unrelated use cases).

Yes.  Although there is absolutely no reason why swiotlb could not
do the same.

> (2) it runs far suboptimal due to bounce-buffering almost all i/o,
> despite of lots of free memory in area where direct DMA is possible.

> Addressing (2) looks much more difficult because different memory
> allocation policy is required for that.

It's basically not possible.  Every piece of memory in a Linux
kernel is a possible source of I/O, and depending on the workload
type it might even be a the prime source of I/O.

> > NVMe should never bounce, the fact that it currently possibly does
> > for highmem pages is a bug.
> 
> The entire topic is absolutely not related to highmem (i.e. memory not
> directly addressable by 32-bit kernel).

I did not say this affects you, but thanks to your mail I noticed that
NVMe has a suboptimal setting there.  Also note that highmem does not
have to imply a 32-bit kernel, just physical memory that is not in the
kernel mapping.

> What we are discussing is hw-originated restriction on where DMA is
> possible.

Yes, where hw means the SOC, and not the actual I/O device, which is an
important distinction.

> > Or even better remove the call to dma_set_mask_and_coherent with
> > DMA_BIT_MASK(32).  NVMe is designed around having proper 64-bit DMA
> > addressing, there is not point in trying to pretent it works without that
> 
> Are you claiming that NVMe driver in mainline is intentionally designed
> to not work on HW that can't do DMA to entire 64-bit space?

It is not intenteded to handle the case where the SOC / chipset
can't handle DMA to all physical memoery, yes.

> Such setups do exist and there is interest to make them working.

Sure, but it's not the job of the NVMe driver to work around such a broken
system.  It's something your architecture code needs to do, maybe with
a bit of core kernel support.

> Quite a few pages used for block I/O are allocated by filemap code - and
> at allocation point it is known what inode page is being allocated for.
> If this inode is from filesystem located on a known device with known
> DMA limitations, this knowledge can be used to allocate page that can be
> DMAed directly.

But in other cases we might never DMA to it.  Or we rarely DMA to it, say
for a machine running databses or qemu and using lots of direct I/O. Or
a storage target using it's local alloc_pages buffers.

> Sure there are lots of cases when at allocation time there is no idea
> what device will run DMA on page being allocated, or perhaps page is
> going to be shared, or whatever. Such cases unavoidably require bounce
> buffers if page ends to be used with device with DMA limitations. But
> still there are cases when better allocation can remove need for bounce
> buffers - without any hurt for other cases.

It takes your max 1GB DMA addressable memoery away from other uses,
and introduce the crazy highmem VM tuning issues we had with big
32-bit x86 systems in the past.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
