Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:46602 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933114AbdCaPmD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 31 Mar 2017 11:42:03 -0400
To: Christoph Hellwig <hch@infradead.org>
References: <1490911959-5146-1-git-send-email-logang@deltatee.com>
 <1490911959-5146-6-git-send-email-logang@deltatee.com>
 <20170331070950.GA9059@infradead.org>
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
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <435d4471-436b-87e6-8827-c9fc6cbdde2c@deltatee.com>
Date: Fri, 31 Mar 2017 09:41:56 -0600
MIME-Version: 1.0
In-Reply-To: <20170331070950.GA9059@infradead.org>
Content-Type: text/plain; charset=windows-1252
Subject: Re: [RFC 5/8] scatterlist: Modify SG copy functions to support io
 memory.
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 31/03/17 01:09 AM, Christoph Hellwig wrote:
> You're calling memcpy_{to,from}_iomem on non-__iomem pointers.  This
> is a fundamental no-go as we keep I/O memory separate from kernel
> pointers.

Yes, that's true, however I don't know how we could get around that when
the iomem is referenced by struct pages inside a scatter gather list. Do
we need to now have special __iomem sgls? And even still, I'm not sure
how that could work when the nvme target code is using the same sgls to
sometimes point to iomem and sometimes point to regular memory.

I'm certainly open to suggestions, though.

Logan
