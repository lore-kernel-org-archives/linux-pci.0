Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9093D39F181;
	Mon, 30 Mar 2026 07:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774855747; cv=none; b=H/kAhzVuaSBTPZgolCWAELSvEjdEH4CQZ+4XU+CpmR6dNsBYhe6i22o+gzpyz2X32Uq6GeTG2q6/sGZtuQSvemCyqlJJGNud2ma2G1RaTpWd7VFcQ4ABxPMz0Q7NGUo2mZwHTk4SCkN5Oz3NYgxTEt0e3n/MyPs3k+9NV0DttuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774855747; c=relaxed/simple;
	bh=QnBO0AjRrhP0nBM8sejbJ+L+SSv54v6NAzivCt5OfiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQzX4eIi7Po3f0kZsjWOVDn9/wQFLiQiSvVTIUNoh96n8G/vINOlHSLROicEtrwqxiUM3EXn6YQ8axUXGyZ/YU3GUPwmdEsq2aHtEDTdpZ74jktJABXfVR3nEALzv3ndie798hH76V6kzVKuBCQKM/4LkPnP1y39bj4jvTc8MS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RvBUyHfo; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RvBUyHfo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774855746; x=1806391746;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QnBO0AjRrhP0nBM8sejbJ+L+SSv54v6NAzivCt5OfiI=;
  b=RvBUyHfowhFTvZbLafkT/jUNNO+xb5Ud8PczEzhK0nijz/TulhJ5+rTs
   KKnEO95wG6punLP0k2gGZVf6SXki5BIZP+ZNIKO9Vthdf+oZb0apGrUMd
   nEGR068NBaqopLQi1bYHoq+fxbc66r/2nxY/pYvz3jAbP2jBNn2BNUhHC
   pB5ejLd7RGB09xN8Jksa/lkxGtY/t74t7iH1LrpwZmSRABQSTAD/1+BzS
   lW5G1VzrIXeZaxJHZ8PYQueJ2jVIgtBz8jmHh8iweod/2ZtD4wf5wYfEt
   F+OE0VSvhjohHv5IdWemJND49/rRrm8NaxHJbDxbIP+O1I4+p9vD5gsEQ
   Q==;
X-CSE-ConnectionGUID: JRJZg9zPS+6mdJyDELEpfw==
X-CSE-MsgGUID: f7KeGFqGQOOYrwnAgFk5WA==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="75737399"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="75737399"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 00:29:06 -0700
X-CSE-ConnectionGUID: GHIFqX98TpmqWIzJgS0I+g==
X-CSE-MsgGUID: 2mXUlfQ9TEK0AIx7ny+hTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="230037968"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa003.jf.intel.com with ESMTP; 30 Mar 2026 00:29:02 -0700
Date: Mon, 30 Mar 2026 15:07:56 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
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
Subject: Re: [PATCH v2 01/31] x86/tdx: Move all TDX error defines into
 <asm/shared/tdx_errno.h>
Message-ID: <acohTAth5yqXcEHq@yilunxu-OptiPlex-7050>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-2-yilun.xu@linux.intel.com>
 <a78f0ac35b137eed6306dd7ad8db37dd9d930aac.camel@intel.com>
 <69c72bdec3ce8_178904100bf@dwillia2-mobl4.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69c72bdec3ce8_178904100bf@dwillia2-mobl4.notmuch>

> In this case, for the tsm.git#staging branch, I will replace this with a
> fresh application of this:
> 
> https://lore.kernel.org/all/20260323-fuller_tdx_kexec_support-v2-1-87a36409e051@intel.com/

This is the exact patch I picked, but Kai's RB is in previous version

https://lore.kernel.org/all/20260307010358.819645-2-rick.p.edgecombe@intel.com/

and b4 didn't catch it. I think should add his RB manually.

> 
> Yilun, going forward, if you borrow a patch from another set, be sure to
> both add your own signed-off-by, but also a:
> 
> Link: https://patch.msgid.link/20260323-fuller_tdx_kexec_support-v2-1-87a36409e051@intel.com
> 
> ...to make it extra clear you are including a patch that is already on
> the list in another set.

Yes. I listed the link in cover letter, but yes add it here should be
clearer and necessary.

> 
> I suspect that by the time this set is ready to move from
> tsm.git#staging to tsm.git#next a stable commit-id may be available for
> a rebase.
