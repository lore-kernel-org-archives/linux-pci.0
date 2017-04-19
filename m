Return-Path: <SRS0=W1ds=33=deltatee.com=logang@kernel.org>
Return-Path: <SRS0=W1ds=33=deltatee.com=logang@kernel.org>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <CAPcyv4it56J8Voo6kV0bBcO3nHsOHYLENpAtONJZTGceDDwNPg@mail.gmail.com>
 <1492381396.25766.43.camel@kernel.crashing.org>
 <20170418164557.GA7181@obsidianresearch.com>
 <cce00131-1f28-27b3-40ab-04f8783f1e5a@deltatee.com>
 <20170418190138.GH7181@obsidianresearch.com>
 <df1351d8-b86c-2e21-1948-4688ece5dc2b@deltatee.com>
 <CAPcyv4gScx6A7vG9VEHpNF41GOy1Nxst7QQ3QC3uZ54bWoxbMg@mail.gmail.com>
 <20170418210339.GA24257@obsidianresearch.com>
 <1492564806.25766.124.camel@kernel.crashing.org>
 <20170419155557.GA8497@obsidianresearch.com>
From: Logan Gunthorpe <logang@deltatee.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>,
 "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Jens Axboe <axboe@kernel.dk>, Steve Wise <swise@opengridcomputing.com>,
 Stephen Bates <sbates@raithlin.com>, Max Gurtovoy <maxg@mellanox.com>,
 Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
 linux-scsi <linux-scsi@vger.kernel.org>, linux-nvme@lists.infradead.org,
 linux-rdma@vger.kernel.org, linux-nvdimm <linux-nvdimm@ml01.01.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jerome Glisse <jglisse@redhat.com>
Message-ID: <4899b011-bdfb-18d8-ef00-33a1516216a6@deltatee.com>
Date: Wed, 19 Apr 2017 10:48:51 -0600
MIME-Version: 1.0
In-Reply-To: <20170419155557.GA8497@obsidianresearch.com>
Content-Type: text/plain; charset=windows-1252
Subject: Re: [RFC 0/8] Copy Offload with Peer-to-Peer PCI Memory
List-ID: <linux-pci.vger.kernel.org>



On 19/04/17 09:55 AM, Jason Gunthorpe wrote:
> I was thinking only this one would be supported with a core code
> helper..

Pivoting slightly: I was looking at how HMM uses ZONE_DEVICE. They add a
type flag to the dev_pagemap structure which would be very useful to us.
We could add another MEMORY_DEVICE_P2P type to distinguish p2p pages.
Then, potentially, we could add a dma_map callback to the structure
(possibly unioned with an hmm field). The dev_ops providers would then
just need to do something like this (enclosed in a helper):

if (is_zone_device_page(page)) {
	pgmap = get_dev_pagemap(page_to_pfn(page));
	if (!pgmap || pgmap->type !=  MEMORY_DEVICE_P2P ||
	    !pgmap->dma_map)
		return 0;
	
	dma_addr = pgmap->dma_map(dev, pgmap->dev, page);
	put_dev_pagemap(pgmap);
	if (!dma_addr)
		return 0;
	...
}

The pci_enable_p2p_bar function would then just need to call
devm_memremap_pages with the dma_map callback set to a function that
does the segment check and the offset calculation.

Thoughts?

@Jerome: my feedback to you would be that your patch assumes all users
of devm_memremap_pages are MEMORY_DEVICE_PERSISTENT. It would be more
useful if it was generic. My suggestion would be to have the caller
allocate the dev_pagemap structure, populate it and pass it into
devm_memremap_pages. Given that pretty much everything in that structure
are already arguments to that function, I feel like this makes sense.
This should also help to unify hmm_devmem_pages_create and
devm_memremap_pages which look very similar to each other.

Logan
