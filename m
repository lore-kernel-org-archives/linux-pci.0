Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:33951 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751808AbdDMWjE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Apr 2017 18:39:04 -0400
Message-ID: <1492123049.7236.123.camel@kernel.crashing.org>
Subject: Re: [RFC 0/8] Copy Offload with Peer-to-Peer PCI Memory
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Steve Wise <swise@opengridcomputing.com>,
        Stephen Bates <sbates@raithlin.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm@ml01.01.org, linux-kernel@vger.kernel.org,
        Jerome Glisse <jglisse@redhat.com>
Date: Fri, 14 Apr 2017 08:37:29 +1000
In-Reply-To: <81888a1e-eb0d-cbbc-dc66-0a09c32e4ea2@deltatee.com>
References: <1490911959-5146-1-git-send-email-logang@deltatee.com>
         <1491974532.7236.43.camel@kernel.crashing.org>
         <5ac22496-56ec-025d-f153-140001d2a7f9@deltatee.com>
         <1492034124.7236.77.camel@kernel.crashing.org>
         <81888a1e-eb0d-cbbc-dc66-0a09c32e4ea2@deltatee.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2017-04-13 at 15:22 -0600, Logan Gunthorpe wrote:
> 
> On 12/04/17 03:55 PM, Benjamin Herrenschmidt wrote:
> > Look at pcibios_resource_to_bus() and pcibios_bus_to_resource(). They
> > will perform the conversion between the struct resource content (CPU
> > physical address) and the actual PCI bus side address.
> 
> Ah, thanks for the tip! On my system, this translation returns the same
> address so it was not necessary. And, yes, that means this would have to
> find its way into the dma mapping routine somehow. This means we'll
> eventually need a way to look-up the p2pmem device from the struct page.
> Which means we will likely need a new flag bit in the struct page or
> something. The big difficulty I see is testing. Do you know what
> architectures or in what circumstances are these translations used?

I think a bunch of non-x86 architectures but I don't know which ones
outside of powerpc.

> > When behind the same switch you need to use PCI addresses. If one tries
> > later to do P2P between host bridges (via the CPU fabric) things get
> > more complex and one will have to use either CPU addresses or something
> > else alltogether (probably would have to teach the arch DMA mapping
> > routines to work with those struct pages you create and return the
> > right thing).
> 
> Probably for starters we'd want to explicitly deny cases between host
> bridges and add that later if someone wants to do the testing.

Cheers,
Ben.

> Thanks,
> 
> Logan
