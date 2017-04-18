Return-Path: <SRS0=GJHp=32=intel.com=dan.j.williams@kernel.org>
Return-Path: <SRS0=GJHp=32=intel.com=dan.j.williams@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170418180020.GE7181@obsidianresearch.com>
References: <CAPcyv4it56J8Voo6kV0bBcO3nHsOHYLENpAtONJZTGceDDwNPg@mail.gmail.com>
 <1492381396.25766.43.camel@kernel.crashing.org> <20170418164557.GA7181@obsidianresearch.com>
 <CAPcyv4izLa2vw12ysvVfd=ysaMKcASNFm+=CaqDKhnPY9B5OJg@mail.gmail.com> <20170418180020.GE7181@obsidianresearch.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 18 Apr 2017 11:34:56 -0700
Message-ID: <CAPcyv4j16W_Q9m1X=GkgMYAyZ1JC3H_=+1CLxfB6CSqVEdWaMw@mail.gmail.com>
Subject: Re: [RFC 0/8] Copy Offload with Peer-to-Peer PCI Memory
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Logan Gunthorpe <logang@deltatee.com>,
	Bjorn Helgaas <helgaas@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	"James E.J. Bottomley" <jejb@linux.vnet.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>, Steve Wise <swise@opengridcomputing.com>,
	Stephen Bates <sbates@raithlin.com>, Max Gurtovoy <maxg@mellanox.com>,
	Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
	linux-scsi <linux-scsi@vger.kernel.org>, linux-nvme@lists.infradead.org,
	linux-rdma@vger.kernel.org, linux-nvdimm <linux-nvdimm@ml01.01.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jerome Glisse <jglisse@redhat.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 18, 2017 at 11:00 AM, Jason Gunthorpe
<jgunthorpe@obsidianresearch.com> wrote:
> On Tue, Apr 18, 2017 at 10:27:47AM -0700, Dan Williams wrote:
>> > FWIW, RDMA probably wouldn't want to use a p2mem device either, we
>> > already have APIs that map BAR memory to user space, and would like to
>> > keep using them. A 'enable P2P for bar' helper function sounds better
>> > to me.
>>
>> ...and I think it's not a helper function as much as asking the bus
>> provider "can these two device dma to each other".
>
> What I mean I could write in a RDMA driver:
>
>   /* Allow the memory in BAR 1 to be the target of P2P transactions */
>   pci_enable_p2p_bar(dev, 1);
>
> And not require anything else..
>
>> The "helper" is the dma api redirecting through a software-iommu
>> that handles bus address translation differently than it would
>> handle host memory dma mapping.
>
> Not sure, until we see what arches actually need to do here it is hard
> to design common helpers.
>
> Here are a few obvious things that arches will need to implement to
> support this broadly:
>
> - Virtualization might need to do a hypervisor call to get the right
>   translation, or consult some hypervisor specific description table.
>
> - Anything using IOMMUs for virtualization will need to setup IOMMU
>   permissions to allow the P2P flow, this might require translation to
>   an address cookie.
>
> - Fail if the PCI devices are in different domains, or setup hardware to
>   do completion bus/device/function translation.
>
> - All platforms can succeed if the PCI devices are under the same
>   'segment', but where segments begin is somewhat platform specific
>   knowledge. (this is 'same switch' idea Logan has talked about)
>
> So, we can eventually design helpers for various common scenarios, but
> until we see what arch code actually needs to do it seems
> premature. Much of this seems to involve interaction with some kind of
> hardware, or consulation of some kind of currently platform specific
> data, so I'm not sure what a software-iommu would be doing??
>
> The main thing to agree on is that this code belongs under dma ops and
> that arches have to support struct page mapped BAR addresses in their
> dma ops inputs. Is that resonable?

I think we're saying the same thing by "software-iommu" and "custom
dma_ops", so yes.
