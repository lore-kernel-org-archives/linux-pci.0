Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F7E2DEA9B;
	Wed, 22 Apr 2026 06:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776838992; cv=none; b=QcaX26Vib/qWwkvVzWlvwFgcEbRvJA6CEz7mmX/KYDNYp9j06d89XN/UdOrDOYI4FDlgsgirPqhYohmutcsKWnozlRqlXZcMEyGyA5LXc3MZO11HJvyJ3wUw66f1mhZoGqhKAQpaFgW4mXdsT9dv6ZMgQKXK2462ZenEkDJ+lhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776838992; c=relaxed/simple;
	bh=lVqWwEzBD5uWHoWpJG0AYHVuBpkn80HziIfAaRo+x3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cY1uzjAhO51n8RrGT+/keb7ggKZLbD4H1U7B1gXXWdr55f0mN+KhA1+ZAaUvaZo3inVrlX0PWJBitLbjYnyTJ8xHHFxy73np45FB0rUxr+2DQsZa09W05IeMZOe5r69PZ6Yz9nobHq/TExVVqRqsWh3x17oFGVibskDgOcIbzAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N9IJLGMj; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N9IJLGMj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776838991; x=1808374991;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lVqWwEzBD5uWHoWpJG0AYHVuBpkn80HziIfAaRo+x3M=;
  b=N9IJLGMjh9vwC7BcyycxkjMrUNH3XR2SXpKceKmozmuJiHTvufXCad1Z
   qiRVrlFN5rKMHtgb5A8gstk1VXUPqpqYCvtKuvUQS0Oiv2TmhNCcvOA4b
   O7SAp/ZFmbQv2yvLLZNJ9vbdHNBiQtMV3feqSKXiQOopuza8zxpg9X51K
   mpD5knq3UCeo1mPVaAwO8K+lv7vkARTqRwPJZIju7dstdM9yHPcQHcyhp
   O9r9jaMvS1Z0LDdYRD3jnu1s0jnc94R7fJXJPITf18Hl8D7gcAKw0ggKX
   xQyiqvwv5qY2iRgdSF+1w5pTjtvx/ZEISXTZfoIG3Zoqq8wvgHy0Cjli4
   Q==;
X-CSE-ConnectionGUID: rXp3DfphQImi3gcaNFyDuQ==
X-CSE-MsgGUID: jTE/PyVLSIm5DJFRth92Tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="88860355"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="88860355"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 23:23:11 -0700
X-CSE-ConnectionGUID: Idh6YeTtSxO0s4azohgAFA==
X-CSE-MsgGUID: C0/3bwQBRsClVvZZ/9DyhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="236627526"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa004.jf.intel.com with ESMTP; 21 Apr 2026 23:23:07 -0700
Date: Wed, 22 Apr 2026 14:00:54 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Williams, Dan J" <dan.j.williams@intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "Gao, Chao" <chao.gao@intel.com>,
	"Jiang, Dave" <dave.jiang@intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"Xu, Yilun" <yilun.xu@intel.com>,
	"Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"kas@kernel.org" <kas@kernel.org>,
	"Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"Verma, Vishal L" <vishal.l.verma@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 19/31] iommu/vt-d: Reserve the MSB domain ID bit for
 the TDX module
Message-ID: <aehkFicutMwa2LP+@yilunxu-OptiPlex-7050>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-20-yilun.xu@linux.intel.com>
 <BN9PR11MB52767F28E9FF692ACE69F3D78C582@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52767F28E9FF692ACE69F3D78C582@BN9PR11MB5276.namprd11.prod.outlook.com>

> Here we need more words to explain the strategy here.
> 
> The comment says "When IOMMU is *enabled*...", but the code here
> just checks the static capability. It's probably a design choice that you
> don't want to add complexity on recycling DIDs when TDX connect
> is actually enabled, but it's worth a note here.

Yes, that's the rationale. I'll add it to comments.

> 
> btw in patch23 commit msg:
> 
> "
> There is no dedicated way to enumerate which IOMMU devices support
> trusted operations. The host has to call TDH.IOMMU.SETUP on all IOMMU
> devices and tell their trusted capability by the return value.
> "
> 
> which implies that ecap_tdxc() alone doesn't really report the capability?

Ah, good catch. Let me explain:

ecap_tdxc does report the capability. This bit is special cause both
trusted part & untrusted part access it.

For IOMMU driver (which now handles the untrusted part), it can directly
query to this bit and decide what to do.

But for tdx-host driver which handles the trusted part, it shouldn't
speculate into the IOMMU for capability enumeration. TDX Module has more
concerns about trusted capability, including the related I/O stack
capabilities e.g. SPDM/IDE cap...  So in patch23 I actually mean we
don't have an enumeration SEAMCALL for trusted capability, I will
refactor that message:

    There is no dedicated *SEAMCALL* to enumerate which IOMMU devices support
    trusted operations...

> 
> anyway all of those need a better explanation here...
