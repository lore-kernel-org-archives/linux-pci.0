Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FC5277CA5
	for <linux-pci@vger.kernel.org>; Fri, 13 Mar 2026 10:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773398652; cv=none; b=nmXvrFt/ah4ydR3JihNKrkZ28RMDneBT0yC4p/dettxB/RaK4uEbecJvibFjFyJnTZW1E8TjJebqZY7PAiAYO7HUXVsWWbCtykKNYAHhSTNhrdF9wC6PeI3g95RqKQNQdwU3ybmDRK/WHeyZISkPXlz9qajIyawWZsxvwF48Pi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773398652; c=relaxed/simple;
	bh=qj7zF2/b8p7pJFMEJOM5RewBphD0eNXZF/m0BHqgcW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E49z7bSIF01n3h1gceH90UytwA9nV1e2VY6TDrGG9dYIeplO/E4Xaa96MGEOpwZuZ4gof2cWAQWQ53ZVaD0MhjyK+T04ObUUwGTUh7lUp2euB/67IVkFt0Sznzd/MeOWX3aYamfmdtN4uoPJBp+RIK/gyeEgnVk41TwUygMZT+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IW4r9OLM; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IW4r9OLM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773398651; x=1804934651;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qj7zF2/b8p7pJFMEJOM5RewBphD0eNXZF/m0BHqgcW4=;
  b=IW4r9OLMvETZiiI5wVU3LZBHnBOMvI8VK4gX5iUa4L2G5Jg+0qHsyd/p
   p9XVnjFnUguBaoFOXtzm1qqCD9BfHHtrWSDfeRe3Nj9TMiA8LS2iDpgoX
   9MBg+owPssY9sPkZaWDUlc+FOiGllvb0Dnrcgnpjm5HAmBG3t5KOE2YEU
   xEZU2ddMZT0GvHpdcNmOM3ZRjyoHCzHwFTt7Mcld+0jGebzlEY/cajqfX
   JXvUOyvvX9W3SSGk78BQlCzg8l2LbylI9lu8esLrKrG3dZyhvHJUp8RuZ
   uIHZhEXL18uF7pKXvf4dIZegIiVYs1usuqAtBgdVTXxo7ZDaJr2sCEdD+
   A==;
X-CSE-ConnectionGUID: 6X1ByUNKR9OxZb1gKvUx3Q==
X-CSE-MsgGUID: QXQUZPooRFGx20p8DlPy7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="73520517"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="73520517"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 03:44:10 -0700
X-CSE-ConnectionGUID: dSBoXgbYSNyTfGuRUaPTIA==
X-CSE-MsgGUID: m7xu9zO5Qb+n5S1ey7QKKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="244149218"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa002.fm.intel.com with ESMTP; 13 Mar 2026 03:44:08 -0700
Date: Fri, 13 Mar 2026 18:23:51 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org, aik@amd.com,
	bhelgaas@google.com, alistair23@gmail.com, lukas@wunner.de,
	jgg@nvidia.com, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 09/19] PCI/TSM: Support creating encrypted MMIO
 descriptors via TDISP Report
Message-ID: <abPlt8oNUOqGvbA3@yilunxu-OptiPlex-7050>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
 <20260303000207.1836586-10-dan.j.williams@intel.com>
 <yq5a4imuanoa.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5a4imuanoa.fsf@kernel.org>

> > +		if (last_bar < bar) {
> > +			/* transition to a new bar */
> > +			last_bar = bar;
> > +			/*
> > +			 * The tsm_offset for the first range of the BAR
> > +			 * corresponds to the BAR base.
> > +			 */
> > +			reporting_bar_base = tsm_offset;
> > +		} else if (tsm_offset < last_reporting_end) {
> > +			pci_dbg(pdev, "Reporting ranges within BAR not in ascending order\n");
> > +			return NULL;
> > +		}
> >
> ....
> > +		range_off = tsm_offset - reporting_bar_base;
> > 
> range_off will always be zero? Should we do

tsm_offset comes from Device Interface Report, MMIO RANGE, First 4k
Page. How do you interpret the exact meaning of this field?

My understanding is, it is the obfuscated host start pfn of this range,
if this range has offset to the BAR start, this field should also be
offsetted.

But if the first range in the BAR should be aligned to BAR, otherwise
there is no way for guest to position the range in the BAR.

So the logic here is:

  reporting_bar_base:	the first obfuscated pfn for the BAR, the BAR pfn
  tsm_offset:		the current obfucated pfn for the BAR.
  tsm_offset - reporting_bar_base: the offset to the BAR.

> 
>  		range_off = tsm_offset & (pci_resource_len(pdev, bar) - 1);
> 
> 
> So that we correctly handle if the interface report is reporting a range
> within a bar. The only requirement here is bar address should be aligned
> to its size and mmio_reporting_offset should not add offsets in that range.
