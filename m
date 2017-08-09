Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49888 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752330AbdHIO66 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Aug 2017 10:58:58 -0400
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: Support SVM without PASID
To: Bob Liu <liubo95@huawei.com>, valmiki <valmikibow@gmail.com>,
        Alex Williamson <alex.williamson@redhat.com>
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, kvm@vger.kernel.org,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        jacob.jun.pan@intel.com, "xieyisheng (A)" <xieyisheng1@huawei.com>
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
 <d737a46a-cebc-f38d-371b-ffb91b7b344a@huawei.com>
Message-ID: <ad4d596c-97ec-7f06-8304-c21d42634909@arm.com>
Date: Wed, 9 Aug 2017 16:01:05 +0100
MIME-Version: 1.0
In-Reply-To: <d737a46a-cebc-f38d-371b-ffb91b7b344a@huawei.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 08/08/17 01:51, Bob Liu wrote:
> On 2017/8/7 20:52, Jean-Philippe Brucker wrote:
>> Hi Bob,
>>
>> On 07/08/17 13:18, Bob Liu wrote:
>>> On 2017/8/7 18:31, Jean-Philippe Brucker wrote:
>>>> On 05/08/17 06:14, valmiki wrote:
>>>> [...]
>>>>> Hi Jean, Thanks a lot, now i understood the flow. From vfio kernel
>>>>> documentation we fill vaddr and iova in struct vfio_iommu_type1_dma_map
>>>>> and pass them to VFIO. But if we use dynamic allocation in application
>>>>> (say malloc), do we need to use dma API to get iova and then call
>>>>> VFIO_IOMMU_MAP ioctl ?
>>>>> If application needs multiple such dynamic allocations, then it need to
>>>>> allocate large chunk and program it via VFIO_IOMMU_MAP ioctl and then
>>>>> manage rest allocations requirements from this buffer ?
>>>>
>>>> Yes, without SVM, the application allocates large buffers, allocates IOVAs
>>>> itself, and maps them with VFIO_IOMMU_MAP. Userspace doesn't rely on the
>>>> DMA API at all, it manages IOVAs as it wants. Sizes passed to
>>>> VFIO_IOMMU_MAP have to be multiples of the MMU or IOMMU page granularity
>>>> (that is at least 4kB), and both iova and vaddr have to be aligned on that
>>>> granularity as well. So malloc isn't really suitable in this case, you'll
>>>> need mmap. The application can then implement a small allocator to manage
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
>>> Suppose there is a device in the same SOC-chip, the device access memory through SMMU(using internal bus instead of PCIe)
>>> Once page fault, the device send an event with (vaddr, substreamID) to SMMU, then SMMU triggers an event interrupt.
>>>
>>> In the event interrupt handler, we can implement the same logic as PRI interrupt in your patch.
>>> What do you think about that?
>> What you're describing is the SMMU stall model for platform devices. From
>> the driver perspective it's the same as PRI and PASID (SubstreamID=PASID).
>>
> 
> Indeed!
> 
>> When a stall-capable device accesses unmapped memory, the SMMU parks the
>> transaction and sends an event marked "stall" on the event queue, with a
>> stall tag (STAG, roughly equivalent to PRG Index). The OS handles the
>> fault and sends a CMD_RESUME command with the status and the STAG. Then
>> the SMMU completes the access or terminates it.
>>
>> In a prototype I have, the stall implementation reuses most of the
> 
> Glad to hear that.
> Would you mind to share me the prototype patch？
> 
>> PASID/PRI code. The main difficulty is defining SSID and stall capability
>> in firmware, as there are no standard capability probing for platform
>> devices. Stall-capable devices must be able to wait an indefinite amount
>> of time that their DMA transactions returns, therefore the stall model
>> cannot work with PCI, only some integrated devices.
>>
> 
> I happen to have a board with such devices and like to do the test.
> Will re-post a full version patch upstream once completing the verification.

Cool! You can find the prototype here:
git://linux-arm.org/linux-jpb.git svm/stall

Please let me know if you get anywhere with it, I'd like to get the series
moving again.

Thanks,
Jean
