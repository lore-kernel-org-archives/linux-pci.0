Return-Path: <SRS0=GJHp=32=intel.com=dan.j.williams@kernel.org>
Return-Path: <SRS0=GJHp=32=intel.com=dan.j.williams@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170418210339.GA24257@obsidianresearch.com>
References: <CAPcyv4it56J8Voo6kV0bBcO3nHsOHYLENpAtONJZTGceDDwNPg@mail.gmail.com>
 <1492381396.25766.43.camel@kernel.crashing.org> <20170418164557.GA7181@obsidianresearch.com>
 <cce00131-1f28-27b3-40ab-04f8783f1e5a@deltatee.com> <20170418190138.GH7181@obsidianresearch.com>
 <df1351d8-b86c-2e21-1948-4688ece5dc2b@deltatee.com> <CAPcyv4gScx6A7vG9VEHpNF41GOy1Nxst7QQ3QC3uZ54bWoxbMg@mail.gmail.com>
 <20170418210339.GA24257@obsidianresearch.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 18 Apr 2017 14:11:33 -0700
Message-ID: <CAPcyv4h9n9Uzq4FAXR0ufieqvx5_txEwtnaaBWdxe-jF_XfTLg@mail.gmail.com>
Subject: Re: [RFC 0/8] Copy Offload with Peer-to-Peer PCI Memory
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Logan Gunthorpe <logang@deltatee.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
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

On Tue, Apr 18, 2017 at 2:03 PM, Jason Gunthorpe
<jgunthorpe@obsidianresearch.com> wrote:
> On Tue, Apr 18, 2017 at 12:48:35PM -0700, Dan Williams wrote:
>
>> > Yes, I noticed this problem too and that makes sense. It just means
>> > every dma_ops will probably need to be modified to either support p2p
>> > pages or fail on them. Though, the only real difficulty there is that it
>> > will be a lot of work.
>>
>> I don't think you need to go touch all dma_ops, I think you can just
>> arrange for devices that are going to do dma to get redirected to a
>> p2p aware provider of operations that overrides the system default
>> dma_ops. I.e. just touch get_dma_ops().
>
> I don't follow, when does get_dma_ops() return a p2p aware provider?
> It has no way to know if the DMA is going to involve p2p, get_dma_ops
> is called with the device initiating the DMA.
>
> So you'd always return the P2P shim on a system that has registered
> P2P memory?
>
> Even so, how does this shim work? dma_ops are not really intended to
> be stacked. How would we make unmap work, for instance? What happens
> when the underlying iommu dma ops actually natively understands p2p
> and doesn't want the shim?
>
> I think this opens an even bigger can of worms..

No, I don't think it does. You'd only shim when the target page is
backed by a device, not host memory, and you can figure this out by a
is_zone_device_page()-style lookup.
