Return-Path: <SRS0=9gB6=33=kernel.crashing.org=benh@kernel.org>
Return-Path: <SRS0=9gB6=33=kernel.crashing.org=benh@kernel.org>
Message-ID: <1492564395.25766.120.camel@kernel.crashing.org>
Subject: Re: [RFC 0/8] Copy Offload with Peer-to-Peer PCI Memory
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        Dan Williams
	 <dan.j.williams@intel.com>
Cc: Logan Gunthorpe <logang@deltatee.com>, Bjorn Helgaas
 <helgaas@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Sagi Grimberg
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
Date: Wed, 19 Apr 2017 11:13:15 +1000
In-Reply-To: <20170418180020.GE7181@obsidianresearch.com>
References: 
	<CAPcyv4it56J8Voo6kV0bBcO3nHsOHYLENpAtONJZTGceDDwNPg@mail.gmail.com>
	 <1492381396.25766.43.camel@kernel.crashing.org>
	 <20170418164557.GA7181@obsidianresearch.com>
	 <CAPcyv4izLa2vw12ysvVfd=ysaMKcASNFm+=CaqDKhnPY9B5OJg@mail.gmail.com>
	 <20170418180020.GE7181@obsidianresearch.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2017-04-18 at 12:00 -0600, Jason Gunthorpe wrote:
> - All platforms can succeed if the PCI devices are under the same
>   'segment', but where segments begin is somewhat platform specific
>   knowledge. (this is 'same switch' idea Logan has talked about)

We also need to be careful whether P2P is enabled in the switch
or not.

Cheers,
Ben.
