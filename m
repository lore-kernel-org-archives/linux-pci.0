Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB83B495531
	for <linux-pci@vger.kernel.org>; Fri,  2 Oct 2026 13:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790948883; cv=none; b=loGbpiZxCAySud9dauq1+t7axnOqaS8m123LPcogzVg40k2fn8wpTRVHAN5aYo/qzZb2G10UB4aP8/hmdL6+vw+/JZXSIpnR41S90J6IIQWC6DUPNhvXd17qhkXQMmKM3D7MhN/spvvx+qoMN/yxW3Ix7aRDqwPOaf/HZqQB1jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790948883; c=relaxed/simple;
	bh=ZdaMnhg0+U5nMFJz6GrDRt3qR1lCDZwhfTCkgtyg/Y0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OtYMrgzJkKQr8uGmvlzhFXyK0xLxyx4ZxSM22vtpA2FC7SJWydoW9ld+vQvAhzJECkhAXD5pugTp093FJJp4wC/5JtSKh+lI5dX6pWWbB1Kw830bbPxMjfPLoRoJc3qH2Qqyb1Q5CFdYMoTTOgb6RBjXZ02Ts2JRN/mvXs5tST0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lcWAsXr8; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lcWAsXr8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790948881; x=1822484881;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ZdaMnhg0+U5nMFJz6GrDRt3qR1lCDZwhfTCkgtyg/Y0=;
  b=lcWAsXr8h3CR0hBNCnFB68RVEvDBYS9hFUM5j7DKSCa0WZlRvzEv6u/B
   NbsrLe/h8CP+rmlvRayeSMJZyKd0PRZTYzdV4Dq4JrkOSSzixiuBovlA5
   ltipX6tK+OQd+G0j7ooTeOh9RNRjB0iqkEnlbO0/P5Ke8vDWc0+PyIuZu
   /JJUn8VcdUMJS6q5uSXoxCnWCX4B8H5Y7Cls+X6+dVtogLirOVheGKWEB
   d7kCqE49/hpdsxNbXGnP2TPlupdzes3D781y5Ck0gX8+pNlZed4OVw0Bj
   7Yyka4VDGLsMh0UfAGDJfavzGpjplc0uvewLum+0b2lzXFdHOHDviJBH9
   g==;
X-CSE-ConnectionGUID: ApXS9r62Tvau4AcfoGIBhg==
X-CSE-MsgGUID: feKKJQy6TTOb8j+QIe7XPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11923"; a="90614437"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="90614437"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 06:48:00 -0700
X-CSE-ConnectionGUID: ctyVlKXYQW+fbD2DLGHEsA==
X-CSE-MsgGUID: HNxBVGcoSF+IUM9ikHUQNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="272656601"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.243])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 06:47:58 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 2 Oct 2026 16:47:54 +0300 (EEST)
To: sashiko-reviews@lists.linux.dev
cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 7/7] PCI/quirks: Avoid certain address on Genoa
 systems
In-Reply-To: <20261002114833.679371F000FF@smtp.kernel.org>
Message-ID: <27be560c-4b69-bc39-f362-bd77b217d7c5@linux.intel.com>
References: <20261002113319.6652-1-ilpo.jarvinen@linux.intel.com> <20261002113319.6652-8-ilpo.jarvinen@linux.intel.com> <20261002114833.679371F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-515967273-1790948874=:1156"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-515967273-1790948874=:1156
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 2 Oct 2026, sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] pci/quirks: skipped workaround and UAF on rescan due to dangling=
 resource pointer
> --
>=20
> commit 988b9fe1c0d1202ac7629ed0f5250a0381f61b90
> Author: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>=20
> PCI/quirks: Avoid certain address on Genoa systems
>=20
> This commit addresses a 64kB iomem black hole on Genoa systems that cause=
s
> reads to return ~0 and blocks overlapping BARs from working. It reserves =
the
> problematic space via a bridge quirk.
>=20
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D222074
>=20
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index de9bbccda21fd..5483b47d8d544 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
>=20
> [ ... ]
>=20
> > +static struct resource black_hole_res =3D DEFINE_RES_MEM_NAMED(0x9c000=
000, SZ_64K,
> > +=09=09=09=09=09=09=09     "reserved");
> > +
> > +static void genoa_iomem_black_hole(struct pci_dev *dev)
> > +{
> > +=09struct resource *r;
> > +
> > +=09pci_bus_for_each_resource(dev->bus, r) {
> > +=09=09if (!r || !r->flags || !resource_assigned(r))
> > +=09=09=09continue;
> > +
> > +=09=09if (!__resource_contains_unbound(r, &black_hole_res))
> > +=09=09=09continue;
> > +
> > +=09=09if (resource_assigned(&black_hole_res))
> > +=09=09=09pci_dbg(dev, "iomem black hole workaround already applied\n")=
;
>=20
> [Severity: High]
> Can this lead to a use-after-free and cause the workaround to be skipped =
on
> rescan?
>=20
> During the first probe, insert_resource() sets black_hole_res.parent to t=
he
> dynamically allocated host bridge window. If the PCI bridge is subsequent=
ly
> removed, the bridge's resources are released and freed.
>=20
> However, release_resource() unlinks the parent but does not clear the par=
ent
> pointers of child resources. Because black_hole_res is statically allocat=
ed,
> its parent pointer is left dangling.
>
> When the bus is rescanned, resource_assigned(&black_hole_res) evaluates t=
o
> true due to the dangling parent pointer. The code erroneously logs "alrea=
dy
> applied" and skips inserting the reservation into the new bridge window.
>
> This leaves the new window unprotected, allowing subsequent BAR allocatio=
ns
> to fall into the 0x9c000000 black hole.

Before sending this, I did test removing the PCI devices all the way to=20
the Root Complex (RC included) and the black hole marker weathered the=20
storm just fine.

I suppose if I'd proceed removing something from further up (something=20
ACPI side?), the scenario might actually occur but why would anyone want=20
to do that?

I think this goes to the territory where root has many ways to shoot=20
oneself's own foot...

--=20
 i.
=20
> > +=09=09else if (!insert_resource(r, &black_hole_res))
> > +=09=09=09pci_info(dev, "iomem black hole workaround enabled\n");
> > +=09=09else
> > +=09=09=09pci_dbg(dev, "iomem black hole workaround add failed\n");
> > +=09=09return;
> > +=09}
> > +}
> > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, 0x14ab, genoa_iomem_black_=
hole);
>=20
>=20
--8323328-515967273-1790948874=:1156--
