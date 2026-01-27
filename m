Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AE9346AFF;
	Tue, 27 Jan 2026 11:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769513988; cv=none; b=SRX0dbl0tsJJz9QyZp9y9Xi2rSbIc+aDuzebIbksQcuoGzo28NjL7R7r+pysW1Ze0NOwmJFwIAYbxCTZTGFAssE3Mekqs3ngD168dJqUCYCTU0UDCssR+BqX6uYF8yhIzUPPhorC0rfz3GSAly2txQ79HKn/wU8AoJ1zPcjD2LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769513988; c=relaxed/simple;
	bh=ZqDDHYcca7Gm0rf13vV0WwrqmmANuJJmCTlAH44KGp8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PinSzwa8Z9tLqG9XhEPQF9KlXvNXwpItyuoXtdCJd1Iy9w6k9R85oD1ceRKTsif2PyMFW0gJVHuBI6u6AdRp3orYz/MKS886SLx4razo+qaG9HOnvD83F/h40uT+Hvc8LsK/FcI3ZSTPVmS4yw6Cm8EtXF17lF0HBoq4dHI8Fok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PejYDn4w; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PejYDn4w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769513986; x=1801049986;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=ZqDDHYcca7Gm0rf13vV0WwrqmmANuJJmCTlAH44KGp8=;
  b=PejYDn4wPMltZz5n4HtaQUE4wiQK0gPQa2du5Zcompdrl0e8xD0gg4xS
   2iCKci9pJQwd7LjAD6dDTNRCqCa0iv9AW5jrYhoFwepyNtJletUWRATUo
   aSa+qUzmlYXiIIlhVgy1Z0SmecUqPUKCf8wKi/ICn4NnkkxeTFTEf2ImJ
   JMwC0PqcEx1o+lMNd5GabAy5bKCJw3TO7wij5GGG9YaZ9KUowcMwf0+zk
   Wa1uPkwJL3NNiu9NbTMoQVI8f5i00sIiE2ucvquClbk13XaTzCv6sK/Za
   cAM1ChQVkEeFlm94ND3ZpWJFE+gv/lFjw87U2Y9QQcgPj86E9HSQuGYJk
   Q==;
X-CSE-ConnectionGUID: XKYzNysWTICkF73cwxcEag==
X-CSE-MsgGUID: fy6+8hJPTTCxtsgDmgewvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="70609325"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="70609325"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 03:39:45 -0800
X-CSE-ConnectionGUID: HqYXD6W4TGqzRTnHOJHC9g==
X-CSE-MsgGUID: 6L7T1XXtSLiUYgZcqBrP8w==
X-ExtLoop1: 1
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.67])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 03:39:43 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 27 Jan 2026 13:39:39 +0200 (EET)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    Dominik Brodowski <linux@dominikbrodowski.net>, 
    LKML <linux-kernel@vger.kernel.org>, 
    Simon Richter <Simon.Richter@hogyros.de>
Subject: Re: [PATCH 05/23] PCI: Remove old_size limit from bridge window
 sizing
In-Reply-To: <20260126200951.GA301074@bhelgaas>
Message-ID: <fb05789e-6a9a-6051-e3fa-ce9ac168c5df@linux.intel.com>
References: <20260126200951.GA301074@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-2105239277-1769511962=:1055"
Content-ID: <643a117e-909a-8c31-0693-17c5097d4369@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2105239277-1769511962=:1055
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <12889a23-00d1-dd0d-1509-d6d3355f4799@linux.intel.com>

On Mon, 26 Jan 2026, Bjorn Helgaas wrote:

> On Mon, Jan 26, 2026 at 11:16:01AM -0600, Bjorn Helgaas wrote:
> > On Fri, Dec 19, 2025 at 07:40:18PM +0200, Ilpo J=E4rvinen wrote:
> > > calculate_memsize() applies lower bound to the resource size before
> > > aligning the resource size making it impossible to shrink bridge wind=
ow
> > > resources. I've not found any justification for this lower bound and
> > > nothing indicated it was to work around some HW issue.
> > >=20
> > > Prior to the commit 3baeae36039a ("PCI: Use pci_release_resource()
> > > instead of release_resource()"), releasing a bridge window during BAR
> > > resize resulted in clearing start and end address of the resource.
> > > Clearing addresses destroys the resource size as a side-effect,
> > > therefore nullifying the effect of the old size lower bound.
> > >=20
> > > After the commit 3baeae36039a ("PCI: Use pci_release_resource() inste=
ad
> > > of release_resource()"), BAR resize uses the aligned old size, which
> > > results in exceeding what fits into the parent window in some cases:
> > >=20
> > > xe 0030:03:00.0: [drm] Attempting to resize bar from 256MiB -> 16384M=
iB
> > > xe 0030:03:00.0: BAR 0 [mem 0x620c000000000-0x620c000ffffff 64bit]: r=
eleasing
> > > xe 0030:03:00.0: BAR 2 [mem 0x6200000000000-0x620000fffffff 64bit pre=
f]: releasing
> > > pci 0030:02:01.0: bridge window [mem 0x6200000000000-0x620001fffffff =
64bit pref]: releasing
> > > pci 0030:01:00.0: bridge window [mem 0x6200000000000-0x6203fbff0ffff =
64bit pref]: releasing
> > > pci 0030:00:00.0: bridge window [mem 0x6200000000000-0x6203fbff0ffff =
64bit pref]: was not released (still contains assigned resources)
> > > pci 0030:00:00.0: Assigned bridge window [mem 0x6200000000000-0x6203f=
bff0ffff 64bit pref] to [bus 01-04] free space at [mem 0x6200400000000-0x62=
007ffffffff 64bit pref]
> > > pci 0030:00:00.0: Assigned bridge window [mem 0x6200000000000-0x6203f=
bff0ffff 64bit pref] to [bus 01-04] cannot fit 0x4000000000 required for 00=
30:01:00.0 bridging to [bus 02-04]
> > >=20
> > > The old size of 0x6200000000000-0x6203fbff0ffff resource was used as
> > > the lower bound which results in 0x4000000000 size request due to
> > > alignment. That exceed what can fit into the parent window.
> > >=20
> > > Since the lower bound never even was enforced fully because the
> > > resource addresses were cleared when the bridge window is released,
> > > remove the old_size lower bound entirely and trust the calculated
> > > bridge window size is enough.
> > >=20
> > > This same problem may occur on io window side but seems less likely t=
o
> > > cause issues due to general difference in alignment. Removing the low=
er
> > > bound may have other unforeseen consequences in case of io window so
> > > it's better to do leave as -next material if no problem is reported
> > > related to io window sizing (BAR resize shouldn't touch io windows
> > > anyway).
> > >=20
> > > Reported-by: Simon Richter <Simon.Richter@hogyros.de>
> >=20
> > I guess this report was
> > https://lore.kernel.org/r/f9a8c975-f5d3-4dd2-988e-4371a1433a60@hogyros.=
de/,
> > right?
>=20
> And this looks like a regression in v6.18 that will persist in v6.19.
>=20
> Is that the right thing?  I wonder if we should move these first five
> patches to pci/for-linus so they land in v6.19?

Fine with me if you want to do that. Stable people would pick things that=
=20
landing in the merge window into Linus' tree anyway so the difference=20
isn't going to be that huge.

Patch 3 is the scariest of the changes and is not strictly even a fix=20
(without it there are two parallel alignment approaches though which=20
wastes some stack space). It will have some impact on resource allocation=
=20
when the new approach is enabled for everything were as previously the new=
=20
sizing/alignment approached were only used in the relative safe haven of=20
relaxed tail alignment cases; though in my tests, surprisingly few changes=
=20
did occur.

The patch 4 too is on the edge, if you want to push that through for-linus=
=20
(but it's not dangerous and is useful for complex topos).

I don't know how you are going to handle the pci/resource branch then=20
though as I expect the rest of the series to not apply cleanly without=20
those 5 patches.

--=20
 i.

> > > Fixes: 3baeae36039a ("PCI: Use pci_release_resource() instead of rele=
ase_resource()")
> > > Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> > > ---
> > >  drivers/pci/setup-bus.c | 11 +++--------
> > >  1 file changed, 3 insertions(+), 8 deletions(-)
> > >=20
> > > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > > index 612288716ba8..8660449f59bd 100644
> > > --- a/drivers/pci/setup-bus.c
> > > +++ b/drivers/pci/setup-bus.c
> > > @@ -1071,16 +1071,13 @@ static resource_size_t calculate_memsize(reso=
urce_size_t size,
> > >  =09=09=09=09=09 resource_size_t min_size,
> > >  =09=09=09=09=09 resource_size_t add_size,
> > >  =09=09=09=09=09 resource_size_t children_add_size,
> > > -=09=09=09=09=09 resource_size_t old_size,
> > >  =09=09=09=09=09 resource_size_t align)
> > >  {
> > >  =09if (size < min_size)
> > >  =09=09size =3D min_size;
> > > -=09if (old_size =3D=3D 1)
> > > -=09=09old_size =3D 0;
> > > =20
> > >  =09size =3D max(size, add_size) + children_add_size;
> > > -=09return ALIGN(max(size, old_size), align);
> > > +=09return ALIGN(size, align);
> > >  }
> > > =20
> > >  resource_size_t __weak pcibios_window_alignment(struct pci_bus *bus,
> > > @@ -1298,7 +1295,6 @@ static void pbus_size_mem(struct pci_bus *bus, =
unsigned long type,
> > >  =09resource_size_t children_add_size =3D 0;
> > >  =09resource_size_t children_add_align =3D 0;
> > >  =09resource_size_t add_align =3D 0;
> > > -=09resource_size_t old_size;
> > > =20
> > >  =09if (!b_res)
> > >  =09=09return;
> > > @@ -1364,11 +1360,10 @@ static void pbus_size_mem(struct pci_bus *bus=
, unsigned long type,
> > >  =09=09}
> > >  =09}
> > > =20
> > > -=09old_size =3D resource_size(b_res);
> > >  =09win_align =3D window_alignment(bus, b_res->flags);
> > >  =09min_align =3D calculate_head_align(aligns, max_order);
> > >  =09min_align =3D max(min_align, win_align);
> > > -=09size0 =3D calculate_memsize(size, min_size, 0, 0, old_size, win_a=
lign);
> > > +=09size0 =3D calculate_memsize(size, min_size, 0, 0, win_align);
> > > =20
> > >  =09if (size0) {
> > >  =09=09resource_set_range(b_res, min_align, size0);
> > > @@ -1378,7 +1373,7 @@ static void pbus_size_mem(struct pci_bus *bus, =
unsigned long type,
> > >  =09if (realloc_head && (add_size > 0 || children_add_size > 0)) {
> > >  =09=09add_align =3D max(min_align, add_align);
> > >  =09=09size1 =3D calculate_memsize(size, min_size, add_size, children=
_add_size,
> > > -=09=09=09=09=09  old_size, win_align);
> > > +=09=09=09=09=09  win_align);
> > >  =09}
> > > =20
> > >  =09if (!size0 && !size1) {
> > > --=20
> > > 2.39.5
> > >=20
>=20
--8323328-2105239277-1769511962=:1055--
