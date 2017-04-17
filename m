Return-Path: <SRS0=P6S7=3Z=kernel.crashing.org=benh@kernel.org>
Return-Path: <SRS0=P6S7=3Z=kernel.crashing.org=benh@kernel.org>
Message-ID: <1492463497.25766.55.camel@kernel.crashing.org>
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
Date: Tue, 18 Apr 2017 07:11:37 +1000
In-Reply-To: <ac643c73-43e9-1658-ffcb-d5628f80cbc1@deltatee.com>
References: 
	<CAPcyv4it56J8Voo6kV0bBcO3nHsOHYLENpAtONJZTGceDDwNPg@mail.gmail.com>
	 <6e732d6a-9baf-1768-3e9c-f6c887a836b2@deltatee.com>
	 <1492381958.25766.50.camel@kernel.crashing.org>
	 <6149ab5e-c981-6881-8c5a-22349561c3e8@deltatee.com>
	 <1492413640.25766.52.camel@kernel.crashing.org>
	 <ac643c73-43e9-1658-ffcb-d5628f80cbc1@deltatee.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2017-04-17 at 10:52 -0600, Logan Gunthorpe wrote:
> 
> On 17/04/17 01:20 AM, Benjamin Herrenschmidt wrote:
> > But is it ? For example take a GPU, does it, in your scheme, need an
> > additional "p2pmem" child ? Why can't the GPU driver just use some
> > helper to instantiate the necessary struct pages ? What does having an
> > actual "struct device" child buys you ?
> 
> Yes, in this scheme, it needs an additional p2pmem child. Why is that an
> issue? It certainly makes it a lot easier for the user to understand the
> p2pmem memory in the system (through the sysfs tree) and reason about
> the topology and when to use it. This is important.

Is it ? Again, you create a "concept" the user may have no idea about,
"p2pmem memory". So now any kind of memory buffer on a device can could
be use for p2p but also potentially a bunch of other things becomes
special and called "p2pmem" ...

> > > 2) In order to create the struct pages we use the ZONE_DEVICE
> > > infrastructure which requires a struct device. (See
> > > devm_memremap_pages.)
> > 
> > Yup, but you already have one in the actual pci_dev ... What is the
> > benefit of adding a second one ?
> 
> But that would tie all of this very tightly to be pci only and may get
> hard to differentiate if more users of ZONE_DEVICE crop up who happen to
> be using a pci device.

But what do you have in p2pmem that somebody benefits from. Again I
don't understand what that "p2pmem" device buys you in term of
functionality vs. having the device just instanciate the pages.

Now having some kind of way to override the dma_ops, yes I do get that,
and it could be that this "p2pmem" is typically the way to do it, but
at the moment you don't even have that. So I'm a bit at a loss here.
 
>  Having a specific class for this makes it very
> clear how this memory would be handled.

But it doesn't *have* to be. Again, take my GPU example. The fact that
a NIC might be able to DMA into it doesn't make it specifically "p2p
memory".

Essentially you are saying that any device that happens to have a piece
of mappable "memory" (or something that behaves like it) and can be
DMA'ed into should now have that "p2pmem" thing attached to it.

Now take an example where that becomes really awkward (it's also a real
example of something people want to do). I have a NIC and a GPU, the
NIC DMA's data to/from the GPU, but they also want to poke at each
other doorbell, the GPU to kick the NIC into action when data is ready
to send, the NIC to poke the GPU when data has been received.

Those doorbells are MMIO registers.

So now your "p2pmem" device needs to also be laid out on top of those
MMIO registers ? It's becoming weird.

See, basically, doing peer 2 peer between devices has 3 main challenges
today: The DMA API needing struct pages, the MMIO translation issues
and the IOMMU translation issues.

You seem to create that added device as some kind of "owner" for the
struct pages, solving #1, but leave #2 and #3 alone.

Now, as I said, it could very well be that having the devmap pointer
point to some specific device-type with a well known structure to
provide solutions for #2 and #3 such as dma_ops overrides, is indeed
the right way to solve these problems.

If we go down that path, though, rather than calling it p2pmem I would
call it something like dma_target which I find much clearer especially
since it doesn't have to be just memory.

For the sole case of creating struct page's however, I fail to see the
point.

>  For example, although I haven't
> looked into it, this could very well be a point of conflict with HMM. If
> they were to use the pci device to populate the dev_pagemap then we
> couldn't also use the pci device. I feel it's much better for users of
> dev_pagemap to have their struct devices they own to avoid such conflicts.

If we are going to create some sort of struct dma_target, HMM could
potentially just look for the parent if it needs the PCI device.

> > >  This amazingly gets us the get_dev_pagemap
> > > architecture which also uses a struct device. So by using a p2pmem
> > > device we can go from struct page to struct device to p2pmem device
> > > quickly and effortlessly.
> > 
> > Which isn't terribly useful in itself right ? What you care about is
> > the "enclosing" pci_dev no ? Or am I missing something ?
> 
> Sure it is. What if we want to someday support p2pmem that's on another bus?

But why not directly use that other bus' device in that case ?

> > > 3) You wouldn't want to use the pci's struct device because it doesn't
> > > really describe what's going on. For example, there may be multiple
> > > devices on the pci device in question: eg. an NVME card and some p2pmem.
> > 
> > What is "some p2pmem" ?
> > > Or it could be a NIC with some p2pmem.
> > 
> > Again what is "some p2pmem" ?
> 
> Some device local memory intended for use as a DMA target from a
> neighbour device or itself. On a PCI device, this would be a BAR, or a
> portion of a BAR with memory behind it.

So back to my base objections:

 - There is no reason why this has to just be memory. There are good
reasons to want to do peer DMA to MMIO registers (see above)

 - There is no reason why that memory on a device is specifically
dedicated to "peer to peer" and thus calling it "p2pmem" is something
I find actually confusing.

> Keep in mind device classes tend to carve out common use cases and don't
> have a one to one mapping with a physical pci card.
> 
> > That a device might have some memory-like buffer space is all well and
> > good but does it need to be specifically distinguished at the device
> > level ? It could be inherent to what the device is... for example again
> > take the GPU example, why would you call the FB memory "p2pmem" ? 
> 
> Well if you are using it for p2p transactions why wouldn't you call it
> p2pmem?

Im not only using it for that :)

>  There's no technical downside here except some vague argument
> over naming. Once registered as p2pmem, that device will handle all the
> dma map stuff for you and have a central obvious place to put code which
> helps decide whether to use it or not based on topology.

Except it doesn't handle any of the dma_map stuff today as far as I can
see.

> I can certainly see an issue you'd have with the current RFC in that the
> p2pmem device currently also handles memory allocation which a GPU would
>  want to do itself.

The memory allocation should be a completely orthogonal and separate
thing yes. You are conflating two completely different things now into
a single concept.

>  There are plenty of solutions to this though: we
> could provide hooks for the parent device to override allocation or
> something like that. However, the use cases I'm concerned with don't do
> their own allocation so that is an important feature for them.

No, the allocation should not even have links to the DMA peering
mechanism. This is completely orthogonal.

I feel more and more like your entire infrastructure is designed for a
special use case and conflates several problems of that specific use
case into one single "solution" rather than separating the various
problems and solving them independently.

> > Again I'm not sure why it needs to "instanciate a p2pmem" device. Maybe
> > it's the term "p2pmem" that offputs me. If p2pmem allowed to have a
> > standard way to lookup the various offsets etc... I mentioned earlier,
> > then yes, it would make sense to have it as a staging point. As-is, I
> > don't know. 
> 
> Well of course, at some point it would have a standard way to lookup
> offsets and figure out what's necessary for a mapping. We wouldn't make
> that separate from this, that would make no sense.
> 
> I also forgot:
> 
> 4) We need someway in the kernel to configure drivers that use p2pmem.
> That means it needs a unique name that the user can understand, lookup
> and pass to other drivers. Then a way for those drivers to find it in
> the system. A specific device class gets that for us in a very simple
> fashion. We also don't want to have drivers like nvmet having to walk
> every pci device to figure out where the p2p memory is and whether it
> can use it.
> 
> IMO there are many clear benefits here and you haven't really offered an
> alternative that provides the same features and potential for future use
> cases.
> 
> Logan
