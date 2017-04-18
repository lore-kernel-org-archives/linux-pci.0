Return-Path: <SRS0=HVeC=32=deltatee.com=logang@kernel.org>
Return-Path: <SRS0=HVeC=32=deltatee.com=logang@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
References: <CAPcyv4it56J8Voo6kV0bBcO3nHsOHYLENpAtONJZTGceDDwNPg@mail.gmail.com>
 <1492381396.25766.43.camel@kernel.crashing.org>
 <20170418164557.GA7181@obsidianresearch.com>
 <cce00131-1f28-27b3-40ab-04f8783f1e5a@deltatee.com>
 <20170418190138.GH7181@obsidianresearch.com>
 <df1351d8-b86c-2e21-1948-4688ece5dc2b@deltatee.com>
 <CAPcyv4gScx6A7vG9VEHpNF41GOy1Nxst7QQ3QC3uZ54bWoxbMg@mail.gmail.com>
 <20170418210339.GA24257@obsidianresearch.com>
 <CAPcyv4h9n9Uzq4FAXR0ufieqvx5_txEwtnaaBWdxe-jF_XfTLg@mail.gmail.com>
 <20170418212258.GA26838@obsidianresearch.com>
 <CAPcyv4g5ifbpukthMXMro8qKdfoXAhftDpiwWWFCLZ4dK8JnnA@mail.gmail.com>
 <96198489-1af5-abcf-f23f-9a7e41aa17f7@deltatee.com>
 <CAPcyv4haUUs1Eew1PZTZkoGU4YFiHOuU93G+kG+CqfKzjz1gpw@mail.gmail.com>
 <5e68102d-e165-6ef3-8678-9bdb4f78382b@deltatee.com>
 <CAPcyv4jArrOBBih5jOU5wrC2imdo9VPzuQpfzepP3_QEwM-33g@mail.gmail.com>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
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
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <462e318b-bcb8-7031-5b25-2c245086e077@deltatee.com>
Date: Tue, 18 Apr 2017 16:56:20 -0600
MIME-Version: 1.0
In-Reply-To: <CAPcyv4jArrOBBih5jOU5wrC2imdo9VPzuQpfzepP3_QEwM-33g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [RFC 0/8] Copy Offload with Peer-to-Peer PCI Memory
List-ID: <linux-pci.vger.kernel.org>



On 18/04/17 04:50 PM, Dan Williams wrote:
> On Tue, Apr 18, 2017 at 3:48 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
>>
>>
>> On 18/04/17 04:28 PM, Dan Williams wrote:
>>> Unlike the pci bus address offset case which I think is fundamental to
>>> support since shipping archs do this today, I think it is ok to say
>>> p2p is restricted to a single sgl that gets to talk to host memory or
>>> a single device. That said, what's wrong with a p2p aware map_sg
>>> implementation calling up to the host memory map_sg implementation on
>>> a per sgl basis?
>>
>> I think Ben said they need mixed sgls and that is where this gets messy.
>> I think I'd prefer this too given trying to enforce all sgs in a list to
>> be one type or another could be quite difficult given the state of the
>> scatterlist code.
>>
>>>> Also, what happens if p2p pages end up getting passed to a device that
>>>> doesn't have the injected dma_ops?
>>>
>>> This goes back to limiting p2p to a single pci host bridge. If the p2p
>>> capability is coordinated with the bridge rather than between the
>>> individual devices then we have a central point to catch this case.
>>
>> Not really relevant. If these pages get to userspace (as people seem
>> keen on doing) or a less than careful kernel driver they could easily
>> get into the dma_map calls of devices that aren't even pci related (via
>> an O_DIRECT operation on an incorrect file or something). The common
>> code must reject these and can't rely on an injected dma op.
> 
> No, we can't do that at get_user_pages() time, it will always need to
> be up to the device driver to fail dma that it can't perform.

I'm not sure I follow -- are you agreeing with me? The dma_map_* needs
to fail for any dma it cannot perform. Which means either all dma_ops
providers need to be p2p aware or this logic has to be in dma_map_*
itself. My point being: you can't rely on an injected dma_op for some
devices to handle the fail case globally.
