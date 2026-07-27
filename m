Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0413909AB;
	Mon, 27 Jul 2026 03:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785121760; cv=none; b=SRVu/qGymjtnSVFHnirGQMO2GAavtITZjiOTMb+8urcsP6vZ05ndj1rFIKA0fmCdzpDiXQ+KBMxBg9t1zPej8Fqxd/5LucsEjF6S6y3EYDGVsLHWx+I1vaG4zZjnmx7iuBN4DnjFy427BDKujvwy7qkQoD4Ar3VTYQt/9i6ic0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785121760; c=relaxed/simple;
	bh=b6peQMSiurmoiNLndl06Vz73KKA/6HQd6iVauTfi7pA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SwBWgjmv2jJX49qtfVbLEU9iW1QK7nV4GGqieEqIM1OzrcuLPJRpOpnh6iStajJhnWPHOnayou6JmwqYKmzccNrBfIKTdpdHpoFO8G86rLKlNnV1YcxIcttMdRvmwBtPqBzeZLjuxz6LCsEXO9LTzRlZXtwGdurhPoUt3qc6dS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lDCm1qih; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lDCm1qih"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785121760; x=1816657760;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=b6peQMSiurmoiNLndl06Vz73KKA/6HQd6iVauTfi7pA=;
  b=lDCm1qihsjqhHjiOpfV08ZNMoV8SlgtuL9HmYM4PVoRq1wLXuneBVMPL
   rS4tpEVHQtYZfZio9VJil3ZAzEpCzYR8BcS6pu559AH3IrHt0EZonk3Mn
   C7DxQZdWTZ2olc3+qVu3h7O9sszb1bxOQkK/MCBj94k6nRInShIFZSOuj
   JlNLh3EBzKrpNnwcXaCTNz7BzQWPYqJ0zJfkuQlIXCGGDI8pqXXlEO10W
   unsFS55+Jd75IP/DUQhnv7Feeqgbcd0OeKWGWGXrkri8F8M86Z8UwsmfV
   YQV4TzsdMDUpGyqqsTSgUAC/iB8zGEJmwGr6XIx16cdG2mFdRBC2Afqgo
   Q==;
X-CSE-ConnectionGUID: 3tpnwPRzQpyq7hGLAoBtlQ==
X-CSE-MsgGUID: demeO3yrQSuAys4FXs/FYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11857"; a="108480192"
X-IronPort-AV: E=Sophos;i="6.25,187,1779174000"; 
   d="scan'208";a="108480192"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 20:09:19 -0700
X-CSE-ConnectionGUID: PgLAahf2TzSFkcNuGwmpmA==
X-CSE-MsgGUID: OdMfD7XwTlKgVyFD/apLmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,187,1779174000"; 
   d="scan'208";a="282624002"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2026 20:09:15 -0700
Message-ID: <11f3f3e3-4fc0-4760-a7e2-d2e6acee6499@linux.intel.com>
Date: Mon, 27 Jul 2026 11:07:25 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/31] iommu/vt-d: Cache max domain ID to avoid
 redundant calculation
To: Xu Yilun <yilun.xu@linux.intel.com>, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org, dan.j.williams@intel.com, x86@kernel.org
Cc: chao.gao@intel.com, dave.jiang@intel.com, yilun.xu@intel.com,
 zhenzhong.duan@intel.com, kvm@vger.kernel.org, rick.p.edgecombe@intel.com,
 dave.hansen@linux.intel.com, kas@kernel.org, xiaoyao.li@intel.com,
 vishal.l.verma@intel.com, linux-kernel@vger.kernel.org
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-19-yilun.xu@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260327160132.2946114-19-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/28/26 00:01, Xu Yilun wrote:
> From: Lu Baolu<baolu.lu@linux.intel.com>
> 
> The cap_ndoms() helper calculates the maximum available domain ID from
> the value of capability register, which can be inefficient if called
> repeatedly. Cache the maximum supported domain ID in max_domain_id field
> during initialization to avoid redundant calls to cap_ndoms() throughout
> the IOMMU driver.
> 
> No functionality change.
> 
> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> Signed-off-by: Xu Yilun<yilun.xu@linux.intel.com>
> ---
>   drivers/iommu/intel/iommu.h |  1 +
>   drivers/iommu/intel/dmar.c  |  1 +
>   drivers/iommu/intel/iommu.c | 10 +++++-----
>   3 files changed, 7 insertions(+), 5 deletions(-)

This patch has been queued for iommu/next. Thanks!
