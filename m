Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20151214191303-mutt-send-email-mst@redhat.com>
References: <20151213212557.5410.48577.stgit@localhost.localdomain>
	<20151213212831.5410.84365.stgit@localhost.localdomain>
	<20151214113016-mutt-send-email-mst@redhat.com>
	<CAKgT0UdtY5stCPVA=-NoM+1C8Z3b+VXLL1OdrNth=dxvz0A9sQ@mail.gmail.com>
	<20151214191303-mutt-send-email-mst@redhat.com>
Date: Mon, 14 Dec 2015 09:59:13 -0800
Message-ID: <CAKgT0Uem+7p9mJDq117XAHktSdeZaWFpyMtbhj87g=XvG0vE-g@mail.gmail.com>
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
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 14, 2015 at 9:20 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Mon, Dec 14, 2015 at 08:34:00AM -0800, Alexander Duyck wrote:
>> > This way distro can use a guest agent to disable
>> > dirtying until before migration starts.
>>
>> Right.  For a v2 version I would definitely want to have some way to
>> limit the scope of this.  My main reason for putting this out here is
>> to start altering the course of discussions since it seems like were
>> weren't getting anywhere with the ixgbevf migration changes that were
>> being proposed.
>
> Absolutely, thanks for working on this.
>
>> >> +     unsigned long pg_addr, start;
>> >> +
>> >> +     start = (unsigned long)addr;
>> >> +     pg_addr = PAGE_ALIGN(start + size);
>> >> +     start &= ~(sizeof(atomic_t) - 1);
>> >> +
>> >> +     /* trigger a write fault on each page, excluding first page */
>> >> +     while ((pg_addr -= PAGE_SIZE) > start)
>> >> +             atomic_add(0, (atomic_t *)pg_addr);
>> >> +
>> >> +     /* trigger a write fault on first word of DMA */
>> >> +     atomic_add(0, (atomic_t *)start);
>> >
>> > start might not be aligned correctly for a cast to atomic_t.
>> > It's harmless to do this for any memory, so I think you should
>> > just do this for 1st byte of all pages including the first one.
>>
>> You may not have noticed it but I actually aligned start in the line
>> after pg_addr.
>
> Yes you did. alignof would make it a bit more noticeable.
>
>>  However instead of aligning to the start of the next
>> atomic_t I just masked off the lower bits so that we start at the
>> DWORD that contains the first byte of the starting address.  The
>> assumption here is that I cannot trigger any sort of fault since if I
>> have access to a given byte within a DWORD I will have access to the
>> entire DWORD.
>
> I'm curious where does this come from.  Isn't it true that access is
> controlled at page granularity normally, so you can touch beginning of
> page just as well?

Yeah, I am pretty sure it probably is page granularity.  However my
thought was to try and stick to the start of the DMA as the last
access.  That way we don't pull in any more cache lines than we need
to in order to dirty the pages.  Usually the start of the DMA region
will contain some sort of headers or something that needs to be
accessed with the highest priority so I wanted to make certain that we
were forcing usable data into the L1 cache rather than just the first
cache line of the page where the DMA started.  If however the start of
a DMA was the start of the page there is nothing there to prevent
that.

>>  I coded this up so that the spots where we touch the
>> memory should match up with addresses provided by the hardware to
>> perform the DMA over the PCI bus.
>
> Yes but there's no requirement to do it like this from
> virt POV. You just need to touch each page.

I know, but at the same time if we match up with the DMA then it is
more likely that we avoid grabbing unneeded cache lines.  In the case
of most drivers the data for headers and start is at the start of the
DMA.  So if we dirty the cache line associated with the start of the
DMA it will be pulled into the L1 cache and there is a greater chance
that it may already be prefetched as well.

>> Also I intentionally ran from highest address to lowest since that way
>> we don't risk pushing the first cache line of the DMA buffer out of
>> the L1 cache due to the PAGE_SIZE stride.
>
> Interesting. How does order of access help with this?

If you use a PAGE_SIZE stride you will start evicting things from L1
cache after something like 8 accesses on an x86 processor as most of
the recent ones have a 32K 8 way associative L1 cache.  So if I go
from back to front then I evict the stuff that would likely be in the
data portion of a buffer instead of headers which are usually located
at the front.

> By the way, if you are into these micro-optimizations you might want to
> limit prefetch, to this end you want to access the last line of the
> page.  And it's probably worth benchmarking a bit and not doing it all just
> based on theory, keep code simple in v1 otherwise.

My main goal for now is functional code over high performance code.
That is why I have kept this code fairly simple.  I might have done
some optimization but it was as much about the optimization as keeping
the code simple.  For example by using the start of the page instead
of the end I could easily do the comparison against start and avoid
doing more than one write per page.

The issue for me doing performance testing is that I don't have
anything that uses DMA blocks that are actually big enough to make use
of the PAGE_SIZE stride.  That is why the PAGE_SIZE stride portion is
mostly just theoretical.  I just have a few NICs and most of them only
allocate 1 page or so for DMA buffers.  What little benchmarking I
have done with netperf only showed a ~1% CPU penalty for the page
dirtying code.  For setups where we did more with the DMA such as
small packet handling I would expect that value to increase, but I
still wouldn't expect to see a penalty of much more than ~5% most
likely since there are still a number of other items that are calling
atomic operations as well such as the code for releasing pages.

- Alex
