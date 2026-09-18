Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965093A9013;
	Fri, 18 Sep 2026 12:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789736237; cv=none; b=LbyfkaTtCnk6E4o16DczgyhQZrJuc7CwYScy1F+y6WbYXjlb718uvup08bmENULEKN0smoKVNn01cFdkH0BM4Au5Ab2ij8S0Hu3G13hHSY+dxidYlIVlxnLKgbqrOB6+esR/ltMA6f01B6Uaw+i//j5XfOG2QE/PSGrRvmTvPeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789736237; c=relaxed/simple;
	bh=tpwzFkjnZBOXxEGmcfJodTksQQDSD8ju7e36ieY34x0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YSKhJJ5MaqXGPVuvz+d7e6u7fWZJBjdgjaEkSRHvETg7okfG3XAqOsE5ONqcQQ0yEXrkxMq7SF9cnuY1wvxng1IUgEI86wMRGjM6aCUJ619riFFtrFhL6Qv/wCPT7GBxwBRAoor56B+y6U/caXxSHv/yeTVPq++zYjXwQ0WS0mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UeJf9n++; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UeJf9n++"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F431F000FF;
	Fri, 18 Sep 2026 12:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789736236;
	bh=O6mVnh2QxpWQMZdcxjlqqxRDl64o8g6/0MdKyQqxUgE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UeJf9n++/bdLr5/NLxctB+2lDVLjXSVWPjihsu0RXsLhJn3lY79HUYY1nQ28lIUHf
	 op141Hs7D6jUQOGPnm/eyAa9lrRu8MoBmoYE2oKS6yHsMp5v5c1sZGSjrFxsY5TJLu
	 PHB0iIiO5ndnypCAahILD6uFPtPSDplaq36ldOMwQpPqs5qeCa75db9QPUJIxRIXUv
	 vWDgY6+ZVljarkPqnITRGUM7Vgni2LZ/d25zz/0P1+DoZ02dswZfL85C95VvD0KBy0
	 j/8wU6bJCpHd4q5kLiSIn4AXyFgCpxv6N7JkCDxsnABxGe2SMjGs6GB6r/mWltNXj6
	 SmIsa04L8NC+Q==
Date: Fri, 18 Sep 2026 14:57:13 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Anand Moon <linux.amoon@gmail.com>, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] dt-bindings: pci: tegra: Convert to json-schema
Message-ID: <aq00_JJv77a7l2ph@orome>
References: <20260902142449.735168-1-thierry.reding@kernel.org>
 <178969471460.164579.7468750310934261303.b4-ty@b4>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4xxiwst64mchr4kd"
Content-Disposition: inline
In-Reply-To: <178969471460.164579.7468750310934261303.b4-ty@b4>


--4xxiwst64mchr4kd
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6] dt-bindings: pci: tegra: Convert to json-schema
MIME-Version: 1.0

On Fri, Sep 18, 2026 at 03:25:14AM +0200, Manivannan Sadhasivam wrote:
>=20
> On Wed, 02 Sep 2026 16:24:49 +0200, Thierry Reding wrote:
> > Convert the Tegra PCIe controller bindings from the free-form text
> > format to json-schema.
>=20
> Applied, thanks!
>=20
> [1/1] dt-bindings: pci: tegra: Convert to json-schema
>       commit: 94976a87cfc164fdddda54f4baa61ea7f0bde323

w00t! \o/

Thierry

--4xxiwst64mchr4kd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmqtNSkACgkQ3SOs138+
s6EJGg//bQ0cEgTIuVP9BnIde2ClYmeOhYi/yLw+uu4LOtIHtJmFc4zeWirobwlE
Ai/CEp5N71Ur2pdmCnRo4qrH+sDtptFQM5yCSaG0yqlXv22Gdzr6AtJr9b4UjSrh
S4iJBWmkMeKYU0aSuqh6+VPXGghiMzF5yDmEvne6NhFQ1lyyRpfQkV7EnAeJznSz
7d8elNo3Cp9zQOwmzvzthdHSe9KOPVzIRQxLtAR1kLPEavY6acCUMKoGgr79X5kj
BW5FCrZF+IRn8+kdYRMXf65rxJzbLFZDwuiu6y9FfmqklfAGnJQP/fr6EMeDOeDD
Qwk+eiyncNT2rfTuk/Q9TUuXqR4QBIFf16XcR0o75rCU6MicgvQXkCqRiaMa9zPN
WRK1EmMLvUgUV9mr9ZCthYcXbTs9QrGjHX6pkBFzM2/SVKCxav/qYiLB8Hbeihfg
m6aFWQ3lP3OyQCRoytk3UIGmrZ6HNfVjOUhBh6f62Xn92hg1RufHDhKBtkpxiexw
6NkKHymX7oJg2Tn9Fh6iQJZPoo2Dg+lwTzEIGoGEyWpff+RuaACMF2AWCVom8ZT8
3aBZQ/QE3lYnOAG0pncuEtV9dJ6C5EYARs1bQL8yB48K7wdmxlZLnimy4JwtMdFi
7pzzHEEFECE+b5JECg+fmr0bKr14De6JOSRQW//JPVTWtVj23ts=
=w91P
-----END PGP SIGNATURE-----

--4xxiwst64mchr4kd--
