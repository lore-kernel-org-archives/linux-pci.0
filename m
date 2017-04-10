Return-Path: <linux-kernel-owner@vger.kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>,
        Stephen Bates <sbates@raithlin.com>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
References: <1490911959-5146-1-git-send-email-logang@deltatee.com>
 <1490911959-5146-7-git-send-email-logang@deltatee.com>
 <080b68b4-eba3-861c-4f29-5d829425b5e7@grimberg.me>
 <20170404154629.GA13552@obsidianresearch.com>
 <4df229d8-8124-664a-9bc4-6401bc034be1@grimberg.me>
 <3E85B4D4-9EBC-4299-8209-2D8740947764@raithlin.com>
 <7fcc3ac8-8b96-90f5-3942-87f999c7499d@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Steve Wise <swise@opengridcomputing.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nvdimm@ml01.01.org" <linux-nvdimm@ml01.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <aeeaeb7b-9cec-4cc0-5d4d-e26aa6c02f80@deltatee.com>
Date: Mon, 10 Apr 2017 10:03:45 -0600
MIME-Version: 1.0
In-Reply-To: <7fcc3ac8-8b96-90f5-3942-87f999c7499d@grimberg.me>
Content-Type: text/plain; charset=utf-8
Subject: Re: [RFC 6/8] nvmet: Be careful about using iomem accesses when
 dealing with p2pmem
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 10/04/17 02:29 AM, Sagi Grimberg wrote:
> What you are saying is surprising to me. The switch needs to preserve
> ordering across different switch ports ??

> You are suggesting that there is a *switch-wide* state that tracks
> MemRds never pass MemWrs across all the switch ports? That is a very
> non-trivial statement...

Yes, it is a requirement of the PCIe spec for transactions to be
strongly ordered throughout the fabric so switches must have an internal
state across all ports. Without that, it would be impossible to have PCI
cards work together even if they are using system memory to do so. Also,
I believe, it was done this way to maintain maximum compatibility with
the legacy PCI bus. There is also a relaxed ordering bit that allows
specific transactions to ignore ordering which can help performance.

Obviously this becomes impossible if you have some kind of complex
multi-path fabric.

Logan
