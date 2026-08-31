Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BD537DEAA;
	Mon, 31 Aug 2026 18:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788202070; cv=none; b=D4SGQwaspvwQB03M1qFCXgu+kyCXxDh3Zy6Df+z+7D9TbZN3u+IRFZBeohP/dAeXMQPY4Kp4ijwguOBOUcDnvOyQhlrOFiR48R15JaqJkBABkrUpLf85SwZWWrV+02kksy7oNAQUKdsEN8gmGq33ntfvJ27E1XGcD3+4rBUPjKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788202070; c=relaxed/simple;
	bh=SbC85oh43xK1cq/2ldnnTnGpw2ddhsw9CYnzDkYxAds=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZIUzhpI6Jy3SHk9RE9uMCXHAdiMvHXeBFm0bAbu3Ii/vR6sRR/3fAWDY91sCb35EyANTgUe94pHbgApS7GPAXpL7QCrcntvybD49fK0YMVL+AQTI5KBAOHxBaUExjQLWa+18OaHaH75aS0JQvLRM0qQ4NITL4iPCCijuHft0BJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F5O2x/q+; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F5O2x/q+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788202068; x=1819738068;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=SbC85oh43xK1cq/2ldnnTnGpw2ddhsw9CYnzDkYxAds=;
  b=F5O2x/q+5ZorcLUxwin77jfZBj0QpugvJVOIqg5x2hCjp6VIjhB0MKiL
   fe7NscYQJ2VVhBvUQwAyrzV5rV5foNfFue9GXL07wlHHK7pSbIIxAjVWo
   /W0qM5yMAfw58kNH60kUTMZWy7mikKesfgaPUYv7Zaf/VkpqMZjSGcL0w
   bXV/SfCyKADwOuxBHm9X/4+a+ie7iUR8R0QKI3CAQsFUbpgM8gYP43D4r
   ZrdVJ4XviYpRQOP3hVtVIDuxnec7DOdwpz8OFqXZlji7TNxmzE9JOUuWb
   EmAWFtmKTdDskaUJEc02fgsXgeQcwXsemN37eEcYXVdCudySbqFtupXXX
   Q==;
X-CSE-ConnectionGUID: AFgHITYoSSyL8xi3eUtKCQ==
X-CSE-MsgGUID: ytpYAnE3QD++VaD4/mxx4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="88742423"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="88742423"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 11:47:47 -0700
X-CSE-ConnectionGUID: QoeNdtnTThOlEpqDltVbiQ==
X-CSE-MsgGUID: 4NjnaTqCQ92FjParRuNGiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="267066138"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.121])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 11:47:44 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 31 Aug 2026 21:47:41 +0300 (EEST)
To: Geramy Loveless <gloveless@jqluv.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, alexander.deucher@amd.com, 
    amd-gfx@lists.freedesktop.org, mario.limonciello@amd.com, 
    nra3088@gmail.com, 
    =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>, 
    meiling.leung@embeddedllm.com, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: Reserve prefetchable window headroom for Resizable
 BARs
In-Reply-To: <7771e88e-9cdf-4415-97ac-69d15c015d1e@jqluv.com>
Message-ID: <034f9ce3-3c50-b0f2-8ac7-e6180242de00@linux.intel.com>
References: <39e09dd8-f73e-4dc2-ba36-8a9228516d26@jqluv.com> <fba65262-5490-4d60-d06d-9badaafc7e17@linux.intel.com> <7771e88e-9cdf-4415-97ac-69d15c015d1e@jqluv.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1847860086-1788202061=:2637"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1847860086-1788202061=:2637
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 31 Aug 2026, Geramy Loveless wrote:

>=20
> On 8/31/26 9:31 AM, Ilpo J=C3=A4rvinen wrote:
> > On Fri, 28 Aug 2026, Geramy Loveless wrote:
> >
> >> Firmware typically sizes prefetchable bridge windows for the boot-time
> >> BAR size. Behind a fixed (non-hotplug) PCIe switch fabric, there is th=
en
> >> no room for a driver to grow a Resizable BAR afterwards: every window
> >> from the leaf up to the root is sized for the small BAR, so
> >> pci_resize_resource() fails with -ENOSPC.=20
> >>
> >> Furthermore, a small prefetchable BAR (e.g., a 2 MiB doorbell) sharing=
 a=20
> >> bridge's single prefetchable window with a much larger one (e.g., a 32=
 GiB=20
> >> VRAM BAR) pushes the required window size past the large BAR's alignme=
nt.=20
> >> Because bridge windows round up to a power of two,
> > Do they??? In which kernel version I must ask??
> I'm sorry this was in reference to a prior patch I made, **ignore**
> >
> >> this forces a massive=20
> >> alignment waste (e.g., 32 GiB + 2 MiB rounds up to a 64 GiB window,=20
> >> wasting ~32 GiB per GPU).
> > The largest I've seen is 32GB + half of that. And that's not with the=
=20
> > latest kernel.
>=20
> This is in reference to when there are two R9700s on one switch basically=
=2E
> As far as my understanding currently how it works is that when there are =
two GPUs they both have a BAR0, BAR2, and BAR5 the BAR5 goes onto the 32-bi=
t window.
> Bar 0 and 2 don't go onto the second window by default as they could over=
fill it of course, bar 0 would not fit period, and 2 might which is the cas=
e I took.=C2=A0
> This allows BAR 0 on (GPU 0) in leaf 0 on window 0 to align as a multiple=
 of 32G like it I guess has to? This is how I understand it, so if R9700 ha=
s 32G on, bar0, leaf 0, window 0, and share the same window as GPU 1 then w=
e have to pad the space between GPU0 BARs on window 0 by 32G, meaning BAR2 =
really is also using 32G, its not possible or at least right now its not po=
ssible to move BAR2 to the end of all the allocations it doesnt fit the sta=
ndards? Keep in mind this is not my specialty here I am trying my best to u=
nderstand and solve the issue at hand.

With the empty space in between, your 64GB calculation would indeed be=20
true, but that wasn't what you said because you made an inaccurate claim=20
about window sizes being power of two in case of 32G+2M.

(I suppose we're generally in agreement here but just ended up discussion=
=20
on finer details and the interpretation of those details.)

> >> This patch solves both issues to enable ReBAR on cascaded switch fabri=
cs:
> >>
> >> 1. Reserve Headroom:=20
> >> Reserve prefetchable window headroom for the maximum size of each=20
> >> downstream Resizable BAR during the bridge sizing pass. The device BAR=
=20
> >> and hardware ReBAR are left at their boot size to prevent tearing down=
=20
> >> firmware-loaded state (e.g., AMD R9700 PSP) before the driver binds.
> > ... reorganizing ...
> >
> >> Fallback / Alignment logic:
> >> If the 32-bit space is exhausted, small BARs remain in the prefetchabl=
e=20
> >> window. The alignment logic gracefully handles this by rounding the br=
idge=20
> >> window up to the next power of two (e.g., growing to 64 GiB to fit a 3=
2 GiB=20
> >> BAR + BAR2) to maintain PCIe compatibility, ensuring sibling GPUs land=
 in=20
> >> properly aligned slots.
> >>
> >> Reserving is safe by default: __assign_resources_sorted() satisfies al=
l
> >> required resources first. Use pci=3Dno_rebar_reserve and pci=3Dno_bar_=
demote=20
> >> to restore previous behaviours.
> >
> > And how does this fallback, if the largest size doesn't fit? What are t=
he=20
> > failure modes?
>
> So if the smaller bars under 16M don't fit in the 32-bit addressable=20
> space the fallback mode is to do as I said above to your prior comment,=
=20
> basically put.=20
> Don't move the 2M BAR2 over to the 32-bit addressable space / window and=
=20
> instead fallback to aligning the prior window by the size of the GPUs=20
> memory space as I understand it, when you have gpu0 and gpu1 both=20
> requiring 32GB their address has to be a multiple of their allocation=20
> size? meaning we get 32G for BAR0 and 32G for BAR2 even though BAR2 only=
=20
> needs 2M because its not aligned to allow GPU1 to be on a aligned space?

I'm more referring to the case where the big ReBARs cannot be assigned as=
=20
space runs out or some other BAR fails to assign because ReBAR took "too=20
much", and the numerous ripple effects from that. When that happens in=20
some system for something important breaking something, you'd have to=20
solve that problem too or this change gets reverted...

> > It's correct that the sizing decision should be done in pbus_size_mem()=
=20
> > but it must not result in breaking things which a naive approach like=
=20
> > this will surely do.
> >
> > Without proper fallbacks done, there will be too much breakage it's a=
=20
> > showstopper for a naive patch like this.
> >
> > Basically, what we'd want to do is try with the largest size, then redu=
ce=20
> > it one step at a time (because it's 2^n -> 2^(n-1) even one step saves=
=20
> > quite much so one might not need to reduce that many steps). But also, =
in=20
> > some IOV enabled cases the oversubscription of the space is very=20
> > substantial and you'd still want to maximize the BAR sizes to what is=
=20
> > allowed by the available space.
> >
> > Fallback is hard to implement, because sizing and assignment are quite =
far=20
> > from each other codewise and there are no structures to carry informati=
on=20
> > over to the next retry phase.

=2E..And that's why there should be proper fallback so that failing one=20
assignment somewhere middle will not result in failure in the end.

Basically, my own plan is for the algorithm to try smaller sizes until all=
=20
things fit. And all that retry logic is far from simple.

--=20
 i.

--8323328-1847860086-1788202061=:2637--
