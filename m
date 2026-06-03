Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02DB2556E;
	Wed,  3 Jun 2026 00:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780445476; cv=none; b=LO4dWdMez/wOZkXqszV0RJlUwLHAOA2y1IIoh6UoJD9fvD3pveoh5d93eAiZky+ZXiujGVefJfVeUlC7CMqm5kSfnMWp4ilsAgj4h9I06I6m/cjVuoK6rb4jw77MZglENdw2NdECHcZyUPi6dtL/loDcMHtWQJqj3XnzxQ3rTMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780445476; c=relaxed/simple;
	bh=3miLjCrBc1xIc3dtkAU18SFsgdmreVXrhMsqcFVtiwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n/dfnSq9YPrL+1Eb1uEsFYdqqsA0D2E4DO6F2EE3aZ9U04G/8dCZYAWyZE31am5rX0Fxi3uBOoqnlFvl1Et8G/zY6zCGh7ioGH6aaeSWEy/OfAnT8OhiZxePFCRyPfWBBj9FQZkfjRW11Fh1VpRNj+35AgSDPWhaJNRxHQHVSb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lOzGusJV; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lOzGusJV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780445474; x=1811981474;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3miLjCrBc1xIc3dtkAU18SFsgdmreVXrhMsqcFVtiwA=;
  b=lOzGusJVPONsP5br/8sKV4CwNCDX7tJE52HWRXpPAN2vRtNYGWSrJ2wW
   Dlq4svEigbsKF9pA0Hi9A9nvmWvsu+2rqZjSk7qGUcuU8HOhE1O6Kb1fc
   TT1SNWVJFTjflB0khojKgfvzoxwbGzN619OKOse2oWOVSk/yssjeYPNEH
   rgIQiuYzTOEBqmawN1agMhKfuCPmS5gJQFTHEiGuXtxjY2dbvPbsOXfF/
   zpdji2OEdJ/TP+6puTVqU20Bst5HrVSyPSVygv3HJgtX2j+JzJbs2Tub6
   EI7MZvUMiXHfDi0irW7Y/SzjXJNUfvwB1sNVBcFGv2R4cDO6uqi99Pk0I
   g==;
X-CSE-ConnectionGUID: fyyXzCfhTxuCOQopDurpqA==
X-CSE-MsgGUID: zKoj1WnCRdCntErVSbkXqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81274414"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="81274414"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 17:11:13 -0700
X-CSE-ConnectionGUID: GtutgX/6TIuJ5yXSWZwa4g==
X-CSE-MsgGUID: Y6a+WXQSQwGf+qTjqv/tyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="244143562"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.108.56]) ([10.125.108.56])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 17:11:13 -0700
Message-ID: <396e18d5-6fa7-4abc-9c8b-ab5e8b260345@intel.com>
Date: Tue, 2 Jun 2026 17:11:11 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 9/9] Documentation/ABI: Document CXL memdev cxl_reset
To: Srirangan Madhavan <smadhavan@nvidia.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: vsethi@nvidia.com, alwilliamson@nvidia.com,
 Dan Williams <danwilliams@nvidia.com>,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20260528083154.137979-1-smadhavan@nvidia.com>
 <20260528083154.137979-10-smadhavan@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260528083154.137979-10-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/28/26 1:31 AM, Srirangan Madhavan wrote:
> Document the write-only cxl_reset attribute under CXL memdev devices.
> The attribute is visible only when the memdev's PCI parent advertises
> CXL Reset capability, and writing a true boolean value requests the CXL
> reset flow.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl | 28 +++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 16a9b3d2e2c0..d5d055e7a756 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -110,6 +110,34 @@ Description:
>  		affinity for this device.
>  
>  
> +What:		/sys/bus/cxl/devices/memX/cxl_reset
> +Date:		May, 2026
> +KernelVersion:	v7.1
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(WO) Write a boolean true value, for example "1" or "true", to
> +		request CXL Reset for this memory device. The driver performs
> +		CXL-specific reset coordination for the target memdev before
> +		issuing reset, including any required preparation for affected
> +		CXL memory regions and related CXL memory devices.
> +
> +		CXL Reset control is Function 0 scoped. A write to this
> +		attribute resets the CXL.cache and CXL.mem state for all
> +		CXL.cache or CXL.mem functions in the same CXL device reset
> +		scope, not only the memX device associated with this file.
> +
> +		The optional CXL Reset Memory Clear operation is not exposed by
> +		this attribute.
> +
> +		A reset fails with -EBUSY if any affected CXL region is
> +		online as System RAM or has an active region driver bound.
> +		Userspace must first quiesce and release affected CXL memory
> +		mappings.
> +
> +		If this file is not present, then CXL Reset is not supported
> +		for the device.

Need to mention this is only shows up for type2 devices. Also missing information about decoder and dvsec range restore.


> +
> +
>  What:		/sys/bus/cxl/devices/memX/security/state
>  Date:		June, 2023
>  KernelVersion:	v6.5

