Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAB431E832;
	Sun, 19 Apr 2026 09:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776591732; cv=none; b=BTACNTONS8eGJv+wGOkYF3gBpcA+jW1XIYKQZJXrGIRasfDmIbDV+A8kebv+MD2doTRfYNdfnLY2ln/f4m35zXnM3nwWbfT5KdeeFjS6Ko8KENMoH5p8vdPT42/4rwCBd6dtuItDQz8vZ5wxd5GkNDaSceQIX6JNQM7f3jsm2w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776591732; c=relaxed/simple;
	bh=xMnHtfngJm6ut0vOrrQvYCGnauOaX3RScn4ALDcNWRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C0K0bI9obMNB4P11Le5LC/JJQejUPSJOzqSuZzGnIDeHZ2ZrLsKVVHesFFSS7V5XVV1l4Iirrbo0BMjlMOpR55ancD+nBPmfA6FZzcag3MLf9fzACYXrEAkX8Az1ULAno3iLPYYenOdRtcu3Y58SbYyPEwPQfGNx9KJRujlmjro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XYvTe7U9; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XYvTe7U9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776591731; x=1808127731;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xMnHtfngJm6ut0vOrrQvYCGnauOaX3RScn4ALDcNWRw=;
  b=XYvTe7U9VlRyMvyiCBKKskbMoW8vA/1w3mmBJFZsXB0B4mZVVFzeoeLf
   X/+GGepkSrN6gNvNkPgpgYrPa7SuOL8SJx3xqunMDsCCsNouk7k2QDDOM
   iq/KOplhypBFC1617RC6ThhbJqX57MZ6F8UgfisUpXK9WCBFCcIYOLzmx
   YPfjvyAqWQFU1viUmhUso8uHnlGmLuBH7QZI4MaT4Ut+aJsB5GkMFdjE+
   ifbHpGVqGNy/f7CmL3fu/aOeMn4fLp+ksL7dveH0FZiwtqfKroTZTnVSL
   S6h34jAYl378BBkU4P8jJaLqp6xilxaSz1Da2jEh8CgXJIwoQMR2uD9It
   Q==;
X-CSE-ConnectionGUID: 0+k2CwNVRLujAIBJXYNI9Q==
X-CSE-MsgGUID: 0M53yVSxRF6xuDxxn7nfhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="77612121"
X-IronPort-AV: E=Sophos;i="6.23,188,1770624000"; 
   d="scan'208";a="77612121"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2026 02:42:11 -0700
X-CSE-ConnectionGUID: fypQKHHKQVWpNn0LFa1Z6Q==
X-CSE-MsgGUID: /tCSLB2ATCqYBra+CzaP4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,188,1770624000"; 
   d="scan'208";a="233204225"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa004.fm.intel.com with ESMTP; 19 Apr 2026 02:42:07 -0700
Date: Sun, 19 Apr 2026 17:20:02 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Dan Williams <djbw@kernel.org>
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
	dan.j.williams@intel.com, x86@kernel.org, chao.gao@intel.com,
	dave.jiang@intel.com, baolu.lu@linux.intel.com, yilun.xu@intel.com,
	zhenzhong.duan@intel.com, kvm@vger.kernel.org,
	rick.p.edgecombe@intel.com, dave.hansen@linux.intel.com,
	kas@kernel.org, xiaoyao.li@intel.com, vishal.l.verma@intel.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/31] x86/virt/tdx: Add tdx_page_array helpers for
 new TDX Module objects
Message-ID: <aeSeQrzaFRi4F0TT@yilunxu-OptiPlex-7050>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-4-yilun.xu@linux.intel.com>
 <69e2c4134f1ef_147c801001a@djbw-dev.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69e2c4134f1ef_147c801001a@djbw-dev.notmuch>

> > +#define HPA_LIST_INFO_FIRST_ENTRY	GENMASK_U64(11, 3)
> > +#define HPA_LIST_INFO_PFN		GENMASK_U64(51, 12)
> > +#define HPA_LIST_INFO_LAST_ENTRY	GENMASK_U64(63, 55)
> > +
> > +static u64 __maybe_unused hpa_list_info_assign_raw(struct tdx_page_array *array)
> 
> 2 quick comments:
> 
> * I do not understand shipping a __maybe_unused helper in patch 3 that
>   does not get used until patch10.

You once had a comment wanting to see how a tdx_page_array collapses to
a 64-bit raw value for SEAMCALLs in the same patch. So I move the
helpers earlier. Do you want to change them back?

Personally, I'd like to keep them here, to better align with the
illustration in commit log about why we need the tdx_page_array.

> 
> * The "assign_raw" verb feels strange. I think this probably just want
>   to be called: to_hpa_list_info(struct tdx_page_array *)

It's a better name, thanks.

[...]

> > +{
> > +	unsigned long pfn;
> > +
> > +	if (array->nents == 1)
> > +		pfn = page_to_pfn(array->pages[array->offset]);
> > +	else
> > +		pfn = PFN_DOWN(virt_to_phys(array->root));
> > +
> > +	return FIELD_PREP(HPA_ARRAY_T_PFN, pfn) |
> > +	       FIELD_PREP(HPA_ARRAY_T_SIZE, array->nents - 1);
> > +}
> > +
> > +static u64 __maybe_unused hpa_array_t_release_raw(struct tdx_page_array *array)
> 
> It seems too subtle that this function sometimes returns zero and
> sometimes returns a page that the TDX module will clobber with data that
> we do not care about.
> 
> It is also not clear that "0" is what the module considers a valid value
> that meets "checks its validity for forward compatibility". I guess we

It is the TDX Module's requirement, which is 'too subtle'. TDX Module
tries to keep align with the singleton definition for its output
hpa_array_t. If TDX Module wants to output multiple released pages, it
requires VMM to provide a root page HPA (in input register) so it can
write HPA list on the root page. But if it outputs one released page, it
directly writes page0 HPA in output register, and doesn't need a root
page HPA in input register and enforce its value 0.

That's why we return 0 on singleton mode, otherwise a root page HPA.

> get lucky because all of the calls that need this presently are
> multi-page cases?

Let me experiment, see if we have chance to simplify things.

> 
> I would feel better if this always returned the root HPA and was called

No, we can't. We must provide 0 for singleton mode. So I think maybe

      to_hpa_array_t_released()


Anyway, Linux doesn't need the output hpa_array_t. I've already raised
to Module team that don't enforce the medium page input. If VMM doesn't
provide the page, don't bother fill it.

> something like:
> 
>     to_output_clobber(), or to_aux_clobber()
> 
> ...to make it clear that whatever was there before gets destroyed.
> 
