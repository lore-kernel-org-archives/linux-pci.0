Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83BC3630B3;
	Mon, 27 Jul 2026 15:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785166746; cv=none; b=MzsaO92dPMXYqIZWFmYNVM3lwvojAIcT+AC41grenC85CnMxqQ74AFAcvEvDJ6B1Pk2BTTxXCJD5u/BNtqXpHMwr6r3qrO+XRE8RYdD5qimCtpWZ2LbqH5LEjfBs/hy0MRhfSjspZTc8mt9mk7w5UjomJzi/zF0zar9OBC4j8aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785166746; c=relaxed/simple;
	bh=wpJgqhcFvrYTsrki8km4NMxs/2UDvsJc1eVE8fgdLbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xu2OfNfZnHwBLDKrQl/3Xp7qXACHCBayaMVx+72wr/UJYmGHdk8ga45lYZOcqiGPQ5ze3yATUcxrYx5+fpziGtSXOPsHMg0qHDnx4/8qjsaqnSFpbDmJxe4c+2UVbOqld3L67IqC3ylTgbYjQuTn4ipLVZk/hviqstYUGA4P+sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VIuydFFk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIuydFFk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D67ED1F000E9;
	Mon, 27 Jul 2026 15:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785166745;
	bh=OiklzXx8p5bBY0lwFSAP/eLHXWDp5ZhVdI0sClUc26c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VIuydFFkDbR7M6wzVg7E2NhUc4eI1TG9hrt9IcyouTAx+xh4che7OJQvgPQP0FBdt
	 rMfdAlEIRhluCTFT4SyRj6/szrxO73m+BayZtLpJkicU6sY4U2gNma1fWvOCFW+7fI
	 BDvoTb1H3ohwFfrMZerEWqOD7s7lO9upZXECHZWgGaqo220Sz89ZAikEMAjB3Siezz
	 8eaMU7HXu6Sjc5MJTflRVMGO4AY7hbbJWEtg8rYIGmB2HzlQvKB0RF+Ugd/6Y+IHDv
	 pkoPl5r0KpdQVr/QSDi4sBV+IWUgCw2a0jNAiq/GjUGCDY5rj23fvRvmha5f+YZRuR
	 Cd+VAJW+x0ScA==
Date: Mon, 27 Jul 2026 17:39:02 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, 
	Michal Simek <michal.simek@amd.com>, Kevin Xie <kevin.xie@starfivetech.com>, 
	Aksh Garg <a-garg7@ti.com>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Thierry Reding <treding@nvidia.com>, 
	Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: Re: [PATCH v8 4/6] PCI: tegra: Add Tegra264 support
Message-ID: <amd7fUUzD9ZLc-85@orome>
References: <20260716-tegra264-pcie-v8-4-23e51589229b@nvidia.com>
 <20260722164442.GA742885@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zk2gh5hl3rqyqvvg"
Content-Disposition: inline
In-Reply-To: <20260722164442.GA742885@bhelgaas>


--zk2gh5hl3rqyqvvg
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v8 4/6] PCI: tegra: Add Tegra264 support
MIME-Version: 1.0

On Wed, Jul 22, 2026 at 11:44:42AM -0500, Bjorn Helgaas wrote:
> On Thu, Jul 16, 2026 at 07:07:15PM +0200, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > Add a driver for the PCIe controller found on NVIDIA Tegra264 SoCs. The
> > driver is very small, with its main purpose being to set up the address
> > translation registers and then creating a standard PCI host using ECAM.
> > ...
>=20
> > + * The various memory regions used by the controller (I/O, memory, ECA=
M) are
> > + * set up during early boot and have hardware-level protections in pla=
ce. If
> > + * the DT ranges don't match what's been setup, the controller won't b=
e able
> > + * to write the address endpoints properly, so make sure to validate t=
hat DT
> > + * and firmware programming agree on these ranges.
> > + */
> > +static bool tegra264_pcie_check_ranges(struct platform_device *pdev)
>=20
> Drive-by comment: I have a bit of an aversion to boolean functions
> named "check" because "check" is not a predicate with a true/false or
> yes/no answer.
>=20
> "true" usually means success, which is the opposite of functions that
> return 0 for success.
>=20
> In this case, it looks like "if (tegra264_pcie_check_ranges())" means
> the DT ranges match the hardware configuration.  If it were named
> "tegra264_pcie_valid_ranges()" or similar, an "if" test like that
> would read better.

Indeed, "valid ranges" is superior in this case.

Thierry

--zk2gh5hl3rqyqvvg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmpne5YACgkQ3SOs138+
s6GQ+A//WeFzw3KoYVOzNsMrSzRoXie99HtTHVBPg/kBvr4ois0lZ3WQEHa+J2Ud
1l5V2hv3q760uHAfQ+kvsOkJByU04WCKNXR3DphG6dEhRap42EfFan16PUWV3GCv
eH3X+5ohtv4G+U8BPfcyvKu6rRLfHAIfCLUv4yOVr7tU6LbLTzrADExj70mQrhM7
AzHjzmAzc323jnPOHhFg+YXFRlK+Y6VPh5zT0+EgA0JwFnOjrEf7d5JEP5HPfPuT
AZMEf7CJnoICRMWS1SjXaNBPllgK61MVhx9EC79/6oMWi1I89+Glutlhz9GTwdVj
Iw61t+2+vQxJQtpRQVSSBwnLnV3lRBvBbKsJZ9DSrbT8xz1BXeG2eTOGdgROD97/
KnkgHIYzpKL68OWWeXeb2FV7uJJocRIHUpaX5MA73gIHBsArGzmkOMhp69XOAGzC
i4a313skcX7hcUjNyKu9H0wSxf05QG9PhnICVIJb8lsD0edb5Ax19h8dwDzxiUXt
h48iBjYNJyzDQXxyOZxhmZ7/0v55t59lMVeokZTI7NNBu9TnL7LPV1JYeGnsRsO2
ZUy+zHcVTSGurw5UGFzAxiYnQ30lIdg7E1EMoIaVyyQnIsbmt2at7SzGoU98dCUe
ln4VM83pPz0SXFzVEcQTVUO3YkBf2DZrjWVZ0lkDYKp429FD6Gs=
=9cZE
-----END PGP SIGNATURE-----

--zk2gh5hl3rqyqvvg--
