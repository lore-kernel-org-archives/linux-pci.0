Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2427827702D;
	Wed,  8 Apr 2026 04:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775623883; cv=none; b=pIQrHyqaug1vP4DbvYKH0XJtA1j3nLPEOyj3ARKP4jTDgkr5P1SVQXz7L6jf+D6La4gIzpFmhyblzzjpdHISwypmmvnjwGN3NYYuWaal0Q/T9JzltGcbE17997KI4lRq/zoPfW1FwT3ufFhzXL8jhSQ2lKdoHcWo/0lY3In3Ix8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775623883; c=relaxed/simple;
	bh=B132BJS1yCU7jBLOGy3abXkXYvrR8CqJzEnq5tfW/08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nlRJ0tSCdFDcMOcUlUa2i+YTtxKbWVeT+CI6M7ShHUl6tbvRdLwHQOfFeUeDJ8d4J9onTpypH4T4eocH4zUzf4Wwo/3oBxJFgtUyV6ZSS3/SHzdJ7E9nQX2Ne+KMi8Cno9ez+Ob6T2+o65fVK0CwOArF1OiEgk0LAanite2s6rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G9HhrU9P; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G9HhrU9P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775623883; x=1807159883;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B132BJS1yCU7jBLOGy3abXkXYvrR8CqJzEnq5tfW/08=;
  b=G9HhrU9PKQZxenEKoE+J3ognUxLVO+ZH+jtS/MVItozO7v7iqjygxGBR
   jiTQ2aK8aKvBmd8Dm2+xEdbeppjOi/fZLBPY5mOZmQi3IpzwCZl9k72Zl
   KeHiX39NxoP3mazDlJHMXzVNqY8lbgnuYmKzJ7rjrWRafLWFfEWU/2a+X
   ivI743cRX3Uiri2pxOYL+Ldcl2szydFXv1NrJTUgxhhsNzBa/FG7ROabv
   iwU4Y/Ou2RqzAT7gyb/0xMF10PGv1x28UqLbpIF7N5QBZTKpGttsXuFAR
   as1QbVZAaoibY/713YjRPO/O2TkWO3qazgOR7wVM1exTzvGcDqAGSTN5W
   A==;
X-CSE-ConnectionGUID: X2uFHfpURMGr7MJxFohOuA==
X-CSE-MsgGUID: Ba4YaOTdQG6zoprOCYSEqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="99224865"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="99224865"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 21:51:22 -0700
X-CSE-ConnectionGUID: xoqBl0YaQw6iISbq4hmDPg==
X-CSE-MsgGUID: ilu7+LiCSJOmS4Yy02oeMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,166,1770624000"; 
   d="scan'208";a="258800426"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa002.jf.intel.com with ESMTP; 07 Apr 2026 21:51:18 -0700
Date: Wed, 8 Apr 2026 12:29:46 +0800
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
Subject: Re: [PATCH v2 05/31] x86/virt/tdx: Extend tdx_page_array to support
 IOMMU_MT
Message-ID: <adXZusc4jX1JlrD9@yilunxu-OptiPlex-7050>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-6-yilun.xu@linux.intel.com>
 <828f174d49a1ecaec65ba1179e08c6b22e249297.camel@intel.com>
 <acvX1x5nDdGtZWyI@yilunxu-OptiPlex-7050>
 <f38d0a080aee052937cb6721683d55155c657717.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f38d0a080aee052937cb6721683d55155c657717.camel@intel.com>

On Wed, Apr 01, 2026 at 12:17:45AM +0000, Edgecombe, Rick P wrote:
> On Tue, 2026-03-31 at 22:19 +0800, Xu Yilun wrote:
> > > Consider the amount of tricks that are needed to coax the tdx_page_array to
> > > populate the handoff page as needed. It adds 2 pages here, then subtracts
> > > them
> > > later in the callback. Then tweaks the pa in tdx_page_array_populate() to
> > > add
> > > the length...
> > 
> > mm.. The tricky part is the specific memory requirement/allocation, the
> > common part is the pa list contained in a root page. Maybe we only model
> > the later, let the specific user does the memory allocation. Is that
> > closer to your "break concepts apart" idea?
> 
> I haven't wrapped my head around this enough to suggest anything is definitely
> the right approach.
> 
> But yes, the idea would be that the allocation of the list of pages to give to
> the TDX module would be a separate allocation and set of management functions.
> And the the allocation of the pages that are used to communicate the list of
> pages (and in this case other args) with the module would be another set. So
> each type of TDX module arg page format (IOMMU_MT, etc) would be separable, but
> share the page list allocation part only. It looks like Nikolay was probing
> along the same path. Not sure if he had the same solution in mind.
> 
> So for this:
> 1. Allocate a list or array of pages using a generic method.
> 2. Allocate these two IOMMU special pages.
> 3. Allocate memory needed for the seamcall (root pages)
> 
> Hand all three to the wrapper and have it shove them all through in the special
> way it prefers.
> 
> Maybe... Can you write something about the similarities and differences with the
> three types of lists in that series? Like in a compact form?


The common part:
   
         64bit obj type                 root page
   +----------+----------------+    +---------------------+     
   | ...      |  ...           |    | page0 HPA(bit12-51) |--> page0
   +----------+----------------+    +---------------------+     
   |bit 12-51 | root page HPA  |--->| page1 HPA           |--> page1
   +----------+----------------+    +---------------------+
   | ...      |  ...           |    | pageX HPA           |--> pageX
   +----------+----------------+    +---------------------+



The specific objects:

         HPA_LIST_INFO                 root page
   +----------+----------------+    +---------------------+
   |bit 3-11  | first entry    |    | page0 HPA(bit12-51) |
   +----------+----------------+    +---------------------+
   |bit 12-51 | root page HPA  |--->| page1 HPA           |
   +----------+----------------+    +---------------------+
   |bit 55-63 | last entry     |    | pageX HPA           |
   +----------+----------------+    +---------------------+



         HPA_ARRAY_T                   root page                  HPA_ARRAY_T(singleton mode)
   +----------+----------------+    +---------------------+      +----------+----------------+
   |bit 3-11  | Reserved 0     |    | page0 HPA(bit12-51) |      |bit 3-11  | Reserved 0     |
   +----------+----------------+    +---------------------+      +----------+----------------+
   |bit 12-51 | root page HPA  |--->| page1 HPA           |      |bit 12-51 | page0 HPA      |--> page0
   +----------+----------------+    +---------------------+      +----------+----------------+
   |bit 55-63 | last entry     |    | pageX HPA           |      |bit 55-63 | last entry     |
   +----------+----------------+    +---------------------+      +----------+----------------+



         MMIOMT                       root page
   +----------+----------------+    +-----------------------------+-------------------+
   |bit 3-11  | Reserved 0     |    | 2^order page0 HPA(bit12-51) |num pages(bit 0-11)|
   +----------+----------------+    +-----------------------------+-------------------+
   |bit 12-51 | root page HPA  |--->| 2^order page1 HPA           |num pages          |
   +----------+----------------+    +-----------------------------+-------------------+
   |bit 55-63 | Reserved 0     |    | page2 HPA                   |0                  |
   +----------+----------------+    +-----------------------------+-------------------+
                                    | page3 HPA                   |0                  |
                                    +-----------------------------+-------------------+
                                    | pageX HPA                   |0                  |
                                    +-----------------------------+-------------------+



The same thing is they all have root_page_hpa->root_page->page_hpa_list structure.

The differences:

		HPA_LIST_INFO	HPA_ARRAY_T	IOMMU_MT	Note
first entry     Y		N		N		start entry in root page
last entry	Y		Y		N		last entry in root page
num pages	always 0	always 0	Y		for multi-order page
singleton	N		Y		N		try to save a root page


> 
> Also, how much of the earlier code duplication you wanted to avoid was the
> leaking and special error handling stuff?

This is indeed a large part, and now we don't need them anymore.

Others are:
 - the root_page allocation/population/free
 - Too much parameters (struct page **, num_pages, struct page *root...)
   for seamcall wrappers. Or 3 newly defined structures which looks
   pretty much the same and need same implementations like
   tdx_clflush_page().

Thanks,
Yilun
