Return-Path: <SRS0=bLgn=32=kernel.crashing.org=benh@kernel.org>
Return-Path: <SRS0=bLgn=32=kernel.crashing.org=benh@kernel.org>
Message-ID: <1492496998.25766.84.camel@kernel.crashing.org>
Subject: Re: [RFC 0/8] Copy Offload with Peer-to-Peer PCI Memory
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Logan Gunthorpe <logang@deltatee.com>,
        Dan Williams
	 <dan.j.williams@intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
        Jason Gunthorpe
 <jgunthorpe@obsidianresearch.com>,
        Christoph Hellwig <hch@lst.de>, Sagi
 Grimberg <sagi@grimberg.me>,
        "James E.J. Bottomley"
 <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen"
 <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Steve Wise
 <swise@opengridcomputing.com>,
        Stephen Bates <sbates@raithlin.com>, Max
 Gurtovoy <maxg@mellanox.com>,
        Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm
 <linux-nvdimm@ml01.01.org>,
        "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>,
        Jerome Glisse <jglisse@redhat.com>
Date: Tue, 18 Apr 2017 16:29:58 +1000
In-Reply-To: <e5645535-8da0-6965-1d5f-ed43ab634600@deltatee.com>
References: 
	<CAPcyv4it56J8Voo6kV0bBcO3nHsOHYLENpAtONJZTGceDDwNPg@mail.gmail.com>
	 <6e732d6a-9baf-1768-3e9c-f6c887a836b2@deltatee.com>
	 <1492381958.25766.50.camel@kernel.crashing.org>
	 <6149ab5e-c981-6881-8c5a-22349561c3e8@deltatee.com>
	 <1492413640.25766.52.camel@kernel.crashing.org>
	 <ac643c73-43e9-1658-ffcb-d5628f80cbc1@deltatee.com>
	 <1492463497.25766.55.camel@kernel.crashing.org>
	 <e5645535-8da0-6965-1d5f-ed43ab634600@deltatee.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2017-04-17 at 23:43 -0600, Logan Gunthorpe wrote:
> 
> On 17/04/17 03:11 PM, Benjamin Herrenschmidt wrote:
> > Is it ? Again, you create a "concept" the user may have no idea about,
> > "p2pmem memory". So now any kind of memory buffer on a device can could
> > be use for p2p but also potentially a bunch of other things becomes
> > special and called "p2pmem" ...
> 
> The user is going to have to have an idea about it if they are designing
> systems to make use of it. I've said it before many times: this is an
> optimization with significant trade-offs so the user does have to make
> decisions regarding when to enable it.

Not necessarily. There are many cases where the "end user" won't have
any idea. In any case, I think we bring the story down to those two
points of conflating the allocator with the peer to peer DMA, and the
lack of generality in the approach to solve the peer to peer DMA
problem.

> > But what do you have in p2pmem that somebody benefits from. Again I
> > don't understand what that "p2pmem" device buys you in term of
> > functionality vs. having the device just instanciate the pages.
> 
> Well thanks for just taking a big shit on all of our work without even
> reading the patches. Bravo.

Now now now .... calm down. We are being civil here. I'm not shitting
on anything, I'm asking what seems to be a reasonable question in term
of benefits of the approach you have chosen. Using that sort of
language will not get you anywhere. 

> > Now having some kind of way to override the dma_ops, yes I do get that,
> > and it could be that this "p2pmem" is typically the way to do it, but
> > at the moment you don't even have that. So I'm a bit at a loss here.
> 
> Yes, we've already said many times that this is something we will need
> to add.
> 
> > But it doesn't *have* to be. Again, take my GPU example. The fact that
> > a NIC might be able to DMA into it doesn't make it specifically "p2p
> > memory".
> 
> Just because you use it for other things doesn't mean it can't also
> provide the service of a "p2pmem" device.

But there is no such thing as a "p2pmem" device.. that's what I'm
trying to tell you...

As both Jerome and I tried to explain, there are many reason why one
may want to do peer DMA into some device memory, that doesn't make that
memory some kind of "p2pmem". It's trying to stick a generic label onto
something that isn't.

That's why I'm suggesting we disconnect the two aspects. On one hand
the problem of handling p2p DMA, whether the target is some memory,
some MMIO registers, etc...

On the other hand, some generic "utility" that can optionally be used
by drivers to manage a pool of DMA memory in the device, essentially a
simple allocator.

The two things are completely orthogonal.

> > So now your "p2pmem" device needs to also be laid out on top of those
> > MMIO registers ? It's becoming weird.
> 
> Yes, Max Gurtovoy has also expressed an interest in expanding this work
> to cover things other than memory. He's suggested simply calling it a
> p2p device, but until we figure out what exactly that all means we can't
> really finalize a name.

Possibly. In any case, I think it should be separate from the
allocation.

> > See, basically, doing peer 2 peer between devices has 3 main challenges
> > today: The DMA API needing struct pages, the MMIO translation issues
> > and the IOMMU translation issues.
> > 
> > You seem to create that added device as some kind of "owner" for the
> > struct pages, solving #1, but leave #2 and #3 alone.
> 
> Well there are other challenges too. Like figuring out when it's
> appropriate to use, tying together the device that provides the memory
> with the driver tring to use it in DMA transactions, etc, etc. Our patch
> set tackles these latter issues.

But it tries to conflate the allocation, which is basically the fact
that this is some kind of "memory pool" with the problem of doing peer
DMA.

I'm advocating for separating the concepts.

> > If we go down that path, though, rather than calling it p2pmem I would
> > call it something like dma_target which I find much clearer especially
> > since it doesn't have to be just memory.
> 
> I'm not set on the name. My arguments have been specifically for the
> existence of an independent struct device. But I'm not really interested
> in getting into bike shedding arguments over what to call it at this
> time when we don't even really know what it's going to end up doing in
> the end.

It's not bike shedding. It's about taking out the allocator part and
making it clear that this isn't something to lay out on top of a pre-
decided chunk of "memory".

> > The memory allocation should be a completely orthogonal and separate
> > thing yes. You are conflating two completely different things now into
> > a single concept.
> 
> Well we need a uniform way for a driver trying to coordinate a p2p dma
> to find and obtain memory from devices that supply it.

Again, you are bringing everything down to your special case of "p2p
memory". That's where you lose me. This looks like a special case to me
and you are making the centre point of your design.

What we need is:

 - On one hand a way to expose device space (whether it's MMIO
registers, memory, something else ...) to the DMA ops so another device
can do standard dma_map_* to/from it. (Not dma_alloc_* those shouldn't
relate to p2p at all, they are intended for a driver own allocation for
the device it manages). This includes the creation of struct pages and
the mechanism to override/adjust the dma_ops etc.... along with all the
PCI specific gunk to figure out if we are on the same bus or not etc.

 - Some kind of generic utility you can use to manage a pool of
"memory" which seems to be what your special devices use or wantf or
use by peer DMA.

>  We are not
> > dealing with GPUs that already have complicated allocators.> 
We are
> dealing with people adding memory to their devices for the _sole_
> purpose of enabling p2p transfers. So having a common allocation setup
> > i
s seen as a benefit to us.

I'm not disagreeing. I'm saying that it is completely orthogonal to the
solving the the DMA peer issue. I'm simply objecting to conflating the
two.

Cheers,
Ben.

> Logan
> 
