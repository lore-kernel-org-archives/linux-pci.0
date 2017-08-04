Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50368 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751475AbdHDJkt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Aug 2017 05:40:49 -0400
Subject: Re: Support SVM without PASID
To: "Tian, Kevin" <kevin.tian@intel.com>,
        valmiki <valmikibow@gmail.com>,
        Alex Williamson <alex.williamson@redhat.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Lan, Tianyu" <tianyu.lan@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>
References: <a30962a6-2240-9263-96cc-10da1b179fcc@gmail.com>
 <20170708140257.2de02d63@w520.home>
 <73619426-6fcc-21ce-cfd4-8c66bde63f9a@gmail.com>
 <eb132dfa-6708-5898-c2ce-ce7ab08809b1@arm.com>
 <ee41f5d9-e7fb-8f7c-4b85-87cdb951ec70@gmail.com>
 <ca0d9f94-f5e2-aaaf-2c64-0cd6ecc62754@arm.com>
 <41333a03-bf91-1152-4779-6579845609f6@gmail.com>
 <564ba70b-db95-7fe0-86bb-bb4eefcd87ec@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D190D57191@SHSMSX101.ccr.corp.intel.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <b973c557-1b4a-18d2-a05e-28680a49daf9@arm.com>
Date: Fri, 4 Aug 2017 10:42:41 +0100
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D190D57191@SHSMSX101.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Kevin,

On 04/08/17 02:49, Tian, Kevin wrote:
>> From: Jean-Philippe Brucker
>> Sent: Tuesday, August 1, 2017 4:26 PM
>>
>> It depends what type you use when registering the IOMMU with
>> VFIO_SET_IOMMU:
>>
>> * If the type is VFIO_TYPE1v2_IOMMU, then
>> VFIO_IOMMU_MAP/UNMAP_DMA
>>   affects the stage-1 non-PASID context (already the case in mainline).
>>   In addition, with my patch the BIND ioctl will affect stage-1 PASID
>>   contexts, and bind process page directories to the device (host SVM).
>>
>> * If the type is VFIO_TYPE1_NESTING_IOMMU, then
>> VFIO_IOMMU_MAP/UNMAP_DMA
>>   will affect stage-2 mappings (already in mainline).
>>   With my SMMU patch series, the BIND ioctl is not supported in this mode.
>>   But in the future, BIND would allow to manage stage-1 as well:
>>   - bind a process page directory (host SVM with added stage-2), or
> 
> I thought host SVM will only go through VFIO_TYPE1v2_IOMMU,
> since you said stage-2 in ARM SMMU is only for GPA->HPA usage
> in previous explanation. then what does "host SVM with added 
> stage-2" mean here?

Ah, that's just a crazy idea I had. I'm not sure it is useful or worth
implementing, but it is one of the possibility offered by nested translation.

Consider the situation where a userspace driver (no virtualization) is
built in a client-server fashion: the server controls a device and spawns
new processes (clients), each sharing a context with the device using its
own PASID. If the server wants to hide parts of the client address space
from the device (e.g. .text), then it could control stage-2 via MAP/UNMAP
to restrict the address space.

It would use different semantics of MAP/UNMAP though, as the ioctl would
only be used to define 1:1 translation windows, not pin memory.

Thanks,
Jean
