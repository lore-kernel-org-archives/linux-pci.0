Return-Path: <SRS0=tZg2=33=obsidianresearch.com=jgunthorpe@kernel.org>
Return-Path: <SRS0=tZg2=33=obsidianresearch.com=jgunthorpe@kernel.org>
Date: Wed, 19 Apr 2017 12:32:47 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Bjorn Helgaas <helgaas@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	"James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>,
	Steve Wise <swise@opengridcomputing.com>,
	Stephen Bates <sbates@raithlin.com>,
	Max Gurtovoy <maxg@mellanox.com>,
	Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
	linux-scsi <linux-scsi@vger.kernel.org>,
	linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
	linux-nvdimm <linux-nvdimm@ml01.01.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Jerome Glisse <jglisse@redhat.com>
Subject: Re: [RFC 0/8] Copy Offload with Peer-to-Peer PCI Memory
Message-ID: <20170419183247.GA13716@obsidianresearch.com>
References: <cce00131-1f28-27b3-40ab-04f8783f1e5a@deltatee.com>
 <20170418190138.GH7181@obsidianresearch.com>
 <df1351d8-b86c-2e21-1948-4688ece5dc2b@deltatee.com>
 <CAPcyv4gScx6A7vG9VEHpNF41GOy1Nxst7QQ3QC3uZ54bWoxbMg@mail.gmail.com>
 <20170418210339.GA24257@obsidianresearch.com>
 <1492564806.25766.124.camel@kernel.crashing.org>
 <20170419155557.GA8497@obsidianresearch.com>
 <4899b011-bdfb-18d8-ef00-33a1516216a6@deltatee.com>
 <20170419171451.GA10020@obsidianresearch.com>
 <b0234176-e86b-6e7c-686d-b4fef719aad7@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b0234176-e86b-6e7c-686d-b4fef719aad7@deltatee.com>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 19, 2017 at 12:01:39PM -0600, Logan Gunthorpe wrote:

> I'm just spit balling here but if HMM wanted to use unaddressable memory
> as a DMA target, it could set that function to create a window ine gpu
> memory, then call the pci_p2p_same_segment and return the result as the
> dma address.

Not entirely, it would have to call through the whole process
including the arch_p2p_cross_segment()..

Maybe we can start down the road of using ops for more iommu steps
with something like this as the helper:

dma_addr_t dma_map_pa(struct device *initiator, struct page *page,
                      void *data)
{
         struct device *completer = get_p2p_completer(page);
	 dma_addr_t pa;

         if (IS_ERR(completer))
	       return SYSTEM_MEMORY;
	       // Or maybe ?
	       return init_ops->dma_map_pa(..);

	 // Try the generic method
	 pa = pci_p2p_same_segment(dev, p2p_src, page);
	 if (pa != ERROR)
	       goto out;

         // Try the arch specific helper
	 const struct dma_map_ops *comp_ops = get_dma_ops(completer);
	 const struct dma_map_ops *init_ops = get_dma_ops(initiator);

         /* FUTURE: Let something translate a HMM page into a DMA'ble
   	    page, eg by mapping it into a GPU window. Maybe this
	    callback lives in devmap ? */
	 page = comp_ops->translate_dma_page(completer, page);

         /* New dma_map_op is the same as arch_p2p_cross_segment in
	    prior version. Any arch specific data needed to program
	    the iommu flows through data */
	 pa = init_ops->p2p_cross_segment_map(completer, inititator, page, data);

out:
	 device_put(completer);
	 return pa;
}

// map_sg op:
for (each sgl) {
    struct page *page = sg_page(s);
    struct arch_iommu_data data = {}; // pass through to ops->p2p_cross_segment
    dma_addr_t pa;

    pa = dma_map_pa(dev, page, &data)
    if (pa == ERROR)
        // fail

    if (!data.needs_iommu) {
        // Insert PA directly into the result SGL
        sg++;
        continue;
    }

    // Else pa & data describe how to setup the iommu
}

> > dma_addr_t pci_p2p_same_segment(struct device *initator,
> >                                 struct device *completer,
> > 				struct page *page)
> 
> I'm not sure I like the name pci_p2p_same_segment. It reads as though
> it's only checking if the devices are not the same segment.

Well, that is exactly what it is doing. If it succeeds then the caller
knows the DMA will not flow outside the segment and no iommu setup/etc
is required.

That function cannot be expanded to include generic cross-segment
traffic, a new function would be needed..

Jason
