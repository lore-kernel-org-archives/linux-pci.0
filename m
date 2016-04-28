Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33161 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752546AbcD1NjE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 28 Apr 2016 09:39:04 -0400
Date: Thu, 28 Apr 2016 15:38:58 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v5 2/2] PCI: tegra: Support per-lane PHYs
Message-ID: <20160428133858.GA13916@ulmo.ba.sec>
References: <1460991105-22861-1-git-send-email-thierry.reding@gmail.com>
 <1460991105-22861-2-git-send-email-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
In-Reply-To: <1460991105-22861-2-git-send-email-thierry.reding@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 18, 2016 at 04:51:45PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>=20
> The current XUSB pad controller bindings are insufficient to describe
> PHY devices attached to USB controllers. New bindings have been created
> to overcome these restrictions. As a side-effect each root port now is
> assigned a set of PHY devices, one for each lane associated with the
> root port. This has the benefit of allowing fine-grained control of the
> power management for each lane.
>=20
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Changes in v5:
> - fix power off sequence
>=20
> Changes in v4:
> - propagate failure from PHY power on
> - refactor PHY power off sequence
>=20
> Changes in v3:
> - cache result of check for new PHY bindings usage (Stephen Warren)
>=20
> Changes in v2:
> - rework commit message to more accurately describe this change
>=20
>  drivers/pci/host/pci-tegra.c | 243 +++++++++++++++++++++++++++++++++++++=
+++---
>  1 file changed, 226 insertions(+), 17 deletions(-)

Hi Bjorn,

still waiting for an Acked-by from you on this one so that I can take it
into the Tegra tree because of the intertwined dependencies of a larger
series.

I've been carrying this in a branch that feeds into linux-next and it's
seen some good test coverage and works well. I can stabilize that branch
and send it your way via a pull request.

Thanks,
Thierry

> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> index 68d1f41b3cbf..12d581130645 100644
> --- a/drivers/pci/host/pci-tegra.c
> +++ b/drivers/pci/host/pci-tegra.c
> @@ -295,6 +295,7 @@ struct tegra_pcie {
>  	struct reset_control *afi_rst;
>  	struct reset_control *pcie_xrst;
> =20
> +	bool legacy_phy;
>  	struct phy *phy;
> =20
>  	struct tegra_msi msi;
> @@ -311,11 +312,14 @@ struct tegra_pcie {
> =20
>  struct tegra_pcie_port {
>  	struct tegra_pcie *pcie;
> +	struct device_node *np;
>  	struct list_head list;
>  	struct resource regs;
>  	void __iomem *base;
>  	unsigned int index;
>  	unsigned int lanes;
> +
> +	struct phy **phys;
>  };
> =20
>  struct tegra_pcie_bus {
> @@ -860,6 +864,128 @@ static int tegra_pcie_phy_enable(struct tegra_pcie =
*pcie)
>  	return 0;
>  }
> =20
> +static int tegra_pcie_phy_disable(struct tegra_pcie *pcie)
> +{
> +	const struct tegra_pcie_soc_data *soc =3D pcie->soc_data;
> +	u32 value;
> +
> +	/* disable TX/RX data */
> +	value =3D pads_readl(pcie, PADS_CTL);
> +	value &=3D ~(PADS_CTL_TX_DATA_EN_1L | PADS_CTL_RX_DATA_EN_1L);
> +	pads_writel(pcie, value, PADS_CTL);
> +
> +	/* override IDDQ */
> +	value =3D pads_readl(pcie, PADS_CTL);
> +	value |=3D PADS_CTL_IDDQ_1L;
> +	pads_writel(pcie, PADS_CTL, value);
> +
> +	/* reset PLL */
> +	value =3D pads_readl(pcie, soc->pads_pll_ctl);
> +	value &=3D ~PADS_PLL_CTL_RST_B4SM;
> +	pads_writel(pcie, value, soc->pads_pll_ctl);
> +
> +	usleep_range(20, 100);
> +
> +	return 0;
> +}
> +
> +static int tegra_pcie_port_phy_power_on(struct tegra_pcie_port *port)
> +{
> +	struct device *dev =3D port->pcie->dev;
> +	unsigned int i;
> +	int err;
> +
> +	for (i =3D 0; i < port->lanes; i++) {
> +		err =3D phy_power_on(port->phys[i]);
> +		if (err < 0) {
> +			dev_err(dev, "failed to power on PHY#%u: %d\n", i,
> +				err);
> +			return err;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int tegra_pcie_port_phy_power_off(struct tegra_pcie_port *port)
> +{
> +	struct device *dev =3D port->pcie->dev;
> +	unsigned int i;
> +	int err;
> +
> +	for (i =3D 0; i < port->lanes; i++) {
> +		err =3D phy_power_off(port->phys[i]);
> +		if (err < 0) {
> +			dev_err(dev, "failed to power off PHY#%u: %d\n", i,
> +				err);
> +			return err;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int tegra_pcie_phy_power_on(struct tegra_pcie *pcie)
> +{
> +	struct tegra_pcie_port *port;
> +	int err;
> +
> +	if (pcie->legacy_phy) {
> +		if (pcie->phy)
> +			err =3D phy_power_on(pcie->phy);
> +		else
> +			err =3D tegra_pcie_phy_enable(pcie);
> +
> +		if (err < 0)
> +			dev_err(pcie->dev, "failed to power on PHY: %d\n", err);
> +
> +		return err;
> +	}
> +
> +	list_for_each_entry(port, &pcie->ports, list) {
> +		err =3D tegra_pcie_port_phy_power_on(port);
> +		if (err < 0) {
> +			dev_err(pcie->dev,
> +				"failed to power on PCIe port %u PHY: %d\n",
> +				port->index, err);
> +			return err;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int tegra_pcie_phy_power_off(struct tegra_pcie *pcie)
> +{
> +	struct tegra_pcie_port *port;
> +	int err;
> +
> +	if (pcie->legacy_phy) {
> +		if (pcie->phy)
> +			err =3D phy_power_off(pcie->phy);
> +		else
> +			err =3D tegra_pcie_phy_disable(pcie);
> +
> +		if (err < 0)
> +			dev_err(pcie->dev, "failed to power off PHY: %d\n",
> +				err);
> +
> +		return err;
> +	}
> +
> +	list_for_each_entry(port, &pcie->ports, list) {
> +		err =3D tegra_pcie_port_phy_power_off(port);
> +		if (err < 0) {
> +			dev_err(pcie->dev,
> +				"failed to power off PCIe port %u PHY: %d\n",
> +				port->index, err);
> +			return err;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static int tegra_pcie_enable_controller(struct tegra_pcie *pcie)
>  {
>  	const struct tegra_pcie_soc_data *soc =3D pcie->soc_data;
> @@ -899,13 +1025,9 @@ static int tegra_pcie_enable_controller(struct tegr=
a_pcie *pcie)
>  		afi_writel(pcie, value, AFI_FUSE);
>  	}
> =20
> -	if (!pcie->phy)
> -		err =3D tegra_pcie_phy_enable(pcie);
> -	else
> -		err =3D phy_power_on(pcie->phy);
> -
> +	err =3D tegra_pcie_phy_power_on(pcie);
>  	if (err < 0) {
> -		dev_err(pcie->dev, "failed to power on PHY: %d\n", err);
> +		dev_err(pcie->dev, "failed to power on PHY(s): %d\n", err);
>  		return err;
>  	}
> =20
> @@ -942,9 +1064,9 @@ static void tegra_pcie_power_off(struct tegra_pcie *=
pcie)
> =20
>  	/* TODO: disable and unprepare clocks? */
> =20
> -	err =3D phy_power_off(pcie->phy);
> +	err =3D tegra_pcie_phy_power_off(pcie);
>  	if (err < 0)
> -		dev_warn(pcie->dev, "failed to power off PHY: %d\n", err);
> +		dev_err(pcie->dev, "failed to power off PHY(s): %d\n", err);
> =20
>  	reset_control_assert(pcie->pcie_xrst);
>  	reset_control_assert(pcie->afi_rst);
> @@ -1049,6 +1171,99 @@ static int tegra_pcie_resets_get(struct tegra_pcie=
 *pcie)
>  	return 0;
>  }
> =20
> +static int tegra_pcie_phys_get_legacy(struct tegra_pcie *pcie)
> +{
> +	int err;
> +
> +	pcie->phy =3D devm_phy_optional_get(pcie->dev, "pcie");
> +	if (IS_ERR(pcie->phy)) {
> +		err =3D PTR_ERR(pcie->phy);
> +		dev_err(pcie->dev, "failed to get PHY: %d\n", err);
> +		return err;
> +	}
> +
> +	err =3D phy_init(pcie->phy);
> +	if (err < 0) {
> +		dev_err(pcie->dev, "failed to initialize PHY: %d\n", err);
> +		return err;
> +	}
> +
> +	pcie->legacy_phy =3D true;
> +
> +	return 0;
> +}
> +
> +static struct phy *devm_of_phy_optional_get_index(struct device *dev,
> +						  struct device_node *np,
> +						  const char *consumer,
> +						  unsigned int index)
> +{
> +	struct phy *phy;
> +	char *name;
> +
> +	name =3D kasprintf(GFP_KERNEL, "%s-%u", consumer, index);
> +	if (!name)
> +		return ERR_PTR(-ENOMEM);
> +
> +	phy =3D devm_of_phy_get(dev, np, name);
> +	kfree(name);
> +
> +	if (IS_ERR(phy) && PTR_ERR(phy) =3D=3D -ENODEV)
> +		phy =3D NULL;
> +
> +	return phy;
> +}
> +
> +static int tegra_pcie_port_get_phys(struct tegra_pcie_port *port)
> +{
> +	struct device *dev =3D port->pcie->dev;
> +	struct phy *phy;
> +	unsigned int i;
> +	int err;
> +
> +	port->phys =3D devm_kcalloc(dev, sizeof(phy), port->lanes, GFP_KERNEL);
> +	if (!port->phys)
> +		return -ENOMEM;
> +
> +	for (i =3D 0; i < port->lanes; i++) {
> +		phy =3D devm_of_phy_optional_get_index(dev, port->np, "pcie", i);
> +		if (IS_ERR(phy)) {
> +			dev_err(dev, "failed to get PHY#%u: %ld\n", i,
> +				PTR_ERR(phy));
> +			return PTR_ERR(phy);
> +		}
> +
> +		err =3D phy_init(phy);
> +		if (err < 0) {
> +			dev_err(dev, "failed to initialize PHY#%u: %d\n", i,
> +				err);
> +			return err;
> +		}
> +
> +		port->phys[i] =3D phy;
> +	}
> +
> +	return 0;
> +}
> +
> +static int tegra_pcie_phys_get(struct tegra_pcie *pcie)
> +{
> +	struct tegra_pcie_port *port;
> +	int err;
> +
> +	if (of_get_property(pcie->dev->of_node, "phys", NULL) !=3D NULL)
> +		return tegra_pcie_phys_get_legacy(pcie);
> +
> +	list_for_each_entry(port, &pcie->ports, list) {
> +		err =3D tegra_pcie_port_get_phys(port);
> +		if (err < 0) {
> +			return err;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static int tegra_pcie_get_resources(struct tegra_pcie *pcie)
>  {
>  	struct platform_device *pdev =3D to_platform_device(pcie->dev);
> @@ -1067,16 +1282,9 @@ static int tegra_pcie_get_resources(struct tegra_p=
cie *pcie)
>  		return err;
>  	}
> =20
> -	pcie->phy =3D devm_phy_optional_get(pcie->dev, "pcie");
> -	if (IS_ERR(pcie->phy)) {
> -		err =3D PTR_ERR(pcie->phy);
> -		dev_err(&pdev->dev, "failed to get PHY: %d\n", err);
> -		return err;
> -	}
> -
> -	err =3D phy_init(pcie->phy);
> +	err =3D tegra_pcie_phys_get(pcie);
>  	if (err < 0) {
> -		dev_err(&pdev->dev, "failed to initialize PHY: %d\n", err);
> +		dev_err(&pdev->dev, "failed to get PHYs: %d\n", err);
>  		return err;
>  	}
> =20
> @@ -1752,6 +1960,7 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *p=
cie)
>  		rp->index =3D index;
>  		rp->lanes =3D value;
>  		rp->pcie =3D pcie;
> +		rp->np =3D port;
> =20
>  		rp->base =3D devm_ioremap_resource(pcie->dev, &rp->regs);
>  		if (IS_ERR(rp->base))
> --=20
> 2.8.0
>=20

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXIhJyAAoJEN0jrNd/PrOhfA8P/i6l3XyjiWmv4NnvsMf1aJD5
zMpApRD8d6y2bLetv9mFarPKoU2HnGrDMXCmsGEQTp7uryur+e+hHg+YFXRBpHha
3xs7Fl7sNgFSa/Eg8cKkcAnuIOYRaGaaHbVqznnEoXWZip0xcrpjL+vo35KleJbw
8Y4do81MtzQw5TUlWP75T+SLM9aR22NGN005/DRTza9uEs/1qXPpYGA3OOyYt1Js
5LPv+5eyBnvabFJzes6SFHyJcq3fEa+CwubwrQ3JarXlcQMksCa3MPwQ/ancWplT
xzFGL6Fc/2j3G/ER/TCRJ9RNIBuhk7JK/B5b0FLZCsfSvJwcXJwUl+TZntTY/3Bn
W1y6BGDR3CB6UnYAn2WUZ24cYAjfPCMmUqTQcc2OwvicUikm4X2qA2UWQv0goz6C
ZBRaM+P6WzTGBDO1oTfwrt5rKljBoq/V8bCxdKHf2QPngPexNUfYF2HY1P/vTs9t
x/KePPiCJJNj7p0Wk1kuo5TG138pEwwKYlz4M1HiNlgOiJsawT3Ta6qrm56Jtfbt
wfoCUa+QZ/10LQLXCUZ1dpXBb6Tid/u+Wp2FqSiVBFAuodIei0pPr4QR2rE7dGil
VDDrp+G76tIGyWsE0nd8z8CMdZ+jNddpjef/CNYYK3BmzCRUNyvzLwRq+z75XJRN
d0SVM8Vip3XTP6ARi7oK
=2GBv
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
