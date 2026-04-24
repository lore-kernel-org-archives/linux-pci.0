Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BC82773F7;
	Fri, 24 Apr 2026 02:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776998590; cv=none; b=KS3kGyRsI8X5LuIWCGPYJuImTqdmQkkjaep6yMQjKRGm1IeGm6d7zOkhCFb2wm/hGBjagmZVAWhR/Zta54RfQKpD10pUpIgmPVMT+geezIS0ix9eeRJazv+44hmCyA1+9jKFIV0KoWMuXxMOVwsWm4bBzoUzQmWSQr14QOG/wdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776998590; c=relaxed/simple;
	bh=j2wYXEfdv0dE8/XEklFeV4fc3oP0ONQSD1BC2wLT97g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DrFBMrhwsoGNzF3n+iUoipUsLxrbex07L/wdbLjcBqDKbuMj7LLJsUnHcBDMY9wvNPVnu0XOw9Ij93NBPpSovXT/O/y992jqgf8q3gScZXyhiaKtLQq7CywK96NZ1m10ahd/pwzdFuqYPa/bBMRSPBN2Avp1mel0iVs7Xdfizgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J3gZV6pr; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J3gZV6pr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776998589; x=1808534589;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=j2wYXEfdv0dE8/XEklFeV4fc3oP0ONQSD1BC2wLT97g=;
  b=J3gZV6prM5uIQQshpkeXWqMqY4TTVukJFTt0snWtZ+hUV6ApGouTslb0
   8nH6xt93sse75m+2mmuQr7cK+EMg8OeDB9yIC2CJnXvOWCVchgHXLl48G
   JLTiJilB6agjxHyxiuKXjA2FjSOi1JttWPouX5l+td46j7uOkb2BFuojs
   3035i9qXALPVe4CiXnMsFnCF6KZBYUaE75vvW38o9/qAceuHyERhSjhE5
   iktq52q1O3hQtvhzLSGqO/egyaN0QBNKt3lTfARuhnd97S9Qx531Sk5hg
   G/fVXigne16pRi4dY++niF94+KhBcKHWHXU1YLbTNMD0heThjaT4iAa4j
   A==;
X-CSE-ConnectionGUID: h2ZmTsl6Sze0vyF975PNvQ==
X-CSE-MsgGUID: xK6h1OQoSoGCxnCAvmMMsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="77008201"
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; 
   d="scan'208";a="77008201"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 19:43:08 -0700
X-CSE-ConnectionGUID: MrEiUpgATxusCdSVkTkrKA==
X-CSE-MsgGUID: bntkoq9+RZqPQ6h+r3WxdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; 
   d="scan'208";a="226289922"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 19:43:04 -0700
Message-ID: <55144f96-35f6-40b5-a29d-b2dd80b37ec7@linux.intel.com>
Date: Fri, 24 Apr 2026 10:40:59 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/11] iommu: Add __iommu_group_block_device helper
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
 <5bf2e259f80696c498cb15f40452862e4b43a295.1776381841.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <5bf2e259f80696c498cb15f40452862e4b43a295.1776381841.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/17/26 07:28, Nicolin Chen wrote:
> Move the RID/PASID blocking routine into a separate helper, which will be
> reused by a new function to quarantine the device but does not bother the
> gdev->reset_depth counter.
> 
> No functional changes.
> 
> Suggested-by: Kevin Tian<kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
> ---
>   drivers/iommu/iommu.c | 99 ++++++++++++++++++++++++-------------------
>   1 file changed, 56 insertions(+), 43 deletions(-)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
