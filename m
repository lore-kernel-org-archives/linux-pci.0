Return-Path: <SRS0=mMqN=35=gmail.com=dan.j.williams@kernel.org>
Return-Path: <SRS0=mMqN=35=gmail.com=dan.j.williams@kernel.org>
MIME-Version: 1.0
Sender: dan.j.williams@gmail.com
In-Reply-To: <D090F830-2753-4479-A291-CEE37DC0A853@raithlin.com>
References: <20170418164557.GA7181@obsidianresearch.com> <cce00131-1f28-27b3-40ab-04f8783f1e5a@deltatee.com>
 <20170418190138.GH7181@obsidianresearch.com> <df1351d8-b86c-2e21-1948-4688ece5dc2b@deltatee.com>
 <CAPcyv4gScx6A7vG9VEHpNF41GOy1Nxst7QQ3QC3uZ54bWoxbMg@mail.gmail.com>
 <20170418210339.GA24257@obsidianresearch.com> <1492564806.25766.124.camel@kernel.crashing.org>
 <20170419155557.GA8497@obsidianresearch.com> <4899b011-bdfb-18d8-ef00-33a1516216a6@deltatee.com>
 <CAPcyv4iJ9H8Ykwnjqa2R_D1qG6PsSQmi=QxYH-rKLF_ihrsWyw@mail.gmail.com>
 <20170419173225.GA11255@redhat.com> <CAPcyv4gxBgVsbSez7_dZYkZojUWU0X0txs7FxiJ+Z3xsMt6TqQ@mail.gmail.com>
 <D79A59A8-DC7E-413F-ABB8-05F373A9DFD4@raithlin.com> <CAPcyv4i+a_14E58SjFHncyq2O2-zf_PB=aT7k0a-Jc0XsfPapQ@mail.gmail.com>
 <D090F830-2753-4479-A291-CEE37DC0A853@raithlin.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 20 Apr 2017 21:59:42 -0700
Message-ID: <CAA9_cmcQaPmF_uGP1FwUW0tO-4xtyJq07opfKcj9FGdADkedgg@mail.gmail.com>
Subject: Re: [RFC 0/8] Copy Offload with Peer-to-Peer PCI Memory
To: Stephen Bates <sbates@raithlin.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
	"James E.J. Bottomley" <jejb@linux.vnet.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, Steve Wise <swise@opengridcomputing.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>, Jerome Glisse <jglisse@redhat.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, linux-nvdimm <linux-nvdimm@ml01.01.org>,
	Max Gurtovoy <maxg@mellanox.com>, linux-scsi <linux-scsi@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 20, 2017 at 4:07 PM, Stephen  Bates <sbates@raithlin.com> wrote=
:
>>> Yes, this makes sense I think we really just want to distinguish host
>>> memory or not in terms of the dev_pagemap type.
>>
>>> I would like to see mutually exclusive flags for host memory (or not) a=
nd persistence (or not).
>>>
>>
>> Why persistence? It has zero meaning to the mm.
>
> I like the idea of having properties of the memory in one place.

We do have memory type data in the global iomem_resource tree, see
IORES_DESC_PERSISTENT_MEMORY.

> While mm might not use persistence today it may make use certain things t=
hat
> persistence implies (like finite endurance and/or higher write latency) i=
n the future.

A persistence flag does not convey endurance or latency information.

> Also the persistence of the memory must have issues for mm security?

Not for the mm, data at rest security might be a property of the
device, but that's not the mm's concern.

>Again not addressed today but useful in the future.

Maybe, but to me "Useful for the future" =3D=3D "don't add it to the
kernel until that future arrives".

> In addition I am not sure where else would be an appropriate place to put=
 something like a persistence property flag. I know the NVDIMM section of t=
he kernel uses things like NFIT to describe properties of the memory but we=
 don=E2=80=99t yet (to my knowledge) have something similar for IO memory.

Do the IORES_DESC flags give you what you need?
