Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:51916 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751571AbdCaViu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 31 Mar 2017 17:38:50 -0400
Subject: Re: [RFC 1/8] Introduce Peer-to-Peer memory (p2pmem) device
To: Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
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
 <1490911959-5146-2-git-send-email-logang@deltatee.com>
 <cb102386-0314-a3a3-ed44-b42debdf1512@codeaurora.org>
 <7158f2e8-2016-f398-e77f-0fcbe6cb41dd@deltatee.com>
Cc: linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <e6a74aeb-9f54-51c5-8ad9-3b6fb92c03b3@codeaurora.org>
Date: Fri, 31 Mar 2017 17:38:46 -0400
MIME-Version: 1.0
In-Reply-To: <7158f2e8-2016-f398-e77f-0fcbe6cb41dd@deltatee.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 3/31/2017 5:23 PM, Logan Gunthorpe wrote:
> What exactly would you white/black list? It can't be the NIC or the
> disk. If it's going to be a white/black list on the switch or root port
> then you'd need essentially the same code to ensure they are all behind
> the same switch or root port.

What is so special about being connected to the same switch?

Why don't we allow the feature by default and blacklist by the root ports
that don't work with a quirk.

I'm looking at this from portability perspective to be honest.

I'd rather see the feature enabled by default without any assumptions.
Using it with a switch is just a use case that you happened to test.
It can allow new architectures to use your code tomorrow.

Sinan
-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
