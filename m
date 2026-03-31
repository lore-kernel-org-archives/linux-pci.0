Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249D43DA5B9;
	Tue, 31 Mar 2026 13:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774965188; cv=none; b=d1amKmRChtaoZGlcJh/Scf/Dw5Jp/lp8xMb3R8VPeGuTCX+24iTtXWJ14uoT87vOlkFPaAB8mzyY0ZKHEc7r3Hp+PRhX3COAXmbvsvn6eXXIl96kS7ipDUDckAjaVqJHXZiNMakjF+51i0Mm/tKK/HZ+7ra0rq7R4dS3ynm+Ba4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774965188; c=relaxed/simple;
	bh=r+pFe1PDSqztfT2fZ08Q6HLabDULFA1GwolFuuOun88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ros7F/LBx3QebfXG6J2ORVHw6h30ccObNX9bDoq3zPsCEn8HiYtrDj3PQiKqeEQy+AD+CaJ+kUbqN8GFirVZyMb5c5VC2qATWDKd4jEqNrTS0bNweycqp4fIan+Gc9VhBLe3qOTTomNXSp6ELnLGmCLY/SHiG3GhJKLwoHJ1WsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f3cvfwEp; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f3cvfwEp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774965188; x=1806501188;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=r+pFe1PDSqztfT2fZ08Q6HLabDULFA1GwolFuuOun88=;
  b=f3cvfwEpoMxrIe+EmoK4b5zsJeCzp6eubbrOH3DaPyGQYz+yPPRj2bjv
   XLlMlFJ51H3FbEEXe29lpWvFzLCQNZAtF0JTHPFk27uK3BvZbQvGRFZM0
   4lZiDVlhnytP4JI5E9xUKQbQvftJ6j87OJC2FN5mAHl7x0+cOMwil3oxl
   8Fac8pRwwPhy/HrExhRzvuzwXuKTcdocBlNxQD/DnTqNwAQw75GVYm1/n
   TY92d92UhLiQJy4o1BsLpEci+tf6xbwaBisIHle1X4ynKArfT++gP2GAe
   LNpfHoih4H+B+2YU6bW2S+AFV8jGADr/rhrXQlnHOKRp7FF/4RRFxgwji
   Q==;
X-CSE-ConnectionGUID: 5iFAkSwHQcmFiT+Oxo53qw==
X-CSE-MsgGUID: cLixKqMdSEG3Ti4OMMOTYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="98589617"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="98589617"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 06:53:07 -0700
X-CSE-ConnectionGUID: eJL/tyDFTNuo8+YWRPpMpg==
X-CSE-MsgGUID: MHGr1+t+TDutrHK33c8pfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="256870739"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa002.jf.intel.com with ESMTP; 31 Mar 2026 06:53:02 -0700
Date: Tue, 31 Mar 2026 21:31:53 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
	dan.j.williams@intel.com, x86@kernel.org, chao.gao@intel.com,
	dave.jiang@intel.com, baolu.lu@linux.intel.com, yilun.xu@intel.com,
	zhenzhong.duan@intel.com, kvm@vger.kernel.org,
	rick.p.edgecombe@intel.com, dave.hansen@linux.intel.com,
	kas@kernel.org, xiaoyao.li@intel.com, vishal.l.verma@intel.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/31] x86/virt/tdx: Add tdx_page_array helpers for
 new TDX Module objects
Message-ID: <acvMyTp8eZ5L3vjw@yilunxu-OptiPlex-7050>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-4-yilun.xu@linux.intel.com>
 <4af194d0-f1d7-4acf-aeef-cf3bb3a4b10e@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4af194d0-f1d7-4acf-aeef-cf3bb3a4b10e@suse.com>

On Mon, Mar 30, 2026 at 04:31:43PM +0300, Nikolay Borisov wrote:
> 
> 
> On 27.03.26 г. 18:01 ч., Xu Yilun wrote:
> <snip>
> 
> > +/**
> > + * tdx_page_array_ctrl_leak() - Leak data pages and free the container
> > + * @array: The tdx_page_array to be leaked.
> > + *
> > + * Call this function when failed to reclaim the control pages. Free the root
> > + * page and the holding structures, but orphan the data pages, to prevent the
> > + * host from re-allocating and accessing memory that the hardware may still
> > + * consider private.
> > + */
> > +void tdx_page_array_ctrl_leak(struct tdx_page_array *array)
> > +{
> > +	if (!array)
> > +		return;
> > +
> > +	kfree(array->pages);
> > +	kfree(array->root);
> > +	kfree(array);
> > +}
> > +EXPORT_SYMBOL_GPL(tdx_page_array_ctrl_leak);
> 
> This instantly raises a red flag if by design an API has the ability to

OK. With the discussion in this thread, I tend to remove this leak API.

> simply leak memory. Under what conditions this might be required, can't we
> do something to gracefully handle the case when pages cannot be freed
> instantly, i.e queued freeing or some such ? Simply leaking them is a big
> NO.

It was intended to be called when failing to reclaim pages from secure
firmware, maybe because of firmware bug. In this case kernel has no idea
what to do. Leaking is a last resort here, don't expect things still work.

