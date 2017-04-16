Return-Path: <SRS0=kBs1=3Y=kernel.crashing.org=benh@kernel.org>
Return-Path: <SRS0=kBs1=3Y=kernel.crashing.org=benh@kernel.org>
Message-ID: <1492381396.25766.43.camel@kernel.crashing.org>
Subject: Re: [RFC 0/8] Copy Offload with Peer-to-Peer PCI Memory
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe
	 <logang@deltatee.com>
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
Date: Mon, 17 Apr 2017 08:23:16 +1000
In-Reply-To: <CAPcyv4it56J8Voo6kV0bBcO3nHsOHYLENpAtONJZTGceDDwNPg@mail.gmail.com>
References: 
	<CAPcyv4it56J8Voo6kV0bBcO3nHsOHYLENpAtONJZTGceDDwNPg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Sun, 2017-04-16 at 08:44 -0700, Dan Williams wrote:
> The difference is that there was nothing fundamental in the core
> design of pmem + DAX that prevented other archs from growing pmem
> support.

Indeed. In fact we have work in progress support for pmem on power
using experimental HW.

> THP and memory hotplug existed on other architectures and
> they just need to plug in their arch-specific enabling. p2p support
> needs the same starting point of something more than one architecture
> can plug into, and handling the bus address offset case needs to be
> incorporated into the design.
> 
> pmem + dax did not change the meaning of what a dma_addr_t is, p2p does.

The more I think about it, the more I tend toward something along the
lines of having the arch DMA ops being able to quickly differentiate
between "normal" memory (which includes non-PCI pmem in some cases,
it's an architecture choice I suppose) and "special device" (page flag
? pfn bit ? ... there are options).

>From there, we keep our existing fast path for the normal case.

For the special case, we need to provide a fast lookup mechanism
(assuming we can't stash enough stuff in struct page or the pfn)
to get back to a struct of some sort that provides the necessary
information to resolve the translation.

This *could* be something like a struct p2mem device that carries
a special set of DMA ops, though we probably shouldn't make the generic
structure PCI specific.

This is a slightly slower path, but that "stub" structure allows the
special DMA ops to provide the necessary bus-specific knowledge, which
for PCI for example, can check whether the devices are on the same
segment, whether the switches are configured to allow p2p, etc...

What form should that fast lookup take ? It's not completely clear to
me at that point. We could start with a simple linear lookup I suppose
and improve in a second stage.

Of course this pipes into the old discussion about disconnecting
the DMA ops from struct page. If we keep struct page, any device that
wants to be a potential DMA target will need to do something "special"
to create those struct pages etc.. though we could make that a simple
pci helper that pops the necessary bits and pieces for a given BAR &
range.

If we don't need struct page, then it might be possible to hide it all
in the PCI infrastructure.

> > Virtualization specifically would be a _lot_ more difficult than simply
> > supporting offsets. The actual topology of the bus will probably be lost
> > on the guest OS and it would therefor have a difficult time figuring out
> > when it's acceptable to use p2pmem. I also have a difficult time seeing
> > a use case for it and thus I have a hard time with the argument that we
> > can't support use cases that do want it because use cases that don't
> > want it (perhaps yet) won't work.
> > 
> > > This is an interesting experiement to look at I suppose, but if you
> > > ever want this upstream I would like at least for you to develop a
> > > strategy to support the wider case, if not an actual implementation.
> > 
> > I think there are plenty of avenues forward to support offsets, etc.
> > It's just work. Nothing we'd be proposing would be incompatible with it.
> > We just don't want to have to do it all upfront especially when no one
> > really knows how well various architecture's hardware supports this or
> > if anyone even wants to run it on systems such as those. (Keep in mind
> > this is a pretty specific optimization that mostly helps systems
> > designed in specific ways -- not a general "everybody gets faster" type
> > situation.) Get the cases working we know will work, can easily support
> > and people actually want.  Then expand it to support others as people
> > come around with hardware to test and use cases for it.
> 
> I think you need to give other archs a chance to support this with a
> design that considers the offset case as a first class citizen rather
> than an afterthought.

Thanks :-) There's a reason why I'm insisting on this. We have constant
requests for this today. We have hacks in the GPU drivers to do it for
GPUs behind a switch, but those are just that, ad-hoc hacks in the
drivers. We have similar grossness around the corner with some CAPI
NICs trying to DMA to GPUs. I have people trying to use PLX DMA engines
to whack nVME devices.

I'm very interested in a more generic solution to deal with the problem
of P2P between devices. I'm happy to contribute with code to handle the
powerpc bits but we need to agree on the design first :)

Cheers,
Ben.
