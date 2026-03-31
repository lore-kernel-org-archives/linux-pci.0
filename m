Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C721DF748;
	Tue, 31 Mar 2026 15:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774970378; cv=none; b=SLsXuWuLc0dWcL+qgI6HyP7E9Dq5pl7oY6xjRd2WdQgaN3FOtvbmNQWuya0dfGWOezwoVtmX+QuhWgWTU64rBM1eFJgsRL7x1I2YmJmVZND6TvkmcEdMtrOJf9O083f829zQMSuo3rP4X/7ZNotfPTUgwSjVaTA2lEDuWcL3Y7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774970378; c=relaxed/simple;
	bh=+5nwryV+ht3ZXO8SXJR1QEUNIxWsjRf7y7BMh8hN8JQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+9LOJ7cHpxUl1q+cqS0Xxs0hiJLkcROGw6a/cHo0LXyQyLurZVI0adGggJLN96cOE9um/RhmHEB96TyjAEnO2cEoxq7sBU1sy2dO/tSpH8vVbNQN8XNWLpwHhWIRNzAPdUHkzxhHfKDz4D8XWfWK3PMmMfVtOPOP7vPN/M9nPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KaPf5Tnf; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KaPf5Tnf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774970377; x=1806506377;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+5nwryV+ht3ZXO8SXJR1QEUNIxWsjRf7y7BMh8hN8JQ=;
  b=KaPf5TnfQiP6OyFc0RkdO/1qHKHdJcMpDe4VGkD4/KO2mPMm2ryjYTTi
   qfYKNfsuGnSRwKe1Gtnj2USek+3QoNUwLexMvh2J7TVDpYy+pY6fPBcEK
   +cFOwLwnSiERqDQy8vqGH30HgNFsIxKnyPtErb0vONSd97r7+QFKn3xgH
   xaFl9XGaKWGhEkuviN51jSQznmLv/blDCzdgs0DugOQEe/jmbi+UNmrjr
   ZmI+0bEtk8Pf8yYXhcf8yQZ26/Fv62HoQbVmjNi4ORV2dIYV7zmpibp+M
   PRmJh4XvFMK3bCMPXEpb8Zevupr+BjgFOMa4Kv/xFb3Te7QC1XNkCTEvV
   Q==;
X-CSE-ConnectionGUID: Jchwg2spQ2iUVPQRStKuBQ==
X-CSE-MsgGUID: vvX6F7zWRcWeUUq0fz1uKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="75881733"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="75881733"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 08:19:36 -0700
X-CSE-ConnectionGUID: 3vc6NVspThOQw0nsEQ4k1w==
X-CSE-MsgGUID: q3CkgsV6TxWDvUcYLZ90ew==
X-ExtLoop1: 1
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa003.fm.intel.com with ESMTP; 31 Mar 2026 08:19:33 -0700
Date: Tue, 31 Mar 2026 22:58:23 +0800
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
Subject: Re: [PATCH v2 11/31] x86/virt/tdx: Make TDX Module initialize
 Extensions
Message-ID: <acvhD/XeCbB4ea0C@yilunxu-OptiPlex-7050>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-12-yilun.xu@linux.intel.com>
 <5cbed31cdfcc7e43f283abc275848370239a3d40.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cbed31cdfcc7e43f283abc275848370239a3d40.camel@intel.com>

> >  static int tdx_ext_mem_add(struct tdx_page_array *ext_mem)
> >  {
> >  	struct tdx_module_args args = {
> > @@ -1572,6 +1589,17 @@ static int __maybe_unused init_tdx_ext(void)
> >  	if (!(tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_EXT))
> >  		return 0;
> >  
> > +	/*
> > +	 * With this errata, TDX should use movdir64b to clear private pages
> > +	 * when reclaiming them. See tdx_quirk_reset_paddr().
> > +	 *
> > +	 * Don't expect this errata on any TDX Extensions supported platform.
> > +	 * All features require TDX Extensions (including TDX Extensions
> > +	 * itself) will never call tdx_quirk_reset_paddr().
> > +	 */
> > +	if (boot_cpu_has_bug(X86_BUG_TDX_PW_MCE))
> > +		return -ENXIO;
> 
> I don't know if we are going to want to sprinkle these over every new feature
> until the end of time. If this feature will only show up on the platforms with
> this erratum, then I say we just drop the check.

Make sense.

> 
> > +
> >  	nr_pages = tdx_sysinfo.ext.memory_pool_required_pages;
> >  	/*
> >  	 * memory_pool_required_pages == 0 means no need to add more pages,
> > @@ -1587,6 +1615,20 @@ static int __maybe_unused init_tdx_ext(void)
> >  			goto out_ext_mem;
> >  	}
> >  
> > +	/*
> > +	 * ext_required == 0 means no need to call TDH.EXT.INIT, the Extensions
> > +	 * are already working.
> 
> How does this scenario happen exactly? And why not check it above at the
> beginning? Before the allocation, so it doesn't need to free.
> 
> Is there a scenario where the memory needs to be given, but the extension is
> already inited?

mm.. you are right. It leads to something absurd.

I checked with TDX Module team again. The correct understanding is:

 - TDX_FEATURES0_EXT bit shows Extensions is supported.
 - optional feature bits are selected on TDH_SYS_CONFIG
 - If one of the optional feature (e.g. TDX CONNECT) requires Extention,
   memory_pool_required_pages > 0 && ext_required == 1. Otherwise no
   need to initialize Extension.

So yes, I should check memory_pool_required_pages && ext_required at the
beginning.

> 
> > +	 */
> > +	if (tdx_sysinfo.ext.ext_required) {
> > +		ret = tdx_ext_init();
> > +		/*
> > +		 * Some pages may have been touched by the TDX module.
> > +		 * Flush cache before returning these pages to kernel.
> > +		 */
> > +		if (ret)
> > +			goto out_flush;
> > +	}
> > +
> >  	/* Extension memory is never reclaimed once assigned */
> >  	tdx_page_array_ctrl_leak(ext_mem);
> >  
> > @@ -1595,6 +1637,9 @@ static int __maybe_unused init_tdx_ext(void)
> >  
> >  	return 0;
> >  
> > +out_flush:
> > +	if (ext_mem)
> 
> For the error path we don't need to be efficient. But also why does it assume
> tdx_ext_init() can touch the pages, but tdx_ext_mem_add() can't?

The tdx_ext_mem_add() only collects memory, tdx_ext_init() does the
actual initialization for Extensions and touches the memory. But the
detail of when touching the pages is not specified in SPEC, do you think
host doesn't have to tell the difference, just flush when any one of
ext-SEAMCALLs is called?

> 
> 
> > +		wbinvd_on_all_cpus();
> >  out_ext_mem:
> >  	tdx_page_array_free(ext_mem);
> >  
> 
