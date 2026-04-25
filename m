Received: from master.debian.org (master.debian.org [82.195.75.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5CE39EF11
	for <linux-pci@vger.kernel.org>; Sat, 25 Apr 2026 22:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777156976; cv=none; b=YGSKLRZOuzTA9liVsaCSk5WhtXbqPg0Ecp/3BBDXGRcYROzs7XvBWbTj+agNUaK6mX6iIppbNv+8WVv8grj2AESoQFX8i029GQngik0Gmz6RJCpKv/iXqwguouM1PGTwQNdeGYpxUoZ4XgtK9exVDPr1tvJCCUzel3lVa0UO/3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777156976; c=relaxed/simple;
	bh=SUaC8kbHxFE29yFJ38TrMwBmdtDBigp1xWTb/wqOgeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n9pXwPbiCHVmFXjjBU+Z6WD4PP7ikp+4fyNjHAfEBqJUJ1CItnqfWtB9ShWpeM4fP+hH3YwZKsNQAleIAZEdpdNSi57+kj2qs4zZ7qkw1jC9RzyaZjXgE/FqZZEbvSYhzRW/88IM001YKMTbKYAUvwbi3Z+hcX5C5BlPFXCywsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=master.debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=spn10kUU; arc=none smtp.client-ip=82.195.75.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=master.debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="spn10kUU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.master; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description;
	bh=r5majvip2FMAT018+Nmrp5zFIP5nSBhbHJ0TM1EHnnk=; b=spn10kUU1LmDQM0jGVTt0fOBdb
	NPHevR9t4i5yH3phyUy2pAVFPz1bnF84Qh/OHfUqcalzxI3RC04aEWVBk6HxtoY7zZc6LooRdWc2z
	J2WUw4PfpUJdZuQiXF7MjbJAD86EvIpRQYLQO+1Ded4jeYBybFXDSctTKZWBBPq1vHIW7a5pon+LY
	mWdyIXMI5BwrzUsolXRLrWPL/z2Te8D3A1D/2H1d84ck3nHViLpM7IHzd8FEV5bPMbbUR/6Jy0mRZ
	+OnYeRNovtDSDTJ/4BvsF+o1w+/4W/1PTbNlKsOQ0Oqsj8HGKZX/IE8zuJOXjWjFr5u5gRy2Dwh92
	svR1Yaug==;
Received: from guillem by master.debian.org with local (Exim 4.96)
	(envelope-from <guillem@master.debian.org>)
	id 1wGlXy-004aRc-2U;
	Sat, 25 Apr 2026 22:32:22 +0000
Date: Sun, 26 Apr 2026 00:32:21 +0200
From: Guillem Jover <guillem@debian.org>
To: Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
Cc: Bjarni Ingi Gislason <bjarniig@simnet.is>, linux-pci@vger.kernel.org
Subject: Re: Debian maintainer does not forward bug reports
Message-ID: <ae1A9ZuAJPHW0S3H@thunder.hadrons.org>
Mail-Followup-To: Guillem Jover <guillem@debian.org>,
	Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>,
	Bjarni Ingi Gislason <bjarniig@simnet.is>,
	linux-pci@vger.kernel.org
References: <aee7asxxZ1qzg_EV@kassi.invalid.is>
 <mj+md-20260422.080349.87303.nikam@ucw.cz>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <mj+md-20260422.080349.87303.nikam@ucw.cz>

Hi!

On Wed, 2026-04-22 at 10:49:11 +0200, Martin Mareš wrote:
> Cc: Guillem who is the Debian maintainer of pciutils; see below for
> context.
> 
> Let us go through all outstanding bugs filed against Debian pciutils:

Ah, thanks for that. When I took over the package in Debian in 2019, I
had a brief look, but then never found the moment or forgot to really
go over all of them. :/

> > #887113		pciutils: lspci does not detect sound for nvidia MPC67 on Pavilion DV9720us
> > #775453		/usr/bin/lspci: "lspci does not detect nvidia geforce 210M on Asus UL80Vt"
> 
> These are likely kernel issues. Since they are a decade old, we should
> ask the submitter for testing on a recent kernel.

Ack, I've asked the reporters.

> > #656925		failure to detect PCIe Gigabit LAN
> 
> Not a pciutils problem, probably a missing kernel driver. It's from
> 2012, so it should be tested with a recent kernel.

Ack, I've asked the reporter.

> > #774063		pciutils: update-pciids changes md5sum of pci.ids
> 
> This is specific to Debian. Another alternative would be to make
> update-pciids store the downloaded file to /usr/local/share and let
> libpci prefer this file over the one if /usr/share if it exists.

I've had a couple of packaging changes for pciutils and pci.ids to switch
them to use alternatives:

  https://git.hadrons.org/cgit/debian/pkgs/pci.ids.git/log/?h=pu/alternatives
  https://git.hadrons.org/cgit/debian/pkgs/pciutils.git/log/?h=pu/alternatives

But never merged those, because then /usr/share/misc/pci.ids would
stop being known by dpkg, and then users cannot search for its owner.
Which is arguably a problem in dpkg itself, but…

At least the nice thing about the alternatives solution is that it defaults
to use the latest version of the file, where using a set of directories
(/var/lib/ comes to mind as perhaps better than /usr/local/share) with
fixed preferred order, would not have that property.

> > #595328		/usr/bin/lspci: lspci reports wrong video ram size
> 
> It's from 2010, so I am not sure if it's worth investigating.

I've closed this one as it was affecting a motherboard for 32-bit x86,
which Debian does not support anymore on real hardware.

> When a bug like this is submitted, please ask the author to provide
> the output of "lspci -vvxxx".

Thanks, I'll add a package script for reportbug to print a note to that
effect so that the submitter can see it in the template report to fill.

> > #640239		/usr/bin/lspci: lspci -t (-v) doesn't show bridges
> 
> We have rewritten the whole tree display code since this version,
> I hope that this problem does not exist any more.

I've closed this now, on your request.

> > #870000		pciutils: Debian Stretch freeze when I use "lspci"
> 
> Very likely a hardware bug. If it should be worked around, the right
> place is the kernel.

Ack, I've asked the reported whether this can still be reproduced.

> > #924237		lspci shows wrong/misleading string instead of "Device xxxx"
> 
> Interesting... can you ask the submitter if they can reproduce it
> with current pciutils?

Ack, done.

> > #1087569	pcilmr.8: Some remarks and editorial changes for this man page
> > #1087678	pcilib.7: Some remarks and editorial changes for this man page
> > #1099040	setpci.8: Some remarks and a patch with editorial changes for this man page
> 
> Bjarni, I assume that these are the bugs that triggered your message.
> I don't see any Debian patches to pciutils man pages, so I will apply
> your patches upstream.

Thanks, I think these just slipped through the cracks on my side.

> > #585146		lspci: query the database for specific vendor/device IDs
> 
> This could be useful. I will consider adding this feature.

Ah, great, let me know if you'd like a report filed upstream for
tracking.

> > #929984		lspci: please make -nn the default
> 
> I admit that it would help in some cases, but on the other hand,
> it would make the default output more cluttered, so I don't think
> it's a clear win.

Ack. I've closed this now.

Thanks,
Guillem
