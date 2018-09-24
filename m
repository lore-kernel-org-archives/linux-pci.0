Return-Path: <SRS0=+fdl=MG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DD7C433F4
	for <linux-pci@archiver.kernel.org>; Mon, 24 Sep 2018 12:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E6220C0A
	for <linux-pci@archiver.kernel.org>; Mon, 24 Sep 2018 12:08:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85E6220C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbeIXSJw (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:09:52 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33472 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728516AbeIXSJw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Sep 2018 14:09:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 550B780D;
        Mon, 24 Sep 2018 05:08:04 -0700 (PDT)
Received: from [10.4.12.111] (ostrya.Emea.Arm.com [10.4.12.111])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D87D03F5C0;
        Mon, 24 Sep 2018 05:08:00 -0700 (PDT)
Subject: Re: [PATCH v3 01/10] iommu: Introduce Shared Virtual Addressing API
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Cc:     "joro@8bytes.org" <joro@8bytes.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "jcrouse@codeaurora.org" <jcrouse@codeaurora.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
        Andrew Murray <Andrew.Murray@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        Robin Murphy <Robin.Murphy@arm.com>,
        "ashok.raj@intel.com" <ashok.raj@intel.com>,
        "xuzaibo@huawei.com" <xuzaibo@huawei.com>,
        "liguozhu@hisilicon.com" <liguozhu@hisilicon.com>,
        "okaya@codeaurora.org" <okaya@codeaurora.org>,
        "bharatku@xilinx.com" <bharatku@xilinx.com>,
        "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
        "shunyong.yang@hxt-semitech.com" <shunyong.yang@hxt-semitech.com>
References: <20180920170046.20154-1-jean-philippe.brucker@arm.com>
 <20180920170046.20154-2-jean-philippe.brucker@arm.com>
 <f406bcf7-4e54-9f1b-88eb-03fc642ffede@linux.intel.com>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <64630c7b-8349-37dd-3fbb-d03c8bc05511@arm.com>
Date:   Mon, 24 Sep 2018 13:07:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <f406bcf7-4e54-9f1b-88eb-03fc642ffede@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 23/09/2018 03:39, Lu Baolu wrote:
>> +int iommu_sva_init_device(struct device *dev, unsigned long features,
>> +                    unsigned int min_pasid, unsigned int max_pasid)
>> +{
>> +     int ret;
>> +     struct iommu_sva_param *param;
>> +     struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> 
> This doesn't work for vt-d. The domains for host iova are self-managed
> by vt-d driver itself. Hence, iommu_get_domain_for_dev() will always
> return NULL unless an UNMANAGED domain is attached to the device.
> 
> How about
> 
>        const struct iommu_ops *ops = dev->bus->iommu_ops;>
> instead?

Right, this should work. I also needed to change the IOMMU ops
introduced in patch 3 to not take a domain. It's a shame that iommu-sva
can't get the device's current domain, I was hoping we could manage the
bonds per domain in common code. But it's not a big deal and on the
upside, it simplifies these core patches.

I was previously relying on "if we have a domain, then
iommu_group_add_device has been called and therefore dev->iommu_param is
set". I now do the same as iommu_register_device_fault_handler, check if
iommu_param isn't NULL. I don't think there is a race with
iommu_group_add/remove_device, since the device driver cannot call SVA
functions before the core called its probe() callback and after the core
called its remove() callback, which happen after
iommu_group_add_device() and before iommu_group_remove_device()
respectively. Though I don't have a full picture here, and might be wrong.

I pushed the updated version to my sva/current branch

Thanks,
Jean
