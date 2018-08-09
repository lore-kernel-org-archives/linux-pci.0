Return-Path: <SRS0=fEc7=KY=gigaio.com=kchow@kernel.org>
Return-Path: <SRS0=fEc7=KY=gigaio.com=kchow@kernel.org>
Subject: Re: IOAT DMA w/IOMMU
To: Logan Gunthorpe <logang@deltatee.com>, Eric Pilmore
 <epilmore@gigaio.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 iommu@lists.linux-foundation.org
References: <CAOQPn8soxubJxb=vp7kz+AM6LbPH5y+_Nx0Vzv7rjV_nMMqEmA@mail.gmail.com>
 <20180809184331.GB113140@bhelgaas-glaptop.roam.corp.google.com>
 <CAOQPn8uPYKai49WYPqZp2wNd5of=0hUvPOHEtqP56RZu-hcjuw@mail.gmail.com>
 <b54899a8-a144-e8e0-9880-1800c4657b95@deltatee.com>
 <95e53520-b05f-4be4-e694-463d717453a8@gigaio.com>
 <cdd9245f-eb23-9e10-1755-8f396a2cd255@deltatee.com>
 <b278c1e5-6f08-c879-a27d-7fc172645fd5@gigaio.com>
 <f04fae39-645e-3c6e-07c0-b194260bf5de@deltatee.com>
From: Kit Chow <kchow@gigaio.com>
Message-ID: <3f503940-db6a-ec75-ed15-1db99d5d48ef@gigaio.com>
Date: Thu, 9 Aug 2018 14:47:36 -0700
MIME-Version: 1.0
In-Reply-To: <f04fae39-645e-3c6e-07c0-b194260bf5de@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>



On 08/09/2018 02:11 PM, Logan Gunthorpe wrote:
>
> On 09/08/18 02:57 PM, Kit Chow wrote:
>>
>> On 08/09/2018 01:11 PM, Logan Gunthorpe wrote:
>>> On 09/08/18 01:47 PM, Kit Chow wrote:
>>>>> I haven't tested this scenario but my guess would be that IOAT would
>>>>> indeed go through the IOMMU and the PCI BAR address would need to be
>>>>> properly mapped into the IOAT's IOVA. The fact that you see DMAR errors
>>>>> is probably a good indication that this is the case. I really don't know
>>>>> why you'd want to DMA something without mapping it.
>>>> I have experimented with changing ntb_async_tx_submit to dma_map the PCI
>>>> BAR
>>>> address. With this, I get a different DMAR error:
>>> What code did you use to do this?
>> If you mean version of linux, it is 4.15.7.  Or specific dma_map call, I
>> believe it was dma_map_single.
> I mean the complete code you use to do the mapping so we can see if it's
> correct. dma_map_single() seems like an odd choice, I expected to see
> dma_map_resource().
Thanks for the suggestion!  Will try out dma_map_resource and report back.

Kit

>>>> DMAR: [DMA Write] Request device [07:00.4] fault addr ffd00000
>>>> [fault reason 12] non-zero reserved fields in PTE
>>> Also, what device corresponds to 07:00.4 on your system?
>> I believe 07.00.4 was the PLX dma device. I get the same error with ioat.
> Using the mapping with the PLX dma device likely converts it from a pure
> P2P request to one where the TLPs pass through the IOMMU. So the fact
> that you get the same error with both means IOAT almost certainly goes
> through the IOMMU and there's something wrong with the mapping setup.
>
> Logan
