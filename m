Return-Path: <SRS0=kBs1=3Y=kernel.crashing.org=benh@kernel.org>
Return-Path: <SRS0=kBs1=3Y=kernel.crashing.org=benh@kernel.org>
Message-ID: <1492381907.25766.49.camel@kernel.crashing.org>
Subject: Re: [RFC 0/8] Copy Offload with Peer-to-Peer PCI Memory
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Logan Gunthorpe <logang@deltatee.com>,
        Dan Williams
	 <dan.j.williams@intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
        Jason Gunthorpe
 <jgunthorpe@obsidianresearch.com>,
        Christoph Hellwig <hch@lst.de>, Sagi
 Grimberg <sagi@grimberg.me>,
        "James E.J. Bottomley"
 <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen"
 <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Steve Wise
 <swise@opengridcomputing.com>,
        Stephen Bates <sbates@raithlin.com>, Max
 Gurtovoy <maxg@mellanox.com>,
        Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm
 <linux-nvdimm@ml01.01.org>,
        "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>,
        Jerome Glisse <jglisse@redhat.com>
Date: Mon, 17 Apr 2017 08:31:47 +1000
In-Reply-To: <5e43818e-8c6b-8be8-23ff-b798633d2a73@deltatee.com>
References: <1490911959-5146-1-git-send-email-logang@deltatee.com>
	 <1491974532.7236.43.camel@kernel.crashing.org>
	 <5ac22496-56ec-025d-f153-140001d2a7f9@deltatee.com>
	 <1492034124.7236.77.camel@kernel.crashing.org>
	 <81888a1e-eb0d-cbbc-dc66-0a09c32e4ea2@deltatee.com>
	 <20170413232631.GB24910@bhelgaas-glaptop.roam.corp.google.com>
	 <20170414041656.GA30694@obsidianresearch.com>
	 <1492169849.25766.3.camel@kernel.crashing.org>
	 <630c1c63-ff17-1116-e069-2b8f93e50fa2@deltatee.com>
	 <20170414190452.GA15679@bhelgaas-glaptop.roam.corp.google.com>
	 <1492207643.25766.18.camel@kernel.crashing.org>
	 <bff1e503-95a9-e19f-bfd9-0ff962c63a81@deltatee.com>
	 <CAPcyv4jUeKzKDARp6Z35kdPLKnP-M6aF8X5KpOx55CLyjnj4dA@mail.gmail.com>
	 <1492311719.25766.37.camel@kernel.crashing.org>
	 <CAPcyv4iqnz1B00Q3xG-nGrLXdOyB7ditxmwZyotksLFgUqr+jA@mail.gmail.com>
	 <5e43818e-8c6b-8be8-23ff-b798633d2a73@deltatee.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Sun, 2017-04-16 at 10:34 -0600, Logan Gunthorpe wrote:
> 
> On 16/04/17 09:53 AM, Dan Williams wrote:
> > ZONE_DEVICE allows you to redirect via get_dev_pagemap() to retrieve
> > context about the physical address in question. I'm thinking you can
> > hang bus address translation data off of that structure. This seems
> > vaguely similar to what HMM is doing.
> 
> Thanks! I didn't realize you had the infrastructure to look up a device
> from a pfn/page. That would really come in handy for us.

It does indeed. I won't be able to play with that much for a few weeks
(see my other email) so if you're going to tackle this while I'm away,
can you work with Jerome to make sure you don't conflict with HMM ?

I really want a way for HMM to be able to layout struct pages over the
GPU BARs rather than in "allocated free space" for the case where the
BAR is big enough to cover all of the GPU memory.

In general, I'd like a simple & generic way for any driver to ask the
core to layout DMA'ble struct pages over BAR space. I an not convinced
this requires a "p2mem device" to be created on top of this though but
that's a different discussion.

Of course the actual ability to perform the DMA mapping will be subject
to various restrictions that will have to be implemented in the actual
"dma_ops override" backend. We can have generic code to handle the case
where devices reside on the same domain, which can deal with switch
configuration etc... we will need to have iommu specific code to handle
the case going through the fabric. 

Virtualization is a separate can of worms due to how qemu completely
fakes the MMIO space, we can look into that later.

Cheers,
Ben.
