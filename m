Return-Path: <SRS0=mpUv=3W=kernel.crashing.org=benh@kernel.org>
Return-Path: <SRS0=mpUv=3W=kernel.crashing.org=benh@kernel.org>
Message-ID: <1492169849.25766.3.camel@kernel.crashing.org>
Subject: Re: [RFC 0/8] Copy Offload with Peer-to-Peer PCI Memory
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        Bjorn Helgaas
	 <helgaas@kernel.org>
Cc: Logan Gunthorpe <logang@deltatee.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "James E.J. Bottomley"
 <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen"
 <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Steve Wise
 <swise@opengridcomputing.com>,
        Stephen Bates <sbates@raithlin.com>, Max
 Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-rdma@vger.kernel.org, linux-nvdimm@ml01.01.org,
        linux-kernel@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>
Date: Fri, 14 Apr 2017 21:37:29 +1000
In-Reply-To: <20170414041656.GA30694@obsidianresearch.com>
References: <1490911959-5146-1-git-send-email-logang@deltatee.com>
	 <1491974532.7236.43.camel@kernel.crashing.org>
	 <5ac22496-56ec-025d-f153-140001d2a7f9@deltatee.com>
	 <1492034124.7236.77.camel@kernel.crashing.org>
	 <81888a1e-eb0d-cbbc-dc66-0a09c32e4ea2@deltatee.com>
	 <20170413232631.GB24910@bhelgaas-glaptop.roam.corp.google.com>
	 <20170414041656.GA30694@obsidianresearch.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2017-04-13 at 22:16 -0600, Jason Gunthorpe wrote:
> > Any caller of pci_add_resource_offset() uses CPU addresses different from
> > the PCI bus addresses (unless the offset is zero, of course).  All ACPI
> > platforms also support this translation (see "translation_offset"), though
> > in most x86 systems the offset is zero.  I'm aware of one x86 system that
> > was tested with a non-zero offset but I don't think it was shipped that
> > way.
> 
> I'd suggest just detecting if there is any translation in bus
> addresses anywhere and just hard disabling P2P on such systems.

I object to designing a subsystem that by design cannot work on whole
categories of architectures out there.

> On modern hardware with 64 bit BARs there is very little reason to
> have translation, so I think this is a legacy feature.

No it's not.

Cheers,
Ben.
