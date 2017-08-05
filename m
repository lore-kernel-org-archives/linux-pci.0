Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:37958 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751221AbdHEFOe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 5 Aug 2017 01:14:34 -0400
Subject: Re: Support SVM without PASID
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Alex Williamson <alex.williamson@redhat.com>
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
Cc: iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-pci@vger.kernel.org, tianyu.lan@intel.com,
        kevin.tian@intel.com, jacob.jun.pan@intel.com
From: valmiki <valmikibow@gmail.com>
Message-ID: <dd3a7852-cd9a-3797-9421-dff97f6d7213@gmail.com>
Date: Sat, 5 Aug 2017 10:44:38 +0530
MIME-Version: 1.0
In-Reply-To: <c142fb8e-3618-152a-fbe3-521e6c8ff9bf@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 8/2/2017 12:10 AM, Jean-Philippe Brucker wrote:
> On 01/08/17 18:38, valmiki wrote:
> [...]
>>>> So i digged through your patches and i understood that using BIND ioctls
>>>> satge-1 translations are setup in SMMU for an application.
>>>> If we use VFIO_IOMMU_MAP/UNMAP_DMA ioctls they are setting up stage-2
>>>> translations in SMMU.
>>>> So without PASID support we can only work with stage-2 translations ?
>>>
>>> It depends what type you use when registering the IOMMU with
>>> VFIO_SET_IOMMU:
>>>
>>> * If the type is VFIO_TYPE1v2_IOMMU, then VFIO_IOMMU_MAP/UNMAP_DMA
>>>   affects the stage-1 non-PASID context (already the case in mainline).
>>>   In addition, with my patch the BIND ioctl will affect stage-1 PASID
>>>   contexts, and bind process page directories to the device (host SVM).
>>>
>>> * If the type is VFIO_TYPE1_NESTING_IOMMU, then VFIO_IOMMU_MAP/UNMAP_DMA
>>>   will affect stage-2 mappings (already in mainline).
>>>   With my SMMU patch series, the BIND ioctl is not supported in this mode.
>>>   But in the future, BIND would allow to manage stage-1 as well:
>>>   - bind a process page directory (host SVM with added stage-2), or
>>>   - bind a guest page directory (viommu), or
>>>   - bind the full stage-1 context table (viommu).
>>
>> Hi Jean, Thanks a lot for this information.
>> I tried to understand how stage-1 translations are setup if we use
>> VFIO_TYPE1v2_IOMMU & VFIO_IOMMU_MAP/UNMAP_DMA flow, but I'm not
>> successful, I couldn't find when context descriptor details are updated
>> with stage-1 translation table details in this flow.
>> I found that in BIND flow a new context descriptor being created and
>> assigned with required translation tables.
>>
>> Can you please point to piece of code/patch series where and how context
>> descriptor is updated for struct vfio_iommu_type1_dma_map/UNMAP_DMA flow with
>> VFIO_TYPE1v2_IOMMU.
>
> What happens for SMMU is during initialization, the
> VFIO_GROUP_SET_CONTAINER ioctl calls vfio_iommu_type1_attach_group.
> This function creates a new iommu_domain, and then calls
> iommu_attach_group(domain, group), which calls arm_smmu_attach_dev(domain,
> dev) for all devices in the group.
>
> If necessary we detach the existing domain, by clearing the STE (and all
> contexts). Then, since the new domain is only partially initialized, we
> call arm_smmu_domain_finalise, which allocates the page tables, and ends
> up calling arm_smmu_domain_finalise_s1. That function prepares the
> configuration of context descriptor 0, which is used for non-PASID
> mappings. Afterwards, back in arm_smmu_attach_dev, context descriptor 0 is
> written, along with the STE, and then the domain is live.
>
> Then when userspace does VFIO_IOMMU_MAP/UNMAP_DMA, iommu_map/unmap are
> called on that domain. arm_smmu_map/unmap update the page tables attached
> to context descriptor 0 (but they don't modify the CD in any way).
>
Hi Jean, Thanks a lot, now i understood the flow. From vfio kernel 
documentation we fill vaddr and iova in struct vfio_iommu_type1_dma_map 
and pass them to VFIO. But if we use dynamic allocation in application 
(say malloc), do we need to use dma API to get iova and then call 
VFIO_IOMMU_MAP ioctl ?
If application needs multiple such dynamic allocations, then it need to 
allocate large chunk and program it via VFIO_IOMMU_MAP ioctl and then 
manage rest allocations requirements from this buffer ?

Regards,
valmiki
