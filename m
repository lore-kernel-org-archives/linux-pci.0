Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91518483825;
	Fri, 16 Oct 2026 12:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792154078; cv=none; b=H1MTqFG6nNqs46VYI5PksWgzFPTcjyrBBtNcqj6eRONHfCXSi0rrKFg/49aPr4tgGeABkFMLDpd+Xf18Js5SbEeX1jijbprjXue+0ix0dP7+C/DPIVqd6UEGkPi5jycrjSe0Sse/yFSaUwtMGw6tQf5oiTZ+wUwtZN3iNHHH+iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792154078; c=relaxed/simple;
	bh=UIbLLDrJIIjb2CwXKb/lPXI78W8TAKpGdXU7fwKd1QA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pWYhFUi0MWx1ZRHTRv9s3BupN5C5wAchBMp2sb5TAxM1/69mZA+2OwwLXI9DVdQf4mhbPT/eiVg5+hK8OWoP5jMhGq9iqeymNCqONcFRZFB5Hc76qFyXIChHvQhPyk7gu9sptR9+Q9FN4MDwWvvDt9jyosjDXkAvgXnw8axn+m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hW6JcTNV; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hW6JcTNV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792154076; x=1823690076;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UIbLLDrJIIjb2CwXKb/lPXI78W8TAKpGdXU7fwKd1QA=;
  b=hW6JcTNVfQzRlnu/laPF38rW/w7mGIzzqaYMVzSg4A4OG8bTUy2ITa78
   3q17HuAnbsGGwRhDcJP2Tpw5cphMIb2ezkiTpeNtgiyBhBXfHmpaqF1gt
   /NiLXKiq7jnc1AODIRNBTeacOW6n7aCNwbTLYGCwPhcM2ztjGHvgmADgx
   O0KPkyfXZfQ6pjO1j2AB1T4EvNPD4R3yrAbdPIwDysBqGvsiHLSUU8Qq8
   X6gi8YPOWOizSO1FY6oNfBcVrwL1XycfZCV0fqLds1qBzU6PdXiOobvJh
   fcldBeyx2dZ+PAtgpgdsTHh/UNSV34ZfUymnoIv7mWJXIZdX3BeZTwT0v
   g==;
X-CSE-ConnectionGUID: MfZFqX70QBSzujNVDUrNVw==
X-CSE-MsgGUID: 5xKoQXQAT0ah1DdbiJ3TBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="819190"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="819190"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 05:34:36 -0700
X-CSE-ConnectionGUID: AtxgidLBRFq7zj1R/NdsSw==
X-CSE-MsgGUID: SuVyVi3NR0WuwCHyDtnJQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="2315671"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa006.fm.intel.com with ESMTP; 16 Oct 2026 05:34:32 -0700
Date: Fri, 16 Oct 2026 20:30:12 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Ankit Agrawal <ankita@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, dave@stgolabs.net, jic23@kernel.org,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, jgg@nvidia.com, aneesh.kumar@kernel.org,
	aik@amd.com, iweiny@kernel.org, ming.li@zohomail.com,
	icheng@nvidia.com, bhelgaas@google.com, smadhavan@nvidia.com,
	ilpo.jarvinen@linux.intel.com,
	Smita.KoralahalliChannabasappa@amd.com,
	andriy.shevchenko@linux.intel.com, linux-coco@lists.linux.dev
Subject: Re: [RFC PATCH 1/4] PCI/TSM: Create MMIO descriptors via TDISP Report
Message-ID: <atIY1Joa//+hCRcr@yilunxu-OptiPlex-7050>
References: <20261005070252.84810-1-ankita@nvidia.com>
 <20261005070252.84810-2-ankita@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005070252.84810-2-ankita@nvidia.com>

> pci_tsm_mmio_alloc() also recovers the obfuscated starting address for
> each encrypted MMIO range, since the VM is never disclosed the HPA
> that correlates to the GPA of the device's MMIO. The obfuscated
> address is BAR aligned.

Could you help specify in the changelog how to ensure the obfuscated
address BAR aligned. I believe this is not mandated in PCI TDISP spec,
so we need to let all TSM vendors know about the rule.

I remember it is done by TSM setting the MMIO_REPORTING_OFFSET as the
largest BAR size on LOCK_INTERFACE_REQUEST, is it?

[...]

> +/**
> + * struct pci_tsm_mmio_entry - an encrypted MMIO range
> + * @res: MMIO address range (typically Guest Physical Address, GPA)
> + * @tsm_offset: Host Physical Address, HPA obfuscation offset added by the TSM.
> + *		Translates report addresses to GPA.
> + */
> +struct pci_tsm_mmio_entry {
> +	struct resource res;
> +	u64 tsm_offset;

I remember Intel TDX once wanted this tsm_offset stored here. TDX
firmware needed this field to identify which private mmio range the
CoCo-VM want to accept.

But now TDX switch to use mmio_range_index. See this link:

https://lore.kernel.org/all/20260924041032.1096569-8-zhenzhong.duan@intel.com/

So could you help switch to store the range index? I believe no vendor
needs the obfuscated HPA now.

> +};
