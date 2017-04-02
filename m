Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:53026 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750916AbdDBRV0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 2 Apr 2017 13:21:26 -0400
To: Sinan Kaya <okaya@codeaurora.org>
References: <1490911959-5146-1-git-send-email-logang@deltatee.com>
 <1490911959-5146-2-git-send-email-logang@deltatee.com>
 <cb102386-0314-a3a3-ed44-b42debdf1512@codeaurora.org>
 <7158f2e8-2016-f398-e77f-0fcbe6cb41dd@deltatee.com>
 <e6a74aeb-9f54-51c5-8ad9-3b6fb92c03b3@codeaurora.org>
 <0280fbb4-ba9e-ac64-6bb3-b72590a54e57@deltatee.com>
 <0ae27bca-21be-b89c-aba4-6cc9766ebd7b@codeaurora.org>
 <c8edc480-a2ac-a763-8438-18f3396db483@deltatee.com>
 <e2165253dc355d5cb223e754d78047b1@codeaurora.org>
 <c5d7da85-41fd-2769-fcf8-b3c2a1fab95f@deltatee.com>
 <f0448277-9381-5c3d-d194-1efa1d1b44a6@codeaurora.org>
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
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <63d73995-4dfa-6270-ca13-972e0628011b@deltatee.com>
Date: Sun, 2 Apr 2017 11:21:05 -0600
MIME-Version: 1.0
In-Reply-To: <f0448277-9381-5c3d-d194-1efa1d1b44a6@codeaurora.org>
Content-Type: text/plain; charset=windows-1252
Subject: Re: [RFC 1/8] Introduce Peer-to-Peer memory (p2pmem) device
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 01/04/17 08:26 PM, Sinan Kaya wrote:
> I recommended a combination of blacklist + p2p capability + BIOS date.
> Not just BIOS date. BIOS date by itself is useless.

Well this proposal doesn't work for me at all. None of my hardware has
the p2p ACS capability and my BIOS date is in 2013 and yet my switch
works perfectly fine. You're going to have to make the case that ACS p2p
capabilities are somehow correlated with a device's ability to move TLPs
between ports with reasonable performance. (For example my sandy bridge
CPU does support p2p transactions fine, it just doesn't have great
performance.) The documentation doesn't suggest this nor can I even find
(via google) any lspci dump that suggest there is hardware that sets
this p2p capability. The ACS P2P flag is meant to indicate something
completely different from what you are proposing using it for: it's
meant to indicate the ability to manage permissions of p2p destined TLPs
not the ability to efficiently transfer them.

> This is when the BIOS date helps so that you don't break existing systems.

I'm not that worried about this code breaking existing systems. There
are significant trade-offs with using p2pmem (ie. you are quite likely
sacrificing performance for memory QOS or upstream PCI bandwidth), and
therefore the user _has_ to specifically say to use it. This is why
we've put a flag in the nvme target code that defaults to off. Thus we
are not going to have a situation where people upgrade their kernels and
see broken or slow systems. People _have_ to make the decision to turn
it on and decide based on their use case whether it's appropriate.

> We can't guarentee all switches will work either. See above for instructions
> on when this feature should be enabled.

It's a lot easier to say that all switches will work than it is for root
ports. This is essentially what switches are designed for, so I'd be
surprised to find one that doesn't work. Root ports are the trouble here
seeing it's a lot more likely for them to be designed without
considering that traffic needs to move between ports efficiently. If we
do find extremely broken switches that don't support this then we'd
probably want to create a black list for that. Also, there's
significantly fewer PCI switch products on the market than there are
root port instances, so a black list would be much easier to manage there.

> If we think about logical blocks here, p2pmem is a pci user. 

Well technically, the only thing that ties p2pmem to pci is the concept
of which devices to allow it's use with. There's absolutely no reason
why any other bus couldn't use the same code and just say any devices on
that bus allow p2pmem.

>It should
> not walk the bus and search for possible good things by itself. We don't
> usually put code into the kernel's driver directory for specific arch/
> specific devices. There are hundreds of device drivers in the kernel. 
> None of them are guarenteed to work in any architecture but they don't
> prohibit use either.

I'd agree that the final code for determining p2p capability should
belong in the pci code. Or more likely an even more generic interface
with struct device that is bus agnostic. Though, I'd hope that a lot of
this could happen later when there are more kernel users actually
wanting to use this code. It's hard to design a generic interface when
you only have one user at present.

> p2pmem is potentially just one of the many users of p2p capability in the
> system.

Yup, we've had similar feedback from Max. However, without knowing the
needs of a generic p2p device at this point, it's hard to consider this
at all. I am open to it though.

Logan
