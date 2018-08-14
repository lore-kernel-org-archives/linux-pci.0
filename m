Return-Path: <SRS0=O9XS=K5=gigaio.com=kchow@kernel.org>
Return-Path: <SRS0=O9XS=K5=gigaio.com=kchow@kernel.org>
Subject: Re: IOAT DMA w/IOMMU
To: Logan Gunthorpe <logang@deltatee.com>, Robin Murphy
 <robin.murphy@arm.com>, Dave Jiang <dave.jiang@intel.com>,
 Eric Pilmore <epilmore@gigaio.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
References: <CAOQPn8soxubJxb=vp7kz+AM6LbPH5y+_Nx0Vzv7rjV_nMMqEmA@mail.gmail.com>
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
 <0a9fa9c3-dbe4-6451-9c1a-06b662702f61@deltatee.com>
 <a2391f6c-d73b-c140-edad-8cd6584dd437@gigaio.com>
 <c8d69f9b-b3a6-76ee-1a90-b3dbaaa9b82b@arm.com>
 <3772d88a-e9ad-465a-c91f-df8f9c6219be@gigaio.com>
 <dd18cf79-aa10-9801-bf95-192f0b86b6d9@gigaio.com>
 <0e839acf-5948-42aa-2ad6-72ca0d84a8c3@deltatee.com>
 <bcfc8738-cbf6-7124-3d79-a1bdfe161d36@gigaio.com>
 <712ecb24-8919-05a5-f64c-6a1faa971edc@deltatee.com>
From: Kit Chow <kchow@gigaio.com>
Message-ID: <55bbbf43-8665-47a3-c290-1d31dca0ba1a@gigaio.com>
Date: Tue, 14 Aug 2018 06:47:56 -0700
MIME-Version: 1.0
In-Reply-To: <712ecb24-8919-05a5-f64c-6a1faa971edc@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>



On 08/13/2018 04:50 PM, Logan Gunthorpe wrote:
>
> On 13/08/18 05:48 PM, Kit Chow wrote:
>> On 08/13/2018 04:39 PM, Logan Gunthorpe wrote:
>>> On 13/08/18 05:30 PM, Kit Chow wrote:
>>>> In arch/x86/include/asm/page.h, there is the following comment in
>>>> regards to validating the virtual address.
>>>>
>>>> /*
>>>>    * virt_to_page(kaddr) returns a valid pointer if and only if
>>>>    * virt_addr_valid(kaddr) returns true.
>>>>    */
>>>> #define virt_to_page(kaddr)     pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
>>>>
>>>> So it looks like the validation by virt_addr_valid was somehow dropped
>>>> from the virt_to_page code path. Does anyone have any ideas what
>>>> happended to it?
>>> I don't think it was ever validated (though I haven't been around long
>>> enough to say for certain). What the comment is saying is that you
>>> shouldn't rely on virt_to_page() unless you know virt_addr_valid() is
>>> true (which in most cases you can without the extra check). virt_to_page
>>> is meant to be really fast so adding an extra validation would probably
>>> be a significant performance regression for the entire kernel.
>>>
>>> The fact that this can happen through dma_map_single() is non-ideal at
>>> best. It assumes the caller is mapping regular memory and doesn't check
>>> this at all. It may make sense to fix that but I think people expect
>>> dma_map_single() to be as fast as possible as well...
>>>
>> Perhaps include the validation with some debug turned on?
> The problem is how often do you develop code with any of the debug
> config options turned on?
>
> There's already a couple of BUG_ONs in dma_map_single so maybe another
> one with virt_addr_valid wouldn't be so bad.
Had my very first Linux crash on the dma direction BUG_ON when I tried 
DMA_NONE :).
