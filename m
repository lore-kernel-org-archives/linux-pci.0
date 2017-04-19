Return-Path: <SRS0=hWz2=33=intel.com=dan.j.williams@kernel.org>
Return-Path: <SRS0=hWz2=33=intel.com=dan.j.williams@kernel.org>
MIME-Version: 1.0
In-Reply-To: <99a22044-8f15-f381-19ee-e239e9d2da29@deltatee.com>
References: <20170418164557.GA7181@obsidianresearch.com> <cce00131-1f28-27b3-40ab-04f8783f1e5a@deltatee.com>
 <20170418190138.GH7181@obsidianresearch.com> <df1351d8-b86c-2e21-1948-4688ece5dc2b@deltatee.com>
 <CAPcyv4gScx6A7vG9VEHpNF41GOy1Nxst7QQ3QC3uZ54bWoxbMg@mail.gmail.com>
 <20170418210339.GA24257@obsidianresearch.com> <1492564806.25766.124.camel@kernel.crashing.org>
 <20170419155557.GA8497@obsidianresearch.com> <4899b011-bdfb-18d8-ef00-33a1516216a6@deltatee.com>
 <CAPcyv4iJ9H8Ykwnjqa2R_D1qG6PsSQmi=QxYH-rKLF_ihrsWyw@mail.gmail.com>
 <20170419173225.GA11255@redhat.com> <CAPcyv4gxBgVsbSez7_dZYkZojUWU0X0txs7FxiJ+Z3xsMt6TqQ@mail.gmail.com>
 <c75b6f6e-2814-1be3-d044-e153849263ce@deltatee.com> <99a22044-8f15-f381-19ee-e239e9d2da29@deltatee.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 19 Apr 2017 11:30:06 -0700
Message-ID: <CAPcyv4hPT3hEWC+q+DvQ_1o3rjeXsKmcRZT4GdKj9wFFVhdFpg@mail.gmail.com>
Subject: Re: [RFC 0/8] Copy Offload with Peer-to-Peer PCI Memory
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Jerome Glisse <jglisse@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>, "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>, linux-rdma@vger.kernel.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, Steve Wise <swise@opengridcomputing.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>, Bjorn Helgaas <helgaas@kernel.org>,
	linux-pci@vger.kernel.org, linux-nvdimm <linux-nvdimm@ml01.01.org>,
	Max Gurtovoy <maxg@mellanox.com>, linux-scsi <linux-scsi@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 19, 2017 at 11:19 AM, Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
> On 19/04/17 12:11 PM, Logan Gunthorpe wrote:
>>
>>
>> On 19/04/17 11:41 AM, Dan Williams wrote:
>>> No, not quite ;-). I still don't think we should require the non-HMM
>>> to pass NULL for all the HMM arguments. What I like about Logan's
>>> proposal is to have a separate create and register steps dev_pagemap.
>>> That way call paths that don't care about HMM specifics can just turn
>>> around and register the vanilla dev_pagemap.
>>
>> Would you necessarily even need a create step? I was thinking more along
>> the lines that struct dev_pagemap _could_ just be a member in another
>> structure. The caller would set the attributes they needed and pass it
>> to devm_memremap. (Similar to how we commonly do things with struct
>> device, et al). Potentially, that could also get rid of the need for the
>> *data pointer HMM is using to get back the struct hmm_devmem seeing
>> container_of could be used instead.
>
> Also, now that I've thought about it a little more, it _may_ be that
> many or all of the hmm specific fields in dev_pagemap could move to a
> containing struct too...

Yes, that's already how we handle struct page_map, it's an internal
implementation detail of devm_memremap_pages().

Letting others users do the container_of() arrangement means that
struct page_map needs to become public and move into struct
dev_pagemap directly.

...I think that encapsulation loss is worth it for the gain of clearly
separating the HMM-case from the base case.
