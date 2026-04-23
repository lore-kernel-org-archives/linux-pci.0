Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B7833D6C7;
	Thu, 23 Apr 2026 07:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776931036; cv=none; b=Br9xeVJO+ydVP+7F/TRKy6FyRr4fSObl+22gjzUYyBPJiqF7OugtJd3RNizw+dsHJoXMXRFNHGqlpCuaXHszePjHEurjkTX8mM029RaYgTLCPJXALCk2njAVrcN6xo3cWKawYBHCvXuqGWHtH+ZEZFPODFjWWHWGo93gaZZyn/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776931036; c=relaxed/simple;
	bh=CHTAO9l3j2AN2pRGlpx8AfN1p1NSocg7+Jj7C8dbzU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=emgm7OUtaDmCS/l3PwmBtd7ygi5Tev+fDA3GxvGVlsWIqh7EAmC957FQ+iLD+9fxWDVGdcf3L4Auc6Gt745tLn4H1Ylj0TYYkaQlXnvg46hCKfDuq3QjVFty6nY3oonRlqQmZUJwz0SVSK7ayDkLckZ24DbBxYeDWwpn6q2r04I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KNFyRdVp; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KNFyRdVp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776931035; x=1808467035;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CHTAO9l3j2AN2pRGlpx8AfN1p1NSocg7+Jj7C8dbzU0=;
  b=KNFyRdVpV5hq3g9CLzq8kyg0ggAF6oAT5zpaHHO/JbY/qlRfbbaq2Hvx
   U40O9+Th3+a30BOfjeJxJS3gWBemUNPjISEasxLTETOAADgl7r9uByraf
   kcRrhZVEo+ZhVh/PP96bu7vzHmeyJk3MT/1/oF//jeNwSpvksFe8+kVSy
   kZymerj/nha+j+bP8alDxN1muHVTGiLABl4G/gryurPuw2Rkw2Odiiuth
   ErfVGqIBAprxBfHOu71s7SisboNfpk0weJsx8GnPvtsBWhgmR0AFPaui2
   ooS2GYrPDS4tqEbEmQWmRuJa9X3MH3T5a2itjhRoE+2VqUCI/UQxe/zeG
   g==;
X-CSE-ConnectionGUID: kGWy7ef8QM2otx76RCAaag==
X-CSE-MsgGUID: s7gTKxtKTQ2ttLQ6rMr4XQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="88975263"
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="88975263"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 00:57:13 -0700
X-CSE-ConnectionGUID: iwunEYo2TdexK5dTlOoruQ==
X-CSE-MsgGUID: ojBjABX+T/Olmr4XoENCbA==
X-ExtLoop1: 1
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 00:57:07 -0700
Message-ID: <3570e178-f887-45c9-a251-e089915cfbd9@linux.intel.com>
Date: Thu, 23 Apr 2026 15:55:02 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/11] iommu: Defer __iommu_group_free_device() to be
 outside group->mutex
To: Nicolin Chen <nicolinc@nvidia.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Pranjal Shrivastava <praan@google.com>, Mostafa Saleh <smostafa@google.com>,
 Kevin Tian <kevin.tian@intel.com>, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, vsethi@nvidia.com,
 Shuai Xue <xueshuai@linux.alibaba.com>
References: <cover.1776381841.git.nicolinc@nvidia.com>
 <3f5d229267d1f4d918641bc5b896f54b5c4b7782.1776381841.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <3f5d229267d1f4d918641bc5b896f54b5c4b7782.1776381841.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/17/26 07:28, Nicolin Chen wrote:
> __iommu_group_remove_device() holds group->mutex across the entire call to
> __iommu_group_free_device() that performs sysfs removals, tracing, and the
> final kfree_rcu(). But in fact, most of these operations don't really need
> the group->mutex.
> 
> The group_device structure will support a work_struct to quarantine broken
> devices asynchronously. The work function must hold group->mutex to safely
> update group state. cancel_work_sync() must be called, to cancel that work
> before freeing the device. But doing so under group->mutex would deadlock
> if the worker is already running and waiting to acquire the same lock.
> 
> Separate the assertion from __iommu_group_free_device() to another helper
> __iommu_group_empty_assert_owner_cnt().
> 
> Defer the __iommu_group_free_device() until the mutex is released.
> 
> This is a preparatory refactor with no functional change.
> 
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
> ---
>   drivers/iommu/iommu.c | 35 +++++++++++++++++++++++------------
>   1 file changed, 23 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index d1be62a07904a..810e7b94a1ae2 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -627,6 +627,19 @@ static struct iommu_domain *pasid_array_entry_to_domain(void *entry)
>   
>   DEFINE_MUTEX(iommu_probe_device_lock);
>   
> +static void __iommu_group_empty_assert_owner_cnt(struct iommu_group *group)
> +{
> +	lockdep_assert_held(&group->mutex);
> +	/*
> +	 * If the group has become empty then ownership must have been
> +	 * released, and the current domain must be set back to NULL or
> +	 * the default domain.
> +	 */

Nit: this comment doesn't quite match the following code. The code
doesn't check "group->domain != NULL". Or perhaps in that case,
group->default_domain must be NULL?

Furthermore, if a device is currently quarantined, group->domain will be
the blocking_domain. If that quarantined device is then hot-removed and
happens to be the last device in the group, will this WARN_ON trigger
unnecessarily?

> +	if (list_empty(&group->devices))
> +		WARN_ON(group->owner_cnt ||
> +			group->domain != group->default_domain);
> +}
> +
>   static int __iommu_probe_device(struct device *dev, struct list_head *group_list)
>   {
>   	struct iommu_group *group;

Thanks,
baolu
