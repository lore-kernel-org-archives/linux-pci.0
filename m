Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:57079 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751932AbdDCWKk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 3 Apr 2017 18:10:40 -0400
To: Dan Williams <dan.j.williams@intel.com>
References: <1490911959-5146-1-git-send-email-logang@deltatee.com>
 <1490911959-5146-6-git-send-email-logang@deltatee.com>
 <20170331070950.GA9059@infradead.org>
 <435d4471-436b-87e6-8827-c9fc6cbdde2c@deltatee.com>
 <445bc352-75d7-438f-96ef-c2411215628d@deltatee.com>
 <CAPcyv4g=MHbjbY0GFPoLq3wAGwhcC7813O7iLUWGEChWh0M7Dw@mail.gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Keith Busch <keith.busch@intel.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        Steve Wise <swise@opengridcomputing.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <ff0dd5ec-2562-9f1d-1335-d0a8813f2f50@deltatee.com>
Date: Mon, 3 Apr 2017 16:10:27 -0600
MIME-Version: 1.0
In-Reply-To: <CAPcyv4g=MHbjbY0GFPoLq3wAGwhcC7813O7iLUWGEChWh0M7Dw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [RFC 5/8] scatterlist: Modify SG copy functions to support io
 memory.
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 03/04/17 03:44 PM, Dan Williams wrote:
> On Mon, Apr 3, 2017 at 2:20 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
>> Hi Christoph,
>>
>> What are your thoughts on an approach like the following untested
>> draft patch.
>>
>> The patch (if fleshed out) makes it so iomem can be used in an sgl
>> and WARN_ONs will occur in places where drivers attempt to access
>> iomem directly through the sgl.
>>
>> I'd also probably create a p2pmem_alloc_sgl helper function so driver
>> writers wouldn't have to mess with sg_set_iomem_page.
>>
>> With all that in place, it should be relatively safe for drivers to
>> implement p2pmem even though we'd still technically be violating the
>> __iomem boundary in some places.
> 
> Just reacting to this mail, I still haven't had a chance to take a
> look at the rest of the series.
> 
> The pfn_t type was invented to carry extra type and page lookup
> information about the memory behind a given pfn. At first glance that
> seems a more natural place to carry an indication that this is an
> "I/O" pfn.

I agree... But what are the plans for pfn_t? Is anyone working on using
it in the scatterlist code? Currently it's not there yet and given the
assertion that we will continue to be using struct page for DMA is that
a direction we'd want to go?

Logan
