Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from zimbra1.kalray.eu ([92.103.151.219]:54715 "EHLO
        zimbra1.kalray.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1175922AbdDYMIb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Apr 2017 08:08:31 -0400
Date: Tue, 25 Apr 2017 13:58:53 +0200 (CEST)
From: Marta Rybczynska <mrybczyn@kalray.eu>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Sinan Kaya <okaya@codeaurora.org>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
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
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Message-ID: <117239810.400362790.1493121533234.JavaMail.zimbra@kalray.eu>
In-Reply-To: <ef507444-d3e5-0454-86a0-b5c4ae4b4dd9@deltatee.com>
References: <1490911959-5146-1-git-send-email-logang@deltatee.com> <c8edc480-a2ac-a763-8438-18f3396db483@deltatee.com> <e2165253dc355d5cb223e754d78047b1@codeaurora.org> <c5d7da85-41fd-2769-fcf8-b3c2a1fab95f@deltatee.com> <f0448277-9381-5c3d-d194-1efa1d1b44a6@codeaurora.org> <63d73995-4dfa-6270-ca13-972e0628011b@deltatee.com> <bed80d4e-7709-5991-498e-0ac361ca96a6@codeaurora.org> <ef507444-d3e5-0454-86a0-b5c4ae4b4dd9@deltatee.com>
Subject: Re: [RFC 1/8] Introduce Peer-to-Peer memory (p2pmem) device
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> On 02/04/17 03:03 PM, Sinan Kaya wrote:
>> Push the decision all the way to the user. Let them decide whether they
>> want this feature to work on a root port connected port or under the
>> switch.
> 
> Yes, I prefer this too. If other folks agree with that I'd be very happy
> to go back to user chooses. I think Sagi was the most vocal proponent
> for kernel chooses at LSF so hopefully he will read this thread and
> offer some opinion.
> 
>> I thought the issue was feature didn't work at all with some root ports
>> or there was some kind of memory corruption issue that you were trying to
>> avoid with the existing systems.
> 
> I *think* there are some much older root ports where P2P TLPs don't even
> get through. But it doesn't really change the situation: in the nvmet
> case, the user would enable p2pmem and then be unable to connect and
> thus choose to disable it going forward. Not a big difference from the
> user seeing bad performance and not choosing to enable it.
> 
>> I think you should get rid of all pci searching business in your code.
> 
> Yes, my original proposal was when you configure the nvme target you
> chose the specific p2pmem device to use. That code had no tie ins to PCI
> code and could, in theory, work generically with any device and bus.
> 

I would add one issue that doesn't seem to be addressed: in my experience
P2P doesn't work when IOMMU activated. It works best with deactivation at
the BIOS level, even the kernel options are not enough in some cases.

This is another argument to leave the chose to user/integrator.

Marta
