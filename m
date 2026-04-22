Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D67C258EC2;
	Wed, 22 Apr 2026 06:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776840948; cv=none; b=vAzdjWDhTpojfiSB/X2DQXAT5Xo0DS36oenSzLiO6ctnRXBKwvvyTrBv8ZdgkL8IKpjvbf4czY6zbP0Imzxk6QVicQBEA/TCJ0Nfg8GKt8v/IYSg4jA8obpFrv1Cr5ZZik5RwfIXGONfNL2HquaCymfEPKR1qfK6+jcrNVnb2lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776840948; c=relaxed/simple;
	bh=JjXhlWicHxG0hmwFHxjedLe/9O+tWbIe7LbrWuwawjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X7nZ8BB8KF+KQmkhzIznmKqEeap+cJDpy9pexmtdzg8OLHwKIhUu2yrnvxoxUBB1k3iYYPNUYtZ1fCHmde6EFF9XYdn/p8lcEZ+Hg2TcW+KEAFy+R6sXvsw1/uVmcxJ33Sy7bL+xOQ6hlUPbxjXPjIJhADG759EqpwaiEh+RHUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QOeUyL/f; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QOeUyL/f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776840947; x=1808376947;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JjXhlWicHxG0hmwFHxjedLe/9O+tWbIe7LbrWuwawjc=;
  b=QOeUyL/fIYgutCWF1CTGVHWnx9PyZ3V5JwsnZwjD1WZkScPuvILkv4KB
   A+wf7Zmb25i9XBTfBkpZayT/jdGw1pRvBRkZUQWPuk0oH1qsb03AUUUXE
   cffAyLT4gZQ+nGoA2SYEK9GZS4eyMpMl0lLNzLveI1eAGNbR6pj6aPx+4
   M2xf980ahfkBZqW4p64pozLOWJmnKi0P2M2nZP0d7pg8LSYTin0B5jUsb
   xhin04h1GgcxlEc/sRHncIxyLPZu6GQZJN539wSIWCjCC41C8ODrs1R9X
   Qo1ZsIBmHQo+RiLxaGONJwhxSsderv5NIy+5/G8JIw4InEiSKe49b484A
   w==;
X-CSE-ConnectionGUID: bUiYaD2ESBCbv/RFpOqglw==
X-CSE-MsgGUID: V6qdTbFqT9+hUoYX7TO2hQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="77663790"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="77663790"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 23:55:47 -0700
X-CSE-ConnectionGUID: izDu9szgSiuairFMvJ/KWg==
X-CSE-MsgGUID: 5cZ8DhgrTlqCo+OVAQID1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="237309302"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa005.jf.intel.com with ESMTP; 21 Apr 2026 23:55:44 -0700
Date: Wed, 22 Apr 2026 14:33:30 +0800
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
Subject: Re: [PATCH v2 22/31] iommu/vt-d: Export a helper to do function for
 each dmar_drhd_unit
Message-ID: <aehrup2/IWdq62mm@yilunxu-OptiPlex-7050>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-23-yilun.xu@linux.intel.com>
 <BN9PR11MB527698CD6C350B371C47540F8C582@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527698CD6C350B371C47540F8C582@BN9PR11MB5276.namprd11.prod.outlook.com>

On Thu, Apr 09, 2026 at 07:49:46AM +0000, Tian, Kevin wrote:
> > From: Xu Yilun <yilun.xu@linux.intel.com>
> > Sent: Saturday, March 28, 2026 12:01 AM
> > 
> > @@ -86,6 +86,8 @@ extern struct list_head dmar_drhd_units;
> >  				dmar_rcu_check())			\
> >  		if (i=drhd->iommu, 0) {} else
> > 
> > +int do_for_each_drhd_unit(int (*fn)(struct dmar_drhd_unit *));
> > +
> >  static inline bool dmar_rcu_check(void)
> 
> It's a bit weird to insert it here. Move it to follow for_each_iommu().

Sorry, it is following for_each_iommu(), is it?

> 
> > +
> > +int do_for_each_drhd_unit(int (*fn)(struct dmar_drhd_unit *))
> > +{
> > +	struct dmar_drhd_unit *drhd;
> > +	int ret;
> > +
> > +	guard(rwsem_read)(&dmar_global_lock);
> > +
> > +	for_each_drhd_unit(drhd) {
> > +		ret = fn(drhd);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +	return 0;
> > +}
> 
> use for_each_active_drhd_unit(). or is there need to setup the trusted
> configuration even on ignored iommu?

No, for_each_active_drhd_unit() is good.
