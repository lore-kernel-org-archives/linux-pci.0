Return-Path: <SRS0=W1ds=33=deltatee.com=logang@kernel.org>
Return-Path: <SRS0=W1ds=33=deltatee.com=logang@kernel.org>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
References: <df1351d8-b86c-2e21-1948-4688ece5dc2b@deltatee.com>
 <CAPcyv4gScx6A7vG9VEHpNF41GOy1Nxst7QQ3QC3uZ54bWoxbMg@mail.gmail.com>
 <20170418210339.GA24257@obsidianresearch.com>
 <1492564806.25766.124.camel@kernel.crashing.org>
 <20170419155557.GA8497@obsidianresearch.com>
 <4899b011-bdfb-18d8-ef00-33a1516216a6@deltatee.com>
 <20170419171451.GA10020@obsidianresearch.com>
 <b0234176-e86b-6e7c-686d-b4fef719aad7@deltatee.com>
 <20170419183247.GA13716@obsidianresearch.com>
 <21e8099a-d19d-7df0-682d-627d8b81dfde@deltatee.com>
 <20170419193154.GA14340@obsidianresearch.com>
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
Message-ID: <ea03e81f-e3d5-9f5c-db60-0ceaf4366612@deltatee.com>
Date: Wed, 19 Apr 2017 13:41:49 -0600
MIME-Version: 1.0
In-Reply-To: <20170419193154.GA14340@obsidianresearch.com>
Content-Type: text/plain; charset=windows-1252
Subject: Re: [RFC 0/8] Copy Offload with Peer-to-Peer PCI Memory
List-ID: <linux-pci.vger.kernel.org>



On 19/04/17 01:31 PM, Jason Gunthorpe wrote:
> Try it with VT-D turned on. It shouldn't work or there is a notable
> security hole in your platform..

Ah, ok.

>>> 	 const struct dma_map_ops *comp_ops = get_dma_ops(completer);
>>> 	 const struct dma_map_ops *init_ops = get_dma_ops(initiator);
>>
>> So, in this case, what device does the completer point to? The PCI
>> device or a more specific GPU device? If it's the former, who's
>> responsible for setting the new dma_ops? Typically the dma_ops are arch
>> specific but now you'd be adding ones that are tied to hmm or the gpu.
> 
> Donno, that is for GPU folks to figure out :)
> 
> But.. it could point to a GPU and the GPU struct device could have a
> proxy dma_ops like Dan pointed out.

Seems a bit awkward to me that in order for the intended use case, you
have to proxy the dma_ops. I'd probably still suggest throwing a couple
ops for things like this in the dev_pagemap.

>> It appears to me like it's calculating the DMA address, and the check is
>> just a side requirement. It reads as though it's only doing the check.
> 
> pci_p2p_same_segment_get_pa() then?

Ok, I think that's a bit clearer.

Logan
