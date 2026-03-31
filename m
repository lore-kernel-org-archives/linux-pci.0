Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931603A6B77;
	Tue, 31 Mar 2026 10:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774953167; cv=none; b=H99T3aw0mAGV/e6lnDzs8od6/777sm4MHs15J16QOPwNok4Xyijtv9jR2CCx+cTW+uyQTrIQ+WDJRuOtJgKweu3glA3D31Ni4JHAGmb/yqYhlqE+aMrHbURLvYWQRsFhLiMfbB1Z5o38L/o/F6JC4okXULLCkGi8vMa97+Jez9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774953167; c=relaxed/simple;
	bh=le09LlhpQMm2HEfzI07BhG5k3bOF1ETqPDTNe0QTR0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3XpPnveNmyWWh8JzzX6VDOrxZ9Dq6PtI2hL9cGjlVUfaQcwYNEQiRpAbiIcA6SxUkQh46t4IKaLPZ9lERcYyfcJLzyQ0jB1L4w3/wwyLzQlp9jZqFlEAbuLR1rHxMWjPz6y4SrAnevKhGOwZznteoY1zhN5uBbUdU+bJctXk/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nWT5aGGd; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nWT5aGGd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774953166; x=1806489166;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=le09LlhpQMm2HEfzI07BhG5k3bOF1ETqPDTNe0QTR0E=;
  b=nWT5aGGd6lUGyN5c+XO/sMNJBsFurN2ZN4UW/PcK/GvH9kWOai/dvTOd
   HXTE/6KOui9NMEzbU20Na1capf/FEJPPJZPUKNIl8/2ypod6Fyd40okss
   rqXFote7nj69yub6+3GtnJ0jfELoZw6omYjJ7ZX5mawi2aYVdP/cR5/Ji
   cvaXyYTVyB05fChZi/M+sP32EMkNPTJTSZm/xSzeYuTk2TpdzXH8uSKew
   gfVDsT6Qsi2UBSK4MzkWUwZ0JVPsx7PY54bVKgFpAnw4d3CrV89uT17yE
   QHqf/7DiwsqrGOeRi5CGND5QVTaJHfl15f9/ngQ5qHXw7KRhA6P+cSbMZ
   g==;
X-CSE-ConnectionGUID: wAxzgU9zRLOS6er/aa5I4Q==
X-CSE-MsgGUID: vIaRWO0XT5mLR8M8Cn3YWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="86656040"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="86656040"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 03:32:45 -0700
X-CSE-ConnectionGUID: zS2ZeGFaQQ6qRc6JbqTn5Q==
X-CSE-MsgGUID: hJN/JewWQaCNv6905GI5/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="219684521"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa009.fm.intel.com with ESMTP; 31 Mar 2026 03:32:41 -0700
Date: Tue, 31 Mar 2026 18:11:32 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "Gao, Chao" <chao.gao@intel.com>, "Xu, Yilun" <yilun.xu@intel.com>,
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
Message-ID: <acud1HzZX9IUUHWH@yilunxu-OptiPlex-7050>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-4-yilun.xu@linux.intel.com>
 <1dd0b8f4d1ad5cd07b5139ed8c944e1e1d004661.camel@intel.com>
 <acqbDVnd6gNJWmBi@yilunxu-OptiPlex-7050>
 <f163ab3b7c939a7d19864dfde9897ca3b424c60b.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f163ab3b7c939a7d19864dfde9897ca3b424c60b.camel@intel.com>

On Mon, Mar 30, 2026 at 11:57:11PM +0000, Edgecombe, Rick P wrote:
> On Mon, 2026-03-30 at 23:47 +0800, Xu Yilun wrote:
> > > pages is going to be an array of struct pointers, and root is a single page
> > > of
> > > PA's that gets re-used to copy and pass the PA's to the TDX module. Why do
> > > we
> > > need both? Like just keep an array of PA's that would be the same size as
> > > the
> > > struct page array. And not need the populate loop? 
> > 
> > We need Linux language, struct page *, for alloc and free. Also need
> > TDX Module language - PA list - for SEAMCALLs. So IIUC, the page to PA
> > populating won't disappear on allocation, the PA to page populating
> > would appear on free.
> 
> Not sure what you mean by this.

I mean host use struct page * for memory allocation and free. If we only
keep the PA list, we still need to convert PAs back to struct page * and
free.

> 
> > 
> > Besides, host may need to vmap and access the (shared) pages.
> 
> Some code someday may need to convert a PA to another format? Is that it?

No, I don't convert a PA to something else. PA list is only for
SEAMCALLs.

Now we use vm_map_ram(array->pages, ...) to map the shared pages,
that's another reason I want to keep the struct page ** in
struct tdx_page_array.

Anyway we use struct page ** for kernel memory management in several
cases, keeping the struct page ** avoids PA -> page populating.

> Doesn't seem like big problem.
> 
> But I'm not sure about this idea yet.
