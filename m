Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27BC1799F;
	Thu,  5 Mar 2026 16:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772728115; cv=none; b=rA+cZ2MlkUnJHueS98F86nrVZmq2hH0wy3H/V0YI1wO9lC0b5LSq2HVhnlcXoeAWMC+OEgp86MYCSUfzJQE96oIPES4iNhuitJrckh0N0kjTE0Yq69a+utgQUmlGRo2Bb6Leqg5jj5xWcmBq+p+yw06i/gbaHRoIlpcsDiPOk/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772728115; c=relaxed/simple;
	bh=v1wftEvl2mbsdX9DP/H8GfKsJ+POz+rS4yMQ6yjPq+k=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GgCCKbpojBKYLBL9Tao6h3xKxmZ1dv4Y9Lozw12MCx4wVeWBe5BvEnfnZ1heg3o58B6GnHqm9aYkHmQ3Ba+bNsDEiKnrZqoDYi0OcvUEtp8kLvDjsS8O37sj2YrUwxbXkkObPCi0M8PL7u6W3zBcek53+3FETdLNPoe4D3H29HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HrdHBbub; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HrdHBbub"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772728114; x=1804264114;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=v1wftEvl2mbsdX9DP/H8GfKsJ+POz+rS4yMQ6yjPq+k=;
  b=HrdHBbube2Y8Ai02R9bxDjIXxZ0ATEUuo1gqXGOIa6fJyQM2Nf3v5muO
   Igl8Yx8dVRf7qJKU9/QYZWYYBVeLLx2V8w//9vc66BaYElvdk2DwCaH8O
   DDqB+BHheUSwQ24EHZaS96O272myUNdsC4gq42Jn5xIYaAA0ykFeYyvvw
   RUkNy3GmvrXDrWbMFze9Q+s4siboio0Rwx+TzQdVWIcy+Cfsh3jUuO/mb
   UnrUMW5owK/keyGEhjMPUISB6MmK4pdYyYOVyC74ooyl6wNkUpKAOtmIs
   8VLHoKS0R73p81YH/s3pusCeJpwO032PfDZpklgdPz5ydVAwz+fHqCTH8
   g==;
X-CSE-ConnectionGUID: nBALu2niQp2DaVNWIvpRFQ==
X-CSE-MsgGUID: oczpjqSvRaKVVgXxzEG7Fg==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="77693322"
X-IronPort-AV: E=Sophos;i="6.23,103,1770624000"; 
   d="scan'208";a="77693322"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 08:28:33 -0800
X-CSE-ConnectionGUID: cxs4tIzMRtG821g/27X9kQ==
X-CSE-MsgGUID: lQZ8qY1lTqOG/9htZgyIug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,103,1770624000"; 
   d="scan'208";a="256624222"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.93])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 08:28:31 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 5 Mar 2026 18:28:27 +0200 (EET)
To: Guenter Roeck <linux@roeck-us.net>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    Dominik Brodowski <linux@dominikbrodowski.net>, 
    LKML <linux-kernel@vger.kernel.org>, 
    =?ISO-8859-15?Q?Malte_Schr=F6der?= <malte+lkml@tnxip.de>
Subject: Re: [PATCH 03/23] PCI: Stop over-estimating bridge window size
In-Reply-To: <b05a6f14-979d-42c9-924c-d8408cb12ae7@roeck-us.net>
Message-ID: <0b62833c-5ac1-4205-2510-a62431f30dd5@linux.intel.com>
References: <20251219174036.16738-1-ilpo.jarvinen@linux.intel.com> <20251219174036.16738-4-ilpo.jarvinen@linux.intel.com> <b05a6f14-979d-42c9-924c-d8408cb12ae7@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-864570821-1772728107=:1083"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-864570821-1772728107=:1083
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 5 Mar 2026, Guenter Roeck wrote:
> On Fri, Dec 19, 2025 at 07:40:16PM +0200, Ilpo J=E4rvinen wrote:
> > New way to calculate the bridge window head alignment produces
> > tight-fit, that is, it does not leave any gaps between the resources.
> > Similarly, relaxed tail alignment does not leave extra tail room.
> >=20
> > Start to use bridge window calculation that does not over-estimate
> > the size of the required window.
> >=20
> > pbus_upstream_space_available() can be removed.
> >=20
> > Tested-by: Malte Schr=F6der <malte+lkml@tnxip.de>
> > Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> > ---
>=20
> Google's experimental AI code review agent produced the following feedbac=
k.
> It seems real to me, but I may be missing something. PTAL and let me know
> if it has a point.
>=20
> If it is a real problem, it may have been fixed by a later patch which I
> may have missed. If so, my apologies for the noise.

Thanks. It looks a real problem to me.

> Thanks,
> Guenter
>=20
> ---
> commit 3958bf16e2fe1b1c95467e58694102122c951a31
> Author: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
>=20
>     PCI: Stop over-estimating bridge window size
>=20
>     New way to calculate the bridge window head alignment produces tight-=
fit,
>     that is, it does not leave any gaps between the resources.  Similarly=
,
>     relaxed tail alignment does not leave extra tail room.
>=20
>     Link: https://patch.msgid.link/20251219174036.16738-4-ilpo.jarvinen@l=
inux.intel.com
>=20
> > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > index cd12926a72af..25d6d4d3afc1 100644
> > --- a/drivers/pci/setup-bus.c
> > +++ b/drivers/pci/setup-bus.c
>=20
> [ ... ]
>=20
> > @@ -1409,13 +1346,8 @@
> >  =09=09=09=09continue;
> >  =09=09=09}
> >  =09=09=09size +=3D max(r_size, align);
> > -=09=09=09/*
> > -=09=09=09 * Exclude ranges with size > align from calculation of
> > -=09=09=09 * the alignment.
> > -=09=09=09 */
> > -=09=09=09if (r_size <=3D align)
> > -=09=09=09=09aligns[order] +=3D align;
> > -=09=09=09aligns2[order] +=3D align;
> > +
> > +=09=09=09aligns[order] +=3D align;
> >  =09=09=09if (order > max_order)
> >  =09=09=09=09max_order =3D order;
> > =20
> > @@ -1429,38 +1361,19 @@
> > =20
> >  =09old_size =3D resource_size(b_res);
> >  =09win_align =3D window_alignment(bus, b_res->flags);
> > -=09min_align =3D calculate_mem_align(aligns, max_order);
> > +=09min_align =3D calculate_head_align(aligns, max_order);
> >  =09min_align =3D max(min_align, win_align);
> > -=09size0 =3D calculate_memsize(size, min_size, 0, 0, old_size, min_ali=
gn);
> > +=09size0 =3D calculate_memsize(size, min_size, 0, 0, old_size, win_ali=
gn);
>=20
> Does the removal of the `r_size <=3D align` check cause bridge window siz=
e
> underestimations if we have child resources larger than their alignment?

It's not really what I'd call underestimation but an unwanted gap what is=
=20
the end result here.

I'll think this over the weekend, maybe the best solution for now is to=20
put that check back. With the check, those resources will end up into tail=
=20
space more often but anything else I can think of would require more=20
complex data structures.

I'd eventually want to use better data structure anyway as I'd want to=20
make it possible to put as much stuff into the head side while still=20
producing gapless fit to generally produce tighter fit for windows that=20
are next to each other in the address space if both have resources=20
smaller than the max order.

> If we have child resources with the following requirements:
> - Resource A: 4MB size, 4MB align
> - Resource B: 3MB size, 1MB align
> - Resource C: 1MB size, 1MB align
>=20
> The requested `size` is calculated as 4 + 3 + 1 =3D 8MB.
> `aligns[order]` for 1MB will now incorrectly include B, summing to 2MB.
> `calculate_head_align()` will see the 2MB remainder and reduce `min_align=
`
> to 2MB, assuming the remainder can perfectly fill a 2MB head gap.
>=20
> If the bridge window of size 8MB is allocated at a 2MB-aligned address
> (e.g., `0x10200000`), the 4MB aligned Resource A must be placed at
> `0x10400000`, leaving a 2MB gap.
>=20
> Resource B (3MB) cannot fit in this 2MB gap, so it is placed after A at
> `0x10800000`.
> Resource C (1MB) fits in the gap at `0x10200000`.
>=20
> The total space used spans from `0x10200000` to `0x10AFFFFF` (9MB).
> Since `size0` was calculated as 8MB, won't Resource B fail to allocate
> because it exceeds the bridge window?
>=20

--=20
 i.

--8323328-864570821-1772728107=:1083--
