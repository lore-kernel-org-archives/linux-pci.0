Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8D636AB44;
	Fri, 29 May 2026 03:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780024900; cv=none; b=aoaLC9X+4SUpao4mlTmpsDrVKx1I0jZ8JZsEKBNFv2WMTeh61CtIlS4SejsTy3fypYHEpvbu7QDCyaETgDgkkfVE8yCO7o/3NVS+n4cAQgJP6I2MxWb1oVV9kvUOpsV/YOPPohQqY4pW2/I8ShT/E1Yowqx9QIzqGeQGkEluXf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780024900; c=relaxed/simple;
	bh=wDQVFhBo3gBIQZfJEViqlT0vYqsaA6hIzYCcs0Tl2GA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V9xzr/Paubs5pw2K9uceHYVB7BS+Fvsx1p1J1A8lXYvuNHv3fYx7pdAoX61j4VeuDWatRaFQ7KtlIrf3XQEkgzY0JFTIyAzMIXe0DfTvLey/DNzfjMzRR02p7oPWcwAmVW/3CEcxr70pGQl51HN0KnUBQOo9rs0yt10cv5KnVIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EDkhHoSn; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EDkhHoSn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780024898; x=1811560898;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wDQVFhBo3gBIQZfJEViqlT0vYqsaA6hIzYCcs0Tl2GA=;
  b=EDkhHoSnFLSFPNGJTQkNJNQV9F3mb9AX79ICpvTio8xxftJaySPkXdz5
   HhhmLyyy3skp+ge8/LlIB2S2REXYHUoXz7gEYUoyGyB3L3sZ3UL8IHGXe
   KWUma5GW4hu2R8fFH72Az1pE1g+HpJig8wn1GdqAQZNt++nCXVuPsB9z5
   Pyn3ppGhArVvT4laSPOJshBzk6nNldmcFDk4KqrX4ChOJ20PABRbc7cKG
   TYY4oBU4RcgBVt0I+JQNEZHL9cEfZK/WWgVwmIZLaae+LjJqZtWG2N9MZ
   80kJqgZCeVp1xfv4ew2ZWeY2qzbdd3GtOc60je1l6VG2isKrRorwqnjmw
   A==;
X-CSE-ConnectionGUID: YnvrWqIQRBivfq0vldFOLw==
X-CSE-MsgGUID: 8xbYMpyYSo63wESzRzt0Rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="81058264"
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="81058264"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 20:21:37 -0700
X-CSE-ConnectionGUID: H5rT94fQQAuf4q2VWMam+w==
X-CSE-MsgGUID: RCxSXA1aSmSJpaSFQgHLbQ==
X-ExtLoop1: 1
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 20:21:33 -0700
Message-ID: <5c5e85f1-f745-4667-af0d-30af71288294@linux.intel.com>
Date: Fri, 29 May 2026 11:20:47 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/7] iommu/vt-d: Fix RB-tree corruption and
 Use-After-Free in probe
To: Pranjal Shrivastava <praan@google.com>, iommu@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, David Woodhouse <dwmw2@infradead.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>,
 David Matlack <dmatlack@google.com>, Samiullah Khawaja
 <skhawaja@google.com>, Daniel Mentz <danielmentz@google.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Mostafa Saleh <smostafa@google.com>, sashiko-bot@kernel.org
References: <20260528202353.3422206-1-praan@google.com>
 <20260528202353.3422206-6-praan@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260528202353.3422206-6-praan@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/29/26 04:23, Pranjal Shrivastava wrote:
> The intel_iommu_probe_device() function contains two pre-existing
> memory safety issues on its error path:
> 
> 1. The info->node RB-tree member is zero-initialized via kzalloc. If
>     a device does not support ATS, the device_rbtree_insert() call is
>     skipped. If a subsequent probe step fails, the error path jumps to
>     device_rbtree_remove(), which misinterprets the zeroed node as
>     a tree root and corrupts the device RB-tree.
> 
> 2. The info structure is freed on failure, but the pointer remains
>     linked to the device via dev_iommu_priv_set(). This leads to a
>     Use-After-Free regression if the pointer is accessed later.
> 
> Fix these by explicitly initializing the RB-node as empty and guarding
> its removal. Additionally, ensure dev_iommu_priv_set(dev, NULL) is
> called before freeing the info structure in the error path.

Thanks for the fixes. Could you please separate these two fixes into two
distinct patches and post them as a standalone series? These two fixes
are quick cleanups and are not part of the current series, which focuses
on improving the robustness of ATS enablement.

> 
> Reported-by: sashiko-bot@kernel.org
> Closes: https://lore.kernel.org/all/20260525205628.CD4431F000E9@smtp.kernel.org/
> Suggested-by: Baolu Lu <baolu.lu@linux.intel.com>
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
> ---
>   drivers/iommu/intel/iommu.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 4d0e65bc131d..ed6d3a0203f5 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -157,7 +157,10 @@ static void device_rbtree_remove(struct device_domain_info *info)
>   	unsigned long flags;
>   
>   	spin_lock_irqsave(&iommu->device_rbtree_lock, flags);
> -	rb_erase(&info->node, &iommu->device_rbtree);
> +	if (!RB_EMPTY_NODE(&info->node)) {
> +		rb_erase(&info->node, &iommu->device_rbtree);
> +		RB_CLEAR_NODE(&info->node);
> +	}
>   	spin_unlock_irqrestore(&iommu->device_rbtree_lock, flags);
>   }
>   
> @@ -3254,6 +3257,7 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
>   
>   	info->dev = dev;
>   	info->iommu = iommu;
> +	RB_CLEAR_NODE(&info->node);
>   	if (dev_is_pci(dev)) {
>   		if (ecap_dev_iotlb_support(iommu->ecap) &&
>   		    pci_ats_supported(pdev) &&
> @@ -3316,6 +3320,7 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
>   clear_rbtree:
>   	device_rbtree_remove(info);
>   free:
> +	dev_iommu_priv_set(dev, NULL);
>   	kfree(info);
>   
>   	return ERR_PTR(ret);

Thanks,
baolu
