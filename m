Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E7A34FF46
	for <linux-pci@vger.kernel.org>; Fri, 13 Mar 2026 10:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773398797; cv=none; b=Wozx79liU08Ja4IHI8PwGovZT9oOASF7eKHdNBEHnv+hdz7ag05nHCZ++QCeTIjyB8ym3iPU0+NrOSb9Bylf4fjaKwces76yrof4dow9oMmdD2Ki6BJzPpdhEPvJ29IuLMwySSoAycsZV8U0PVkzod0zn3bdsho9NGlX3zCBt80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773398797; c=relaxed/simple;
	bh=PTmY2nKD6hoY/LGYYNm8rJAUyVDhur4/C7CTrQQPHqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gnVgufWSlyuT9ugAS5jGb/4TK+1rMVuG5lF+rBcilos9e/ct8x3nb0vm5iNLtSYDL0KiDi3KNfjNC92+xdscnbLAzGFnLSQlzeOB0y/KPAVl6MtMd1nH52YAFTDp2txyPpx2OBxDCeG7Ac2ySpfHpIgNwTefqX9wnhwL1yWm0Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fZge6TEc; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fZge6TEc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773398795; x=1804934795;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PTmY2nKD6hoY/LGYYNm8rJAUyVDhur4/C7CTrQQPHqU=;
  b=fZge6TEc2HVgc9YXVZPkJw55GL5EELLWTuq8WgJJlkWFQSDXux/gG3C+
   lyKCWwnudSvddpETPmd0zGoPkBdEkGV4YqSxSqcSqp4ai4ODvBbW5wfpv
   LZJkcS1zMgyzpJ4RADd8NOeJSwGgfxndQGsefo8wNvWva1UG1bchcK/Ge
   nXPiLXSolzOMZalt3pK2w0G6hDG0XzzHKOj0nSZfhulITdn7IJszmWeEk
   gdXBd5GUr+cHhg0wpkiE+oEj8Dl+Z9dPzDx2CQYaLvVEXudP18c0N9ajh
   tE5F0Fs1fgFAVJfqwbgHzkyI6hOCvfkTHk3Zki/1GrZM884Fwnq4iQfL3
   A==;
X-CSE-ConnectionGUID: 0VqM/kCHQ7eiMOqsdzd6tg==
X-CSE-MsgGUID: Am/XF7knSbey+XaBvaKJIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="74692808"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="74692808"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 03:46:35 -0700
X-CSE-ConnectionGUID: Ko8UEkYQR9+8HbK6k84lPA==
X-CSE-MsgGUID: qY5hGhJWRMe74quojS+aTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="221077974"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa009.jf.intel.com with ESMTP; 13 Mar 2026 03:46:31 -0700
Date: Fri, 13 Mar 2026 18:26:14 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org, aik@amd.com,
	bhelgaas@google.com, alistair23@gmail.com, lukas@wunner.de,
	jgg@nvidia.com, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 10/19] x86, swiotlb: Teach swiotlb to skip "accepted"
 devices
Message-ID: <abPmRsJ7cvLJ272k@yilunxu-OptiPlex-7050>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
 <20260303000207.1836586-11-dan.j.williams@intel.com>
 <yq5ah5qx9t77.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5ah5qx9t77.fsf@kernel.org>

> > @@ -365,6 +365,7 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
> >  
> >  	io_tlb_default_mem.force_bounce =
> >  		swiotlb_force_bounce || (flags & SWIOTLB_FORCE);
> > +	io_tlb_default_mem.bounce_unaccepted = flags & SWIOTLB_UNACCEPTED;
> >
> 
> This should be.
> 
> @@ -373,7 +373,7 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
>  
>  	io_tlb_default_mem.force_bounce =
>  		swiotlb_force_bounce || (flags & SWIOTLB_FORCE);
> -	io_tlb_default_mem.bounce_unaccepted = flags & SWIOTLB_UNACCEPTED;
> +	io_tlb_default_mem.bounce_unaccepted = !!(flags & SWIOTLB_UNACCEPTED);

Ah yes, I just realized assigning to a 1-bit field would truncate the
assigned value to its LSB...
