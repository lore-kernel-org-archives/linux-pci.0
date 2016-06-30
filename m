Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33488 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752686AbcF3Pxn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jun 2016 11:53:43 -0400
Date: Thu, 30 Jun 2016 17:46:19 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
	Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH] pci: tegra: correctly program PADS_REFCLK registers
Message-ID: <20160630154619.GC4279@ulmo.ba.sec>
References: <20160621184640.19885-1-swarren@wwwdotorg.org>
 <20160622125749.GJ26943@ulmo.ba.sec>
 <576AAFFD.4050404@wwwdotorg.org>
 <20160623084448.GA8608@ulmo.ba.sec>
 <20160630132001.GA26758@ulmo.ba.sec>
 <20160630093523.24cd5767@t450s.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lMM8JwqTlfDpEaS6"
In-Reply-To: <20160630093523.24cd5767@t450s.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--lMM8JwqTlfDpEaS6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 30, 2016 at 09:35:23AM -0600, Alex Williamson wrote:
> On Thu, 30 Jun 2016 15:20:01 +0200
> Thierry Reding <thierry.reding@gmail.com> wrote:
>=20
> > On Thu, Jun 23, 2016 at 10:44:48AM +0200, Thierry Reding wrote:
> > > On Wed, Jun 22, 2016 at 09:34:21AM -0600, Stephen Warren wrote: =20
> > > > On 06/22/2016 06:57 AM, Thierry Reding wrote: =20
> > > > > On Tue, Jun 21, 2016 at 12:46:40PM -0600, Stephen Warren wrote: =
=20
> > > > > > From: Stephen Warren <swarren@nvidia.com>
> > > > > >=20
> > > > > > The value that should be programmed into the PADS_REFCLK regist=
er varies
> > > > > > per SoC. Fix the Tegra PCIe driver to program the correct value=
s. Future
> > > > > > SoCs will require different values in cfg0/1, so the two values=
 are stored
> > > > > > separately in the per-SoC data structures.
> > > > > >=20
> > > > > > For reference, the values are all documented in NV bug 1771116 =
comment 20.
> > > > > > Rhe ASIC team has validated all these values, except for the Te=
gra20 value
> > > > > > which is simply left unchanged in this patch. =20
> > > >  =20
> > > > > > diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pc=
i-tegra.c =20
> > > >  =20
> > > > > > @@ -2078,6 +2070,7 @@ static const struct tegra_pcie_soc_data t=
egra20_pcie_data =3D {
> > > > > >   	.msi_base_shift =3D 0,
> > > > > >   	.pads_pll_ctl =3D PADS_PLL_CTL_TEGRA20,
> > > > > >   	.tx_ref_sel =3D PADS_PLL_CTL_TXCLKREF_DIV10,
> > > > > > +	.pads_refclk_cfg0 =3D 0xfa5cfa5c,
> > > > > >   	.has_pex_clkreq_en =3D false,
> > > > > >   	.has_pex_bias_ctrl =3D false,
> > > > > >   	.has_intr_prsnt_sense =3D false,
> > > > > > @@ -2090,6 +2083,8 @@ static const struct tegra_pcie_soc_data t=
egra30_pcie_data =3D {
> > > > > >   	.msi_base_shift =3D 8,
> > > > > >   	.pads_pll_ctl =3D PADS_PLL_CTL_TEGRA30,
> > > > > >   	.tx_ref_sel =3D PADS_PLL_CTL_TXCLKREF_BUF_EN,
> > > > > > +	.pads_refclk_cfg0 =3D 0xfa5cfa5c,
> > > > > > +	.pads_refclk_cfg1 =3D 0xfa5cfa5c,
> > > > > >   	.has_pex_clkreq_en =3D true,
> > > > > >   	.has_pex_bias_ctrl =3D true,
> > > > > >   	.has_intr_prsnt_sense =3D true,
> > > > > > @@ -2102,6 +2097,7 @@ static const struct tegra_pcie_soc_data t=
egra124_pcie_data =3D {
> > > > > >   	.msi_base_shift =3D 8,
> > > > > >   	.pads_pll_ctl =3D PADS_PLL_CTL_TEGRA30,
> > > > > >   	.tx_ref_sel =3D PADS_PLL_CTL_TXCLKREF_BUF_EN,
> > > > > > +	.pads_refclk_cfg0 =3D 0x44ac44ac,
> > > > > >   	.has_pex_clkreq_en =3D true,
> > > > > >   	.has_pex_bias_ctrl =3D true,
> > > > > >   	.has_intr_prsnt_sense =3D true, =20
> > > > >=20
> > > > > I think it'd be nice to have these decoded into their individual =
fields,
> > > > > to reduce the magic. We already define the register fields, so it=
 seems
> > > > > sensible to use them. =20
> > > >=20
> > > > I did consider that. However, the specification from the ASIC team =
is always
> > > > the raw values. Decoding them into bitfields is only going to make =
it harder
> > > > to verify whether the correct values are present (since the reader =
has to
> > > > manually expand the math), and introduce the possibility of errors =
during
> > > > the expansion process. I think using raw numbers is better in this =
case. =20
> > >=20
> > > Alright, fine with me:
> > >=20
> > > Acked-by: Thierry Reding <treding@nvidia.com> =20
> >=20
> > Hi Bjorn,
> >=20
> > I do have a couple of other patches, mostly minor cleanup and prep-work
> > for 64-bit ARM support, that I'd like to get into v4.8. Would you mind
> > if I took Stephen's patches into a branch and send it all out via pull
> > request after it passed testing?
>=20
> Hi Theirry,
>=20
> Bjorn is on holiday and will be back at the beginning of the v4.8 merge
> window, assuming everything sticks to a regular schedule.  I expect
> that anything that consolidates and prioritizes potential v4.8 content
> for easy evaluation on his return would be appreciated.  Thanks,

Okay, thanks for letting me know.

Thierry

--lMM8JwqTlfDpEaS6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXdT7KAAoJEN0jrNd/PrOhgDUP/1fchQnuXw3FHcOlRKrPBcko
2Y5peKVaqhRZ5DHrSF1P0Widwr8fmQOVZp870unqLSJ715jN4qKOJzbQmUdWkBhi
CluzOTvNmOdIhiKv7YWzU+QuufiuB1DEFfTYFO4GuBYrI67mORNhhR1Sfxl6Bwue
Ckr5ycQhT4O+hhfpcIhnypwWOL0jUrwajvgk8L+b/iYJhkrfolIyEb7D8vuxNtm7
L+hFYKOR1UBQdbdIZuFjtHd8OvptZ/jyiOeynnsVA0UzoWxSCUI2cmX9nea5bVXw
+o7R9t1dEAYc63ld/7QjvWduG4jc/kfwitzJSmu7LoHJf26zaFC3V32ND18XkQ3W
phC4XIZrd91N/eVvaLQDsoO5VZ8DkcKY7kDrEKayfKpihCyumDsXIQsr2eLXggIz
L6BAHvbY73GxZzK/JHG9HJrR6zI4V00TMiutDzApk7k1RR1nanrw3OEwY/BiDRni
ABRMt60GpsBTJ505uIbPyQhCb9FqgJgHW3U2yxOQw/YRYU0ZLeMHQlg6ESYceAIx
FEw9O3KVyAGrtbAYF0FCR3PZxFKbDSO+qR3vSM9XklIdVXl7ECnpPRIIY2VED/67
zIvLLN6BTvKcvoAOGmCldE4PVNO3f7k/rfjl7Jv3Lu97jnPmzGwmhRwTV1QygLF2
y9Jsmc37EipDtQmNnRZr
=xNjI
-----END PGP SIGNATURE-----

--lMM8JwqTlfDpEaS6--
