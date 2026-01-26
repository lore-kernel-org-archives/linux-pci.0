Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8EA1FE44A;
	Mon, 26 Jan 2026 20:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769458193; cv=none; b=sEr3u89C+nc9fnKBflibt2aOdnlMRtFMgbAr+zRsLvfRwQI0A3yugCx+Ti18PhmDJkAmGbr8WhB7nPci6Bvr+lYAGi8d111q7QZ8cajumXjit17D3glRlNS0Vseh5WxrWF6G/dMupvkxHwht7+cF4HqDtgqFSpHiWM8mms2vbLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769458193; c=relaxed/simple;
	bh=oAHjMq6ZYOQ+ABlkzC+0J7uOwu9U3ncvzzjxxD1bIJk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YY7KUxhYikfrwlJ2aKStIf5Gess+hXpktbTGYKm0Vo61wT1l+w6CJn1c/L8KjRv3PsNB64KS2GigcyxwYYZA3rvS+XgRSlornLRLa6iwdq+31Wmiy5EMiRaH68R+8ZElTBj9+Nwr0GcO/4Z07/elNwbBM88A18c36FLvdYlu574=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nKbrSn5o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nKbrSn5o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 462BCC116C6;
	Mon, 26 Jan 2026 20:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769458193;
	bh=oAHjMq6ZYOQ+ABlkzC+0J7uOwu9U3ncvzzjxxD1bIJk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=nKbrSn5oKstqo02expVD5PHU4xVMr/AtW8t+OCf7aS4nc5RwTiItx6ItixtbVMAvz
	 X05hH76lAhZ6GBEL2UI+QG1+0BOLErcVGVHLsKbbtWJ4IJjFEFPo1nn1V8gjyPAMFM
	 7nMrrPOViJoIHlnEtyPjpgLraMbSCioM8fvLhKvvaFFMTUEV01Gh15iRFFCWL+AIwZ
	 7D0OaTN7hQheI3x3wwfctaAxDTWmWww633HhrSUs6bihPilAFVua0l/y9DjM9GqfVk
	 9m3c5LMMjyYaagof1gglR71wYoWOFFLUEXnsQeXkEb06IssUSbF0xalHfMpr4D2ayZ
	 sDWsx3YfDJQfg==
Date: Mon, 26 Jan 2026 14:09:51 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	linux-kernel@vger.kernel.org,
	Simon Richter <Simon.Richter@hogyros.de>
Subject: Re: [PATCH 05/23] PCI: Remove old_size limit from bridge window
 sizing
Message-ID: <20260126200951.GA301074@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260126171601.GA249217@bhelgaas>

On Mon, Jan 26, 2026 at 11:16:01AM -0600, Bjorn Helgaas wrote:
> On Fri, Dec 19, 2025 at 07:40:18PM +0200, Ilpo Järvinen wrote:
> > calculate_memsize() applies lower bound to the resource size before
> > aligning the resource size making it impossible to shrink bridge window
> > resources. I've not found any justification for this lower bound and
> > nothing indicated it was to work around some HW issue.
> > 
> > Prior to the commit 3baeae36039a ("PCI: Use pci_release_resource()
> > instead of release_resource()"), releasing a bridge window during BAR
> > resize resulted in clearing start and end address of the resource.
> > Clearing addresses destroys the resource size as a side-effect,
> > therefore nullifying the effect of the old size lower bound.
> > 
> > After the commit 3baeae36039a ("PCI: Use pci_release_resource() instead
> > of release_resource()"), BAR resize uses the aligned old size, which
> > results in exceeding what fits into the parent window in some cases:
> > 
> > xe 0030:03:00.0: [drm] Attempting to resize bar from 256MiB -> 16384MiB
> > xe 0030:03:00.0: BAR 0 [mem 0x620c000000000-0x620c000ffffff 64bit]: releasing
> > xe 0030:03:00.0: BAR 2 [mem 0x6200000000000-0x620000fffffff 64bit pref]: releasing
> > pci 0030:02:01.0: bridge window [mem 0x6200000000000-0x620001fffffff 64bit pref]: releasing
> > pci 0030:01:00.0: bridge window [mem 0x6200000000000-0x6203fbff0ffff 64bit pref]: releasing
> > pci 0030:00:00.0: bridge window [mem 0x6200000000000-0x6203fbff0ffff 64bit pref]: was not released (still contains assigned resources)
> > pci 0030:00:00.0: Assigned bridge window [mem 0x6200000000000-0x6203fbff0ffff 64bit pref] to [bus 01-04] free space at [mem 0x6200400000000-0x62007ffffffff 64bit pref]
> > pci 0030:00:00.0: Assigned bridge window [mem 0x6200000000000-0x6203fbff0ffff 64bit pref] to [bus 01-04] cannot fit 0x4000000000 required for 0030:01:00.0 bridging to [bus 02-04]
> > 
> > The old size of 0x6200000000000-0x6203fbff0ffff resource was used as
> > the lower bound which results in 0x4000000000 size request due to
> > alignment. That exceed what can fit into the parent window.
> > 
> > Since the lower bound never even was enforced fully because the
> > resource addresses were cleared when the bridge window is released,
> > remove the old_size lower bound entirely and trust the calculated
> > bridge window size is enough.
> > 
> > This same problem may occur on io window side but seems less likely to
> > cause issues due to general difference in alignment. Removing the lower
> > bound may have other unforeseen consequences in case of io window so
> > it's better to do leave as -next material if no problem is reported
> > related to io window sizing (BAR resize shouldn't touch io windows
> > anyway).
> > 
> > Reported-by: Simon Richter <Simon.Richter@hogyros.de>
> 
> I guess this report was
> https://lore.kernel.org/r/f9a8c975-f5d3-4dd2-988e-4371a1433a60@hogyros.de/,
> right?

And this looks like a regression in v6.18 that will persist in v6.19.

Is that the right thing?  I wonder if we should move these first five
patches to pci/for-linus so they land in v6.19?

> > Fixes: 3baeae36039a ("PCI: Use pci_release_resource() instead of release_resource()")
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  drivers/pci/setup-bus.c | 11 +++--------
> >  1 file changed, 3 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > index 612288716ba8..8660449f59bd 100644
> > --- a/drivers/pci/setup-bus.c
> > +++ b/drivers/pci/setup-bus.c
> > @@ -1071,16 +1071,13 @@ static resource_size_t calculate_memsize(resource_size_t size,
> >  					 resource_size_t min_size,
> >  					 resource_size_t add_size,
> >  					 resource_size_t children_add_size,
> > -					 resource_size_t old_size,
> >  					 resource_size_t align)
> >  {
> >  	if (size < min_size)
> >  		size = min_size;
> > -	if (old_size == 1)
> > -		old_size = 0;
> >  
> >  	size = max(size, add_size) + children_add_size;
> > -	return ALIGN(max(size, old_size), align);
> > +	return ALIGN(size, align);
> >  }
> >  
> >  resource_size_t __weak pcibios_window_alignment(struct pci_bus *bus,
> > @@ -1298,7 +1295,6 @@ static void pbus_size_mem(struct pci_bus *bus, unsigned long type,
> >  	resource_size_t children_add_size = 0;
> >  	resource_size_t children_add_align = 0;
> >  	resource_size_t add_align = 0;
> > -	resource_size_t old_size;
> >  
> >  	if (!b_res)
> >  		return;
> > @@ -1364,11 +1360,10 @@ static void pbus_size_mem(struct pci_bus *bus, unsigned long type,
> >  		}
> >  	}
> >  
> > -	old_size = resource_size(b_res);
> >  	win_align = window_alignment(bus, b_res->flags);
> >  	min_align = calculate_head_align(aligns, max_order);
> >  	min_align = max(min_align, win_align);
> > -	size0 = calculate_memsize(size, min_size, 0, 0, old_size, win_align);
> > +	size0 = calculate_memsize(size, min_size, 0, 0, win_align);
> >  
> >  	if (size0) {
> >  		resource_set_range(b_res, min_align, size0);
> > @@ -1378,7 +1373,7 @@ static void pbus_size_mem(struct pci_bus *bus, unsigned long type,
> >  	if (realloc_head && (add_size > 0 || children_add_size > 0)) {
> >  		add_align = max(min_align, add_align);
> >  		size1 = calculate_memsize(size, min_size, add_size, children_add_size,
> > -					  old_size, win_align);
> > +					  win_align);
> >  	}
> >  
> >  	if (!size0 && !size1) {
> > -- 
> > 2.39.5
> > 
