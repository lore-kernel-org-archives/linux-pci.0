Return-Path: <SRS0=hvyY=3X=kernel.crashing.org=benh@kernel.org>
Return-Path: <SRS0=hvyY=3X=kernel.crashing.org=benh@kernel.org>
Message-ID: <1492294628.25766.33.camel@kernel.crashing.org>
Subject: Re: [RFC 0/8] Copy Offload with Peer-to-Peer PCI Memory
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Logan Gunthorpe <logang@deltatee.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        Christoph Hellwig
 <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        "James E.J. Bottomley"
 <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen"
 <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Steve Wise
 <swise@opengridcomputing.com>,
        Stephen Bates <sbates@raithlin.com>, Max
 Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-rdma@vger.kernel.org, linux-nvdimm@ml01.01.org,
        linux-kernel@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>
Date: Sun, 16 Apr 2017 08:17:08 +1000
In-Reply-To: <bff1e503-95a9-e19f-bfd9-0ff962c63a81@deltatee.com>
References: <1490911959-5146-1-git-send-email-logang@deltatee.com>
	 <1491974532.7236.43.camel@kernel.crashing.org>
	 <5ac22496-56ec-025d-f153-140001d2a7f9@deltatee.com>
	 <1492034124.7236.77.camel@kernel.crashing.org>
	 <81888a1e-eb0d-cbbc-dc66-0a09c32e4ea2@deltatee.com>
	 <20170413232631.GB24910@bhelgaas-glaptop.roam.corp.google.com>
	 <20170414041656.GA30694@obsidianresearch.com>
	 <1492169849.25766.3.camel@kernel.crashing.org>
	 <630c1c63-ff17-1116-e069-2b8f93e50fa2@deltatee.com>
	 <20170414190452.GA15679@bhelgaas-glaptop.roam.corp.google.com>
	 <1492207643.25766.18.camel@kernel.crashing.org>
	 <bff1e503-95a9-e19f-bfd9-0ff962c63a81@deltatee.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Sat, 2017-04-15 at 11:41 -0600, Logan Gunthorpe wrote:
> Thanks, Benjamin, for the summary of some of the issues.
> 
> On 14/04/17 04:07 PM, Benjamin Herrenschmidt wrote
> > So I assume the p2p code provides a way to address that too via special
> > dma_ops ? Or wrappers ?
> 
> Not at this time. We will probably need a way to ensure the iommus do
> not attempt to remap these addresses.

You can't. If the iommu is on, everything is remapped. Or do you mean
to have dma_map_* not do a remapping ?

That's the problem again, same as before, for that to work, the
dma_map_* ops would have to do something special that depends on *both*
the source and target device.

The current DMA infrastructure doesn't have anything like that. It's a
rather fundamental issue to your design that you need to address.

The dma_ops today are architecture specific and have no way to
differenciate between normal and those special P2P DMA pages.

> Though if it does, I'd expect
> everything would still work you just wouldn't get the performance or
> traffic flow you are looking for. We've been testing with the software
> iommu which doesn't have this problem.

So first, no, it's more than "you wouldn't get the performance". On
some systems it may also just not work. Also what do you mean by "the
SW iommu doesn't have this problem" ? It catches the fact that
addresses don't point to RAM and maps differently ?

> > The problem is that the latter while seemingly easier, is also slower
> > and not supported by all platforms and architectures (for example,
> > POWER currently won't allow it, or rather only allows a store-only
> > subset of it under special circumstances).
> 
> Yes, I think situations where we have to cross host bridges will remain
> unsupported by this work for a long time. There are two many cases where
> it just doesn't work or it performs too poorly to be useful.

And the situation where you don't cross bridges is the one where you
need to also take into account the offsets.

*both* cases mean that you need somewhat to intervene at the dma_ops
level to handle this. Which means having a way to identify your special
struct pages or PFNs to allow the arch to add a special case to the
dma_ops.

> > I don't fully understand how p2pmem "solves" that by creating struct
> > pages. The offset problem is one issue. But there's the iommu issue as
> > well, the driver cannot just use the normal dma_map ops.
> 
> We are not using a proper iommu and we are dealing with systems that
> have zero offset. This case is also easily supported. I expect fixing
> the iommus to not map these addresses would also be reasonably achievable.

So you are designing something that is built from scratch to only work
on a specific limited category of systems and is also incompatible with
virtualization.

This is an interesting experiement to look at I suppose, but if you
ever want this upstream I would like at least for you to develop a
strategy to support the wider case, if not an actual implementation.

Cheers,
Ben.
