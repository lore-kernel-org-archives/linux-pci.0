Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:39751 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755136AbdDFQCJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Apr 2017 12:02:09 -0400
To: Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
References: <1490911959-5146-1-git-send-email-logang@deltatee.com>
 <1490911959-5146-7-git-send-email-logang@deltatee.com>
 <080b68b4-eba3-861c-4f29-5d829425b5e7@grimberg.me>
 <20170404154629.GA13552@obsidianresearch.com>
 <4df229d8-8124-664a-9bc4-6401bc034be1@grimberg.me>
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
Message-ID: <cc2ac0cc-8543-5297-bc09-9946cca93894@deltatee.com>
Date: Thu, 6 Apr 2017 10:02:04 -0600
MIME-Version: 1.0
In-Reply-To: <4df229d8-8124-664a-9bc4-6401bc034be1@grimberg.me>
Content-Type: text/plain; charset=windows-1252
Subject: Re: [RFC 6/8] nvmet: Be careful about using iomem accesses when
 dealing with p2pmem
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 05/04/17 11:33 PM, Sagi Grimberg wrote:
> 
>>> Note that the nvme completion queues are still on the host memory, so
>>> this means we have lost the ordering between data and completions as
>>> they go to different pcie targets.
>>
>> Hmm, in this simple up/down case with a switch, I think it might
>> actually be OK.
>>
>> Transactions might not complete at the NVMe device before the CPU
>> processes the RDMA completion, however due to the PCI-E ordering rules
>> new TLPs directed to the NVMe will complete after the RMDA TLPs and
>> thus observe the new data. (eg order preserving)
>>
>> It would be very hard to use P2P if fabric ordering is not preserved..
> 
> I think it still can race if the p2p device is connected with more than
> a single port to the switch.
> 
> Say it's connected via 2 legs, the bar is accessed from leg A and the
> data from the disk comes via leg B. In this case, the data is heading
> towards the p2p device via leg B (might be congested), the completion
> goes directly to the RC, and then the host issues a read from the
> bar via leg A. I don't understand what can guarantee ordering here.
> 
> Stephen told me that this still guarantees ordering, but I honestly
> can't understand how, perhaps someone can explain to me in a simple
> way that I can understand.

I'll say I don't have a complete understanding of this myself. However,
my understanding is the completion coming from disk won't be sent toward
the RC until all the all the TLPs reached leg B. Then if the RC sends
TLPs to the p2p device via leg B they will be behind all the TLPs the
disk sent. Or something like that. Obviously this will only work with a
tree topology (which I believe is the only topology that makes sense for
PCI). If you had a mesh topology, then the data could route around
congestion and that would get around the ordering restrictions.

Logan
