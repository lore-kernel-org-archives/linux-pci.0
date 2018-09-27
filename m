Return-Path: <SRS0=vBCh=MJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8856C43382
	for <linux-pci@archiver.kernel.org>; Thu, 27 Sep 2018 20:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A01A5216FE
	for <linux-pci@archiver.kernel.org>; Thu, 27 Sep 2018 20:36:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A01A5216FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbeI1C4Z (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 27 Sep 2018 22:56:25 -0400
Received: from mga05.intel.com ([192.55.52.43]:53097 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727407AbeI1C4Y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Sep 2018 22:56:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Sep 2018 13:36:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,312,1534834800"; 
   d="scan'208";a="76611565"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga007.jf.intel.com with ESMTP; 27 Sep 2018 13:36:20 -0700
Date:   Thu, 27 Sep 2018 13:37:46 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     iommu@lists.linux-foundation.org, joro@8bytes.org,
        linux-pci@vger.kernel.org, jcrouse@codeaurora.org,
        alex.williamson@redhat.com, Jonathan.Cameron@huawei.com,
        christian.koenig@amd.com, eric.auger@redhat.com,
        kevin.tian@intel.com, yi.l.liu@intel.com, andrew.murray@arm.com,
        will.deacon@arm.com, robin.murphy@arm.com, ashok.raj@intel.com,
        baolu.lu@linux.intel.com, xuzaibo@huawei.com,
        liguozhu@hisilicon.com, okaya@codeaurora.org, bharatku@xilinx.com,
        ilias.apalodimas@linaro.org, shunyong.yang@hxt-semitech.com,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v3 07/10] iommu: Add a page fault handler
Message-ID: <20180927133746.319e19b8@jacob-builder>
In-Reply-To: <20180920170046.20154-8-jean-philippe.brucker@arm.com>
References: <20180920170046.20154-1-jean-philippe.brucker@arm.com>
        <20180920170046.20154-8-jean-philippe.brucker@arm.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 20 Sep 2018 18:00:43 +0100
Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:

> +	/*
> +	 * When removing a PASID, the device driver tells the device
> to stop
> +	 * using it, and flush any pending fault to the IOMMU. In
> this flush
> +	 * callback, the IOMMU driver makes sure that there are no
> such faults
> +	 * left in the low-level queue.
> +	 */
> +	queue->flush(queue->flush_arg, dev, pasid);
> +
> +	/*
> +	 * If at some point the low-level fault queue overflowed and
> the IOMMU
> +	 * device had to auto-respond to a 'last' page fault, other
> faults from
> +	 * the same Page Request Group may still be stuck in the
> partial list.
> +	 * We need to make sure that the next address space using
> the PASID
> +	 * doesn't receive them.
> +	 */
Trying to understand the intended use case under queue full condition.
1 model specific iommu driver register a flush callback to handle
  internal PRQ drain

2 IOMMU HW detects queue full and auto respond with 'SUCCESS' code to
  all device and PASID, raise interrupt

3 model specific iommu driver detects queue full and call
iopf_queue_flush_dev()

4 call queue->flush() callback to drain PRQ in-flight inside IOMMU HW
5.Shoot down partial list for all PASIDs

If the above understanding is correct, don't we need to shoot down all
partial groups? instead of just one PASID. At least for VT-d, we need
to do that.


> +	mutex_lock(&param->lock);
> +	list_for_each_entry_safe(fault, next,
> &param->iopf_param->partial, head) {
> +		if (fault->evt.pasid == pasid || pasid ==
> IOMMU_PASID_INVALID) {
> +			list_del(&fault->head);
> +			kfree(fault);
> +		}
> +	}
> +	mutex_unlock(&param->lock);
> +
> +	flush_workqueue(queue->wq);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(iopf_queue_flush_dev);
> +
[Jacob Pan]
