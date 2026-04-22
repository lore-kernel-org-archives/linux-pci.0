Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484013C276D;
	Wed, 22 Apr 2026 09:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776851364; cv=none; b=b0hKzoysKw2E55tyczdlljFkLGmUNYtVFM7oPMLrsJWWRzbSnAFqX2aVomLFR4wl0JVs9SrzK+LKsM9pvWWEiCc+sWPrZ+R2Tt/mxyZ6RzQaTVoRMDDgOC/cOE+oXIZ0UaGqLHIN/O2WILJv2VuWP3mUSErKX7+6prXQeyMt6Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776851364; c=relaxed/simple;
	bh=ultWxa7WdCoSQYIpbTwwdH0/chhusx4Nxhnep0Jmpzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CV8YYi6R7rO2CjOFI4TxZS+Yqnr4LctnBhDU0WR7ZBGXGeGsgcFGmdlZqoNLH4vI6DSYIDIUsh9MloQKYGgGMwmlVU5k3EEhga9+oBNfOlPFCEbZ8j0spSguoLd35oxUfL8pN7ZFYigk60nN9DTV24huK8N6E5pgeeJJLKj3/ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HZhw6MNY; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HZhw6MNY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776851364; x=1808387364;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ultWxa7WdCoSQYIpbTwwdH0/chhusx4Nxhnep0Jmpzk=;
  b=HZhw6MNYC74YQG3+YzUT5rAi+fkFm4w4lGxFjsOC4bNbiUIiCZ5G/Ryn
   6ZtcvJ7YOYVGi87CVO3/9v8isis8SF/9Spr+IvYsUJiew2S8KRn5vIrQU
   08rQHIp2aZzBDBCTDvcZMv9c9LLqRzzFzDfhQiG+9rsvnXAsKNHubTWwE
   bbTSxxtKIDmQgyLtGGEcAk/J/63XgAgVcRXHPs2HdiOtCRwMjsODo/fgE
   H8EZyKwpx5U/bNskiMqkeg5Y902He6TEcSVLWC2+DOZIksBi4H6ilbC1R
   mDX0MY3mgmtCqmdLR8sVQvGdlwZAFY+kHNE6X3fsvcXvZy1ZVFa5UxR7e
   Q==;
X-CSE-ConnectionGUID: 33cJE1HhT+KeyxWetgRt5Q==
X-CSE-MsgGUID: 9e7DkHKATcCG0mGR6HMcHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="89187229"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="89187229"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 02:49:23 -0700
X-CSE-ConnectionGUID: 93l4kKytRFe9TaVrAF2kSA==
X-CSE-MsgGUID: f/uyBA9kRxqBr2DnPA5UUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="255569002"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa002.fm.intel.com with ESMTP; 22 Apr 2026 02:49:19 -0700
Date: Wed, 22 Apr 2026 17:27:06 +0800
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
Subject: Re: [PATCH v2 23/31] coco/tdx-host: Setup all trusted IOMMUs on TDX
 Connect init
Message-ID: <aeiUartvxzsvq2Ye@yilunxu-OptiPlex-7050>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-24-yilun.xu@linux.intel.com>
 <BN9PR11MB527640A3D76B66DCE5FFA58C8C582@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527640A3D76B66DCE5FFA58C8C582@BN9PR11MB5276.namprd11.prod.outlook.com>

On Thu, Apr 09, 2026 at 07:51:56AM +0000, Tian, Kevin wrote:
> > From: Xu Yilun <yilun.xu@linux.intel.com>
> > Sent: Saturday, March 28, 2026 12:01 AM
> > 
> > Setup all trusted IOMMUs on TDX Connect initialization and clear all on
> > TDX Connect removal.
> > 
> > Trusted IOMMU setup is the pre-condition for all following TDX Connect
> > operations such as SPDM/IDE setup. It is more of a platform
> > configuration than a standalone IOMMU configuration, so put the
> > implementation in tdx-host driver.
> > 
> 
> not sure what above tries to tell. why is it a platform configuration
> when you have seamcalls on each IOMMU?

This is to say the TDH.IOMMU.SETUP relates to PCIe SPDM/IDE, it is not
just about IOMMU. By identifying the

  for_each_iommu(iommu)
	tdh.iommu.setup(iommu)

as a platform configuration, it justifies why we trigger this
configuration at tdx-host driver probe, rather than in some
IOMMU/IOMMUFD API.
