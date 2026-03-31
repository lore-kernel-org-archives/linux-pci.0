Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF131329E4B;
	Tue, 31 Mar 2026 14:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774968019; cv=none; b=tUKSrDrBBDFG2N88nD0ZnyL9K6ps6yekWE6RYKf/dxZ7cfBtQ70gfMeI5zK1TM6lCdq14YbmBv9QJiCh91+aokNCAd6Cje/NacS0AdViW05fWiVYj0H6QfyEq6+16bwo5iHRV3O9orU+gp1o/gaCL8bHcO59j1wlkvhjOKXi8EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774968019; c=relaxed/simple;
	bh=CxK5eQocQ9FQWY1jgFLkFY1OzPjcTFeXueFlb3s4J0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=StJ7chGbKYU64mYtMUdq9ZEc8Mn+cw6jb0IF3PZEm1t5DYDANjXAtkSf/aLX8o9JVFYF9ktx9T5XD8kUa3KTbFqraJpWNBQyscOTpUal6f4QElErV8QIFYL9+1YT9OwJCzU4doyXfrCdpMtKcakimy4MnE+3WSyWktDRzv9Ysbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eBBTzrfp; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eBBTzrfp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774968018; x=1806504018;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CxK5eQocQ9FQWY1jgFLkFY1OzPjcTFeXueFlb3s4J0Q=;
  b=eBBTzrfpjkJI5Ot95uF36/uymOd6avR8i6Lcql/NQUhmo6ETkPBN4hSN
   IIiajTzopPGUTHwHZoSY7DYsj7aBz9IOFQEIiTfS85fho6Vzyli509RPF
   W1k/IBLuGv6ufe+NgjrgxtXPKnE/rgyrM3D1sHUoP1Vmfnh3ZqJBmRiVq
   TkeIY3ai1XY9ibryAakVdy9z0yyTwSpqYruzGk/3GhgqbWv2tOTeHIdo9
   6WkBot58wc2W0rVJ5KX2aVomylETY9JkADr//kJ+VmnRipzdh2p1sBms/
   FOxyKYQBaInqfHNUg/3QrnefeAk5/D6/R6IhyRitghMsm++DGgdjKmCHP
   Q==;
X-CSE-ConnectionGUID: fWZQzeOYRHmqEU80i3Cdfw==
X-CSE-MsgGUID: wZ/qGE68RQGGA5n+2hfOfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="75699855"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="75699855"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 07:40:18 -0700
X-CSE-ConnectionGUID: cffhhCypT8KX9UrmnFNALw==
X-CSE-MsgGUID: TXxSmoE9Qk+M+3o+YqC3vQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="264322294"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa001.jf.intel.com with ESMTP; 31 Mar 2026 07:40:13 -0700
Date: Tue, 31 Mar 2026 22:19:03 +0800
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
Subject: Re: [PATCH v2 05/31] x86/virt/tdx: Extend tdx_page_array to support
 IOMMU_MT
Message-ID: <acvX1x5nDdGtZWyI@yilunxu-OptiPlex-7050>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-6-yilun.xu@linux.intel.com>
 <828f174d49a1ecaec65ba1179e08c6b22e249297.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <828f174d49a1ecaec65ba1179e08c6b22e249297.camel@intel.com>

> > +static int tdx_alloc_pages_iommu_mt(unsigned int nr_pages, struct page **pages,
> > +				    void *data)
> > +{
> > +	unsigned int iq_order = (unsigned int)(long)data;
> > +	struct folio *t_iq, *t_ctxiq;
> > +	int ret;
> > +
> > +	/* TODO: folio_alloc_node() is preferred, but need numa info */
> > +	t_iq = folio_alloc(GFP_KERNEL | __GFP_ZERO, iq_order);
> > +	if (!t_iq)
> > +		return -ENOMEM;
> > +
> > +	t_ctxiq = folio_alloc(GFP_KERNEL | __GFP_ZERO, iq_order);
> > +	if (!t_ctxiq) {
> > +		ret = -ENOMEM;
> > +		goto out_t_iq;
> > +	}
> > +
> > +	ret = tdx_alloc_pages_bulk(nr_pages - 2, pages + 2, NULL);
> > +	if (ret)
> > +		goto out_t_ctxiq;
> > +
> > +	pages[0] = folio_page(t_iq, 0);
> > +	pages[1] = folio_page(t_ctxiq, 0);
> 
> To me it seems like this can't really be called a page array any more. The first
> two u64's are too special. Instead it's a special one-off ABI format passed via
> a page.
> 
> BTW, I can't find TDH.IOMMU.SETUP in the docs. Any pointers?

https://cdrdv2.intel.com/v1/dl/getContent/858625

> 
> > +
> > +	return 0;
> > +
> > +out_t_ctxiq:
> > +	folio_put(t_ctxiq);
> > +out_t_iq:
> > +	folio_put(t_iq);
> > +
> > +	return ret;
> > +}
> > +
> > +/**
> > + * tdx_page_array_create_iommu_mt() - Create a page array for IOMMU Memory Tables
> > + * @iq_order: The allocation order for the IOMMU Invalidation Queue.
> > + * @nr_mt_pages: Number of additional order-0 pages for the MT.
> > + *
> > + * Allocate and populate a specialized tdx_page_array for IOMMU_MT structures.
> > + * The resulting array consists of two multi-order folios (at index 0 and 1)
> > + * followed by the requested number of order-0 pages.
> > + *
> > + * Return: Fully populated tdx_page_array or NULL on failure> > + */
> > +struct tdx_page_array *
> > +tdx_page_array_create_iommu_mt(unsigned int iq_order, unsigned int nr_mt_pages)
> > +{
> > +	unsigned int nr_pages = nr_mt_pages + 2;
> 
> Consider the amount of tricks that are needed to coax the tdx_page_array to
> populate the handoff page as needed. It adds 2 pages here, then subtracts them
> later in the callback. Then tweaks the pa in tdx_page_array_populate() to add
> the length...

mm.. The tricky part is the specific memory requirement/allocation, the
common part is the pa list contained in a root page. Maybe we only model
the later, let the specific user does the memory allocation. Is that
closer to your "break concepts apart" idea?

> 
> > +	struct tdx_page_array *array;
> > +	int populated;
> > +
> > +	if (nr_pages > TDX_PAGE_ARRAY_MAX_NENTS)
> > +		return NULL;
> > +
> > +	array = tdx_page_array_alloc(nr_pages, tdx_alloc_pages_iommu_mt,
> > +				     (void *)(long)iq_order);
> > +	if (!array)
> > +		return NULL;
> > +
> > +	populated = tdx_page_array_populate(array, 0);
> > +	if (populated != nr_pages)
> > +		goto out_free;
> > +
> > +	return array;
> > +
> > +out_free:
> > +	tdx_page_array_free(array);
> > +	return NULL;
> > +}
> > +EXPORT_SYMBOL_GPL(tdx_page_array_create_iommu_mt);
