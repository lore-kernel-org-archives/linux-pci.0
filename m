Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:35411 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932453AbbLNWc6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 14 Dec 2015 17:32:58 -0500
MIME-Version: 1.0
In-Reply-To: <20151214221919-mutt-send-email-mst@redhat.com>
References: <20151213212557.5410.48577.stgit@localhost.localdomain>
	<20151213212831.5410.84365.stgit@localhost.localdomain>
	<20151214113016-mutt-send-email-mst@redhat.com>
	<CAKgT0UdtY5stCPVA=-NoM+1C8Z3b+VXLL1OdrNth=dxvz0A9sQ@mail.gmail.com>
	<20151214191303-mutt-send-email-mst@redhat.com>
	<CAKgT0Uem+7p9mJDq117XAHktSdeZaWFpyMtbhj87g=XvG0vE-g@mail.gmail.com>
	<20151214221919-mutt-send-email-mst@redhat.com>
Date: Mon, 14 Dec 2015 14:32:57 -0800
Message-ID: <CAKgT0Ufquy9n7vra9SJ6DrU=onv0tMiipsMrvMGnUUAiZXn8-g@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] x86: Create dma_mark_dirty to dirty pages used
 for DMA by VM guest
From: Alexander Duyck <alexander.duyck@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alexander Duyck <aduyck@mirantis.com>, kvm@vger.kernel.org,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	x86@kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	qemu-devel@nongnu.org, Lan Tianyu <tianyu.lan@intel.com>,
	Yang Zhang <yang.zhang.wz@gmail.com>, konrad.wilk@oracle.com,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Alexander Graf <agraf@suse.de>,
	Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 14, 2015 at 12:52 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Mon, Dec 14, 2015 at 09:59:13AM -0800, Alexander Duyck wrote:
>> On Mon, Dec 14, 2015 at 9:20 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
>> > On Mon, Dec 14, 2015 at 08:34:00AM -0800, Alexander Duyck wrote:
>> >> > This way distro can use a guest agent to disable
>> >> > dirtying until before migration starts.
>> >>
>> >> Right.  For a v2 version I would definitely want to have some way to
>> >> limit the scope of this.  My main reason for putting this out here is
>> >> to start altering the course of discussions since it seems like were
>> >> weren't getting anywhere with the ixgbevf migration changes that were
>> >> being proposed.
>> >
>> > Absolutely, thanks for working on this.
>> >
>> >> >> +     unsigned long pg_addr, start;
>> >> >> +
>> >> >> +     start = (unsigned long)addr;
>> >> >> +     pg_addr = PAGE_ALIGN(start + size);
>> >> >> +     start &= ~(sizeof(atomic_t) - 1);
>> >> >> +
>> >> >> +     /* trigger a write fault on each page, excluding first page */
>> >> >> +     while ((pg_addr -= PAGE_SIZE) > start)
>> >> >> +             atomic_add(0, (atomic_t *)pg_addr);
>> >> >> +
>> >> >> +     /* trigger a write fault on first word of DMA */
>> >> >> +     atomic_add(0, (atomic_t *)start);
>
> Actually, I have second thoughts about using atomic_add here,
> especially for _sync.
>
> Many architectures do
>
> #define ATOMIC_OP_RETURN(op, c_op)                                      \
> static inline int atomic_##op##_return(int i, atomic_t *v)              \
> {                                                                       \
>         unsigned long flags;                                            \
>         int ret;                                                        \
>                                                                         \
>         raw_local_irq_save(flags);                                      \
>         ret = (v->counter = v->counter c_op i);                         \
>         raw_local_irq_restore(flags);                                   \
>                                                                         \
>         return ret;                                                     \
> }
>
> and this is not safe if device is still doing DMA to/from
> this memory.
>
> Generally, atomic_t is there for SMP effects, not for sync
> with devices.
>
> This is why I said you should do
>         cmpxchg(pg_addr, 0xdead, 0xdead);
>
> Yes, we probably never actually want to run m68k within a VM,
> but let's not misuse interfaces like this.

Right now this implementation is for x86 only.  Any other architecture
currently reports dma_mark_dirty as an empty inline function.  The
reason why I chose the atomic_add for x86 is simply because it is
guaranteed dirty the cache line with relatively few instructions and
operands as all I have to have is the pointer and 0.

For the m68k we could implement it as a cmpxchg instead.  The general
thought here is that each architecture is probably going to have to do
it a little bit differently.

>> >> >
>> >> > start might not be aligned correctly for a cast to atomic_t.
>> >> > It's harmless to do this for any memory, so I think you should
>> >> > just do this for 1st byte of all pages including the first one.
>> >>
>> >> You may not have noticed it but I actually aligned start in the line
>> >> after pg_addr.
>> >
>> > Yes you did. alignof would make it a bit more noticeable.
>> >
>> >>  However instead of aligning to the start of the next
>> >> atomic_t I just masked off the lower bits so that we start at the
>> >> DWORD that contains the first byte of the starting address.  The
>> >> assumption here is that I cannot trigger any sort of fault since if I
>> >> have access to a given byte within a DWORD I will have access to the
>> >> entire DWORD.
>> >
>> > I'm curious where does this come from.  Isn't it true that access is
>> > controlled at page granularity normally, so you can touch beginning of
>> > page just as well?
>>
>> Yeah, I am pretty sure it probably is page granularity.  However my
>> thought was to try and stick to the start of the DMA as the last
>> access.  That way we don't pull in any more cache lines than we need
>> to in order to dirty the pages.  Usually the start of the DMA region
>> will contain some sort of headers or something that needs to be
>> accessed with the highest priority so I wanted to make certain that we
>> were forcing usable data into the L1 cache rather than just the first
>> cache line of the page where the DMA started.  If however the start of
>> a DMA was the start of the page there is nothing there to prevent
>> that.
>
> OK, maybe this helps. You should document all these tricks
> in code comments.

I'll try to get that taken care of for v2.

>> >>  I coded this up so that the spots where we touch the
>> >> memory should match up with addresses provided by the hardware to
>> >> perform the DMA over the PCI bus.
>> >
>> > Yes but there's no requirement to do it like this from
>> > virt POV. You just need to touch each page.
>>
>> I know, but at the same time if we match up with the DMA then it is
>> more likely that we avoid grabbing unneeded cache lines.  In the case
>> of most drivers the data for headers and start is at the start of the
>> DMA.  So if we dirty the cache line associated with the start of the
>> DMA it will be pulled into the L1 cache and there is a greater chance
>> that it may already be prefetched as well.
>>
>> >> Also I intentionally ran from highest address to lowest since that way
>> >> we don't risk pushing the first cache line of the DMA buffer out of
>> >> the L1 cache due to the PAGE_SIZE stride.
>> >
>> > Interesting. How does order of access help with this?
>>
>> If you use a PAGE_SIZE stride you will start evicting things from L1
>> cache after something like 8 accesses on an x86 processor as most of
>> the recent ones have a 32K 8 way associative L1 cache.  So if I go
>> from back to front then I evict the stuff that would likely be in the
>> data portion of a buffer instead of headers which are usually located
>> at the front.
>
> I see, interesting.
>
>> > By the way, if you are into these micro-optimizations you might want to
>> > limit prefetch, to this end you want to access the last line of the
>> > page.  And it's probably worth benchmarking a bit and not doing it all just
>> > based on theory, keep code simple in v1 otherwise.
>>
>> My main goal for now is functional code over high performance code.
>> That is why I have kept this code fairly simple.  I might have done
>> some optimization but it was as much about the optimization as keeping
>> the code simple.
>
> Well you were trying to avoid putting extra stress on
> the cache, and it seems clear to me that prefetch
> is not your friend here. So
> -             atomic_add(0, (atomic_t *)pg_addr);
> +             atomic_add(0, (atomic_t *)(pg_addr + PAGE_SIZE - sizeof(atomic_t));
> (or whatever we change atomic_t to) is probably a win.

What is the advantage to writing to the last field in the page versus
the first?  I think that is the part I am not getting.

>>  For example by using the start of the page instead
>> of the end I could easily do the comparison against start and avoid
>> doing more than one write per page.
>
> That's probably worth fixing, we don't want two atomics
> if we can help it.
>
> -     while ((pg_addr -= PAGE_SIZE) > start)
> +     while ((pg_addr -= PAGE_SIZE) >= PAGE_ALIGN(start + PAGE_SIZE))
>
> will do it with no fuss.

I'm still not seeing what the gain here is.  It just seems like it is
making things more complicated.

The main goal of keeping things inside the DMA is to keep us from
doing too much cache bouncing.  Us reaching out and dirtying cache
lines that we aren't actually using seems to be really wasteful.  If
for example a page was split between two CPUs with one doing DMA on
one half, and one doing DMA on another I wouldn't want to have both
devices dirtying the same cache line, I would rather have them each
marking a separate cache line in order to avoid cache thrash.  By
having the start aligned with the start of the DMA, and all of the
other entries aligned with the start of pages contained within the DMA
we can avoid that since devices are generally working with at least
cache aligned buffers.

- Alex
