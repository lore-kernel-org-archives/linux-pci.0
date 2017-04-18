Return-Path: <SRS0=bkpB=32=obsidianresearch.com=jgunthorpe@kernel.org>
Return-Path: <SRS0=bkpB=32=obsidianresearch.com=jgunthorpe@kernel.org>
Date: Tue, 18 Apr 2017 16:24:40 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Bjorn Helgaas <helgaas@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	"James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>,
	Steve Wise <swise@opengridcomputing.com>,
	Stephen Bates <sbates@raithlin.com>,
	Max Gurtovoy <maxg@mellanox.com>,
	Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
	linux-scsi <linux-scsi@vger.kernel.org>,
	linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
	linux-nvdimm <linux-nvdimm@ml01.01.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Jerome Glisse <jglisse@redhat.com>
Subject: Re: [RFC 0/8] Copy Offload with Peer-to-Peer PCI Memory
Message-ID: <20170418222440.GA27113@obsidianresearch.com>
References: <CAPcyv4it56J8Voo6kV0bBcO3nHsOHYLENpAtONJZTGceDDwNPg@mail.gmail.com>
 <1492381396.25766.43.camel@kernel.crashing.org>
 <20170418164557.GA7181@obsidianresearch.com>
 <cce00131-1f28-27b3-40ab-04f8783f1e5a@deltatee.com>
 <20170418190138.GH7181@obsidianresearch.com>
 <df1351d8-b86c-2e21-1948-4688ece5dc2b@deltatee.com>
 <CAPcyv4gScx6A7vG9VEHpNF41GOy1Nxst7QQ3QC3uZ54bWoxbMg@mail.gmail.com>
 <20170418210339.GA24257@obsidianresearch.com>
 <9fc9352f-86fe-3a9e-e372-24b3346b518c@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9fc9352f-86fe-3a9e-e372-24b3346b518c@deltatee.com>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 18, 2017 at 03:31:58PM -0600, Logan Gunthorpe wrote:

> 1) It means that sg_has_p2p has to walk the entire sg and check every
> page. Then map_sg_p2p/map_sg has to walk it again and repeat the check
> then do some operation per page. If anyone is concerned about the
> dma_map performance this could be an issue.

dma_map performance is a concern, this is why I suggest this as an
interm solution until all dma_ops are migrated. Ideally sg_has_p2p
would be a fast path that checked some kind of flags bit set during
sg_assign_page... 

This would probably all have to be protected with CONFIG_P2P until it
becomes performance neutral. People without an iommu are not going to
want to walk the sg list at all..

> 2) Without knowing exactly what the arch specific code may need to do
> it's hard to say that this is exactly the right approach. If every
> dma_ops provider has to do exactly this on every page it may lead to a
> lot of duplicate code:

I think someone would have to start to look at it to make a
determination..

I suspect the main server oriented iommu dma op will want to have
proper p2p support anyhow and will probably have their unique control
flow..

> The only thing I'm presently aware of is the segment check and applying
> the offset to the physical address

Well, I called the function p2p_same_segment_map_page() in my last
suggestion for a reason - that is all the helper does.

The intention would be for real iommu drivers to call that helper for
the one simple case and if it fails then use their own routines to
figure out if cross-segment P2P is possible and configure the iommu as
needed.

> bus specific and not arch specific which I think is what Dan may be
> getting at. So it may make sense to just have a pci_map_sg_p2p() which
> takes a dma_ops struct it would use for any page that isn't a p2p page.

Like I keep saying, dma_ops are not really designed to be stacked.

Try and write a stacked map_sg function like you describe and you will
see how horrible it quickly becomes.

Setting up an iommu is very expensive, so we need to batch it for the
entire sg list. Thus a trivial implementation to iterate over all sg
list entries is not desired.

So first a sg list without p2p memory would have to be created, pass
to the lower level ops, then brought back. Remember, the returned sg
list will have a different number of entries than the original. Now
another complex loop is needed to split/merge back in the p2p sg
elements to get a return result.

Finally, we have to undo all of this when doing unmap.

Basically, all this list processing is a huge overhead compared to
just putting a helper call in the existing sg iteration loop of the
actual op.  Particularly if the actual op is a no-op like no-mmu x86
would use.

Since dma mapping is a performance path we must be careful not to
create intrinsic inefficiencies with otherwise nice layering :)

Jason
