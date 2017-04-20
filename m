Return-Path: <SRS0=VHUN=34=intel.com=dan.j.williams@kernel.org>
Return-Path: <SRS0=VHUN=34=intel.com=dan.j.williams@kernel.org>
MIME-Version: 1.0
In-Reply-To: <D79A59A8-DC7E-413F-ABB8-05F373A9DFD4@raithlin.com>
References: <20170418164557.GA7181@obsidianresearch.com> <cce00131-1f28-27b3-40ab-04f8783f1e5a@deltatee.com>
 <20170418190138.GH7181@obsidianresearch.com> <df1351d8-b86c-2e21-1948-4688ece5dc2b@deltatee.com>
 <CAPcyv4gScx6A7vG9VEHpNF41GOy1Nxst7QQ3QC3uZ54bWoxbMg@mail.gmail.com>
 <20170418210339.GA24257@obsidianresearch.com> <1492564806.25766.124.camel@kernel.crashing.org>
 <20170419155557.GA8497@obsidianresearch.com> <4899b011-bdfb-18d8-ef00-33a1516216a6@deltatee.com>
 <CAPcyv4iJ9H8Ykwnjqa2R_D1qG6PsSQmi=QxYH-rKLF_ihrsWyw@mail.gmail.com>
 <20170419173225.GA11255@redhat.com> <CAPcyv4gxBgVsbSez7_dZYkZojUWU0X0txs7FxiJ+Z3xsMt6TqQ@mail.gmail.com>
 <D79A59A8-DC7E-413F-ABB8-05F373A9DFD4@raithlin.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 20 Apr 2017 13:47:19 -0700
Message-ID: <CAPcyv4i+a_14E58SjFHncyq2O2-zf_PB=aT7k0a-Jc0XsfPapQ@mail.gmail.com>
Subject: Re: [RFC 0/8] Copy Offload with Peer-to-Peer PCI Memory
To: Stephen Bates <sbates@raithlin.com>
Cc: Jerome Glisse <jglisse@redhat.com>, Logan Gunthorpe <logang@deltatee.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, Bjorn Helgaas <helgaas@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	"James E.J. Bottomley" <jejb@linux.vnet.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>, Steve Wise <swise@opengridcomputing.com>,
	Max Gurtovoy <maxg@mellanox.com>, Keith Busch <keith.busch@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, linux-scsi <linux-scsi@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, linux-nvdimm <linux-nvdimm@ml01.01.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 20, 2017 at 1:43 PM, Stephen  Bates <sbates@raithlin.com> wrote:
>
>> Yes, this makes sense I think we really just want to distinguish host
>> memory or not in terms of the dev_pagemap type.
>
> I would like to see mutually exclusive flags for host memory (or not) and persistence (or not).
>

Why persistence? It has zero meaning to the mm.
