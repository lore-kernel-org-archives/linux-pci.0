Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FD42F4A16
	for <linux-pci@vger.kernel.org>; Tue,  3 Feb 2026 17:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770139307; cv=none; b=eA6GKSAVcUKamXJd99vYgsPPDRw2ku6+/YrT2amKEVEuPGzvWbEJSxX+wNHNdJiOxBBpTtIKpDDMUbtPhmS2s1MFibQxF8FhCpTOWCl0f1WzV3SFj0gC11kwNDTKT04rLTXTvdoKYNTqZTyYHeKti+SWe5AW+kl7seky9gRrjeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770139307; c=relaxed/simple;
	bh=j9R/SR0LqxR32XmjsECS119ERmjwgUjrLbv01u8tVTE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BoIbBfDAmDX4vfx2+cWrwfaAo3mpAfQTL3z7p6zSHqDKJPeAtBX/tbXoOWgOYH8qb1iAqdmJzz0OGwJzLLPWLQ7bd8aYrT5CaF2Q1rJTlXpPix/N6TpeCHuDbKoSg22pKaspYBjnQhbRACvlnihyBkfwfLgG/DKUD3HOUxIxliM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PUlVlFFI; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PUlVlFFI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770139306; x=1801675306;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=j9R/SR0LqxR32XmjsECS119ERmjwgUjrLbv01u8tVTE=;
  b=PUlVlFFIiy+fZ9ppreDb42FtlixEhs5b3IxLx1P0rhgmS2HaltOmTw9E
   mWEPA6dtFC9ap5AVkpwE/iFpNXjfakDDxgE2EoR6ffeZ/hyviVyNHuWsK
   vxxWgxcbeT88kjW3D8TzWnzkle0X4BqkQuU7rzxhz5s6VQrvXSx7axjBg
   cKSWh28tXl9zxOEhJvyTmP2B8nKulmf98e98M65vPRtY0L97gwgOcglPB
   l67iFDlL540LzWMubZUxwwqC9e6xzgykQLZjQfYyEbvpSe0VTaGEYmvwM
   3T7yJfCW6fVhwvk8yU+thaIvr8++IW6sF6vTF2wHrXs9wVaHkB0wmp80g
   g==;
X-CSE-ConnectionGUID: thBwTOGlSoiyPEYOcD2qyw==
X-CSE-MsgGUID: x8+tH/lUQq2JBMgEZF4g+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="75173422"
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="75173422"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 09:21:45 -0800
X-CSE-ConnectionGUID: PvfuvvR/RLWR/NCu0aA8Bw==
X-CSE-MsgGUID: T4c6PyMjQsyBaALBXKtI9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="214057951"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.117])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 09:21:42 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 3 Feb 2026 19:21:38 +0200 (EET)
To: Sizhe Liu <liusizhe5@huawei.com>
cc: bhelgaas@google.com, jonathan.cameron@huawei.com, shiju.jose@huawei.com, 
    linux-pci@vger.kernel.org, linuxarm@huawei.com, prime.zeng@hisilicon.com, 
    fanghao11@huawei.com, shenyang39@huawei.com
Subject: Re: [PATCH] PCI: Fix PCI bridge resource allocation when base exceeds
 limit
In-Reply-To: <cc4121b7-b99e-d7e0-8c20-8a2f0d3a0e2d@linux.intel.com>
Message-ID: <4d9228d6-a230-6ddf-e300-fbf42d523863@linux.intel.com>
References: <20260203023545.2753811-1-liusizhe5@huawei.com> <cc4121b7-b99e-d7e0-8c20-8a2f0d3a0e2d@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-892247047-1770139298=:965"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-892247047-1770139298=:965
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 3 Feb 2026, Ilpo J=E4rvinen wrote:

> On Tue, 3 Feb 2026, Sizhe Liu wrote:
>=20
> > In pci_read_bridge_mmio_pref(), pci_read_bridge_mmio() and pci_read_bri=
dge_io(),
> > when the MEMORY_BASE value is greater than MEMORY_LIMIT,
> > resource_set_range(res, 0, 0) is called to set both the start address
> > and the size of the address of the PCI bridge resource to 0.
> > However, the end address is later calculated as:
> > res->end =3D res->start + size - 1
> > As a result, the resource range becomes [0x00000000-0xffffffffffffffff]
> > instead of the expected [0x00000000-0x00000000].
>=20
> Hi,
>=20
> Thanks for the patch but your understanding on how resources addresses=20
> work is not correct.
>=20
> A zero sized resource should have end at start - 1, just like=20
> resource_set_range() sets it!
>=20
> > This causes an exception in the subsequent resource claiming process,
> > because the address range [0x00000000-0xffffffffffffffff] exceeds
> > the range specified in the DSDT. The abnormal bridge triggers clipping
> > when claiming resources, then the entire parent PCI bus address range
> > becomes occupied. Other bridges on the same bus will report
> > address conflicts during their claim process. The resource allocation
> > may be degraded from 64-bit to 32-bit, or even worse, it fails.
> >=20
> > The related boot log is as follows:
> > pci 0000:20:00.0: PCI bridge to [bus 21]
> > pci 0000:20:00.0: bridge window [io  size 0x0000 disabled]: can't claim=
; no address assigned
> > pci 0000:20:00.0: [io  0x0000-0xffffffffffffffff disabled] clipped to [=
io  0x0000-0xffff disabled]
>=20
> pci_bus_clip_resource() should not touch IORESOURCE_DISABLED resources=20
> nor zero sized resources. The problem seems to originate from=20
> pci_claim_bridge_resources() and pci_claim_bridge_resource() which try to=
=20
> claim such resources no matter what.
>=20
> I think pci_claim_bridge_resources() should check if IORESOURCE_DISABLED=
=20
> is set and use continue, it already has check !r->flags which probably=20
> worked prior to 8278c6914306 ("PCI: Preserve bridge window resource type=
=20
> flags") but is no longer enough to decided if bridge window is valid or=
=20
> not.
>=20
> Do you want to do that patch and test it? (I'm quite busy this week=20
> myself.)

I managed to get the patch done:

--
From: =3D?UTF-8?q?Ilpo=3D20J=3DC3=3DA4rvinen?=3D <ilpo.jarvinen@linux.intel=
=2Ecom>
Date: Tue, 3 Feb 2026 19:14:30 +0200
Subject: [PATCH 1/1] PCI: Don't claim disabled bridge windows
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

The commit 8278c6914306 ("PCI: Preserve bridge window resource type
flags") change bridge window resource behavior such that flags are no
longer zero if the bridge window is not valid or is disabled (mainly
to preserve the type flags for later use). If a bridge window has its
limit smaller than base address, pci_read_bridge_*() sets both
IORESOURCE_UNSET and IORESOURCE_DISABLED to indicate the bridge window
exists but is not valid with the current base and limit configuration.

The code in pci_claim_bridge_resources() still depends on the old
behavior be checking validity of the bridge window solely based on
!r->flags, whereas after the commit 8278c6914306 ("PCI: Preserve bridge
window resource type flags"), also IORESOURCE_DISABLED may indicate
bridge window addresses are not valid.

While pci_claim_resource() does check IORESOURCE_UNSET,
pci_claim_bridge_resource() does attempt to clip the resource if
pci_claim_resource() fails which is not correct for not valid bridge
window resource. As pci_bus_clip_resource() performs clipping
regardless flags and then clears IORESOURCE_UNSET, it should not be
called for not valid resources.

The problem is visible in this log:

pci 0000:20:00.0: PCI bridge to [bus 21]
pci 0000:20:00.0: bridge window [io  size 0x0000 disabled]: can't claim; no=
 address assigned
pci 0000:20:00.0: [io  0x0000-0xffffffffffffffff disabled] clipped to [io 0=
x0000-0xffff disabled]

Add IORESOURCE_DISABLED check into pci_claim_bridge_resources() to
only claim bridge windows that appear to have a valid configuration.

Reported-by: Sizhe Liu <liusizhe5@huawei.com>
Fixes: 8278c6914306 ("PCI: Preserve bridge window resource type flags")
Cc: <stable@vger.kernel.org>
Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 6e90f46f52af..43ea635e1ea8 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1733,6 +1733,8 @@ static void pci_claim_bridge_resources(struct pci_dev=
 *dev)
=20
 =09=09if (!r->flags || r->parent)
 =09=09=09continue;
+=09=09if (r->flags & IORESOURCE_DISABLED)
+=09=09=09continue;
=20
 =09=09pci_claim_bridge_resource(dev, i);
 =09}

base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
--=20
2.39.5

--8323328-892247047-1770139298=:965--
