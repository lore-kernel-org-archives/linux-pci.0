Return-Path: <SRS0=ZLZ+=K4=gigaio.com=kchow@kernel.org>
Return-Path: <SRS0=ZLZ+=K4=gigaio.com=kchow@kernel.org>
Subject: Re: IOAT DMA w/IOMMU
From: Kit Chow <kchow@gigaio.com>
To: Robin Murphy <robin.murphy@arm.com>, Logan Gunthorpe
 <logang@deltatee.com>, Dave Jiang <dave.jiang@intel.com>,
 Eric Pilmore <epilmore@gigaio.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
References: <CAOQPn8soxubJxb=vp7kz+AM6LbPH5y+_Nx0Vzv7rjV_nMMqEmA@mail.gmail.com>
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
 <c8d69f9b-b3a6-76ee-1a90-b3dbaaa9b82b@arm.com>
 <3772d88a-e9ad-465a-c91f-df8f9c6219be@gigaio.com>
Message-ID: <dd18cf79-aa10-9801-bf95-192f0b86b6d9@gigaio.com>
Date: Mon, 13 Aug 2018 16:30:51 -0700
MIME-Version: 1.0
In-Reply-To: <3772d88a-e9ad-465a-c91f-df8f9c6219be@gigaio.com>
Content-Type: multipart/alternative;
 boundary="------------A4CE38F0D46C2E9E0683DDB3"
List-ID: <linux-pci.vger.kernel.org>

This is a multi-part message in MIME format.
--------------A4CE38F0D46C2E9E0683DDB3
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Taking a step back, I was a little surprised that dma_map_single 
successfully returned an iommu address for the pci bar address passed 
into it during my initial experiment...

Internally, dma_map_single calls virt_to_page() to translate the 
"virtual address" into a page and intel_map page then calls 
page_to_phys() to convert the page to a dma_addr_t.

The virt_to_page and page_to_phys routines don't appear to do any 
validation and just uses arithmetic to do the conversions.

the pci bar address (0x383c70e51578) does fall into a valid VA range in 
x86_64 so it could conceivably be a valid VA.  So I tried an virtual 
address inside the VA hole and and it too returned without any errors.

virt_to_page(0x800000000000) -> 0xffffede000000000
page_to_phys(0xffffede000000000) -> 0xf80000000000

In arch/x86/include/asm/page.h, there is the following comment in 
regards to validating the virtual address.

/*
  * virt_to_page(kaddr) returns a valid pointer if and only if
  * virt_addr_valid(kaddr) returns true.
  */
#define virt_to_page(kaddr)     pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)

So it looks like the validation by virt_addr_valid was somehow dropped 
from the virt_to_page code path. Does anyone have any ideas what 
happended to it?

Kit


On 08/13/2018 08:21 AM, Kit Chow wrote:
>
>
> On 08/13/2018 07:59 AM, Robin Murphy wrote:
>> On 13/08/18 15:23, Kit Chow wrote:
>>> On 08/10/2018 07:10 PM, Logan Gunthorpe wrote:
>>>>
>>>> On 10/08/18 06:53 PM, Kit Chow wrote:
>>>>> I was able to finally succeed in doing the dma transfers over ioat 
>>>>> only
>>>>> when prot has DMA_PTE_WRITE set by setting the direction to either
>>>>> DMA_FROM_DEVICE or DMA_BIDIRECTIONAL. Any ideas if the prot settings
>>>>> need to be changed? Are there any bad side effects if I used
>>>>> DMA_BIDIRECTIONAL?
>>>> Good to hear it. Without digging into the direction much all I can say
>>>> is that it can sometimes be very confusing what the direction is. 
>>>> Adding
>>>> another PCI device just adds to the confusion.
>>> Yep, confusing :).
>>>
>>> ======================= =============================================
>>> DMA_NONE        no direction (used for debugging)
>>> DMA_TO_DEVICE        data is going from the memory to the device
>>> DMA_FROM_DEVICE        data is coming from the device to the memory
>>> DMA_BIDIRECTIONAL    direction isn't known
>>> ======================= =============================================
>>>
>>>> I believe, the direction should be from the IOAT's point of view. 
>>>> So if
>>>> the IOAT is writing to the BAR you'd set DMA_FROM_DEVICE (ie. data is
>>>> coming from the IOAT) and if it's reading you'd set DMA_TO_DEVICE (ie.
>>>> data is going to the IOAT).
>>> It would certainly seem like DMA_TO_DEVICE would be the proper 
>>> choice; IOAT is the plumbing to move host data (memory) to the bar 
>>> address (device).
>>
>> Except that the "device" in question is the IOAT itself (more 
>> generally, it means the device represented by the first argument to 
>> dma_map_*() - the one actually emitting the reads and writes). The 
>> context of a DMA API call is the individual mapping in question, not 
>> whatever overall operation it may be part of - your example already 
>> involves two separate mappings: one "from" system memory "to" the DMA 
>> engine, and one "from" the DMA engine "to" PCI BAR memory.
>
> OK, that makes sense.  The middleman (aka DMA engine device) is the 
> key in the to/from puzzle. Thanks!
>
>
>>
>> Note that the DMA API's dma_direction is also distinct from the 
>> dmaengine API's dma_transfer_direction, and there's plenty of fun to 
>> be had mapping between the two - see pl330.c or rcar-dmac.c for other 
>> examples of dma_map_resource() for slave devices - no guarantees that 
>> those implementations are entirely correct (especially the one I 
>> did!), but in practice they do make the "DMA engine behind an IOMMU" 
>> case work for UARTs and similar straightforward slaves.
>>
>>> Will go with what works and set DMA_FROM_DEVICE.
>>>
>>> In ntb_async_tx_submit, does the direction used for the dma_map 
>>> routines for the src and dest addresses need to be consistent?
>>
>> In general, the mappings of source and destination addresses would 
>> typically have opposite directions as above, unless they're both 
>> bidirectional.
>>
>>> And does the direction setting for the dmaengine_unmap_data have to 
>>> be consistent with the direction used in dma_map_*?
>>
>> Yes, the arguments to an unmap are expected to match whatever was 
>> passed to the corresponding map call. CONFIG_DMA_API_DEBUG should 
>> help catch any mishaps.
>>
>> Robin.
>>
>>> BTW, dmaengine_unmap routine only calls dma_unmap_page. Should it 
>>> keep track of the dma_map routine used and call the corresponding 
>>> dma_unmap routine?  In the case of the intel iommu, it doesn't matter.
>>>
>>> Thanks
>>> Kit
>>>
>>>>
>>>> Using DMA_BIDIRECTIONAL just forgoes any hardware security / 
>>>> protection
>>>> that the buffer would have in terms of direction. Generally it's good
>>>> practice to use the strictest direction you can.
>>>>
>>>>> Given that using the pci bar address as is without getting an iommu
>>>>> address results in the same "PTE Write access" error, I wonder if 
>>>>> there
>>>>> is some internal 'prot' associated with the non-translated pci bar
>>>>> address that just needs to be tweaked to include DMA_PTE_WRITE???
>>>> No, I don't think so. The 'prot' will be a property of the IOMMU. Not
>>>> having an entry is probably just the same (from the perspective of the
>>>> error you see) as only having an entry for reading.
>>>>
>>>> Logan
>>>
>>> _______________________________________________
>>> iommu mailing list
>>> iommu@lists.linux-foundation.org
>>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>


--------------A4CE38F0D46C2E9E0683DDB3
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p><tt>Taking a step back, I was a little surprised that
        dma_map_single successfully returned an iommu address for the
        pci bar address passed into it during my initial experiment... <br>
      </tt></p>
    <p><tt>Internally, dma_map_single calls virt_to_page() to translate
        the "virtual address" into a page and intel_map page then calls
        page_to_phys() to convert the page to a dma_addr_t.</tt></p>
    <p><tt>The virt_to_page and page_to_phys routines don't appear to do
        any validation and just uses arithmetic to do the conversions.</tt></p>
    <p><tt>the pci bar address (0x383c70e51578) does fall into a valid
        VA range in x86_64 so it could conceivably be a valid VA.  So I
        tried an virtual address inside the VA hole and and it too
        returned without any errors.<br>
      </tt></p>
    <tt>virt_to_page(0x800000000000) -&gt; </tt><tt>0xffffede000000000
      <br>
    </tt><tt>page_to_phys(</tt><tt>0xffffede000000000</tt><tt>) -&gt; </tt><tt>0xf80000000000</tt>
    <p><tt><tt>
        </tt></tt></p>
    <p><tt>In arch/x86/include/asm/page.h, there is the following
        comment in regards to validating the virtual address.<br>
      </tt></p>
    <p><tt>/*<br>
        <font color="#ff0000"> * virt_to_page(kaddr) returns a valid
          pointer if and only if<br>
           * virt_addr_valid(kaddr) returns true.</font><br>
         */<br>
        #define virt_to_page(kaddr)     pfn_to_page(__pa(kaddr) &gt;&gt;
        PAGE_SHIFT)<br>
        <br>
      </tt></p>
    <p><tt>So it looks like the validation by virt_addr_valid was
        somehow dropped from the virt_to_page code path. Does anyone
        have any ideas what happended to </tt><tt><tt>it?</tt>
      </tt>
    </p>
    <p><tt>Kit</tt><br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 08/13/2018 08:21 AM, Kit Chow wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:3772d88a-e9ad-465a-c91f-df8f9c6219be@gigaio.com">
      <br>
      <br>
      On 08/13/2018 07:59 AM, Robin Murphy wrote:
      <br>
      <blockquote type="cite">On 13/08/18 15:23, Kit Chow wrote:
        <br>
        <blockquote type="cite">On 08/10/2018 07:10 PM, Logan Gunthorpe
          wrote:
          <br>
          <blockquote type="cite">
            <br>
            On 10/08/18 06:53 PM, Kit Chow wrote:
            <br>
            <blockquote type="cite">I was able to finally succeed in
              doing the dma transfers over ioat only
              <br>
              when prot has DMA_PTE_WRITE set by setting the direction
              to either
              <br>
              DMA_FROM_DEVICE or DMA_BIDIRECTIONAL. Any ideas if the
              prot settings
              <br>
              need to be changed? Are there any bad side effects if I
              used
              <br>
              DMA_BIDIRECTIONAL?
              <br>
            </blockquote>
            Good to hear it. Without digging into the direction much all
            I can say
            <br>
            is that it can sometimes be very confusing what the
            direction is. Adding
            <br>
            another PCI device just adds to the confusion.
            <br>
          </blockquote>
          Yep, confusing :).
          <br>
          <br>
          =======================
          =============================================
          <br>
          DMA_NONE        no direction (used for debugging)
          <br>
          DMA_TO_DEVICE        data is going from the memory to the
          device
          <br>
          DMA_FROM_DEVICE        data is coming from the device to the
          memory
          <br>
          DMA_BIDIRECTIONAL    direction isn't known
          <br>
          =======================
          =============================================
          <br>
          <br>
          <blockquote type="cite">I believe, the direction should be
            from the IOAT's point of view. So if
            <br>
            the IOAT is writing to the BAR you'd set DMA_FROM_DEVICE
            (ie. data is
            <br>
            coming from the IOAT) and if it's reading you'd set
            DMA_TO_DEVICE (ie.
            <br>
            data is going to the IOAT).
            <br>
          </blockquote>
          It would certainly seem like DMA_TO_DEVICE would be the proper
          choice; IOAT is the plumbing to move host data (memory) to the
          bar address (device).
          <br>
        </blockquote>
        <br>
        Except that the "device" in question is the IOAT itself (more
        generally, it means the device represented by the first argument
        to dma_map_*() - the one actually emitting the reads and
        writes). The context of a DMA API call is the individual mapping
        in question, not whatever overall operation it may be part of -
        your example already involves two separate mappings: one "from"
        system memory "to" the DMA engine, and one "from" the DMA engine
        "to" PCI BAR memory.
        <br>
      </blockquote>
      <br>
      OK, that makes sense.  The middleman (aka DMA engine device) is
      the key in the to/from puzzle. Thanks!
      <br>
      <br>
      <br>
      <blockquote type="cite">
        <br>
        Note that the DMA API's dma_direction is also distinct from the
        dmaengine API's dma_transfer_direction, and there's plenty of
        fun to be had mapping between the two - see pl330.c or
        rcar-dmac.c for other examples of dma_map_resource() for slave
        devices - no guarantees that those implementations are entirely
        correct (especially the one I did!), but in practice they do
        make the "DMA engine behind an IOMMU" case work for UARTs and
        similar straightforward slaves.
        <br>
        <br>
        <blockquote type="cite">Will go with what works and set
          DMA_FROM_DEVICE.
          <br>
          <br>
          In ntb_async_tx_submit, does the direction used for the
          dma_map routines for the src and dest addresses need to be
          consistent?
          <br>
        </blockquote>
        <br>
        In general, the mappings of source and destination addresses
        would typically have opposite directions as above, unless
        they're both bidirectional.
        <br>
        <br>
        <blockquote type="cite">And does the direction setting for the
          dmaengine_unmap_data have to be consistent with the direction
          used in dma_map_*?
          <br>
        </blockquote>
        <br>
        Yes, the arguments to an unmap are expected to match whatever
        was passed to the corresponding map call. CONFIG_DMA_API_DEBUG
        should help catch any mishaps.
        <br>
        <br>
        Robin.
        <br>
        <br>
        <blockquote type="cite">BTW, dmaengine_unmap routine only calls
          dma_unmap_page. Should it keep track of the dma_map routine
          used and call the corresponding dma_unmap routine?  In the
          case of the intel iommu, it doesn't matter.
          <br>
          <br>
          Thanks
          <br>
          Kit
          <br>
          <br>
          <blockquote type="cite">
            <br>
            Using DMA_BIDIRECTIONAL just forgoes any hardware security /
            protection
            <br>
            that the buffer would have in terms of direction. Generally
            it's good
            <br>
            practice to use the strictest direction you can.
            <br>
            <br>
            <blockquote type="cite">Given that using the pci bar address
              as is without getting an iommu
              <br>
              address results in the same "PTE Write access" error, I
              wonder if there
              <br>
              is some internal 'prot' associated with the non-translated
              pci bar
              <br>
              address that just needs to be tweaked to include
              DMA_PTE_WRITE???
              <br>
            </blockquote>
            No, I don't think so. The 'prot' will be a property of the
            IOMMU. Not
            <br>
            having an entry is probably just the same (from the
            perspective of the
            <br>
            error you see) as only having an entry for reading.
            <br>
            <br>
            Logan
            <br>
          </blockquote>
          <br>
          _______________________________________________
          <br>
          iommu mailing list
          <br>
          <a class="moz-txt-link-abbreviated" href="mailto:iommu@lists.linux-foundation.org">iommu@lists.linux-foundation.org</a>
          <br>
          <a class="moz-txt-link-freetext" href="https://lists.linuxfoundation.org/mailman/listinfo/iommu">https://lists.linuxfoundation.org/mailman/listinfo/iommu</a>
          <br>
        </blockquote>
      </blockquote>
      <br>
    </blockquote>
    <br>
  </body>
</html>

--------------A4CE38F0D46C2E9E0683DDB3--
