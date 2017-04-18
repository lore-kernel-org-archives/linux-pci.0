Return-Path: <SRS0=HVeC=32=deltatee.com=logang@kernel.org>
Return-Path: <SRS0=HVeC=32=deltatee.com=logang@kernel.org>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
References: <CAPcyv4it56J8Voo6kV0bBcO3nHsOHYLENpAtONJZTGceDDwNPg@mail.gmail.com>
 <1492381396.25766.43.camel@kernel.crashing.org>
 <20170418164557.GA7181@obsidianresearch.com>
 <cce00131-1f28-27b3-40ab-04f8783f1e5a@deltatee.com>
 <20170418190138.GH7181@obsidianresearch.com>
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
Message-ID: <df1351d8-b86c-2e21-1948-4688ece5dc2b@deltatee.com>
Date: Tue, 18 Apr 2017 13:35:32 -0600
MIME-Version: 1.0
In-Reply-To: <20170418190138.GH7181@obsidianresearch.com>
Content-Type: text/plain; charset=windows-1252
Subject: Re: [RFC 0/8] Copy Offload with Peer-to-Peer PCI Memory
List-ID: <linux-pci.vger.kernel.org>



On 18/04/17 01:01 PM, Jason Gunthorpe wrote:
> Ultimately every dma_ops will need special code to support P2P with
> the special hardware that ops is controlling, so it makes some sense
> to start by pushing the check down there in the first place. This
> advice is partially motivated by how dma_map_sg is just a small
> wrapper around the function pointer call...

Yes, I noticed this problem too and that makes sense. It just means
every dma_ops will probably need to be modified to either support p2p
pages or fail on them. Though, the only real difficulty there is that it
will be a lot of work.

> Where p2p_same_segment_map_page checks if the two devices are on the
> 'same switch' and if so returns the address translated to match the
> bus address programmed into the BAR or fails. We knows this case is
> required to work by the PCI spec, so it makes sense to use it as the
> first canned helper.

I've also suggested that this check should probably be done (or perhaps
duplicated) before we even get to the map stage. In the case of
nvme-fabrics we'd probably want to let the user know when they try to
configure it or at least fall back to allocating regular memory instead.
It would be a difficult situation to have already copied a block of data
from a NIC to p2p memory only to have it be deemed unmappable on the
NVMe device it's destined for. (Or vice-versa.) This was another issue
p2pmem was attempting to solve.

Logan
