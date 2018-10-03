Return-Path: <SRS0=Y6U6=MP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112DDC00449
	for <linux-pci@archiver.kernel.org>; Wed,  3 Oct 2018 17:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA327213A2
	for <linux-pci@archiver.kernel.org>; Wed,  3 Oct 2018 17:46:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA327213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbeJDAfl (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 3 Oct 2018 20:35:41 -0400
Received: from foss.arm.com ([217.140.101.70]:54634 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbeJDAfl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Oct 2018 20:35:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4000AED1;
        Wed,  3 Oct 2018 10:46:17 -0700 (PDT)
Received: from [10.1.35.75] (lophozonia.cambridge.arm.com [10.1.35.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8728A3F5B3;
        Wed,  3 Oct 2018 10:46:13 -0700 (PDT)
Subject: Re: [PATCH v3 07/10] iommu: Add a page fault handler
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
 <20180920170046.20154-8-jean-philippe.brucker@arm.com>
 <20180927133746.319e19b8@jacob-builder>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <f873cc65-ec0c-9273-eb14-9e07f13d3206@arm.com>
Date:   Wed, 3 Oct 2018 18:46:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180927133746.319e19b8@jacob-builder>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 27/09/2018 21:37, Jacob Pan wrote:
> On Thu, 20 Sep 2018 18:00:43 +0100
> Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:
> 
>> +	/*
>> +	 * When removing a PASID, the device driver tells the device
>> to stop
>> +	 * using it, and flush any pending fault to the IOMMU. In
>> this flush
>> +	 * callback, the IOMMU driver makes sure that there are no
>> such faults
>> +	 * left in the low-level queue.
>> +	 */
>> +	queue->flush(queue->flush_arg, dev, pasid);
>> +
>> +	/*
>> +	 * If at some point the low-level fault queue overflowed and
>> the IOMMU
>> +	 * device had to auto-respond to a 'last' page fault, other
>> faults from
>> +	 * the same Page Request Group may still be stuck in the
>> partial list.
>> +	 * We need to make sure that the next address space using
>> the PASID
>> +	 * doesn't receive them.
>> +	 */
> Trying to understand the intended use case under queue full condition.
> 1 model specific iommu driver register a flush callback to handle
>   internal PRQ drain
> 
> 2 IOMMU HW detects queue full and auto respond with 'SUCCESS' code to
>   all device and PASID, raise interrupt
> 
> 3 model specific iommu driver detects queue full and call
> iopf_queue_flush_dev()

I didn't intent for iopf_queue_flush_dev to be called by the IOMMU driver
in this situation, at the moment it's only intended for the SVA code to
clean up before removing a PASID (in which case we have to wipe partial
faults). This version doesn't provide anything to the IOMMU driver for
handling overflow condition cleanly, partial faults are kept until the
PASID is unbound or SVA is disabled.

> 4 call queue->flush() callback to drain PRQ in-flight inside IOMMU HW

Could we avoid this step in this scenario? If it's the PRI IRQ thread that
detects queue full in step 3, then it could drain the HW queue before
calling iopf_flush_partial() (or something like that). I'm a bit worried
about possible locking problems if we go back to the IOMMU driver here
while it is calling us.

> 5.Shoot down partial list for all PASIDs
> 
> If the above understanding is correct, don't we need to shoot down all
> partial groups? instead of just one PASID. At least for VT-d, we need
> to do that.

Passing IOMMU_PASID_INVALID will do that. But It also needs to be done for
all devices that use this IOPF queue, and we don't need to flush the
workqueue, so iopf_queue_flush_dev isn't really adapted.

Thanks,
Jean

> 
> 
>> +	mutex_lock(&param->lock);
>> +	list_for_each_entry_safe(fault, next,
>> &param->iopf_param->partial, head) {
>> +		if (fault->evt.pasid == pasid || pasid ==
>> IOMMU_PASID_INVALID) {
>> +			list_del(&fault->head);
>> +			kfree(fault);
>> +		}
>> +	}
>> +	mutex_unlock(&param->lock);
>> +
>> +	flush_workqueue(queue->wq);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(iopf_queue_flush_dev);
>> +
> [Jacob Pan]
> 

