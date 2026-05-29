Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAD73A7843;
	Fri, 29 May 2026 06:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780036818; cv=none; b=jT+dwmGer/grv2ESLhBcIy5CpoNonhdiQdM2IzbgKZjj18SF/DRG+3GQpvMVZRSOHL6JtjCwZ8++jFep1K4Pehd2CTWnvIaPIDCkhpje4mc+CgnkAl3lC5nSk2cLv0F4yCd1I9ULlCo21KwlaFUsBcK/iZHJ8whb77Phfxx7AdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780036818; c=relaxed/simple;
	bh=RuPeE6gjPC40qKPJlamS/Aiu1t3G8drwyUhBpAA62Es=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OEKjbjaqXPDafS2YYiXqS2YCXzYmVTBxPt1kq4WPVNUaTZGgtuwJDXLhk1iTo0QNYIaQ7HVEPlr6P4GpxT6yaYnbqIi7/s3Z+umVNEK3GWaighfL2w+1Wf67xoyRr3bg1F06qHrHQCO/pBBC+qwVMx6N1rTCPq+P8CmtuBHUKS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hvgQv2f0; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hvgQv2f0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780036817; x=1811572817;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RuPeE6gjPC40qKPJlamS/Aiu1t3G8drwyUhBpAA62Es=;
  b=hvgQv2f0twK6GFicWULbgPsQsc2s65XtoY+CgrmO9KfUUAUODEnMQ7+Q
   JTbBvXCtNSuH3OMVz0f+gJDE7PWRNUPUv3/93/KvUNXOxF86x5M94RuyV
   4m2rA8nT0QD9BmSa7mMjSbI4j02b6CCW6BzCdv4tvMifN4dcbXdSk9VTe
   hKBnMPqCOeuqgoUyYI19rnL1oOwmteN9wygepqaAb2fTET3mR8B3b6uZT
   bVGB1JlcwDwgeR0RJ/762RWQkGmILbranrkrNmBAllX53WoobowJmGUuy
   pVG5akHz72VrRYCF/9cZfbYcS8H6abu9h98yZquSmH5Ei24jIAqevExVg
   Q==;
X-CSE-ConnectionGUID: 3nEN0CkZQPyax09bUSgKyQ==
X-CSE-MsgGUID: teh2keZFRZGTDZgBZ5PODw==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="84743560"
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="84743560"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 23:40:17 -0700
X-CSE-ConnectionGUID: f2+Pz2IRQwO0yTKeVeEmcA==
X-CSE-MsgGUID: O7ZOH8EvRFmSYEg28QuzHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="246777942"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 23:40:13 -0700
Message-ID: <3fa3d4c9-c083-4167-93fe-814f0ecfcb7f@linux.intel.com>
Date: Fri, 29 May 2026 14:39:26 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] iommu/vt-d: Fail probe on ATS configuration
 failure
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
 Mostafa Saleh <smostafa@google.com>
References: <20260528202353.3422206-1-praan@google.com>
 <20260528202353.3422206-7-praan@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260528202353.3422206-7-praan@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/29/26 04:23, Pranjal Shrivastava wrote:
> Update the Intel VT-d driver to handle ATS configuration and enablement
> more strictly. Specifically, update the device probe to fail if
> pci_prepare_ats() returns an error. This ensures that any ATS-capable
> master reaching the attach phase is guaranteed to have a valid config.
> 
> Additionally, update iommu_enable_pci_ats() to WARN() if pci_enable_ats
> fails. Since earlier checks in the probe phase preclude config-related
> failures, any failure during hardware enablement is considered a kernel
> bug.
> 
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
> ---
>   drivers/iommu/intel/iommu.c | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index ed6d3a0203f5..f13da16717fe 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -876,8 +876,14 @@ static void iommu_enable_pci_ats(struct device_domain_info *info)
>   	if (!pci_ats_page_aligned(pdev))
>   		return;
>   
> -	if (!pci_enable_ats(pdev, VTD_PAGE_SHIFT))
> -		info->ats_enabled = 1;
> +	/*
> +	 * pci_enable_ats() should not fail here because earlier checks
> +	 * have already verified support and configuration.
> +	 */
> +	if (WARN_ON(pci_enable_ats(pdev, VTD_PAGE_SHIFT)))
> +		return;
> +
> +	info->ats_enabled = 1;
>   }
>   
>   static void iommu_disable_pci_ats(struct device_domain_info *info)
> @@ -3292,7 +3298,10 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
>   
>   	dev_iommu_priv_set(dev, info);
>   	if (pdev && pci_ats_supported(pdev)) {
> -		pci_prepare_ats(pdev, VTD_PAGE_SHIFT);
> +		ret = pci_prepare_ats(pdev, VTD_PAGE_SHIFT);
> +		if (ret)
> +			goto free;
> +
>   		ret = device_rbtree_insert(iommu, info);
>   		if (ret)
>   			goto free;

Sashiko made a valuable review comment, and I believe it applies here as
well:

[Severity: High]
Since ATS is an optional performance optimization, does failing the
IOMMU probe when pci_prepare_ats() fails break backward compatibility?

This completely prevents devices with buggy ATS capabilities (or VF/PF
STU mismatches) from attaching to the IOMMU.

Could this disable DMA translation entirely for hardware that would
otherwise work correctly without ATS?

Thanks,
baolu
