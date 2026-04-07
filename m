Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43E93B5820;
	Tue,  7 Apr 2026 12:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775566416; cv=none; b=UxfAClxG70b7iU+cOnhAG9UGL4ZA5Ek/yQerbMKiMChaLwBSQiaIphKKddro4uNyrcf3GzTZ4g+rCH1o1GW+g9azXAZJ01RCI5InrUAP5cgRr2oRg4m5AN4n4BLP3HWdQIjDirp7RLxE+yUqZCNIjEDQQbOS9LWf/AEurT7nVkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775566416; c=relaxed/simple;
	bh=kzlmuSZXSQW3zYu/KHCOMjFtl5h7aN8fjo7UqtK0Cgs=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lGEx8RI0OgrVmfmTxAyP02vAM/1e2MIg8/I0gqu7QRyF9QYKxCoqALWXpJ37U+Atq5ON+SSgAbGQXi3yu8qz+hOr+yi07jTIDQ6lYXdDZJi2kFNXQqj4rI2bf6F9Du1ohT+m1fwA6MsNXOCO1nYluibez/uLUyC+R8hVnafbwHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZwICw9uP; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZwICw9uP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775566415; x=1807102415;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=kzlmuSZXSQW3zYu/KHCOMjFtl5h7aN8fjo7UqtK0Cgs=;
  b=ZwICw9uPy8GUxAzQkg2vev9n/TeJ1gFcwn1ftL8cdrjk4DQbrK1oaF87
   NiihEMUiyUvVmZ32NEurKaUnKZ/zEbuAg6YEwY/n3vl2o6dt9L5TUyP1J
   RCpXvG/ZFxCBvN8QkOGOA/3jqLI0U25OxMiHmGPnH+qLWF49dJ7Q8JrsC
   RC7osbg0l0De9RAQAf/LNw+qKDn7Rvlw7kE9P0IXxd2rK5AWjfHKgZISU
   dw6QPBx4p1x7xBcRpq6QQoBpPKmwLglbFmz4dTLCF/CcWcTjTPgFanLQ/
   wFGPvy9YcL1wsGW7n4y99Kga+zPlj0S0PNhNccbO+YXiF2DhdRjjq9z7q
   Q==;
X-CSE-ConnectionGUID: XdqyxJAVRvSTR6oO7gbbdw==
X-CSE-MsgGUID: 1dRDrfvZRC+J87oVZqsIMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="76717323"
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="76717323"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 05:53:34 -0700
X-CSE-ConnectionGUID: Wy1Y23RQT3ORhhHnMbiXxg==
X-CSE-MsgGUID: tL9zwgJ+T6+A7nrBm2GWcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="223862151"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.110])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 05:53:30 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 7 Apr 2026 15:53:28 +0300 (EEST)
To: Hans Zhang <18255117159@163.com>
cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
    kwilczynski@kernel.org, mani@kernel.org, jingoohan1@gmail.com, 
    robh@kernel.org, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/3] PCI: Move pci_bus_speed2lnkctl2() to public
 header
In-Reply-To: <6525a7bd-3540-4eb7-866f-d325282d1e78@163.com>
Message-ID: <e79055d3-1353-b6be-7c83-f61697efeae9@linux.intel.com>
References: <20260406104708.1218648-1-18255117159@163.com> <20260406104708.1218648-3-18255117159@163.com> <d19c8a93-71ae-187d-4aa6-a22105edcde3@linux.intel.com> <e1acfaad-faaa-410e-a20c-94552fded7a3@163.com> <a08aae5d-4239-6099-d95a-9d1ea1661c69@linux.intel.com>
 <8f10ec0e-9774-4eb8-b369-95c99a8e0226@163.com> <6525a7bd-3540-4eb7-866f-d325282d1e78@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2055045750-1775566408=:983"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2055045750-1775566408=:983
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 7 Apr 2026, Hans Zhang wrote:
> On 4/7/26 20:29, Hans Zhang wrote:
> > On 4/7/26 20:26, Ilpo J=C3=A4rvinen wrote:
> > > On Tue, 7 Apr 2026, Hans Zhang wrote:
> > > > On 4/7/26 16:11, Ilpo J=C3=A4rvinen wrote:
> > > > > On Mon, 6 Apr 2026, Hans Zhang wrote:
> > > > >=20
> > > > > > Move the static array-based pci_bus_speed2lnkctl2() function fr=
om
> > > > > > bwctrl.c to pci.h as a public inline function.
> > > > > >=20
> > > > > > This provides efficient O(1) speed-to-LNKCTL2 value conversion =
using
> > > > > > static array lookup, maintaining optimal performance while enab=
ling
> > > > > > code reuse by other PCIe drivers.
> > > > > >=20
> > > > > > Signed-off-by: Hans Zhang <18255117159@163.com>
> > > > > > ---
> > > > > > =C2=A0=C2=A0 drivers/pci/pci.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 17 +++++++++++++++++
> > > > > > =C2=A0=C2=A0 drivers/pci/pcie/bwctrl.c | 17 -----------------
> > > > > > =C2=A0=C2=A0 2 files changed, 17 insertions(+), 17 deletions(-)
> > > > > >=20
> > > > > > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > > > > > index f0a082bfd6f1..db91878a86ac 100644
> > > > > > --- a/drivers/pci/pci.h
> > > > > > +++ b/drivers/pci/pci.h
> > > > > > @@ -611,6 +611,23 @@ static inline bool pcie_valid_speed(enum
> > > > > > pci_bus_speed speed)
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return (speed >=3D PCIE_SP=
EED_2_5GT) && (speed <=3D
> > > > > > PCIE_SPEED_64_0GT);
> > > > > > =C2=A0=C2=A0 }
> > > > > > =C2=A0=C2=A0 +static inline u16 pci_bus_speed2lnkctl2(enum pci_=
bus_speed
> > > > > > speed)
> > > > > > +{
> > > > > > +=C2=A0=C2=A0=C2=A0 static const u8 speed_conv[] =3D {
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [PCIE_SPEED_2_5GT] =
=3D PCI_EXP_LNKCTL2_TLS_2_5GT,
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [PCIE_SPEED_5_0GT] =
=3D PCI_EXP_LNKCTL2_TLS_5_0GT,
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [PCIE_SPEED_8_0GT] =
=3D PCI_EXP_LNKCTL2_TLS_8_0GT,
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [PCIE_SPEED_16_0GT]=
 =3D PCI_EXP_LNKCTL2_TLS_16_0GT,
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [PCIE_SPEED_32_0GT]=
 =3D PCI_EXP_LNKCTL2_TLS_32_0GT,
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [PCIE_SPEED_64_0GT]=
 =3D PCI_EXP_LNKCTL2_TLS_64_0GT,
> > > > > > +=C2=A0=C2=A0=C2=A0 };
> > > > > > +
> > > > > > +=C2=A0=C2=A0=C2=A0 if (WARN_ON_ONCE(!pcie_valid_speed(speed)))
> > > > >=20
> > > > > drivers/pci/pci.h doesn't seem to have include for WARN_ON_ONCE()=
 so
> > > > > you
> > > > > should add it.
> > > >=20
> > > > Hi Ilpo,
> > > >=20
> > > > In the file "drivers/pci/pcie/bwctrl.c", there is no reference to t=
he
> > > > header
> > > > file of WARN_ON_ONCE(). It seems that no error was reported. I thin=
k it
> > > > might
> > > > be that some other header files have indirectly referenced the head=
er
> > > > file of
> > > > WARN_ON_ONCE(). However, when I compiled it locally, no errors were
> > > > reported.
> > >=20
> > > Hi,
> > >=20
> > > Apparently it was missing from there as well.
> > >=20
> > > It might build now (I don't actually even doubt that), but that depen=
ds
> > > on the includes in every file including drivers/pci/pci.h. We should =
not
> > > depend on that as it is fragile but ensure a header is self-sufficien=
t
> > > when it comes to includes necessary for it.
> >=20
> > Hi Ilpo,
> >=20
> > OK, I see.
> >=20
> >=20
> > >=20
> > > > I think if we want to add a header file, it should be #include
> > > > <asm-generic/bug.h> ?
> > >=20
> > > Yes
> > >=20
> > > #include <asm/bug.h>
>=20
> Hi Ilpo,
>=20
> Executing the following check script will trigger a warning. However, usi=
ng
> #include <asm-generic/bug.h> will not cause any issues. So, should we use
> #include <asm-generic/bug.h> ?
>=20
> ./scripts/checkpatch.pl ...../*patch
>=20
> 0002-PCI-Move-pci_bus_speed2lnkctl2-to-public-header.patch
> ---------------------------------------------------------------------
> WARNING: Use #include <linux/bug.h> instead of <asm/bug.h>
> #27: FILE: drivers/pci/pci.h:5:
> +#include <asm/bug.h>
>=20
> total: 0 errors, 1 warnings, 53 lines checked
>=20
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inpl=
ace.

This is a header, so using <asm/bug.h> minimizes what it pulls in so it=20
is justified to use asm/ over linux/ in this case.


--=20
 i.

--8323328-2055045750-1775566408=:983--
