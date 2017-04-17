Return-Path: <SRS0=nsds=3Z=intel.com=dan.j.williams@kernel.org>
Return-Path: <SRS0=nsds=3Z=intel.com=dan.j.williams@kernel.org>
MIME-Version: 1.0
In-Reply-To: <ac643c73-43e9-1658-ffcb-d5628f80cbc1@deltatee.com>
References: <CAPcyv4it56J8Voo6kV0bBcO3nHsOHYLENpAtONJZTGceDDwNPg@mail.gmail.com>
 <6e732d6a-9baf-1768-3e9c-f6c887a836b2@deltatee.com> <1492381958.25766.50.camel@kernel.crashing.org>
 <6149ab5e-c981-6881-8c5a-22349561c3e8@deltatee.com> <1492413640.25766.52.camel@kernel.crashing.org>
 <ac643c73-43e9-1658-ffcb-d5628f80cbc1@deltatee.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 17 Apr 2017 10:04:31 -0700
Message-ID: <CAPcyv4guU68waLZ1XBT9GPq1b1iZFDhTpsAven18jhr2JU6ScQ@mail.gmail.com>
Subject: Re: [RFC 0/8] Copy Offload with Peer-to-Peer PCI Memory
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Bjorn Helgaas <helgaas@kernel.org>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>, Jens Axboe <axboe@kernel.dk>,
	Steve Wise <swise@opengridcomputing.com>, Stephen Bates <sbates@raithlin.com>,
	Max Gurtovoy <maxg@mellanox.com>, Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
	linux-scsi <linux-scsi@vger.kernel.org>, linux-nvme@lists.infradead.org,
	linux-rdma@vger.kernel.org, linux-nvdimm <linux-nvdimm@ml01.01.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jerome Glisse <jglisse@redhat.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 17, 2017 at 9:52 AM, Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
> On 17/04/17 01:20 AM, Benjamin Herrenschmidt wrote:
>> But is it ? For example take a GPU, does it, in your scheme, need an
>> additional "p2pmem" child ? Why can't the GPU driver just use some
>> helper to instantiate the necessary struct pages ? What does having an
>> actual "struct device" child buys you ?
>
> Yes, in this scheme, it needs an additional p2pmem child. Why is that an
> issue? It certainly makes it a lot easier for the user to understand the
> p2pmem memory in the system (through the sysfs tree) and reason about
> the topology and when to use it. This is important.

I think you want to go the other way in the hierarchy and find a
shared *parent* to land the p2pmem capability. Because that same agent
is going to be responsible handling address translation for the peers.

>>> 2) In order to create the struct pages we use the ZONE_DEVICE
>>> infrastructure which requires a struct device. (See
>>> devm_memremap_pages.)
>>
>> Yup, but you already have one in the actual pci_dev ... What is the
>> benefit of adding a second one ?
>
> But that would tie all of this very tightly to be pci only and may get
> hard to differentiate if more users of ZONE_DEVICE crop up who happen to
> be using a pci device. Having a specific class for this makes it very
> clear how this memory would be handled. For example, although I haven't
> looked into it, this could very well be a point of conflict with HMM. If
> they were to use the pci device to populate the dev_pagemap then we
> couldn't also use the pci device. I feel it's much better for users of
> dev_pagemap to have their struct devices they own to avoid such conflicts.

Peer-dma is always going to be a property of the bus and not the end
devices. Requiring each bus implementation to explicitly enable
peer-to-peer support is a feature not a bug.

>>>  This amazingly gets us the get_dev_pagemap
>>> architecture which also uses a struct device. So by using a p2pmem
>>> device we can go from struct page to struct device to p2pmem device
>>> quickly and effortlessly.
>>
>> Which isn't terribly useful in itself right ? What you care about is
>> the "enclosing" pci_dev no ? Or am I missing something ?
>
> Sure it is. What if we want to someday support p2pmem that's on another bus?

We shouldn't design for some future possible use case. Solve it for
pci and when / if another bus comes along then look at a more generic
abstraction.
