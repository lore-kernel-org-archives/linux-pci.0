Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36774 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751832AbdHARiW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Aug 2017 13:38:22 -0400
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
Cc: iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-pci@vger.kernel.org, tianyu.lan@intel.com,
        kevin.tian@intel.com, jacob.jun.pan@intel.com
From: valmiki <valmikibow@gmail.com>
Message-ID: <32b6402d-40fb-d40c-32f3-1ed6b9a3185a@gmail.com>
Date: Tue, 1 Aug 2017 23:08:26 +0530
MIME-Version: 1.0
In-Reply-To: <564ba70b-db95-7fe0-86bb-bb4eefcd87ec@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 8/1/2017 1:56 PM, Jean-Philippe Brucker wrote:
> Hi Valmiki,
>
> Sorry for the delay, I was away last week.
>
> On 22/07/17 03:05, valmiki wrote:
>> On 7/12/2017 10:18 PM, Jean-Philippe Brucker wrote:
>>> On 12/07/17 17:27, valmiki wrote:
>>>> On 7/11/2017 4:26 PM, Jean-Philippe Brucker wrote:
>>>>> Hi Valmiki,
>>>>>
>>>>> On 09/07/17 04:15, valmiki wrote:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> In SMMUv3 architecture document i see "PASIDs are optional,
>>>>>>>> configurable, and of a size determined by the minimum
>>>>>>>> of the endpoint".
>>>>>>>>
>>>>>>>> So if PASID's are optional and not supported by PCIe end point, how
>>>>>>>> SVM
>>>>>>>> can be achieved ?
>>>>>>>
>>>>>>> It cannot be inferred from that statement that PASID support is not
>>>>>>> required for SVM.  AIUI, SVM is a software feature enabled by numerous
>>>>>>> "optional" hardware features, including PASID.  Features that are
>>>>>>> optional per the hardware specification may be required for specific
>>>>>>> software features.  Thanks,
>>>>>>>
>>>>>> Thanks for the information Alex. Suppose if an End point doesn't support
>>>>>> PASID, is it still possible to achieve SVM ?
>>>>>> Are there any such features in SMMUv3 with which we can achieve it ?
>>>>>
>>>>> Not really, we don't plan to share the non-PASID context with a process.
>>>>>
>>>>> In theory you could achieve something resembling SVM by assigning the
>>>>> entire endpoint to userspace using VFIO, then use ATS+PRI capabilities
>>>>> with a bind ioctl. If your device can do SR-IOV, then you can bind one
>>>>> process per virtual function.
>>>>>
>>>>> Unless we end up seeing lots of endpoints that implement PRI but not
>>>>> PASID, I don't plan to add this to VFIO or SMMUv3.
>>>>>
>>>>> For a PCIe endpoint, the requirements for SVM are ATS, PRI and PASID
>>>>> enabled. In addition, the SMMU should support DVM (broadcast TLB
>>>>> maintenance) and must be compatible with the MMU (page sizes, output
>>>>> address size, ASID bits...)
>>>>>
>>>> Thanks Jean.
>>>> In SMMU document it was quoted as follows
>>>> "When STE.S1DSS==0b10, a transaction without a SubstreamID is accepted and
>>>> uses the CD of Substream 0. Under this configuration, transactions that
>>>> arrive with SubstreamID 0 are aborted and an event recorded."
>>>>
>>>> Is this mode supported in your previous series of SMMUv3 patches ?
>>>> If it is supported is it achieved through VFIO ?
>>>
>>> Yes, STE.S1DSS==0b10 is the only supported mode with my patches. And in
>>> VFIO, the non-PASID context (CD 0) is managed with
>>> VFIO_IOMMU_MAP/UNMAP_DMA ioctls, mirroring the current behavior for
>>> devices that don't support PASID. All other CDs, with PASID > 0, are
>>> managed via the new BIND ioctl.
>>
>> Thanks Jean, this helps a lot.
>> So i digged through your patches and i understood that using BIND ioctls
>> satge-1 translations are setup in SMMU for an application.
>> If we use VFIO_IOMMU_MAP/UNMAP_DMA ioctls they are setting up stage-2
>> translations in SMMU.
>> So without PASID support we can only work with stage-2 translations ?
>
> It depends what type you use when registering the IOMMU with VFIO_SET_IOMMU:
>
> * If the type is VFIO_TYPE1v2_IOMMU, then VFIO_IOMMU_MAP/UNMAP_DMA
>   affects the stage-1 non-PASID context (already the case in mainline).
>   In addition, with my patch the BIND ioctl will affect stage-1 PASID
>   contexts, and bind process page directories to the device (host SVM).
>
> * If the type is VFIO_TYPE1_NESTING_IOMMU, then VFIO_IOMMU_MAP/UNMAP_DMA
>   will affect stage-2 mappings (already in mainline).
>   With my SMMU patch series, the BIND ioctl is not supported in this mode.
>   But in the future, BIND would allow to manage stage-1 as well:
>   - bind a process page directory (host SVM with added stage-2), or
>   - bind a guest page directory (viommu), or
>   - bind the full stage-1 context table (viommu).

Hi Jean, Thanks a lot for this information.
I tried to understand how stage-1 translations are setup if we use 
VFIO_TYPE1v2_IOMMU & VFIO_IOMMU_MAP/UNMAP_DMA flow, but I'm not 
successful, I couldn't find when context descriptor details are updated 
with stage-1 translation table details in this flow.
I found that in BIND flow a new context descriptor being created and 
assigned with required translation tables.

Can you please point to piece of code/patch series where and how context 
descriptor is updated for VFIO_IOMMU_MAP/UNMAP_DMA flow with 
VFIO_TYPE1v2_IOMMU.


Regards,
Valmiki
