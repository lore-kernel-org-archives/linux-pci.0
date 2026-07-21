Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29444343F6
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 07:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784619794; cv=none; b=FGmhNYGKBDNc0lVZeJKnhYrg3I6PftLdAEXCfuDXk4ElPgCHcdHrSetKsuyEHvO21G9wZM12ug3qDhLMbYlEatr4YLeeM2ReR1vA21r10JBkeMUq5toC2Gdh6jMvFxQxUqyewuBMv3gjemcoU43ojmgdhxaneH2KSNGlNhfRy0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784619794; c=relaxed/simple;
	bh=jyYYK6uRMOM3jtowtv1VThVfh61cDZUuuumhoQyBNoY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ARzf2Nn7C+I7DXFmeF7Xo+rD9BXqxmNVMPhVCkYv67RSO/JVDQibdt/YOTh9j7NSifJomAm9Cbq2gbotYbMrjl7V+WQV6ydZu//L8k0So+NukNd20+UZ84goutILsBvQcE67UFmd4/EfVRBWt46+CMIxvewQXxlXp+ZnOUdtQIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n04ai4Fj; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n04ai4Fj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784619793; x=1816155793;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=jyYYK6uRMOM3jtowtv1VThVfh61cDZUuuumhoQyBNoY=;
  b=n04ai4FjNh42Y3TiX7fkFHBVnLhysaLhYrYG+xrJUfDjmI2+e0ZdIrML
   4g3LhLUyQTxHw6RtYhKX5GK6qphh/Z+CLeslPL7h5lImDiZ87yauVp912
   sFRA0sxW277KUdXV9XJXO0qvDBIymZN+UAAOAG9kywthlwiA7kmZnqxGH
   CmR3dqkdyoIVJOZGf8P+QVRgKXoT6C8OeW3F59qNGZFLdq270XfcPRBLa
   Q8snnw92RFUW+CcjOGKX9ks09ZdukMyBzCgx/honxu0rdBYSWMwBoX+WI
   VOXioxO+QY/rOl1M31NYAcL0SPOiWQrqk0qjP0AHyh2HpnI4A/soYgJlI
   w==;
X-CSE-ConnectionGUID: skLW0eP9TemIUmmPftCIog==
X-CSE-MsgGUID: sefWG1wgTeSlXIN3ED/H9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="72745910"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="72745910"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 00:43:12 -0700
X-CSE-ConnectionGUID: m8ITfQRES8aDT42wkGavsg==
X-CSE-MsgGUID: jYQH+7T/S/KEnH0jrf0qZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="255048745"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.47])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 00:43:11 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 21 Jul 2026 10:43:08 +0300 (EEST)
To: sashiko-reviews@lists.linux.dev
cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI: Do not add hotplug reservation multiple times
In-Reply-To: <20260720164006.8E86C1F000E9@smtp.kernel.org>
Message-ID: <e3cbbf52-a78c-c370-dcb7-da64b54fe8dd@linux.intel.com>
References: <20260720162416.5771-1-ilpo.jarvinen@linux.intel.com> <20260720164006.8E86C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1499174521-1784619788=:1265"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1499174521-1784619788=:1265
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 20 Jul 2026, sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>=20
> Pre-existing issues:
> - [High] The patch fixes nested hotplug reservation accumulation for memo=
ry windows in `calculate_memsize()`, but misses the identical buggy logic i=
n `calculate_iosize()`, leading to I/O space exhaustion.
> --
>=20
> --- Patch [1]: [PATCH 1/1] PCI: Do not add hotplug reservation multiple t=
imes ---
> commit 3c4b4a62adcb92793a7c17214021e8b637be1016
> Author: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>=20
> PCI: Do not add hotplug reservation multiple times
>=20
> In nested topologies, hotplug reservations gets added multiple times
> into the bridge window higher up in the hierarchy. Adding reservation
> for intermediate level bridges does not seem very useful because the
> hotplug is going to add device at a leaf.
>=20
> Link: https://lore.kernel.org/linux-pci/f23946f2-06ac-4607-8f2c-3ffbc52b6=
27a@redhat.com/
>=20
> > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > index c0a949f2c9956..e8c94aa1d3c12 100644
> > --- a/drivers/pci/setup-bus.c
> > +++ b/drivers/pci/setup-bus.c
> > @@ -1021,7 +1021,7 @@ static resource_size_t calculate_memsize(resource=
_size_t size,
> >  =09=09=09=09=09 resource_size_t children_add_size,
> >  =09=09=09=09=09 resource_size_t align)
> >  {
> > -=09size =3D max(size, min_size) + children_add_size;
> > +=09size =3D max(size + children_add_size, min_size);
> >  =09return ALIGN(size, align);
> >  }
>=20
> [Severity: High]
> This isn't a bug introduced by this patch, but does calculate_iosize() ne=
ed a
> similar fix to avoid I/O space exhaustion in nested topologies?
>=20
> Just above calculate_memsize(), calculate_iosize() retains the identical
> logic for I/O windows:
>
> drivers/pci/setup-bus.c:calculate_iosize() {
>     ...
>     size =3D max(size, add_size) + children_add_size;
>     return ALIGN(max(size, old_size), align);
> }
>=20
> When allocating I/O windows for nested hotplug bridges, pbus_size_io() pa=
sses
> both the accumulated children I/O sizes (children_add_size) and the hotpl=
ug
> reservation (add_size) to calculate_iosize().
>=20
> Because the logic is exactly the same as the unpatched calculate_memsize(=
),
> this appears to still unconditionally add an extra 4KB (due to bridge win=
dow
> alignment) at each nested bridge level. Can this linearly inflate the req=
uired
> space and quickly exhaust the limited 64KB I/O address space on systems w=
ith
> deeply nested hotplug PCIe bridges (like Thunderbolt docks)?

For the record, I intentionally left the io side untouched.

If somebody feels I should make the same change there, I can of course add=
=20
it there.

IMO io side would be better served with defaulting hotplug allocation to=20
zero, big systems keep running out of io space because of gazillions empty=
=20
reservations even when nesting is not in the picture.


--=20
 i.

--8323328-1499174521-1784619788=:1265--
