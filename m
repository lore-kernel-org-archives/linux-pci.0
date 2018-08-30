Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-it0-f54.google.com ([209.85.214.54]:37272 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbeH3XPA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Aug 2018 19:15:00 -0400
Received: by mail-it0-f54.google.com with SMTP id h20-v6so4163117itf.2
        for <linux-pci@vger.kernel.org>; Thu, 30 Aug 2018 12:11:22 -0700 (PDT)
Subject: Re: [PATCH v5 07/13] block: Add PCI P2P flag for request queue and
 check support for requests
To: Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-block@vger.kernel.org
Cc: Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20180830185352.3369-1-logang@deltatee.com>
 <20180830185352.3369-8-logang@deltatee.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b5ab8fa3-34ac-3117-fa0d-5206c3939435@kernel.dk>
Date: Thu, 30 Aug 2018 13:11:18 -0600
MIME-Version: 1.0
In-Reply-To: <20180830185352.3369-8-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 8/30/18 12:53 PM, Logan Gunthorpe wrote:
> QUEUE_FLAG_PCI_P2P is introduced meaning a driver's request queue
> supports targeting P2P memory.
> 
> When a request is submitted we check if PCI P2PDMA memory is assigned
> to the first page in the bio. If it is, we ensure the queue it's
> submitted to supports it, and enforce REQ_NOMERGE.

I think this belongs in the caller - both the validity check, and
passing in NOMERGE for this type of request. I don't want to impose
this overhead on everything, for a pretty niche case.

-- 
Jens Axboe
