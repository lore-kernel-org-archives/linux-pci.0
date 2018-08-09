Return-Path: <SRS0=Ly/z=KY=deltatee.com=logang@kernel.org>
Return-Path: <SRS0=Ly/z=KY=deltatee.com=logang@kernel.org>
To: Eric Pilmore <epilmore@gigaio.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 iommu@lists.linux-foundation.org
References: <CAOQPn8soxubJxb=vp7kz+AM6LbPH5y+_Nx0Vzv7rjV_nMMqEmA@mail.gmail.com>
 <20180809184331.GB113140@bhelgaas-glaptop.roam.corp.google.com>
 <CAOQPn8uPYKai49WYPqZp2wNd5of=0hUvPOHEtqP56RZu-hcjuw@mail.gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <b54899a8-a144-e8e0-9880-1800c4657b95@deltatee.com>
Date: Thu, 9 Aug 2018 13:35:07 -0600
MIME-Version: 1.0
In-Reply-To: <CAOQPn8uPYKai49WYPqZp2wNd5of=0hUvPOHEtqP56RZu-hcjuw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: IOAT DMA w/IOMMU
List-ID: <linux-pci.vger.kernel.org>

Hey,

On 09/08/18 12:51 PM, Eric Pilmore wrote:
>>> Was wondering if anybody here has used IOAT DMA engines with an
>>> IOMMU turned on (Xeon based system)? My specific question is really
>>> whether it is possible to DMA (w/IOAT) to a PCI BAR address as the
>>> destination without having to map that address to the IOVA space of
>>> the DMA engine first (assuming the IOMMU is on)?

I haven't tested this scenario but my guess would be that IOAT would
indeed go through the IOMMU and the PCI BAR address would need to be
properly mapped into the IOAT's IOVA. The fact that you see DMAR errors
is probably a good indication that this is the case. I really don't know
why you'd want to DMA something without mapping it.

>> So is this a peer-to-peer DMA scenario?  You mention DMA, which would
>> be a transaction initiated by a PCI device, to a PCI BAR address, so
>> it doesn't sound like system memory is involved.
> 
> No, not peer-to-peer.  This is from system memory (e.g. SKB buffer which
> has had an IOMMU mapping created) to a PCI BAR address.

It's definitely peer-to-peer in the case where you are using a DMA
engine in the PCI tree. You have the DMA PCI device sending TLPs
directly to the PCI BAR device. So, if everything is done right, the
TLPs will avoid the root complex completely. (Though, ACS settings could
also prevent this from working and you'd either get similar DMAR errors
or they'd disappear into a black hole).

When using the IOAT, it is part of the CPU so I wouldn't say it's really
peer-to-peer. But an argument could be made that it is. Though, this is
exactly what the existing ntb_transport is doing: DMAing from system
memory to a PCI BAR and vice versa using IOAT.

Logan
