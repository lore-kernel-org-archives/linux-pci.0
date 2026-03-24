Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FA33E8C57;
	Tue, 24 Mar 2026 11:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774351091; cv=none; b=ZZtYWbolROTMUEBak6LR/vOnhmFENSGPyelImbkFVnRvvYxne/q5I7nY60KQG+z1Y30guPJNVp98wUqt6vbbfO+3A3gMxiu69WuMHcY+yxAg1+o9xK1flCtUOIZanPccPy3Iw7G9SWycb2HKv7BLgKVLHuurrcqR33QlvDJuxL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774351091; c=relaxed/simple;
	bh=XPt0YDeq+4ztCKiouUecjHrixwCyVqTENTf7aomrlfI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dtiQJKNhFEmIFuwPoQIIPkPRgUbWOqDmzLnlaONqxEC6dh3gLHSWBfrErXA0zE4omAvMjfjPA+Ha4B7pa+3LtsgrXzwS+axe9OHIrZnOpsShgjHQCyVTnvj9mBF9uJCsTseEORxaawfLwebnNUf5Gh18SmioSYepTb5GD/NC9dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UF0Bf+Bn; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UF0Bf+Bn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774351088; x=1805887088;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=XPt0YDeq+4ztCKiouUecjHrixwCyVqTENTf7aomrlfI=;
  b=UF0Bf+Bnox5mSPYcslNr9SGYTdroa/fC93Hs+srkRqNsP66fkUfg+wob
   qov2zJFVlTwID0L/SDhQohEglCAA54QlbjanOVwLW6iGOPyM0kexcVtpU
   sF5NSGf6ZbtRTPPPNjiQ0gmobg+kq7FnQBcn5HqpBQptzTc/ucdSbhzkG
   +SdnASfbHp3w1TdiNxsbVhPnaqqPsDJ0Cmyo/g6VRKcZOW6syWrGBcfyb
   NxBAI0n0K0HVxkGFhiCD+hmpf3+Fv1tMTzYYUAnAmhgojXIbQrfT5W//L
   G+RunKSZ2RnjjgOuJFmufMd+Cr2czhkkLn7JEM0XF1IxcdGcrbvVlVkAU
   Q==;
X-CSE-ConnectionGUID: H2Er5+QpTFGarH9CdChCYw==
X-CSE-MsgGUID: cwvhQ8FfQ62T79oPFr30ew==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="86733299"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="86733299"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 04:18:06 -0700
X-CSE-ConnectionGUID: fJ/h2n20R+619p5HwgQR8g==
X-CSE-MsgGUID: kycy7crlTiq8MYKK/RpEfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="224565057"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.217])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 04:18:03 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 24 Mar 2026 13:18:00 +0200 (EET)
To: mx2pg@pm.me
cc: Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>, 
    Jonathan Corbet <corbet@lwn.net>, linux-pci@vger.kernel.org, 
    linux-doc@vger.kernel.org, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    Kai-Heng Feng <kaihengf@nvidia.com>
Subject: Re: [PATCH] Documentation: PCI: Document decoding of TLP Header in
 AER messages
In-Reply-To: <jlpBGxAZL6_8dQI417NowB0RVfrnwcnuaNvBlTN035buqP4dRBJaaX3fwqtYxZu2evmcNCAJVzj2suZKDA5iriUSrpj_ziWQVWxZS3nEkEg=@pm.me>
Message-ID: <0ca0e817-7c28-011d-5738-f5856d267337@linux.intel.com>
References: <20260323165038.GA830530@bhelgaas> <jlpBGxAZL6_8dQI417NowB0RVfrnwcnuaNvBlTN035buqP4dRBJaaX3fwqtYxZu2evmcNCAJVzj2suZKDA5iriUSrpj_ziWQVWxZS3nEkEg=@pm.me>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1544536909-1774351080=:1055"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1544536909-1774351080=:1055
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 24 Mar 2026, mx2pg@pm.me wrote:

>   One thing worth calling out: starting with PCIe 6.0, Flit Mode is      =
                                                                           =
                                         =20
>   mandatory at 64.0 GT/s and supported at all PCIe link speeds, so a     =
                                                                           =
                                         =20
>   Flit-capable PCIe 6.x link may operate below 64.0 GT/s and still be    =
                                                                           =
                                         =20
>   in Flit Mode.  The raw TLP Header bytes do not encode the framing =E2=
=80=94                                                                     =
                                                   =20
>   the same four bytes decode to entirely different packet types in  =20
>   non-Flit vs Flit framing.  The negotiated mode can be read from the    =
                                                                           =
                                         =20
>   Flit Mode Status bit in Link Status 2, or via lspci -vv on a recent    =
                                                                           =
                                         =20
>   pciutils build.                                                   =20

There's one caveat in using Link Status 2 Flit Mode Status bit, it can=20
only be used as the indicator when the Link is Up, which may come into=20
picture in troubleshooting scenarios.

The kernel code tries to hide that by indicating the Flit mode explicitly=
=20
in the log message it prints out.

Sadly, TLP Logging on DPC side was botched in the PCIe spec so it doesn't=
=20
indicate the Flit/non-Flit mode information explicitly (in contrast to AER=
=20
that has a flag that tells in which mode the TLP Log was captured). To=20
workaround that limitation, kernel has to save of the Link Status 2=20
contents and hope the information is not stale when DPC has brought the=20
Link Down (it seems relatively likely to remain valid but it's still=20
fundamentally racy way to get the Flit/non-Flit information).

--=20
 i.

>   tlp-tool defaults to non-Flit, which is correct for the vast majority  =
                                                                           =
                                         =20
>   of hardware deployed today.  That will change: as PCIe 6.x adoption =20
>   grows, a significant share of TLP debugging will involve Flit Mode     =
                                                                           =
                                         =20
>   links, and this is already a concern among switch and device vendors   =
                                                                           =
                                         =20
>   working through the transition.  Users on Flit Mode links must pass    =
                                                                           =
                                         =20
>   --flit:                                                                =
                                                                           =
                                         =20
>                                                                          =
                                                                           =
                                         =20
>     # non-Flit link (default, most common today)                         =
                                                                           =
                                         =20
>     curl -L https://git.kernel.org/linus/2ca1c94ce0b6 | rtlp-tool --aer  =
                                                                           =
                                         =20
>                                                                       =20
>     # Flit Mode link                                                     =
                                                                           =
                                         =20
>     curl -L https://git.kernel.org/linus/2ca1c94ce0b6 | rtlp-tool --aer -=
-flit
>                                                                          =
    =20
>   It may be worth a one-liner in the Documentation patch:                =
                                                                           =
                                         =20
>                                                         =20
>     For PCIe 6.x links with Flit Mode negotiated (check Flit Mode Status =
                                                                           =
                                         =20
>     in Link Status 2, or lspci -vv), pass --flit to rtlp-tool.           =
                                                                           =
                                         =20
>   =20
>   Maciej    =20
>=20
>=20
>=20
> On Monday, March 23rd, 2026 at 9:50 AM, Bjorn Helgaas <helgaas@kernel.org=
> wrote:
>=20
> > On Mon, Mar 23, 2026 at 07:52:39AM +0100, Lukas Wunner wrote:
> > > The prefix/header of the TLP that caused an error is recorded by the =
Root
> > > Complex and emitted to the kernel log in raw hex format.  Document th=
e
> > > existence and usage of tlp-tool, which allows decoding the TLP Header
> > > into human-readable form.
> > >
> > > The TLP Header hints at the root cause of an error, yet is often igno=
red
> > > because of its seeming opaqueness.  Instead, PCIe errors are frequent=
ly
> > > worked around by a change in the kernel without fully understanding t=
he
> > > actual source of the problem.  With more documentation on available t=
ools
> > > we'll hopefully come up with better solutions.
> > >
> > > There are also wireshark dissectors for TLPs, but it seems they expec=
t a
> > > complete TLP, not just the header, and they cannot grok the hex forma=
t
> > > emitted by the kernel directly.  tlp-tool appears to be the most cut =
and
> > > dried solution out there.
> > >
> > > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > > Cc: Maciej Grochowski <mx2pg@pm.me>
> >=20
> > Applied to pci/for-linus for v7.0, thanks!
> >=20
> > I tweaked the commit log to note that the Header Log is in the AER
> > Capability, which may be in any PCIe function.
> >=20
> > > ---
> > > We could also go one step further and point users to this tool
> > > in a printk_once() message when the first error occurs.
> > > For now, just amending the documentation is probably sufficient.
> > >
> > >  Documentation/PCI/pcieaer-howto.rst | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > diff --git a/Documentation/PCI/pcieaer-howto.rst b/Documentation/PCI/=
pcieaer-howto.rst
> > > index 3210c47..90fdfdd 100644
> > > --- a/Documentation/PCI/pcieaer-howto.rst
> > > +++ b/Documentation/PCI/pcieaer-howto.rst
> > > @@ -85,6 +85,16 @@ In the example, 'Requester ID' means the ID of the=
 device that sent
> > >  the error message to the Root Port. Please refer to PCIe specs for o=
ther
> > >  fields.
> > >
> > > +The 'TLP Header' is the prefix/header of the TLP that caused the err=
or
> > > +in raw hex format. To decode the TLP Header into human-readable form
> > > +one may use tlp-tool:
> > > +
> > > +https://github.com/mmpg-x86/tlp-tool
> > > +
> > > +Example usage::
> > > +
> > > +  curl -L https://git.kernel.org/linus/2ca1c94ce0b6 | rtlp-tool --ae=
r
> > > +
> > >  AER Ratelimits
> > >  --------------
> > >
> > > --
> > > 2.51.0
> > >
> >
>=20
--8323328-1544536909-1774351080=:1055--
