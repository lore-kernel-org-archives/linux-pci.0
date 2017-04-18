Return-Path: <SRS0=bkpB=32=obsidianresearch.com=jgunthorpe@kernel.org>
Return-Path: <SRS0=bkpB=32=obsidianresearch.com=jgunthorpe@kernel.org>
Date: Tue, 18 Apr 2017 10:45:57 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Logan Gunthorpe <logang@deltatee.com>,
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
Message-ID: <20170418164557.GA7181@obsidianresearch.com>
References: <CAPcyv4it56J8Voo6kV0bBcO3nHsOHYLENpAtONJZTGceDDwNPg@mail.gmail.com>
 <1492381396.25766.43.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1492381396.25766.43.camel@kernel.crashing.org>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 17, 2017 at 08:23:16AM +1000, Benjamin Herrenschmidt wrote:
 
> Thanks :-) There's a reason why I'm insisting on this. We have constant
> requests for this today. We have hacks in the GPU drivers to do it for
> GPUs behind a switch, but those are just that, ad-hoc hacks in the
> drivers. We have similar grossness around the corner with some CAPI
> NICs trying to DMA to GPUs. I have people trying to use PLX DMA engines
> to whack nVME devices.

A lot of people feel this way in the RDMA community too. We have had
vendors shipping out of tree code to enable P2P for RDMA with GPU
years and years now. :(

Attempts to get things in mainline have always run into the same sort
of road blocks you've identified in this thread..

FWIW, I read this discussion and it sounds closer to an agreement than
I've ever seen in the past.

>From Ben's comments, I would think that the 'first class' support that
is needed here is simply a function to return the 'struct device'
backing a CPU address range.

This is the minimal required information for the arch or IOMMU code
under the dma ops to figure out the fabric source/dest, compute the
traffic path, determine if P2P is even possible, what translation
hardware is crossed, and what DMA address should be used.

If there is going to be more core support for this stuff I think it
will be under the topic of more robustly describing the fabric to the
core and core helpers to extract data from the description: eg compute
the path, check if the path crosses translation, etc

But that isn't really related to P2P, and is probably better left to
the arch authors to figure out where they need to enhance the existing
topology data..

I think the key agreement to get out of Logan's series is that P2P DMA
means:
 - The BAR will be backed by struct pages
 - Passing the CPU __iomem address of the BAR to the DMA API is
   valid and, long term, dma ops providers are expected to fail
   or return the right DMA address
 - Mapping BAR memory into userspace and back to the kernel via
   get_user_pages works transparently, and with the DMA API above
 - The dma ops provider must be able to tell if source memory is bar
   mapped and recover the pci device backing the mapping.

At least this is what we'd like in RDMA :)

FWIW, RDMA probably wouldn't want to use a p2mem device either, we
already have APIs that map BAR memory to user space, and would like to
keep using them. A 'enable P2P for bar' helper function sounds better
to me.

Jason
