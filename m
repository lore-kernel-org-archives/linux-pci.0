Return-Path: <SRS0=5fKE=3Z=deltatee.com=logang@kernel.org>
Return-Path: <SRS0=5fKE=3Z=deltatee.com=logang@kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Dan Williams <dan.j.williams@intel.com>
References: <CAPcyv4it56J8Voo6kV0bBcO3nHsOHYLENpAtONJZTGceDDwNPg@mail.gmail.com>
 <6e732d6a-9baf-1768-3e9c-f6c887a836b2@deltatee.com>
 <1492381958.25766.50.camel@kernel.crashing.org>
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
Message-ID: <6149ab5e-c981-6881-8c5a-22349561c3e8@deltatee.com>
Date: Sun, 16 Apr 2017 23:13:13 -0600
MIME-Version: 1.0
In-Reply-To: <1492381958.25766.50.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
Subject: Re: [RFC 0/8] Copy Offload with Peer-to-Peer PCI Memory
List-ID: <linux-pci.vger.kernel.org>



On 16/04/17 04:32 PM, Benjamin Herrenschmidt wrote:
>> I'll consider this. Given the fact I can use your existing
>> get_dev_pagemap infrastructure to look up the p2pmem device this
>> probably isn't as hard as I thought it would be anyway (we probably
>> don't even need a page flag). We'd just have lookup the dev_pagemap,
>> test if it's a p2pmem device, and if so, call a p2pmem_dma_map function
>> which could apply the offset or do any other arch specific logic (if
>> necessary).
> 
> I'm still not 100% why do you need a "p2mem device" mind you ...

Well, you don't "need" it but it is a design choice that I think makes a
lot of sense for the following reasons:

1) p2pmem is in fact a device on the pci bus. A pci driver will need to
set it up and create the device and thus it will have a natural parent
pci device. Instantiating a struct device for it means it will appear in
the device hierarchy and one can use that to reason about its position
in the topology.

2) In order to create the struct pages we use the ZONE_DEVICE
infrastructure which requires a struct device. (See
devm_memremap_pages.) This amazingly gets us the get_dev_pagemap
architecture which also uses a struct device. So by using a p2pmem
device we can go from struct page to struct device to p2pmem device
quickly and effortlessly.

3) You wouldn't want to use the pci's struct device because it doesn't
really describe what's going on. For example, there may be multiple
devices on the pci device in question: eg. an NVME card and some p2pmem.
Or it could be a NIC with some p2pmem. Or it could just be p2pmem by
itself. And the logic to figure out what memory is available and where
the address is will be non-standard so it's really straightforward to
have any pci driver just instantiate a p2pmem device.

It is probably worth you reading the RFC patches at this point to get a
better feel for this.

Logan
