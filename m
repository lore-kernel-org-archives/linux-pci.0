Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19678175A96;
	Mon, 30 Mar 2026 07:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774855900; cv=none; b=bjlkOivsJCuAlAeyyjU+97Suvi/gLziZF9yqEl8Xb/UBSDLss2uXuyh5PS/PQh5kRmE7a2MtOdc3FTNcFB9I52Rqp8SyuVmLeEuwz4mESV2xLSpKpZ1JCQxvnQEPa0Q/D8hHmTMy4JfHxQFWfkj0dCam1IVS+36iQ+NfKYorOGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774855900; c=relaxed/simple;
	bh=c/rMpV9IvK5o7i+Dqp5d7DXROYsKkHh+wmyTeT4H1Lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eKck1Up0/cfK2xHqURybKzKbDu1tW7crAnmBRsLD5kwzUVnMURBIchG2foLdRfAQ42hr0PsiFWYBKwHLUMzUQTqlKzj3eYPBoC/AhE85jHqQQVa3xGAMDd1sS8DaL9P23GeEvcRb9IQ+3KerycQfxaspmGHDBgoCu4dj2V5CI7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aT1IoHNQ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aT1IoHNQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774855899; x=1806391899;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c/rMpV9IvK5o7i+Dqp5d7DXROYsKkHh+wmyTeT4H1Lc=;
  b=aT1IoHNQ5FPzIkOIrjXhGePyyWnxfTFjt89F53TpBxEqVgjEfyJLcxAR
   BNq8YPsZ3XZ+Ge1weWiZ142TXRby/YVJwiO2azRpoQjI/pAGRZG+hg1Lq
   2GfHkRu7iWUlLgHVbQjwC64/77m4R+htPQy1zEgiNQ0P8JeAvjCzQN/n+
   gtM9fHEhudWK8smb5lMLOUZpyg2VzpzdOPo+f0ZL/9xQ3FjrA/wSaczq4
   Unr+7mYSNAQBHE35jR3AgHHwP+BQVtuRpJdGKfIq48Jmr1W76GKAbhEOh
   5TXkTIG6FW8W7oiZN6WfIzFNozjnuhe1etGVT035Rvs01ZLr7olj4rKnX
   w==;
X-CSE-ConnectionGUID: DxiCIHpJQwKbQ+ZwkTQ1dA==
X-CSE-MsgGUID: xQ9xnDW4RbiLrn34IJlwkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="79442738"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="79442738"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 00:31:39 -0700
X-CSE-ConnectionGUID: kGphVsi0TLuaYfpyvY09UQ==
X-CSE-MsgGUID: a9xYO6+CTuK8aQe9zMifoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="223110347"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa008.fm.intel.com with ESMTP; 30 Mar 2026 00:31:35 -0700
Date: Mon, 30 Mar 2026 15:10:29 +0800
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
Subject: Re: [PATCH v2 01/31] x86/tdx: Move all TDX error defines into
 <asm/shared/tdx_errno.h>
Message-ID: <acoh5RwfPyEvbqQv@yilunxu-OptiPlex-7050>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-2-yilun.xu@linux.intel.com>
 <a78f0ac35b137eed6306dd7ad8db37dd9d930aac.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a78f0ac35b137eed6306dd7ad8db37dd9d930aac.camel@intel.com>

> I think it is missing Kai's RB from sys disable v1, and your sign off.

Ah, yes. I picked from the latest post:

https://lore.kernel.org/all/20260323-fuller_tdx_kexec_support-v2-1-87a36409e051@intel.com/

But didn't realize the older thread has different RB set and b4 didn't
catch, will add it manually.

I'll also add my sign off.

Thanks
