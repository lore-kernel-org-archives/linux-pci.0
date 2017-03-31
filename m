Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 31 Mar 2017 00:09:50 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Steve Wise <swise@opengridcomputing.com>,
        Stephen Bates <sbates@raithlin.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 5/8] scatterlist: Modify SG copy functions to support io
 memory.
Message-ID: <20170331070950.GA9059@infradead.org>
References: <1490911959-5146-1-git-send-email-logang@deltatee.com>
 <1490911959-5146-6-git-send-email-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1490911959-5146-6-git-send-email-logang@deltatee.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

You're calling memcpy_{to,from}_iomem on non-__iomem pointers.  This
is a fundamental no-go as we keep I/O memory separate from kernel
pointers.
