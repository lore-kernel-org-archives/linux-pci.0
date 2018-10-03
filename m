Return-Path: <SRS0=Y6U6=MP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03C7C00449
	for <linux-pci@archiver.kernel.org>; Wed,  3 Oct 2018 17:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59A3320684
	for <linux-pci@archiver.kernel.org>; Wed,  3 Oct 2018 17:52:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59A3320684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbeJDAls (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 3 Oct 2018 20:41:48 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54836 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbeJDAlr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Oct 2018 20:41:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A587780D;
        Wed,  3 Oct 2018 10:52:22 -0700 (PDT)
Received: from [10.1.35.75] (lophozonia.cambridge.arm.com [10.1.35.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1EE1E3F5B3;
        Wed,  3 Oct 2018 10:52:17 -0700 (PDT)
Subject: Re: [PATCH v3 03/10] iommu/sva: Manage process address spaces
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "jcrouse@codeaurora.org" <jcrouse@codeaurora.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
        Andrew Murray <Andrew.Murray@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        Robin Murphy <Robin.Murphy@arm.com>,
        "ashok.raj@intel.com" <ashok.raj@intel.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "xuzaibo@huawei.com" <xuzaibo@huawei.com>,
        "liguozhu@hisilicon.com" <liguozhu@hisilicon.com>,
        "okaya@codeaurora.org" <okaya@codeaurora.org>,
        "bharatku@xilinx.com" <bharatku@xilinx.com>,
        "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
        "shunyong.yang@hxt-semitech.com" <shunyong.yang@hxt-semitech.com>
References: <20180920170046.20154-1-jean-philippe.brucker@arm.com>
 <20180920170046.20154-4-jean-philippe.brucker@arm.com>
 <20180926153544.54884f88@jacob-builder>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <8ebfd3b5-9e16-85f6-a9f9-2627fb4b5b03@arm.com>
Date:   Wed, 3 Oct 2018 18:52:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180926153544.54884f88@jacob-builder>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 26/09/2018 23:35, Jacob Pan wrote:
> On Thu, 20 Sep 2018 18:00:39 +0100
> Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:
> 
>> +
>> +static int io_mm_attach(struct iommu_domain *domain, struct device
>> *dev,
>> +			struct io_mm *io_mm, void *drvdata)
>> +{
>> +	int ret;
>> +	bool attach_domain = true;
>> +	int pasid = io_mm->pasid;
>> +	struct iommu_bond *bond, *tmp;
>> +	struct iommu_sva_param *param = dev->iommu_param->sva_param;
>> +
>> +	if (!domain->ops->mm_attach || !domain->ops->mm_detach)
>> +		return -ENODEV;
>> +
>> +	if (pasid > param->max_pasid || pasid < param->min_pasid)
>> +		return -ERANGE;
>> +
>> +	bond = kzalloc(sizeof(*bond), GFP_KERNEL);
>> +	if (!bond)
>> +		return -ENOMEM;
>> +
>> +	bond->domain		= domain;
>> +	bond->io_mm		= io_mm;
>> +	bond->dev		= dev;
>> +	bond->drvdata		= drvdata;
>> +
>> +	spin_lock(&iommu_sva_lock);
>> +	/*
>> +	 * Check if this io_mm is already bound to the domain. In
>> which case the
>> +	 * IOMMU driver doesn't have to install the PASID table
>> entry.
>> +	 */
>> +	list_for_each_entry(tmp, &domain->mm_list, domain_head) {
>> +		if (tmp->io_mm == io_mm) {
>> +			attach_domain = false;
>> +			break;
>> +		}
>> +	}
>> +
>> +	ret = domain->ops->mm_attach(domain, dev, io_mm,
>> attach_domain);
>> +	if (ret) {
>> +		kfree(bond);
>> +		goto out_unlock;
>> +	}
>> +
>> +	list_add(&bond->mm_head, &io_mm->devices);
>> +	list_add(&bond->domain_head, &domain->mm_list);
>> +	list_add(&bond->dev_head, &param->mm_list);
>> +
> 
> I am trying to understand if mm_list is needed for both per device and
> per domain. Do you always unbind and detach domain? Seems device could
> use the domain->mm_list to track all mm's, true?

We need to track bonds per devices, since the bind/unbind() user interface
in on devices. Tracking per domain is just a helper, so IOMMU drivers that
have a single PASID table per domain know when they need to install a new
entry (the attach_domain parameter above) and remove it. I think my code
is wrong here: if binding two devices that are in the same domain to the
same process we shouldn't add the io_mm to domain->mm_list twice.

I'm still not sure if I should remove domains handling here though, could
you confirm if you're planning to support iommu_get_domain_for_dev for vt-d?

Thanks,
Jean
