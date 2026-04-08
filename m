Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394043AC0FF;
	Wed,  8 Apr 2026 08:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775637988; cv=none; b=pWg+XjwFTjzBQyZGi02mAsZbB4m/BiLhuUdM2k7BKlZEc20XmHAoVqVpX/EXRGnzFv2yaJzyr5tEkAieAmcJwKkjePFWYaxNYUWTObilyG/PAtnuXFuzo2Ne/7A5fgHTcQF2LGYiUxsZkt2F8cZGB87T/AIY0u1AL+1/L++01xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775637988; c=relaxed/simple;
	bh=91maVxZNEzGhFKlBZ9qtc86KCdBoWXk2N2q/VDGazBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n7XRZ1wwGBCrq50rO2JxU8MPPqa0i0Z+pjTKlUawjLebU3pcakiEkSs7ytRhdCCl0Kv7GHrxsduQ1/erdOL5iKZqX1zVCYaqeEwlrQ3okRuW/IOYplzb4IX//NS88GJEwkPYPo4wSor7QRaatC3QGP9bLOp6ny2ZNB0rRn51fmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GVI2Pk0e; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GVI2Pk0e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775637982; x=1807173982;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=91maVxZNEzGhFKlBZ9qtc86KCdBoWXk2N2q/VDGazBk=;
  b=GVI2Pk0erUGQgulbh8nBVPC7cjYXkS3whjB8nB7d2EKO8LCPNn3mgKYy
   HnsCmETHRAw0TP5QQjBJurDyD2PBqWSUviQjmKbvZUwSGZMZgcqTveggP
   7uqIg80fukIWRQc2rx2n/skFZgak5X9ATCTAdfPZq/g/XMPqZ3EJoE+B5
   JPPa6hITbJqKRov0phQ6ygnZKoiWaZX84S1WkAAwj9zcSnzdC7RqKGHmT
   hQ8qP7MPuICKNAbV29qdDichdW0lJCYGTqHD1ptHuilXAZND6dU3GiB8H
   isqTB0g0HFlBiQXVacMV87MWoZD5A+rCbwS+1mR8FhqfTijwXwz0lZ8bY
   g==;
X-CSE-ConnectionGUID: qKHZvD5NRlGrpZYLOnxblg==
X-CSE-MsgGUID: hzxuAiuKQ1m79MOFhS+uCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="75784554"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="75784554"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 01:46:15 -0700
X-CSE-ConnectionGUID: jcf3ZyLxSs+YjirYcm6NNw==
X-CSE-MsgGUID: LzCr/hS7QuCjRxFbYMUGJQ==
X-ExtLoop1: 1
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa003.fm.intel.com with ESMTP; 08 Apr 2026 01:46:12 -0700
Date: Wed, 8 Apr 2026 16:24:39 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Huang, Kai" <kai.huang@intel.com>
Cc: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
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
Subject: Re: [PATCH v2 11/31] x86/virt/tdx: Make TDX Module initialize
 Extensions
Message-ID: <adYQx+6LcO/s2nyn@yilunxu-OptiPlex-7050>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-12-yilun.xu@linux.intel.com>
 <5cbed31cdfcc7e43f283abc275848370239a3d40.camel@intel.com>
 <acvhD/XeCbB4ea0C@yilunxu-OptiPlex-7050>
 <124b776006fee36e4a242f58bd4e128eae97c505.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <124b776006fee36e4a242f58bd4e128eae97c505.camel@intel.com>

On Wed, Apr 01, 2026 at 11:42:36AM +0000, Huang, Kai wrote:
> On Tue, 2026-03-31 at 22:58 +0800, Xu Yilun wrote:
> > > > +	/*
> > > > +	 * ext_required == 0 means no need to call TDH.EXT.INIT, the Extensions
> > > > +	 * are already working.
> > > 
> > > How does this scenario happen exactly? And why not check it above at the
> > > beginning? Before the allocation, so it doesn't need to free.
> > > 
> > > Is there a scenario where the memory needs to be given, but the extension is
> > > already inited?
> > 
> > mm.. you are right. It leads to something absurd.
> > 
> > I checked with TDX Module team again. The correct understanding is:
> > 
> >  - TDX_FEATURES0_EXT bit shows Extensions is supported.
> >  - optional feature bits are selected on TDH_SYS_CONFIG
> >  - If one of the optional feature (e.g. TDX CONNECT) requires Extention,
> >    memory_pool_required_pages > 0 && ext_required == 1. Otherwise no
> >    need to initialize Extension.
> > 
> > So yes, I should check memory_pool_required_pages && ext_required at the
> > beginning.
> 
> My understanding is different:
> 
> Per spec, the 'EXT_REQUIRED' global metadata just means "Return true if the
> TDH.EXT.INIT is required to be called", so I think, architecturally, it's

Maybe these text should be improved. They just literally tell how, so leads
to our disagreement.

> possible that one particular feature only requires additional memory pool
> but doesn't explicitly need to call TDH.EXT.INIT.  Or some feature may not
> require any additional memory pool but needs TDH.EXT.INIT.

This is different from what I've been told by TDX Module team. Do you
have a real setup like that?

My gut feeling also tells me there is little chance that:

 1. The Extensions is already working (cause no need to call
    TDH.EXT.INIT) while we are still adding memory.
 2. The Extensions could enable long running / hard-irq preemptible
    flows with no memory consumption.
