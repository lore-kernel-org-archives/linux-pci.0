Return-Path: <SRS0=XYHn=K2=gigaio.com=kchow@kernel.org>
Return-Path: <SRS0=XYHn=K2=gigaio.com=kchow@kernel.org>
Subject: Re: IOAT DMA w/IOMMU
To: Dave Jiang <dave.jiang@intel.com>, Logan Gunthorpe <logang@deltatee.com>,
 Eric Pilmore <epilmore@gigaio.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
References: <CAOQPn8soxubJxb=vp7kz+AM6LbPH5y+_Nx0Vzv7rjV_nMMqEmA@mail.gmail.com>
 <b54899a8-a144-e8e0-9880-1800c4657b95@deltatee.com>
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
From: Kit Chow <kchow@gigaio.com>
Message-ID: <9d135f61-20c2-e966-4d7d-3e154384ea08@gigaio.com>
Date: Fri, 10 Aug 2018 17:53:23 -0700
MIME-Version: 1.0
In-Reply-To: <499934e7-3734-1aee-37dd-b42a5d2a2608@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Success!

I've implemented a new intel_map_resource (and intel_unmap_resource) 
routine which is called by dma_map_resource. As mentioned previously, 
the primary job of dma_map_resource/intel_map_resource is to call the 
intel iommu internal mapping routine (__intel_map_single) without 
translating the pci bar address into a page and then back to a phys addr 
as dma_map_page and dma_map_single are doing.

With the new dma_map_resource routine mapping the pci bar address in 
ntb_transport_tx_submit, I was still getting the "PTE Write access is 
not set" error.

The __intel_map_single routine sets prot based on the DMA direction.

         if (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL || \
                         !cap_zlr(iommu->cap))
                 prot |= DMA_PTE_READ;
         if (dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL)
                 prot |= DMA_PTE_WRITE;

I was able to finally succeed in doing the dma transfers over ioat only 
when prot has DMA_PTE_WRITE set by setting the direction to either 
DMA_FROM_DEVICE or DMA_BIDIRECTIONAL. Any ideas if the prot settings 
need to be changed? Are there any bad side effects if I used 
DMA_BIDIRECTIONAL?

Given that using the pci bar address as is without getting an iommu 
address results in the same "PTE Write access" error, I wonder if there 
is some internal 'prot' associated with the non-translated pci bar 
address that just needs to be tweaked to include DMA_PTE_WRITE???

Thanks!




On 08/10/2018 10:46 AM, Dave Jiang wrote:
>
> On 08/10/2018 10:15 AM, Logan Gunthorpe wrote:
>>
>> On 10/08/18 11:01 AM, Dave Jiang wrote:
>>> Or if the BIOS has provided mapping for the Intel NTB device
>>> specifically? Is that a possibility? NTB does go through the IOMMU.
>> I don't know but if the BIOS is doing it, but that would only at best
>> work for Intel NTB.... I see no hope in getting the BIOS to map the MW
>> for a Switchtec NTB device...
> Right. I'm just speculating why it may possibly work. But yes, I think
> kernel will need appropriate mapping if it's not happening right now.
> Hopefully Kit is onto something.
>
>> Logan
>>
