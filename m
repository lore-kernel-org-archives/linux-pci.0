Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7940B345741
	for <linux-pci@vger.kernel.org>; Wed, 22 Apr 2026 08:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776847764; cv=none; b=UQ/lp8uELphfcXEP5L7c8K6g3REvfYpGYsgY3vB2phjhk8vPQ8S6sYKNcSv0qVCpAIhQP6InnofbP0/itbjMFIu4UtrbL42jrqreBsww8GmARQepGzq4O3EbBsjq0xs9mSu2+2Zn5aINnZFswCMxjo73OaTsKOHIZUDrTDL+BSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776847764; c=relaxed/simple;
	bh=NdCz7ujO15wUOuWq3Q01ds9gmYJkDjMI5V3dMQNLTiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nIWHqZO1YSO+KRJyq+jov9qFBsaRPjIkj4jVTCsBd+ZDFHhI+9Gb1AuuTZD1sXZJmr5pEDozVHWnItZBFKkNMElIUvuGWpx0YLJwksZzak8fYN8XsPU9EfWUrxHWCkxWyOunJUQ7Mhr4hlU7B+NYgzhFyp4XChPtv5kEPLtdHhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=WWnkfq2M; arc=none smtp.client-ip=195.113.20.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="WWnkfq2M"
Received: by nikam.ms.mff.cuni.cz (Postfix, from userid 2587)
	id E9AF628055B; Wed, 22 Apr 2026 10:49:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1776847751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xsVFbMzRvJJ54nAl05mEkoPpQT7/4+OF4i4Kl7rcGJE=;
	b=WWnkfq2MrgWxzljXwhco1XiVYuz1bEx9NMNiHBeDXACb/cgXlyr4qVfbKJ4ZgJxy6boe22
	kaQlLs74Hj5ejdAYVue3UBix4W9bd0YcZcohEmFapoJjOA+95nwzhhQ6mQ3lXFCTjLM88D
	P0siDtWnmlIXn7+Oh4FQEHAQIEi3hK8=
Date: Wed, 22 Apr 2026 10:49:11 +0200
From: Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To: Bjarni Ingi Gislason <bjarniig@simnet.is>
Cc: linux-pci@vger.kernel.org, Guillem Jover <guillem@debian.org>
Subject: Re: Debian maintainer does not forward bug reports
Message-ID: <mj+md-20260422.080349.87303.nikam@ucw.cz>
References: <aee7asxxZ1qzg_EV@kassi.invalid.is>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aee7asxxZ1qzg_EV@kassi.invalid.is>

Cc: Guillem who is the Debian maintainer of pciutils; see below for
context.

Let us go through all outstanding bugs filed against Debian pciutils:

> #887113		pciutils: lspci does not detect sound for nvidia MPC67 on Pavilion DV9720us
> #775453		/usr/bin/lspci: "lspci does not detect nvidia geforce 210M on Asus UL80Vt"

These are likely kernel issues. Since they are a decade old, we should
ask the submitter for testing on a recent kernel.

> #656925		failure to detect PCIe Gigabit LAN

Not a pciutils problem, probably a missing kernel driver. It's from
2012, so it should be tested with a recent kernel.

> #774063		pciutils: update-pciids changes md5sum of pci.ids

This is specific to Debian. Another alternative would be to make
update-pciids store the downloaded file to /usr/local/share and let
libpci prefer this file over the one if /usr/share if it exists.

> #595328		/usr/bin/lspci: lspci reports wrong video ram size

It's from 2010, so I am not sure if it's worth investigating.

When a bug like this is submitted, please ask the author to provide
the output of "lspci -vvxxx".

> #640239		/usr/bin/lspci: lspci -t (-v) doesn't show bridges

We have rewritten the whole tree display code since this version,
I hope that this problem does not exist any more.

> #870000		pciutils: Debian Stretch freeze when I use "lspci"

Very likely a hardware bug. If it should be worked around, the right
place is the kernel.

> #924237		lspci shows wrong/misleading string instead of "Device xxxx"

Interesting... can you ask the submitter if they can reproduce it
with current pciutils?

> #1087569	pcilmr.8: Some remarks and editorial changes for this man page
> #1087678	pcilib.7: Some remarks and editorial changes for this man page
> #1099040	setpci.8: Some remarks and a patch with editorial changes for this man page

Bjarni, I assume that these are the bugs that triggered your message.
I don't see any Debian patches to pciutils man pages, so I will apply
your patches upstream.

> #585146		lspci: query the database for specific vendor/device IDs

This could be useful. I will consider adding this feature.

> #929984		lspci: please make -nn the default

I admit that it would help in some cases, but on the other hand,
it would make the default output more cluttered, so I don't think
it's a clear win.

				Have a nice fortnight
-- 
Martin `MJ' Mareš                        <mj@ucw.cz>   http://mj.ucw.cz/
United Computer Wizards, Prague, Czech Republic, Europe, Earth, Universe

---

> See
> 
> https://bugs.debian.org/cgi-bin/pkgreport.cgi?pkg=pciutils;dist=testing
> 
> -.-
> 
>   Additional remarks.
> 
>   Mails from me to "submit@bugs.debian.org" are no longer acknowledged.  A
> Debian maintainer told me, that he would contact the mail administrator
> about me not wanting to send bugs upstream.
> 
> -.-
> 
> From "/usr/share/doc/debian/bug-reporting.txt.gz":
> 
>   Don't file bugs upstream
> 
>    If you file a bug in Debian, don't send a copy to the upstream software
>    maintainers yourself, as it is possible that the bug exists only in
>    Debian. If necessary, the maintainer of the package will forward the
>    bug upstream.
> 
> -.-
> 
>   For forwarding bug reports to upstream see:
> 
> https://www.debian.org/Bugs/Developer#forward
> 
> -.-
> 
>   I do not send reports upstream if I have to get an account there.
> The Debian maintainers have one already.
> 
>   If I get a negative (or no) response from upstream, I send henceforth
> bugs to Debian.
