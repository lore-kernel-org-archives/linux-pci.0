Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5B31D5CC6
	for <linux-pci@vger.kernel.org>; Wed, 25 Mar 2026 05:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774415917; cv=none; b=uEY1vz+Jp1Pqovji33YzC+0wsskupCdTENX3jAsoP8trZ5f7W+K/YERPcIlrJ4gqbU2Ni5UIm1PbeHWybFa8eiVha7DrTrmz7BDp+gitK/yQheMP0Rd5jkNfxHL5AHTAyxMgJrtipiZCPgWCK9Xj3RNS7/c65fjXLC0ju6mOkGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774415917; c=relaxed/simple;
	bh=1M0nJmFTScNHwMtYF08ehKjSh6gmwxwOpth64QH/dKg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RHJdLF/pAv085cAvif7ahpgT/qmbKUUyXdxxQAr5AQNmqhmn3bs8Ds3RYGzzEGN2oACZm0C2tGtu/C+Jr8xQZjHci1eUBd5QpfuDWtXZ9qdHX+IATgdpZi95zULK1PaFqcmMmSRzfjmiufaCxlK80JTefNjE5IwVVY5cQdZN57M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=dDIEx7yS; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="dDIEx7yS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1774415907; x=1774675107;
	bh=qHmLk4Tgb19/N3vXmqwwPWWdp2pOoFTugeb3iP0Ybj0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=dDIEx7ySnla48xB8tnv0e+rjcCmezsMJX8QaJeSr3CMubzDS927/UQS2Le6RST379
	 YTMZGFdQu12bbAE8RWciqHBer5IL7YEyejD5RRLYJeuO7TsOmPTFf3K5QWIO4vgSWu
	 4+MJa/jM/bI5o1qNJOAvfb/m+ZlIpTrMj60MrozQGs8XEqw0Q6AGrhprGDhWFECsj1
	 iOfKXBn+6yDKFBVkDlcOqwRLO7kPJrbuy5eCv1PG1cgM+pKD6NxemJicp/13Ry8uRv
	 dXurUNrtkzSgNrkzNUSj6FPYJvspb7lMvYgPT4l8Uik3xlPnB7TyvDxe5Q07tA8Aa3
	 CZl0HYYZj5A4Q==
Date: Wed, 25 Mar 2026 05:18:22 +0000
To: =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
From: mx2pg@pm.me
Cc: Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>, Jonathan Corbet <corbet@lwn.net>, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Kai-Heng Feng <kaihengf@nvidia.com>
Subject: Re: [PATCH] Documentation: PCI: Document decoding of TLP Header in AER messages
Message-ID: <qThoJTmv00RudWODUQ5g4z3mWX5_Axa-Wa8h8hEr6jwleKuBrXUMEkvzNhvThpsySu9wsnKLuK6XedmboMzDFOZqj_uMFmAOKMb6jgHQciQ=@pm.me>
In-Reply-To: <0ca0e817-7c28-011d-5738-f5856d267337@linux.intel.com>
References: <20260323165038.GA830530@bhelgaas> <jlpBGxAZL6_8dQI417NowB0RVfrnwcnuaNvBlTN035buqP4dRBJaaX3fwqtYxZu2evmcNCAJVzj2suZKDA5iriUSrpj_ziWQVWxZS3nEkEg=@pm.me> <0ca0e817-7c28-011d-5738-f5856d267337@linux.intel.com>
Feedback-ID: 168671048:user:proton
X-Pm-Message-ID: 955b9558e4c5a760401e1c8a10bd254827ea8cad
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thanks Lukas for the suggestion and Ilpo for the caveat on
Link Status 2.

I'll add auto-detection of the (Flit) suffix (7e077e6707b3,
v6.15+) to --aer mode so mixed flit / non-flit TLPs in the same
log are each parsed with the correct framing -- no --flit needed.
For --lspci I'll also pick up Flit+ from LnkSta2: per device.

The --flit flag stays as a global override for inputs without
auto-detection markers.  This will be a patch release (v0.5.1) --
fully backward compatible.

Maciej



On Tuesday, March 24th, 2026 at 4:18 AM, Ilpo J=C3=A4rvinen <ilpo.jarvinen@=
linux.intel.com> wrote:

> On Tue, 24 Mar 2026, mx2pg@pm.me wrote:
>=20
> >   One thing worth calling out: starting with PCIe 6.0, Flit Mode is
> >   mandatory at 64.0 GT/s and supported at all PCIe link speeds, so a
> >   Flit-capable PCIe 6.x link may operate below 64.0 GT/s and still be
> >   in Flit Mode.  The raw TLP Header bytes do not encode the framing =
=E2=80=94
> >   the same four bytes decode to entirely different packet types in
> >   non-Flit vs Flit framing.  The negotiated mode can be read from the
> >   Flit Mode Status bit in Link Status 2, or via lspci -vv on a recent
> >   pciutils build.
>=20
> There's one caveat in using Link Status 2 Flit Mode Status bit, it can
> only be used as the indicator when the Link is Up, which may come into
> picture in troubleshooting scenarios.
>=20
> The kernel code tries to hide that by indicating the Flit mode explicitly
> in the log message it prints out.
>=20
> Sadly, TLP Logging on DPC side was botched in the PCIe spec so it doesn't
> indicate the Flit/non-Flit mode information explicitly (in contrast to AE=
R
> that has a flag that tells in which mode the TLP Log was captured). To
> workaround that limitation, kernel has to save of the Link Status 2
> contents and hope the information is not stale when DPC has brought the
> Link Down (it seems relatively likely to remain valid but it's still
> fundamentally racy way to get the Flit/non-Flit information).
>=20
> --
>  i.
>=20
> >   tlp-tool defaults to non-Flit, which is correct for the vast majority
> >   of hardware deployed today.  That will change: as PCIe 6.x adoption
> >   grows, a significant share of TLP debugging will involve Flit Mode
> >   links, and this is already a concern among switch and device vendors
> >   working through the transition.  Users on Flit Mode links must pass
> >   --flit:
> >
> >     # non-Flit link (default, most common today)
> >     curl -L https://git.kernel.org/linus/2ca1c94ce0b6 | rtlp-tool --aer
> >
> >     # Flit Mode link
> >     curl -L https://git.kernel.org/linus/2ca1c94ce0b6 | rtlp-tool --aer=
 --flit
> >
> >   It may be worth a one-liner in the Documentation patch:
> >
> >     For PCIe 6.x links with Flit Mode negotiated (check Flit Mode Statu=
s
> >     in Link Status 2, or lspci -vv), pass --flit to rtlp-tool.
> >
> >   Maciej
> >
> >
> >
> > On Monday, March 23rd, 2026 at 9:50 AM, Bjorn Helgaas <helgaas@kernel.o=
rg> wrote:
> >
> > > On Mon, Mar 23, 2026 at 07:52:39AM +0100, Lukas Wunner wrote:
> > > > The prefix/header of the TLP that caused an error is recorded by th=
e Root
> > > > Complex and emitted to the kernel log in raw hex format.  Document =
the
> > > > existence and usage of tlp-tool, which allows decoding the TLP Head=
er
> > > > into human-readable form.
> > > >
> > > > The TLP Header hints at the root cause of an error, yet is often ig=
nored
> > > > because of its seeming opaqueness.  Instead, PCIe errors are freque=
ntly
> > > > worked around by a change in the kernel without fully understanding=
 the
> > > > actual source of the problem.  With more documentation on available=
 tools
> > > > we'll hopefully come up with better solutions.
> > > >
> > > > There are also wireshark dissectors for TLPs, but it seems they exp=
ect a
> > > > complete TLP, not just the header, and they cannot grok the hex for=
mat
> > > > emitted by the kernel directly.  tlp-tool appears to be the most cu=
t and
> > > > dried solution out there.
> > > >
> > > > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > > > Cc: Maciej Grochowski <mx2pg@pm.me>
> > >
> > > Applied to pci/for-linus for v7.0, thanks!
> > >
> > > I tweaked the commit log to note that the Header Log is in the AER
> > > Capability, which may be in any PCIe function.
> > >
> > > > ---
> > > > We could also go one step further and point users to this tool
> > > > in a printk_once() message when the first error occurs.
> > > > For now, just amending the documentation is probably sufficient.
> > > >
> > > >  Documentation/PCI/pcieaer-howto.rst | 10 ++++++++++
> > > >  1 file changed, 10 insertions(+)
> > > >
> > > > diff --git a/Documentation/PCI/pcieaer-howto.rst b/Documentation/PC=
I/pcieaer-howto.rst
> > > > index 3210c47..90fdfdd 100644
> > > > --- a/Documentation/PCI/pcieaer-howto.rst
> > > > +++ b/Documentation/PCI/pcieaer-howto.rst
> > > > @@ -85,6 +85,16 @@ In the example, 'Requester ID' means the ID of t=
he device that sent
> > > >  the error message to the Root Port. Please refer to PCIe specs for=
 other
> > > >  fields.
> > > >
> > > > +The 'TLP Header' is the prefix/header of the TLP that caused the e=
rror
> > > > +in raw hex format. To decode the TLP Header into human-readable fo=
rm
> > > > +one may use tlp-tool:
> > > > +
> > > > +https://github.com/mmpg-x86/tlp-tool
> > > > +
> > > > +Example usage::
> > > > +
> > > > +  curl -L https://git.kernel.org/linus/2ca1c94ce0b6 | rtlp-tool --=
aer
> > > > +
> > > >  AER Ratelimits
> > > >  --------------
> > > >
> > > > --
> > > > 2.51.0
> > > >
> > >
> >
