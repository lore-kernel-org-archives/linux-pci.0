Return-Path: <SRS0=9gB6=33=kernel.crashing.org=benh@kernel.org>
Return-Path: <SRS0=9gB6=33=kernel.crashing.org=benh@kernel.org>
Message-ID: <1492564984.25766.126.camel@kernel.crashing.org>
Subject: Re: [RFC 0/8] Copy Offload with Peer-to-Peer PCI Memory
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        Logan Gunthorpe
	 <logang@deltatee.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas
 <helgaas@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg
 <sagi@grimberg.me>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe
 <axboe@kernel.dk>,
        Steve Wise <swise@opengridcomputing.com>,
        Stephen Bates
 <sbates@raithlin.com>, Max Gurtovoy <maxg@mellanox.com>,
        Keith Busch
 <keith.busch@intel.com>, linux-pci@vger.kernel.org,
        linux-scsi
 <linux-scsi@vger.kernel.org>,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm <linux-nvdimm@ml01.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jerome
 Glisse <jglisse@redhat.com>
Date: Wed, 19 Apr 2017 11:23:04 +1000
In-Reply-To: <20170418222440.GA27113@obsidianresearch.com>
References: 
	<CAPcyv4it56J8Voo6kV0bBcO3nHsOHYLENpAtONJZTGceDDwNPg@mail.gmail.com>
	 <1492381396.25766.43.camel@kernel.crashing.org>
	 <20170418164557.GA7181@obsidianresearch.com>
	 <cce00131-1f28-27b3-40ab-04f8783f1e5a@deltatee.com>
	 <20170418190138.GH7181@obsidianresearch.com>
	 <df1351d8-b86c-2e21-1948-4688ece5dc2b@deltatee.com>
	 <CAPcyv4gScx6A7vG9VEHpNF41GOy1Nxst7QQ3QC3uZ54bWoxbMg@mail.gmail.com>
	 <20170418210339.GA24257@obsidianresearch.com>
	 <9fc9352f-86fe-3a9e-e372-24b3346b518c@deltatee.com>
	 <20170418222440.GA27113@obsidianresearch.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2017-04-18 at 16:24 -0600, Jason Gunthorpe wrote:
> Basically, all this list processing is a huge overhead compared to
> just putting a helper call in the existing sg iteration loop of the
> actual op.  Particularly if the actual op is a no-op like no-mmu x86
> would use.

Yes, I'm leaning toward that approach too.

The helper itself could hang off the devmap though.

> Since dma mapping is a performance path we must be careful not to
> create intrinsic inefficiencies with otherwise nice layering :)
> 
> Jason
