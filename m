Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5875E364021;
	Wed, 18 Mar 2026 06:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773813667; cv=none; b=T2d+Q29JGASvEXGaQpYDb3kKS1QSWLFvWemdpkpQ2BtYU1MTzCyNzCUNJC8o73A96Xarj09GaHtnRH/clUcUaWm//Wd1h5D1HI83kkeT3ozJ0bA3BzyiQp3lPL5eSYfNqKY9MzdzsHW7iaiYG0NmCLP3uwKpqZdTZ5HwYbaw+FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773813667; c=relaxed/simple;
	bh=QWi6oahhozHMScCb8k498+pC0gcouQ2/wL4RVwYu/w0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dgalSLQ1OtwCPWkQ4L7VPiAf047qZRTlKxoG2hhFQvrI3XiT+1f0ijNtrQ8qDDh04uEhC80b19gpYpaWRx53wOdNXY6OxU31l6q70XzQ+Kj3GxM7POF6Zb9p6ZJ+uJEFfBUrHKsQ/V5Cxv5khk+G2k3ssCcyTlDuwOuo1PFbi5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LzdGXQcg; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LzdGXQcg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773813665; x=1805349665;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QWi6oahhozHMScCb8k498+pC0gcouQ2/wL4RVwYu/w0=;
  b=LzdGXQcgs/T0sbNX5j+31Mr21c/FUeH6VTNebQbgtS84ZubK/tyvr+PU
   FIlUv3pkbT4FEcY5o/4n8VE9gOple6zpFVWVF/8P/fHCMNTE70xAhkJoH
   hNWhPLV+RE8ROu4aMsaxJMvjRmx0Y5+INYfxR5oIwpa9dMGDINVo8wQWO
   UaKhdbKuLjXA8d1TdYoj4rUxfrIv/2J+eE+SrT67XINf6aqrwR+1JF02c
   clKDunwRCpg68+NRUaUBD5LbpX3WMSsH2rVk5+G9PR2hU/8oxcg1TsMep
   27IuW9Qar2w1T91j91dvTM7IWub5rFAUqwF7zkItByeQkgMnMHdl/1yOW
   g==;
X-CSE-ConnectionGUID: A+6LwK2MQh6RjrasLkxixg==
X-CSE-MsgGUID: PkGUSZJrRcOlU3TKgx4cDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="86333453"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="86333453"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 23:01:04 -0700
X-CSE-ConnectionGUID: fufkNcBiT+CBntmgJzz94w==
X-CSE-MsgGUID: fcvgoaXHTAWlNQB0gyTvMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="222480812"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 23:01:00 -0700
Message-ID: <566549c9-fab1-43b5-a35b-e3c76f1c285d@linux.intel.com>
Date: Wed, 18 Mar 2026 13:59:58 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] iommu: Add reset_device_done callback for hardware
 fault recovery
To: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
 robin.murphy@arm.com, joro@8bytes.org, bhelgaas@google.com, jgg@nvidia.com
Cc: rafael@kernel.org, lenb@kernel.org, praan@google.com,
 xueshuai@linux.alibaba.com, kevin.tian@intel.com,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-pci@vger.kernel.org, vsethi@nvidia.com
References: <cover.1773774441.git.nicolinc@nvidia.com>
 <3750a106b4ab4235df842fa2b9defbc8226ebbef.1773774441.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <3750a106b4ab4235df842fa2b9defbc8226ebbef.1773774441.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/18/26 03:15, Nicolin Chen wrote:
> When an IOMMU hardware detects an error due to a faulty device (e.g. an ATS
> invalidation timeout), IOMMU drivers may quarantine the device by disabling
> specific hardware features or dropping translation capabilities.
> 
> To recover from these states, the IOMMU driver needs a reliable signal that
> the underlying physical hardware has been cleanly reset (e.g., via PCIe AER
> or a sysfs Function Level Reset) so as to lift the quarantine.
> 
> Introduce a reset_device_done callback in struct iommu_ops. Trigger it from
> the existing pci_dev_reset_iommu_done() path to notify the underlying IOMMU
> driver that the device's internal state has been sanitized.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   include/linux/iommu.h |  2 ++
>   drivers/iommu/iommu.c | 12 ++++++++++++
>   2 files changed, 14 insertions(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 54b8b48c762e8..9ba12b2164724 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -626,6 +626,7 @@ __iommu_copy_struct_to_user(const struct iommu_user_data *dst_data,
>    * @release_device: Remove device from iommu driver handling
>    * @probe_finalize: Do final setup work after the device is added to an IOMMU
>    *                  group and attached to the groups domain
> + * @reset_device_done: Notify the driver about the completion of a device reset
>    * @device_group: find iommu group for a particular device
>    * @get_resv_regions: Request list of reserved regions for a device
>    * @of_xlate: add OF master IDs to iommu grouping
> @@ -683,6 +684,7 @@ struct iommu_ops {
>   	struct iommu_device *(*probe_device)(struct device *dev);
>   	void (*release_device)(struct device *dev);
>   	void (*probe_finalize)(struct device *dev);
> +	void (*reset_device_done)(struct device *dev);
>   	struct iommu_group *(*device_group)(struct device *dev);
>   
>   	/* Request/Free a list of reserved regions for a device */
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 40a15c9360bd1..fcd2902d9e8db 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -4013,11 +4013,13 @@ EXPORT_SYMBOL_GPL(pci_dev_reset_iommu_prepare);
>   void pci_dev_reset_iommu_done(struct pci_dev *pdev)
>   {
>   	struct iommu_group *group = pdev->dev.iommu_group;
> +	const struct iommu_ops *ops;
>   	unsigned long pasid;
>   	void *entry;
>   
>   	if (!pci_ats_supported(pdev) || !dev_has_iommu(&pdev->dev))
>   		return;
> +	ops = dev_iommu_ops(&pdev->dev);
>   
>   	guard(mutex)(&group->mutex);
>   
> @@ -4029,6 +4031,16 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev)
>   	if (WARN_ON(!group->blocking_domain))
>   		return;
>   
> +	/*
> +	 * A PCI device might have been in an error state, so the IOMMU driver
> +	 * had to quarantine the device by disabling specific hardware feature
> +	 * or dropping translation capability. Here notify the IOMMU driver as
> +	 * a reliable signal that the faulty PCI device has been cleanly reset
> +	 * so now it can lift its quarantine and restore full functionality.
> +	 */
> +	if (ops && ops->reset_device_done)
> +		ops->reset_device_done(&pdev->dev);

Nit: dev_iommu_ops() ensures a valid iommu "ops". There is no need to
check "ops != NULL" here. Just

	if (ops->reset_device_done)
		ops->reset_device_done(&pdev->dev);

> +
>   	/* Re-attach RID domain back to group->domain */
>   	if (group->domain != group->blocking_domain) {
>   		WARN_ON(__iommu_attach_device(group->domain, &pdev->dev,

Thanks,
baolu
