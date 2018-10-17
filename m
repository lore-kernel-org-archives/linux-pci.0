Return-Path: <SRS0=Zwnb=M5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFC1ECDE30
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 14:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61F6D205F4
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 14:24:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61F6D205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbeJQWU3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Oct 2018 18:20:29 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52646 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727013AbeJQWU3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Oct 2018 18:20:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFF0780D;
        Wed, 17 Oct 2018 07:24:32 -0700 (PDT)
Received: from [10.1.196.78] (unknown [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A69FF3F59C;
        Wed, 17 Oct 2018 07:24:29 -0700 (PDT)
Subject: Re: [RFC PATCH v3 10/10] iommu/sva: Add support for private PASIDs
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To:     iommu@lists.linux-foundation.org, joro@8bytes.org,
        linux-pci@vger.kernel.org, alex.williamson@redhat.com,
        Jonathan.Cameron@huawei.com, jacob.jun.pan@linux.intel.com,
        christian.koenig@amd.com, eric.auger@redhat.com,
        kevin.tian@intel.com, yi.l.liu@intel.com, andrew.murray@arm.com,
        will.deacon@arm.com, robin.murphy@arm.com, ashok.raj@intel.com,
        baolu.lu@linux.intel.com, xuzaibo@huawei.com,
        liguozhu@hisilicon.com, okaya@codeaurora.org, bharatku@xilinx.com,
        ilias.apalodimas@linaro.org, shunyong.yang@hxt-semitech.com
References: <20180920170046.20154-1-jean-philippe.brucker@arm.com>
 <20180920170046.20154-11-jean-philippe.brucker@arm.com>
 <20181012143229.GI9977@jcrouse-lnx.qualcomm.com>
 <3e1b58bb-eb16-5855-2922-2b15b37ba971@arm.com>
Message-ID: <3ab968f0-4da5-eba8-94a1-8f42b8af8a49@arm.com>
Date:   Wed, 17 Oct 2018 15:24:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <3e1b58bb-eb16-5855-2922-2b15b37ba971@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 17/10/2018 15:21, Jean-Philippe Brucker wrote:
> Hi Jordan,
> 
> On 12/10/2018 15:32, Jordan Crouse wrote:
>> On Thu, Sep 20, 2018 at 06:00:46PM +0100, Jean-Philippe Brucker wrote:
>>> Provide an API for allocating PASIDs and populating them manually. To ease
>>> cleanup and factor allocation code, reuse the io_mm structure for private
>>> PASID. Private io_mm has a NULL mm_struct pointer, and cannot be bound to
>>> multiple devices. The mm_alloc() IOMMU op must now check if the mm
>>> argument is NULL, in which case it should allocate io_pgtables instead of
>>> binding to an mm.
>>>
>>> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
>>> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
>>> ---
>>> Sadly this probably won't be the final thing. The API in this patch is
>>> used like this:
>>>
>>>         iommu_sva_alloc_pasid(dev, &io_mm) -> PASID
>>>         iommu_sva_map(io_mm, ...)
>>>         iommu_sva_unmap(io_mm, ...)
>>>         iommu_sva_free_pasid(dev, io_mm)
>>>
>>> The proposed API for auxiliary domains is in an early stage but might
>>> replace this patch and could be used like this:
>>>
>>>         iommu_enable_aux_domain(dev)
>>>         d = iommu_domain_alloc()
>>>         iommu_attach_aux(dev, d)
>>>         iommu_aux_id(d) -> PASID
>>>         iommu_map(d, ...)
>>>         iommu_unmap(d, ...)
>>>         iommu_detach_aux(dev, d)
>>>         iommu_domain_free(d)
>>>
>>> The advantage being that the driver doesn't have to use a special
>>> version of map/unmap/etc.
>>
>> Hi Jean-Phillippe -
>>
>> Have you thought about this any more? I want to send out a
>> refresh for the per-context pagetables for arm-smmu so if we want to change
>> the underlying assumptions this would be a great time.
>>
>> For my part I'm okay with either model. In fact the second one is closer
>> to the original implementation that I sent out so I have a clear development
>> path in mind for either option depending on what the community decides.
> 
> We'll probably go with the second model. I'm trying to make the latest
> version work with SMMUv3
> (https://lwn.net/ml/linux-kernel/20181012051632.26064-1-baolu.lu@linux.intel.com/)
> and I'd like to send an RFC soon
> 
> Thanks,
> Jean
> IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.

Ugh. Please disregard this notice.

Thanks,
Jean
