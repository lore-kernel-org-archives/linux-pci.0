Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B8727B340;
	Mon, 27 Apr 2026 04:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777263447; cv=none; b=YP16TtoPeGe2Yf+dx00NVFlD0wOG3dSgKfUF62fIRwCaHk8I149p7abdr0q/laDuhQaChkq6oc+1jigjnEaAoQHtYjyPF2zStdlfbw9PGcE9ZOqsVE3y9goOYpm4lmda1VQxIFTs2U+OZWO2e2AxF4jxEvdWqHNyKZmB/BrvQVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777263447; c=relaxed/simple;
	bh=cO6WJvmGQL4rJFN4/VYn6S1ENlMx+AdqGU8pNE9VnPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4QgH0vIdnBLoQkuj9lVRyGMWdn92hTIV+qP+4T0PTrNZWkG/Hn/R++/D5tjz2vd2RarIl4RBfjynv+LCyZaTVO2Q1JWmT8BlwyVw+BjU/vbBb6nVb12DWEXo5RUjYHnwgyzsVpTH9WBi7TXp/0CoJAYSnuZ8WqwyVPXcvHAXN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iQoJVHT8; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iQoJVHT8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777263446; x=1808799446;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cO6WJvmGQL4rJFN4/VYn6S1ENlMx+AdqGU8pNE9VnPY=;
  b=iQoJVHT8AoVVwa472bSfPc8WH0PDn7Y9yxCdBLkt9gCoj6UUN0tNXcNJ
   rCajNmco1l8UauiqD2ZhFpo5GfdKOvuriJVpCteRfEJlYA3YB4zlHb9qv
   8nJlh1M1UgIBYe3QLczjwQEreje1+oEBOznPiuQ7PdvEjaSUX1gsTLf9w
   RnqvrEKzIkM3j9Fszp7sBmJKD1NvJmS7fqShelOEhQNpT0hdS9SAjQedc
   vugY21yGQ1kMXJPlBX7RGcuH1mqFe1NPWayRX9xGzmub2FLP6CvZxxg3G
   xJAwRYc91S+ZRDIRTCYN/swckHyZlP4WZae3PJXkjJ7xn3uwHAHvUY+xw
   g==;
X-CSE-ConnectionGUID: FuoycizXR9Ct8/tTFzeK2A==
X-CSE-MsgGUID: KD/exbStSRySDZg4Lo+G0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="88745800"
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="88745800"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2026 21:17:25 -0700
X-CSE-ConnectionGUID: IRNH05ULQU+ZqmAHqv06gw==
X-CSE-MsgGUID: oZRZfy9ZRpe79cRakMiFdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="226987610"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa009.fm.intel.com with ESMTP; 26 Apr 2026 21:17:22 -0700
Date: Mon, 27 Apr 2026 11:54:54 +0800
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
Message-ID: <ae7eDgujuIEF6G08@yilunxu-OptiPlex-7050>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-31-yilun.xu@linux.intel.com>
 <BN9PR11MB5276BB48433E1AF97E5D27298C582@BN9PR11MB5276.namprd11.prod.outlook.com>
 <aeibi7JzfZ2Kx0NU@yilunxu-OptiPlex-7050>
 <BN9PR11MB5276DBD859A8122620EB86CE8C2B2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276DBD859A8122620EB86CE8C2B2@BN9PR11MB5276.namprd11.prod.outlook.com>

On Fri, Apr 24, 2026 at 07:05:32AM +0000, Tian, Kevin wrote:
> > From: Xu Yilun <yilun.xu@linux.intel.com>
> > Sent: Wednesday, April 22, 2026 5:58 PM
> > 
> > On Thu, Apr 09, 2026 at 08:02:33AM +0000, Tian, Kevin wrote:
> > > > From: Xu Yilun <yilun.xu@linux.intel.com>
> > > > Sent: Saturday, March 28, 2026 12:02 AM
> > > >
> > > > Implementation for a most straightforward Selective IDE stream setup.
> > > > Hard code all parameters for Stream Control Register. And no IDE Key
> > > > Refresh support.
> > > >
> > >
> > > 'more straightforward', compared to what?
> 
> a typo.
> 
> > 
> > Actually it is " *most* straightforward", I just mean "very".
> 
> When you say "most straightforward", then I want to know what are
> other options to compare. If you think that the thought practice

OK, I think the use of "a most" is somewhat misleading. I don't want to
emphasize on comparison.  I just want to give a summary about the
implementation: hard code all parameters, give no option for
configurations, no optional features supported e.g. KEY Refresh.

So is it better I just s/most/very:

 Implementation for a very straightforward Selective IDE stream setup...

> leading to the 'most' definition is important, then please elaborate.
> 
> otherwise I'd just remove that sentence.
> 
