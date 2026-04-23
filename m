Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC69D2D3A60;
	Thu, 23 Apr 2026 11:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776944288; cv=none; b=Rlui2MBAJkySTkrP+Mq+5RLExo8sQDoexTocjja50Xa8VI+b9mYM/jK9LHfLUqYQ0t8qIxdJHRN9PJxu9jjfKooG6WGoCR8XatNwtzJ6lMs92zL2ktTFTmmfG4pEl2ZtBHDFa1RWuxkU46CeHpR7DrxUN1BBzYjmjg9ABTGlk6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776944288; c=relaxed/simple;
	bh=R4Ca6IN1mWJGYFdQzaPE55EKhI3bfpMmk2W2eUuXQk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPby/atNqXOcuvDjAXkGD69XuDoBmrNoEv9P5xKkxezXafYSkElnJcLpKPRWz5nOyuIQ0/GjKqrrRw+rrbub+1jtEnW47B5peMnrvOEWm9SSlf44QFUORaSk7n+mhdx6HgExbQ0JvTVawWidGzvBrNrb+/NgVRBW4XKFeRu29zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DsqCfQK5; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DsqCfQK5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776944287; x=1808480287;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R4Ca6IN1mWJGYFdQzaPE55EKhI3bfpMmk2W2eUuXQk4=;
  b=DsqCfQK5IIjltm5zK2IwxGplYNYl3/8BnuN1lSIKe5xm1Wc9jY8pDjff
   EFGg+219TshrOfqRRkmy0PewUZSAX8HgtQ6KsJed4/QMAm63CanOa6Cg9
   tbWr5UH33W2leOwmr+YXtQKknxS6qkbYV3h3hbuJ/kAZnOFjYh469Wrjr
   c+uOsmiY/yr3/zxyrjysRHDWH4dBoJr7+LW1FCPHrSdavzmHHF7OmDlSZ
   aN4pVCuGu9JYqOJdMFNwtetwDIEKqQBl7OM7VPEpBmjYkqXvASofoXzWA
   EhZ7x2nQ4OHIYp1WZFfYTPD3fUd5CL99HBlSR0ESwcR6PvQOt/6dZGWps
   w==;
X-CSE-ConnectionGUID: UwD1z+pUQq26VQq2YQK9XA==
X-CSE-MsgGUID: u8Tciu0tSyCqdNMLr6G2Nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="77076526"
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="77076526"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 04:38:06 -0700
X-CSE-ConnectionGUID: YOC+9CzoQ1qbgt/bfOfHKw==
X-CSE-MsgGUID: VwVj9JQlQQC/APZI3GucUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="231608619"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa006.jf.intel.com with ESMTP; 23 Apr 2026 04:38:03 -0700
Date: Thu, 23 Apr 2026 19:15:46 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Dan Williams <djbw@kernel.org>
Cc: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"Gao, Chao" <chao.gao@intel.com>, "Xu, Yilun" <yilun.xu@intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"kas@kernel.org" <kas@kernel.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"Jiang, Dave" <dave.jiang@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"Verma, Vishal L" <vishal.l.verma@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH v2 05/31] x86/virt/tdx: Extend tdx_page_array to support
 IOMMU_MT
Message-ID: <aen/Yi2qCSK0z16l@yilunxu-OptiPlex-7050>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-6-yilun.xu@linux.intel.com>
 <828f174d49a1ecaec65ba1179e08c6b22e249297.camel@intel.com>
 <acvX1x5nDdGtZWyI@yilunxu-OptiPlex-7050>
 <f38d0a080aee052937cb6721683d55155c657717.camel@intel.com>
 <ad4Pj0cqlprvNUSj@yilunxu-OptiPlex-7050>
 <aeBufjwO3t7XzVle@yilunxu-OptiPlex-7050>
 <69e2c9334cbf7_147c8010040@djbw-dev.notmuch>
 <aeSTPuR9cuga+I69@yilunxu-OptiPlex-7050>
 <69e7f166319a5_fe083100f7@djbw-dev.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69e7f166319a5_fe083100f7@djbw-dev.notmuch>

> A couple recommendations come to mind:
> 
> * s/tdx_page_array_free/tdx_page_array_destroy/
> 
>   ...since "destroy" mirrors create and matches other cases where only
>   metadata is managed.
> 
> * Create a new tdx_page_array_repopulate() helper to make it clear which
>   paths depend on being able to repopulate and move the WARN_ON_ONCE() out of
>   the common path that does not repopulate. "repopulate" can have
>   "realloc" semantics where it allocates on first use, but otherwise
>   "populate" gets to not care about the corner cases. Make the WARN case
>   fail repopulate.

Agree. I end up add a function like that:


/**
 * tdx_page_array_repopulate() - repopulate a tdx_page_array
 * @array: The array descriptor to reallocate for.
 * @pages: Pointer to struct page array for tdx_page_array populating
 * @nr_pages: Size of @pages array.
 * 
 * Re-populate the tdx_page_array. If @array is %NULL, it behaves exactly like
 * tdx_page_array_create().
 *
 * Return: Re-populated tdx_page_array or NULL on failure.
 */
static struct tdx_page_array *
tdx_page_array_repopulate(struct tdx_page_array *array, struct page **pages,
			  unsigned int nr_pages)
{
	struct tdx_page_array *tmp = array;
	int ret;

	if (tmp) {
		/* Don't pass in something partially initialized */
		if (!tmp->root || !tmp->pages || !tmp->nr_pages)
			return NULL;

		/*
		 * When re-populating, the old pages are no longer tracked.
		 * Theoretically they require cache flushing before reclaiming
		 * for other kernel usage, similar to tdx_page_array_destroy().
		 * Since there is no use case to repopulate and then reclaim
		 * old pages yet, just warn to prompt future improvement.
		 */
		if (WARN_ON_ONCE(tmp->need_phymem_page_wbinvd))
			return NULL;
	} else {
		tmp = tdx_page_array_alloc();
		if (!tmp)
			return NULL;
	}

	ret = tdx_page_array_populate(tmp, pages, nr_pages);
	if (ret) {
		/* Only destroy newly allocated object */
		if (!array)
			tdx_page_array_destroy(tmp);

		return NULL;
	}

	return tmp;
}
