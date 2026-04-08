Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FB53644C3;
	Wed,  8 Apr 2026 06:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775630348; cv=none; b=s5MRqoNuePE5ufDsNZ/6v06eNtPVJIgWA+IqgbEaSNMPhgYQfJYyEoeUYnp3A8v80OkqCSGXKYaWKhQjbOtmXCvJhQLaZoJ0RP1Vw/2/kTuVkHGOWzj/gHZo1aNl1chfIe3ZQUlY/cxUDM8ypUIGYFUb3B1/nAboS4r1X+2umhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775630348; c=relaxed/simple;
	bh=gfNGQ5QjHhh5D3nMxQxPtsK5nwXzJaRB3AosQTY0GQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SPOQWq+qXJrs3mW2z2N9XpWVwR+Qx8sbHFixtBgSqfI8xizXoT6Jjtc98Jk2y/iCFE+FR1gObAfVzLRVwLTBMFwv1GPfuWqmdqOl4xWFQBb6h+l5ZKwYsmJRkA95T6HfcC84xp9MWqxVywr18kPcv2dzGDrVNre6tQKsMXYUPEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T+tNxtyL; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T+tNxtyL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775630347; x=1807166347;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gfNGQ5QjHhh5D3nMxQxPtsK5nwXzJaRB3AosQTY0GQk=;
  b=T+tNxtyLI31ER3jlNqXSeHXfgON+v6gN/Ae7+0lE/Xcpv3ZTwmbqIjki
   OOtaLA5HlbagAtL7PnqtkL2pVwy2Ltf24LQiMg8ld+ET5mjGLFOI95sZs
   rma8LTG2xCwlDhowvJAHDf6bhZjn/zcZyJ69B5cHcGSdbEXO/pm3RDoQj
   rEaH3RBj6F4Q5goq/UtNmJDEIwiHHZxzwpRk3Qian3hT/ZsSPd8hvlP9E
   3oig7tHn/V9oPDhl64Jby2rrBREfxBqyFnqk0WUgAd0LIDrf6aqFRG3fo
   HR0o0grNmfNp18MyRHVj6wscVXExeFXpKGare0YmxRiNO8Eljxc84jI3c
   g==;
X-CSE-ConnectionGUID: MsRy075RTYy2odXLtPhj9A==
X-CSE-MsgGUID: j9sY16+1QTSwNDQculGw1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="87303576"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="87303576"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 23:39:07 -0700
X-CSE-ConnectionGUID: PTqeNjZ1Tg+5CCFgVSdFIw==
X-CSE-MsgGUID: 3sWgQKr4QraK0pO2vtTxUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="233340257"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa005.jf.intel.com with ESMTP; 07 Apr 2026 23:39:03 -0700
Date: Wed, 8 Apr 2026 14:17:30 +0800
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
Subject: Re: [PATCH v2 06/31] x86/virt/tdx: Read global metadata for TDX
 Module Extensions/Connect
Message-ID: <adXy+unvDJDytU1Q@yilunxu-OptiPlex-7050>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-7-yilun.xu@linux.intel.com>
 <123290f2bd1fb9c98bf494650c5912a3bf080114.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <123290f2bd1fb9c98bf494650c5912a3bf080114.camel@intel.com>

On Wed, Apr 01, 2026 at 09:36:18PM +0000, Huang, Kai wrote:
> On Sat, 2026-03-28 at 00:01 +0800, Xu Yilun wrote:
> > Add reading of the global metadata for TDX Module Extensions & TDX
> > Connect. Add them in a batch as TDX Connect is currently the only user
> > of TDX Module Extensions and no way to initialize TDX Module Extensions
> > without firstly enabling TDX Connect.
> > 
> > TDX Module Extensions & TDX Connect are optional features enumerated by
> > TDX_FEATURES0. Check the TDX_FEATURES0 before reading these metadata to
> > avoid failing the whole TDX initialization.
> 
> Maybe it's better to split this patch into two, one to read generic "TDX
> Module Extension" related global metadata, and the other to read TDX Connect
> specific ones?
> 
> They are logically two separate things anyway.  And there are other features
> also need to enable TDX Module Extensions (e.g., NRX for migration), and we
> can just reuse the generic metadata patch from this series.

Will do.
