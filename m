Return-Path: <SRS0=iNHT=33=redhat.com=jglisse@kernel.org>
Return-Path: <SRS0=iNHT=33=redhat.com=jglisse@kernel.org>
Date: Wed, 19 Apr 2017 13:32:26 -0400
From: Jerome Glisse <jglisse@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Logan Gunthorpe <logang@deltatee.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
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
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 0/8] Copy Offload with Peer-to-Peer PCI Memory
Message-ID: <20170419173225.GA11255@redhat.com>
References: <20170418164557.GA7181@obsidianresearch.com>
 <cce00131-1f28-27b3-40ab-04f8783f1e5a@deltatee.com>
 <20170418190138.GH7181@obsidianresearch.com>
 <df1351d8-b86c-2e21-1948-4688ece5dc2b@deltatee.com>
 <CAPcyv4gScx6A7vG9VEHpNF41GOy1Nxst7QQ3QC3uZ54bWoxbMg@mail.gmail.com>
 <20170418210339.GA24257@obsidianresearch.com>
 <1492564806.25766.124.camel@kernel.crashing.org>
 <20170419155557.GA8497@obsidianresearch.com>
 <4899b011-bdfb-18d8-ef00-33a1516216a6@deltatee.com>
 <CAPcyv4iJ9H8Ykwnjqa2R_D1qG6PsSQmi=QxYH-rKLF_ihrsWyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAPcyv4iJ9H8Ykwnjqa2R_D1qG6PsSQmi=QxYH-rKLF_ihrsWyw@mail.gmail.com>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 19, 2017 at 10:01:23AM -0700, Dan Williams wrote:
> On Wed, Apr 19, 2017 at 9:48 AM, Logan Gunthorpe <logang@deltatee.com> wrote:
> >
> >
> > On 19/04/17 09:55 AM, Jason Gunthorpe wrote:
> >> I was thinking only this one would be supported with a core code
> >> helper..
> >
> > Pivoting slightly: I was looking at how HMM uses ZONE_DEVICE. They add a
> > type flag to the dev_pagemap structure which would be very useful to us.
> > We could add another MEMORY_DEVICE_P2P type to distinguish p2p pages.
> > Then, potentially, we could add a dma_map callback to the structure
> > (possibly unioned with an hmm field). The dev_ops providers would then
> > just need to do something like this (enclosed in a helper):
> >
> > if (is_zone_device_page(page)) {
> >         pgmap = get_dev_pagemap(page_to_pfn(page));
> >         if (!pgmap || pgmap->type !=  MEMORY_DEVICE_P2P ||
> >             !pgmap->dma_map)
> >                 return 0;
> >
> >         dma_addr = pgmap->dma_map(dev, pgmap->dev, page);
> >         put_dev_pagemap(pgmap);
> >         if (!dma_addr)
> >                 return 0;
> >         ...
> > }
> >
> > The pci_enable_p2p_bar function would then just need to call
> > devm_memremap_pages with the dma_map callback set to a function that
> > does the segment check and the offset calculation.
> >
> > Thoughts?
> >
> > @Jerome: my feedback to you would be that your patch assumes all users
> > of devm_memremap_pages are MEMORY_DEVICE_PERSISTENT. It would be more
> > useful if it was generic. My suggestion would be to have the caller
> > allocate the dev_pagemap structure, populate it and pass it into
> > devm_memremap_pages. Given that pretty much everything in that structure
> > are already arguments to that function, I feel like this makes sense.
> > This should also help to unify hmm_devmem_pages_create and
> > devm_memremap_pages which look very similar to each other.
> 
> I like that change. Also the types should describe the memory relative
> to its relationship to struct page, not whether it is persistent or
> not. I would consider volatile and persistent memory that is attached
> to the cpu memory controller and i/o coherent as the same type of
> memory. DMA incoherent ranges like P2P and HMM should get their own
> types.

Dan you asked me to not use devm_memremap_pages() because you didn't
want to have HMM memory in the pgmap_radix, did you change opinion
on that ? :)

Note i won't make any change now on that front but if it make sense
i am happy to do it as separate patchset on top of HMM.

Also i don't want p2pmem to be an exclusive or with HMM, we will want
GPU to do peer to peer DMA and thus HMM ZONE_DEVICE pages to support
this too.

I do believe it is easier to special case in ZONE_DEVICE into existing
dma_ops for each architecture. For x86 i think there is only 3 different
set of dma_ops to modify. For other arch i guess there is even less.

But in all the case i think p2pmem should stay out of memory management
business. If some set of device do not have memory management it is
better to propose helper to do that as part of the subsystem to which
those devices belong. Just wanted to reiterate that point.

Cheers,
Jérôme
