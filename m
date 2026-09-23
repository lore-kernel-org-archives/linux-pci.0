Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC0F51D52A
	for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2026 13:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790170787; cv=none; b=DY8EbWyUSyEs69s7wyXKfE3n9CEcPP44qtZQwlb0ygBFKHT7CGwDbohCfDL1qsHdmpsVhlTmKR7MFibX6M28Ll3iZSYIe2qaEuL9S2CBAsybSRQu3ddDJJbl3EMOQ49jqOtz16h8VmpLw3whPEejeMyNNFdbU5McWwsmCMnqMV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790170787; c=relaxed/simple;
	bh=EiWgRrCZl+2DtpVafWliNqNzIqphGm44ttBYL0XpEDk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=J4VVH8vhXPUQ/ZwhRJ+CnNUCcDWcUeDwYqFuEQ5iy1tM3vWBI04+ehSUenQJIMtZbf/T01efgMEg+reqcLd8hbbVmBuyYW3bHWJScVuOztkt5nlOe2AMkim7ji8uCGS8l4nf7+pobhF1wH5B9GKHmCyJA5tRyXOx6HelDkM10wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VPK9XZKK; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VPK9XZKK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790170784; x=1821706784;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=EiWgRrCZl+2DtpVafWliNqNzIqphGm44ttBYL0XpEDk=;
  b=VPK9XZKKUP/S46BkQp0RBX62TRDQXeBYdttUVu+zOfO2rWGBxFHDgCEE
   R41iA3FlvtiEHIAQIatXVN3gGLeV06kPlozAhwSr7BwPF9H4Iu09rQa9X
   BYPjSwH+6c3MssToI2iyUoiSxDzezIxWkLA/ayBqAB5CSsuPSxgzpp1ME
   2NpVC8Mdx3lDUiSELB2nnJadXiWs3pHafXy9LSqwRVGTtsUeSjHdawMuw
   XPjfEV7i/+C6LdgftyqsvI9Oez7Di/HyY6ESGnQEEBUPiT4hUJ9psLgGY
   HYq4Av0M4DEmbA4Nt/fo3XbItWE1/+E4AjssBvsDXZ7J07t8rZi+qYjAx
   Q==;
X-CSE-ConnectionGUID: tYNkMuiCSZmJsUwM8MC7tw==
X-CSE-MsgGUID: sncAl+R0QDS1DL1sEvJ/zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="90982867"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="90982867"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 06:39:43 -0700
X-CSE-ConnectionGUID: bnW3Vj6nRjenxW0epd5vvQ==
X-CSE-MsgGUID: lITg15atQey1I4ek4KzEyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="4706129"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.13])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 06:39:42 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 23 Sep 2026 16:39:38 +0300 (EEST)
To: sashiko-reviews@lists.linux.dev
cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH 4/5] PCI: Fix composite resource sizing
In-Reply-To: <20260923133151.70D231F000FF@smtp.kernel.org>
Message-ID: <d50df48b-1221-74b6-96b2-ba8178312949@linux.intel.com>
References: <20260923131757.7792-1-ilpo.jarvinen@linux.intel.com> <20260923131757.7792-5-ilpo.jarvinen@linux.intel.com> <20260923133151.70D231F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1957391310-1790170778=:1282"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1957391310-1790170778=:1282
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 23 Sep 2026, sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] pci: bridge window gap calculation Rule 2 underestimates require=
d size
> --
>=20
> commit f9f2d66b1a5c96f99a75fc82cb40a5f073968dfb
> Author: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>=20
> PCI: Fix composite resource sizing
>=20
> This commit modifies the bridge window sizing algorithm to add a gap size
> calculator. The calculator determines the empty space required because of
> non-aligning composite child resources, such as VF BARs and bridge window=
s,
> to ensure alignment constraints are met when resources are placed.
>=20
> Link: https://lore.kernel.org/linux-pci/20260903063124.9316-1-nbritton@ex=
abit.io/
>=20
> > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > index 7ca0e9f4ffb63..9d828a59bd002 100644
> > --- a/drivers/pci/setup-bus.c
> > +++ b/drivers/pci/setup-bus.c
> [ ... ]
> > @@ -1164,6 +1164,76 @@ static inline resource_size_t calculate_mem_alig=
n(resource_size_t *aligns,
> [ ... ]
> > +static resource_size_t calculate_win_gap_size(struct pci_bus *bus,
> > +=09=09=09=09=09      struct resource *b_res,
> > +=09=09=09=09=09      resource_size_t win_align,
> > +=09=09=09=09=09      bool optional)
> > +{
> > +=09resource_size_t safe_gap =3D 0, remainders =3D 0;
> > +=09unsigned int nonaligning =3D 0;
> > +=09struct pci_dev *dev;
> [ ... ]
> > +=09=09=09nonaligning++;
> > +=09=09=09remainders +=3D remainder;
> > +=09=09=09safe_gap +=3D win_align - remainder;
> > +=09=09}
> > +=09}
> > +
> > +=09if (nonaligning =3D=3D 2 && (remainders <=3D win_align))
> > +=09=09return win_align - remainders;
>=20
> [Severity: High]
> Does this logic underestimate the required gap size by assuming two remai=
nder
> parts can perfectly share a single alignment block's padding without veri=
fying
> if their individual alignment constraints allow tight packing?
>=20
> If a parent PCI bus contains exactly two child resources (e.g., downstrea=
m
> bridge windows) whose sizes are not multiples of the bus's max alignment,=
 and
> their size remainders sum to less than or equal to the max alignment, thi=
s
> bypass avoids the safe_gap fallback.
>=20
> For example, if two 10MB windows require 4MB alignment, this calculates a=
 gap
> of (4 - (2+2)) =3D 0MB, resulting in a 20MB parent window. However, becau=
se both
> resources require 4MB alignment, if the first is placed at 0..10MB, the s=
econd
> must be placed at 12MB. This requires a 22MB total span, which exceeds th=
e

This is bogus, sashiko doesn't understand how the new placement algorithm=
=20
works when it comes to remainder parts. The remainder for the second=20
resource would start at 10MB and the aligning part will start exactly at=20
12MB filling all the constraints and fitting to 20MB.

Thus, the calculation is correct. I suspect this case would work even=20
without this patch because no gap is needed in the first place (untested).

> calculated 20MB window.
>
> Could this underestimation cause PCI resource assignment to fail during
> enumeration for devices or downstream bridges, leaving them uninitialized=
?
>
> > +
> > +=09if (nonaligning >=3D 2)
> > +=09=09return safe_gap;
> > +
> > +=09return 0;
> > +}

--=20
 i.

--8323328-1957391310-1790170778=:1282--
