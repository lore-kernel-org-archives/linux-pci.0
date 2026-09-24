Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5051A6814
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 11:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790247821; cv=none; b=DaG1qvFZtUuM8M+L4VaqvD7yYFnRMYlv1w5bnSaXwXSWFrQOXVvEFdeNj70/0DCZF2cm9w89Cks7222slw+awb/rm+C3hXy4tQk1Z5HlfTpKfgH40d595+KP9puAvNG7UM/X79KDW5OBnw4URN+70yWpWuB7g9MMtB+6rgA+02I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790247821; c=relaxed/simple;
	bh=IhabpTLczNnSHQ0UJk2NzC+d4ckaiZ88UI5IfHfDiAk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Sjb+5bx+9zvAzJWnUryUgtKuhG5mnBM/QOyS+iycbCeIOW0P9svFmoR88ysR/O+Q6HP3SSG7VJEfoTPrWbUntSRaN1PwxKCxyBEpRkSiy2icbzvjzIHUoil4l9vmVOFIxYCJiwo74d5QYca782WR8MbWUHSh+rL7CX/U4KhQwQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X2CSM7eb; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X2CSM7eb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790247820; x=1821783820;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=IhabpTLczNnSHQ0UJk2NzC+d4ckaiZ88UI5IfHfDiAk=;
  b=X2CSM7ebLsvmjRl92OW1z8fYTfoN9zrqgKx9w/YFdcYFVXmH4GKT2GF1
   xVkA0KcUN77ZR1F59976w3wwT8ywURKfddlQixdzk/0Zy9DafIZn7cmjP
   VedwxAxVTXrOBIavIeStAT+j8ldFRJIVL876EvLztLvj55qDr9rSQ2Dar
   Jc++7YcojOwf+fdMxAKlfdwnjMxjzx3bDa7F6L431IY2GrNC95019RfTS
   ZunKXwMNCLXWKFvoZVXfKGIY3oyk5rlP0IURVgHYmWzUJP6JvYqczGZuk
   skiDoY3zZAmr8SejS/4T+KgTwpsSRAF948zKTVly09AFd4/21UVFMZXBV
   w==;
X-CSE-ConnectionGUID: Vpud5gDmQU+/4FXDqupb9Q==
X-CSE-MsgGUID: 3VPz+TnbTX+HfvhXDjswJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="101186713"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="101186713"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 04:03:39 -0700
X-CSE-ConnectionGUID: XKhCMxK0SkGEqi9xCjf9dw==
X-CSE-MsgGUID: IzzmPFaURc6e1HBUr37y5Q==
X-ExtLoop1: 1
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.183])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 04:03:37 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 24 Sep 2026 14:03:33 +0300 (EEST)
To: sashiko-reviews@lists.linux.dev
cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH 3/5] PCI: Place resources to either edge of the window
In-Reply-To: <20260923132848.B7A451F000FF@smtp.kernel.org>
Message-ID: <9aa21437-c8c1-8b51-62aa-aeaa64854f1f@linux.intel.com>
References: <20260923131757.7792-1-ilpo.jarvinen@linux.intel.com> <20260923131757.7792-4-ilpo.jarvinen@linux.intel.com> <20260923132848.B7A451F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-467248736-1790245410=:1187"
Content-ID: <98b81c16-5dbd-a0e4-5742-f88e0aba1a5b@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-467248736-1790245410=:1187
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <1cc40ac6-288f-1647-2d71-a8848471b11d@linux.intel.com>

On Wed, 23 Sep 2026, sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] pci: undefined behavior from 64-bit resource sizes on 32-bit sys=
tems
> - [Medium] pci: res->end + 1 overflow breaks natural alignment logic
> --
>=20
> commit 65c3dea851ed27dd4bf3576e0a9387eaa7359798
> Author: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> Subject: PCI: Place resources to either edge of the window
>=20
> This commit updates the PCI resource assignment phase to use a window edg=
e
> aware resource assignment algorithm. It alters the greedy assignment logi=
c
> to place resources either to the left or right edge of the window to avoi=
d
> fragmenting contiguous free space.
>=20
> > diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> > index eacce9e2486bf..1ab5d167ab5c6 100644
> > --- a/drivers/pci/setup-res.c
> > +++ b/drivers/pci/setup-res.c
> [ ... ]
> > @@ -262,16 +265,80 @@ resource_size_t pci_resource_alignment(const stru=
ct pci_dev *dev,
> >  =09return resource_alignment(res);
> >  }
> > =20
> > +static resource_size_t pci_max_natural_size(const struct resource *res=
,
> > +=09=09=09=09=09    resource_size_t *max_align)
> > +{
> > +=09resource_size_t size =3D resource_size(res);
> > +=09resource_size_t powof2, natural_start;
> > +
> > +=09*max_align =3D 1;
> > +=09if (!size)
> > +=09=09return 0;
> > +
> > +=09powof2 =3D rounddown_pow_of_two(size);
>=20
> [Severity: High]
> Does this code inadvertently truncate 64-bit resource sizes on 32-bit sys=
tems?
>=20
> When a 32-bit kernel is built with a 64-bit phys_addr_t (like x86 PAE or
> ARM LPAE), passing a 64-bit size into rounddown_pow_of_two() casts it to =
an
> unsigned long. If the size is a multiple of 4GB (which is common for larg=
e
> GPU BARs), the lower 32 bits are silently truncated to 0, causing powof2 =
to
> be evaluated as 0.

This is a pre-existing issue. PCI core already uses __ffs() which is based=
=20
on unsigned long (at least on x86).

There's also a serious discussion in x86 space about future of 32-bit=20
support where keeping it wastes development effort:

https://lore.kernel.org/all/bd252483-fb0a-4818-bfaf-b9b6ebd187fe@intel.com/

The non-trivial cost here is avoiding the problematic generic helpers=20
(custom coding them) or fixing ffs() and round*_pow_of_two() when input=20
size > sizeof(unsigned long), for ability to run >=3D4GB BARs on a 32-bit=
=20
platform. Yeah, modern GPUs have big BARs but running them on a 32-bit=20
platform doesn't sound that great combination.


That being said, I think round*_pow_of_two() interface should be made
to return same type as the input because it simply doesn't make sense to=20
convert the value to some other type. I briefly looked into that earlier=20
but it requires auditting that all the callers can handle that (IIRC,=20
there were even some build failures from making just the type change and
there could be logic flaws as well if something relies on type expansion
to unsigned long).

> > +=09natural_start =3D ALIGN(res->start, powof2);
> > +=09if (natural_start >=3D ALIGN_DOWN(res->end + 1, powof2)) {
>=20
> [Severity: Medium]
> Could this boundary check overflow if the window ends exactly at ~0U?
>=20
> If a 32-bit system maps PCI space just below the 4GB boundary, res->end
> could be 0xFFFFFFFF. In that scenario, res->end + 1 wraps to 0, which
> causes ALIGN_DOWN(0, powof2) to return 0. The check natural_start >=3D 0 =
then
> unconditionally evaluates to true for unsigned types, incorrectly forcing
> the algorithm to halve powof2 and potentially failing to pack memory wind=
ows
> tightly.

This will be fixed by subtracting 1 from the aligned result to underflow=20
it back from 0 to ~0.

> > +=09=09powof2 =3D max(powof2 / 2, 1U);
> > +=09=09natural_start =3D ALIGN(res->start, powof2);
> > +=09}
> > +
> > +=09if (natural_start) {
> > +=09=09*max_align <<=3D __ffs(natural_start);
>=20
> [Severity: High]
> Does this trigger undefined behavior when passing a truncated 64-bit valu=
e?
>=20
> Similar to rounddown_pow_of_two(), __ffs() takes an unsigned long. If a
> 64-bit natural_start is a multiple of 4GB, the cast truncates it to 0.
> Passing 0 to __ffs() invokes undefined behavior, which can lead to
> unpredictable results or kernel panics during boot (such as garbage shift
> amounts or arch-specific trap instructions on zero inputs).

Sashiko knows no shame with rather bold claims. I'm pretty sure the answer=
=20
should have fit into its context window, no matter how small that was. ;-)

> > +=09} else {
> > +=09=09/*
> > +=09=09 * Zero address has infinite alignment, return the largest
> > +=09=09 * representable number even if it's not a power of two.
> > +=09=09 */
> > +=09=09*max_align =3D RESOURCE_SIZE_MAX;
> > +=09}
> > +
> > +=09return powof2;
> > +}
>=20
>=20

--=20
 i.
--8323328-467248736-1790245410=:1187--
