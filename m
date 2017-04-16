Return-Path: <SRS0=kBs1=3Y=kernel.crashing.org=benh@kernel.org>
Return-Path: <SRS0=kBs1=3Y=kernel.crashing.org=benh@kernel.org>
Message-ID: <1492381958.25766.50.camel@kernel.crashing.org>
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
Date: Mon, 17 Apr 2017 08:32:38 +1000
In-Reply-To: <6e732d6a-9baf-1768-3e9c-f6c887a836b2@deltatee.com>
References: 
	<CAPcyv4it56J8Voo6kV0bBcO3nHsOHYLENpAtONJZTGceDDwNPg@mail.gmail.com>
	 <6e732d6a-9baf-1768-3e9c-f6c887a836b2@deltatee.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Sun, 2017-04-16 at 10:47 -0600, Logan Gunthorpe wrote:
> > I think you need to give other archs a chance to support this with a
> > design that considers the offset case as a first class citizen rather
> > than an afterthought.
> 
> I'll consider this. Given the fact I can use your existing
> get_dev_pagemap infrastructure to look up the p2pmem device this
> probably isn't as hard as I thought it would be anyway (we probably
> don't even need a page flag). We'd just have lookup the dev_pagemap,
> test if it's a p2pmem device, and if so, call a p2pmem_dma_map function
> which could apply the offset or do any other arch specific logic (if
> necessary).

I'm still not 100% why do you need a "p2mem device" mind you ...

Cheers,
Ben.
