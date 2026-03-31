Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFD7385509;
	Tue, 31 Mar 2026 06:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774938326; cv=none; b=eDR/Y6pkIRbIuOlbsTyFzJecqcGhIOL+jNWvUiaOJTNLu7Ly25GrYx5TpOZac0Ss3TN+8wkBrw+Cok7YTe3QYtCZcITZMoL5imrfajDGtRZgKKnaj8TzDP58eqrKF2Gtx+63okK/GhHZ+zFrVBhA83G5gTzgKi2TefpmoUPlsHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774938326; c=relaxed/simple;
	bh=UhU7giXO/4/XwBFR6g8fWJ7VGxRAyzkloQXuM0newp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uh9iAm0cP+jCBtHFiyW65kKw0vf9JDFoSOoRDvkNP5RLpYLra8BzmbkGuGIeucaBwbl6XG8+xYZkSJfJ5OaemJnKVU7piBUqG4ZSUR/CObhlfI2eFKOvP4HvqBptqnd5AlqW+XP30vQd8iexjY+c4u8ZsXvqnLBf2wMJ72swmAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JIJqMTqc; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JIJqMTqc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774938325; x=1806474325;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UhU7giXO/4/XwBFR6g8fWJ7VGxRAyzkloQXuM0newp8=;
  b=JIJqMTqcigYqZ4Eud9yagVb/2T11uWktERGIwnUiGI4OXGxmu7RqAGFw
   GJmBX8wzVC6b8a43XfETguVArlepqFsD80V1nyudbxoWG+azwNzlhRKI1
   aOu3HPvkulWYAZUN/YJc17dgstr1IvZZkA7Ubp2UmX6Nss1BAMlgeKRaC
   xkgjXAHwf2WiyxtBTQ8e1lpp8XVSMdASkv8nRjov/+mn7x6d/BTm1QXxH
   fv/9H7MuTrBEJSaN9jQMjuuBNu5QNLrsE/V7EYTjPTKb3C51XHD840wwC
   MZ912O3wKqq48ueO/3rOj+VXpampiz2FpmK4VvhFUU1zSWMf/aoj9l6Gl
   w==;
X-CSE-ConnectionGUID: nxTn2hKmQb6q2XineSpcKA==
X-CSE-MsgGUID: 43oM8jYgSlGh31WcSgvqUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="98548904"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="98548904"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 23:25:24 -0700
X-CSE-ConnectionGUID: fDCrYkeNTcCE7MyMjV2QuA==
X-CSE-MsgGUID: J2lxHIqFQlSV8pOohhyOfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="221402278"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.246.52])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 23:25:18 -0700
Date: Tue, 31 Mar 2026 09:25:14 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>,
	"Gao, Chao" <chao.gao@intel.com>, "Xu, Yilun" <yilun.xu@intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"kas@kernel.org" <kas@kernel.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"Williams, Dan J" <dan.j.williams@intel.com>,
	"Jiang, Dave" <dave.jiang@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"Verma, Vishal L" <vishal.l.verma@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH v2 03/31] x86/virt/tdx: Add tdx_page_array helpers for
 new TDX Module objects
Message-ID: <actoyocXRKv8_Kcc@tlindgre-MOBL1>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-4-yilun.xu@linux.intel.com>
 <1dd0b8f4d1ad5cd07b5139ed8c944e1e1d004661.camel@intel.com>
 <acpPsPivfllpWfv1@yilunxu-OptiPlex-7050>
 <23b92a154c859450d106de6c9badbe284e3aa19f.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23b92a154c859450d106de6c9badbe284e3aa19f.camel@intel.com>

On Mon, Mar 30, 2026 at 11:25:08PM +0000, Edgecombe, Rick P wrote:
> On Mon, 2026-03-30 at 18:25 +0800, Xu Yilun wrote:
> > Yes in POC code we do write dedicated code for each type, but it ends up
> > with plenty of similar logics on caller side about root page
> > manipulation. By now, the differences are not much, but I think we
> > should not write copies for every type, we should stop new types.
> 
> Hmm, doesn't it seem like this is quickly becoming complicated though, to
> combine all the different types together? And it seems there are more coming
> that people want to add to this.

Most of the list entry types are the same with just some bits unused.

Regards,

Tony
