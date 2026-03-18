Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E87313E2B;
	Wed, 18 Mar 2026 06:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773814457; cv=none; b=aZ5wDsJh+g4gM2akTUpa4YGp76DffqISajec0RkiLd35LgFs3ZpeWLuM7naO02lm6lXjlKsN5bTGqYtROf9bCE5aPzxi9tQ2z6yjRKe1xyc4mxsUD5ehtF5JSA0ke4Mq9v4+0YUHb5bAr2q192b1El8j15v+t/7Ro3QKmr4KrKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773814457; c=relaxed/simple;
	bh=DkHUnEo/Buc1iI8h0hzSm7QzwytPckEV+C7X+Kypm6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rc8a/m4licOD893u1tB7dd4dkKV39CDGr5XcRlKleGBeFVetbs2CIhDTIAxLiWfwSleJGZwbrtCe0jACslJOn+v1i32UX6fgxbflJoP2grnKfdH9W+PuTBscXetoVcT/gQPcwv8vKEpQL4LvmFWpo7V85m20SJ2TvLD+J2FfDpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ThU7rf/f; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ThU7rf/f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773814456; x=1805350456;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DkHUnEo/Buc1iI8h0hzSm7QzwytPckEV+C7X+Kypm6E=;
  b=ThU7rf/f2bbXa3igaTn3wXXepU7XKFXrsrhXxtl9Uz3btRe1TMF9S/zM
   o+jKxEbKKf1VhIGkBtlBM5vpVuOoLiYRF0uaGG4WpI1FW1dgayx92/KQx
   bPyzHwtMsjaDvLWYelrcwK53CLAsavpcM4RXTgHp24o+//VwcakPsqv0X
   YHDJviOQ/Nv+ZvMco81+6iO0S2VLViXNTaLm1kk/gKB2Y/iKE39BIJP8M
   H1r9+mn+VO4HsH4frKefcI3tOikzTVCIdYbYx1bv+SHRBsuCKKweEXrrS
   l+5s0pJjTCf/6cgM94TgwO7CSnWUzm6LHfGnJ1Z/+3Y9wbDto751UVbvp
   w==;
X-CSE-ConnectionGUID: MTkhzz5ZQmS6pLbQ64+mcQ==
X-CSE-MsgGUID: UA87a2JcQjm6A0pBwUlcaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="85494663"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="85494663"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 23:14:15 -0700
X-CSE-ConnectionGUID: Z1FGCetaTSGF++XIxaxXEg==
X-CSE-MsgGUID: iCZ0jeD2TnyuQZO6sIHcrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="222567515"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 23:14:11 -0700
Message-ID: <791a46c7-3129-4438-86bd-b7677e01332a@linux.intel.com>
Date: Wed, 18 Mar 2026 14:13:09 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] iommu: Add iommu_report_device_broken() to
 quarantine a broken device
To: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
 robin.murphy@arm.com, joro@8bytes.org, bhelgaas@google.com, jgg@nvidia.com
Cc: rafael@kernel.org, lenb@kernel.org, praan@google.com,
 xueshuai@linux.alibaba.com, kevin.tian@intel.com,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-pci@vger.kernel.org, vsethi@nvidia.com
References: <cover.1773774441.git.nicolinc@nvidia.com>
 <c5390aeaeccfa86a1c79f26d2c0ff5df380940a4.1773774441.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <c5390aeaeccfa86a1c79f26d2c0ff5df380940a4.1773774441.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/18/26 03:15, Nicolin Chen wrote:
> When an IOMMU hardware detects an error due to a faulty device (e.g. an ATS
> invalidation timeout), IOMMU drivers may quarantine the device by disabling
> specific hardware features or dropping translation capabilities.
> 
> However, the core-level states of the faulty device are out of sync, as the
> device can be still attached to a translation domain or even potentially be
> moved to a new domain that might overwrite the driver-level quarantine.
> 
> Given that such an error can be likely an ISR, introduce a broken_work per
> iommu_group, and add a helper function to allow driver to report the broken
> device, so as to completely quarantine it in the core.
> 
> Use the existing pci_dev_reset_iommu_prepare() function to shift the device
> to its resetting_domain/blocking_domain. A later pci_dev_reset_iommu_done()
> call will clear it and move it out of the quarantine.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   include/linux/iommu.h |  2 ++
>   drivers/iommu/iommu.c | 59 +++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 61 insertions(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 9ba12b2164724..9b5f94e566ff9 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -891,6 +891,8 @@ static inline struct iommu_device *__iommu_get_iommu_dev(struct device *dev)
>   #define iommu_get_iommu_dev(dev, type, member) \
>   	container_of(__iommu_get_iommu_dev(dev), type, member)
>   
> +void iommu_report_device_broken(struct device *dev);
> +
>   static inline void iommu_iotlb_gather_init(struct iommu_iotlb_gather *gather)
>   {
>   	*gather = (struct iommu_iotlb_gather) {
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index fcd2902d9e8db..2f297f689a3a3 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -55,6 +55,8 @@ struct iommu_group {
>   	struct list_head devices;
>   	struct xarray pasid_array;
>   	struct mutex mutex;
> +	struct work_struct broken_work;
> +	bool requires_reset;
>   	void *iommu_data;
>   	void (*iommu_data_release)(void *iommu_data);
>   	char *name;
> @@ -146,6 +148,7 @@ static struct group_device *iommu_group_alloc_device(struct iommu_group *group,
>   						     struct device *dev);
>   static void __iommu_group_free_device(struct iommu_group *group,
>   				      struct group_device *grp_dev);
> +static void iommu_group_broken_worker(struct work_struct *work);
>   static void iommu_domain_init(struct iommu_domain *domain, unsigned int type,
>   			      const struct iommu_ops *ops);
>   
> @@ -1057,6 +1060,7 @@ struct iommu_group *iommu_group_alloc(void)
>   	if (!group)
>   		return ERR_PTR(-ENOMEM);
>   
> +	INIT_WORK(&group->broken_work, iommu_group_broken_worker);
>   	group->kobj.kset = iommu_group_kset;
>   	mutex_init(&group->mutex);
>   	INIT_LIST_HEAD(&group->devices);
> @@ -4031,6 +4035,7 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev)
>   	if (WARN_ON(!group->blocking_domain))
>   		return;
>   
> +	WRITE_ONCE(group->requires_reset, false);
>   	/*
>   	 * A PCI device might have been in an error state, so the IOMMU driver
>   	 * had to quarantine the device by disabling specific hardware feature
> @@ -4062,6 +4067,60 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev)
>   }
>   EXPORT_SYMBOL_GPL(pci_dev_reset_iommu_done);
>   
> +static void iommu_group_broken_worker(struct work_struct *work)
> +{
> +	struct iommu_group *group =
> +		container_of(work, struct iommu_group, broken_work);
> +	struct pci_dev *pdev = NULL;
> +	struct device *dev;
> +
> +	scoped_guard(mutex, &group->mutex) {
> +		/* Do not block the device again if it has been recovered */
> +		if (!READ_ONCE(group->requires_reset))
> +			goto out_put;
> +		if (list_is_singular(&group->devices)) {
> +			/* Note: only support group with a single device */
> +			dev = iommu_group_first_dev(group);
> +			if (dev_is_pci(dev)) {
> +				pdev = to_pci_dev(dev);
> +				pci_dev_get(pdev);
> +			}
> +		}

The current mechanism is designed only for the PCIe devices within
singleton iommu groups. How about moving the above check to
iommu_report_device_broken() and emitting a message if it is called for
unsupported devices?

> +	}
> +
> +	if (pdev) {
> +		/*
> +		 * Quarantine the device completely. This will be cleared upon
> +		 * a pci_dev_reset_iommu_done() call indicating the recovery.
> +		 */
> +		pci_dev_lock(pdev);
> +		pci_dev_reset_iommu_prepare(pdev);
> +		pci_dev_unlock(pdev);
> +		pci_dev_put(pdev);
> +	}
> +out_put:
> +	iommu_group_put(group);
> +}
> +
> +void iommu_report_device_broken(struct device *dev)
> +{
> +	struct iommu_group *group = iommu_group_get(dev);
> +
> +	if (!group)
> +		return;
> +
> +	if (READ_ONCE(group->requires_reset)) {
> +		iommu_group_put(group);
> +		return;
> +	}
> +	WRITE_ONCE(group->requires_reset, true);
> +
> +	/* Put the group now or later in iommu_group_broken_worker() */
> +	if (!schedule_work(&group->broken_work))
> +		iommu_group_put(group);
> +}
> +EXPORT_SYMBOL_GPL(iommu_report_device_broken);
> +
>   #if IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
>   /**
>    * iommu_dma_prepare_msi() - Map the MSI page in the IOMMU domain

Thanks,
baolu
