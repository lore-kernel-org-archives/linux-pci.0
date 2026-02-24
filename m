Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596923A0E8B;
	Tue, 24 Feb 2026 17:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771953935; cv=none; b=Yf/fZqWewPBmDM6mJ2fr7R2GxSPUtaIi1GYmhetYNln2yBJHcHR4BiauX/PfBs7I9Y7N7QUGeAiePiZnGrFwenPoU0lpknaaG5ZdnPa1i13rPTj85NLPYFiPFP7TqRfkcBUivcFhgNi9pLBj4jVzeKGN2I6nWVeoYsmNGQZ4sX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771953935; c=relaxed/simple;
	bh=3VJKf0JqagyAT1Xwu5Z+Nhs214HfA+S4HT/ophousRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZSamPGHAZh3gsWFqtFhlQp/VejIUb1ub98bkryCIbjFcPcfTXFdDihkdq8Wp1x+wdijC/3ynJXNMD1tve188yrWH2aPPrCCJRtlIkkvT1iCJf/BTpfna+hoiPbFn5tvb3FiVNXyiAddnJkC6+nCU6y7ayN65aG/UAyWKXjMPE3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GThBuJ4y; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GThBuJ4y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771953934; x=1803489934;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=3VJKf0JqagyAT1Xwu5Z+Nhs214HfA+S4HT/ophousRg=;
  b=GThBuJ4ylBJLSC5gfycy6H4vy9K4vwsH3WvaBi/rPnQrJLjJHHuIsk1+
   qzVkMOfzlNJRDlFsJWh6zAoAelu3ajrtcwgiWMibXcdWL0KsejrZNmpGN
   PVHN5BWrsq+rM2TtvSwpZ8ckE2Fw34pILN3aq5p6/19fGELixWTNaQ6zJ
   GZdJgCcmoKXxWWQLwduzFBGBsMrj9/uQMC8fAD0l3EUyMi0+oEEc4lj7m
   y46Gd/0BhOOjwxHEVM6BuIumpqHjocoRYKnlfn4DqeySNyUEOXLDP+Tcl
   Kkum8O/gLRoZZnEiRkbZOTARvC1Z7ykMP5skkHvP8jj/UZY8BawyZDpKr
   Q==;
X-CSE-ConnectionGUID: hOUME9cZT1GY52sOVMCFHw==
X-CSE-MsgGUID: ZF2UwMsuT7q3I/cHNKYWNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="76586111"
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; 
   d="scan'208";a="76586111"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 09:25:34 -0800
X-CSE-ConnectionGUID: Q7wr2mKyR7Wo4UXYp9ojOQ==
X-CSE-MsgGUID: peeZ0oKXT+mxeuddzAIIRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; 
   d="scan'208";a="213192920"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.146])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 09:25:31 -0800
Date: Tue, 24 Feb 2026 19:25:29 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Matlack <dmatlack@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Bartosz Pawlowski <bartosz.pawlowski@intel.com>,
	David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>,
	Raghavendra Rao Ananta <rananta@google.com>
Subject: Re: [PATCH] PCI: Disable ATS via quirk before notifying IOMMU drivers
Message-ID: <aZ3fCdkCIAW-Q4-k@smile.fi.intel.com>
References: <20260223184017.688212-1-dmatlack@google.com>
 <aZy6cge_a9a7O03g@smile.fi.intel.com>
 <CALzav=f+p3bcq78dunjEqTOhRHxr8WhTxojYNwJOdYH49p0_Hw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALzav=f+p3bcq78dunjEqTOhRHxr8WhTxojYNwJOdYH49p0_Hw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 24, 2026 at 09:19:05AM -0800, David Matlack wrote:
> On Mon, Feb 23, 2026 at 12:37 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Feb 23, 2026 at 06:40:16PM +0000, David Matlack wrote:

> > > Fix this by disabling ATS via quirk during "early" fixups instead of
> > > "final" fixups.
> >
> > Hmm... Sounds to me like a premature disablement, but I leave it the experts.
> 
> What do you mean by "premature disablement"?

On early stage instead of final stage.


> > What I think about the case, that IOMMU should be probably fixed to avoid such
> > situation for all level of quirks. Can it be feasible?
> 
> What do you mean by the "IOMMU should be fixed"? Are you saying the
> IOMMU should be prepared to handle quirks disabling features on
> devices after the IOMMU driver is notified about a device?

Something like this, yes. At least the commit message is unclear why
"This fixes at least one bug in the Intel IOMMU driver..." not in IOMMU
driver code.


-- 
With Best Regards,
Andy Shevchenko


