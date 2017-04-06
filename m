Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:39699 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751605AbdDFPwt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Apr 2017 11:52:49 -0400
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Steve Wise <swise@opengridcomputing.com>,
        Stephen Bates <sbates@raithlin.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
References: <1490911959-5146-1-git-send-email-logang@deltatee.com>
 <1490911959-5146-4-git-send-email-logang@deltatee.com>
 <bce6b009-7756-3cf7-5053-2628b26c8d97@grimberg.me>
 <ec05b7d9-8dfd-8227-84d2-7d391df32219@deltatee.com>
 <0689e764-bf04-6da2-3b7d-2cbf0b6b94a0@grimberg.me>
Cc: linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        Sinan Kaya <okaya@codeaurora.org>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <5f76a824-3918-b706-86bd-0ba455895185@deltatee.com>
Date: Thu, 6 Apr 2017 09:52:36 -0600
MIME-Version: 1.0
In-Reply-To: <0689e764-bf04-6da2-3b7d-2cbf0b6b94a0@grimberg.me>
Content-Type: text/plain; charset=windows-1252
Subject: Re: [RFC 3/8] nvmet: Use p2pmem in nvme target
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hey Sagi,

On 05/04/17 11:47 PM, Sagi Grimberg wrote:
> Because the user can get it wrong, and its our job to do what we can in
> order to prevent the user from screwing itself.

Well, "screwing" themselves seems a bit strong. It wouldn't be much
different from a lot of other tunables in the system. For example, it
would be similar to the user choosing the wrong io scheduler for their
disk or workload. If you change this setting without measuring
performance you probably don't care too much about the result anyway.

> I wasn't against it that much, I'm all for making things "just work"
> with minimal configuration steps, but I'm not sure we can get it
> right without it.

Ok, well in that case I may reconsider this in the next series.

>>>> Ideally, we'd want to use an NVME CMB buffer as p2p memory. This would
>>>> save an extra PCI transfer as the NVME card could just take the data
>>>> out of it's own memory. However, at this time, cards with CMB buffers
>>>> don't seem to be available.
>>>
>>> Even if it was available, it would be hard to make real use of this
>>> given that we wouldn't know how to pre-post recv buffers (for in-capsule
>>> data). But let's leave this out of the scope entirely...
>>
>> I don't understand what you're referring to. We'd simply use the CMB
>> buffer as a p2pmem device, why does that change anything?
> 
> I'm referring to the in-capsule data buffers pre-posts that we do.
> Because we prepare a buffer that would contain in-capsule data, we have
> no knowledge to which device the incoming I/O is directed to, which
> means we can (and will) have I/O where the data lies in CMB of device
> A but it's really targeted to device B - which sorta defeats the purpose
> of what we're trying to optimize here...

Well, the way I've had it is that each port gets one p2pmem device. So
you'd only want to put NVMe devices that will work with that p2pmem
device behind that port. Though, I can see that being a difficult
restriction seeing it probably means you'll need to have one port per
nvme device if you want to use the CMB buffer of each device. I'll have
to think about that some. Also, it's worth noting that we aren't even
optimizing in-capsule data at this time.


> Still the user can get it wrong. Not sure we can get a way without
> keeping track of this as new devices join the subsystem.

Yeah, I understand. I'll have to think some more about all of this. I'm
starting to see some ways to improve thing.s

Thanks,

Logan
