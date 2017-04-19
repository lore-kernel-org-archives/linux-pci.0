Return-Path: <SRS0=9gB6=33=kernel.crashing.org=benh@kernel.org>
Return-Path: <SRS0=9gB6=33=kernel.crashing.org=benh@kernel.org>
Message-ID: <1492564806.25766.124.camel@kernel.crashing.org>
Subject: Re: [RFC 0/8] Copy Offload with Peer-to-Peer PCI Memory
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        Dan Williams
	 <dan.j.williams@intel.com>
Cc: Logan Gunthorpe <logang@deltatee.com>, Bjorn Helgaas
 <helgaas@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Sagi Grimberg
 <sagi@grimberg.me>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe
 <axboe@kernel.dk>,
        Steve Wise <swise@opengridcomputing.com>,
        Stephen Bates
 <sbates@raithlin.com>, Max Gurtovoy <maxg@mellanox.com>,
        Keith Busch
 <keith.busch@intel.com>, linux-pci@vger.kernel.org,
        linux-scsi
 <linux-scsi@vger.kernel.org>,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm <linux-nvdimm@ml01.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jerome
 Glisse <jglisse@redhat.com>
Date: Wed, 19 Apr 2017 11:20:06 +1000
In-Reply-To: <20170418210339.GA24257@obsidianresearch.com>
References: 
	<CAPcyv4it56J8Voo6kV0bBcO3nHsOHYLENpAtONJZTGceDDwNPg@mail.gmail.com>
	 <1492381396.25766.43.camel@kernel.crashing.org>
	 <20170418164557.GA7181@obsidianresearch.com>
	 <cce00131-1f28-27b3-40ab-04f8783f1e5a@deltatee.com>
	 <20170418190138.GH7181@obsidianresearch.com>
	 <df1351d8-b86c-2e21-1948-4688ece5dc2b@deltatee.com>
	 <CAPcyv4gScx6A7vG9VEHpNF41GOy1Nxst7QQ3QC3uZ54bWoxbMg@mail.gmail.com>
	 <20170418210339.GA24257@obsidianresearch.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2017-04-18 at 15:03 -0600, Jason Gunthorpe wrote:
> I don't follow, when does get_dma_ops() return a p2p aware provider?
> It has no way to know if the DMA is going to involve p2p, get_dma_ops
> is called with the device initiating the DMA.
> 
> So you'd always return the P2P shim on a system that has registered
> P2P memory?
> 
> Even so, how does this shim work? dma_ops are not really intended to
> be stacked. How would we make unmap work, for instance? What happens
> when the underlying iommu dma ops actually natively understands p2p
> and doesn't want the shim?

Good point. We only know on a per-page basis ... ugh.

So we really need to change the arch main dma_ops. I'm not opposed to
that. What we then need to do is have that main arch dma_map_sg,
when it encounters a "device" page, call into a helper attached to
the devmap to handle *that page*, providing sufficient context.

That helper wouldn't perform the actual iommu mapping. It would simply
return something along the lines of:

 - "use that alternate bus address and don't map in the iommu"
 - "use that alternate bus address and do map in the iommu"
 - "proceed as normal"
 - "fail"

What do you think ?

Cheers,
Ben.
