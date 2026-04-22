Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A188F2DF132;
	Wed, 22 Apr 2026 10:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776852520; cv=none; b=rwcKuQPbhldQQ++6oMUBlGC3U4W7IkQbX92QX1Ch+sILx94dKQVktWvoLo9f+ui/E2Y3WFw+5aPay+dNEmWok9tZUWFeyi/+BNytMKQCs+dZmSunNEeSl6Be7NHdWydHiJ8ev1Sj8QthmylhSVaEqduG+QcBoV9xOXzH4Mif+Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776852520; c=relaxed/simple;
	bh=r2Ab2e3TX1xz+0fxRvMDzUsnz1vWyQWs6ma8wdCDmNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDxcc9HEbK7hUw5KnDCJawcsvjhbZm/WS931CArFGGTKpdPD5iMP10KxBLLBwF1hNWZ+vQ5R2TNc8/gEQ3DszVPOdqPRhe8cu8vTY51NwTCqc6pMaQY36EXjoiXk6uDiWvVnba7Pcc/TsN3Oynhv6cM7YeiGw/07LdTUWA/8Sss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n+vs50NO; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n+vs50NO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776852520; x=1808388520;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r2Ab2e3TX1xz+0fxRvMDzUsnz1vWyQWs6ma8wdCDmNU=;
  b=n+vs50NOkTk//gZgEMbLccTAwXytEfeq+kWp4H/Qr31fmpyDpz4TbVjX
   DFE0Elhv+9YrX856PfmRVQqG3s/+ZTOS0ElIkXMbPAXAFMBqOTolTa8X1
   8ZGHvHlXq/NGGE6ZIku+2yQA+i3VEUkrGhCzKNf3SIkm2eRsnUnxJZBfC
   FozGxH02bckQRkO7c/vgygRps29AdLzjLCEo6/3uioB/psirat3O86kgk
   b+lWChoVucVyO+8Gc/WYlbrHH2+oB5LbZmPvuqxSnBCFxjE2boWCg+vlp
   zTr/Vqqz8c4psTYylG77MLLX4o9/Ai31O+fIwe1AbRSllAU600DQBOvBg
   A==;
X-CSE-ConnectionGUID: ZZ1L4F6yQC2cYLomwO92/g==
X-CSE-MsgGUID: rkr5rA5kTwKtRsNu5R0Icg==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="76834859"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="76834859"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 03:08:39 -0700
X-CSE-ConnectionGUID: hGtqkofsRbeKSHqa/MlHKA==
X-CSE-MsgGUID: ZmiFbkyfQgqS5fWLrcqgvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="225818160"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa009.fm.intel.com with ESMTP; 22 Apr 2026 03:08:35 -0700
Date: Wed, 22 Apr 2026 17:46:22 +0800
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
Subject: Re: [PATCH v2 25/31] x86/virt/tdx: Add SEAMCALL wrappers for SPDM
 management
Message-ID: <aeiY7qsBgVIbG5F0@yilunxu-OptiPlex-7050>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-26-yilun.xu@linux.intel.com>
 <BN9PR11MB5276DE573BCA90782AE5BA608C582@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276DE573BCA90782AE5BA608C582@BN9PR11MB5276.namprd11.prod.outlook.com>

On Thu, Apr 09, 2026 at 07:59:33AM +0000, Tian, Kevin wrote:
> > From: Xu Yilun <yilun.xu@linux.intel.com>
> > Sent: Saturday, March 28, 2026 12:01 AM
> > 
> 
> here ...
> 
> > - TDH.SPDM.MNG supports three SPDM runtime operations: HEARTBEAT,
> >   KEY_UPDATE and DEV_INFO_RECOLLECTION.
> 
> ... but the actual helper just pass whatever ops to TDX module

Ah, yes. But only tdx-host driver which implements link encryption cares
about these operation code. My preference is only define general the
SEAMCALL wrapper format in TDX core as other SEAMCALL do. And leave the
specific op code definition in tdx-host driver.

I can revise the commit log as:

   - TDH.SPDM.MNG supports various SPDM runtime operations: HEARTBEAT,
     KEY_UPDATE, DEV_INFO_RECOLLECTION... These operation codes are defined
     in tdx-host driver.
 
Thanks.

> 
> > +u64 tdh_exec_spdm_mng(u64 spdm_id, u64 spdm_op, struct page
> > *spdm_param,
> > +		      struct page *spdm_rsp, struct page *spdm_req,
> > +		      struct tdx_page_array *spdm_out,
> > +		      u64 *spdm_req_or_out_len)
> > +{
> > +	struct tdx_module_args args = {
> > +		.rcx = spdm_id,
> > +		.rdx = spdm_op,
> > +		.r8 = spdm_param ? page_to_phys(spdm_param) : -1,
> > +		.r9 = page_to_phys(spdm_rsp),
> > +		.r10 = page_to_phys(spdm_req),
> > +		.r11 = spdm_out ? hpa_array_t_assign_raw(spdm_out) : -1,
> > +	};
> > +	u64 r;
> > +
> > +	r = seamcall_ret_ir_exec(TDH_SPDM_MNG, &args);
> > +
> > +	*spdm_req_or_out_len = args.rcx;
> > +
> > +	return r;
> > +}
> > +EXPORT_SYMBOL_FOR_MODULES(tdh_exec_spdm_mng, "tdx-host");
