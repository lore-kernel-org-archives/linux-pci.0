Return-Path: <SRS0=zVIF=MH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912B0C43382
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 05:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D0EF20C0A
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 05:01:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D0EF20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbeIYLGv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 25 Sep 2018 07:06:51 -0400
Received: from mga01.intel.com ([192.55.52.88]:20895 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbeIYLGv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Sep 2018 07:06:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2018 22:01:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,300,1534834800"; 
   d="scan'208";a="72624921"
Received: from allen-box.sh.intel.com (HELO [10.239.161.122]) ([10.239.161.122])
  by fmsmga007.fm.intel.com with ESMTP; 24 Sep 2018 22:01:04 -0700
Cc:     baolu.lu@linux.intel.com, joro@8bytes.org,
        linux-pci@vger.kernel.org, jcrouse@codeaurora.org,
        alex.williamson@redhat.com, Jonathan.Cameron@huawei.com,
        jacob.jun.pan@linux.intel.com, christian.koenig@amd.com,
        eric.auger@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
        andrew.murray@arm.com, will.deacon@arm.com, robin.murphy@arm.com,
        ashok.raj@intel.com, xuzaibo@huawei.com, liguozhu@hisilicon.com,
        okaya@codeaurora.org, bharatku@xilinx.com,
        ilias.apalodimas@linaro.org, shunyong.yang@hxt-semitech.com
Subject: Re: [PATCH v3 06/10] iommu/sva: Search mm by PASID
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        iommu@lists.linux-foundation.org
References: <20180920170046.20154-1-jean-philippe.brucker@arm.com>
 <20180920170046.20154-7-jean-philippe.brucker@arm.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <bb2e42bb-175a-3368-4a53-8872e63e8d3e@linux.intel.com>
Date:   Tue, 25 Sep 2018 12:59:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180920170046.20154-7-jean-philippe.brucker@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 09/21/2018 01:00 AM, Jean-Philippe Brucker wrote:
> The fault handler will need to find an mm given its PASID. This is the
> reason we have an IDR for storing address spaces, so hook it up.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> ---
>   drivers/iommu/iommu-sva.c | 26 ++++++++++++++++++++++++++
>   include/linux/iommu.h     |  7 +++++++
>   2 files changed, 33 insertions(+)
> 
> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> index 5ff8967cb213..ee86f00ee1b9 100644
> --- a/drivers/iommu/iommu-sva.c
> +++ b/drivers/iommu/iommu-sva.c
> @@ -636,6 +636,32 @@ void iommu_sva_unbind_device_all(struct device *dev)
>   }
>   EXPORT_SYMBOL_GPL(iommu_sva_unbind_device_all);
>   
> +/**
> + * iommu_sva_find() - Find mm associated to the given PASID
> + * @pasid: Process Address Space ID assigned to the mm
> + *
> + * Returns the mm corresponding to this PASID, or NULL if not found. A reference
> + * to the mm is taken, and must be released with mmput().
> + */
> +struct mm_struct *iommu_sva_find(int pasid)
> +{
> +	struct io_mm *io_mm;
> +	struct mm_struct *mm = NULL;
> +
> +	spin_lock(&iommu_sva_lock);
> +	io_mm = idr_find(&iommu_pasid_idr, pasid);

The same thing here. We can't guarantee that a pointer of mm_struct type
is associated with a pasid value when pasid is also used for other
purposes. If hardware reports a bad pasid, this function might run into
problem.

Best regards,
Lu Baolu

> +	if (io_mm && io_mm_get_locked(io_mm)) {
> +		if (mmget_not_zero(io_mm->mm))
> +			mm = io_mm->mm;
> +
> +		io_mm_put_locked(io_mm);
> +	}
> +	spin_unlock(&iommu_sva_lock);
> +
> +	return mm;
> +}
> +EXPORT_SYMBOL_GPL(iommu_sva_find);
> +
>   /**
>    * iommu_sva_init_device() - Initialize Shared Virtual Addressing for a device
>    * @dev: the device
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 429f3dc37a35..a457650b80de 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -987,6 +987,8 @@ extern int __iommu_sva_bind_device(struct device *dev, struct mm_struct *mm,
>   				   void *drvdata);
>   extern int __iommu_sva_unbind_device(struct device *dev, int pasid);
>   extern void iommu_sva_unbind_device_all(struct device *dev);
> +extern struct mm_struct *iommu_sva_find(int pasid);
> +
>   #else /* CONFIG_IOMMU_SVA */
>   static inline int iommu_sva_init_device(struct device *dev,
>   					unsigned long features,
> @@ -1016,6 +1018,11 @@ static inline int __iommu_sva_unbind_device(struct device *dev, int pasid)
>   static inline void iommu_sva_unbind_device_all(struct device *dev)
>   {
>   }
> +
> +static inline struct mm_struct *iommu_sva_find(int pasid)
> +{
> +	return NULL;
> +}
>   #endif /* CONFIG_IOMMU_SVA */
>   
>   #endif /* __LINUX_IOMMU_H */
> 
