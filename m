Return-Path: <SRS0=XSei=MI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87184C43382
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 22:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47CB52154B
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 22:34:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47CB52154B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbeI0Et3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 27 Sep 2018 00:49:29 -0400
Received: from mga07.intel.com ([134.134.136.100]:20015 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbeI0Et3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Sep 2018 00:49:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2018 15:34:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,307,1534834800"; 
   d="scan'208";a="260526400"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga005.jf.intel.com with ESMTP; 26 Sep 2018 15:34:18 -0700
Date:   Wed, 26 Sep 2018 15:35:44 -0700
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
Subject: Re: [PATCH v3 03/10] iommu/sva: Manage process address spaces
Message-ID: <20180926153544.54884f88@jacob-builder>
In-Reply-To: <20180920170046.20154-4-jean-philippe.brucker@arm.com>
References: <20180920170046.20154-1-jean-philippe.brucker@arm.com>
        <20180920170046.20154-4-jean-philippe.brucker@arm.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 20 Sep 2018 18:00:39 +0100
Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:

> +
> +static int io_mm_attach(struct iommu_domain *domain, struct device
> *dev,
> +			struct io_mm *io_mm, void *drvdata)
> +{
> +	int ret;
> +	bool attach_domain = true;
> +	int pasid = io_mm->pasid;
> +	struct iommu_bond *bond, *tmp;
> +	struct iommu_sva_param *param = dev->iommu_param->sva_param;
> +
> +	if (!domain->ops->mm_attach || !domain->ops->mm_detach)
> +		return -ENODEV;
> +
> +	if (pasid > param->max_pasid || pasid < param->min_pasid)
> +		return -ERANGE;
> +
> +	bond = kzalloc(sizeof(*bond), GFP_KERNEL);
> +	if (!bond)
> +		return -ENOMEM;
> +
> +	bond->domain		= domain;
> +	bond->io_mm		= io_mm;
> +	bond->dev		= dev;
> +	bond->drvdata		= drvdata;
> +
> +	spin_lock(&iommu_sva_lock);
> +	/*
> +	 * Check if this io_mm is already bound to the domain. In
> which case the
> +	 * IOMMU driver doesn't have to install the PASID table
> entry.
> +	 */
> +	list_for_each_entry(tmp, &domain->mm_list, domain_head) {
> +		if (tmp->io_mm == io_mm) {
> +			attach_domain = false;
> +			break;
> +		}
> +	}
> +
> +	ret = domain->ops->mm_attach(domain, dev, io_mm,
> attach_domain);
> +	if (ret) {
> +		kfree(bond);
> +		goto out_unlock;
> +	}
> +
> +	list_add(&bond->mm_head, &io_mm->devices);
> +	list_add(&bond->domain_head, &domain->mm_list);
> +	list_add(&bond->dev_head, &param->mm_list);
> +

I am trying to understand if mm_list is needed for both per device and
per domain. Do you always unbind and detach domain? Seems device could
use the domain->mm_list to track all mm's, true?



