Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADB1429CEE;
	Mon, 17 Aug 2026 13:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786973278; cv=none; b=M3FodeJIlouMAxhtgOjrG01ETM+Y5GYluMCjhXBS6Kqg0qF+97PZp76Tmi5bX1RDOxi6L90dr+CzCv3hB4Rd9Rf9bwx+ehvzGrxSqfarXaRN1fB3eIsG9tyVi902vVpLJ1YXpQzofiMBixb3b2nNQ8mYahty1lVXaCZKX6k08Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786973278; c=relaxed/simple;
	bh=KUdwiuHEFhVhO1itwdFrGoQBICFLjmpZRLXi65Mix+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZmbkBHSkf5/AT/0roJ4ZeuK3qoHZYKaQttMKGweLqc6RG7W5ZOBvZypKQHDxaRpgTgAGtrL71ZldnEdZ77iMQTnsYuPAB1n9KXVgA2NrPuQDI+jTruqkArGMWRsr0CnavGa4IbYfK24129FDj40S3rcYy/WZ2fLoKE8OqaQpddE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bc5HyQYM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bc5HyQYM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA8351F000E9;
	Mon, 17 Aug 2026 13:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786973277;
	bh=KUdwiuHEFhVhO1itwdFrGoQBICFLjmpZRLXi65Mix+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bc5HyQYM1Yl/eP6xwJH4ZarKDSSbpcsoeD1ioi6wDfndS/hS1Y9Zk+yG5UxwQ7np1
	 Zurmh0Uv5ewUTABnmQfBUt/J12Nvb3TiNWBEMpnht3T2IMsivhk6iFBl0LdQpD7AK4
	 PvCSblTa9E8CKeZbODLUvw6SsbsSUklbZUe2wPKbJnxEi9q2q3dIi/v7hwG4RdsGEF
	 WJigU2caH1PkHisw6MfOGlinm5qZK9uEn5TTthzJcLwMjyQl/QMzfWsAPNu0SK34wr
	 kc2MK9xKx6rui4tK0p8jfX8Z+07eRXq2ySrauSloWjItE5oe4PjhcG0sBJs9y5WsPl
	 Ogqtz5AlvOzBQ==
Date: Mon, 17 Aug 2026 15:27:54 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>, 
	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, Michal Simek <michal.simek@amd.com>, 
	Kevin Xie <kevin.xie@starfivetech.com>, Aksh Garg <a-garg7@ti.com>, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH v10 2/5] dt-bindings: pci: tegra264: Switch to PCIe root
 port bindings
Message-ID: <aoMMInqEdS4MGUfU@orome>
References: <20260814-tegra264-pcie-v10-0-05d08c592b05@nvidia.com>
 <20260814-tegra264-pcie-v10-2-05d08c592b05@nvidia.com>
 <f2wdbxqudd7kice4fcee4skgwektcftgqvccihi6l47ztwlssg@ufehmcwfwjh7>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kwhhjrimcwx56o2n"
Content-Disposition: inline
In-Reply-To: <f2wdbxqudd7kice4fcee4skgwektcftgqvccihi6l47ztwlssg@ufehmcwfwjh7>


--kwhhjrimcwx56o2n
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v10 2/5] dt-bindings: pci: tegra264: Switch to PCIe root
 port bindings
MIME-Version: 1.0

On Sat, Aug 15, 2026 at 08:28:31AM +0200, Manivannan Sadhasivam wrote:
> On Fri, Aug 14, 2026 at 05:38:56PM +0200, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > Switch to using the PCIe root port bindings in preparation for using the
> > standard WAKE# handling.
> >=20
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
>=20
> For some reason, you just keep missing Rob's R-b tag for this patch:
> https://lore.kernel.org/all/178594272722.905042.3804777775947567354.robh@=
kernel.org
>=20
> I'll add it while applying, but please ensure that tags are not missed in=
 the
> future.

Understood, I'll pay more attention to this.

Thierry

--kwhhjrimcwx56o2n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmqDDFoACgkQ3SOs138+
s6HZvxAAuhRhI5oheC9XaqEXYpnP1hc7i+bmTmMgHx3tBcBUww6zCs+JMeL2cY7F
kJ7m82I/7kFU30Ttyk+HouyfcPyZ1uj6aiP7PHwSty+N+KJRhgMy4/+kUKc3MxZk
CWO10DCTO6kFdWGmrBI82o6TJ/VPVGkAN46PvKsi5FZE+TDTa5IGfRtRZmMVKTXO
8qCjR1KK92sc1Tibu95ByDCA3uzLoGtkoj32AqOMfVNRcCTpf/GDWy0/ZCTfPryg
jzGFCiRIRV3//FAsbQFh2xRrLydUUT1gpDGXOSsKmu/+fyvXTSoP/Q7hJ3nMYEje
v4GFbgclY3+BR33QPzAIon5Fp/gepYO4w5bha4F+acvKO+ImwMfVLH21lOs1d9Iv
YSo8c4kNUsnVhgL4XdgIpRhAZGMgPxog7GmGatqf71QLqq6n6DPlNLK7OEt+1uI5
LbSflXOFlRS4xGTi1SpUnqhS3DwIAhTpubTEqslZkejtktLKRr66z3A9D7TdhOoh
ZDcePOLZUqEoOHg//GJGfvzVJtYcgTq+v4aruVtFDHD61UMTNNqc5Iy9XsfWtyVQ
2AAfHOIO/g+zKC16JtXgye1GyOP8BWqe3VA3f48GnDYGYP0rEloqTjIoBDgY3T+U
14EN7Fw3wPZN4JDKysXD9rq8owQJrj3S3ZfIIAeUbAV28uIRQr8=
=Cjmd
-----END PGP SIGNATURE-----

--kwhhjrimcwx56o2n--
