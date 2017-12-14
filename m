Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:38058 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752687AbdLNP2i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Dec 2017 10:28:38 -0500
Date: Thu, 14 Dec 2017 16:28:34 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: bhelgaas@google.com, jonathanh@nvidia.com, vidyas@nvidia.com,
        mperttunen@nvidia.com, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, kthota@nvidia.com
Subject: Re: [PATCH V3 05/12] PCI: tegra: Program UPHY electrical settings in
 Tegra210
Message-ID: <20171214152834.GE13733@ulmo>
References: <1509371843-22931-1-git-send-email-mmaddireddy@nvidia.com>
 <1509371843-22931-6-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HnQK338I3UIa/qiP"
In-Reply-To: <1509371843-22931-6-git-send-email-mmaddireddy@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--HnQK338I3UIa/qiP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2017 at 07:27:16PM +0530, Manikanta Maddireddy wrote:
> UPHY electrical programming guidelines are documented in Tegra210 TRM.
> Program these electrical settings for proper eye diagram in all link
> speeds.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> V3:
> * Added shift operation for readability
> V2:
> * no change in this patch
>=20
>  drivers/pci/host/pci-tegra.c | 97 ++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 97 insertions(+)
>=20
> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> index 46896aaab81d..c862facfd6e9 100644
> --- a/drivers/pci/host/pci-tegra.c
> +++ b/drivers/pci/host/pci-tegra.c
> @@ -184,6 +184,32 @@
> =20
>  #define AFI_PEXBIAS_CTRL_0		0x168
> =20
> +#define RP_ECTL_2_R1	0xe84
> +#define  RP_ECTL_2_R1_RX_CTLE_1C_MASK		0xffff
> +
> +#define RP_ECTL_4_R1	0xe8c
> +#define  RP_ECTL_4_R1_RX_CDR_CTRL_1C_MASK	(0xffff << 16)
> +#define  RP_ECTL_4_R1_RX_CDR_CTRL_1C_SHIFT	16
> +
> +#define RP_ECTL_5_R1	0xe90
> +#define  RP_ECTL_5_R1_RX_EQ_CTRL_L_1C_MASK	0xffffffff
> +
> +#define RP_ECTL_6_R1	0xe94
> +#define  RP_ECTL_6_R1_RX_EQ_CTRL_H_1C_MASK	0xffffffff
> +
> +#define RP_ECTL_2_R2	0xea4
> +#define  RP_ECTL_2_R2_RX_CTLE_1C_MASK		0xffff
> +
> +#define RP_ECTL_4_R2	0xeac
> +#define  RP_ECTL_4_R2_RX_CDR_CTRL_1C_MASK	(0xffff << 16)
> +#define  RP_ECTL_4_R2_RX_CDR_CTRL_1C_SHIFT	16
> +
> +#define RP_ECTL_5_R2	0xeb0
> +#define  RP_ECTL_5_R2_RX_EQ_CTRL_L_1C_MASK	0xffffffff
> +
> +#define RP_ECTL_6_R2	0xeb4
> +#define  RP_ECTL_6_R2_RX_EQ_CTRL_H_1C_MASK	0xffffffff
> +
>  #define RP_VEND_XP	0x00000f00
>  #define  RP_VEND_XP_DL_UP	(1 << 30)
> =20
> @@ -254,6 +280,14 @@ struct tegra_pcie_soc {
>  	u32 tx_ref_sel;
>  	u32 pads_refclk_cfg0;
>  	u32 pads_refclk_cfg1;
> +	u32 rp_ectl_2_r1;
> +	u32 rp_ectl_4_r1;
> +	u32 rp_ectl_5_r1;
> +	u32 rp_ectl_6_r1;
> +	u32 rp_ectl_2_r2;
> +	u32 rp_ectl_4_r2;
> +	u32 rp_ectl_5_r2;
> +	u32 rp_ectl_6_r2;
>  	bool has_pex_clkreq_en;
>  	bool has_pex_bias_ctrl;
>  	bool has_intr_prsnt_sense;
> @@ -261,6 +295,7 @@ struct tegra_pcie_soc {
>  	bool has_gen2;
>  	bool force_pca_enable;
>  	bool program_uphy;
> +	bool program_ectl_settings;

Could you move all of the ECTL related fields under a substructure for
better readability? Something like:

	struct {
		struct {
			u32 ...;
			...
		} regs;

		bool enable;
	} ectl;

>  };
> =20
>  static inline struct tegra_msi *to_tegra_msi(struct msi_controller *chip)
> @@ -2058,6 +2093,52 @@ static void tegra_pcie_apply_pad_settings(struct t=
egra_pcie *pcie)
>  		pads_writel(pcie, soc->pads_refclk_cfg1, PADS_REFCLK_CFG1);
>  }
> =20
> +static void tegra_pcie_program_ectl_settings(struct tegra_pcie_port *por=
t)
> +{
> +	unsigned long value;

u32, please.

> +	const struct tegra_pcie_soc *soc =3D port->pcie->soc;
> +
> +	value =3D readl(port->base + RP_ECTL_2_R1);
> +	value &=3D ~RP_ECTL_2_R1_RX_CTLE_1C_MASK;
> +	value |=3D soc->rp_ectl_2_r1;
> +	writel(value, port->base + RP_ECTL_2_R1);
> +
> +	value =3D readl(port->base + RP_ECTL_4_R1);
> +	value &=3D ~RP_ECTL_4_R1_RX_CDR_CTRL_1C_MASK;
> +	value |=3D (soc->rp_ectl_4_r1 << RP_ECTL_4_R1_RX_CDR_CTRL_1C_SHIFT);
> +	writel(value, port->base + RP_ECTL_4_R1);
> +
> +	value =3D readl(port->base + RP_ECTL_5_R1);
> +	value &=3D ~RP_ECTL_5_R1_RX_EQ_CTRL_L_1C_MASK;
> +	value |=3D soc->rp_ectl_5_r1;
> +	writel(value, port->base + RP_ECTL_5_R1);
> +
> +	value =3D readl(port->base + RP_ECTL_6_R1);
> +	value &=3D ~RP_ECTL_6_R1_RX_EQ_CTRL_H_1C_MASK;
> +	value |=3D soc->rp_ectl_6_r1;
> +	writel(value, port->base + RP_ECTL_6_R1);
> +
> +	value =3D readl(port->base + RP_ECTL_2_R2);
> +	value &=3D ~RP_ECTL_2_R2_RX_CTLE_1C_MASK;
> +	value |=3D soc->rp_ectl_2_r2;
> +	writel(value, port->base + RP_ECTL_2_R2);
> +
> +	value =3D readl(port->base + RP_ECTL_4_R2);
> +	value &=3D ~RP_ECTL_4_R2_RX_CDR_CTRL_1C_MASK;
> +	value |=3D (soc->rp_ectl_4_r2 << RP_ECTL_4_R2_RX_CDR_CTRL_1C_SHIFT);
> +	writel(value, port->base + RP_ECTL_4_R2);
> +
> +	value =3D readl(port->base + RP_ECTL_5_R2);
> +	value &=3D ~RP_ECTL_5_R2_RX_EQ_CTRL_L_1C_MASK;
> +	value |=3D soc->rp_ectl_5_r2;
> +	writel(value, port->base + RP_ECTL_5_R2);
> +
> +	value =3D readl(port->base + RP_ECTL_6_R2);
> +	value &=3D ~RP_ECTL_6_R2_RX_EQ_CTRL_H_1C_MASK;
> +	value |=3D soc->rp_ectl_6_r2;
> +	writel(value, port->base + RP_ECTL_6_R2);
> +}
> +
>  static void tegra_pcie_enable_rp_features(struct tegra_pcie_port *port)
>  {
>  	unsigned long value;
> @@ -2125,6 +2206,7 @@ static void tegra_pcie_enable_ports(struct tegra_pc=
ie *pcie)
>  {
>  	struct device *dev =3D pcie->dev;
>  	struct tegra_pcie_port *port, *tmp;
> +	const struct tegra_pcie_soc *soc =3D pcie->soc;
> =20
>  	tegra_pcie_apply_pad_settings(pcie);
> =20
> @@ -2133,6 +2215,8 @@ static void tegra_pcie_enable_ports(struct tegra_pc=
ie *pcie)
>  			 port->index, port->lanes);
> =20
>  		tegra_pcie_port_enable(port);
> +		if (soc->program_ectl_settings)
> +			tegra_pcie_program_ectl_settings(port);

Perhaps this should be moved into tegra_pcie_port_enable()? That way the
programming is done in one central location. If ever we need to enable
the ports from somewhere else we could simply call it instead of having
to duplicate enabling all the extra features.

Thierry

--HnQK338I3UIa/qiP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAloymJ8ACgkQ3SOs138+
s6HY3Q/8DfmUdPMxNgKha6K9he7wOBP46SN/iusLNTJvReJZ+LjgBot1YxAZTSLn
exHI5y6iXQZv0AXpfjJlwOR1076DJlrwNP8cEWxD8F6IQFg/5mn6qPgRkl1MwjlT
jML48YIIvTU3GLRefV96kIVul/YnlQv22Dk9EXpuEBmxzFgjk5YHYT5Dg5WOfQGC
CKXKAoK2tfCXY4T3g8sPx3koqnN46PS3i0e6faz03xOwlPOgaDM8/ILI8X6MwQ5u
PiNA9q0WQ0imC6cvhLQdd2gT4hlufmBfNfaaAJwsIFcMNLjdztoGNvDxQmkbb3Gk
Fi5F7hCNt8gAh/rec5sio4F00Wuqp5Ob4nTElZRFblpVACSKBNbmOiw/KS3EnZ40
nvorBhJ/rbQWkA2XNyE/WI38ttlqcGi+u/kx6HV7W1VWJEr/UJwgrLcurr5cAQET
Kq3KVOJzstNWT0TF56VUE85+7lpNI7+lJLhU6BDQfHeIamOe1DnUjeeVWIW/PujT
lUBX+zBrimPlGZmJ4PUUpWyDMECSxGtBeeHyxh5G8ZT0dlHucC+yevnCVcxaA9L3
7PCMCFZpbHKlkJaZf2k+fzuMxoN9tZ+VHgzv/XkHzIbu1uv1TugaCfa7coYTt1tm
CDKtZquv7VzFOMXNQbqK6qz3MiE6SgNHjN9KeFe1jOmShBP7HfQ=
=b0ke
-----END PGP SIGNATURE-----

--HnQK338I3UIa/qiP--
