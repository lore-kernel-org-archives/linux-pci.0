Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60975 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752103AbbLNRUT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 14 Dec 2015 12:20:19 -0500
Date: Mon, 14 Dec 2015 19:20:14 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Alexander Duyck <aduyck@mirantis.com>, kvm@vger.kernel.org,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	x86@kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	qemu-devel@nongnu.org, Lan Tianyu <tianyu.lan@intel.com>,
	Yang Zhang <yang.zhang.wz@gmail.com>, konrad.wilk@oracle.com,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Alexander Graf <agraf@suse.de>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [RFC PATCH 3/3] x86: Create dma_mark_dirty to dirty pages used
 for DMA by VM guest
Message-ID: <20151214191303-mutt-send-email-mst@redhat.com>
References: <20151213212557.5410.48577.stgit@localhost.localdomain>
 <20151213212831.5410.84365.stgit@localhost.localdomain>
 <20151214113016-mutt-send-email-mst@redhat.com>
 <CAKgT0UdtY5stCPVA=-NoM+1C8Z3b+VXLL1OdrNth=dxvz0A9sQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKgT0UdtY5stCPVA=-NoM+1C8Z3b+VXLL1OdrNth=dxvz0A9sQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 14, 2015 at 08:34:00AM -0800, Alexander Duyck wrote:
> > This way distro can use a guest agent to disable
> > dirtying until before migration starts.
> 
> Right.  For a v2 version I would definitely want to have some way to
> limit the scope of this.  My main reason for putting this out here is
> to start altering the course of discussions since it seems like were
> weren't getting anywhere with the ixgbevf migration changes that were
> being proposed.

Absolutely, thanks for working on this.

> >> +     unsigned long pg_addr, start;
> >> +
> >> +     start = (unsigned long)addr;
> >> +     pg_addr = PAGE_ALIGN(start + size);
> >> +     start &= ~(sizeof(atomic_t) - 1);
> >> +
> >> +     /* trigger a write fault on each page, excluding first page */
> >> +     while ((pg_addr -= PAGE_SIZE) > start)
> >> +             atomic_add(0, (atomic_t *)pg_addr);
> >> +
> >> +     /* trigger a write fault on first word of DMA */
> >> +     atomic_add(0, (atomic_t *)start);
> >
> > start might not be aligned correctly for a cast to atomic_t.
> > It's harmless to do this for any memory, so I think you should
> > just do this for 1st byte of all pages including the first one.
> 
> You may not have noticed it but I actually aligned start in the line
> after pg_addr.

Yes you did. alignof would make it a bit more noticeable.

>  However instead of aligning to the start of the next
> atomic_t I just masked off the lower bits so that we start at the
> DWORD that contains the first byte of the starting address.  The
> assumption here is that I cannot trigger any sort of fault since if I
> have access to a given byte within a DWORD I will have access to the
> entire DWORD.

I'm curious where does this come from.  Isn't it true that access is
controlled at page granularity normally, so you can touch beginning of
page just as well?

>  I coded this up so that the spots where we touch the
> memory should match up with addresses provided by the hardware to
> perform the DMA over the PCI bus.

Yes but there's no requirement to do it like this from
virt POV. You just need to touch each page.

> Also I intentionally ran from highest address to lowest since that way
> we don't risk pushing the first cache line of the DMA buffer out of
> the L1 cache due to the PAGE_SIZE stride.
> 
> - Alex

Interesting. How does order of access help with this?

By the way, if you are into these micro-optimizations you might want to
limit prefetch, to this end you want to access the last line of the
page.  And it's probably worth benchmarking a bit and not doing it all just
based on theory, keep code simple in v1 otherwise.

-- 
MST
