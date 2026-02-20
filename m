Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22141227EB9;
	Fri, 20 Feb 2026 14:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771597210; cv=none; b=nPPy2+hllIocI1ptqfl7I9jLf3eUNM/5UZVPk61XawRTrWIZa5gLNKpmv7zl28ONkjzHsToq9+W4Vjqd0YmijZcbb6JaxesFgRVSoMUnWSqLRJLfSqwErxbUF2iF1kcP2h+67GhTJM1ral9i/GYixgyCukkvxuY48mKPlsyp8+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771597210; c=relaxed/simple;
	bh=M/TFMsE/rIdlM6D3RjOXRKfFbPq00HS1pLS06RalxQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W6gZVcunU1Y2Piae6cLETN+2m4p2MxqJAI2zQlWlVho0jLSFeNFnDRrt176wNA5lC7JRsECBqz3IdIMQaPxK4rUzUgzRAzyhEaRvnILmDtMg2kmgWtT5l9DYh/z8vxjAyVRTwV3Xk7ETBnikJLZTheIs6OFjL1fRPYirP2HXpFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DOxRR9gJ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DOxRR9gJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771597209; x=1803133209;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M/TFMsE/rIdlM6D3RjOXRKfFbPq00HS1pLS06RalxQs=;
  b=DOxRR9gJ+o794mA5BaPRAbJdZzCaxHQaIhHgqeScF1QVpE226JHqdSA0
   0tMq+TI5680CyfE02Xr6CznGRee/98kGNn3+FKu8/N0LEbfSCywe+Z9ZC
   fzi+j102r0J5fY3nbQ7bV70IH6PBjFheM5MXSFpVsCFROJRmrDteB9rwB
   /zSDXx4uy7GADlDNmHkBzcGBxAt7zyK4Mozzfhmx4kOfC/ZhpnhsnweDi
   j03vG2z42GmQNrUYNfCHgEWtfT3X3s/rJiX/DXzxme3CKZNItozL9Au1n
   coE+e/V5HjGfBuifABF2S8V0B7oc5vP5VRE35/XynxQKRwl1FStMW6j+r
   A==;
X-CSE-ConnectionGUID: vwTh0nmnSOGV7eyFAstp7g==
X-CSE-MsgGUID: g6J6NJRjQVedadmmxb8qPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11707"; a="83008332"
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="83008332"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 06:20:08 -0800
X-CSE-ConnectionGUID: BLyi9VpNT0GBx1FKk6BgOA==
X-CSE-MsgGUID: D//tJJxTRISUETgN+4/0ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="219861466"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.25])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 06:20:05 -0800
Date: Fri, 20 Feb 2026 16:20:03 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v1 1/1] PCI: dwc: Remove not-going-to-be-supported code
 for Baikal SoC
Message-ID: <aZhtkyyORd1xqNNY@smile.fi.intel.com>
References: <20260220082438.2320616-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220082438.2320616-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 20, 2026 at 09:24:38AM +0100, Andy Shevchenko wrote:
> As noticed in the discussion [1] the Baikal SoC and platforms
> are not going to be finalized, hence remove stale code.

Need to drop YAML as well.

-- 
With Best Regards,
Andy Shevchenko


