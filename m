Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E69430B96;
	Mon,  2 Mar 2026 13:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772458474; cv=none; b=KkYTSuVntmQ+SkVlelH2JsifBy6wI8LLvwfg/NYqs0lFTCAz2orWmCUjZLNYFjzk9gSE662fPvgWmxEEET3e7iYQoNKO2m1mQoMeInLYaVAVvM5ImdiIbs5BPO8p5Ju7uzetbLgzks3pZqRAW0yRHVMYvyfF0megZWAYXsPXIGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772458474; c=relaxed/simple;
	bh=eav+j/40O8nK+MuZLnmeNCASbcgkY4UsZ5EW/ZCMs2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GyHhEUQZIE8L59087wQyuBMzivCqrTEHytKI9HbYO51EFD7uCPRzMjY4ZjtJmAW39xFPMnrZxLJRjhxKvHE7eKbRcN7iOen6O993apiw+4xACZRngSjti0DyOuQYrTVvcTJtR6vZ92AZDassEIxjTUe7v/vRUCVo8+WZNpN+FUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UvoO3lW4; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UvoO3lW4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772458474; x=1803994474;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eav+j/40O8nK+MuZLnmeNCASbcgkY4UsZ5EW/ZCMs2k=;
  b=UvoO3lW4xCdEGNi5Xd5DURgSMzvR+YHkXa533ZJGdQJadQmMmq1cypz7
   cRE7xQwH7lLQuxAlizsix0uaSMbsFjv6Xzjw4210LxGxOXS+oO6QekdGR
   ylckwb4JDLd6INg0luBideoryDTNLcYX/CdNxGV5FvYCQP55AdWWFFss3
   9xcHhsJUMxLPlbrwpQmlzq9r+dSVc4xsqX6dL7QEyPJScv4tD0LIBg8ov
   Kv5bKpRUcWtTN1nRQd6tawt1mkUR3rqXcNnd9RJRExOe+T+d0oclspQrh
   iH3E/SkVxy78ftRweda7AICHm9h0P61nOXQlviKOPHf1nZfkBFB0q8D+8
   w==;
X-CSE-ConnectionGUID: /a/JDo/pT7q7bp+aUL+rcg==
X-CSE-MsgGUID: iHPfYl8nScqSz+D52YRDTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="84167849"
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="84167849"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 05:34:33 -0800
X-CSE-ConnectionGUID: HTLfsgFXSviZlnlskKbi4w==
X-CSE-MsgGUID: 4JWchqCvQD+hWSjd/OtEvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="240669193"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.52])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 05:33:51 -0800
Date: Mon, 2 Mar 2026 15:33:49 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 1/1] PCI: dwc: Remove not-going-to-be-supported code
 for Baikal SoC
Message-ID: <aaWRveAPxWpHosPs@ashevche-desk.local>
References: <20260220142600.2397070-1-andriy.shevchenko@linux.intel.com>
 <177187310274.163191.14167430732235845058.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177187310274.163191.14167430732235845058.robh@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 23, 2026 at 12:58:24PM -0600, Rob Herring (Arm) wrote:
> On Fri, 20 Feb 2026 15:21:12 +0100, Andy Shevchenko wrote:
> > As noticed in the discussion [1] the Baikal SoC and platforms
> > are not going to be finalized, hence remove stale code.

> Acked-by: Rob Herring (Arm) <robh@kernel.org>

Thanks, Rob!

Any chances to see this in PCI tree?

-- 
With Best Regards,
Andy Shevchenko


