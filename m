Return-Path: <SRS0=P6S7=3Z=kernel.crashing.org=benh@kernel.org>
Return-Path: <SRS0=P6S7=3Z=kernel.crashing.org=benh@kernel.org>
Message-ID: <1492413640.25766.52.camel@kernel.crashing.org>
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
Date: Mon, 17 Apr 2017 17:20:40 +1000
In-Reply-To: <6149ab5e-c981-6881-8c5a-22349561c3e8@deltatee.com>
References: 
	<CAPcyv4it56J8Voo6kV0bBcO3nHsOHYLENpAtONJZTGceDDwNPg@mail.gmail.com>
	 <6e732d6a-9baf-1768-3e9c-f6c887a836b2@deltatee.com>
	 <1492381958.25766.50.camel@kernel.crashing.org>
	 <6149ab5e-c981-6881-8c5a-22349561c3e8@deltatee.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Sun, 2017-04-16 at 23:13 -0600, Logan Gunthorpe wrote:
> 
> > 
> > I'm still not 100% why do you need a "p2mem device" mind you ...
> 
> Well, you don't "need" it but it is a design choice that I think makes a
> lot of sense for the following reasons:
> 
> 1) p2pmem is in fact a device on the pci bus. A pci driver will need to
> set it up and create the device and thus it will have a natural parent
> pci device. Instantiating a struct device for it means it will appear in
> the device hierarchy and one can use that to reason about its position
> in the topology.

But is it ? For example take a GPU, does it, in your scheme, need an
additional "p2pmem" child ? Why can't the GPU driver just use some
helper to instantiate the necessary struct pages ? What does having an
actual "struct device" child buys you ?

> 2) In order to create the struct pages we use the ZONE_DEVICE
> infrastructure which requires a struct device. (See
> devm_memremap_pages.)

Yup, but you already have one in the actual pci_dev ... What is the
benefit of adding a second one ?

>  This amazingly gets us the get_dev_pagemap
> architecture which also uses a struct device. So by using a p2pmem
> device we can go from struct page to struct device to p2pmem device
> quickly and effortlessly.

Which isn't terribly useful in itself right ? What you care about is
the "enclosing" pci_dev no ? Or am I missing something ?

> 3) You wouldn't want to use the pci's struct device because it doesn't
> really describe what's going on. For example, there may be multiple
> devices on the pci device in question: eg. an NVME card and some p2pmem.

What is "some p2pmem" ?

> Or it could be a NIC with some p2pmem.

Again what is "some p2pmem" ?

That a device might have some memory-like buffer space is all well and
good but does it need to be specifically distinguished at the device
level ? It could be inherent to what the device is... for example again
take the GPU example, why would you call the FB memory "p2pmem" ? 

>  Or it could just be p2pmem by itself. And the logic to figure out what
>  memory is available and where
> the address is will be non-standard so it's really straightforward to
> have any pci driver just instantiate a p2pmem device.

Again I'm not sure why it needs to "instanciate a p2pmem" device. Maybe
it's the term "p2pmem" that offputs me. If p2pmem allowed to have a
standard way to lookup the various offsets etc... I mentioned earlier,
then yes, it would make sense to have it as a staging point. As-is, I
don't know. 

> It is probably worth you reading the RFC patches at this point to get a
> better feel for this.

Yup, I'll have another look a bit more in depth.

Cheers,
Ben.


> Logan
