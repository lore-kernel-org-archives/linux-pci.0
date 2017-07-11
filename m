Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:43320 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752023AbdGKKxZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Jul 2017 06:53:25 -0400
Subject: Re: Support SVM without PASID
To: valmiki <valmikibow@gmail.com>,
        Alex Williamson <alex.williamson@redhat.com>
Cc: iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-pci@vger.kernel.org, tianyu.lan@intel.com,
        kevin.tian@intel.com, jacob.jun.pan@intel.com
References: <a30962a6-2240-9263-96cc-10da1b179fcc@gmail.com>
 <20170708140257.2de02d63@w520.home>
 <73619426-6fcc-21ce-cfd4-8c66bde63f9a@gmail.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <eb132dfa-6708-5898-c2ce-ce7ab08809b1@arm.com>
Date: Tue, 11 Jul 2017 11:56:16 +0100
MIME-Version: 1.0
In-Reply-To: <73619426-6fcc-21ce-cfd4-8c66bde63f9a@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Valmiki,

On 09/07/17 04:15, valmiki wrote:
>>> Hi,
>>>
>>> In SMMUv3 architecture document i see "PASIDs are optional,
>>> configurable, and of a size determined by the minimum
>>> of the endpoint".
>>>
>>> So if PASID's are optional and not supported by PCIe end point, how SVM
>>> can be achieved ?
>>
>> It cannot be inferred from that statement that PASID support is not
>> required for SVM.  AIUI, SVM is a software feature enabled by numerous
>> "optional" hardware features, including PASID.  Features that are
>> optional per the hardware specification may be required for specific
>> software features.  Thanks,
>>
> Thanks for the information Alex. Suppose if an End point doesn't support
> PASID, is it still possible to achieve SVM ?
> Are there any such features in SMMUv3 with which we can achieve it ?

Not really, we don't plan to share the non-PASID context with a process.

In theory you could achieve something resembling SVM by assigning the
entire endpoint to userspace using VFIO, then use ATS+PRI capabilities
with a bind ioctl. If your device can do SR-IOV, then you can bind one
process per virtual function.

Unless we end up seeing lots of endpoints that implement PRI but not
PASID, I don't plan to add this to VFIO or SMMUv3.

For a PCIe endpoint, the requirements for SVM are ATS, PRI and PASID
enabled. In addition, the SMMU should support DVM (broadcast TLB
maintenance) and must be compatible with the MMU (page sizes, output
address size, ASID bits...)

Thanks,
Jean
