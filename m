Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:59364 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753696AbdDDP4y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Apr 2017 11:56:54 -0400
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
 <1490911959-5146-3-git-send-email-logang@deltatee.com>
 <f269d9e1-8dcf-7970-382e-cb0d9a020efc@grimberg.me>
Cc: linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <962a8dd8-4d09-0802-9569-00dbf29382d3@deltatee.com>
Date: Tue, 4 Apr 2017 09:56:48 -0600
MIME-Version: 1.0
In-Reply-To: <f269d9e1-8dcf-7970-382e-cb0d9a020efc@grimberg.me>
Content-Type: text/plain; charset=windows-1252
Subject: Re: [RFC 2/8] cxgb4: setup pcie memory window 4 and create p2pmem
 region
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 04/04/17 04:42 AM, Sagi Grimberg wrote:
> This is weird, why even call this if !use_p2pmem?

I personally find it cleaner than:

if (use_p2pmem)
	setup_memwin_p2pmem(...)

I'm not sure why that's so weird.

Logan
