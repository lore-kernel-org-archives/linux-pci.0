Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33480 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751652AbcFVM6b (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 22 Jun 2016 08:58:31 -0400
Date: Wed, 22 Jun 2016 14:57:49 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-tegra@vger.kernel.org,
	linux-pci@vger.kernel.org, Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH] pci: tegra: correctly program PADS_REFCLK registers
Message-ID: <20160622125749.GJ26943@ulmo.ba.sec>
References: <20160621184640.19885-1-swarren@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VSaCG/zfRnOiPJtU"
In-Reply-To: <20160621184640.19885-1-swarren@wwwdotorg.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--VSaCG/zfRnOiPJtU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 21, 2016 at 12:46:40PM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
>=20
> The value that should be programmed into the PADS_REFCLK register varies
> per SoC. Fix the Tegra PCIe driver to program the correct values. Future
> SoCs will require different values in cfg0/1, so the two values are stored
> separately in the per-SoC data structures.
>=20
> For reference, the values are all documented in NV bug 1771116 comment 20.
> Rhe ASIC team has validated all these values, except for the Tegra20 value
> which is simply left unchanged in this patch.
>=20
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
>  drivers/pci/host/pci-tegra.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> index c388468c202a..74887fedc3d4 100644
> --- a/drivers/pci/host/pci-tegra.c
> +++ b/drivers/pci/host/pci-tegra.c
> @@ -228,15 +228,6 @@
>  #define PADS_REFCLK_CFG_PREDI_SHIFT		8  /* 11:8 */
>  #define PADS_REFCLK_CFG_DRVI_SHIFT		12 /* 15:12 */
> =20
> -/* Default value provided by HW engineering is 0xfa5c */
> -#define PADS_REFCLK_CFG_VALUE \
> -	( \
> -		(0x17 << PADS_REFCLK_CFG_TERM_SHIFT)   | \
> -		(0    << PADS_REFCLK_CFG_E_TERM_SHIFT) | \
> -		(0xa  << PADS_REFCLK_CFG_PREDI_SHIFT)  | \
> -		(0xf  << PADS_REFCLK_CFG_DRVI_SHIFT)     \
> -	)
> -
>  struct tegra_msi {
>  	struct msi_controller chip;
>  	DECLARE_BITMAP(used, INT_PCI_MSI_NR);
> @@ -252,6 +243,8 @@ struct tegra_pcie_soc_data {
>  	unsigned int msi_base_shift;
>  	u32 pads_pll_ctl;
>  	u32 tx_ref_sel;
> +	u32 pads_refclk_cfg0;
> +	u32 pads_refclk_cfg1;
>  	bool has_pex_clkreq_en;
>  	bool has_pex_bias_ctrl;
>  	bool has_intr_prsnt_sense;
> @@ -839,10 +832,9 @@ static int tegra_pcie_phy_enable(struct tegra_pcie *=
pcie)
>  	pads_writel(pcie, value, soc->pads_pll_ctl);
> =20
>  	/* Configure the reference clock driver */
> -	value =3D PADS_REFCLK_CFG_VALUE | (PADS_REFCLK_CFG_VALUE << 16);
> -	pads_writel(pcie, value, PADS_REFCLK_CFG0);
> +	pads_writel(pcie, soc->pads_refclk_cfg0, PADS_REFCLK_CFG0);
>  	if (soc->num_ports > 2)
> -		pads_writel(pcie, PADS_REFCLK_CFG_VALUE, PADS_REFCLK_CFG1);
> +		pads_writel(pcie, soc->pads_refclk_cfg1, PADS_REFCLK_CFG1);
> =20
>  	/* wait for the PLL to lock */
>  	err =3D tegra_pcie_pll_wait(pcie, 500);
> @@ -2078,6 +2070,7 @@ static const struct tegra_pcie_soc_data tegra20_pci=
e_data =3D {
>  	.msi_base_shift =3D 0,
>  	.pads_pll_ctl =3D PADS_PLL_CTL_TEGRA20,
>  	.tx_ref_sel =3D PADS_PLL_CTL_TXCLKREF_DIV10,
> +	.pads_refclk_cfg0 =3D 0xfa5cfa5c,
>  	.has_pex_clkreq_en =3D false,
>  	.has_pex_bias_ctrl =3D false,
>  	.has_intr_prsnt_sense =3D false,
> @@ -2090,6 +2083,8 @@ static const struct tegra_pcie_soc_data tegra30_pci=
e_data =3D {
>  	.msi_base_shift =3D 8,
>  	.pads_pll_ctl =3D PADS_PLL_CTL_TEGRA30,
>  	.tx_ref_sel =3D PADS_PLL_CTL_TXCLKREF_BUF_EN,
> +	.pads_refclk_cfg0 =3D 0xfa5cfa5c,
> +	.pads_refclk_cfg1 =3D 0xfa5cfa5c,
>  	.has_pex_clkreq_en =3D true,
>  	.has_pex_bias_ctrl =3D true,
>  	.has_intr_prsnt_sense =3D true,
> @@ -2102,6 +2097,7 @@ static const struct tegra_pcie_soc_data tegra124_pc=
ie_data =3D {
>  	.msi_base_shift =3D 8,
>  	.pads_pll_ctl =3D PADS_PLL_CTL_TEGRA30,
>  	.tx_ref_sel =3D PADS_PLL_CTL_TXCLKREF_BUF_EN,
> +	.pads_refclk_cfg0 =3D 0x44ac44ac,
>  	.has_pex_clkreq_en =3D true,
>  	.has_pex_bias_ctrl =3D true,
>  	.has_intr_prsnt_sense =3D true,

I think it'd be nice to have these decoded into their individual fields,
to reduce the magic. We already define the register fields, so it seems
sensible to use them.

Thierry

--VSaCG/zfRnOiPJtU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXaotNAAoJEN0jrNd/PrOhLTYP/jlaSo0vXY4K4M1a+drSuS5u
MYN6ZKFKboEMRf2NAxjLkV2dCwqjLkPWnClao8cL3/WL1I38KEAMEr8XD/GLW9b+
Fhh3iTH6VY94SwsWuAGUCxZt8aBRtRWwfyAwuPv2kRT5h6xhAJirVHNDiELlDbtg
iXfYxIF/qQo+vJjPNcsZV+Q37USD88PNHB6Ls3iXQ9BRyFYSuOZI3nqQMuW9xwEo
vgvrEzuBrC39g0S0i/RtaPoNcedt3cYFmZLAXJUX5EHo6QkyZfxte+RIAx1zPOzy
hFqAqe4RXAlAU9jdTPiPnqGMnrBW20xAvr7I12Gu3LCx7X+aA+hY4LJloT8wUZmJ
Yt2VhjlohoPH7BJrGtYPmT4uwFjz/I6lji0cC8/BUqNU4RcOtP1bm6AhsFJQA6Xk
+n7OmlDphp3yIj1mkYbLja18GlzAyp2zHwf4QI80u0d7kEfUNShgByRuANcNcp+W
VVsXYBAWZLxQKK0fQc8mgkYsM3AwczffnCAQb4E2CTQ1ADTBckJW9Y6wCdlBkllZ
8pIGHiFrvc3VQ6bX0+UJa+IbcvrP+wqfHvr9b4lKJlvC9MMT6G6m/GWtMeUF8X5K
caySnnhTT1loVGPeF9OqfqYVbu5RY1QZqZEsUI1L0/vm+SE32GIFwzD7LVt9+0XN
ACyd7oJi6AS5rT8QC664
=GKtd
-----END PGP SIGNATURE-----

--VSaCG/zfRnOiPJtU--
