Return-Path: <linux-kernel-owner@vger.kernel.org>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        Sagi Grimberg <sagi@grimberg.me>
References: <1490911959-5146-1-git-send-email-logang@deltatee.com>
 <1490911959-5146-7-git-send-email-logang@deltatee.com>
 <080b68b4-eba3-861c-4f29-5d829425b5e7@grimberg.me>
 <20170404154629.GA13552@obsidianresearch.com>
Cc: Christoph Hellwig <hch@lst.de>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Steve Wise <swise@opengridcomputing.com>,
        Stephen Bates <sbates@raithlin.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-rdma@vger.kernel.org, linux-nvdimm@ml01.01.org,
        linux-kernel@vger.kernel.org
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <c5638d51-d43f-f30e-f32c-531b3091bd49@deltatee.com>
Date: Tue, 4 Apr 2017 11:21:58 -0600
MIME-Version: 1.0
In-Reply-To: <20170404154629.GA13552@obsidianresearch.com>
Content-Type: text/plain; charset=windows-1252
Subject: Re: [RFC 6/8] nvmet: Be careful about using iomem accesses when
 dealing with p2pmem
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 04/04/17 04:59 AM, Sagi Grimberg wrote:
> We can never ever get here from an IO command, and that is a good thing
> because it would have been broken if we did, regardless of what copy
> method we use...

Yes, I changed this mostly for admin commands. I did notice connect
commands do end up reading from the p2mem and this patchset correctly
switches it to iomemcpy. However, based on Cristoph's comment, I hope to
make it more general such that iomem is hidden within sgls and any
access will either be correct or create a warning.


On 04/04/17 09:46 AM, Jason Gunthorpe wrote:
> Transactions might not complete at the NVMe device before the CPU
> processes the RDMA completion, however due to the PCI-E ordering rules
> new TLPs directed to the NVMe will complete after the RMDA TLPs and
> thus observe the new data. (eg order preserving)
> 
> It would be very hard to use P2P if fabric ordering is not preserved..

Yes, my understanding is the same, the PCI-E ordering rules save us here.

Thanks,

Logan
