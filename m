Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB4535B64E;
	Wed,  8 Apr 2026 06:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775630292; cv=none; b=hWYSiTr44jAY3T9DA6jTflcMjM0probirlmHtxksv4NkEL8vlCvkbZRTKLhYsjNVJrDBifuupgSHCq60RJSygW8jhzfWwm66nOPrypZJxR+lhQbUUIEJCBldRSFm1vK/M0Mk5ahXp9j4UtdiDcEbj83VCK3yFHVnQmbn9JV3t3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775630292; c=relaxed/simple;
	bh=r7Zou7qBpk7/ogc3+xg37FtskbYfl/ga0t5KuLEhvgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERqSe4MfBCgdycBPJWX5vqQrFHfaW7Zj7QVZnKGyi+JOnbzyjPYD6Y/NnorLOLRLVAF1KURBym2PmhjCJR47qg7YFCQEHMXr8lew6EoG1HCG6/BZ8m58PM0aIUbdHVhuECv2b8oRPG1NU/WJsjzyiGbdvlOfxz5Uf93C5opeFs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GpWzWrFl; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GpWzWrFl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775630292; x=1807166292;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r7Zou7qBpk7/ogc3+xg37FtskbYfl/ga0t5KuLEhvgM=;
  b=GpWzWrFlSE0koHPz2mRJEwRTsFjo+pOABAtchHK6x9jfl8Q+N/ylELo8
   nqVe8XgDopDtCrMxyHM6eZBGiFvsMVRZTENaprOoBE0qhVW1prHiFNekH
   0EcMcmJsfIlFCxVrYuqT3J7jlzgiEpHiOt4RXYaLumuHI0aRr4ZsnIfGn
   Y8Arinpa3YnRfWKn5PBCRQ1gECO7EitmFSkdfrkaXFMsR0HA+wnuAk7Zn
   3RNqpIqQU/jyex5BEGgZ9/ETPBG0ItACNlwSrmjOGEyCDAffpQ0YORQVX
   Ue3Tn94hw3NZ6UYkd49xd8ZpHLqHWqFh07H8l6zjWX66xID2s/Lns8Lk7
   A==;
X-CSE-ConnectionGUID: Ot1Ku8ZpTFqExzd5f1NTHA==
X-CSE-MsgGUID: bozWrQYySHKWzWSxzDHfhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="94188558"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="94188558"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 23:38:11 -0700
X-CSE-ConnectionGUID: aBA/9jzKS/++5ZnqqSF2cQ==
X-CSE-MsgGUID: eXarkgTMS92K4tFqc3IkYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="228323197"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa008.jf.intel.com with ESMTP; 07 Apr 2026 23:38:07 -0700
Date: Wed, 8 Apr 2026 14:16:35 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Huang, Kai" <kai.huang@intel.com>
Cc: "Williams, Dan J" <dan.j.williams@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"x86@kernel.org" <x86@kernel.org>, "Gao, Chao" <chao.gao@intel.com>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"Xu, Yilun" <yilun.xu@intel.com>,
	"Jiang, Dave" <dave.jiang@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"kas@kernel.org" <kas@kernel.org>,
	"Verma, Vishal L" <vishal.l.verma@intel.com>,
	"Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 05/31] x86/virt/tdx: Extend tdx_page_array to support
 IOMMU_MT
Message-ID: <adXywwSAThfE5lgK@yilunxu-OptiPlex-7050>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-6-yilun.xu@linux.intel.com>
 <e290bd999c5cec93bf0b611f5506ba1e8a23c81e.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e290bd999c5cec93bf0b611f5506ba1e8a23c81e.camel@intel.com>

On Thu, Apr 02, 2026 at 12:05:43AM +0000, Huang, Kai wrote:
> On Sat, 2026-03-28 at 00:01 +0800, Xu Yilun wrote:
> > IOMMU_MT is another TDX Module defined structure similar to HPA_ARRAY_T
> > and HPA_LIST_INFO. The difference is it requires multi-order contiguous
> > pages for some entries. It adds an additional NUM_PAGES field for every
> > multi-order page entry.
> > 
> > Add a dedicated allocation helper for IOMMU_MT. Fortunately put_page()
> > works well for both single pages and multi-order folios, simplifying the
> > cleanup logic for all allocation methods.
> 
> Well I guess you can have a 'free_fn' to free the pages you allocated via
> 'alloc_fn'?  Will this simplify the code and at least keep tdx_page_array
> implementation cleaner?

mm.. I think code would be simplified with less callbacks.

But anyway, the need for the alloc_fn becomes a sign for me to think
about separating the memory allocation and struct tdx_page_array
construction. Especially that the IOMMU_MT needs specialized memory
layout so better managed by the kernel driver who really uses IOMMU_MT.

> 
> It's strange that you only have a 'alloc_fn' but doesn't have a 'free_fn'
> anyway.
