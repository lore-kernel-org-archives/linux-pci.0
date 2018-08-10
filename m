Return-Path: <SRS0=xQUW=KZ=intel.com=dave.jiang@kernel.org>
Return-Path: <SRS0=xQUW=KZ=intel.com=dave.jiang@kernel.org>
Subject: Re: IOAT DMA w/IOMMU
To: Logan Gunthorpe <logang@deltatee.com>, Kit Chow <kchow@gigaio.com>,
 Eric Pilmore <epilmore@gigaio.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
References: <CAOQPn8soxubJxb=vp7kz+AM6LbPH5y+_Nx0Vzv7rjV_nMMqEmA@mail.gmail.com>
 <20180809184331.GB113140@bhelgaas-glaptop.roam.corp.google.com>
 <CAOQPn8uPYKai49WYPqZp2wNd5of=0hUvPOHEtqP56RZu-hcjuw@mail.gmail.com>
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
From: Dave Jiang <dave.jiang@intel.com>
Message-ID: <6525fa4d-7d9b-0136-7206-f8351230af46@intel.com>
Date: Fri, 10 Aug 2018 10:01:56 -0700
MIME-Version: 1.0
In-Reply-To: <0f653f8f-c7ae-831d-e238-2742590d9ea1@deltatee.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>



On 08/10/2018 09:33 AM, Logan Gunthorpe wrote:
> 
> 
> On 10/08/18 10:31 AM, Dave Jiang wrote:
>>
>>
>> On 08/10/2018 09:24 AM, Logan Gunthorpe wrote:
>>>
>>>
>>> On 10/08/18 10:02 AM, Kit Chow wrote:
>>>> Turns out there is no dma_map_resource routine on x86. get_dma_ops 
>>>> returns intel_dma_ops which has map_resource pointing to NULL.
>>>
>>> Oh, yup. I wasn't aware of that. From a cursory view, it looks like it
>>> shouldn't be too hard to implement though.
>>>
>>>> Will poke around some in the intel_map_page code but can you actually 
>>>> get a valid struct page for a pci bar address (dma_map_single calls 
>>>> virt_to_page)?  If not, does a map_resource routine that can properly 
>>>> map a pci bar address need to be implemented?
>>>
>>> Yes, you can not get a struct page for a PCI bar address unless it's
>>> mapped with ZONE_DEVICE like in my p2p work. So that would explain why
>>> dma_map_single() didn't work.
>>>
>>> This all implies that ntb_transport doesn't work with DMA and the IOMMU
>>> turned on. I'm not sure I've ever tried that configuration myself but it
>>> is a bit surprising.
>>
>> Hmm....that's surprising because it seems to work on Skylake platform
>> when I tested it yesterday with Intel NTB. Kit is using a Haswell
>> platform at the moment I think. Although I'm curious if it works with
>> the PLX NTB he's using on Skylake.
> 
> Does that mean on Skylake the IOAT can bypass the IOMMU? Because it
> looks like the ntb_transport code doesn't map the physical address of
> the NTB MW into the IOMMU when doing DMA...

Or if the BIOS has provided mapping for the Intel NTB device
specifically? Is that a possibility? NTB does go through the IOMMU.
