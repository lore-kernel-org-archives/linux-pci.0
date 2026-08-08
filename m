Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF1F255F28;
	Sat,  8 Aug 2026 23:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786232733; cv=none; b=eGC1JQpyvmM7zqe/ZdYj7/fs3FCwSXlVv66rSVgZsCDjkQ1GUKGNVTRSKrE4c1f/YBNm8r4fkn38kKkzNerZ1z3oXdMEclSv29REMhiUmHNkpjPQ9JcZiC/U4bIbg1IEGg9F7Bdwn/fyoraYykpytoSnwV06cIu+uXdmKoyRbkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786232733; c=relaxed/simple;
	bh=VKG37MXSGBkwRD4+qasywOcn+zrIJlhtTF1OULPwsqU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fnQQgMB1eUmxMSqfGOqEXvrAMC61PiqpkoBvfxriZX9QW23V4/58VlefUnXocDh1UPeeSJPwhr6gSpZa3aJY64HFYqajrdGimTQq9zkplmtjZp/BbOVOAjQNkxlJw1DGaFU+nlDoqJfN+vHpGvm9oacKnBjLUZJL4IWnRXWdRRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bADhdRvl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bADhdRvl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81E5A1F000E9;
	Sat,  8 Aug 2026 23:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786232731;
	bh=pkqnrFOxcZE3IxmrDZIC3skk0xLyvyD7clFk7nwFXT8=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=bADhdRvldb9hEA8yfeuMtrjhWGE45gmOjd7m4GScnIkIWYx2PTsCvN18KQYbxmPdW
	 OXX4lyByNiRDuN+VwRfnHK0IizCOTEZGZhB6lhv6jEVUvhrMm5ap9cKaDX6C99UpjD
	 jppzMv5JbMDd1DVgkJA0VtXNAEZ6xRfDfbOOK6SYALHF6N/MAM/TQNxFsFKZnGxUZs
	 9vPvXrq2TfyUlOhNPiPNZX2au9t6NzdsbAEqJ7nEq35eRfJTsM64IshqiFvcaxUxE4
	 N9uxKh0H8haizRSl03djrY27FkrXhp7NpLfDxfRUuBlNyPgISy/epGfHaJl4sgn5j3
	 iJ3cnMtdetZXg==
Date: Sat, 8 Aug 2026 18:45:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v1 1/2] vsprintf: Add %pR human-readable size
Message-ID: <20260808234530.GA402575@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <andqwn7I-YCDqmXI@ashevche-desk.local>

On Sat, Aug 08, 2026 at 08:43:30PM +0300, Andy Shevchenko wrote:
> On Sat, Aug 08, 2026 at 12:23:07PM -0500, Bjorn Helgaas wrote:
> > Include human-readable size when printing struct resource memory ranges
> > (not including DMA, bus number, or I/O port ranges) with the %pR format to
> > make it easier to read, e.g.,
> > 
> >   - pci 0000:00:02.0: BAR 0 [mem 0xfea80000-0xfea9ffff]
> >   + pci 0000:00:02.0: BAR 0 [mem 0xfea80000-0xfea9ffff (128 KiB)]
> 
> ...
> 
> >  lib/vsprintf.c | 18 ++++++++++++++----
> >  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> Sorry, we do not accept this without added test cases.

TIL about these tests, they look great and I'll fix this up and update
printk-formats.rst as well, thank you!

> ...
> 
> > +	if (res->flags & IORESOURCE_MEM) {
> 
> Besides we have resource_type() macro, why only this? I would expect
> IO as well as 64-bit MEM version.

We could use resource_type() here, but would have to check other bits
directly (IORESOURCE_PREFETCH, IORESOURCE_MEM_64, etc) since they're
not included.

I considered including IO and certainly could do that.  IO resources
are smaller and it's not as interesting, but maybe we should.

64-bit MEM resources are already included because they have both
IORESOURCE_MEM and IORESOURCE_MEM_64 set.

> > +		*p++ = ' ';
> > +		*p++ = '(';
> > +		string_get_size(resource_size(res), 1, STRING_UNITS_2,
> > +				size_buf, sizeof(size_buf));
> 
> > +		p = string_nocheck(p, pend, size_buf, str_spec);
> 
> Why do you need this? Use returned value from string_get_size() directly.

string_get_size() doesn't return a char * like string_nocheck() et al
do.  We could do something like "p += string_get_size(..., p, pend - p)",
but it's a little messy because the return value is the length that
*would* have been written if it was truncated, so I think we'd have to
check for "p > pend".  I'll ponder this one.

> > +		*p++ = ')';
> > +	}
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
