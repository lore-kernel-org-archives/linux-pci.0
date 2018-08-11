Return-Path: <SRS0=qTcG=K2=deltatee.com=logang@kernel.org>
Return-Path: <SRS0=qTcG=K2=deltatee.com=logang@kernel.org>
To: Kit Chow <kchow@gigaio.com>, Dave Jiang <dave.jiang@intel.com>,
 Eric Pilmore <epilmore@gigaio.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
References: <CAOQPn8soxubJxb=vp7kz+AM6LbPH5y+_Nx0Vzv7rjV_nMMqEmA@mail.gmail.com>
 <95e53520-b05f-4be4-e694-463d717453a8@gigaio.com>
 <cdd9245f-eb23-9e10-1755-8f396a2cd255@deltatee.com>
 <b278c1e5-6f08-c879-a27d-7fc172645fd5@gigaio.com>
 <f04fae39-645e-3c6e-07c0-b194260bf5de@deltatee.com>
 <3f503940-db6a-ec75-ed15-1db99d5d48ef@gigaio.com>
 <112A412BB11A1242B37129D931BCE5348382CFB2@fmsmsx117.amr.corp.intel.com>
 <b8af340c-d40b-cb8c-987f-b394f1d6ec3e@gigaio.com>
 <adf51c74-36fa-b61d-8497-27bd75178ba4@deltatee.com>
 <aa9c3f41-efc9-8c68-a517-2736c8986621@gigaio.com>
 <1170c096-a749-6ee3-32d4-ebba1d12adff@gigaio.com>
 <929f3dfa-fbff-c582-3be5-c368f11feb7e@deltatee.com>
 <460cc47f-6a8e-67b0-01a0-02f0c51df258@intel.com>
 <0f653f8f-c7ae-831d-e238-2742590d9ea1@deltatee.com>
 <6525fa4d-7d9b-0136-7206-f8351230af46@intel.com>
 <f22c565e-ba49-c83d-3e51-7967664c7136@deltatee.com>
 <499934e7-3734-1aee-37dd-b42a5d2a2608@intel.com>
 <9d135f61-20c2-e966-4d7d-3e154384ea08@gigaio.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <0a9fa9c3-dbe4-6451-9c1a-06b662702f61@deltatee.com>
Date: Fri, 10 Aug 2018 20:10:20 -0600
MIME-Version: 1.0
In-Reply-To: <9d135f61-20c2-e966-4d7d-3e154384ea08@gigaio.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: IOAT DMA w/IOMMU
List-ID: <linux-pci.vger.kernel.org>



On 10/08/18 06:53 PM, Kit Chow wrote:
> I was able to finally succeed in doing the dma transfers over ioat only
> when prot has DMA_PTE_WRITE set by setting the direction to either
> DMA_FROM_DEVICE or DMA_BIDIRECTIONAL. Any ideas if the prot settings
> need to be changed? Are there any bad side effects if I used
> DMA_BIDIRECTIONAL?

Good to hear it. Without digging into the direction much all I can say
is that it can sometimes be very confusing what the direction is. Adding
another PCI device just adds to the confusion.

I believe, the direction should be from the IOAT's point of view. So if
the IOAT is writing to the BAR you'd set DMA_FROM_DEVICE (ie. data is
coming from the IOAT) and if it's reading you'd set DMA_TO_DEVICE (ie.
data is going to the IOAT).

Using DMA_BIDIRECTIONAL just forgoes any hardware security / protection
that the buffer would have in terms of direction. Generally it's good
practice to use the strictest direction you can.

> Given that using the pci bar address as is without getting an iommu
> address results in the same "PTE Write access" error, I wonder if there
> is some internal 'prot' associated with the non-translated pci bar
> address that just needs to be tweaked to include DMA_PTE_WRITE???

No, I don't think so. The 'prot' will be a property of the IOMMU. Not
having an entry is probably just the same (from the perspective of the
error you see) as only having an entry for reading.

Logan
