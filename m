Return-Path: <SRS0=HVeC=32=deltatee.com=logang@kernel.org>
Return-Path: <SRS0=HVeC=32=deltatee.com=logang@kernel.org>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
References: <CAPcyv4it56J8Voo6kV0bBcO3nHsOHYLENpAtONJZTGceDDwNPg@mail.gmail.com>
 <1492381396.25766.43.camel@kernel.crashing.org>
 <20170418164557.GA7181@obsidianresearch.com>
 <cce00131-1f28-27b3-40ab-04f8783f1e5a@deltatee.com>
 <20170418190138.GH7181@obsidianresearch.com>
 <df1351d8-b86c-2e21-1948-4688ece5dc2b@deltatee.com>
 <20170418194845.GA22895@obsidianresearch.com>
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
Message-ID: <643a2bf3-c60d-b0d1-666b-ff33b360723e@deltatee.com>
Date: Tue, 18 Apr 2017 14:06:14 -0600
MIME-Version: 1.0
In-Reply-To: <20170418194845.GA22895@obsidianresearch.com>
Content-Type: text/plain; charset=windows-1252
Subject: Re: [RFC 0/8] Copy Offload with Peer-to-Peer PCI Memory
List-ID: <linux-pci.vger.kernel.org>



On 18/04/17 01:48 PM, Jason Gunthorpe wrote:
> I think this is why progress on this keeps getting stuck - every
> solution is a lot of work.

Yup! There's also a ton of work just to get the iomem safety issues
addressed. Let alone the dma mapping issues.

> You could try to do a dummy mapping / create a MR early on to detect
> this.

Ok, that could be a workable solution.

> FWIW, I wonder if from a RDMA perspective we have another
> problem.. Should we allow P2P memory to be used with the local DMA
> lkey? There are potential designs around virtualization that would not
> allow that. Should we mandate that P2P memory be in its own MR?

I can't say I understand these issues...

Logan
