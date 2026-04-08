Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6BF31355C;
	Wed,  8 Apr 2026 07:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775634588; cv=none; b=ogx0yj5O35+NKx8mnqa4TL+TJYark3jwGsh8sPIe8nZmxBAa5ow2SKG0UOy3Ep3uCQ2CmhUyzn/zBRYBHX5NThmpZJ9/ZzkdC+z0/p91APws0xyF+xGIwvukYgf/Lhs29Yn1iFTM++51pbOLFl9UNC2CDLQ2qlQ97OrdTHY3HAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775634588; c=relaxed/simple;
	bh=TZ8vAjBEh8SJSxBZo9/DJgG2nIYFLp8l9WUkHVDXk2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dmsf+g2pLJ6+x9RWfWNgVOC2mGsAhtJT3/Ci3ncGHFZ5eclkY9f/sC4SPBl8ijIOt0U9niznpZwxGUG+oIh+3NHHOcS8a77eJmsKVuDWDGSf3e2Bd8N8k1zm+NFINYrWZKgRPrxdrwS07CkJYHC65+A2xkpwqdZj5flUn6j7vcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SylTvEXa; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SylTvEXa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775634587; x=1807170587;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TZ8vAjBEh8SJSxBZo9/DJgG2nIYFLp8l9WUkHVDXk2E=;
  b=SylTvEXarqXeISKlnlxzQGog4L7jM04gWBNq6Y0TRSfJgOeTZVqwck8C
   N8SYFmpd6w6wHLUt+CLHLXlZ9Kdr3pdCtKIRiVU9itHJlswEzqhHsZRWR
   ZfpnpuGKwTKJxpkI9x4KSB0xXSNtQe68NqjvVEq80BwP/BrRbMEWWhGSN
   OqJD/nLvoabt9GQ4HqKAaQAbucF4V87yNaEqRT2uaA29J+sSJTObNZx9r
   BZEHbqwg08KojSLnY+fbfN+vS8VBeV8ooUgDhH9WWS6dYmMHdOUqikdm2
   FgGyH6ooOkP5wJchA0shzZ0MEZfHjj3WEPGx6QL/Om1x1z78NVh27S4LN
   g==;
X-CSE-ConnectionGUID: Fgb8c1MQS5Wk897ytyBNxA==
X-CSE-MsgGUID: FXJ/FtuYR76FfrnlfHNK+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="86901697"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="86901697"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 00:49:46 -0700
X-CSE-ConnectionGUID: LQFNHdM2S+icJZVek/TuOQ==
X-CSE-MsgGUID: iPTdPX9gSOeIsZFEVM9X2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="251725022"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa001.fm.intel.com with ESMTP; 08 Apr 2026 00:49:43 -0700
Date: Wed, 8 Apr 2026 15:28:11 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
	dan.j.williams@intel.com, x86@kernel.org, chao.gao@intel.com,
	dave.jiang@intel.com, baolu.lu@linux.intel.com, yilun.xu@intel.com,
	zhenzhong.duan@intel.com, kvm@vger.kernel.org,
	rick.p.edgecombe@intel.com, dave.hansen@linux.intel.com,
	kas@kernel.org, xiaoyao.li@intel.com, vishal.l.verma@intel.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/31] x86/virt/tdx: Add extra memory to TDX Module
 for Extensions
Message-ID: <adYDiw2BkdzajBHD@yilunxu-OptiPlex-7050>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-11-yilun.xu@linux.intel.com>
 <d9f09a41-9d10-4778-b49a-d54504020636@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9f09a41-9d10-4778-b49a-d54504020636@suse.com>

> > @@ -643,7 +643,7 @@ EXPORT_SYMBOL_GPL(tdx_page_array_create_iommu_mt);
> >   #define HPA_LIST_INFO_PFN		GENMASK_U64(51, 12)
> >   #define HPA_LIST_INFO_LAST_ENTRY	GENMASK_U64(63, 55)
> > -static u64 __maybe_unused hpa_list_info_assign_raw(struct tdx_page_array *array)
> > +static u64 hpa_list_info_assign_raw(struct tdx_page_array *array)
> >   {
> >   	return FIELD_PREP(HPA_LIST_INFO_FIRST_ENTRY, 0) |
> >   	       FIELD_PREP(HPA_LIST_INFO_PFN,
> > @@ -1513,6 +1513,94 @@ static void tdx_clflush_page(struct page *page)
> >   	clflush_cache_range(page_to_virt(page), PAGE_SIZE);
> >   }
> > +static void tdx_clflush_page_array(struct tdx_page_array *array)
> > +{
> > +	for (int i = 0; i < array->nents; i++)
> 
> shouldn't the actual number of entries be adjusted as per offset, similarly
> to how 'nents' in tdx_page_array_validate_release is calculated?

Actually array->nents is calculated the same way:

  static int tdx_page_array_populate(struct tdx_page_array *array,
				   unsigned int offset)
  {
	...

	array->offset = offset;
	array->nents = umin(array->nr_pages - offset,
			    TDX_PAGE_ARRAY_MAX_NENTS);
	...
  }

so IIUC we are good here.
