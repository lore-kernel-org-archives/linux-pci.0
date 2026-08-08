Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED40935E92B;
	Sat,  8 Aug 2026 17:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786211017; cv=none; b=rZPBgYHmOEicQh5Uujx64sH1iTlymkv6JisFB5pvRKf60doTT57Y7rwFpdbofTQ9LHKvR+gcbDDSq5H19TlC5w5XcrDyFfeCzpiT/qxadYRsHgCJ1iOpcN/w6vOovWjMPUT7M4SygqYQLlsp+oW+c4yeGyuS0WDV1XM4ztKpbKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786211017; c=relaxed/simple;
	bh=MuHABUpPV5DLxSQxsdtT5LCRKr/QSp6Bgk4/bYJSBvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uqvkzIGfLdmMrYz4L6NWdVNZ8WwFi3W3oSajwe/6PbJ51pe8PObJahHwJi1/a7dyPAO6/Q7b/hjkCJzPk5dTranoUW7oDGQr0cg5TnH0Etjluk0OmdZh6IVivsAaTmwiSV+RlFxkFSOlCND+hLygpz7EG1PV8SRpjnkbyb7rtrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QKJZizue; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QKJZizue"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786211016; x=1817747016;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MuHABUpPV5DLxSQxsdtT5LCRKr/QSp6Bgk4/bYJSBvI=;
  b=QKJZizue1/ng8ox1Jl7Q5nmARYgZL5oRpSw0+TCGlQAju6tLMkBNwatG
   T8we+TR2u0qpYV3/fG45KWHXbwqxENp6/JDvzE4QCNcWd7tWgzlx296f1
   v4UkkEXyl14ggD3FDfB9GeM/pKmRjKQiZBIcVGb4GcAzxkKSFvURgyArV
   CBWrcRWsEeQz4W5g0dMG9ucCwN/cBMF6VOEQxh6YLfITRqQ1ozUJ7DEWo
   L4GFAG7OMy0BDG21zJQ1q0AerklyTfrCjiDHaxn7InpvRsW3yHUi20WeA
   dnbz61ha+t1Qfevk1TiBp9UGXcxlnT/c6Qhh+/La5v2OZtuvEaCO7YJ+j
   g==;
X-CSE-ConnectionGUID: lgtuAH4dSRqEmz2piFHA6Q==
X-CSE-MsgGUID: 9x6xEDGEQeyfAsHL2nvkWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11869"; a="86865437"
X-IronPort-AV: E=Sophos;i="6.25,212,1779174000"; 
   d="scan'208";a="86865437"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2026 10:43:36 -0700
X-CSE-ConnectionGUID: NP/faML/SleAiE+4pNb6Nw==
X-CSE-MsgGUID: IZkDKfo0SemMROYCn4RD0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,212,1779174000"; 
   d="scan'208";a="259342499"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2026 10:43:33 -0700
Date: Sat, 8 Aug 2026 20:43:30 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v1 1/2] vsprintf: Add %pR human-readable size
Message-ID: <andqwn7I-YCDqmXI@ashevche-desk.local>
References: <20260808172308.282591-1-bhelgaas@google.com>
 <20260808172308.282591-2-bhelgaas@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260808172308.282591-2-bhelgaas@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Aug 08, 2026 at 12:23:07PM -0500, Bjorn Helgaas wrote:
> Include human-readable size when printing struct resource memory ranges
> (not including DMA, bus number, or I/O port ranges) with the %pR format to
> make it easier to read, e.g.,
> 
>   - pci 0000:00:02.0: BAR 0 [mem 0xfea80000-0xfea9ffff]
>   + pci 0000:00:02.0: BAR 0 [mem 0xfea80000-0xfea9ffff (128 KiB)]

...

>  lib/vsprintf.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)

Sorry, we do not accept this without added test cases.

...

> +	if (res->flags & IORESOURCE_MEM) {

Besides we have resource_type() macro, why only this? I would expect IO as well
as 64-bit MEM version.

> +		*p++ = ' ';
> +		*p++ = '(';
> +		string_get_size(resource_size(res), 1, STRING_UNITS_2,
> +				size_buf, sizeof(size_buf));

> +		p = string_nocheck(p, pend, size_buf, str_spec);

Why do you need this? Use returned value from string_get_size() directly.

> +		*p++ = ')';
> +	}

-- 
With Best Regards,
Andy Shevchenko


