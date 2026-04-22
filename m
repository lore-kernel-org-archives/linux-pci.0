Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE203542E5;
	Wed, 22 Apr 2026 10:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776853192; cv=none; b=ri/TvRAzj4XcckBNi/Grb97DUKwbIFV8gXo1HTyWjdJ9nzkQm9XIx8ACITs/6QwdklKC5C1dGQW94b/mdXN+V3LWpXeQaTwN/n+wC5rG7yJWm7VmO8yPnY3LLYIq4bKA8werrAjiH+uAnDx4sTrdUbamY71i8boMiyVeifHLj2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776853192; c=relaxed/simple;
	bh=RYQDqtGxjhv7K4s8pHKgwi4zGSUkmTBG3WhMUrxGSa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVOqFQ0c8J0E7x6/fSKbE/SeVylNjWAsczuA/SwsZ26sqeLVgpry5o2JR0C272s8Dz9HJy7bMqM0+Mw6zXEbHIdhzPbK63Tmtx1oA8CL7tgmLZMLNxSUkWeCByewjEjOWfT2pZbAC2MOV4kZS+qKxTa3j6JWUgQgy6VC4/ZnPoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=chJVT3Iy; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="chJVT3Iy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776853191; x=1808389191;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RYQDqtGxjhv7K4s8pHKgwi4zGSUkmTBG3WhMUrxGSa8=;
  b=chJVT3IyG+3DRHJ86bz4iA88rsRIlQfecJh9/M5GSg3eR4Av4zvnYZW1
   g/dDIs1TqEMWnTPxXEwkuARs7LgTbrBgBtxEYNWzQvYuBS0ZHth3p0Rt5
   dJUG8/ohOHftoRO5bAFMnnMpxAZZA8opPNlxbGzS9HUqxj/9WGjTuOaEN
   KZ79UczntJjtQITpX9K+d1dsBzYnFW0NqepL/nJcfSuISP1zocgBqc4H7
   EuwRj/TRizMXzbF78gAOlKlQ5kOWjQnT8fQZBKItNr/iDCMmfNNeHKF67
   vTvvMgdXhdNp78K3rI0CD9CDevXdGFKMrcTkqKkksfzBJrnvCv2R8q4fh
   g==;
X-CSE-ConnectionGUID: x0p3a7VBR3mlUy8nf2bLXA==
X-CSE-MsgGUID: 2qJDe5JmTNiJ8j1ZmOOwbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="77679228"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="77679228"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 03:19:49 -0700
X-CSE-ConnectionGUID: P2gYsQRtQVSoKuvREvJWeA==
X-CSE-MsgGUID: 0ySYhr/kTnyRrOzI8GGvHQ==
X-ExtLoop1: 1
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa003.fm.intel.com with ESMTP; 22 Apr 2026 03:19:44 -0700
Date: Wed, 22 Apr 2026 17:57:31 +0800
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
Subject: Re: [PATCH v2 30/31] coco/tdx-host: Implement IDE stream
 setup/teardown
Message-ID: <aeibi7JzfZ2Kx0NU@yilunxu-OptiPlex-7050>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-31-yilun.xu@linux.intel.com>
 <BN9PR11MB5276BB48433E1AF97E5D27298C582@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276BB48433E1AF97E5D27298C582@BN9PR11MB5276.namprd11.prod.outlook.com>

On Thu, Apr 09, 2026 at 08:02:33AM +0000, Tian, Kevin wrote:
> > From: Xu Yilun <yilun.xu@linux.intel.com>
> > Sent: Saturday, March 28, 2026 12:02 AM
> > 
> > Implementation for a most straightforward Selective IDE stream setup.
> > Hard code all parameters for Stream Control Register. And no IDE Key
> > Refresh support.
> > 
> 
> 'more straightforward', compared to what?

Actually it is " *most* straightforward", I just mean "very".

