Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795006184;
	b=sEoOhL8tZC1MStgL2D5uaU66mBRnSATTQz7wpwsueiUNegl7LcIlm2c95UG50jmoTbAK
	 nZvfiLy6s6bFvwA0jN6KHebSUeQK5Uwdhd+ZmuIqrMtW1TzGv4PKzI3W24T5ttX3SDDRT
	 f4L+WvRVlxnO8nEL7+MCGUZPinZEM7P+BpupuUn/dlXsgGjrtjlM14DzDGTYC87XF7PgG
	 oBbOYxotBtB1BjrdYubAvmbivj1/IuUytO0IrztdykHZSXwjxKi2HB7PaOs1dxHSx71Ry
	 Ts0M2acwfM+3pVPlwxQkCIpmsPadsxBlJOAkWL5xbQ3HMuOYTsKSOrWIwm3V6ZkQElA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795006184;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=URvBMdGeISFS4Y5PNtgpvQvlUcggA7LAsGg7ALwQkRA=;
	b=SoQ66YDg1DUpyXiRo4VUBY+MwSAIIzPefX4HoZB1UOKHMOLQSauFXaumaVj55SKpw2wR
	 M5/o0hBBaYTPQkja2eq7tZh7GuSgpLUmeLGVsfju2Fjy8V93Bv/B/xY8bB2hK1B5AM4Ey
	 dOjbZ1YJwfce/1EP3g72vVwjLDYc9PvN6C0IHklw1SoVzo8O8MYCaOeBmvpWPMjAGmvm8
	 V6YNLU0zUKq4OF0g+9Ol8PxpqtzsHRn2kddUzhEz5nlSVuqeJSxLPvCzWdTK8cKWOoO8Z
	 K4rVhe/L3cc+3sSH1dlj9ltkzVwxxLCk+txKnIS8OTPAdm0u+pRwIdeVR2fzjdfFPfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IiEJkbeI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F3F606A32A;
	Wed, 18 Nov 2026 12:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IiEJkbeI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B841F000C4;
	Wed, 18 Nov 2026 12:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795006183;
	bh=URvBMdGeISFS4Y5PNtgpvQvlUcggA7LAsGg7ALwQkRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IiEJkbeI+E0iseDW8AYqz3VsqA/LHdXyP4WdB62HYrFCKRbryBg0PeFKR5EEDz6Sb
	 BrODIBXpvWoMmL9vLx+ugP7R8M8bLXqXpfcs3EsqAELi3PgVVSdKP7uZlYAMyiN4x0
	 BnXWv1aMX3OPd3R8hJYgXm9rhk5yPUrAsJxHzA3m6BFumadVEqbgK60Djto9zcvXDd
	 BxR+jxff+HDTfZqZYalfS560GEWju787Np5TkA93JFJptP9cZC4KepmqYP1vWKPqNK
	 TMAPxzQw6tbbIXKU5vCk0uQVGG4e2F/GOa0KcisyrPnAkc9iL/VZ7ON6DvOGZRu6MG
	 //edHFyqRQFUg==
Date: Wed, 18 Nov 2026 13:49:41 +0100
From: Thierry Reding <thierry.reding@kernel.org>
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: devicetree@vger.kernel.org, Bartosz Golaszewski <brgl@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 5/6] arm64: tegra: Add node for the GB10B GPU on Tegra264
Message-ID: <av2epzD6Igno_oza@orome>
References: <20261029-b4-t264-igpu-pci-v1-0-4d843dda0b02@nvidia.com>
 <20261029-b4-t264-igpu-pci-v1-5-4d843dda0b02@nvidia.com>
 <avxBUt6Yo3oKbEZI@orome>
 <IOZkShOKS1Cv0Px6mU4F6g@nvidia.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7sgzgn3uezi5ctku"
Content-Disposition: inline
In-Reply-To: <IOZkShOKS1Cv0Px6mU4F6g@nvidia.com>


--7sgzgn3uezi5ctku
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 5/6] arm64: tegra: Add node for the GB10B GPU on Tegra264
MIME-Version: 1.0

On Wed, Nov 18, 2026 at 09:30:59AM +0900, Mikko Perttunen wrote:
> On Tuesday, November 17, 2026 9:17=E2=80=AFPM Thierry Reding wrote:
> > On Thu, Oct 29, 2026 at 12:32:07PM +0900, Mikko Perttunen wrote:
> > > While the integrated GB10B GPU on Tegra264 is on the PCI bus, it
> > > requires a BPMP power domain to be enabled or it won't enumerate on t=
he
> > > bus. Therefore, describe it and the power domain in the device tree to
> > > allow the power domain to be enabled prior to enumeration.
> > >=20
> > > Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> > > ---
> > >  arch/arm64/boot/dts/nvidia/tegra264.dtsi | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >=20
> > > diff --git a/arch/arm64/boot/dts/nvidia/tegra264.dtsi b/arch/arm64/bo=
ot/dts/nvidia/tegra264.dtsi
> > > index 5ab34cd09a3d..4c8b320ecc40 100644
> > > --- a/arch/arm64/boot/dts/nvidia/tegra264.dtsi
> > > +++ b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
> > > @@ -3597,6 +3597,12 @@ pcie@0 {
> > >  				#address-cells =3D <3>;
> > >  				#size-cells =3D <2>;
> > >  				ranges;
> > > +
> > > +				gpu@0 {
> > > +					compatible =3D "pci10de,2b00";
> > > +					reg =3D <0x00010000 0x0 0x0 0x0 0x0>;
> > > +					power-domains =3D <&bpmp TEGRA264_POWER_DOMAIN_GPU>;
> > > +				};
> >=20
> > My understanding is that the GPU is the only device on this PCI bus, so
> > wouldn't it be simpler to add the power-domains property to the bus' DT
> > node? I guess that's just another interpretation of how this hardware
> > works, and I like how this power control for PCI devices allows
> > individual devices to be turned on before the bus probes (there's a case
> > like this on Jetson Nano where Ethernet needs a GPIO pin to be pulled up
> > in order to start enumerating on the PCI bus, though I don't remember
> > how we ended up solving that, sources don't have any indication of that
> > GPIO being permanently set high or something).
> >=20
> > Thierry
>=20
> The bus itself appears (at least to the point of showing up on lspci and=
=20
> kernel logs without any errors) to work fine without the power domain,=20
> so I thought this the correct way to model the hardware. It seems pretty=
=20
> straightforward like this anyway.

Agreed, this looks like a nice extension of the PCI enablement code.
I'll wait for the DT maintainers to review the bindings change before
picking this up.

Thierry

--7sgzgn3uezi5ctku
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmr9nuIACgkQ3SOs138+
s6HMKw//TryH+vGQCqsyMd1otLJAqgPN3QEdMz5IYX5upgxqHUrgFkrSioY1a9TZ
A/SVztu+i4/MjNEzBOV2ABFieND7XO/fRza8iJVnagHN8DuqqAT9yD6CsX3IEOgd
wiyAuoaGx29PKQ8S0/lNTZ/IqfGTvHI36p1Nn4LnngkAbqeTOVqdphn5+G3foRQh
I5gmXIhERDVdRmzJtKNDSCQF+X2gWAeV+IFcb14pfvzUeQZPzWLFXKT1uKl0LAS2
YWzpTFQvYRaTpfcmWfQ2oxBSwT/dYMAE0LjHhIYhtgGGSd70xgNUhx7zKqcriMVA
509/G2xDmIr8TVALYXMeb5dhFdxtyZgACsx7BrGT3i//SBYigsMiU3yms2yjUAPt
LUj6UT09Vj7+meoLsGvE9n7G0vwnXqN27SzguJETGvROa9DrSiSZRrHix0dhsuhd
Ge+pckWXFADOmITx8TGCBowE0Dq0Tjx5xjy+hjvHSLIWR4fQzrXyPbfAtuKzMnwL
QlZ1C28sM8gOREPGs6N6hCWT/nZMTO43CHYtsIZYwTkHVXEAw1vuPhypdQYP9CKe
+JpVvzMdTNnQ/gdRFjEi2dAU1Zj1UzPLdKAiw0GL5cwB7L/3x1ffOUPh7csQxQED
U5WztGUKHj3onXHqt0b/w/RujGeV5fbxHsyLvsxqJd4AlY7hUU4=
=2LMb
-----END PGP SIGNATURE-----

--7sgzgn3uezi5ctku--
