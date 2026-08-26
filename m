Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FC3388E4E;
	Wed, 26 Aug 2026 14:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787754502; cv=none; b=JRPahhE0mGIZNHJWYw3p1aS+F4uOYdERl6JBssxasZWTqi8Q8S4Wzqt9GTrEbi9MuTvvqw3TfEQFThAB4GSZnb1S6bU5YXkk6GPOUzER9EjsBfjPkyCUgudBoLSprrMthfOjoAAfohZP3rzYD/onMiECBuFOg4zUBofP0+w1Jg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787754502; c=relaxed/simple;
	bh=oefbwwsQLVMqvwQz9VktJBOzGvOgDcAnvZm1QKkyqoI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nX07Sg8+fP0SMfd33DQ4oAEO9tWDAGav3j3I5qPRijpnQ7jshvWDeoTRBBHDS/SAetj5W4BrXc0vesdqNQhJAKF57H2cBrEoBbx/+bZBoEgYNooDxBOZFs/WBolIPxMDQfNuTmuVx/SrwMdcrxQ0RzbQbArjPKsXQ8yv3VnpdL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gOc5w8hu; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gOc5w8hu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787754498; x=1819290498;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=oefbwwsQLVMqvwQz9VktJBOzGvOgDcAnvZm1QKkyqoI=;
  b=gOc5w8hu7e5Wj2twQwQszNRBQEkyYzyv3HQumzHGbWcPR/LgBpDY6eH/
   f1XhOrmHtXYJIIiE8DKI2pA4W8vsI8yx4hJVPzCzY8x5hJDP0POLmZ7Ea
   mmxhZNYbD7oxei9AUy8CadGhDLwO91+nnYaPLjMCzcWEmx71cCF5xzP+H
   9urBsdFKlv03LIW2eN999JENbPg5QZCdpH2tCGY1C1l2rL+xjI/O5A6KM
   wbCIyhNmTXgVSPkizd5aonrjo5O9Oe/6SwDlSCp1VrhiONdinAZUaOBak
   RQHg3unsR+vYnRe8L3b/G1nA4D3q/3yfjZhWn/GaiNWjhA+9wt4A1ojAB
   g==;
X-CSE-ConnectionGUID: LtLGMULoS02TpbL60QrgRg==
X-CSE-MsgGUID: I51H42AeRYmCBYCtEvM3xA==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="88003269"
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="88003269"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 07:28:17 -0700
X-CSE-ConnectionGUID: Em7ztitfTHyI89/6YgmhGA==
X-CSE-MsgGUID: 2F01p6mFSCSwEstJlAtp3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="297484890"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.247])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 07:28:15 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 26 Aug 2026 17:28:11 +0300 (EEST)
To: =?ISO-2022-JP?Q?JC_Chen=5B=1B$BDDqApP=1B=28J=5D?= <jc_chen@diodes.com>
cc: Bjorn Helgaas <helgaas@kernel.org>, Nirmoy Das <nirmoyd@nvidia.com>, 
    Bjorn Helgaas <bhelgaas@google.com>, 
    "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH] PCI: Work around Pericom PI7C9X3G606GPC Port 4 BAR
 erratum
In-Reply-To: <TYQPR02MB90041221BDD960DDD05CF63DF3CF2@TYQPR02MB9004.apcprd02.prod.outlook.com>
Message-ID: <b4d8e820-4cd5-7225-5078-678c4f191297@linux.intel.com>
References: <20260723161010.2638956-1-nirmoyd@nvidia.com> <20260723205413.GA852929@bhelgaas> <TYQPR02MB90041221BDD960DDD05CF63DF3CF2@TYQPR02MB9004.apcprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1298480256-1787754491=:1168"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1298480256-1787754491=:1168
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 24 Jul 2026, JC Chen[=E9=99=B3=E9=A5=92=E9=9D=9C] wrote:

>=20
> Hi,
>=20
> =C2=A0
>=20
> Attached are kernel log "dmesg.log" and lspci "lspci.log" output.
>=20
> =C2=A0
>=20
> I guess without this patch, MSI-X from the downstream port doesn't work c=
orrectly?
>=20
> =3D> YES
>=20
> =C2=A0
>=20
> By "mirror", I guess you mean you want the same value in BAR 0 of both th=
e switch
> upstream port and the downstream port?
>=20
> =3D> Yes, please use the same value in BAR 0 of both the switch upstream =
and downstream
> ports.
>=20
> I don't know what that even means, because the upstream port BAR 0 can't =
be inside
> its memory window, so reads should never reach the downstream port.
>
> =3D> Yes, you are correct that the upstream port BAR 0 can't be inside it=
s memory
> window, so reads should never reach the downstream port. When CDEP functi=
on is
> disabled, BAR0 of P4 is read as all zeros. If root complex send out memor=
y address
> 0x7F000 or 0x7F080 to P4, it will hit P4=E2=80=99s MSI-X Table or PBA add=
ress range, switch
> will response UR and then cause SOC reports timeout. To avoid this issue,=
 the patch
> write P0=E2=80=99s BAR0 to P4=E2=80=99s BAR0.

Hi,

I have problem of understanding why touching that downstream BAR helps=20
because the bridge windows on 0000:17:00.0 are disabled.

--=20
 i.

>=20
> =C2=A0
>=20
> Thanks,
>=20
> JC
>=20
> =C2=A0
>=20
> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Friday, July 24, 2026 4:54 AM
> To: Nirmoy Das <nirmoyd@nvidia.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>; linux-pci@vger.kernel.org;
> linux-kernel@vger.kernel.org; JC Chen[=E9=99=B3=E9=A5=92=E9=9D=9C] <jc_ch=
en@diodes.com>; Ilpo J=C3=A4rvinen
> <ilpo.jarvinen@linux.intel.com>
> Subject: Re: [RFC PATCH] PCI: Work around Pericom PI7C9X3G606GPC Port 4 B=
AR erratum
>=20
> =C2=A0
>=20
> [You don't often get email from helgaas@kernel.org. Learn why this is imp=
ortant at
> https://aka.ms/LearnAboutSenderIdentification ]
>=20
> =C2=A0
>=20
> [+cc Ilpo, this sounds really weird from a resource perspective]
>=20
> =C2=A0
>=20
> On Thu, Jul 23, 2026 at 09:10:00AM -0700, Nirmoy Das wrote:
>=20
> > The Pericom PI7C9X3G606GPC PCIe switch has an erratum where downstream
>=20
> > Port 4 retains a default MSI-X table and PBA decode when BAR 0 is zero.
>=20
> > Memory reads that match this window are dropped with an Unsupported
>=20
> > Request completion, which may cause the SoC to report a timeout.
>=20
> =C2=A0
>=20
> Help me understand what's going on here.=C2=A0 Can you share the dmesg lo=
g of enumeration
> and resource assignment and the "lspci -v" output for the whole switch (b=
oth upstream
> and downstream ports) without this patch?
>=20
> =C2=A0
>=20
> I guess without this patch, MSI-X from the downstream port doesn't work c=
orrectly?
>=20
> =C2=A0
>=20
> > The workaround is to make Port 4 BAR 0 mirror BAR 0 of the immediate
>=20
> > upstream port. Firmware may establish this at boot, but PCI resource
>=20
> > assignment can move upstream BAR 0 without updating Port 4.
>=20
> =C2=A0
>=20
> By "mirror", I guess you mean you want the same value in BAR 0 of both th=
e switch
> upstream port and the downstream port?=C2=A0 I don't know what that even =
means, because
> the upstream port BAR 0 can't be inside its memory window, so reads shoul=
d never
> reach the downstream port.
>=20
> =C2=A0
>=20
> > For a 64-bit BAR, also mirror BAR 1 while memory decoding is disabled,
>=20
> > matching the PCI core update sequence. Port 4 BAR 0 may read back as
>=20
> > zero after a successful write, so do not use readback to validate the u=
pdate.
>=20
> >=C2=A0
>=20
> > Signed-off-by: Nirmoy Das <nirmoyd@nvidia.com>
>=20
> > ---
>=20
> >=C2=A0 drivers/pci/quirks.c | 92
>=20
> > ++++++++++++++++++++++++++++++++++++++++++++
>=20
> >=C2=A0 1 file changed, 92 insertions(+)
>=20
> >=C2=A0
>=20
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c index
>=20
> > b09f27f7846fc..fa8098d77adb5 100644
>=20
> > --- a/drivers/pci/quirks.c
>=20
> > +++ b/drivers/pci/quirks.c
>=20
> > @@ -6264,6 +6264,98 @@ DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_PERICOM,
>=20
> > 0xb404,=C2=A0 DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_PERICOM, 0xb404,
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_fixu=
p_pericom_acs_store_forward);
>=20
> >=C2=A0
>=20
> > +#define PCI_DEVICE_ID_PERICOM_PI7C9X3G606GPC 0xc008
>=20
> > +
>=20
> > +/*
>=20
> > + * Pericom PI7C9X3G606GPC switch erratum E15 -
>=20
> > + * Downstream Port 4 BAR 0 must mirror the immediate upstream port
>=20
> > +BAR 0
>=20
> > + *
>=20
> > + * Port 4 uses BAR 0 for its MSI-X table and PBA. Firmware may
>=20
> > +program this
>=20
> > + * mirror at boot, but Linux resource assignment can move the
>=20
> > +upstream BAR
>=20
> > + * and leave Port 4 with a stale mirror.
>=20
> > + *
>=20
> > + * Diodes confirmed Tile0/P4 appears to Linux as device 4, function 0
>=20
> > +on the
>=20
> > + * bus below the upstream port. Match that downstream function and
>=20
> > +re-apply
>=20
> > + * the mirror after resource assignment and early resume.
>=20
> > + */
>=20
> > +static void pci_fixup_pericom_pi7c9x3g606gpc_bar0_mirror(struct
>=20
> > +pci_dev *pdev) {
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct pci_dev *upstream;
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 bool bar0_64, disable_mem;
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 u16 cmd =3D 0;
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 u32 bar =3D 0, bar1 =3D 0, upstream_bar =3D 0=
, upstream_bar1 =3D 0;
>=20
> > +
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (pci_pcie_type(pdev) !=3D PCI_EXP_TYPE_DOW=
NSTREAM)
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return;
>=20
> > +
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (PCI_SLOT(pdev->devfn) !=3D 4 || PCI_FUNC(=
pdev->devfn))
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return;
>=20
> > +
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 upstream =3D pci_upstream_bridge(pdev);
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (!upstream || upstream->vendor !=3D PCI_VE=
NDOR_ID_PERICOM ||
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 upstream->device !=3D=
 PCI_DEVICE_ID_PERICOM_PI7C9X3G606GPC ||
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_pcie_type(upstrea=
m) !=3D PCI_EXP_TYPE_UPSTREAM)
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return;
>=20
> > +
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 pci_read_config_dword(upstream, PCI_BASE_ADDR=
ESS_0, &upstream_bar);
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (upstream_bar & PCI_BASE_ADDRESS_SPACE_IO)
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return;
>=20
> > +
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 bar0_64 =3D (upstream_bar & PCI_BASE_ADDRESS_=
MEM_TYPE_MASK) =3D=3D
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 PCI_BASE_ADDRESS_MEM_TYPE_64;
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (bar0_64)
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 pci_read_config_dword(upstream, PCI_BASE_ADDRESS_1,
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &upstream_bar1=
);
>=20
> > +
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (!(upstream_bar & PCI_BASE_ADDRESS_MEM_MAS=
K) &&
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (!bar0_64 || !upstrea=
m_bar1)) {
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 pci_warn(pdev, "skipping PI7C9X3G606GPC BAR 0 mirror workaround
> because upstream BAR 0 is unassigned\n");
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return;
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> > +
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 pci_read_config_dword(pdev, PCI_BASE_ADDRESS_=
0, &bar);
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (bar0_64) {
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 pci_read_config_dword(pdev, PCI_BASE_ADDRESS_1, &bar1);
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (bar =3D=3D upstream_bar && bar1 =3D=3D upstream_bar1)
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (bar =3D=3D upstream_bar)
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> > +
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /*
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Port 4 BAR 0 may read back as zero ev=
en after a successful write.
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * If BAR 0 is configured as 64-bit, BAR=
 1 is the upper half.
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Disable memory decoding while updatin=
g both dwords, matching PCI
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * core's 64-bit BAR update sequence.
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 disable_mem =3D bar0_64 && !pdev->mmio_always=
_on;
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (disable_mem) {
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 pci_read_config_word(pdev, PCI_COMMAND, &cmd);
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 pci_write_config_word(pdev, PCI_COMMAND,
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cmd & ~PCI_COM=
MAND_MEMORY);
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> > +
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 pci_write_config_dword(pdev, PCI_BASE_ADDRESS=
_0, upstream_bar);
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (bar0_64)
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 pci_write_config_dword(pdev, PCI_BASE_ADDRESS_1, upstream_bar1);
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (disable_mem)
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 pci_write_config_word(pdev, PCI_COMMAND, cmd);
>=20
> > +
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (bar0_64)
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 pci_info(pdev, "wrote upstream BAR 0/1 %#x/%#x to Port 4 BAR 0/1 for
> PI7C9X3G606GPC BAR 0 mirror workaround\n",
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 upstream_bar, ups=
tream_bar1);
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 else
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 pci_info(pdev, "wrote upstream BAR 0 %#x to Port 4 BAR 0 for
> PI7C9X3G606GPC BAR 0 mirror workaround\n",
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 upstream_bar);
>=20
> > +}
>=20
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_PERICOM,
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PCI_DEVICE_ID_PERICOM_P=
I7C9X3G606GPC,
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_fixup_pericom_pi7c9=
x3g606gpc_bar0_mirror);
>=20
> > +DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_PERICOM,
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 PCI_DEVICE_ID_PERICOM_PI7C9X3G606GPC,
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0
>=20
> > +pci_fixup_pericom_pi7c9x3g606gpc_bar0_mirror);
>=20
> > +
>=20
> >=C2=A0 static void nvidia_ion_ahci_fixup(struct pci_dev *pdev)=C2=A0 {
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pdev->dev_flags |=3D PCI_DEV_FLAGS_=
HAS_MSI_MASKING;
>=20
> >=C2=A0
>=20
> > base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
>=20
> > --
>=20
> > 2.43.0
>=20
> >=C2=A0
>=20
>=20
>=20

--=20
 i.

--8323328-1298480256-1787754491=:1168--
