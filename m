Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10E9175A88;
	Sat,  8 Aug 2026 17:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786211288; cv=none; b=gMxfGjEXhfVV+4OdCsyBAIMSwGbk68m11/vYX/vCwOedrVd8zLBa0gzlSb+Y/z+XVLrfABuR5aRLlGEIGgHBZGnkjnrNFwh4imNVaUJcbTCeXJl/z48Geiq0o8hRlRGrDsm4HjfxaYboG8bhIu0s6b9EMVcbGSxz4FTfRFbp1pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786211288; c=relaxed/simple;
	bh=udZh5+mwEy3zAgvnM4aJ8CEwgLEiSTA/Swzt9ojhPg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fbCmmIBRsT3JbQbFkj9rLwDAHwpEDYAVankWyBYtweWTXmznZM9PZNWvaKweiB0d00kL/MX3AukXTbuSj8nQnrQRp+bIRSqxSMMOGAiXV+IKmJB4k0UR7Js+y3bsWaHAAuL+pAK7Qcuppp1d4/GsKy9TJfsaWgeYSYQtc/pK1Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eeaCBe77; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eeaCBe77"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786211286; x=1817747286;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=udZh5+mwEy3zAgvnM4aJ8CEwgLEiSTA/Swzt9ojhPg4=;
  b=eeaCBe77p4jQe/5AglQPR2xy9tmKdng4rt93wPajD774KHH2CxHTBSIU
   uw0Yy9zhmxsRVTFsex94u2k/Mt64SgTAz/vaPCfonkzktJNK6W39X5kO6
   ammyOwoaoBqLXeVMtFIhACPUeRYeh+InHqR2RUKDY14S4FB0FVrxaIDgm
   gFDT75jFEloX6iMr4dAHf2CL0Mtj5RGT3YVHoMQVnEyw/lh9WO2Q6J1mC
   cZkXw8mTi6COxJgKRPXMt2I9oe2s2USse5o56P3v4OwZjleiYSh5Yn+NI
   mYO5jIjh+FcH/z1E8gF5lEJEVHX8qPCvX6YPh8qkMkGEAToQsPM380uFV
   A==;
X-CSE-ConnectionGUID: MSWa49MwQeKyeEa6WFS//Q==
X-CSE-MsgGUID: NSwbhFfATKWyf6hxELOihw==
X-IronPort-AV: E=McAfee;i="6800,10657,11869"; a="86865531"
X-IronPort-AV: E=Sophos;i="6.25,212,1779174000"; 
   d="scan'208";a="86865531"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2026 10:48:06 -0700
X-CSE-ConnectionGUID: i8LAKvUaRfaCVJTltKysoQ==
X-CSE-MsgGUID: UYslffwvSSeMEgSy1MpxFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,212,1779174000"; 
   d="scan'208";a="259343070"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2026 10:48:03 -0700
Date: Sat, 8 Aug 2026 20:48:00 +0300
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
Subject: Re: [PATCH v1 2/2] PCI: Include human-readable sizes in resource
 assignment messages
Message-ID: <andr0LDPlgD5kEzT@ashevche-desk.local>
References: <20260808172308.282591-1-bhelgaas@google.com>
 <20260808172308.282591-3-bhelgaas@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260808172308.282591-3-bhelgaas@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Aug 08, 2026 at 12:23:08PM -0500, Bjorn Helgaas wrote:
> Include human-readable sizes, e.g., "16.0 MiB", in addition to the hex
> "0x1000000" size, in resource-related messages.  Also consistently include
> the "0x" prefix.

Instead of repeating many times the %#llx (%s) and accompanying
string_get_size() calls can we rather introduce a (sub-)extension
to %p[R] (perhaps against 'R' to print only size) and use it?

-- 
With Best Regards,
Andy Shevchenko


