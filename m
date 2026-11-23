Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795428742;
	b=QNTaw14eCkMdYNwlSRDaLj8I46P1trI5PVfWAhrlKKRnHqhmj2M6sckzNVPj1Ud8Pymy
	 w5CKBVYyo8j7jSCyohAXG/hitqJopcOTOq+eeafjWOoQ7uDGJKcZGDBYfEp9Z/hOWmHu/
	 ie+elcPfErE1+9IdWehOEtgKveaXirWYXzYTCeV/z3HzkOrNo5Kpjh/K1W0nF7ipvbWyh
	 1KZM/C1Rz2Dojnlq52YSQ9+HfGu1Bbqnl8kVFGYpSFl1Pgit4xe1DErN/R5ISi6c97r7+
	 +qoqbXlMcZ4dBs5KB6N5GV5xb7aZAzku6OQLsdCv+qD+Qmnk7o9LuzgJjrgMwwyULYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795428742;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=ni8CyQa6iIUsnR+CCXF9vQOiK5prjpZYIKGoPxBO0e0=;
	b=s4Yzf6UDTYD1dO6ciHypRw/wV1bzCoEUwlFK7KHiokoxxCs6nSCUSC5SQX5iAzlfpCBg
	 55OlVFtqj34BVPZqWCekHbxOPMyGZ1Db07b63SwLgasu2eLDDxu3+Up3f64MhuBLS4VYy
	 VObTFn6x4031HU76ZM31qI1drNohHUnWVbr9QG42Jy80j2Xswn+bn2cl5GyFfkLaVwh8u
	 Pxi1Goz1BrxahyAg/Qu6r/HtVxJXJV2XHtdILaWYqA0mVkrr9dzE5IsdRQr2ibEpJhGjt
	 1E6Nc0CcdTR48r+PBTggSx/7vxqYycMLor6ZCnOqmc4gx2dhZ1y/im9igJf60Ds4Suw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Bknpezj0;
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E899B606A31A;
	Mon, 23 Nov 2026 10:12:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E899B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Bknpezj0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795428742; x=1826964742;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=b6Fvc/zAnl3+9ZtthK7Eqri0H3sbMfvblGongTr+wf4=;
  b=Bknpezj0PXFllnnuyC3ZdvVvIn0nNYIgkE8thKlqjcUYzvKd85nQVV0Z
   1dxf6j9RDyNmVQEiPiBy4tZpDEFi0DaI+F9xDz1nzghpNkAtRmqlI2/6c
   pt1lAWo3jiVQPuDgEpEwJd8D9QkSsvqwTtl/mkN0FgrRsIIBxE023x8vQ
   fWDp0H0czH0+uT6P+lKXFd1HVsB0A1NOkNCtYU8SUdOm2tuDfyRE1pnwc
   6FiXLvZ6C3hsMsmwo8K6dpx9P4nBZTrXGv5/H7MVdSXHeyqZW67PhkyZL
   GxOwH6t/As1l9fY6TWIlp59XH9B/P7P8mf4YzayP9GxVxsTWygj0HGXYE
   w==;
X-CSE-ConnectionGUID: kT0Dzk0cTUKFJAnyQbe6sw==
X-CSE-MsgGUID: L3YycvuARR6uXjAnXH+QwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4218419"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4218419"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 02:12:21 -0800
X-CSE-ConnectionGUID: pnlRSAmPRlqgVD8wBtUYNA==
X-CSE-MsgGUID: X/GIl15JSMWL35sOxfG9CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="11464339"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.204])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 02:12:19 -0800
Date: Mon, 23 Nov 2026 12:12:16 +0200
From: "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>
To: Habil Eren =?iso-8859-1?Q?T=FCrker?= <habilerenturker@hotmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/4] PCI: Convert pci.c to pci_power_t helpers
Message-ID: <awQRgPkcBnfEYKoe@ashevche-desk.local>
References: <20261121130936.53191-2-habilerenturker@hotmail.com>
 <20261121130936.53191-4-habilerenturker@hotmail.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261121130936.53191-4-habilerenturker@hotmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Nov 21, 2026 at 01:12:33PM +0000, Habil Eren Türker wrote:
> Convert PCI core code to use the pci_power_t helper functions
> when accessing the Power Management Control/Status register.
> 
> Keep comparisons between values already typed as pci_power_t
> as direct typed comparisons.
> 
> Resolved Sparse warnings:
> 
> - drivers/pci/pci.c : warning: incorrect type in assignment
>   (different base types) (4 warnings)
> 
> - drivers/pci/pci.c : warning: invalid assignment: |= (3 warnings)

...

> -	state = pmcsr & PCI_PM_CTRL_STATE_MASK;
> +	need_restore = !(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET) &&
> +			(pci_power_t_eq(pci_power_t_get(pmcsr), PCI_D3hot) ||
> +			dev->current_state >= PCI_D3hot);

Broken indentation. They should start from the same column as '!' above.

...

The rest looks fine.

-- 
With Best Regards,
Andy Shevchenko


