Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00A4346795;
	Wed,  8 Apr 2026 17:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775668234; cv=none; b=URhBHLWbS7gcam3SL2wn3Eu9KPnhVXqnpt1pzde9qEJDlb+/M9tn+XRfv9RAo9ZUq6iSuqtEZuNsmWPl3Gglxa/5N1Sn/xF2w3sGCsrppHH6MJIS8YxTP+Tzms01Ysp1sBk1teURfw/b+dHgM/ExEkj+q4pMfu76ySGEW1rhNXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775668234; c=relaxed/simple;
	bh=VemTHUNOHqbQhomT+Nwffv1fwuVRoqZYJeo1rBqbfRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sxnNyUrLo/DILxcydkhOXZK0Tw8llQ6zLdefYsF7+YpAvlSAsiLcTaEqK7X4iMu3/Sml+hy6SUwVAll0Yhjbi4iuxUDFlmpKtzkmKYpxMYgHUwPZA5bUNaj4s2JqKw2eqknZdJs+5uVRGvI6AElnaJuRxCSkuoctQpBurLhJY/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQyxn6a3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQyxn6a3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 721F8C19421;
	Wed,  8 Apr 2026 17:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775668233;
	bh=VemTHUNOHqbQhomT+Nwffv1fwuVRoqZYJeo1rBqbfRs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dQyxn6a3xAGTnA/HWecd7jmECH8FShhe631u+N2mcXjikdaV6k6i7k0b2sPOn2/yp
	 OiaqyUPWqyYZ5RL228fsYVJ9ZafY8X0vhci7EI6k+6tkcracqOvWprcs0nRiHMjIiN
	 etgDQSA0NwChnr7dRHPbkww1RAGqo7kBLhz2sdhjgbvNLmdPp5a0+Z1TMTKoIxArf/
	 xhLBAdsKinHFh7bAFTGfgOz0svtiu1MDSsmME57iXE8KI4LadeqXfUa4km6fuHp4LA
	 FT3m+gjV9NBEcAWB5ndoBFgQeowUYnfWVNZ3gQpn3XINr9OucV2+d+atc2T6KH9hxG
	 9UwnlkUtDdc2Q==
Date: Wed, 8 Apr 2026 18:10:28 +0100
From: Conor Dooley <conor@kernel.org>
To: Jia Wang <wangjia@ultrarisc.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Xincheng Zhang <zhangxincheng@ultrarisc.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/4] riscv: add UltraRISC SoC family Kconfig support
Message-ID: <20260408-wise-dividers-ec8a057d4bd2@spud>
References: <20260407-ultrarisc-pcie-v2-0-2aa2a19a7fb3@ultrarisc.com>
 <20260407-ultrarisc-pcie-v2-1-2aa2a19a7fb3@ultrarisc.com>
 <20260407-shown-guileless-5c8b8d94f5e5@spud>
 <177561282495.2731393.9548650582911498336.b4-reply@b4>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PAOwAJ1VswMSS1Ix"
Content-Disposition: inline
In-Reply-To: <177561282495.2731393.9548650582911498336.b4-reply@b4>


--PAOwAJ1VswMSS1Ix
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 08, 2026 at 09:47:04AM +0800, Jia Wang wrote:
> On 2026-04-07 17:29 +0100, Conor Dooley wrote:
> > On Tue, Apr 07, 2026 at 10:40:52AM +0800, Jia Wang wrote:
> > > The first SoC in the UltraRISC series is UR-DP1000, containing octa
> > > UltraRISC C100 cores.
> >=20
> > Not gonna lie, I find it odd that pcie is where this platform starts
> > off, but sure. What's the plan for adding the rest of the platform?
> >
>=20
> Hi Conor,
>=20
> Thanks for the question.
>=20
> Our next step is to upstream the pinctrl driver together with the related
> DTS updates. The pinctrl series only affects the SoC=E2=80=99s low-speed =
peripheral
> interfaces. For GMAC, SPI, I2C, and GPIO, we plan to use the existing
> kernel drivers, so no new controller drivers are needed=20

And clocks? pinctrl and clocks would be the bare minimum level of
support required before a platform should be merged. Obviously, you can
get device drivers for PCI etc etc merged without clock drivers, but the
initial dts should contain the clocks too.

> > >=20
> > > Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
> > > ---
> > >  arch/riscv/Kconfig.socs | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > >=20
> > > diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> > > index d621b85dd63b..98708569ec6a 100644
> > > --- a/arch/riscv/Kconfig.socs
> > > +++ b/arch/riscv/Kconfig.socs
> > > @@ -84,6 +84,15 @@ config ARCH_THEAD
> > >  	help
> > >  	  This enables support for the RISC-V based T-HEAD SoCs.
> > > =20
> > > +config ARCH_ULTRARISC
> > > +	bool "UltraRISC RISC-V SoCs"
> > > +	help
> > > +	  This enables support for UltraRISC SoC platform hardware,
> > > +	  including boards based on the UR-DP1000.
> >=20
> > > +	  UR-DP1000 is an 8-core 64-bit RISC-V SoC that supports
> > > +	  the RV64GCBHX ISA. It supports Hardware Virtualization
> > > +	  and RISC-V RV64 ISA H(v1.0) Extension.
> >=20
> > Delete this section IMO, doesn't provide any real value. Don't need nor
> > want the marketing brochure in the help text. The first sentence is
> > sufficient.
> >
>=20
> I=E2=80=99ll drop the SoC description part from the Kconfig help text as =
you
> suggested.
> =20
> > > +
> > >  config ARCH_VIRT
> > >  	bool "QEMU Virt Machine"
> > >  	select POWER_RESET
> > >=20
> > > --=20
> > > 2.34.1
> > >=20
>=20
> Best regards,
> Jia Wang
>=20

--PAOwAJ1VswMSS1Ix
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCadaMAwAKCRB4tDGHoIJi
0s4aAP4/zVM8abd/kBx74iWV4RRMqLs8Q8+zIaMqjQAhxLbkDQEAt8x6jy+kcvVd
XeqklOhbRz0kXh31JASEBm4BQ3iRhQQ=
=nYVT
-----END PGP SIGNATURE-----

--PAOwAJ1VswMSS1Ix--
