Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F4EEED8;
	Wed,  8 Apr 2026 07:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775633643; cv=none; b=u2jxrEulCIdRPhTTK/n8PYEqFrhMLAwT9eTTt1NlBKILR/JQvM3/XOqEWYT5/Ty91e50vSHEGOjDqHwO1+U9W/thXeLOUxu6JxSEJwLT7nEngqDs4ncdcBXnLr0NYOkv/oxG8GiMh3QOpaY2QY2mrYqCHpL7CFHd0aI8nFTJVdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775633643; c=relaxed/simple;
	bh=b/VOXPFjCE8dX3TjUJf6dh+G4cRGp5dIvF5DKtG0Z6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sm/y7AF9xJIWZJ4uSyJaQED9VPIpm4lrqVI6mfSbdBclZrt8DcKZqsnbzVHoIM25qiYl9BPKbO3oZnB9TBUxL3Y9K++1FjFD6eZHWVsmPSCWJWlBJnkjFZ7ufEWDze5oEA5MSXJOwpssMDg+jcyAYttMStfHdOEoFazdDQAwrPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C8gdnPRc; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C8gdnPRc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775633642; x=1807169642;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b/VOXPFjCE8dX3TjUJf6dh+G4cRGp5dIvF5DKtG0Z6I=;
  b=C8gdnPRciBKgZYAsICk9b0YQqjW3HAAcskd/IBbbkg02kg3ZVRl4poQD
   MPqkwjv+mfh40KGCMrI5nTTPVEVpXpg/n3k4kvrfPVTouuqhAeV2Fiq8T
   4BE+rIKRgDLQAAffVYwG68OEnzjMFuH6VamWjj6SGTOW5EuGZ3opJXd/g
   tjA4zbfLIvYUaz6UWRuPCjijV6nB2ISuQpQ+v665p+Kgs43GKEl5o46k8
   L3Ttbtn0a5rhlmkWND810F3z4a8WTupgv+EtAWPliXcU+KOFMnikVwPAN
   oipxUCR6Uy25MYzuzxBk3wRgcfO76VdHTF8Pymt0kdiS/ZfrY8IzH6/y8
   Q==;
X-CSE-ConnectionGUID: jb34n6aWTAaM+vU15RnaFw==
X-CSE-MsgGUID: iU4+OloGSn+EcJki/gtN3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="76329284"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="76329284"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 00:34:02 -0700
X-CSE-ConnectionGUID: Pvkv/j3UQQ6JwIe04/ddvw==
X-CSE-MsgGUID: 0XYu2UxkQ4yP6seUK7ObVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="232769437"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa004.jf.intel.com with ESMTP; 08 Apr 2026 00:33:58 -0700
Date: Wed, 8 Apr 2026 15:12:26 +0800
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
Subject: Re: [PATCH v2 08/31] x86/virt/tdx: Configure TDX Module with
 optional TDX Connect feature
Message-ID: <adX/2oTOsiigA2QI@yilunxu-OptiPlex-7050>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-9-yilun.xu@linux.intel.com>
 <d563b85664271c4d8510f66222c8a05d77d396e1.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d563b85664271c4d8510f66222c8a05d77d396e1.camel@intel.com>

On Wed, Apr 01, 2026 at 10:13:33AM +0000, Huang, Kai wrote:
> 
> > 
> > TDX Module updates global metadata when optional features are enabled.
> > Host should update the cached tdx_sysinfo to reflect these changes.
> > 
> > 
> [...]
> 
> >  static int config_tdx_module(struct tdmr_info_list *tdmr_list, u64 global_keyid)
> >  {
> >  	struct tdx_module_args args = {};
> > +	u64 seamcall_fn = TDH_SYS_CONFIG_V0;
> >  	u64 *tdmr_pa_array;
> >  	size_t array_sz;
> >  	int i, ret;
> > @@ -1377,7 +1378,15 @@ static int config_tdx_module(struct tdmr_info_list *tdmr_list, u64 global_keyid)
> >  	args.rcx = __pa(tdmr_pa_array);
> >  	args.rdx = tdmr_list->nr_consumed_tdmrs;
> >  	args.r8 = global_keyid;
> > -	ret = seamcall_prerr(TDH_SYS_CONFIG, &args);
> > +
> > +	if (tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_TDXCONNECT) {
> > +		args.r9 |= TDX_FEATURES0_TDXCONNECT;
> > +		args.r11 = ktime_get_real_seconds();
> > +		/* These parameters requires version >= 1 */
> > +		seamcall_fn = TDH_SYS_CONFIG;
> > +	}
> > +
> > +	ret = seamcall_prerr(seamcall_fn, &args);
> >  
> >  	/* Free the array as it is not required anymore. */
> >  	kfree(tdmr_pa_array);
> > @@ -1537,6 +1546,11 @@ static int init_tdx_module(void)
> >  	if (ret)
> >  		goto err_free_pamts;
> >  
> > +	/* configuration to tdx module may change tdx_sysinfo, update it */
> > +	ret = get_tdx_sys_info(&tdx_sysinfo);
> > +	if (ret)
> > +		goto err_reset_pamts;
> > +
> 
> How about put this into config_tdx_module()?
> 
> In this way you can only update global metadata when there's new feature

mm.. personally I don't like such subtle control, especially when

 - We expect one or more features are doomed to be enabled.
 - We are pursuing simple TDX enabling process.
 - This is still not the exact control. If we really want to be precise,
   should check feature by feature, that's not worth it.

> being opted in, and at the meantime, avoid making init_tdx_module() more
> complicated.
