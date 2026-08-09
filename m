Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C642C3290A5;
	Sun,  9 Aug 2026 08:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786263943; cv=none; b=dRu6YknQgMMKZZsyYx88nW5mVYygBtMuynzKewFweeunK66dD0p+koB3MSQlsTPrX60/ZnsgEbH5+IZ5whR0JZd58piG/S1fHFmhUDu1NIHcPHyTSqY0coyqTJxnKG2fxufkJ2jj0+qpKQA0FOUey5w9ogHXHqreYNc+Wln0wlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786263943; c=relaxed/simple;
	bh=97N97kIRB7s33pCDon+Q5UzXBbcqfWcCannAkDee/4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lIsP1F/3hHq19nBZjrDkAH1z2OaecKaWIDVRLfVYr488n8cxNW2E/ZlrbgOGH3+lXFoiFhJvORgG0Zki6x0z1qHkcBj80bkS8XelcDUK2aYf9D89GvdobgLJ6e1Wsa3Vl1HVcKF3WyG0ysR5Ws7zCTwxA1HS3gId0WUqs7auFt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NYd0QOmy; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NYd0QOmy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786263940; x=1817799940;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=97N97kIRB7s33pCDon+Q5UzXBbcqfWcCannAkDee/4A=;
  b=NYd0QOmyvNOl+RT2+UWg1Hf6OcWJVxZ6eGew+CdSOf/pi5uc9zeE67z8
   L6FWh0OxcpIr8Vc1btCZYPz7oCbYlpoEFDe9J/M7tQFrGO5+ovnYHLkjK
   OHnp+z9A+xgAa+n6OWNu21QAH8jlbuUKPKTzVrpudpIu5TgbQiikeY/DY
   apDzdSqY6aDfdQ2BuU8GGU9Y4HpLd8GsswfG9jXa4lco01COj7PLOlIxl
   BdBsNDwRnWlkYnSKOnQ/nd9pOdeu2PubTTXnLANyTZG1/mZJDdoBvliTU
   YxK+wdwA3CYpMhbGN1g4xOQ6vobF6OXxrvE9UKClX0xHZZ94Zolb4ARkD
   Q==;
X-CSE-ConnectionGUID: ePSaCUeGQZukOdix3uNDXg==
X-CSE-MsgGUID: tpWEFZbrSuS8hepB7Ml1gQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11869"; a="86918006"
X-IronPort-AV: E=Sophos;i="6.25,213,1779174000"; 
   d="scan'208";a="86918006"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2026 01:25:40 -0700
X-CSE-ConnectionGUID: 4x1j/aakQaGlMH8JRUaX1w==
X-CSE-MsgGUID: 7zKcS3CRTjK6UPo/2ITKIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,213,1779174000"; 
   d="scan'208";a="258465322"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.25])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2026 01:25:37 -0700
Date: Sun, 9 Aug 2026 11:25:35 +0300
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
Message-ID: <ang5fyuOzQkCSmlC@ashevche-desk.local>
References: <andqwn7I-YCDqmXI@ashevche-desk.local>
 <20260808234530.GA402575@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260808234530.GA402575@bhelgaas>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Aug 08, 2026 at 06:45:30PM -0500, Bjorn Helgaas wrote:
> On Sat, Aug 08, 2026 at 08:43:30PM +0300, Andy Shevchenko wrote:
> > On Sat, Aug 08, 2026 at 12:23:07PM -0500, Bjorn Helgaas wrote:

...

> > > +	if (res->flags & IORESOURCE_MEM) {
> > 
> > Besides we have resource_type() macro, why only this? I would expect
> > IO as well as 64-bit MEM version.
> 
> We could use resource_type() here, but would have to check other bits
> directly (IORESOURCE_PREFETCH, IORESOURCE_MEM_64, etc) since they're
> not included.

Sure.

> I considered including IO and certainly could do that.  IO resources
> are smaller and it's not as interesting, but maybe we should.
> 
> 64-bit MEM resources are already included because they have both
> IORESOURCE_MEM and IORESOURCE_MEM_64 set.

Is it guaranteed to have MEM when MEM_64 is set?

...

> > > +		*p++ = ' ';
> > > +		*p++ = '(';
> > > +		string_get_size(resource_size(res), 1, STRING_UNITS_2,
> > > +				size_buf, sizeof(size_buf));
> > 
> > > +		p = string_nocheck(p, pend, size_buf, str_spec);
> > 
> > Why do you need this? Use returned value from string_get_size() directly.
> 
> string_get_size() doesn't return a char * like string_nocheck() et al
> do.  We could do something like "p += string_get_size(..., p, pend - p)",
> but it's a little messy

See the use of string_escape_mem() in the same file.

> because the return value is the length that
> *would* have been written if it was truncated, so I think we'd have to
> check for "p > pend".  I'll ponder this one.

Yes, and that's exactly what we want from the vsnprintf() as a returned value.
What I mean is to use the given buffer directly without any intermediate one.
The *p++ = 'xxx' will become an idiomatic

	if (end > ...)
		*buf = 'xxx';
	++buf;

which vsprintf.c is full of.

> > > +		*p++ = ')';
> > > +	}

-- 
With Best Regards,
Andy Shevchenko


