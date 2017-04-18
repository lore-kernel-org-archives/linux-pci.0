Return-Path: <SRS0=HVeC=32=deltatee.com=logang@kernel.org>
Return-Path: <SRS0=HVeC=32=deltatee.com=logang@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
References: <CAPcyv4it56J8Voo6kV0bBcO3nHsOHYLENpAtONJZTGceDDwNPg@mail.gmail.com>
 <6e732d6a-9baf-1768-3e9c-f6c887a836b2@deltatee.com>
 <1492381958.25766.50.camel@kernel.crashing.org>
 <6149ab5e-c981-6881-8c5a-22349561c3e8@deltatee.com>
 <1492413640.25766.52.camel@kernel.crashing.org>
 <ac643c73-43e9-1658-ffcb-d5628f80cbc1@deltatee.com>
 <CAPcyv4guU68waLZ1XBT9GPq1b1iZFDhTpsAven18jhr2JU6ScQ@mail.gmail.com>
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
Message-ID: <bd28298b-c679-d02e-c014-0af5843b0795@deltatee.com>
Date: Mon, 17 Apr 2017 23:22:30 -0600
MIME-Version: 1.0
In-Reply-To: <CAPcyv4guU68waLZ1XBT9GPq1b1iZFDhTpsAven18jhr2JU6ScQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [RFC 0/8] Copy Offload with Peer-to-Peer PCI Memory
List-ID: <linux-pci.vger.kernel.org>



On 17/04/17 11:04 AM, Dan Williams wrote:
>> Yes, in this scheme, it needs an additional p2pmem child. Why is that an
>> issue? It certainly makes it a lot easier for the user to understand the
>> p2pmem memory in the system (through the sysfs tree) and reason about
>> the topology and when to use it. This is important.
> 
> I think you want to go the other way in the hierarchy and find a
> shared *parent* to land the p2pmem capability. Because that same agent
> is going to be responsible handling address translation for the peers.
>
> Peer-dma is always going to be a property of the bus and not the end
> devices. Requiring each bus implementation to explicitly enable
> peer-to-peer support is a feature not a bug.
> 
> We shouldn't design for some future possible use case. Solve it for
> pci and when / if another bus comes along then look at a more generic
> abstraction.

Thanks Dan, these are some good points. Wedding it closer to the PCI
code makes more sense to me now. I'd still think you'd want some struct
device though to appear in the device hierarchy and allow reasoning
about topology.

Logan
