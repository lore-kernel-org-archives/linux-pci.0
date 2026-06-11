Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E43637E2F3;
	Thu, 11 Jun 2026 17:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781199803; cv=none; b=Mudy2IKqUbdxoYJu2+yv1Q0VB0scE3BewNPdUYnzFmhQaIrau+xQF1toW3fMP9ojHAytjP1tx+7xvR3gIDBUMxhAh6qyL4L9zhZzIxjGQ6Hj2wjVazxvDF7+tZdA8532JPN8rsGUbe9WQfzrZTZ+bwHFgod4UsvqYuCiIfV13KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781199803; c=relaxed/simple;
	bh=1QOkVMHwS0SVgz+xjx42MmC1OAJy/jM4oEY1H2nNlIM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NFpiICNzov3xhvu1WubLrl/K4x+RPgkgJpG/JxNIz2hr+mD6hkgTQRCazULmpIP+jVhCaOz/IsFY4C3H6KtwviWTn5Zo9Lw+DuEqn7KSOWJ5fYVwPqW8BBg2wN4yalwxAlSOm+OUIaXXllBZtQ0IwvHMYuTTSUesEIVkzAFd3/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b6xfn2Vb; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b6xfn2Vb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781199802; x=1812735802;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=1QOkVMHwS0SVgz+xjx42MmC1OAJy/jM4oEY1H2nNlIM=;
  b=b6xfn2Vbbchzt3EsUXgWk4JX+ZCaaa8Bu9FJAYpgvCiJpKxp6Ypi2rJ6
   QGf9Iwr9KytreuZwn/V5yYCADkQTaEZXS0xAPT8WdV8KsPpRqM8BS5e5q
   mmUOfuXRqqOT7jbysw/84LTgVLP/NifOB2ZbKsU+jiKf5cpBMcCXKid/S
   6DBVQSiEF9e9DMaxEY846CuDa3XXqPBH73weLrDONCdhmAZG39YDmivwL
   pdmfvSgcYOMXUOHC0QKTRy4duwd3RkfOvqOn22h3FsXdOnPb/Tam1GlRP
   xa4CVzfa6zBYzJyOyNfrGTwVMLARm8QDGljm/yGXgy8UVZBHEv+j+0YlX
   w==;
X-CSE-ConnectionGUID: 59yVax7wR8iGUI3tLP2cIA==
X-CSE-MsgGUID: MoqncpbgSwSja1ybVK9+Sw==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="82083946"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="82083946"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 10:43:22 -0700
X-CSE-ConnectionGUID: CdahFpJGSRWSeyKm1wLPiw==
X-CSE-MsgGUID: kzQTOMnKTKmh68pYdXQAWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="251643595"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.157])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 10:43:17 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 11 Jun 2026 20:43:13 +0300 (EEST)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Hans Zhang <18255117159@163.com>, bhelgaas@google.com, 
    lpieralisi@kernel.org, kw@linux.com, kwilczynski@kernel.org, 
    mani@kernel.org, jingoohan1@gmail.com, robh@kernel.org, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v7 1/3] PCI: Add public pcie_valid_speed() for shared
 validation
In-Reply-To: <20260611172301.GA490724@bhelgaas>
Message-ID: <672be06c-1428-8681-f2b4-1e65670bf915@linux.intel.com>
References: <20260611172301.GA490724@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2095337770-1781199793=:1126"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2095337770-1781199793=:1126
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 11 Jun 2026, Bjorn Helgaas wrote:

> On Tue, Apr 07, 2026 at 09:04:48PM +0800, Hans Zhang wrote:
> > Extract the PCIe speed validation logic from bwctrl.c's static
> > pcie_valid_speed() into a public static inline function in pci.h.
> >=20
> > This allows consistent speed range checks (2.5GT/s to 64.0GT/s) across
> > multiple drivers and functions, avoiding duplicate code and ensuring
> > validation consistency as per PCIe specifications.
> >=20
> > Signed-off-by: Hans Zhang <18255117159@163.com>
> > Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
>=20
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>=20
> Any objection, Ilpo?
>=20
> It looks like 1/3 and 2/3 are pure moves, and the interesting part is
> the use in dwc, which I'd like to be reviewed and applied by Mani.

I went through the patches, no "objections" in the main sense of the word.

For PATCH 1 and 2,

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

I'll write some of my thoughts to the patch 3.

--
 i.

> > ---
> >  drivers/pci/pci.h         | 5 +++++
> >  drivers/pci/pcie/bwctrl.c | 5 -----
> >  2 files changed, 5 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > index 4a14f88e543a..f0a082bfd6f1 100644
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -606,6 +606,11 @@ void pci_bus_put(struct pci_bus *bus);
> >  =09 (speed) =3D=3D PCIE_SPEED_2_5GT  ?  2500*8/10 : \
> >  =09 0)
> > =20
> > +static inline bool pcie_valid_speed(enum pci_bus_speed speed)
> > +{
> > +=09return (speed >=3D PCIE_SPEED_2_5GT) && (speed <=3D PCIE_SPEED_64_0=
GT);
> > +}
> > +
> >  static inline int pcie_dev_speed_mbps(enum pci_bus_speed speed)
> >  {
> >  =09switch (speed) {
> > diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
> > index c4c8d260bf96..ea82e326f164 100644
> > --- a/drivers/pci/pcie/bwctrl.c
> > +++ b/drivers/pci/pcie/bwctrl.c
> > @@ -48,11 +48,6 @@ struct pcie_bwctrl_data {
> >  /* Prevent port removal during Link Speed changes. */
> >  static DECLARE_RWSEM(pcie_bwctrl_setspeed_rwsem);
> > =20
> > -static bool pcie_valid_speed(enum pci_bus_speed speed)
> > -{
> > -=09return (speed >=3D PCIE_SPEED_2_5GT) && (speed <=3D PCIE_SPEED_64_0=
GT);
> > -}
> > -
> >  static u16 pci_bus_speed2lnkctl2(enum pci_bus_speed speed)
> >  {
> >  =09static const u8 speed_conv[] =3D {
> > --=20
> > 2.34.1
> >=20
>=20

--8323328-2095337770-1781199793=:1126--
