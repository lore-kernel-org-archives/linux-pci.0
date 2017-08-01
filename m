Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44310 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751327AbdHASiW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Aug 2017 14:38:22 -0400
Subject: Re: Support SVM without PASID
To: valmiki <valmikibow@gmail.com>,
        Alex Williamson <alex.williamson@redhat.com>
Cc: iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-pci@vger.kernel.org, tianyu.lan@intel.com,
        kevin.tian@intel.com, jacob.jun.pan@intel.com
References: <a30962a6-2240-9263-96cc-10da1b179fcc@gmail.com>
 <20170708140257.2de02d63@w520.home>
 <73619426-6fcc-21ce-cfd4-8c66bde63f9a@gmail.com>
 <eb132dfa-6708-5898-c2ce-ce7ab08809b1@arm.com>
 <ee41f5d9-e7fb-8f7c-4b85-87cdb951ec70@gmail.com>
 <ca0d9f94-f5e2-aaaf-2c64-0cd6ecc62754@arm.com>
 <41333a03-bf91-1152-4779-6579845609f6@gmail.com>
 <564ba70b-db95-7fe0-86bb-bb4eefcd87ec@arm.com>
 <32b6402d-40fb-d40c-32f3-1ed6b9a3185a@gmail.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <c142fb8e-3618-152a-fbe3-521e6c8ff9bf@arm.com>
Date: Tue, 1 Aug 2017 19:40:08 +0100
MIME-Version: 1.0
In-Reply-To: <32b6402d-40fb-d40c-32f3-1ed6b9a3185a@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 01/08/17 18:38, valmiki wrote:
[...]
>>> So i digged through your patches and i understood that using BIND ioctls
>>> satge-1 translations are setup in SMMU for an application.
>>> If we use VFIO_IOMMU_MAP/UNMAP_DMA ioctls they are setting up stage-2
>>> translations in SMMU.
>>> So without PASID support we can only work with stage-2 translations ?
>>
>> It depends what type you use when registering the IOMMU with
>> VFIO_SET_IOMMU:
>>
>> * If the type is VFIO_TYPE1v2_IOMMU, then VFIO_IOMMU_MAP/UNMAP_DMA
>>   affects the stage-1 non-PASID context (already the case in mainline).
>>   In addition, with my patch the BIND ioctl will affect stage-1 PASID
>>   contexts, and bind process page directories to the device (host SVM).
>>
>> * If the type is VFIO_TYPE1_NESTING_IOMMU, then VFIO_IOMMU_MAP/UNMAP_DMA
>>   will affect stage-2 mappings (already in mainline).
>>   With my SMMU patch series, the BIND ioctl is not supported in this mode.
>>   But in the future, BIND would allow to manage stage-1 as well:
>>   - bind a process page directory (host SVM with added stage-2), or
>>   - bind a guest page directory (viommu), or
>>   - bind the full stage-1 context table (viommu).
> 
> Hi Jean, Thanks a lot for this information.
> I tried to understand how stage-1 translations are setup if we use
> VFIO_TYPE1v2_IOMMU & VFIO_IOMMU_MAP/UNMAP_DMA flow, but I'm not
> successful, I couldn't find when context descriptor details are updated
> with stage-1 translation table details in this flow.
> I found that in BIND flow a new context descriptor being created and
> assigned with required translation tables.
> 
> Can you please point to piece of code/patch series where and how context
> descriptor is updated for VFIO_IOMMU_MAP/UNMAP_DMA flow with
> VFIO_TYPE1v2_IOMMU.

What happens for SMMU is during initialization, the
VFIO_GROUP_SET_CONTAINER ioctl calls vfio_iommu_type1_attach_group.
This function creates a new iommu_domain, and then calls
iommu_attach_group(domain, group), which calls arm_smmu_attach_dev(domain,
dev) for all devices in the group.

If necessary we detach the existing domain, by clearing the STE (and all
contexts). Then, since the new domain is only partially initialized, we
call arm_smmu_domain_finalise, which allocates the page tables, and ends
up calling arm_smmu_domain_finalise_s1. That function prepares the
configuration of context descriptor 0, which is used for non-PASID
mappings. Afterwards, back in arm_smmu_attach_dev, context descriptor 0 is
written, along with the STE, and then the domain is live.

Then when userspace does VFIO_IOMMU_MAP/UNMAP_DMA, iommu_map/unmap are
called on that domain. arm_smmu_map/unmap update the page tables attached
to context descriptor 0 (but they don't modify the CD in any way).

This is the current behavior in mainline Linux. My patch series don't
change this, as we need to keep backward compatibility for all VFIO IOMMU
types.

Thanks,
Jean
