Return-Path: <SRS0=g1/S=K7=deltatee.com=logang@kernel.org>
Return-Path: <SRS0=g1/S=K7=deltatee.com=logang@kernel.org>
To: Kit Chow <kchow@gigaio.com>, Eric Pilmore <epilmore@gigaio.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
 David Woodhouse <dwmw2@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 iommu@lists.linux-foundation.org
References: <CAOQPn8soxubJxb=vp7kz+AM6LbPH5y+_Nx0Vzv7rjV_nMMqEmA@mail.gmail.com>
 <20180809184331.GB113140@bhelgaas-glaptop.roam.corp.google.com>
 <CAOQPn8uPYKai49WYPqZp2wNd5of=0hUvPOHEtqP56RZu-hcjuw@mail.gmail.com>
 <b54899a8-a144-e8e0-9880-1800c4657b95@deltatee.com>
 <CAOQPn8tSNN+3igN-kMcQH46w_a9p6T+S7=c8CLREMLxr1kaTXQ@mail.gmail.com>
 <7068db44-af31-4462-f966-2dd2340ba0f0@deltatee.com>
 <695826a6-e10c-5a30-a51f-7cc61ba6e640@gigaio.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <0d3f48c3-8c4f-4dfb-e883-23c168f12b9b@deltatee.com>
Date: Thu, 16 Aug 2018 11:21:44 -0600
MIME-Version: 1.0
In-Reply-To: <695826a6-e10c-5a30-a51f-7cc61ba6e640@gigaio.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: IOAT DMA w/IOMMU
List-ID: <linux-pci.vger.kernel.org>



On 16/08/18 11:16 AM, Kit Chow wrote:
> I only have access to intel hosts for testing (and possibly an AMD
> host currently collecting dust) and am not sure how to go about getting
> the proper test coverage for other architectures.

Well, I thought you were only changing the Intel IOMMU implementation...
So testing on Intel hardware seems fine to me.

> Any suggestions? Do you anticipate any issues with dma mapping the pci bar
> address in ntb_async_tx_submit on non-x86 archs?  Do you or know of folks
> who have ntb test setups with non-x86 hosts who might be able to help?

I expect other IOMMUs will need to be updated to properly support
dma_map_resource but that will probably need to be done on a case by
case basis as the need arises. Unfortunately it seems the work to add
dma_map_resource() didn't really consider that the IOMMUs had to have
proper support and probably should have errored out instead of just
passing along the physical address if the IOMMU didn't have support.

I don't know of anyone with an NTB setup on anything but x86 at the moment.

Logan
