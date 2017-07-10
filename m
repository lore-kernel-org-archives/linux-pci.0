Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([45.249.212.189]:8887 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752838AbdGJAOW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 Jul 2017 20:14:22 -0400
Subject: Re: Support SVM without PASID
To: valmiki <valmikibow@gmail.com>,
        Alex Williamson <alex.williamson@redhat.com>
References: <a30962a6-2240-9263-96cc-10da1b179fcc@gmail.com>
 <20170708140257.2de02d63@w520.home>
 <73619426-6fcc-21ce-cfd4-8c66bde63f9a@gmail.com>
CC: <tianyu.lan@intel.com>, <kevin.tian@intel.com>,
        <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>, <jacob.jun.pan@intel.com>
From: Bob Liu <liubo95@huawei.com>
Message-ID: <b92c4abd-cf3a-6b08-754d-a859fe45cacf@huawei.com>
Date: Mon, 10 Jul 2017 08:14:09 +0800
MIME-Version: 1.0
In-Reply-To: <73619426-6fcc-21ce-cfd4-8c66bde63f9a@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2017/7/9 11:15, valmiki wrote:
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
> 

I don't think so.
But one option is your device has an internal MMU. e.g Nvidia GPU.

Thanks,
Bob Liu
