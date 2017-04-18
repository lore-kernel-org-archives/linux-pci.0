Return-Path: <SRS0=HVeC=32=deltatee.com=logang@kernel.org>
Return-Path: <SRS0=HVeC=32=deltatee.com=logang@kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Dan Williams <dan.j.williams@intel.com>
References: <CAPcyv4it56J8Voo6kV0bBcO3nHsOHYLENpAtONJZTGceDDwNPg@mail.gmail.com>
 <6e732d6a-9baf-1768-3e9c-f6c887a836b2@deltatee.com>
 <1492381958.25766.50.camel@kernel.crashing.org>
 <6149ab5e-c981-6881-8c5a-22349561c3e8@deltatee.com>
 <1492413640.25766.52.camel@kernel.crashing.org>
 <ac643c73-43e9-1658-ffcb-d5628f80cbc1@deltatee.com>
 <1492463497.25766.55.camel@kernel.crashing.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
 Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Jens Axboe <axboe@kernel.dk>, Steve Wise <swise@opengridcomputing.com>,
 Stephen Bates <sbates@raithlin.com>, Max Gurtovoy <maxg@mellanox.com>,
 Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
 linux-scsi <linux-scsi@vger.kernel.org>, linux-nvme@lists.infradead.org,
 linux-rdma@vger.kernel.org, linux-nvdimm <linux-nvdimm@ml01.01.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jerome Glisse <jglisse@redhat.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <e5645535-8da0-6965-1d5f-ed43ab634600@deltatee.com>
Date: Mon, 17 Apr 2017 23:43:24 -0600
MIME-Version: 1.0
In-Reply-To: <1492463497.25766.55.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
Subject: Re: [RFC 0/8] Copy Offload with Peer-to-Peer PCI Memory
List-ID: <linux-pci.vger.kernel.org>



On 17/04/17 03:11 PM, Benjamin Herrenschmidt wrote:
> Is it ? Again, you create a "concept" the user may have no idea about,
> "p2pmem memory". So now any kind of memory buffer on a device can could
> be use for p2p but also potentially a bunch of other things becomes
> special and called "p2pmem" ...

The user is going to have to have an idea about it if they are designing
systems to make use of it. I've said it before many times: this is an
optimization with significant trade-offs so the user does have to make
decisions regarding when to enable it.


> But what do you have in p2pmem that somebody benefits from. Again I
> don't understand what that "p2pmem" device buys you in term of
> functionality vs. having the device just instanciate the pages.

Well thanks for just taking a big shit on all of our work without even
reading the patches. Bravo.

> Now having some kind of way to override the dma_ops, yes I do get that,
> and it could be that this "p2pmem" is typically the way to do it, but
> at the moment you don't even have that. So I'm a bit at a loss here.

Yes, we've already said many times that this is something we will need
to add.

> But it doesn't *have* to be. Again, take my GPU example. The fact that
> a NIC might be able to DMA into it doesn't make it specifically "p2p
> memory".

Just because you use it for other things doesn't mean it can't also
provide the service of a "p2pmem" device.

> So now your "p2pmem" device needs to also be laid out on top of those
> MMIO registers ? It's becoming weird.

Yes, Max Gurtovoy has also expressed an interest in expanding this work
to cover things other than memory. He's suggested simply calling it a
p2p device, but until we figure out what exactly that all means we can't
really finalize a name.

> See, basically, doing peer 2 peer between devices has 3 main challenges
> today: The DMA API needing struct pages, the MMIO translation issues
> and the IOMMU translation issues.
> 
> You seem to create that added device as some kind of "owner" for the
> struct pages, solving #1, but leave #2 and #3 alone.

Well there are other challenges too. Like figuring out when it's
appropriate to use, tying together the device that provides the memory
with the driver tring to use it in DMA transactions, etc, etc. Our patch
set tackles these latter issues.

> If we go down that path, though, rather than calling it p2pmem I would
> call it something like dma_target which I find much clearer especially
> since it doesn't have to be just memory.

I'm not set on the name. My arguments have been specifically for the
existence of an independent struct device. But I'm not really interested
in getting into bike shedding arguments over what to call it at this
time when we don't even really know what it's going to end up doing in
the end.

> The memory allocation should be a completely orthogonal and separate
> thing yes. You are conflating two completely different things now into
> a single concept.

Well we need a uniform way for a driver trying to coordinate a p2p dma
to find and obtain memory from devices that supply it. We are not
dealing with GPUs that already have complicated allocators. We are
dealing with people adding memory to their devices for the _sole_
purpose of enabling p2p transfers. So having a common allocation setup
is seen as a benefit to us.

Logan
