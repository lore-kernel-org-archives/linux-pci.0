Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45F43A6F0B;
	Mon, 24 Aug 2026 08:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787559526; cv=none; b=cqUP8pYqGrEAaQfs5k0jMXemhfoqRWtvAMQv4X3Dyt7d/zFsPyvOltio/gOyR/kXcofPhpYfVHI2Eq8m+rEt8nhQtBRYIjWfiGtGiLaSVXewzuTjbZw363IernWXgqa6c+gP5h3GwAT4zt8+/t3A1JJV6DFvIHMKZNyDXhaV2No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787559526; c=relaxed/simple;
	bh=dYBx1billie+1dEcHx+Hfu2gKYUIO7TxH7zQLmkOVRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DKLQHy2+DmzXGKQ2PcadjkW7OeTD+rrkply8VW92Mom7/2g0nNTDgE6QY7N0/0u2RWMb+IuFqAjKQujVeXcS6G8SfZO91VLFUVEQdhwGJbATpnMYH3yW9NhTcAcYkpWm84u3kCBH3W1smKvcceX7kP3bGxKWt5vhQC+2+TbX6Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lm8mvqJ2; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lm8mvqJ2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787559525; x=1819095525;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dYBx1billie+1dEcHx+Hfu2gKYUIO7TxH7zQLmkOVRg=;
  b=lm8mvqJ2t1z3J/bP/rszcGcyd/I+Tfp2cXv3keLA1H9XRx+V3mjilfRa
   3Ub2kwvFqUEvdsVNyoYXUapcZmi5N4DihpY5abxGeHDT30rXCs76zYQik
   dTuwBJXte03cOm0CAPgz5wwBRLD7NgEQATQq9pse28BiSDAyogWp3EqSC
   lWkdK8qJVYsFjhCJIvO9RtAZiHEMfgAEd/UNfN1zJ/OqW/0R2uRDq+VYD
   ASvP/eewu92b8hOIVPFziBDuLYVld5XkN3X7q6z1c2DcZoFn/pDAC9C9e
   j5UMy8wXTq+PQ3ruBhj4qvqah9tWZgsrY6MumtN9VcBkBlT+7/JSuU2Ae
   g==;
X-CSE-ConnectionGUID: krVlUNWBQV6Ap+EEJgipQQ==
X-CSE-MsgGUID: CBxH6eSrS+uHDsg1NY1dTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="87769529"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="87769529"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 01:18:44 -0700
X-CSE-ConnectionGUID: MV/ZGA7tRu6HKEe4n/rDBA==
X-CSE-MsgGUID: kYQ8/NSmTQOeyffvp+PFsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="264318645"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.130])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 01:18:42 -0700
Date: Mon, 24 Aug 2026 11:18:39 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v1 2/2] PCI: Include human-readable sizes in resource
 assignment messages
Message-ID: <aov-X5UILIDfSkK6@ashevche-desk.local>
References: <20260808172308.282591-1-bhelgaas@google.com>
 <20260808172308.282591-3-bhelgaas@google.com>
 <andr0LDPlgD5kEzT@ashevche-desk.local>
 <aohWvp0bSeK-Xk9r@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aohWvp0bSeK-Xk9r@pathway.suse.cz>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 21, 2026 at 03:46:38PM +0200, Petr Mladek wrote:
> On Sat 2026-08-08 20:48:00, Andy Shevchenko wrote:
> > On Sat, Aug 08, 2026 at 12:23:08PM -0500, Bjorn Helgaas wrote:
> > > Include human-readable sizes, e.g., "16.0 MiB", in addition to the hex
> > > "0x1000000" size, in resource-related messages.  Also consistently include
> > > the "0x" prefix.
> > 
> > Instead of repeating many times the %#llx (%s) and accompanying
> > string_get_size() calls can we rather introduce a (sub-)extension
> > to %p[R] (perhaps against 'R' to print only size) and use it?
> 
> I am not sure if I understand it correctly. It looks to me that
> this patch uses string_get_size() for printing some "arbitrary" size
> values. Some are not part of struct resources, so using %pRR
> might be confusing.

AFAICS (but I might have missed something) they all can be containered into
the local variables of type 'struct resource' and then be used with that
extension directly. So, I don't see that it will be confusing.

> Unfortunately, implementing a generic printf modifier for printing
> human readable size is complicated. It should keep the type-size
> checks. Also it should allow to distinguish binary vs decimal
> size calculation, for example 1kB vs 1kHz for 1024B vs 1000Hz.
> See https://lore.kernel.org/all/ZbFd5TZ_pi7q3hso@casper.infradead.org/

I have an idea about this, but I think it's too premature for that type
of extension. So far, this series (AFAIU) is only about known type and
hence known units to print with the format also kinda fixed.

-- 
With Best Regards,
Andy Shevchenko


