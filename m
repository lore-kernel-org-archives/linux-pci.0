Return-Path: <SRS0=Ppao=3Y=deltatee.com=logang@kernel.org>
Return-Path: <SRS0=Ppao=3Y=deltatee.com=logang@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
References: <CAPcyv4it56J8Voo6kV0bBcO3nHsOHYLENpAtONJZTGceDDwNPg@mail.gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Bjorn Helgaas <helgaas@kernel.org>,
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
Message-ID: <6e732d6a-9baf-1768-3e9c-f6c887a836b2@deltatee.com>
Date: Sun, 16 Apr 2017 10:47:50 -0600
MIME-Version: 1.0
In-Reply-To: <CAPcyv4it56J8Voo6kV0bBcO3nHsOHYLENpAtONJZTGceDDwNPg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [RFC 0/8] Copy Offload with Peer-to-Peer PCI Memory
List-ID: <linux-pci.vger.kernel.org>



On 16/04/17 09:44 AM, Dan Williams wrote:
> I think we very much want the dma mapping layer to be in the way.
> It's the only sane semantic we have to communicate this translation.

Yes, I wasn't proposing bypassing that layer, per say. I just meant that
the layer would, in the end, have to return the address without any
translations.

> The difference is that there was nothing fundamental in the core
> design of pmem + DAX that prevented other archs from growing pmem
> support. THP and memory hotplug existed on other architectures and
> they just need to plug in their arch-specific enabling. p2p support
> needs the same starting point of something more than one architecture
> can plug into, and handling the bus address offset case needs to be
> incorporated into the design.

I don't think there's a difference there either. There'd have been
nothing fundamental in our core design that says offsets couldn't have
been added later.

> pmem + dax did not change the meaning of what a dma_addr_t is, p2p does.

I don't think p2p actually really changes the meaning of dma_addr_t
either. We are just putting addresses in there that weren't used
previously. Our RFC makes no changes to anything even remotely related
to dma_addr_t.

> I think you need to give other archs a chance to support this with a
> design that considers the offset case as a first class citizen rather
> than an afterthought.

I'll consider this. Given the fact I can use your existing
get_dev_pagemap infrastructure to look up the p2pmem device this
probably isn't as hard as I thought it would be anyway (we probably
don't even need a page flag). We'd just have lookup the dev_pagemap,
test if it's a p2pmem device, and if so, call a p2pmem_dma_map function
which could apply the offset or do any other arch specific logic (if
necessary).

Logan
