Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:33987 "EHLO quartz.orcorp.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754793AbdDDPrF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Apr 2017 11:47:05 -0400
Date: Tue, 4 Apr 2017 09:46:29 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>,
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
Subject: Re: [RFC 6/8] nvmet: Be careful about using iomem accesses when
 dealing with p2pmem
Message-ID: <20170404154629.GA13552@obsidianresearch.com>
References: <1490911959-5146-1-git-send-email-logang@deltatee.com>
 <1490911959-5146-7-git-send-email-logang@deltatee.com>
 <080b68b4-eba3-861c-4f29-5d829425b5e7@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <080b68b4-eba3-861c-4f29-5d829425b5e7@grimberg.me>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 04, 2017 at 01:59:26PM +0300, Sagi Grimberg wrote:
> Note that the nvme completion queues are still on the host memory, so
> this means we have lost the ordering between data and completions as
> they go to different pcie targets.

Hmm, in this simple up/down case with a switch, I think it might
actually be OK.

Transactions might not complete at the NVMe device before the CPU
processes the RDMA completion, however due to the PCI-E ordering rules
new TLPs directed to the NVMe will complete after the RMDA TLPs and
thus observe the new data. (eg order preserving)

It would be very hard to use P2P if fabric ordering is not preserved..

Jason
