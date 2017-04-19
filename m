Return-Path: <SRS0=9gB6=33=kernel.crashing.org=benh@kernel.org>
Return-Path: <SRS0=9gB6=33=kernel.crashing.org=benh@kernel.org>
Message-ID: <1492565149.25766.128.camel@kernel.crashing.org>
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
Date: Wed, 19 Apr 2017 11:25:49 +1000
In-Reply-To: <20170418232159.GA28477@obsidianresearch.com>
References: <df1351d8-b86c-2e21-1948-4688ece5dc2b@deltatee.com>
	 <CAPcyv4gScx6A7vG9VEHpNF41GOy1Nxst7QQ3QC3uZ54bWoxbMg@mail.gmail.com>
	 <20170418210339.GA24257@obsidianresearch.com>
	 <CAPcyv4h9n9Uzq4FAXR0ufieqvx5_txEwtnaaBWdxe-jF_XfTLg@mail.gmail.com>
	 <20170418212258.GA26838@obsidianresearch.com>
	 <CAPcyv4g5ifbpukthMXMro8qKdfoXAhftDpiwWWFCLZ4dK8JnnA@mail.gmail.com>
	 <96198489-1af5-abcf-f23f-9a7e41aa17f7@deltatee.com>
	 <CAPcyv4haUUs1Eew1PZTZkoGU4YFiHOuU93G+kG+CqfKzjz1gpw@mail.gmail.com>
	 <20170418224225.GB27113@obsidianresearch.com>
	 <CAPcyv4gQxifHcKLv0CZZoXJWz=rtzv-vGoofkek6NxRABd4XyA@mail.gmail.com>
	 <20170418232159.GA28477@obsidianresearch.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2017-04-18 at 17:21 -0600, Jason Gunthorpe wrote:
> Splitting the sgl is different from iommu batching.
> 
> As an example, an O_DIRECT write of 1 MB with a single 4K P2P page in
> the middle.
> 
> The optimum behavior is to allocate a 1MB-4K iommu range and fill it
> with the CPU memory. Then return a SGL with three entires, two
> pointing into the range and one to the p2p.
> 
> It is creating each range which tends to be expensive, so creating
> two
> ranges (or worse, if every SGL created a range it would be 255) is
> very undesired.

I think it's easier to get us started to just use a helper and
stick it in the existing sglist processing loop of the architecture.

As we noticed, stacking dma_ops is actually non-trivial and opens quite
the can of worms.

As Jerome mentioned, you can end up with IOs ops containing an sglist
that is a collection of memory and GPU pages for example.

Cheers,
Ben.
