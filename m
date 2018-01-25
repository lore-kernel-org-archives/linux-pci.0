Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:44194 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750911AbeAYOgb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Jan 2018 09:36:31 -0500
Date: Thu, 25 Jan 2018 15:36:27 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: bhelgaas@google.com, lorenzo.pieralisi@arm.com, cyndis@kapsi.fi,
        jonathanh@nvidia.com, robh+dt@kernel.org, frowand.list@gmail.com,
        rjw@rjwysocki.net, tglx@linutronix.de, vidyas@nvidia.com,
        kthota@nvidia.com, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH V6 6/7] PCI: tegra: Broadcast PME_Turn_Off message before
 link goes to L2
Message-ID: <20180125143627.GH27888@ulmo>
References: <1515650888-9459-1-git-send-email-mmaddireddy@nvidia.com>
 <1515650888-9459-7-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fmEUq8M7S0s+Fl0V"
In-Reply-To: <1515650888-9459-7-git-send-email-mmaddireddy@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--fmEUq8M7S0s+Fl0V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2018 at 11:38:07AM +0530, Manikanta Maddireddy wrote:
> Per PCIe r3.0, sec 5.3.3.2.1, PCIe root port shoould broadcast PME_Turn_O=
ff
> message before PCIe link goes to L2. PME_Turn_Off broadcast mechanism is
> implemented in AFI module. Each Tegra PCIe root port has its own
> PME_Turn_Off and PME_TO_Ack bitmap in AFI_PME register, program this
> register to broadcast PME_Turn_Off message.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> V2:
> * no change in this patch
> V3:
> * add PME bitmap in soc data instead of using compatible string
> * replace while loop with readl_poll_timeout() for polling
> * commit log correction
> V4:
> * no change in this patch
> V5:
> * Rebased on linux-next
> V6:
> * no change in this patch
>=20
>  drivers/pci/host/pci-tegra.c | 45 ++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 45 insertions(+)
>=20
> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> index 981f126b14d6..cc33fc0fb300 100644
> --- a/drivers/pci/host/pci-tegra.c
> +++ b/drivers/pci/host/pci-tegra.c
> @@ -31,6 +31,7 @@
>  #include <linux/delay.h>
>  #include <linux/export.h>
>  #include <linux/interrupt.h>
> +#include <linux/iopoll.h>
>  #include <linux/irq.h>
>  #include <linux/irqdomain.h>
>  #include <linux/kernel.h>
> @@ -153,6 +154,8 @@
>  #define  AFI_INTR_EN_FPCI_TIMEOUT	(1 << 7)
>  #define  AFI_INTR_EN_PRSNT_SENSE	(1 << 8)
> =20
> +#define AFI_PCIE_PME		0xf0
> +
>  #define AFI_PCIE_CONFIG					0x0f8
>  #define  AFI_PCIE_CONFIG_PCIE_DISABLE(x)		(1 << ((x) + 1))
>  #define  AFI_PCIE_CONFIG_PCIE_DISABLE_ALL		0xe
> @@ -233,6 +236,8 @@
>  #define PADS_REFCLK_CFG_PREDI_SHIFT		8  /* 11:8 */
>  #define PADS_REFCLK_CFG_DRVI_SHIFT		12 /* 15:12 */
> =20
> +#define PME_ACK_TIMEOUT 10000
> +
>  struct tegra_msi {
>  	struct msi_controller chip;
>  	DECLARE_BITMAP(used, INT_PCI_MSI_NR);
> @@ -251,6 +256,8 @@ struct tegra_pcie_soc {
>  	u32 tx_ref_sel;
>  	u32 pads_refclk_cfg0;
>  	u32 pads_refclk_cfg1;
> +	u8 pme_turnoff_bit[3];
> +	u8 pme_ack_bit[3];

This seems suboptimal to me. Perhaps a better way would be:

	struct tegra_pcie_port_soc {
		struct {
			u8 turnoff_bit;
			u8 ack_bit;
		} pme;
	};

And since we already have num_ports which defines exactly how many ports
we have:

	struct tegra_pcie_soc {
		unsigned int num_ports;
		const struct tegra_pcie_port_soc *ports;
		...
	};

I suspect that as you're adding more features we may need more of this
data.

But I'm fine to keep it like this. We can always switch to something
different if the above becomes too much cluttered.

>  	bool has_pex_clkreq_en;
>  	bool has_pex_bias_ctrl;
>  	bool has_intr_prsnt_sense;
> @@ -1358,6 +1365,31 @@ static int tegra_pcie_put_resources(struct tegra_p=
cie *pcie)
>  	return 0;
>  }
> =20
> +static void tegra_pcie_pme_turnoff(struct tegra_pcie_port *port)
> +{
> +	struct tegra_pcie *pcie =3D port->pcie;
> +	const struct tegra_pcie_soc *soc =3D pcie->soc;
> +	int err;
> +	u32 val;
> +
> +	val =3D afi_readl(pcie, AFI_PCIE_PME);
> +	val |=3D (0x1 << soc->pme_turnoff_bit[port->index]);
> +	afi_writel(pcie, val, AFI_PCIE_PME);
> +
> +	err =3D readl_poll_timeout(pcie->afi + AFI_PCIE_PME, val,
> +				 val & (0x1 << soc->pme_ack_bit[port->index]),
> +				 1, PME_ACK_TIMEOUT);
> +	if (err)
> +		dev_err(pcie->dev, "PME Ack is not received on port: %d\n",
> +			port->index);
> +
> +	usleep_range(10000, 11000);
> +
> +	val =3D afi_readl(pcie, AFI_PCIE_PME);
> +	val &=3D ~(0x1 << soc->pme_turnoff_bit[port->index]);
> +	afi_writel(pcie, val, AFI_PCIE_PME);
> +}
> +
>  static int tegra_msi_alloc(struct tegra_msi *chip)
>  {
>  	int msi;
> @@ -2109,6 +2141,8 @@ static const struct tegra_pcie_soc tegra20_pcie =3D=
 {
>  	.pads_pll_ctl =3D PADS_PLL_CTL_TEGRA20,
>  	.tx_ref_sel =3D PADS_PLL_CTL_TXCLKREF_DIV10,
>  	.pads_refclk_cfg0 =3D 0xfa5cfa5c,
> +	.pme_turnoff_bit =3D {0, 8},
> +	.pme_ack_bit =3D {5, 10},
>  	.has_pex_clkreq_en =3D false,
>  	.has_pex_bias_ctrl =3D false,
>  	.has_intr_prsnt_sense =3D false,
> @@ -2125,6 +2159,8 @@ static const struct tegra_pcie_soc tegra30_pcie =3D=
 {
>  	.tx_ref_sel =3D PADS_PLL_CTL_TXCLKREF_BUF_EN,
>  	.pads_refclk_cfg0 =3D 0xfa5cfa5c,
>  	.pads_refclk_cfg1 =3D 0xfa5cfa5c,
> +	.pme_turnoff_bit =3D {0, 8, 16},
> +	.pme_ack_bit =3D {5, 10, 18},
>  	.has_pex_clkreq_en =3D true,
>  	.has_pex_bias_ctrl =3D true,
>  	.has_intr_prsnt_sense =3D true,
> @@ -2140,6 +2176,8 @@ static const struct tegra_pcie_soc tegra124_pcie =
=3D {
>  	.pads_pll_ctl =3D PADS_PLL_CTL_TEGRA30,
>  	.tx_ref_sel =3D PADS_PLL_CTL_TXCLKREF_BUF_EN,
>  	.pads_refclk_cfg0 =3D 0x44ac44ac,
> +	.pme_turnoff_bit =3D {0, 8},
> +	.pme_ack_bit =3D {5, 10},
>  	.has_pex_clkreq_en =3D true,
>  	.has_pex_bias_ctrl =3D true,
>  	.has_intr_prsnt_sense =3D true,
> @@ -2155,6 +2193,8 @@ static const struct tegra_pcie_soc tegra210_pcie =
=3D {
>  	.pads_pll_ctl =3D PADS_PLL_CTL_TEGRA30,
>  	.tx_ref_sel =3D PADS_PLL_CTL_TXCLKREF_BUF_EN,
>  	.pads_refclk_cfg0 =3D 0x90b890b8,
> +	.pme_turnoff_bit =3D {0, 8},
> +	.pme_ack_bit =3D {5, 10},
>  	.has_pex_clkreq_en =3D true,
>  	.has_pex_bias_ctrl =3D true,
>  	.has_intr_prsnt_sense =3D true,
> @@ -2171,6 +2211,8 @@ static const struct tegra_pcie_soc tegra186_pcie =
=3D {
>  	.tx_ref_sel =3D PADS_PLL_CTL_TXCLKREF_BUF_EN,
>  	.pads_refclk_cfg0 =3D 0x80b880b8,
>  	.pads_refclk_cfg1 =3D 0x000480b8,
> +	.pme_turnoff_bit =3D {0, 8, 12},
> +	.pme_ack_bit =3D {5, 10, 14},
>  	.has_pex_clkreq_en =3D true,
>  	.has_pex_bias_ctrl =3D true,
>  	.has_intr_prsnt_sense =3D true,
> @@ -2399,11 +2441,14 @@ static int tegra_pcie_remove(struct platform_devi=
ce *pdev)
>  {
>  	struct tegra_pcie *pcie =3D platform_get_drvdata(pdev);
>  	struct pci_host_bridge *host =3D pci_host_bridge_from_priv(pcie);
> +	struct tegra_pcie_port *port, *tmp;
> =20
>  	if (IS_ENABLED(CONFIG_DEBUG_FS))
>  		tegra_pcie_debugfs_exit(pcie);
>  	pci_stop_root_bus(host->bus);
>  	pci_remove_root_bus(host->bus);
> +	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
> +		tegra_pcie_pme_turnoff(port);

Why list_for_each_entry_safe()? tegra_pcie_pme_turnoff() doesn't do
anything that would make port become invalid.

Thierry

--fmEUq8M7S0s+Fl0V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlpp62sACgkQ3SOs138+
s6FkkBAAjmeLFbk6TdQgo6tKgmVB6IK0ixqDivsTl8CLJNPVTJxH7MEWmSh9Ggxy
IX75IQd4VOSysnnoGjHbi0++erRfWehYD0E07uQ0z8UnJqukLq0myYsGwYQHVG5s
vkJAMxAUKcyVB4VA4TgiDeYO3rjL2WO1U84nMxAW5roPZ2or27gNDtkH4xDddK6D
fe4Q7OuwTfFLBSs3ZY4WK2NAsqGv9s3160D/beIZWtmSLYYuzv65ueP3oQfFrWbo
M8RTfX6QTEPJ0zYYsHy7i1upy4334IHA0gGFc4WEnESHzwRMoJQhvWx08MkGno/j
7RiB1xu5NI93A/ICFutjbg5iDGef6+z1bEBThUKCOs8jY/bOK6bGD+hjtH3UrVfX
/xlBUR+zjbN/qX+XR9H8a7DmK8ITd6QzpM0KjOTkUW0olzLp+bxTlODAH3qfcs6R
1oOfrWOEPv5k2cqqU8xK7E+ZPJHkb2CYCkwpJS4XwUfW7AeiwxLG565oX1yGa6Sq
mcI7YJMQYfrnT32vIfs0Y4Ps5m9T5cM8mW9/O3TOur1Hvfl7M//2VEhfqUyXUrKW
7wi9lNY29A/aa+tsRtScXkr90yQoxsdVvid7FAeU4UI4ehVWUqRtjqquR1ovPTyP
FEkxGW+xOQOD4JNrNW5RoyI60LsVGyTrrp+DMU3aXyLqxzusbpY=
=Wxs+
-----END PGP SIGNATURE-----

--fmEUq8M7S0s+Fl0V--
