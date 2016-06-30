Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:36358 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975AbcF3NWX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jun 2016 09:22:23 -0400
Date: Thu, 30 Jun 2016 15:20:01 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>,
	linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
	Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH] pci: tegra: correctly program PADS_REFCLK registers
Message-ID: <20160630132001.GA26758@ulmo.ba.sec>
References: <20160621184640.19885-1-swarren@wwwdotorg.org>
 <20160622125749.GJ26943@ulmo.ba.sec>
 <576AAFFD.4050404@wwwdotorg.org>
 <20160623084448.GA8608@ulmo.ba.sec>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
In-Reply-To: <20160623084448.GA8608@ulmo.ba.sec>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 23, 2016 at 10:44:48AM +0200, Thierry Reding wrote:
> On Wed, Jun 22, 2016 at 09:34:21AM -0600, Stephen Warren wrote:
> > On 06/22/2016 06:57 AM, Thierry Reding wrote:
> > > On Tue, Jun 21, 2016 at 12:46:40PM -0600, Stephen Warren wrote:
> > > > From: Stephen Warren <swarren@nvidia.com>
> > > >=20
> > > > The value that should be programmed into the PADS_REFCLK register v=
aries
> > > > per SoC. Fix the Tegra PCIe driver to program the correct values. F=
uture
> > > > SoCs will require different values in cfg0/1, so the two values are=
 stored
> > > > separately in the per-SoC data structures.
> > > >=20
> > > > For reference, the values are all documented in NV bug 1771116 comm=
ent 20.
> > > > Rhe ASIC team has validated all these values, except for the Tegra2=
0 value
> > > > which is simply left unchanged in this patch.
> >=20
> > > > diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-te=
gra.c
> >=20
> > > > @@ -2078,6 +2070,7 @@ static const struct tegra_pcie_soc_data tegra=
20_pcie_data =3D {
> > > >   	.msi_base_shift =3D 0,
> > > >   	.pads_pll_ctl =3D PADS_PLL_CTL_TEGRA20,
> > > >   	.tx_ref_sel =3D PADS_PLL_CTL_TXCLKREF_DIV10,
> > > > +	.pads_refclk_cfg0 =3D 0xfa5cfa5c,
> > > >   	.has_pex_clkreq_en =3D false,
> > > >   	.has_pex_bias_ctrl =3D false,
> > > >   	.has_intr_prsnt_sense =3D false,
> > > > @@ -2090,6 +2083,8 @@ static const struct tegra_pcie_soc_data tegra=
30_pcie_data =3D {
> > > >   	.msi_base_shift =3D 8,
> > > >   	.pads_pll_ctl =3D PADS_PLL_CTL_TEGRA30,
> > > >   	.tx_ref_sel =3D PADS_PLL_CTL_TXCLKREF_BUF_EN,
> > > > +	.pads_refclk_cfg0 =3D 0xfa5cfa5c,
> > > > +	.pads_refclk_cfg1 =3D 0xfa5cfa5c,
> > > >   	.has_pex_clkreq_en =3D true,
> > > >   	.has_pex_bias_ctrl =3D true,
> > > >   	.has_intr_prsnt_sense =3D true,
> > > > @@ -2102,6 +2097,7 @@ static const struct tegra_pcie_soc_data tegra=
124_pcie_data =3D {
> > > >   	.msi_base_shift =3D 8,
> > > >   	.pads_pll_ctl =3D PADS_PLL_CTL_TEGRA30,
> > > >   	.tx_ref_sel =3D PADS_PLL_CTL_TXCLKREF_BUF_EN,
> > > > +	.pads_refclk_cfg0 =3D 0x44ac44ac,
> > > >   	.has_pex_clkreq_en =3D true,
> > > >   	.has_pex_bias_ctrl =3D true,
> > > >   	.has_intr_prsnt_sense =3D true,
> > >=20
> > > I think it'd be nice to have these decoded into their individual fiel=
ds,
> > > to reduce the magic. We already define the register fields, so it see=
ms
> > > sensible to use them.
> >=20
> > I did consider that. However, the specification from the ASIC team is a=
lways
> > the raw values. Decoding them into bitfields is only going to make it h=
arder
> > to verify whether the correct values are present (since the reader has =
to
> > manually expand the math), and introduce the possibility of errors duri=
ng
> > the expansion process. I think using raw numbers is better in this case.
>=20
> Alright, fine with me:
>=20
> Acked-by: Thierry Reding <treding@nvidia.com>

Hi Bjorn,

I do have a couple of other patches, mostly minor cleanup and prep-work
for 64-bit ARM support, that I'd like to get into v4.8. Would you mind
if I took Stephen's patches into a branch and send it all out via pull
request after it passed testing?

Thierry

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXdRx+AAoJEN0jrNd/PrOh6RYP/3mBY1diaOWPhUDLn2uIiMRO
wm3UHfn2oNsSBAh/NtmXUhfYSoAWbhhCSbpuGqHgRRIA/x35DL8GcRPLb5aytij0
+eufpDRlxwej3v/pcHWYlyFKltTs7AjeeI3Ca9azBVqxib9LN/BzsoHradZ//IF3
GOzW7zOUljqb3S2qnDeYb9JF5ikRwbZK6qyLXer9o2k7/LJCmjM+E+MaeGOrRNq7
G3FQ7Jkk6De6wamgIPYMawin1s0nW6jHfezO+zITRDOHhbMYJNeC63yYMcrBsGUW
UFntHnWenBUzrgumKzRC4InpOjyrqpJcEuiWwMzWaOtbkJy5a8iWaDJNtNBmX1bw
gvuwBnQlm2jiEKM8luynSm1nwKYsbYi6KO8ttEVlrItUFSF8soHi0ycekOeWTzjU
jKZmE86mh631eRQhTZDnFbQArwbopic2bMDq0M9BAzhFQOBNl4RCt9mKPAyttvPA
FRjJWtkJY+1NI11CQdiuRQ0yNwxQnRoV4K5oYEgaXPl1PhalUfjVlD5OctTxWTd/
xxFLahx1AsqRZS3aWgJ6AC/hnTUFSR6LtCloHm/T9H6H/g/WTFMutlDAhiSAOeXX
B4FNTpBnn6KSC8+cEWdP7G/IaK6cf5U/BzW3bYhEEXHHG6stu+eU2Fmw4e/Sh9/N
h+dH9PlvdtxdoDVXwU4J
=LQx6
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
