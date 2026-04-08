Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE61342519;
	Wed,  8 Apr 2026 07:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775634187; cv=none; b=leQEULdJb2LLBal8L6ikpYJQIcNCTJK8bVRT4vrY710jl+G4mBIOe5o8WoPOv8fn3n6kBaHKJnbsu82xtnZ+AimD97HYWNP2T6TDIKc7vW2zz3TwgIlALm3f5Ip1Iq8x4xuK9wKaqKH+7Lirc4H71+m3ibeJ++R2h9or2S/2jwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775634187; c=relaxed/simple;
	bh=92apjKIq3V/Vil+v0781AdMkOLBeV57GYGIb7EwOhDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NKSc3pkGNGKkam3uLk/m8eM/Z+tLf5fWkuqcurqmSUJBMN618EGjU2wTcg71lxKcZ4BuR4fXPRjJuclL2ltUEyKCoE3L7ZViyr5NUT8OiqKMRRgYbW6v4OecoqLYnc0d84V3bvwh12meVFqKitgcHx8KBa0QF6JVK/dLgzguoFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TJdYkMhs; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TJdYkMhs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775634186; x=1807170186;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=92apjKIq3V/Vil+v0781AdMkOLBeV57GYGIb7EwOhDI=;
  b=TJdYkMhsWNIaUq9jyWeitazqsgGUmdf8uLqoTiPw+iePO5kYlXfT5NKg
   kYbYxSxFYprV+tXWnqb2weIfMgVM6OIIF0zqexh/kaok1TYng7CHbrhuN
   LNm/8YcpTZTZgREc0l/0vbXKrl3O0zblg2vZJ/d7e4rVSTH0aNElSSpJE
   ggISNi3G5PGL+IIUDl8AY2B5PsMc00AvtV9k6KE0FIV2bvLuWc5fiVtxc
   K4OAyS01ZzGD86XYI8FlKYf1oYHbK5z8WWq4xQdokBmvHzpE54AvbCiKW
   zvk16fsw5ykmi/CdCEsEizDj/UWgEcz/ZBRYzY+HqM2vKRRst5RrGx5qc
   g==;
X-CSE-ConnectionGUID: WpssInk6SASTNB6rumSWcw==
X-CSE-MsgGUID: iVdmYhetQamg0wyz04LY/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="79200897"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="79200897"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 00:43:05 -0700
X-CSE-ConnectionGUID: t56srLlWRsyl48wK69TAzA==
X-CSE-MsgGUID: uIDSKUdzTwKU5axE5pb8wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="228290155"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa009.jf.intel.com with ESMTP; 08 Apr 2026 00:43:01 -0700
Date: Wed, 8 Apr 2026 15:21:29 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
	dan.j.williams@intel.com, x86@kernel.org, chao.gao@intel.com,
	dave.jiang@intel.com, baolu.lu@linux.intel.com, yilun.xu@intel.com,
	zhenzhong.duan@intel.com, kvm@vger.kernel.org,
	rick.p.edgecombe@intel.com, dave.hansen@linux.intel.com,
	kas@kernel.org, xiaoyao.li@intel.com, vishal.l.verma@intel.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/31] x86/virt/tdx: Configure TDX Module with
 optional TDX Connect feature
Message-ID: <adYB+fEvEIE59z9A@yilunxu-OptiPlex-7050>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-9-yilun.xu@linux.intel.com>
 <730feb0b-7022-4d22-9ead-3efc4b4ab4ab@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <730feb0b-7022-4d22-9ead-3efc4b4ab4ab@suse.com>

On Tue, Mar 31, 2026 at 01:38:16PM +0300, Nikolay Borisov wrote:
> 
> 
> On 27.03.26 г. 18:01 ч., Xu Yilun wrote:
> > TDX Module supports optional TDX features (e.g. TDX Connect & TDX Module
> > Extensions) that won't be enabled by default. It extends TDH.SYS.CONFIG
> > for host to choose to enable them on bootup.
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
> > 
> > TDX Module updates global metadata when optional features are enabled.
> > Host should update the cached tdx_sysinfo to reflect these changes.
> > 
> > Co-developed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> > Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> > Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> > ---
> >   arch/x86/virt/vmx/tdx/tdx.h |  3 ++-
> >   arch/x86/virt/vmx/tdx/tdx.c | 16 +++++++++++++++-
> >   2 files changed, 17 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
> > index e5a9331df451..870bb75da3ba 100644
> > --- a/arch/x86/virt/vmx/tdx/tdx.h
> > +++ b/arch/x86/virt/vmx/tdx/tdx.h
> > @@ -58,7 +58,8 @@
> >   #define TDH_PHYMEM_CACHE_WB		40
> >   #define TDH_PHYMEM_PAGE_WBINVD		41
> >   #define TDH_VP_WR			43
> > -#define TDH_SYS_CONFIG			45
> > +#define TDH_SYS_CONFIG_V0		45
> > +#define TDH_SYS_CONFIG			SEAMCALL_LEAF_VER(TDH_SYS_CONFIG_V0, 1)
> 
> Since newer versions of tdx module apis are backwards compatible with older
> ones, and v0 are actually deprecated why have both definitions?

No, for this TDH_SYS_CONFIG SEAMCALL, the situation is different. There
is no public TDX Module release yet to support TDH_SYS_CONFIG_V1. So I
can't say v0 is deprecated.

> 
> 
> <snip>
