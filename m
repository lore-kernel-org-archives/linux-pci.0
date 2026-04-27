Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D923537F7;
	Mon, 27 Apr 2026 03:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777259611; cv=none; b=GqE4Baa7totea4gQhcqSTt0c+nnWjTjG8s2fIBdC8RjmdTY7bAOKzPnBI8B5nEOhrB+paN1tvvD/x5TLu+x1MF6c7IQ80+giTeGfrZv+E0OjtCAXm5KqbVbgdRVLJTsZXr37Gmfkr0uvvJdKy55v3DOEMNO2RCuqZLdgpJ7tXPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777259611; c=relaxed/simple;
	bh=V80SL+lhwvJTQ0cXw8bvUx5mV2JJH1vu6VApetJqC/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pdmcqImvR+sh5SfuG/D8bq5wDIUPzx4K0NbF1lD7iVxHeYsyCNu9kdgw+FIHdUs/JwyHwvN0hdYU3t29BKSbvk0pTC0cH31eA6Gb+RTbnbzEAypoTNEvIJcrPX1bx8dQ+2VEmccl+6Gg/uZT4jLcZlCFoldQT9JeFPlf1mlltdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oCUK8wwc; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oCUK8wwc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777259609; x=1808795609;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V80SL+lhwvJTQ0cXw8bvUx5mV2JJH1vu6VApetJqC/w=;
  b=oCUK8wwcgC3UUWD6Np185HkE/+Vp2dbLbOFCPkD27l9mtVKrXQCCKuzi
   cZguS/XPgSoHJk/cACHzo95zfRVGqA6nhg7LvXsm4MlC3tUm2X3kVitYP
   K1ZOaJ+B9vzffoSAp7zEk5wgd20885b2qR7HKeBKb9YtFnCpIpHzWl/hh
   jqB0OsztJuEc7eMNG8pAHihNcFwJmuNOB4Cg+hWkdk/mwvaefe2KzzgbI
   6GE4M0/PN+z9U2ui7y0+pcyJjMs3JGUAKTkfraNvqWTsZW0WB0B0pM+GG
   uHk3u0mv8FFTPFbaYg0TmhoMhgFHQ+Qx0yQ5nK2me08Heftz7ZEwXAEp4
   w==;
X-CSE-ConnectionGUID: RVcKT/P5THymYDbNGr6Mdw==
X-CSE-MsgGUID: 1J3wBD0gTeux3EYPBV+bow==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="89606068"
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="89606068"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2026 20:13:28 -0700
X-CSE-ConnectionGUID: T+Q4B9PtSeaiD0zyK+WjNA==
X-CSE-MsgGUID: sqRr1n3dQ7C5lSSVJ1g95A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="238504442"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa005.fm.intel.com with ESMTP; 26 Apr 2026 20:13:25 -0700
Date: Mon, 27 Apr 2026 10:50:58 +0800
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
Subject: Re: [PATCH v2 19/31] iommu/vt-d: Reserve the MSB domain ID bit for
 the TDX module
Message-ID: <ae7PErLELqLHE4JA@yilunxu-OptiPlex-7050>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-20-yilun.xu@linux.intel.com>
 <BN9PR11MB52767F28E9FF692ACE69F3D78C582@BN9PR11MB5276.namprd11.prod.outlook.com>
 <aehkFicutMwa2LP+@yilunxu-OptiPlex-7050>
 <BN9PR11MB52763F59424C6E4AFD7F63988C2B2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52763F59424C6E4AFD7F63988C2B2@BN9PR11MB5276.namprd11.prod.outlook.com>

> > > btw in patch23 commit msg:
> > >
> > > "
> > > There is no dedicated way to enumerate which IOMMU devices support
> > > trusted operations. The host has to call TDH.IOMMU.SETUP on all IOMMU
> > > devices and tell their trusted capability by the return value.
> > > "
> > >
> > > which implies that ecap_tdxc() alone doesn't really report the capability?
> > 
> > Ah, good catch. Let me explain:
> > 
> > ecap_tdxc does report the capability. This bit is special cause both
> > trusted part & untrusted part access it.
> > 
> > For IOMMU driver (which now handles the untrusted part), it can directly
> > query to this bit and decide what to do.
> > 
> > But for tdx-host driver which handles the trusted part, it shouldn't
> > speculate into the IOMMU for capability enumeration. TDX Module has more
> > concerns about trusted capability, including the related I/O stack
> 
> I guess "more concerns" means that there are more conditions for
> TDX module to look at beyond ecap_tdxc(), so it's not appropriate
> for tdx-host driver to check ecap alone.

Exactly. 

> 
> > capabilities e.g. SPDM/IDE cap...  So in patch23 I actually mean we
> > don't have an enumeration SEAMCALL for trusted capability, I will
> > refactor that message:
> > 
> >     There is no dedicated *SEAMCALL* to enumerate which IOMMU devices
> > support
> >     trusted operations...
