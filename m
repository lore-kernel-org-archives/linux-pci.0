Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040753AA516;
	Tue,  7 Apr 2026 12:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775564805; cv=none; b=H47NRF8XeauRZtF23dVBHkyoGybVI6MfZz6lsTJDEddv4B5ba6lDh7TJfG5KS4+9onhTaeP7YtAYG2NPhValI6TQDPLhOS49BNICrhz3yBAyJlOwn4LR3SyrVXlz3fEjAbT7r2fCZkdoQDo71HDZC1SGZBVhwwOHR7emdjzyU2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775564805; c=relaxed/simple;
	bh=h4yTczUHVKUWhPXpwlYm9+H8LhrAyaSQh8rnV3r/NQU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KrOf/MOL9H8MuZB95VtOmPO+h+CdxyBU5EUm+qprFSbPW5ZwwHxS91GcskGd4epBCFrAnLgeFOzWKjTfrSM25Z7GK7CMk/uivQ1FE5pEwW76ngNl7y/WTCaKqd7xwW2S1jPUoJzVurrbSkfLqoPipvKl7ic7ngh4/AYRvWCxAuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DyfXg+mj; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DyfXg+mj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775564804; x=1807100804;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=h4yTczUHVKUWhPXpwlYm9+H8LhrAyaSQh8rnV3r/NQU=;
  b=DyfXg+mjf4HqJ4hC8mwFCK4wF+0HZwKaVfdDj1n1iWtxVanaEZ0tAZWy
   +SbwcSA/mJxEcJFGCwNw6tNfBHbvyYMM9nEo1aRtpmcvsE69XrJgJm1rD
   /vd+n8O475sul4ZorVntKzaMBQOYpEVH9dZN5ebhUcOJHK3Q3PM31sI+l
   CB61HXHz/fVPYiQ9svD4qgmdyhy6ocvS5vq+1kYk09M7v+S4emnMNoohU
   Ubj6TymG+O+sXVGXvgIIuX2S6/iBpbFtiVlGBw3Q8Yy/sfxM5OM8PMVpE
   5Y7Oq/nUjoFm0613Bn+XTDWIvZQCg71PYy3yflISaESIeQMwd6jkN5A67
   w==;
X-CSE-ConnectionGUID: k+4IC5tcQ2yutjA8nsl3ng==
X-CSE-MsgGUID: djHsnpjbRaChi0FR32t+OQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="76420567"
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="76420567"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 05:26:43 -0700
X-CSE-ConnectionGUID: D2B7lhe1SQqejXESoulV2g==
X-CSE-MsgGUID: 1Gp5F1KfQUOYbOn+wCPg1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="223856793"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.110])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 05:26:39 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 7 Apr 2026 15:26:36 +0300 (EEST)
To: Hans Zhang <18255117159@163.com>
cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
    kwilczynski@kernel.org, mani@kernel.org, jingoohan1@gmail.com, 
    robh@kernel.org, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/3] PCI: Move pci_bus_speed2lnkctl2() to public
 header
In-Reply-To: <e1acfaad-faaa-410e-a20c-94552fded7a3@163.com>
Message-ID: <a08aae5d-4239-6099-d95a-9d1ea1661c69@linux.intel.com>
References: <20260406104708.1218648-1-18255117159@163.com> <20260406104708.1218648-3-18255117159@163.com> <d19c8a93-71ae-187d-4aa6-a22105edcde3@linux.intel.com> <e1acfaad-faaa-410e-a20c-94552fded7a3@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1455161500-1775564796=:983"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1455161500-1775564796=:983
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 7 Apr 2026, Hans Zhang wrote:

>=20
>=20
> On 4/7/26 16:11, Ilpo J=C3=A4rvinen wrote:
> > On Mon, 6 Apr 2026, Hans Zhang wrote:
> >=20
> > > Move the static array-based pci_bus_speed2lnkctl2() function from
> > > bwctrl.c to pci.h as a public inline function.
> > >=20
> > > This provides efficient O(1) speed-to-LNKCTL2 value conversion using
> > > static array lookup, maintaining optimal performance while enabling
> > > code reuse by other PCIe drivers.
> > >=20
> > > Signed-off-by: Hans Zhang <18255117159@163.com>
> > > ---
> > >   drivers/pci/pci.h         | 17 +++++++++++++++++
> > >   drivers/pci/pcie/bwctrl.c | 17 -----------------
> > >   2 files changed, 17 insertions(+), 17 deletions(-)
> > >=20
> > > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > > index f0a082bfd6f1..db91878a86ac 100644
> > > --- a/drivers/pci/pci.h
> > > +++ b/drivers/pci/pci.h
> > > @@ -611,6 +611,23 @@ static inline bool pcie_valid_speed(enum
> > > pci_bus_speed speed)
> > >   =09return (speed >=3D PCIE_SPEED_2_5GT) && (speed <=3D PCIE_SPEED_6=
4_0GT);
> > >   }
> > >   +static inline u16 pci_bus_speed2lnkctl2(enum pci_bus_speed speed)
> > > +{
> > > +=09static const u8 speed_conv[] =3D {
> > > +=09=09[PCIE_SPEED_2_5GT] =3D PCI_EXP_LNKCTL2_TLS_2_5GT,
> > > +=09=09[PCIE_SPEED_5_0GT] =3D PCI_EXP_LNKCTL2_TLS_5_0GT,
> > > +=09=09[PCIE_SPEED_8_0GT] =3D PCI_EXP_LNKCTL2_TLS_8_0GT,
> > > +=09=09[PCIE_SPEED_16_0GT] =3D PCI_EXP_LNKCTL2_TLS_16_0GT,
> > > +=09=09[PCIE_SPEED_32_0GT] =3D PCI_EXP_LNKCTL2_TLS_32_0GT,
> > > +=09=09[PCIE_SPEED_64_0GT] =3D PCI_EXP_LNKCTL2_TLS_64_0GT,
> > > +=09};
> > > +
> > > +=09if (WARN_ON_ONCE(!pcie_valid_speed(speed)))
> >=20
> > drivers/pci/pci.h doesn't seem to have include for WARN_ON_ONCE() so yo=
u
> > should add it.
>=20
> Hi Ilpo,
>=20
> In the file "drivers/pci/pcie/bwctrl.c", there is no reference to the hea=
der
> file of WARN_ON_ONCE(). It seems that no error was reported. I think it m=
ight
> be that some other header files have indirectly referenced the header fil=
e of
> WARN_ON_ONCE(). However, when I compiled it locally, no errors were repor=
ted.

Hi,

Apparently it was missing from there as well.

It might build now (I don't actually even doubt that), but that depends=20
on the includes in every file including drivers/pci/pci.h. We should not=20
depend on that as it is fragile but ensure a header is self-sufficient=20
when it comes to includes necessary for it.

> I think if we want to add a header file, it should be #include
> <asm-generic/bug.h> ?

Yes

#include <asm/bug.h>

--=20
 i.

--8323328-1455161500-1775564796=:983--
