Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37022 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751543AbcFWIow (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jun 2016 04:44:52 -0400
Date: Thu, 23 Jun 2016 10:44:48 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-tegra@vger.kernel.org,
	linux-pci@vger.kernel.org, Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH] pci: tegra: correctly program PADS_REFCLK registers
Message-ID: <20160623084448.GA8608@ulmo.ba.sec>
References: <20160621184640.19885-1-swarren@wwwdotorg.org>
 <20160622125749.GJ26943@ulmo.ba.sec>
 <576AAFFD.4050404@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
In-Reply-To: <576AAFFD.4050404@wwwdotorg.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 22, 2016 at 09:34:21AM -0600, Stephen Warren wrote:
> On 06/22/2016 06:57 AM, Thierry Reding wrote:
> > On Tue, Jun 21, 2016 at 12:46:40PM -0600, Stephen Warren wrote:
> > > From: Stephen Warren <swarren@nvidia.com>
> > >=20
> > > The value that should be programmed into the PADS_REFCLK register var=
ies
> > > per SoC. Fix the Tegra PCIe driver to program the correct values. Fut=
ure
> > > SoCs will require different values in cfg0/1, so the two values are s=
tored
> > > separately in the per-SoC data structures.
> > >=20
> > > For reference, the values are all documented in NV bug 1771116 commen=
t 20.
> > > Rhe ASIC team has validated all these values, except for the Tegra20 =
value
> > > which is simply left unchanged in this patch.
>=20
> > > diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegr=
a.c
>=20
> > > @@ -2078,6 +2070,7 @@ static const struct tegra_pcie_soc_data tegra20=
_pcie_data =3D {
> > >   	.msi_base_shift =3D 0,
> > >   	.pads_pll_ctl =3D PADS_PLL_CTL_TEGRA20,
> > >   	.tx_ref_sel =3D PADS_PLL_CTL_TXCLKREF_DIV10,
> > > +	.pads_refclk_cfg0 =3D 0xfa5cfa5c,
> > >   	.has_pex_clkreq_en =3D false,
> > >   	.has_pex_bias_ctrl =3D false,
> > >   	.has_intr_prsnt_sense =3D false,
> > > @@ -2090,6 +2083,8 @@ static const struct tegra_pcie_soc_data tegra30=
_pcie_data =3D {
> > >   	.msi_base_shift =3D 8,
> > >   	.pads_pll_ctl =3D PADS_PLL_CTL_TEGRA30,
> > >   	.tx_ref_sel =3D PADS_PLL_CTL_TXCLKREF_BUF_EN,
> > > +	.pads_refclk_cfg0 =3D 0xfa5cfa5c,
> > > +	.pads_refclk_cfg1 =3D 0xfa5cfa5c,
> > >   	.has_pex_clkreq_en =3D true,
> > >   	.has_pex_bias_ctrl =3D true,
> > >   	.has_intr_prsnt_sense =3D true,
> > > @@ -2102,6 +2097,7 @@ static const struct tegra_pcie_soc_data tegra12=
4_pcie_data =3D {
> > >   	.msi_base_shift =3D 8,
> > >   	.pads_pll_ctl =3D PADS_PLL_CTL_TEGRA30,
> > >   	.tx_ref_sel =3D PADS_PLL_CTL_TXCLKREF_BUF_EN,
> > > +	.pads_refclk_cfg0 =3D 0x44ac44ac,
> > >   	.has_pex_clkreq_en =3D true,
> > >   	.has_pex_bias_ctrl =3D true,
> > >   	.has_intr_prsnt_sense =3D true,
> >=20
> > I think it'd be nice to have these decoded into their individual fields,
> > to reduce the magic. We already define the register fields, so it seems
> > sensible to use them.
>=20
> I did consider that. However, the specification from the ASIC team is alw=
ays
> the raw values. Decoding them into bitfields is only going to make it har=
der
> to verify whether the correct values are present (since the reader has to
> manually expand the math), and introduce the possibility of errors during
> the expansion process. I think using raw numbers is better in this case.

Alright, fine with me:

Acked-by: Thierry Reding <treding@nvidia.com>

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXa6GAAAoJEN0jrNd/PrOhq+AQALiKwNrnKCq+BGRpsG+2P4QQ
31qWZDyzGdnW8383JdqtZpbvy+x9DIRd0nXFB82BKOzkcrZ28CUkZeG5lxPABQGh
bhaC6QJMJT56nhCXbEbdB4SqAT0OO+FODJfHay3hMRHPsOeI2OyGPWayQqCYdQlw
2j6kmcSFVukhQG1WKcV4cOrKEU8/bo5S7Hd1rLvYCPXNyQ6+ULyJj+9uDa9nyTwj
hFmyJOW7jd9wsmRjGBrumI/VMDdvjGw1vL0if6hvctX4PY5eKVQc9DnkkRDa0oNY
Y8CYMHe2P9jmeflR3YshnJRCmJXSjHdTFafab9biDsqSMX14yY1Vb1khNFt0C+6e
qf9VCrr7tJ1ZfHu6VwGMgewm55c8gkjAARFz/QrDU3aBgAlopt3ATGzT4fpyXH0o
I5JbboBoNJY0PLfX5ekyFsKfLs+YxyyVtwOgZq6OS1JoZ433tQq90xG0eeOoyNS+
jd2uJsGZr5lNtRLb+5qrCYzJ5Z2lNFBRnLvPSixFBwL+sBY9c7mfHl0drJgy3Can
YnbIBA/QpD36/ujP0LZm6n33sRwpCjuFIRJiLOKAgzUj5SoN647PTaNI6qNGbj6S
DORyW7ToHlnLCnQrUUIi+XStWfLULh7HxokgZauqc1IZPb80VupaswddiiIQ9wXV
UJiAxKzDpvZt6b+WtcdL
=RxoY
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
