Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561052F5A35;
	Tue, 27 Jan 2026 10:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769509009; cv=none; b=IRfR+C+cmVLB9YIkyPWJQwkrP72MmsBy6x5jiM1CrGMhECcle0RKRyurkJVVOOGYagMBNpAkFCBSZzd9lR8Fs5na2e3wR41wvhUz6aFfx+wgAbzpd6XGUUaNW5bRUvEIANUQb7T7j+NXy62Cehwu258gUPGklrd5WNRO5MfnUZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769509009; c=relaxed/simple;
	bh=krH1HhCKpqHDogCwFIMmcVKSI1HGx/Ny36W+ftV+96w=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lA2zCirMec5WU/jfVDpZm8icsUMaZzIKUZe3Ymc0159o1vC6hJarxWNLcUVT5e4OawNod4zizusHzXftlum6GBX7N/56bt8IgO5EvstDaqpjHK6bQGGqzM82OScVHepNSMJLwFxsqd+MZHgfyc8o+/h092oPyeF/B38JU7bG18g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HZHCnaFn; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HZHCnaFn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769509007; x=1801045007;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=krH1HhCKpqHDogCwFIMmcVKSI1HGx/Ny36W+ftV+96w=;
  b=HZHCnaFnfSVrZY4ueVri6Vh0Pj7vtdLoaCt5IxsmTmavV186GNEJ0rC8
   Kbil7yHEvEnA0Nra97gx5Y5I+BGmThA0dncntPAai3boygsht059SeyK/
   R6XIZHJGHFufaap3gmqmkrdzPBCO8CwF9cWHWiDb1AaMZeIT2Tnfqg8G+
   93AKFyiRJx9vxceeNaKzCE93DCiapCDCCloet1DW0gSGcZJVDvwF81v6F
   ZpM3xRCkwwp66B2TxndtGvAIVovXTTFFFXQQfj3HrtgGqNuDt4B6PFS4N
   PBdLEBj97ZXrqa2UnRAfkZ8uSE+2G+uAeaebba5/wvJFcaelF/s/33DMA
   g==;
X-CSE-ConnectionGUID: sUzeCb7WR8ee71v3hdyxSw==
X-CSE-MsgGUID: 1HcWHVpMSxqebaF17BpygA==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="81808509"
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="81808509"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 02:16:46 -0800
X-CSE-ConnectionGUID: iBqyTwYPQkCCL2LgAISCgw==
X-CSE-MsgGUID: 6ihD1vXWSPy7mGtUW8kBdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="207734261"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.67])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 02:16:42 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 27 Jan 2026 12:16:38 +0200 (EET)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    Dominik Brodowski <linux@dominikbrodowski.net>, 
    LKML <linux-kernel@vger.kernel.org>, 
    Simon Richter <Simon.Richter@hogyros.de>
Subject: Re: [PATCH 05/23] PCI: Remove old_size limit from bridge window
 sizing
In-Reply-To: <20260126171601.GA249217@bhelgaas>
Message-ID: <c46c4bd1-51e3-d76a-5ae9-14bd31b57aa1@linux.intel.com>
References: <20260126171601.GA249217@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-45747642-1769508998=:1055"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-45747642-1769508998=:1055
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 26 Jan 2026, Bjorn Helgaas wrote:

> On Fri, Dec 19, 2025 at 07:40:18PM +0200, Ilpo J=C3=A4rvinen wrote:
> > calculate_memsize() applies lower bound to the resource size before
> > aligning the resource size making it impossible to shrink bridge window
> > resources. I've not found any justification for this lower bound and
> > nothing indicated it was to work around some HW issue.
> >=20
> > Prior to the commit 3baeae36039a ("PCI: Use pci_release_resource()
> > instead of release_resource()"), releasing a bridge window during BAR
> > resize resulted in clearing start and end address of the resource.
> > Clearing addresses destroys the resource size as a side-effect,
> > therefore nullifying the effect of the old size lower bound.
> >=20
> > After the commit 3baeae36039a ("PCI: Use pci_release_resource() instead
> > of release_resource()"), BAR resize uses the aligned old size, which
> > results in exceeding what fits into the parent window in some cases:
> >=20
> > xe 0030:03:00.0: [drm] Attempting to resize bar from 256MiB -> 16384MiB
> > xe 0030:03:00.0: BAR 0 [mem 0x620c000000000-0x620c000ffffff 64bit]: rel=
easing
> > xe 0030:03:00.0: BAR 2 [mem 0x6200000000000-0x620000fffffff 64bit pref]=
: releasing
> > pci 0030:02:01.0: bridge window [mem 0x6200000000000-0x620001fffffff 64=
bit pref]: releasing
> > pci 0030:01:00.0: bridge window [mem 0x6200000000000-0x6203fbff0ffff 64=
bit pref]: releasing
> > pci 0030:00:00.0: bridge window [mem 0x6200000000000-0x6203fbff0ffff 64=
bit pref]: was not released (still contains assigned resources)
> > pci 0030:00:00.0: Assigned bridge window [mem 0x6200000000000-0x6203fbf=
f0ffff 64bit pref] to [bus 01-04] free space at [mem 0x6200400000000-0x6200=
7ffffffff 64bit pref]
> > pci 0030:00:00.0: Assigned bridge window [mem 0x6200000000000-0x6203fbf=
f0ffff 64bit pref] to [bus 01-04] cannot fit 0x4000000000 required for 0030=
:01:00.0 bridging to [bus 02-04]
> >=20
> > The old size of 0x6200000000000-0x6203fbff0ffff resource was used as
> > the lower bound which results in 0x4000000000 size request due to
> > alignment. That exceed what can fit into the parent window.
> >=20
> > Since the lower bound never even was enforced fully because the
> > resource addresses were cleared when the bridge window is released,
> > remove the old_size lower bound entirely and trust the calculated
> > bridge window size is enough.
> >=20
> > This same problem may occur on io window side but seems less likely to
> > cause issues due to general difference in alignment. Removing the lower
> > bound may have other unforeseen consequences in case of io window so
> > it's better to do leave as -next material if no problem is reported
> > related to io window sizing (BAR resize shouldn't touch io windows
> > anyway).
> >=20
> > Reported-by: Simon Richter <Simon.Richter@hogyros.de>
>=20
> I guess this report was
> https://lore.kernel.org/r/f9a8c975-f5d3-4dd2-988e-4371a1433a60@hogyros.de=
/,
> right?

Yes,

I seem to have forgotten to add the Link once again despite trying to=20
really remember it. I'm sorry about that.

> > Fixes: 3baeae36039a ("PCI: Use pci_release_resource() instead of releas=
e_resource()")
> > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  drivers/pci/setup-bus.c | 11 +++--------
> >  1 file changed, 3 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > index 612288716ba8..8660449f59bd 100644
> > --- a/drivers/pci/setup-bus.c
> > +++ b/drivers/pci/setup-bus.c
> > @@ -1071,16 +1071,13 @@ static resource_size_t calculate_memsize(resour=
ce_size_t size,
> >  =09=09=09=09=09 resource_size_t min_size,
> >  =09=09=09=09=09 resource_size_t add_size,
> >  =09=09=09=09=09 resource_size_t children_add_size,
> > -=09=09=09=09=09 resource_size_t old_size,
> >  =09=09=09=09=09 resource_size_t align)
> >  {
> >  =09if (size < min_size)
> >  =09=09size =3D min_size;
> > -=09if (old_size =3D=3D 1)
> > -=09=09old_size =3D 0;
> > =20
> >  =09size =3D max(size, add_size) + children_add_size;
> > -=09return ALIGN(max(size, old_size), align);
> > +=09return ALIGN(size, align);
> >  }
> > =20
> >  resource_size_t __weak pcibios_window_alignment(struct pci_bus *bus,
> > @@ -1298,7 +1295,6 @@ static void pbus_size_mem(struct pci_bus *bus, un=
signed long type,
> >  =09resource_size_t children_add_size =3D 0;
> >  =09resource_size_t children_add_align =3D 0;
> >  =09resource_size_t add_align =3D 0;
> > -=09resource_size_t old_size;
> > =20
> >  =09if (!b_res)
> >  =09=09return;
> > @@ -1364,11 +1360,10 @@ static void pbus_size_mem(struct pci_bus *bus, =
unsigned long type,
> >  =09=09}
> >  =09}
> > =20
> > -=09old_size =3D resource_size(b_res);
> >  =09win_align =3D window_alignment(bus, b_res->flags);
> >  =09min_align =3D calculate_head_align(aligns, max_order);
> >  =09min_align =3D max(min_align, win_align);
> > -=09size0 =3D calculate_memsize(size, min_size, 0, 0, old_size, win_ali=
gn);
> > +=09size0 =3D calculate_memsize(size, min_size, 0, 0, win_align);
> > =20
> >  =09if (size0) {
> >  =09=09resource_set_range(b_res, min_align, size0);
> > @@ -1378,7 +1373,7 @@ static void pbus_size_mem(struct pci_bus *bus, un=
signed long type,
> >  =09if (realloc_head && (add_size > 0 || children_add_size > 0)) {
> >  =09=09add_align =3D max(min_align, add_align);
> >  =09=09size1 =3D calculate_memsize(size, min_size, add_size, children_a=
dd_size,
> > -=09=09=09=09=09  old_size, win_align);
> > +=09=09=09=09=09  win_align);
> >  =09}
> > =20
> >  =09if (!size0 && !size1) {
> > --=20
> > 2.39.5
> >=20
>=20
--8323328-45747642-1769508998=:1055--
