Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF7B39A04A;
	Tue, 14 Apr 2026 10:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776161971; cv=none; b=oG86ZRIlBlDA65WPRM1jumrEzC9C83OZzG469NnytmUIMkik9O7eyzoQgi5MyOou/CkFcT4XJAomMDxiF6msUHEoXEw6cufsGlQyMiZ8qNU+1rxrMvO+a2T+adqWy75wb+QVSi0DgmjXPDSCdzVBNfwIywRVLajbQZDZUnAtWBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776161971; c=relaxed/simple;
	bh=B2hp8pIzpur9QpDNjownUQWL2JU+z/TQTreC0jcUJco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQBJ1RuMz9hw7Ky+SmH8wxfvTGd0ZZ1hLnhyKRXYDaupUfAk8TtBA9lnvlvFB1LX66bNRA6jghZV9DdEOhp79biGY34Egg9czikBGL159Y8qrdOtmuWlImcyCEBOqhlqa0m1SzExboCZzqP1ZnQeq6M4fuSoC6GVgk+E6JXFvCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gio7eHT4; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gio7eHT4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776161970; x=1807697970;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B2hp8pIzpur9QpDNjownUQWL2JU+z/TQTreC0jcUJco=;
  b=Gio7eHT4JQ2VTFi2lLq1rHZitFG+felbAwXT6yp5GPky+/hEq+pA1gew
   Cj8tvBvHn06d9zLdgWOc5xHwIovjcBhO3Zk151wkjt1glmlP9JbNpOVAb
   zgUEBJIU3W9e/iG57alh90Ogi+BV6nAYhABOGiWw/HI+Y9DWwKrVKMKZo
   T5gnbFqKSWdzCH3uBO/KW0S1jMGxYxly1E5a776G97CNcTrk/tQ8RtksG
   Xe77ckfPax3WC3uYn/tVDVanQ0mS/nHSDcrrwsXcRoNkzMwaJ3Gy+3EcS
   qcJ3sDpVdxiXJ+65SfsJFg/PzGNMI3VWMZ32zuiMIr7q27OaG0WGqjp1j
   g==;
X-CSE-ConnectionGUID: D2BA/wRSSMSxmtsDosMmsw==
X-CSE-MsgGUID: c4gCkvBhT5ajludrtEqkhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="77020018"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="77020018"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 03:19:30 -0700
X-CSE-ConnectionGUID: DaMgaSwARGiiqBWrF6ndNA==
X-CSE-MsgGUID: 02DLoXeXSRSlGZYhrOMZtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="234451599"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa004.jf.intel.com with ESMTP; 14 Apr 2026 03:19:26 -0700
Date: Tue, 14 Apr 2026 17:57:35 +0800
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
Message-ID: <ad4Pj0cqlprvNUSj@yilunxu-OptiPlex-7050>
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

I'm drafting some changes and make the tdx_page_array look like:

  struct tdx_page_array {
	/* public: */
	unsigned int nr_pages;
	struct page **pages;

	/* private: */
	u64 *root;
	bool flush_on_free;
  };

  - I removed the page allocations for tdx_page_array kAPIs. Now the
    caller needs to allocate the struct page **pages and the page list,
    then create the tdx_page_array by providing these pages.

    struct tdx_page_array *tdx_page_array_create(struct page **pages,
						 unsigned int nr_pages)

    This also means tdx_page_array doesn't have to hold more than 512
    pages anymore, it now an exact descriptor for the TDX Module's
    definitions rather than a manager. It's a chunk of the required
    memory when we need more than 512 pages. This eliminates the need
    for 'offset' field and the slide window operations so make the
    helpers simpler.

  - I still keep the generic struct tdx_page_array to represent all
    kinds of object types (HPA_ARRAY_T, HPA_LIST_INFO, IOMMU_MT), and
    provide the tdx_page_array to SEAMCALL helpers as parameters. I
    think this structure is generally good enough to represent a list of
    pages, keeps type safety compared to a list of HPAs.

  - I still record both the page list (struct page **pages) and the HPA
    list (in u64 *root). struct page **pages works with kernel memory
    management (e.g. vmap) well while the populated root works with
    SEAMCALLs.

  - I'm not introducing more structures each for an object type, like 
    struct hpa_array, struct hpa_list_info, struct iommu_metadata. They
    are conceptually the same thing. The iommu_mt supports multi-order
    pages, hpa_array_t & hpa_list_info don't support. But their bit
    definitions don't conflict. I can use the same piece of code to
    populate their root page content.

  - Add a flush_on_free field to mark if a cache write back is needed on
    tdx_page_array_free(), then we don't need 2 free APIs.

I want to clean up my code, then post an incremental patch for preview.

Thanks.
