Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464D73A5E62;
	Thu, 23 Apr 2026 12:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776946865; cv=none; b=syAnH4zxphu2NDceTWFLUnSsM8lRShF9hMMuYP/e7zyzUfSrwMxJUdkPYYQWoKcGglXVuVx15tFYpqzNY6xieoSmB+lSK1SQMaVXgRNC0wqPpZz1htzBp+UmDduEtp0eo/7ug7L3TWe3iyyZOR9DnIh8joEXeXAupyQ4dDga04A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776946865; c=relaxed/simple;
	bh=9vX8M4xMjcTWYrCOwYDAFRogS36VuvNkR+NBI9imW6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DRxfCtkFVoMHbmF9WFu3FRZ6X7///iKlAd2hbmSLIAx1mLcIzynKnDWDNDtjqEeSZR1e9OskpQJk9agX1fnEdVQzQm2hHNgYEH+WsW5Ai9BkRSWRZTKmL/6Qu9te59GiPYtg19e1/D6o1RU9PMbBZYHJ81oD6+mfl7lUP0J4P+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aBIwqBOQ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aBIwqBOQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776946864; x=1808482864;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9vX8M4xMjcTWYrCOwYDAFRogS36VuvNkR+NBI9imW6Q=;
  b=aBIwqBOQQD1BhnIWzd/JnBjzYrni9ZnEG7+y1aQ1db7UtZnZ+Y+bFChQ
   BMhJp/5sQu/JbSJXFk1zn9jRPojxMz54W7p2N8D1/cypKJ+3zwCktpsYg
   wjC6XitWHo6Be6Nkvo4T358JYzexJyQM1uKZLIbo+5BK+3IUSn4A1Cpdc
   LJuiKux1llNnE9KIoysnO1Yyr7AYleyJz7sMqWNoAOLtjRWeqevaMgO/1
   pj7sUaFzHUyqWzghR+DcE2An1Yn2A+MULB5yppW8+xIiXYnhJ/GARaU+5
   xFtOnd3v1/jdrEf1OqE9NYJXHyiJEPvd6Ksn5diIlGzYMwCy4o1HCfNkn
   g==;
X-CSE-ConnectionGUID: g4/Pq0iQQqaGIt7ozmmhwA==
X-CSE-MsgGUID: M+VWZsaeS8e5sfkASUOYNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="77975637"
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="77975637"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 05:21:03 -0700
X-CSE-ConnectionGUID: OP7QmNhNQvS8srQRLkMADg==
X-CSE-MsgGUID: pj/gSRnBQMusJYYNDDiCKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="231613964"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa006.jf.intel.com with ESMTP; 23 Apr 2026 05:21:00 -0700
Date: Thu, 23 Apr 2026 19:58:43 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Dan Williams <djbw@kernel.org>
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org, x86@kernel.org,
	chao.gao@intel.com, dave.jiang@intel.com, baolu.lu@linux.intel.com,
	yilun.xu@intel.com, zhenzhong.duan@intel.com, kvm@vger.kernel.org,
	rick.p.edgecombe@intel.com, dave.hansen@linux.intel.com,
	kas@kernel.org, xiaoyao.li@intel.com, vishal.l.verma@intel.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/31] x86/virt/tdx: Read global metadata for TDX
 Module Extensions/Connect
Message-ID: <aeoJczEza936bLO3@yilunxu-OptiPlex-7050>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-7-yilun.xu@linux.intel.com>
 <69e7f808e9aa5_fe0831004@djbw-dev.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69e7f808e9aa5_fe0831004@djbw-dev.notmuch>

On Tue, Apr 21, 2026 at 03:19:52PM -0700, Dan Williams wrote:
> Xu Yilun wrote:
> > Add reading of the global metadata for TDX Module Extensions & TDX
> > Connect. Add them in a batch as TDX Connect is currently the only user
> > of TDX Module Extensions and no way to initialize TDX Module Extensions
> > without firstly enabling TDX Connect.
> > 
> > TDX Module Extensions & TDX Connect are optional features enumerated by
> > TDX_FEATURES0. Check the TDX_FEATURES0 before reading these metadata to
> > avoid failing the whole TDX initialization.
> 
> I think it is important to distinguish "optional" module features vs
> required Linux features. Linux requires all features that a module
> advertises to succeed at core TDX init time.

Agree. But I want to reduce the scope to only about metadata reading in
this patch. So:

    TDX Module Extensions is an optional features enumerated by
    TDX_FEATURES0. But in the implementation, Linux requires that all
    features that a Module advertises must have a complete, valid set of
    metadata, and the check must succeed at core TDX initialization time.

    Check TDX_FEATURES0 before reading these metadata. If a feature is
    advertised, a failure in reading associated metadata causes the whole
    TDX initialization to fail, otherwise skip.

> 
> Otherwise, this looks ok / consistent with other metadata reading. It 
> sets the precedent that if TDX Connect is advertised it must succeed all
> core initialization.
