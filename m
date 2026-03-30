Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CD832ED21;
	Mon, 30 Mar 2026 16:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774886930; cv=none; b=FjZuNZ/8+sPTSbQ2GSGlgRBXfVPawRyOaXcko/5Zd8KGWhldzgMmSqckdcNVxbj2vnioHW4tIiaaNfWHOgcliXJANwjxrErinlB4B/1ZClC1bGqyWp75CCLiFD9whXIWQr4+giwIch5i1K+V52FHq5x8ioN+a7uVxuVcHv2bmF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774886930; c=relaxed/simple;
	bh=R1lczy6zP3pbs2WaZJ0Q/JKqtQsI+1tLW7W/sSy9xmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hguIFZgeBdRWDzaAG4mfjWZ9lOUMnJsqa/8ALE2tWE0hRYtJ1c+CN6K/td2eIA52lgvtDDZyEjwLCenPNZpQEr0pk1cHXn97hGkl+eELATUVnjSqfxQdJpmvqfxjGtw0P4Vv4mhAHxKdDnl8pojQc9/08yBHxBC1k5+SCAhkeE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z4zWgR7+; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z4zWgR7+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774886927; x=1806422927;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R1lczy6zP3pbs2WaZJ0Q/JKqtQsI+1tLW7W/sSy9xmI=;
  b=Z4zWgR7+TNUCYSeU6dE1n7MXaFU5FZaN0ArWFVHrIa6jIEZgCiO+WZvi
   BTPpZM5Ku0PWUBpGBLUDNUY928HUwQ3sr/6DNyJmwz8nZrhXdyfnBchIu
   Pg3dc3EuS2M7hgiEQ8CxdbEsdt7xj7ExaD8FiEOastNOduXFz+5oFx/iz
   IHCntBVOvbrgn6axh3UDduFBffKAYkhrX/OaCPfEdMuzLNkpa+2+h0GC6
   i6O7mulSTPQ2gRz0spy64r5AiB4jAObFXmUWmnAZzbP4u0NlvEQRrEJKw
   gsBZTayrCvoMr6SjrgZ3E79dOrHhmZSjbcPqFoSTUHpv+6AKMDttsYoPM
   g==;
X-CSE-ConnectionGUID: d2rQkpf0TlefDyRHgO92jQ==
X-CSE-MsgGUID: Ndt3JgqqSFWa6hwhoNHExA==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="98495434"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="98495434"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 09:08:42 -0700
X-CSE-ConnectionGUID: uTgWgaUaT+uuyszltsYDdg==
X-CSE-MsgGUID: nAif47SPQRKLy2j5kn4Qcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="249147394"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa002.fm.intel.com with ESMTP; 30 Mar 2026 09:08:32 -0700
Date: Mon, 30 Mar 2026 23:47:25 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "Williams, Dan J" <dan.j.williams@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"x86@kernel.org" <x86@kernel.org>, "Gao, Chao" <chao.gao@intel.com>,
	"Xu, Yilun" <yilun.xu@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"kas@kernel.org" <kas@kernel.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"Jiang, Dave" <dave.jiang@intel.com>,
	"Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"Verma, Vishal L" <vishal.l.verma@intel.com>,
	"Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 03/31] x86/virt/tdx: Add tdx_page_array helpers for
 new TDX Module objects
Message-ID: <acqbDVnd6gNJWmBi@yilunxu-OptiPlex-7050>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-4-yilun.xu@linux.intel.com>
 <1dd0b8f4d1ad5cd07b5139ed8c944e1e1d004661.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1dd0b8f4d1ad5cd07b5139ed8c944e1e1d004661.camel@intel.com>

> > Typical usages of the tdx_page_array:
> > 
> > 1. Add control pages:
> >  - struct tdx_page_array *array = tdx_page_array_create(nr_pages);
> >  - seamcall(TDH_XXX_CREATE, array, ...);
> > 
> > 2. Release control pages:
> >  - seamcall(TDX_XXX_DELETE, array, &nr_released, &released_hpa);
> >  - tdx_page_array_ctrl_release(array, nr_released, released_hpa);
> 
> So release is mostly needed because of the need to do the wbvind seamcall? And
> unlike tdx_page_array_free() it returns an error in case that fails. Or other
> sanity checking. But all the callers do the same thing on error, call
> tdx_page_array_ctrl_leak().
> 
> Just wondering if we could simplify it somehow. There are two helpers and the
> caller has to know which one to call based on SEAMCALL specifics. What if the
> seamcall wrapper set a bit in the page array while passing it out. The bit would
> specify to the helper if it needs to do wbinvd or not. Then the wrappers could
> encapsulate the type of free needed and not rely on the caller to know. And we
> only need to have one function for it instead of two.

I like the idea, I can have a try.

But we may need more than a bit to finish the release. On release some
SEAMCALLs return the released HPA list and host checks they are sane,
otherwise leak. We need to also record these info in the struct.

> 
> 
> BTW, do we expect errors from the tdh_phymem_page_wbinvd_hkid() calls here? How

No, it can't happen in normal runtime.

> could the BUSY happen? If we don't think it can happen in normal runtime, we
> could just warn and skip the special leak logic. In KVM side there is a place
> where we can't really handle it for the wbinvd calls. And one where we can. If

But we do leak control pages when wbinvd fails, or even when
tdh_phymem_page_reclaim() fails. So anyway we need leak logic, is it?
Is it a little insane if we failed to reclaim and return the private
page to kernel?

> we need a ton of code to handle a bug somewhere (on kernel side or TDX module),
> it seems too defensive to me. At least it's not in sync with the rest of TDX.
> 
> Especially the quite large tdx_page_array_validate_release() logic should need a
> justification that there is something very tricky that needs all this checking.
> 
> But maybe you can explain what the special risk is.

I don't see the special risk, actually I don't even see the releasing
failed once.

But we do check the return value of tdh_phymem_page_reclaim() for a
single ctrl page releasing. It is just we also check a list of ctrl
pages releasing. The check becomes naturally complex, e.g., if the
released number matches, if every HPA in the list matches ...

...

> > +struct tdx_page_array {
> > +	/* public: */
> > +	unsigned int nr_pages;
> > +	struct page **pages;
> > +
> > +	/* private: */
> > +	unsigned int offset;
> > +	unsigned int nents;
> > +	u64 *root;
> 
> pages is going to be an array of struct pointers, and root is a single page of
> PA's that gets re-used to copy and pass the PA's to the TDX module. Why do we
> need both? Like just keep an array of PA's that would be the same size as the
> struct page array. And not need the populate loop? 

We need Linux language, struct page *, for alloc and free. Also need
TDX Module language - PA list - for SEAMCALLs. So IIUC, the page to PA
populating won't disappear on allocation, the PA to page populating
would appear on free.

Besides, host may need to vmap and access the (shared) pages.

Thanks,
Yilun
