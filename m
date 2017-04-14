Return-Path: <SRS0=mpUv=3W=kernel.crashing.org=benh@kernel.org>
Return-Path: <SRS0=mpUv=3W=kernel.crashing.org=benh@kernel.org>
Message-ID: <1492207643.25766.18.camel@kernel.crashing.org>
Subject: Re: [RFC 0/8] Copy Offload with Peer-to-Peer PCI Memory
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <helgaas@kernel.org>, Logan Gunthorpe <logang@deltatee.com>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        Christoph Hellwig
 <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        "James E.J. Bottomley"
 <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen"
 <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Steve Wise
 <swise@opengridcomputing.com>,
        Stephen Bates <sbates@raithlin.com>, Max
 Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-rdma@vger.kernel.org, linux-nvdimm@ml01.01.org,
        linux-kernel@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>
Date: Sat, 15 Apr 2017 08:07:23 +1000
In-Reply-To: <20170414190452.GA15679@bhelgaas-glaptop.roam.corp.google.com>
References: <1490911959-5146-1-git-send-email-logang@deltatee.com>
	 <1491974532.7236.43.camel@kernel.crashing.org>
	 <5ac22496-56ec-025d-f153-140001d2a7f9@deltatee.com>
	 <1492034124.7236.77.camel@kernel.crashing.org>
	 <81888a1e-eb0d-cbbc-dc66-0a09c32e4ea2@deltatee.com>
	 <20170413232631.GB24910@bhelgaas-glaptop.roam.corp.google.com>
	 <20170414041656.GA30694@obsidianresearch.com>
	 <1492169849.25766.3.camel@kernel.crashing.org>
	 <630c1c63-ff17-1116-e069-2b8f93e50fa2@deltatee.com>
	 <20170414190452.GA15679@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2017-04-14 at 14:04 -0500, Bjorn Helgaas wrote:
> I'm a little hesitant about excluding offset support, so I'd like to
> hear more about this.
> 
> Is the issue related to PCI BARs that are not completely addressable
> by the CPU?  If so, that sounds like a first-class issue that should
> be resolved up front because I don't think the PCI core in general
> would deal well with that.
> 
> If all the PCI memory of interest is in fact addressable by the CPU,
> I would think it would be pretty straightforward to support offsets
> --
> everywhere you currently use a PCI bus address, you just use the
> corresponding CPU physical address instead.

It's not *that* easy sadly. The reason is that normal dma map APIs
assume the "target" of the DMAs are system memory, there is no way to
pass it "another device", in a way that allows it to understand the
offsets if needed.

That said, dma_map will already be problematic when doing p2p behind
the same bridge due to the fact that the iommu is not in the way so you
can't use the arch standard ops there.

So I assume the p2p code provides a way to address that too via special
dma_ops ? Or wrappers ?

Basically there are two very different ways you can do p2p, either
behind the same host bridge or accross two host bridges:

 - Behind the same host bridge, you don't go through the iommu, which
means that even if your target looks like a struct page, you can't just
use dma_map_* on it because what you'll get back from that is an iommu
token, not a sibling BAR offset. Additionally, if you use the target
struct resource address, you will need to offset it to get back to the
actual BAR value on the PCIe bus.

 - Behind different host bridges, then you go through the iommu and the
host remapping. IE. that's actually the easy case. You can probably
just use the normal iommu path and normal dma mapping ops, you just
need to have your struct page representing the target device BAR *in
CPU space* this time. So no offsetting required either.

The problem is that the latter while seemingly easier, is also slower
and not supported by all platforms and architectures (for example,
POWER currently won't allow it, or rather only allows a store-only
subset of it under special circumstances).

So what people practically want to do is to have 2 devices behind a
switch DMA'ing to/from each other.

But that brings the 2 problems above.

I don't fully understand how p2pmem "solves" that by creating struct
pages. The offset problem is one issue. But there's the iommu issue as
well, the driver cannot just use the normal dma_map ops.

I haven't had a chance to look at the details of the patches but it's
not clear from the description in patch 0 how that is solved.

Cheers,
Ben.
