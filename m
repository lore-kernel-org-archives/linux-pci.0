Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DC93E0C53;
	Mon,  2 Mar 2026 13:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772459875; cv=none; b=OdhkILhY8S7LF8I3sR139nlQzQFPur/DklAQCZ+pJXPyYJY/3T3CXO5gG6QI4IqVjT+wgS3Y2a3hVWynTSnDWzhW5lmDEj9OZKZXPLNMOMC5ZcMo1KGP14gifMgaRVL1fEDNqZvBD+IhXaRUf5Ak6cLezR1fc8rkzeP7Jj2W9H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772459875; c=relaxed/simple;
	bh=9P/mj5fTPf8mwPASxXPVk84iarRxlQeiB27I1MVpN9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dqjWtsDTenb8omVya9xe8R5lqWN3dNjcr3cU+kyyA1VsvUeNljgY+88HP4hZDqDuJvopQYW+Yk/8MKQh1yCv9zhHIh/UZibLfLLMOSUHDD0/QOFzpeyrCfnvWAWfDntbUfim18C1DTAUXU1y7AIPqj+/7DN921o6MHLjffimQ/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gYz/VRAh; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gYz/VRAh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772459873; x=1803995873;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9P/mj5fTPf8mwPASxXPVk84iarRxlQeiB27I1MVpN9c=;
  b=gYz/VRAhu+V31TbYzLUqZze3XbDDdeRZjKCzUBjOd0PxZB+pgugsLvF8
   rHpfqXC15nN0vUlKLIXsLqnHFljr8EcveFpqb14hzum9t0sZcaP2QTMMr
   1y7onBDhsvWtXbsJ4qTzLcGOYj9YIPQ6l/4ukF+lomZUkr175z3IFbxJc
   LU1/d8UxfrR1mo57x+ALhDsWuRqahIuAbBVDvoRClAs/C7zhn1FdImzCK
   NsQOj5Jw/cHIbL8CjXu8bRrzhpcb7OPz1Z63I5n8gTxpio3+r6c07k/BK
   4v7rDcScX/k+XMTLVxsOZ8tYtfm8lTNty2yKYZP8+dfa26Vi+6goWjNS5
   g==;
X-CSE-ConnectionGUID: h80nNO/GSZqcq27Qz9wp2A==
X-CSE-MsgGUID: +DcgimfVR6OXmMRIaGM6HQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="91041561"
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="91041561"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 05:57:52 -0800
X-CSE-ConnectionGUID: 9uKRkdOpSmu5dHKqDPo/Zg==
X-CSE-MsgGUID: ueuMSJAqSnKEWHTcLsGulA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="217683290"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.52])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 05:57:49 -0800
Date: Mon, 2 Mar 2026 15:57:46 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 1/1] PCI: dwc: Remove not-going-to-be-supported code
 for Baikal SoC
Message-ID: <aaWXWka5GpHEBjD3@ashevche-desk.local>
References: <20260220142600.2397070-1-andriy.shevchenko@linux.intel.com>
 <ndzk3mcrkymcf3ru7my6om6llkbc6w4paxmgyqab4b46txxjr7@2upwgzrnlu7s>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ndzk3mcrkymcf3ru7my6om6llkbc6w4paxmgyqab4b46txxjr7@2upwgzrnlu7s>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 02, 2026 at 07:21:22PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Feb 20, 2026 at 03:21:12PM +0100, Andy Shevchenko wrote:
> > As noticed in the discussion [1] the Baikal SoC and platforms
> > are not going to be finalized, hence remove stale code.
> > 
> > Link: https://lore.kernel.org/lkml/22b92ddf-6321-41b5-8073-f9c7064d3432@infradead.org/ [1]
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> I see Arnd's comment in the above thread:
> 
> "I don't think we'll merge the rest of Baikal, we should probably
> remove the entire platform."
> 
> But is there more to the story?

The Baikal enterprise is Russian entity under OFAC sanctions.

-- 
With Best Regards,
Andy Shevchenko


