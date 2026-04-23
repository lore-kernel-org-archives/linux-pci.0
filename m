Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B883B38AF;
	Thu, 23 Apr 2026 16:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776960704; cv=none; b=Mz8Cnzer82pZDQy9NRBJojZtbVmWFHIFs5mMbHM8vHTd+tpE81kK6+tpPYs6u5DtD6jOR8hOf0pC2+hFNaX/aWcw0QWX17qvdwJ9L62lspT6rFt4EXqxMth9X3fWEfqcb6/0xonDjNz8gD8vjXxlPlgYBP9WBfNkBYFOGa3aGrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776960704; c=relaxed/simple;
	bh=NwSQ5W3OkXSYKvZWQ1PKtWmGWeMIrSt8dgUnFNUEk9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCaHlj42FcSfk8SK6mwSX2Vj/H1GkPTlxvseK8NM2hvQ3YkZVUOMd6cbV2KxmFdde9Fz4V7S9hxGGRz0yFdAOMQwt8gealjedfV2Eo9DxQgrFObhELN7QCUjKST3Nc0bhf9Lg5OAdfk2UuWD/W96224WS8RWQSOBxC5BGMahiHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OJ5roPcp; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OJ5roPcp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776960702; x=1808496702;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NwSQ5W3OkXSYKvZWQ1PKtWmGWeMIrSt8dgUnFNUEk9c=;
  b=OJ5roPcp/oK41GyzL/HnZSz+aulrZVG8epy0E0kuRTCkfdNiEKdHay6x
   SbFBnwjQ+qw0xnSonQAGwQvwp8wEGkPuHiF8ATs3h4EhM+/H+lZ63z+a9
   f90n9ZssS7ywXtPS56mtrhp/V+xcPVV16uAH7O+d+n966UP/ZVgu8uqiN
   jm9bsAouCfnZlUwu3FuW42b8NSgNGmurRfM20CB2S4eMAuEZU7QGw1PKe
   ajckppwCYekKgZiKNidmo12C05h36DBQT2V38Ef1QOPcx0GKjY8AS/ZPi
   ldrCJlZQbX4ZbMEaB8Z7Pbyy20bwrcDtNJs+4EvNRhjaaJ0DeKPtdHw/+
   A==;
X-CSE-ConnectionGUID: H6QOR9lDSaC65py1dqVx/w==
X-CSE-MsgGUID: +F58VTqdQk2aYuL7iK17mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="77100786"
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; 
   d="scan'208";a="77100786"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 09:11:42 -0700
X-CSE-ConnectionGUID: xhjZTAs0QHGErBnFKdPmyQ==
X-CSE-MsgGUID: jSKRxRWHQMWaqvQ3FNHC5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; 
   d="scan'208";a="236689740"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa003.jf.intel.com with ESMTP; 23 Apr 2026 09:11:37 -0700
Date: Thu, 23 Apr 2026 23:49:20 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Dan Williams <djbw@kernel.org>
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
	dan.j.williams@intel.com, x86@kernel.org, chao.gao@intel.com,
	dave.jiang@intel.com, baolu.lu@linux.intel.com, yilun.xu@intel.com,
	zhenzhong.duan@intel.com, kvm@vger.kernel.org,
	rick.p.edgecombe@intel.com, dave.hansen@linux.intel.com,
	kas@kernel.org, xiaoyao.li@intel.com, vishal.l.verma@intel.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/31] x86/virt/tdx: Configure TDX Module with
 optional TDX Connect feature
Message-ID: <aeo/gOWbGy89nWDN@yilunxu-OptiPlex-7050>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-9-yilun.xu@linux.intel.com>
 <69e8223f4c8e6_fe08310058@djbw-dev.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69e8223f4c8e6_fe08310058@djbw-dev.notmuch>

On Tue, Apr 21, 2026 at 06:19:59PM -0700, Dan Williams wrote:
> Xu Yilun wrote:
> > TDX Module supports optional TDX features (e.g. TDX Connect & TDX Module
> > Extensions) that won't be enabled by default.
> 
> So this is another place where "optional" is misleading. For simplicity
> there is no mechanism to fallback from TDX Connect operation if present,
> at least in the core. The only optional aspects would be the mechanism
> that could be unloaded through the tdx_host driver.

I see. I think I should use 'extra' instead of 'optional' in all places.
I'll rephase the comments.

> 
> .../me notices that other comments on this patch say the same, but do
> read on, another important detail about ktime_get_real_seconds() below.
> 
> > It extends TDH.SYS.CONFIG for host to choose to enable them on bootup.
> > 
> > Call TDH.SYS.CONFIG with a new bitmap input parameter to specify which
> > features to enable. The bitmap uses the same definitions as
> > TDX_FEATURES0. But note not all bits in TDX_FEATURES0 are valid for
> > configuration, e.g. TDX Module Extensions is a service that supports TDX
> > Connect, it is implicitly enabled when TDX Connect is enabled. Setting
> > TDX_FEATURES0_EXT in the bitmap has no effect.
> > 
> > TDX Module advances the version of TDH.SYS.CONFIG for the change, so
> > use the latest version (v1) for optional feature enabling. But
> > supporting existing Modules which only support v0 is still necessary
> > until they are deprecated, enumerate via TDX_FEATURES0 to decide which
> > version to use.
> 
> I would say this differently, it will always be the case that new
> kernels are needed to enable new features, but it is unlikely that
> TDH.SYS.CONFIG ever needs to change again. The v0 -> v1 transition means
> that feature bits are to be used here on out. So there is little value
> in worrying about deprecating v0 to save a couple lines of code in 5-7
> years when these original TDX platforms sunset.

OK. I'll use your rationale.

> 
> > TDX Module updates global metadata when optional features are enabled.
> > Host should update the cached tdx_sysinfo to reflect these changes.
> > 
> > Co-developed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> > Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> > Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> > ---
> >  arch/x86/virt/vmx/tdx/tdx.h |  3 ++-
> >  arch/x86/virt/vmx/tdx/tdx.c | 16 +++++++++++++++-
> >  2 files changed, 17 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
> > index e5a9331df451..870bb75da3ba 100644
> > --- a/arch/x86/virt/vmx/tdx/tdx.h
> > +++ b/arch/x86/virt/vmx/tdx/tdx.h
> > @@ -58,7 +58,8 @@
> >  #define TDH_PHYMEM_CACHE_WB		40
> >  #define TDH_PHYMEM_PAGE_WBINVD		41
> >  #define TDH_VP_WR			43
> > -#define TDH_SYS_CONFIG			45
> > +#define TDH_SYS_CONFIG_V0		45
> > +#define TDH_SYS_CONFIG			SEAMCALL_LEAF_VER(TDH_SYS_CONFIG_V0, 1)
> >  
> >  /* TDX page types */
> >  #define	PT_NDA		0x0
> > diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> > index 130214933c2f..0c5d6bdd810f 100644
> > --- a/arch/x86/virt/vmx/tdx/tdx.c
> > +++ b/arch/x86/virt/vmx/tdx/tdx.c
> > @@ -1353,6 +1353,7 @@ static int construct_tdmrs(struct list_head *tmb_list,
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
> 
> Mainline has reason to not entertain this module requirement. The fact
> that passing zero is an error is useful to detect unsupported modules.

Ah, it is "useful"...  :)

> An updated module would accept zero as indicating "VMM requests module
> disable all policy and mechanisms related to untrusted wall clock time".
> Specifically, there are several problems with this:
> 
> 1/ No other TSM implementation requires the VMM to pass in an untrusted time
> 2/ The wall time may change and may require hooks to keep the module time
>    up to date, but see point 1/, this would be a TDX special flower hook.
> 3/ Presumably this allows the module or the guest to do certificate expiration
>    checks, but that is the responsibility of the relying party. The
>    relying party may have reason to accept an "expired" cert as determined
>    by VMM wall clock, and the guest presumably already has mechanisms to
>    determine untrusted wall clock time from the VMM if it wants. Guests
>    do not need TDX ABI for that.
> 
> So I think Linux wants to pass 0 here and wait for modules that accept
> that as the start of TDX Connect support. As you said, given there are
> no released modules with TDX Connect there is time to make that first
> release drop this requirement.

I see. Actually the Module is about to remove the r11 RTC.

https://cdrdv2.intel.com/v1/dl/getContent/871617

I'll remove this r11.


