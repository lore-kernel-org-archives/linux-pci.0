Return-Path: <SRS0=9gB6=33=kernel.crashing.org=benh@kernel.org>
Return-Path: <SRS0=9gB6=33=kernel.crashing.org=benh@kernel.org>
Message-ID: <1492564669.25766.122.camel@kernel.crashing.org>
Subject: Re: [RFC 0/8] Copy Offload with Peer-to-Peer PCI Memory
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Logan Gunthorpe <logang@deltatee.com>,
        Dan Williams
	 <dan.j.williams@intel.com>,
        Jerome Glisse <jglisse@redhat.com>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Wed, 19 Apr 2017 11:17:49 +1000
In-Reply-To: <1cdeee61-2107-a392-4e5e-77a6aa10354f@deltatee.com>
References: 
	<CAPcyv4it56J8Voo6kV0bBcO3nHsOHYLENpAtONJZTGceDDwNPg@mail.gmail.com>
	 <1492381396.25766.43.camel@kernel.crashing.org>
	 <20170418164557.GA7181@obsidianresearch.com>
	 <cce00131-1f28-27b3-40ab-04f8783f1e5a@deltatee.com>
	 <20170418190138.GH7181@obsidianresearch.com>
	 <df1351d8-b86c-2e21-1948-4688ece5dc2b@deltatee.com>
	 <CAPcyv4gScx6A7vG9VEHpNF41GOy1Nxst7QQ3QC3uZ54bWoxbMg@mail.gmail.com>
	 <1565047873.28680036.1492547352121.JavaMail.zimbra@redhat.com>
	 <CAPcyv4hTWbXkdeCEO9O0UM-EPcSjpdHCh7vDpSoNs1kB-Kup3A@mail.gmail.com>
	 <1cdeee61-2107-a392-4e5e-77a6aa10354f@deltatee.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2017-04-18 at 14:48 -0600, Logan Gunthorpe wrote:
> > ...and that dma_map goes through get_dma_ops(), so I don't see the conflict?
> 
> The main conflict is in dma_map_sg which only does get_dma_ops once but
> the sg may contain memory of different types.

We can handle that in our "overriden" dma ops.

It's a bit tricky but it *could* break it down into segments and
forward portions back to the original dma ops.

Ben.
