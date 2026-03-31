Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26973EF0D2;
	Tue, 31 Mar 2026 13:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774965518; cv=none; b=EOnJx3AQFt7RkUOM4pcjE8bHl7DNzo3k9LeZBxc3vvN5jvUDqkDaxdDr1uQixSovxc+gQFW8DUC/kdoi9vN+2N70H0FU/w+HhUrsajURhBtebr45ivFTSKRpiPOlIF6w07urDrDkFxHSKZCH0HovgNUcW2IbQqQLlTzsKcGcD64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774965518; c=relaxed/simple;
	bh=PPljGw9YHSDgqARUKl/8MSJo6myqRucdPKY3A3kp0j4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JnDe9nA4thhfU3ciocpLj0fqeVemZzR/CleKCErJoXJb/He4IV6DO1e7FR8ANJaOCIhgLwNYiVnpYr1DUkd7skFWX+BpX27Mj/RHnipp0Q41aAiwjaoNw5mrcSCcwYl2JE2dP4++3IizLqvyFSIeQx4YFnHBxXZiinBjS0+BCUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N0J2pcbM; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N0J2pcbM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774965514; x=1806501514;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PPljGw9YHSDgqARUKl/8MSJo6myqRucdPKY3A3kp0j4=;
  b=N0J2pcbMWkQH5Dxcjg68CAZlWqo2QnzCwZm5SGY+/YC6fditCTS25Q/h
   SuFzrkzyVUPjRe7UaqTA0+izKN/BDntv33BnxsqSmTqFoIwC1R8rVbFhV
   cAuw5ZjGBjTYL2HU0bb3Gn/VfEZoe33UtnijT71MfPP378Qel90zgipPJ
   jnxyjPKxRUwAtoWwmG8SFijT0wB1JzyybJ6e7SWVg5IRXy7BooPEilPku
   9wvDmVXrCI6c760TG4NRzeUEGl9BV9igrT0GLjTtKOvyejQnxWbP1mx1X
   g2ks4C/TtMMw/qfUBjrI1f06XD1QpAM8PeKx6d2wQGbosUUV5T+RUo+I0
   w==;
X-CSE-ConnectionGUID: C+4uJXGUTIa1toakdE8Z7Q==
X-CSE-MsgGUID: PhK8BQEhRyaLTEj50V51YQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="86674921"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="86674921"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 06:58:32 -0700
X-CSE-ConnectionGUID: laxniY+xRXG2+3wcucwqXw==
X-CSE-MsgGUID: Pn1ePiK3TCmbnWGsr0g9jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="225540978"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa010.jf.intel.com with ESMTP; 31 Mar 2026 06:58:28 -0700
Date: Tue, 31 Mar 2026 21:37:18 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
	dan.j.williams@intel.com, x86@kernel.org, chao.gao@intel.com,
	dave.jiang@intel.com, baolu.lu@linux.intel.com, yilun.xu@intel.com,
	zhenzhong.duan@intel.com, kvm@vger.kernel.org,
	rick.p.edgecombe@intel.com, dave.hansen@linux.intel.com,
	kas@kernel.org, xiaoyao.li@intel.com, vishal.l.verma@intel.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/31] x86/virt/tdx: Support allocating contiguous
 pages for tdx_page_array
Message-ID: <acvODhP/Fa/ehNTw@yilunxu-OptiPlex-7050>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-5-yilun.xu@linux.intel.com>
 <7d67722b-5107-4dc3-b8fb-04c3c86a1563@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d67722b-5107-4dc3-b8fb-04c3c86a1563@suse.com>

> >   static struct tdx_page_array *
> > -tdx_page_array_alloc(unsigned int nr_pages)
> > +tdx_page_array_alloc(unsigned int nr_pages,
> > +		     int (*alloc_fn)(unsigned int nr_pages,
> > +				     struct page **pages, void *data),
> > +		     void *data)
> 
> This interface seems cumbersome, since you will always have separate
> allocation paths:
> 
> Contig, Bulk and Iommu mt pages let's just keep them separate. I.e the flow
> should be:
> 
> 1. Do common allocation by calling tdx_page_array_alloc (you aren't passing
> the alloc function) you just get a bare-bones tdx_page_array struct
> 
> 2. Do the specific allocation in either :
> 
> tdx_page_array_create - for the bulk case
> tdx_page_array_alloc_contig - for the contig case
> tdx_page_array_create_iommu_mt - for the iommu case. Here you can open code
> tdx_alloc_pages_iommu_mt.
> 
> And keep the specific clearly separate in each function.

Thank for the suggestion. There are also other concerns in this thread,
but I'll take this into consideration.
