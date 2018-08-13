Return-Path: <SRS0=FpW9=K4=arm.com=robin.murphy@kernel.org>
Return-Path: <SRS0=FpW9=K4=arm.com=robin.murphy@kernel.org>
Subject: Re: IOAT DMA w/IOMMU
To: Kit Chow <kchow@gigaio.com>, Logan Gunthorpe <logang@deltatee.com>,
 Dave Jiang <dave.jiang@intel.com>, Eric Pilmore <epilmore@gigaio.com>,
 Bjorn Helgaas <helgaas@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
References: <CAOQPn8soxubJxb=vp7kz+AM6LbPH5y+_Nx0Vzv7rjV_nMMqEmA@mail.gmail.com>
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
 <0a9fa9c3-dbe4-6451-9c1a-06b662702f61@deltatee.com>
 <a2391f6c-d73b-c140-edad-8cd6584dd437@gigaio.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <c8d69f9b-b3a6-76ee-1a90-b3dbaaa9b82b@arm.com>
Date: Mon, 13 Aug 2018 15:59:01 +0100
MIME-Version: 1.0
In-Reply-To: <a2391f6c-d73b-c140-edad-8cd6584dd437@gigaio.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 13/08/18 15:23, Kit Chow wrote:
> On 08/10/2018 07:10 PM, Logan Gunthorpe wrote:
>>
>> On 10/08/18 06:53 PM, Kit Chow wrote:
>>> I was able to finally succeed in doing the dma transfers over ioat only
>>> when prot has DMA_PTE_WRITE set by setting the direction to either
>>> DMA_FROM_DEVICE or DMA_BIDIRECTIONAL. Any ideas if the prot settings
>>> need to be changed? Are there any bad side effects if I used
>>> DMA_BIDIRECTIONAL?
>> Good to hear it. Without digging into the direction much all I can say
>> is that it can sometimes be very confusing what the direction is. Adding
>> another PCI device just adds to the confusion.
> Yep, confusing :).
> 
> ======================= =============================================
> DMA_NONE        no direction (used for debugging)
> DMA_TO_DEVICE        data is going from the memory to the device
> DMA_FROM_DEVICE        data is coming from the device to the memory
> DMA_BIDIRECTIONAL    direction isn't known
> ======================= =============================================
> 
>> I believe, the direction should be from the IOAT's point of view. So if
>> the IOAT is writing to the BAR you'd set DMA_FROM_DEVICE (ie. data is
>> coming from the IOAT) and if it's reading you'd set DMA_TO_DEVICE (ie.
>> data is going to the IOAT).
> It would certainly seem like DMA_TO_DEVICE would be the proper choice; 
> IOAT is the plumbing to move host data (memory) to the bar address 
> (device).

Except that the "device" in question is the IOAT itself (more generally, 
it means the device represented by the first argument to dma_map_*() - 
the one actually emitting the reads and writes). The context of a DMA 
API call is the individual mapping in question, not whatever overall 
operation it may be part of - your example already involves two separate 
mappings: one "from" system memory "to" the DMA engine, and one "from" 
the DMA engine "to" PCI BAR memory.

Note that the DMA API's dma_direction is also distinct from the 
dmaengine API's dma_transfer_direction, and there's plenty of fun to be 
had mapping between the two - see pl330.c or rcar-dmac.c for other 
examples of dma_map_resource() for slave devices - no guarantees that 
those implementations are entirely correct (especially the one I did!), 
but in practice they do make the "DMA engine behind an IOMMU" case work 
for UARTs and similar straightforward slaves.

> Will go with what works and set DMA_FROM_DEVICE.
> 
> In ntb_async_tx_submit, does the direction used for the dma_map routines 
> for the src and dest addresses need to be consistent?

In general, the mappings of source and destination addresses would 
typically have opposite directions as above, unless they're both 
bidirectional.

> And does the direction setting for the dmaengine_unmap_data have to be 
> consistent with the direction used in dma_map_*?

Yes, the arguments to an unmap are expected to match whatever was passed 
to the corresponding map call. CONFIG_DMA_API_DEBUG should help catch 
any mishaps.

Robin.

> BTW, dmaengine_unmap routine only calls dma_unmap_page. Should it keep 
> track of the dma_map routine used and call the corresponding dma_unmap 
> routine?  In the case of the intel iommu, it doesn't matter.
> 
> Thanks
> Kit
> 
>>
>> Using DMA_BIDIRECTIONAL just forgoes any hardware security / protection
>> that the buffer would have in terms of direction. Generally it's good
>> practice to use the strictest direction you can.
>>
>>> Given that using the pci bar address as is without getting an iommu
>>> address results in the same "PTE Write access" error, I wonder if there
>>> is some internal 'prot' associated with the non-translated pci bar
>>> address that just needs to be tweaked to include DMA_PTE_WRITE???
>> No, I don't think so. The 'prot' will be a property of the IOMMU. Not
>> having an entry is probably just the same (from the perspective of the
>> error you see) as only having an entry for reading.
>>
>> Logan
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
