Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243BE3CAE95;
	Wed, 22 Apr 2026 10:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776852953; cv=none; b=hzfmewmLETNb5IV/zz0ASVhbNEInkwmYyXjb6qDp1vjlk4altwA6Xm/BxX970mpILwjy2oQPHsDj5coEuW0LtC6b7y425GF/Sn2FgmMY7hvX53qEFzbiPdyOjfkRV+nPld+A5F5vY5MHyFW3cuMRVZRYoOZalis1dFoemiR0sX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776852953; c=relaxed/simple;
	bh=4pm3cuE4YtiBWgDifB2kYoUnXjTiXLk2G7f65ddr4uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LdRuPafa9DLB9lQ4pBqx4bfrWXttl629gAOJJc3eVd6kZDskobzCoLbdY9vtgeEuCHYL1tm042wnfQx+cbrm4d+YS9ssJ4gxuXScyIW+olOXXPA1xsbk5+RtsSPdIO4omKHGIl9yVFShbNPBUSezZUb3MYtvmPkyMi6u8DH953E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U5SemlP9; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U5SemlP9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776852952; x=1808388952;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4pm3cuE4YtiBWgDifB2kYoUnXjTiXLk2G7f65ddr4uo=;
  b=U5SemlP9hrw0llBaEkQ2q7iu04foN6faUT1/CZT94U0RvXTgrl1YfUWb
   IIh6wHLVAY4F/PMH+j4KWPgM/86Pw90h04cNzkW7E+4IU6mm7OKor2EQX
   azpvioUPriOFT6z7GZ0WAzAdHPYqTJeCdQB4PH+dUCbFcurj2XxdXbD5y
   I4Gsh/Rwn5YCgfxa+/QHD5/fsUTh88Vwwc4K7vlmF1l2gmz0dX6RNMMyo
   K/jlTtIiSG+grfhMMqxrs3cX9AfyMACjy1vxz9tDEJcxFeST5o61QlcJH
   Kv1CN8SrOB0o0qrQN2v6Dh4RIVUD5Q5j63u29xZmn+cJdiGzNz17uewgA
   Q==;
X-CSE-ConnectionGUID: GVM6/bUURyShbWj8gujq6w==
X-CSE-MsgGUID: Fdm0J4AqTZmk8LIAtGrkeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="88103576"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="88103576"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 03:15:51 -0700
X-CSE-ConnectionGUID: clzp6i49Tqy7fKYj7FwyrQ==
X-CSE-MsgGUID: 2wvphU5qQKabKVkwrdVVEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="227983651"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa010.fm.intel.com with ESMTP; 22 Apr 2026 03:15:47 -0700
Date: Wed, 22 Apr 2026 17:53:34 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
	dan.j.williams@intel.com, x86@kernel.org, chao.gao@intel.com,
	dave.jiang@intel.com, baolu.lu@linux.intel.com, yilun.xu@intel.com,
	zhenzhong.duan@intel.com, kvm@vger.kernel.org,
	rick.p.edgecombe@intel.com, dave.hansen@linux.intel.com,
	kas@kernel.org, xiaoyao.li@intel.com, vishal.l.verma@intel.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 27/31] coco/tdx-host: Implement SPDM session setup
Message-ID: <aeianoT0LZFC2DNt@yilunxu-OptiPlex-7050>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-28-yilun.xu@linux.intel.com>
 <51f2be5a-47d2-4a06-92bb-368aaed73530@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51f2be5a-47d2-4a06-92bb-368aaed73530@suse.com>

> > +#define TDISP_FUNC_ID		GENMASK(15, 0)
> > +#define TDISP_FUNC_ID_SEGMENT		GENMASK(23, 16)
> > +#define TDISP_FUNC_ID_SEG_VALID		BIT(24)
> > +
> > +static inline u32 tdisp_func_id(struct pci_dev *pdev)
> > +{
> > +	u32 func_id;
> > +
> > +	func_id = FIELD_PREP(TDISP_FUNC_ID_SEGMENT, pci_domain_nr(pdev->bus));
> > +	if (func_id)
> > +		func_id |= TDISP_FUNC_ID_SEG_VALID;
> 
> This check implies pci_domain_nr returning 0 is considered invalid. Other
> callers in the kernel seem to not care, they just use the domain nr, so is
> this check spurious or intentional ?

This is the func_id format defined in TDISP SPEC, bit 24 is a must. It
is not the linux defined SBDF format.

> 
> > +	func_id |= FIELD_PREP(TDISP_FUNC_ID,
> > +			      PCI_DEVID(pdev->bus->number, pdev->devfn));
> > +
> > +	return func_id;
> > +}
> > +
> > +struct spdm_config_info_t {
> > +	u32 vmm_spdm_cap;
> > +#define SPDM_CAP_HBEAT          BIT(13)
> > +#define SPDM_CAP_KEY_UPD        BIT(14)
> 
> nit: move those defines above the struct definition, they just break the
> reading flow as it is.

Yes.

...

> > +static void *tdx_dup_array_data(struct tdx_page_array *array,
> > +				unsigned int data_size)
> > +{
> > +	unsigned int npages = (data_size + PAGE_SIZE - 1) / PAGE_SIZE;
> 
> nit: There's DIV_ROUND_UP

Yes.

...

> > +DEFINE_FREE(tdx_spdm_session_teardown, struct tdx_tsm_link *,
> > +	    if (!IS_ERR_OR_NULL(_T)) tdx_spdm_session_teardown(_T))
> > +
> >   static int tdx_tsm_link_connect(struct pci_dev *pdev)
> >   {
> > -	return -ENXIO;
> > +	struct tdx_tsm_link *tlink = to_tdx_tsm_link(pdev->tsm);
> > +
> > +	struct tdx_tsm_link *tlink_spdm __free(tdx_spdm_session_teardown) =
> > +		tdx_spdm_session_setup(tlink);
> 
> Is the free() really needed here, either the session is correctly setup and
> tlink_spdm is returned. But if session_setup() files then what about calling
> spdm_session_disconnect() on an unestablished session?

Ah, we have more steps to add, the __free() will take function when the
following steps fail.

We may add __free() when we add more steps, but I think that makes the
diff harder to read, so I want to keep this style.

Thanks.

> 
> 
> > +	if (IS_ERR(tlink_spdm)) {
> > +		pci_err(pdev, "fail to setup spdm session\n");
> > +		return PTR_ERR(tlink_spdm);
> > +	}
> > +
> > +	retain_and_null_ptr(tlink_spdm);
> > +
> > +	return 0;
> >   }
> 
> <snip>
> 
