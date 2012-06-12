Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:58215 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937Ab2FLE7w (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jun 2012 00:59:52 -0400
Date: Tue, 12 Jun 2012 06:59:37 +0200
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: linux-tegra@vger.kernel.org,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v2 05/10] ARM: tegra: Rewrite PCIe support as a driver
Message-ID: <20120612045937.GA3669@avionic-0098.mockup.avionic-design.de>
References: <1339427118-32263-1-git-send-email-thierry.reding@avionic-design.de>
 <1339427118-32263-6-git-send-email-thierry.reding@avionic-design.de>
 <4FD6617C.4090805@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
In-Reply-To: <4FD6617C.4090805@wwwdotorg.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Stephen Warren wrote:
> On 06/11/2012 09:05 AM, Thierry Reding wrote:
> > This commit adds a platform device driver for the PCIe controller on
> > Tegra SOCs. Current users of the old code (TrimSlice and Harmony) are
> > converted and now initialize and register a corresponding platform
> > device.
>=20
> > -static int tegra_pcie_clocks_get(void)
> > +static int tegra_pcie_clocks_get(struct tegra_pcie_info *pcie)
> >  {
> >  	int err;
> > =20
> > -	tegra_pcie.pex_clk =3D clk_get(NULL, "pex");
> > -	if (IS_ERR(tegra_pcie.pex_clk))
> > -		return PTR_ERR(tegra_pcie.pex_clk);
> > +	pcie->pex_clk =3D clk_get(NULL, "pex");
> > +	if (IS_ERR(pcie->pex_clk))
> > +		return PTR_ERR(pcie->pex_clk);
>=20
> While we're changing this, can we convert this to devm_clk_get(), and ...

Will do.

> > -	tegra_pcie.regs =3D ioremap_nocache(TEGRA_PCIE_BASE, PCIE_IOMAP_SZ);
> > -	if (tegra_pcie.regs =3D=3D NULL) {
> > -		pr_err("PCIE: Failed to map PCI/AFI registers\n");
> > +	regs =3D request_mem_region(regs->start, resource_size(regs), "PCI/AF=
I");
> > +	if (regs =3D=3D NULL) {
> > +		dev_err(&pdev->dev, "failed to request PCI/AFI region: %d\n", err);
> > +		goto err_req_reg;
> > +	}
> > +
> > +	pcie->regs =3D ioremap_nocache(regs->start, resource_size(regs));
> > +	if (pcie->regs =3D=3D NULL) {
> > +		dev_err(&pdev->dev, "failed to map PCI/AFI registers\n");
> >  		err =3D -ENOMEM;
> >  		goto err_map_reg;
> >  	}
>=20
> ... that to devm_request_and_ioremap(). That would allow a bunch of the
> cleanup code to be deleted rather than just modified.

Yes, I'll fix that up as well.

Thierry

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk/WzLkACgkQZ+BJyKLjJp9LsgCgkd2RUHoQ3x28GMcYJKhFCGW9
ULQAn119Zd8JXGN/WKk/ayq06qrwl3w3
=IU8W
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
