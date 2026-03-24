Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAA1215F6B
	for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 05:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774331626; cv=none; b=GMe67zo3b9Ekm3KCcggyaNTexk4Ch4PqYBoMk+p3eb3pR3XbILh+oAfrxcyaIJS4UbcgSd1iaMN3OjBeo6S0UDKvSM8Tpu8WTQy1RyHV19R1x8Hvj77RsmTwmbwkSoh7v7x2OuX615vfLUnwtzRfwxsOQdbyJcQ4uV0hEnzPI10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774331626; c=relaxed/simple;
	bh=7Kwr5ahwc1SLBh98Koj2kpTyp8J0ZK6K8uIETiGkRfM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qn67E4aDEuONpVfutCq7gkdKDYxy8Kk+6ETtuXXXd0uOAq6D/5dVnyb0HKAGDjNw2FTlSGTZYC3ooPSn/4uWeDvbF4ckpLhVjzD11i3MpVKF8XiETeTEAucFT+Qq9Q9/37WJ/2Yb2cIKu2IGkb5y/VyGkarygYogvLhecxD1ems=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=S2JvZLfC; arc=none smtp.client-ip=109.224.244.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="S2JvZLfC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1774331616; x=1774590816;
	bh=lZYMDkNctrcYm24rTUbHsJxXF75rTtX+72u0W3PoQhU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=S2JvZLfC9aScP7BePsT5X5FdmhhDOANGiL98+2FxzrCDRuDjCEpbcqY5DfKbxGJRk
	 GRa4o987FSGZ3SHIIM467BPp7+u4wK1XcMJ8/Uz4gCgSOrch1WzD3WSk1bR3dP8eJ8
	 q6SLRJN5/8fFPol4ieCPMJ+j7+tsaZ+cEkR+8qxx/ft5d1WXHspa3FMW91pGQTX6L1
	 ediLO+5ZQlv9O/kHpU317yAb7DdNg/s2eGdDMpz2TF642RzZhORjjQTKhrLIca+Z/A
	 fMIf4NzG/8OnaLPvHV+fgTSmiZuMnl3i39o/jVOhgyFBr4crK4yx1Ms3VIiKj5Kb4C
	 xJhSHNCVMqYGg==
Date: Tue, 24 Mar 2026 05:53:30 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
From: mx2pg@pm.me
Cc: Lukas Wunner <lukas@wunner.de>, Jonathan Corbet <corbet@lwn.net>, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, Kai-Heng Feng <kaihengf@nvidia.com>
Subject: Re: [PATCH] Documentation: PCI: Document decoding of TLP Header in AER messages
Message-ID: <jlpBGxAZL6_8dQI417NowB0RVfrnwcnuaNvBlTN035buqP4dRBJaaX3fwqtYxZu2evmcNCAJVzj2suZKDA5iriUSrpj_ziWQVWxZS3nEkEg=@pm.me>
In-Reply-To: <20260323165038.GA830530@bhelgaas>
References: <20260323165038.GA830530@bhelgaas>
Feedback-ID: 168671048:user:proton
X-Pm-Message-ID: 49e3d4638ab22c96b083138dc14f35e22e4ba111
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

  One thing worth calling out: starting with PCIe 6.0, Flit Mode is        =
                                                                           =
                                       =20
  mandatory at 64.0 GT/s and supported at all PCIe link speeds, so a       =
                                                                           =
                                       =20
  Flit-capable PCIe 6.x link may operate below 64.0 GT/s and still be      =
                                                                           =
                                       =20
  in Flit Mode.  The raw TLP Header bytes do not encode the framing =
=E2=80=94                                                                  =
                                                      =20
  the same four bytes decode to entirely different packet types in  =20
  non-Flit vs Flit framing.  The negotiated mode can be read from the      =
                                                                           =
                                       =20
  Flit Mode Status bit in Link Status 2, or via lspci -vv on a recent      =
                                                                           =
                                       =20
  pciutils build.                                                   =20
                                                                           =
                                                                           =
                                       =20
  tlp-tool defaults to non-Flit, which is correct for the vast majority    =
                                                                           =
                                       =20
  of hardware deployed today.  That will change: as PCIe 6.x adoption =20
  grows, a significant share of TLP debugging will involve Flit Mode       =
                                                                           =
                                       =20
  links, and this is already a concern among switch and device vendors     =
                                                                           =
                                       =20
  working through the transition.  Users on Flit Mode links must pass      =
                                                                           =
                                       =20
  --flit:                                                                  =
                                                                           =
                                       =20
                                                                           =
                                                                           =
                                       =20
    # non-Flit link (default, most common today)                           =
                                                                           =
                                       =20
    curl -L https://git.kernel.org/linus/2ca1c94ce0b6 | rtlp-tool --aer    =
                                                                           =
                                       =20
                                                                      =20
    # Flit Mode link                                                       =
                                                                           =
                                       =20
    curl -L https://git.kernel.org/linus/2ca1c94ce0b6 | rtlp-tool --aer --f=
lit
                                                                           =
  =20
  It may be worth a one-liner in the Documentation patch:                  =
                                                                           =
                                       =20
                                                        =20
    For PCIe 6.x links with Flit Mode negotiated (check Flit Mode Status   =
                                                                           =
                                       =20
    in Link Status 2, or lspci -vv), pass --flit to rtlp-tool.             =
                                                                           =
                                       =20
  =20
  Maciej    =20



On Monday, March 23rd, 2026 at 9:50 AM, Bjorn Helgaas <helgaas@kernel.org> =
wrote:

> On Mon, Mar 23, 2026 at 07:52:39AM +0100, Lukas Wunner wrote:
> > The prefix/header of the TLP that caused an error is recorded by the Ro=
ot
> > Complex and emitted to the kernel log in raw hex format.  Document the
> > existence and usage of tlp-tool, which allows decoding the TLP Header
> > into human-readable form.
> >
> > The TLP Header hints at the root cause of an error, yet is often ignore=
d
> > because of its seeming opaqueness.  Instead, PCIe errors are frequently
> > worked around by a change in the kernel without fully understanding the
> > actual source of the problem.  With more documentation on available too=
ls
> > we'll hopefully come up with better solutions.
> >
> > There are also wireshark dissectors for TLPs, but it seems they expect =
a
> > complete TLP, not just the header, and they cannot grok the hex format
> > emitted by the kernel directly.  tlp-tool appears to be the most cut an=
d
> > dried solution out there.
> >
> > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > Cc: Maciej Grochowski <mx2pg@pm.me>
>=20
> Applied to pci/for-linus for v7.0, thanks!
>=20
> I tweaked the commit log to note that the Header Log is in the AER
> Capability, which may be in any PCIe function.
>=20
> > ---
> > We could also go one step further and point users to this tool
> > in a printk_once() message when the first error occurs.
> > For now, just amending the documentation is probably sufficient.
> >
> >  Documentation/PCI/pcieaer-howto.rst | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/Documentation/PCI/pcieaer-howto.rst b/Documentation/PCI/pc=
ieaer-howto.rst
> > index 3210c47..90fdfdd 100644
> > --- a/Documentation/PCI/pcieaer-howto.rst
> > +++ b/Documentation/PCI/pcieaer-howto.rst
> > @@ -85,6 +85,16 @@ In the example, 'Requester ID' means the ID of the d=
evice that sent
> >  the error message to the Root Port. Please refer to PCIe specs for oth=
er
> >  fields.
> >
> > +The 'TLP Header' is the prefix/header of the TLP that caused the error
> > +in raw hex format. To decode the TLP Header into human-readable form
> > +one may use tlp-tool:
> > +
> > +https://github.com/mmpg-x86/tlp-tool
> > +
> > +Example usage::
> > +
> > +  curl -L https://git.kernel.org/linus/2ca1c94ce0b6 | rtlp-tool --aer
> > +
> >  AER Ratelimits
> >  --------------
> >
> > --
> > 2.51.0
> >
> 
