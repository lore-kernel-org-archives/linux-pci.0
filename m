Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106943CB2E6;
	Thu, 26 Mar 2026 10:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774519229; cv=none; b=eVNuNSvKKsYKU8bXlth80yC8o985xKWD2XCOjyoEUJvcTFKT+A/BOYqpE2iVA6G/CiUFFv8GPIxvaEzQ1fQx2dfAfuhsAhivriWkxzNKg6ZRKTkrpmv1pn1FYwboKOmNipv2t89dYOemT+YC/xgfHSdj0M/Ff3BAHua/uix+PLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774519229; c=relaxed/simple;
	bh=YpjKz+MXrEJKD/amzHLZygjzl2q1zYJTn/2+9zrnFbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lphtx27Pxfg1PvOn1e9HAkqjruzv7nI4O1cX9Xkwwa/u8cz4UhvlLcY6u/bx0XaWtJvKKswvV0MFJtXtRGA+8PPmrq3dGrhuGs3l+pw5AgTF7dBDCsy6eMUHt5HiOMJxWQmmMY8zrKD/P4Wv7Zj4kNYrmrqRMDQAnz0/z/NMB00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HbnZB+J2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HbnZB+J2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1692C19423;
	Thu, 26 Mar 2026 10:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774519228;
	bh=YpjKz+MXrEJKD/amzHLZygjzl2q1zYJTn/2+9zrnFbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HbnZB+J2EUiWTIcTl5ux6o4nmsX0zdPCeKA9X2E2pqwVjLqHXljiFGkZePyN9Uo5k
	 UQq2HnTy4Jh6bUXew9Nk6dQR9OcIPSjXV3O6fT5jnjvr4okYPP59GBAoIc0X+HX6C3
	 rZ2BSOZhNu0rhiapGbswtE+4dWW3abszZ2TernYS1U7Y9mktHT9zFxsq7DnzcKKfvQ
	 exvsjEcmDHQwwcxLWLVoeYE8/tR2Bszae26Tuve04yoL5qmJaiHH7jWMAgdVDqlCow
	 fAUsK3OrU+CclrDswok0HGiZaDO6fTtArHEIvjD062Lk03TVEQorQXzibIR4NKtEsb
	 MRpiZiCbzgwqQ==
Date: Thu, 26 Mar 2026 11:00:24 +0100
From: Thierry Reding <thierry.reding@kernel.org>
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jon Hunter <jonathanh@nvidia.com>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 2/5] firmware: tegra: bpmp: Add
 tegra_bpmp_get_with_id() function
Message-ID: <acUDq3bt7P2vL5tg@orome>
References: <20260320225443.2571920-1-thierry.reding@kernel.org>
 <20260320225443.2571920-3-thierry.reding@kernel.org>
 <24777801.6Emhk5qWAg@senjougahara>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pu5ew2iy2ugqzuez"
Content-Disposition: inline
In-Reply-To: <24777801.6Emhk5qWAg@senjougahara>


--pu5ew2iy2ugqzuez
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/5] firmware: tegra: bpmp: Add
 tegra_bpmp_get_with_id() function
MIME-Version: 1.0

On Wed, Mar 25, 2026 at 11:28:41AM +0900, Mikko Perttunen wrote:
> On Saturday, March 21, 2026 7:54=E2=80=AFAM Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > Some device tree bindings need to specify a parameter along with a BPMP
> > phandle reference to designate the ID associated with a given controller
> > that needs to interoperate with BPMP. Typically this is specified as an
> > extra cell in the nvidia,bpmp property, so add a helper to parse this ID
> > while resolving the phandle reference.
> >=20
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >  drivers/firmware/tegra/bpmp.c | 34 ++++++++++++++++++++++++++++++++++
> >  include/soc/tegra/bpmp.h      |  1 +
> >  2 files changed, 35 insertions(+)
> >=20
> > diff --git a/drivers/firmware/tegra/bpmp.c b/drivers/firmware/tegra/bpm=
p.c
> > index e74bba7ccc44..753472b53bd8 100644
> > --- a/drivers/firmware/tegra/bpmp.c
> > +++ b/drivers/firmware/tegra/bpmp.c
> > @@ -32,6 +32,40 @@ channel_to_ops(struct tegra_bpmp_channel *channel)
> >  	return bpmp->soc->ops;
> >  }
> > =20
> > +struct tegra_bpmp *tegra_bpmp_get_with_id(struct device *dev, unsigned=
 int=20
> *id)
> > +{
> > +	struct platform_device *pdev;
> > +	struct of_phandle_args args;
> > +	struct tegra_bpmp *bpmp;
> > +	int err;
> > +
> > +	err =3D __of_parse_phandle_with_args(dev->of_node, "nvidia,bpmp", NUL=
L,
> > +					   1, 0, &args);
> > +	if (err < 0)
> > +		return ERR_PTR(err);
> > +
> > +	pdev =3D of_find_device_by_node(args.np);
> > +	if (!pdev) {
> > +		bpmp =3D ERR_PTR(-ENODEV);
> > +		goto put;
> > +	}
> > +
> > +	bpmp =3D platform_get_drvdata(pdev);
> > +	if (!bpmp) {
> > +		bpmp =3D ERR_PTR(-EPROBE_DEFER);
> > +		put_device(&pdev->dev);
> > +		goto put;
> > +	}
> > +
> > +	if (id)
> > +		*id =3D args.args[0];
> > +
> > +put:
> > +	of_node_put(args.np);
> > +	return bpmp;
> > +}
> > +EXPORT_SYMBOL_GPL(tegra_bpmp_get_with_id);
> > +
> >  struct tegra_bpmp *tegra_bpmp_get(struct device *dev)
> >  {
> >  	struct platform_device *pdev;
> > diff --git a/include/soc/tegra/bpmp.h b/include/soc/tegra/bpmp.h
> > index f5e4ac5b8cce..424188c100d9 100644
> > --- a/include/soc/tegra/bpmp.h
> > +++ b/include/soc/tegra/bpmp.h
> > @@ -127,6 +127,7 @@ struct tegra_bpmp_message {
> > =20
> >  #if IS_ENABLED(CONFIG_TEGRA_BPMP)
> >  struct tegra_bpmp *tegra_bpmp_get(struct device *dev);
> > +struct tegra_bpmp *tegra_bpmp_get_with_id(struct device *dev, unsigned=
 int=20
> *id);
>=20
> Should add a stub function in the #else branch, as well.

Good point. Done.

Thierry

--pu5ew2iy2ugqzuez
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmnFA7UACgkQ3SOs138+
s6Em5w/+KkKgYHMUISCj532bdIof02gpfGfp/DB5EFjFjW6ST6rASh5Q2g272YNw
n9nD8AxA3Z89OZgoAl5pqZ6AFFghe2eK2I7yGV3rxcIoxGvBF37Yl9caQp+YO+H5
2FBj6MSmBN8Rf/4IMZavXfxjCfvrfHU01qYUL73bPtQAzKaWGW4Opc284LIi/STw
vRoqqpAtxRdqtMvA81z24BQ0n5UyDiUJmvy/QMoNea8wRwVkVp2mmltx1foJ1PZA
ze7OxaOe2dVj4dsfJYd7D0rDf9k1Wp9XG065Zvn1orsAfj8s3bqPT4nFz8mggxID
jSCNFdp8PtWwwNOWr90Z0rBrBX/uI2E77q3phWHWqQ41JFK0EHAunBQ/pAJ82d5T
STSApB7hquaMv3QEf2gryrCHu2r+nbBD7QrP4hQpH/MvxLu8mJ86zimmsQEvdc4h
lczoADmSIen5E4MuF+bTvguVvCbAsHyuUIZ45LhIZTWH8FjQkY0OaT0gy4x/2mBc
QVRjucIInQDtKfQtcv925RYzwkmCTnI6O135v8kyGEIxmBXA9uOUcmV6cn6luhbJ
cnkrcT8o2XO4QIT5Qh7Y+guVlsvz+T4aN0pWUmMecxJJCtJ9X7b298tUJtyTzEVU
1A2Gsa10bUeMTQL0WUHhNkBRrftScKT/xjjpOq0ClmVRc44wSPE=
=qh4a
-----END PGP SIGNATURE-----

--pu5ew2iy2ugqzuez--
