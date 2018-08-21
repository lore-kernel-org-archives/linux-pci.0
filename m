Return-Path: <SRS0=hyej=LE=deltatee.com=logang@kernel.org>
Return-Path: <SRS0=hyej=LE=deltatee.com=logang@kernel.org>
To: Eric Pilmore <epilmore@gigaio.com>
Cc: Kit Chow <kchow@gigaio.com>, Bjorn Helgaas <helgaas@kernel.org>,
 linux-pci@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 iommu@lists.linux-foundation.org
References: <CAOQPn8soxubJxb=vp7kz+AM6LbPH5y+_Nx0Vzv7rjV_nMMqEmA@mail.gmail.com>
 <20180809184331.GB113140@bhelgaas-glaptop.roam.corp.google.com>
 <CAOQPn8uPYKai49WYPqZp2wNd5of=0hUvPOHEtqP56RZu-hcjuw@mail.gmail.com>
 <b54899a8-a144-e8e0-9880-1800c4657b95@deltatee.com>
 <CAOQPn8tSNN+3igN-kMcQH46w_a9p6T+S7=c8CLREMLxr1kaTXQ@mail.gmail.com>
 <7068db44-af31-4462-f966-2dd2340ba0f0@deltatee.com>
 <695826a6-e10c-5a30-a51f-7cc61ba6e640@gigaio.com>
 <0d3f48c3-8c4f-4dfb-e883-23c168f12b9b@deltatee.com>
 <14db6acb-da4f-9604-7359-1671210fcb8b@gigaio.com>
 <ad2cd3f2-eb41-d4c2-7614-379c2e458352@deltatee.com>
 <CAOQPn8uuTEcmdQdZB9-A7FT+YWtxSuruGFwmwCPApffTJNs9Vg@mail.gmail.com>
 <41419ada-7f16-0028-1e43-3b4a6c6960b6@deltatee.com>
 <CAOQPn8uyozbmEV0Ww3LW4XDcaY1ZwV0yazsPxPQC0AfLNUhKYw@mail.gmail.com>
 <dd918b52-7ddc-662c-5980-edf3e96ebca2@deltatee.com>
 <CAOQPn8vO7wP2XGwyJALxkyeBFG6fkTAFgF8QcGiiJF0fOMBa4Q@mail.gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <b62adad7-6f39-8bb2-9aca-258cbf909d4d@deltatee.com>
Date: Tue, 21 Aug 2018 17:53:02 -0600
MIME-Version: 1.0
In-Reply-To: <CAOQPn8vO7wP2XGwyJALxkyeBFG6fkTAFgF8QcGiiJF0fOMBa4Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: IOAT DMA w/IOMMU
List-ID: <linux-pci.vger.kernel.org>



On 21/08/18 05:45 PM, Eric Pilmore wrote:
> Well, the only difference between success and failure is running with the
> call to dma_map_resource for the destination address, which is a PCI BAR
> address. Prior to Kit introducing this call, we never created a mapping for the
> destination PCI BAR address and it worked fine on all systems when using
> PLX DMA. It was only when we went to a Xeon system and attempted to use
> IOAT DMA that we found we needed a mapping for that destination PCI BAR
> address.
> 
> The only thing the PLX driver does related to "mappings" is a call to
> dma_descriptor_unmap when the descriptor is freed, however that is more
> of an administrative step to clean up the unmap-data data structure used
> when the mapping was originally established.

Ah, so there's a big difference here in hardware. Without the mapping
call you are going to essentially be doing a P2P transaction. So the
TLPs won't even hit the CPU. With the mapping call, the TLPs will now
go through the CPU and IOMMU.

CPUs don't always have good support for routing PCI P2P transactions.
However, I would have expected a relatively new i7 CPU to support it
well. It may simply be that this CPU does not have good support, however
 that comes as a bit of a surprise to me. Our plans for the P2P
patch-set was to have a white-list for CPUs that work.

If you can, it would be worth hooking up a PCI analyzer to see what's
happening to the TLPs in both cases.

Logan
