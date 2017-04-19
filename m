Return-Path: <SRS0=W1ds=33=deltatee.com=logang@kernel.org>
Return-Path: <SRS0=W1ds=33=deltatee.com=logang@kernel.org>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
References: <1492381396.25766.43.camel@kernel.crashing.org>
 <20170418164557.GA7181@obsidianresearch.com>
 <cce00131-1f28-27b3-40ab-04f8783f1e5a@deltatee.com>
 <20170418190138.GH7181@obsidianresearch.com>
 <df1351d8-b86c-2e21-1948-4688ece5dc2b@deltatee.com>
 <CAPcyv4gScx6A7vG9VEHpNF41GOy1Nxst7QQ3QC3uZ54bWoxbMg@mail.gmail.com>
 <20170418210339.GA24257@obsidianresearch.com>
 <1492564806.25766.124.camel@kernel.crashing.org>
 <20170419155557.GA8497@obsidianresearch.com>
 <4899b011-bdfb-18d8-ef00-33a1516216a6@deltatee.com>
 <20170419171451.GA10020@obsidianresearch.com>
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
Message-ID: <b0234176-e86b-6e7c-686d-b4fef719aad7@deltatee.com>
Date: Wed, 19 Apr 2017 12:01:39 -0600
MIME-Version: 1.0
In-Reply-To: <20170419171451.GA10020@obsidianresearch.com>
Content-Type: text/plain; charset=windows-1252
Subject: Re: [RFC 0/8] Copy Offload with Peer-to-Peer PCI Memory
List-ID: <linux-pci.vger.kernel.org>



On 19/04/17 11:14 AM, Jason Gunthorpe wrote:
> I don't see a use for the dma_map function pointer at this point..

Yes, it is kind of like designing for the future. I just find it a
little odd calling the pci functions in the iommu.


> It doesn't make alot of sense for the completor of the DMA to provide
> a mapping op, the mapping process is *path* specific, not specific to
> a completer/initiator.

I'm just spit balling here but if HMM wanted to use unaddressable memory
as a DMA target, it could set that function to create a window ine gpu
memory, then call the pci_p2p_same_segment and return the result as the
dma address.


> dma_addr_t pci_p2p_same_segment(struct device *initator,
>                                 struct device *completer,
> 				struct page *page)

I'm not sure I like the name pci_p2p_same_segment. It reads as though
it's only checking if the devices are not the same segment. It also may
be that, in the future, it supports devices on different segments. I'd
call it more like pci_p2p_dma_map.


> for (each sgl) {

Thanks, this code fleshes things out nicely


> To me it looks like the code duplication across the iommu stuff comes
> from just duplicating the basic iommu algorithm in every driver.

Yes, this is true.

> To clean that up I think someone would need to hoist the overall sgl
> loop and use more ops callbacks eg allocate_iommu_range,
> assign_page_to_rage, dealloc_range, etc. This is a problem p2p makes
> worse, but isn't directly causing :\

Yup.

Logan
