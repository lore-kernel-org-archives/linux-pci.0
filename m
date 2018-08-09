Return-Path: <SRS0=0wuL=KY=gigaio.com=epilmore@kernel.org>
Return-Path: <SRS0=0wuL=KY=gigaio.com=epilmore@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180809184331.GB113140@bhelgaas-glaptop.roam.corp.google.com>
References: <CAOQPn8soxubJxb=vp7kz+AM6LbPH5y+_Nx0Vzv7rjV_nMMqEmA@mail.gmail.com>
 <20180809184331.GB113140@bhelgaas-glaptop.roam.corp.google.com>
From: Eric Pilmore <epilmore@gigaio.com>
Date: Thu, 9 Aug 2018 11:51:53 -0700
Message-ID: <CAOQPn8uPYKai49WYPqZp2wNd5of=0hUvPOHEtqP56RZu-hcjuw@mail.gmail.com>
Subject: Re: IOAT DMA w/IOMMU
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
	Logan Gunthorpe <logang@deltatee.com>, Alex Williamson <alex.williamson@redhat.com>,
	iommu@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 9, 2018 at 11:43 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> [+cc David, Logan, Alex, iommu list]
>
> On Thu, Aug 09, 2018 at 11:14:13AM -0700, Eric Pilmore wrote:
>> Didn't get any response on the IRC channel so trying here.
>>
>> Was wondering if anybody here has used IOAT DMA engines with an
>> IOMMU turned on (Xeon based system)? My specific question is really
>> whether it is possible to DMA (w/IOAT) to a PCI BAR address as the
>> destination without having to map that address to the IOVA space of
>> the DMA engine first (assuming the IOMMU is on)?
>
> So is this a peer-to-peer DMA scenario?  You mention DMA, which would
> be a transaction initiated by a PCI device, to a PCI BAR address, so
> it doesn't sound like system memory is involved.

No, not peer-to-peer.  This is from system memory (e.g. SKB buffer which
has had an IOMMU mapping created) to a PCI BAR address.

>
> I copied some folks who know a lot more about this than I do.

Thank you!


>
>> I am encountering issues where I see PTE Errors reported from DMAR
>> in this scenario, but I do not if I use a different DMA engine
>> that's sitting downstream off the PCI tree. I'm wondering if the
>> IOAT DMA failure is some artifact of these engines sitting behind
>> the Host Bridge.
>>
>> Thanks in advance!
>> Eric
