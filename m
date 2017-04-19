Return-Path: <SRS0=W1ds=33=deltatee.com=logang@kernel.org>
Return-Path: <SRS0=W1ds=33=deltatee.com=logang@kernel.org>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
References: <20170418210339.GA24257@obsidianresearch.com>
 <1492564806.25766.124.camel@kernel.crashing.org>
 <20170419155557.GA8497@obsidianresearch.com>
 <4899b011-bdfb-18d8-ef00-33a1516216a6@deltatee.com>
 <20170419171451.GA10020@obsidianresearch.com>
 <b0234176-e86b-6e7c-686d-b4fef719aad7@deltatee.com>
 <20170419183247.GA13716@obsidianresearch.com>
 <21e8099a-d19d-7df0-682d-627d8b81dfde@deltatee.com>
 <20170419193154.GA14340@obsidianresearch.com>
 <ea03e81f-e3d5-9f5c-db60-0ceaf4366612@deltatee.com>
 <20170419204808.GA15716@obsidianresearch.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Dan Williams <dan.j.williams@intel.com>, Bjorn Helgaas <helgaas@kernel.org>,
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
Message-ID: <c143c2fd-8bff-595d-8a9e-debfcd56e531@deltatee.com>
Date: Wed, 19 Apr 2017 16:55:22 -0600
MIME-Version: 1.0
In-Reply-To: <20170419204808.GA15716@obsidianresearch.com>
Content-Type: text/plain; charset=windows-1252
Subject: Re: [RFC 0/8] Copy Offload with Peer-to-Peer PCI Memory
List-ID: <linux-pci.vger.kernel.org>



On 19/04/17 02:48 PM, Jason Gunthorpe wrote:
> On Wed, Apr 19, 2017 at 01:41:49PM -0600, Logan Gunthorpe wrote:
> 
>>> But.. it could point to a GPU and the GPU struct device could have a
>>> proxy dma_ops like Dan pointed out.
>>
>> Seems a bit awkward to me that in order for the intended use case, you
>> have to proxy the dma_ops. I'd probably still suggest throwing a couple
>> ops for things like this in the dev_pagemap.
> 
> Another option is adding a new 'struct completer_dma_ops *' to struct
> device for this use case.
> 
> Seems like a waste to expand dev_pagemap when we only need a unique
> value per struct device?

I feel like expanding dev_pagemap has a much lower impact than expanding
struct device... dev_pagemap is only one instance per zone device region
so expanding it shouldn't be a huge issue. Expanding struct device means
every device struct in the system gets bigger.

Logan
