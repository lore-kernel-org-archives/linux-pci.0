Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:3509 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751873AbdHKJhK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Aug 2017 05:37:10 -0400
Subject: Re: Support SVM without PASID
To: "Tian, Kevin" <kevin.tian@intel.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        valmiki <valmikibow@gmail.com>,
        "Alex Williamson" <alex.williamson@redhat.com>
References: <a30962a6-2240-9263-96cc-10da1b179fcc@gmail.com>
 <20170708140257.2de02d63@w520.home>
 <73619426-6fcc-21ce-cfd4-8c66bde63f9a@gmail.com>
 <eb132dfa-6708-5898-c2ce-ce7ab08809b1@arm.com>
 <ee41f5d9-e7fb-8f7c-4b85-87cdb951ec70@gmail.com>
 <ca0d9f94-f5e2-aaaf-2c64-0cd6ecc62754@arm.com>
 <41333a03-bf91-1152-4779-6579845609f6@gmail.com>
 <564ba70b-db95-7fe0-86bb-bb4eefcd87ec@arm.com>
 <32b6402d-40fb-d40c-32f3-1ed6b9a3185a@gmail.com>
 <c142fb8e-3618-152a-fbe3-521e6c8ff9bf@arm.com>
 <dd3a7852-cd9a-3797-9421-dff97f6d7213@gmail.com>
 <9b8611ca-3e39-90ec-e18e-7455115b38b3@arm.com>
 <ed289d79-880a-a542-dcb1-0de8c55a8ca0@huawei.com>
 <1ef75c2d-f980-5cef-f760-be3b133c82ca@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D190D6EDB7@SHSMSX101.ccr.corp.intel.com>
CC: "Lan, Tianyu" <tianyu.lan@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>
From: Bob Liu <liubo95@huawei.com>
Message-ID: <64150791-b912-fd04-42f1-368d367607d1@huawei.com>
Date: Fri, 11 Aug 2017 17:36:26 +0800
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D190D6EDB7@SHSMSX101.ccr.corp.intel.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2017/8/11 14:41, Tian, Kevin wrote:
>> From: Jean-Philippe Brucker [mailto:jean-philippe.brucker@arm.com]
>> Sent: Monday, August 7, 2017 8:52 PM
>>
>> Hi Bob,
>>
>> On 07/08/17 13:18, Bob Liu wrote:
>>> On 2017/8/7 18:31, Jean-Philippe Brucker wrote:
>>>> On 05/08/17 06:14, valmiki wrote:
>>>> [...]
>>>>> Hi Jean, Thanks a lot, now i understood the flow. From vfio kernel
>>>>> documentation we fill vaddr and iova in struct
>> vfio_iommu_type1_dma_map
>>>>> and pass them to VFIO. But if we use dynamic allocation in application
>>>>> (say malloc), do we need to use dma API to get iova and then call
>>>>> VFIO_IOMMU_MAP ioctl ?
>>>>> If application needs multiple such dynamic allocations, then it need to
>>>>> allocate large chunk and program it via VFIO_IOMMU_MAP ioctl and
>> then
>>>>> manage rest allocations requirements from this buffer ?
>>>>
>>>> Yes, without SVM, the application allocates large buffers, allocates IOVAs
>>>> itself, and maps them with VFIO_IOMMU_MAP. Userspace doesn't rely on
>> the
>>>> DMA API at all, it manages IOVAs as it wants. Sizes passed to
>>>> VFIO_IOMMU_MAP have to be multiples of the MMU or IOMMU page
>> granularity
>>>> (that is at least 4kB), and both iova and vaddr have to be aligned on that
>>>> granularity as well. So malloc isn't really suitable in this case, you'll
>>>> need mmap. The application can then implement a small allocator to
>> manage
>>>> the DMA pool created with VFIO_IOMMU_MAP.
>>>>
>>>> With SVM the application binds its address space to the device, and then
>>>> uses malloc for all DMA buffers, no need for VFIO_IOMMU_MAP.
>>>>
>>>
>>> Hi Jean,
>>>
>>> I think there is another way to support SVM without PASID.
>>>
>>> Suppose there is a device in the same SOC-chip, the device access memory
>> through SMMU(using internal bus instead of PCIe)
>>> Once page fault, the device send an event with (vaddr, substreamID) to
>> SMMU, then SMMU triggers an event interrupt.
>>>
>>> In the event interrupt handler, we can implement the same logic as PRI
>> interrupt in your patch.
>>> What do you think about that?
>> What you're describing is the SMMU stall model for platform devices. From
>> the driver perspective it's the same as PRI and PASID (SubstreamID=PASID).
>>
>> When a stall-capable device accesses unmapped memory, the SMMU parks
>> the
>> transaction and sends an event marked "stall" on the event queue, with a
>> stall tag (STAG, roughly equivalent to PRG Index). The OS handles the
>> fault and sends a CMD_RESUME command with the status and the STAG.
>> Then
>> the SMMU completes the access or terminates it.
> 
> Can such platform device send multiple SubstreamIDs, or one ID per
> device? 
> 

Software should able to config different SubstreamID to the device,
but I'm not sure whether our device can send multiple SubStreamIDs at the same time.
Btw, why do you care about this?

Thanks,
Liubo
