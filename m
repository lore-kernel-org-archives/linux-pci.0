Return-Path: <SRS0=oEMe=K7=gigaio.com=kchow@kernel.org>
Return-Path: <SRS0=oEMe=K7=gigaio.com=kchow@kernel.org>
Subject: Re: IOAT DMA w/IOMMU
To: Logan Gunthorpe <logang@deltatee.com>, Eric Pilmore <epilmore@gigaio.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
 David Woodhouse <dwmw2@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 iommu@lists.linux-foundation.org,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <CAOQPn8soxubJxb=vp7kz+AM6LbPH5y+_Nx0Vzv7rjV_nMMqEmA@mail.gmail.com>
 <20180809184331.GB113140@bhelgaas-glaptop.roam.corp.google.com>
 <CAOQPn8uPYKai49WYPqZp2wNd5of=0hUvPOHEtqP56RZu-hcjuw@mail.gmail.com>
 <b54899a8-a144-e8e0-9880-1800c4657b95@deltatee.com>
 <CAOQPn8tSNN+3igN-kMcQH46w_a9p6T+S7=c8CLREMLxr1kaTXQ@mail.gmail.com>
 <7068db44-af31-4462-f966-2dd2340ba0f0@deltatee.com>
From: Kit Chow <kchow@gigaio.com>
Message-ID: <695826a6-e10c-5a30-a51f-7cc61ba6e640@gigaio.com>
Date: Thu, 16 Aug 2018 10:16:14 -0700
MIME-Version: 1.0
In-Reply-To: <7068db44-af31-4462-f966-2dd2340ba0f0@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>


On 08/09/2018 02:36 PM, Logan Gunthorpe wrote:
>
> On 09/08/18 03:31 PM, Eric Pilmore wrote:
>> On Thu, Aug 9, 2018 at 12:35 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
>>> Hey,
>>>
>>> On 09/08/18 12:51 PM, Eric Pilmore wrote:
>>>>>> Was wondering if anybody here has used IOAT DMA engines with an
>>>>>> IOMMU turned on (Xeon based system)? My specific question is really
>>>>>> whether it is possible to DMA (w/IOAT) to a PCI BAR address as the
>>>>>> destination without having to map that address to the IOVA space of
>>>>>> the DMA engine first (assuming the IOMMU is on)?
>>> I haven't tested this scenario but my guess would be that IOAT would
>>> indeed go through the IOMMU and the PCI BAR address would need to be
>>> properly mapped into the IOAT's IOVA. The fact that you see DMAR errors
>>> is probably a good indication that this is the case. I really don't know
>>> why you'd want to DMA something without mapping it.
>> The thought was to avoid paying the price of having to go through yet another
>> translation and also because it was not believed to be necessary anyway since
>> the DMA device could go straight to a PCI BAR address without the need for a
>> mapping.  We have been playing with two DMA engines, IOAT and PLX. The
>> PLX does not have any issues going straight to the PCI BAR address, but unlike
>> IOAT, PLX is sitting "in the PCI tree".
> Yes, you can do true P2P transactions with the PLX DMA engine. (Though
> you do have to be careful as technically you need to translate to a PCI
> bus address not the CPU physical address which are the same on x86; and
> you need to watch that ACS doesn't mess it up).
>
> It doesn't sound like it's possible to avoid the IOMMU when using the
> IOAT so you need the mapping. I would not expect the extra translation
> in the IOMMU to be noticeable, performance wise.
>
> Logan
Hi Logan,

Based on Dave Jiang's suggestion, I am looking into upstreaming the
ntb change to dma map the pci bar address in ntb_async_tx_submit() 
(along with
the intel iommu change to support dma_map_resource).

I only have access to intel hosts for testing (and possibly an AMD
host currently collecting dust) and am not sure how to go about getting
the proper test coverage for other architectures.

Any suggestions? Do you anticipate any issues with dma mapping the pci bar
address in ntb_async_tx_submit on non-x86 archs?  Do you or know of folks
who have ntb test setups with non-x86 hosts who might be able to help?

Thanks
Kit
