Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD9C3AC0C7
	for <linux-pci@vger.kernel.org>; Sun, 12 Jul 2026 12:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783859408; cv=none; b=k691WeDyXYQ7bc/VBa01ZAU9AS4EODebI/4RTllT08JWGGsDS8bbeEMjbmFetea8K3cObUpSh5jgSa2NjLB9E5wlyU5aEaZNSfNtEchsIit5YN/zigRdag88XI9piSmbkEdGjENBNSdlniecm3HMEwywmTagrpkI+J4nszovxvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783859408; c=relaxed/simple;
	bh=UZhO67pPsDDCcsBGmRVk8mTcw23+lbNXtxXjSjmwd30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQRF7RigISMZU9mjU9AQP0GI1O1qb9ZxwdcuwjOyxD95sCyXnKSw6Gp07QI5GNrdtt55ZNZm1EtPQ+/rnCBhUTGMYc1L7Cx3Vio7pp+u/v7sfyctbD7bC+7dvDrLRxM1ciFoFRDRDPY1oLGsTB72cK+fxQcUe5Y4a07BMstISec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eA1pk8hi; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eA1pk8hi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783859406; x=1815395406;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UZhO67pPsDDCcsBGmRVk8mTcw23+lbNXtxXjSjmwd30=;
  b=eA1pk8hi8ogyNj1Qkyo5Np/WWscpoa6WObSGMdj3SagDD1Whd1Vju2Xx
   YHDnFOp+50Bx0xuhZFObA1JeuK6TZB/57tvLJSPTRyo55IukqL6rO2cZb
   0sUfM49WSvQT4rVpo/Qc1/nwzRMjLgcdULl0rtmufLtvJq2jHUS+6cElR
   d3ijm6NIXc/Ka6E9Iz9OTtPUEKipGdIxe7LuYh2rBcD3IFZGi878u5TIt
   0rlhhsc80KfkjuiN6YINVfy74s/643Kc0cSon3M1oQmWW811bJo80I4gU
   GDpzfQSRQ2FMycpUmdwYxRswfo8ucaZLGRfqLdCFKJWYiEkG3nEMb+nc7
   A==;
X-CSE-ConnectionGUID: WFJ4W0ihTF+c+QXusXHGow==
X-CSE-MsgGUID: tqadGM4DSP+GKaoDsbbhVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="88174734"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="88174734"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2026 05:30:06 -0700
X-CSE-ConnectionGUID: IWnT2MZdTiWkoZHz75ARVA==
X-CSE-MsgGUID: BDQoNfu2SHaYOZwkTeCiwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="260190001"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.24])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2026 05:30:04 -0700
Date: Sun, 12 Jul 2026 15:30:01 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nirmal Patel <nirmal.patel@intel.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, lpieralisi@kernel.org,
	Nirmal Patel <nirmal.patel@linux.intel.com>
Subject: Re: [PATCH v2] PCI: vmd: Only assign OSC features in bare metal OS.
Message-ID: <alOIyYDz_RhsqT8v@ashevche-desk.local>
References: <20260710200558.499434-1-nirmal.patel@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710200558.499434-1-nirmal.patel@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 10, 2026 at 08:05:58PM +0000, Nirmal Patel wrote:
> Copy valid OSC flags from root bridge only when OS can provide correct
> values. In virtual machine, all of the control features are disabled as
> hypervisor will not passthrough root bridge information to VM.

...

> v2 : Added descriptive boolean and removed period from commit message.

It's still in the $Subject. You probably misinterpreted the comment(s).

...

> +	/* Non-zero offset means guest/direct assign view. */
> +	vmd_in_guest = offset[0] || offset[1];

+ Blank line?

>  	/*
>  	 * Currently MSI remapping must be enabled in guest passthrough mode
>  	 * due to some missing interrupt remapping plumbing. This is probably
>  	 * acceptable because the guest is usually CPU-limited and MSI
>  	 * remapping doesn't become a performance bottleneck.
>  	 */
> -	if (!(features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) ||
> -	    offset[0] || offset[1]) {
> +	if (!(features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) || vmd_in_guest) {
>  		ret = vmd_alloc_irqs(vmd);
>  		if (ret)
>  			return ret;

...

> -	vmd_copy_host_bridge_flags(pci_find_host_bridge(vmd->dev->bus),
> -				   to_pci_host_bridge(vmd->bus->bridge));
> +	/* Don't copy OSC control flags in VM, it disables features.*/

Missing space before */.

> +	if (!vmd_in_guest)
> +		vmd_copy_host_bridge_flags(pci_find_host_bridge(vmd->dev->bus),
> +					 to_pci_host_bridge(vmd->bus->bridge));

-- 
With Best Regards,
Andy Shevchenko


