Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35507 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751448AbdDJIaC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Apr 2017 04:30:02 -0400
Subject: Re: [RFC 6/8] nvmet: Be careful about using iomem accesses when
 dealing with p2pmem
To: Stephen Bates <sbates@raithlin.com>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
References: <1490911959-5146-1-git-send-email-logang@deltatee.com>
 <1490911959-5146-7-git-send-email-logang@deltatee.com>
 <080b68b4-eba3-861c-4f29-5d829425b5e7@grimberg.me>
 <20170404154629.GA13552@obsidianresearch.com>
 <4df229d8-8124-664a-9bc4-6401bc034be1@grimberg.me>
 <3E85B4D4-9EBC-4299-8209-2D8740947764@raithlin.com>
Cc: Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>,
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
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <7fcc3ac8-8b96-90f5-3942-87f999c7499d@grimberg.me>
Date: Mon, 10 Apr 2017 11:29:57 +0300
MIME-Version: 1.0
In-Reply-To: <3E85B4D4-9EBC-4299-8209-2D8740947764@raithlin.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


> Sagi
>
> As long as legA, legB and the RC are all connected to the same switch then ordering will be preserved (I think many other topologies also work). Here is how it would work for the problem case you are concerned about (which is a read from the NVMe drive).
>
> 1. Disk device DMAs out the data to the p2pmem device via a string of PCIe MemWr TLPs.
> 2. Disk device writes to the completion queue (in system memory) via a MemWr TLP.
> 3. The last of the MemWrs from step 1 might have got stalled in the PCIe switch due to congestion but if so they are stalled in the egress path of the switch for the p2pmem port.
> 4. The RC determines the IO is complete when the TLP associated with step 2 updates the memory associated with the CQ. It issues some operation to read the p2pmem.
> 5. Regardless of whether the MemRd TLP comes from the RC or another device connected to the switch it is queued in the egress queue for the p2pmem FIO behind the last DMA TLP (from step 1).
> PCIe ordering ensures that this MemRd cannot overtake the MemWr (Reads can never pass writes).
> Therefore the MemRd can never get to the p2pmem device until after the last DMA MemWr has.

What you are saying is surprising to me. The switch needs to preserve
ordering across different switch ports ??

You are suggesting that there is a *switch-wide* state that tracks
MemRds never pass MemWrs across all the switch ports? That is a very
non-trivial statement...
