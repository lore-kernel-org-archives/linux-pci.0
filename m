Return-Path: <SRS0=6/CK=BQ=gmail.com=thierry.reding@kernel.org>
Return-Path: <SRS0=6/CK=BQ=gmail.com=thierry.reding@kernel.org>
Date: Tue, 17 Oct 2017 22:27:49 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manikanta Maddireddy <mmaddireddy@nvidia.com>, bhelgaas@google.com,
	jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
	linux-pci@vger.kernel.org, mperttunen@nvidia.com
Subject: Re: [PATCH V2 2/4] PCI: tegra: Add Tegra186 PCIe support
Message-ID: <20171017202749.GB10482@ulmo>
References: <1506513517-25870-1-git-send-email-mmaddireddy@nvidia.com>
 <1506513517-25870-3-git-send-email-mmaddireddy@nvidia.com>
 <20171017173428.GE5641@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="H1spWtNR+x+ondvy"
In-Reply-To: <20171017173428.GE5641@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>


--H1spWtNR+x+ondvy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 17, 2017 at 12:34:28PM -0500, Bjorn Helgaas wrote:
> On Wed, Sep 27, 2017 at 05:28:35PM +0530, Manikanta Maddireddy wrote:
> > UPHY programming is performed by BPMP, PHY enable calls are
> > not required for Tegra186 PCIe. Power partition ungate is
> > done by BPMP powergate driver.
> >=20
> > Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> > Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
> > Tested-by: Mikko Perttunen <mperttunen@nvidia.com>
> > ---
> > V2: Add soc->program_uphy check for phy_exit call
> >  drivers/pci/host/pci-tegra.c | 132 +++++++++++++++++++++++++++++++++++=
--------
> >  1 file changed, 108 insertions(+), 24 deletions(-)
>=20
> > @@ -1012,10 +1016,12 @@ static int tegra_pcie_enable_controller(struct =
tegra_pcie *pcie)
> >  		afi_writel(pcie, value, AFI_FUSE);
> >  	}
> > =20
> > -	err =3D tegra_pcie_phy_power_on(pcie);
> > -	if (err < 0) {
> > -		dev_err(dev, "failed to power on PHY(s): %d\n", err);
> > -		return err;
> > +	if (soc->program_uphy) {
> > +		err =3D tegra_pcie_phy_power_on(pcie);
> > +		if (err < 0) {
> > +			dev_err(dev, "failed to power on PHY(s): %d\n", err);
> > +			return err;
> > +		}
>=20
> This looks good: it's obvious that the previously-supported devices
> continue to work the same way because you set ".program_uphy =3D true"
> for them.  (It would be even more obvious if you changed the sense so
> that only the new device had to add this initializaer, but in general
> I prefer the positive logic as you have here, and I did verify that
> you added the initializer for all tegra_pcie_soc variants.)
>=20
> > @@ -1048,19 +1054,23 @@ static int tegra_pcie_enable_controller(struct =
tegra_pcie *pcie)
> >  static void tegra_pcie_power_off(struct tegra_pcie *pcie)
> >  {
> >  	struct device *dev =3D pcie->dev;
> > +	const struct tegra_pcie_soc *soc =3D pcie->soc;
> >  	int err;
> > =20
> >  	/* TODO: disable and unprepare clocks? */
> > =20
> > -	err =3D tegra_pcie_phy_power_off(pcie);
> > -	if (err < 0)
> > -		dev_err(dev, "failed to power off PHY(s): %d\n", err);
> > +	if (soc->program_uphy) {
> > +		err =3D tegra_pcie_phy_power_off(pcie);
> > +		if (err < 0)
> > +			dev_err(dev, "failed to power off PHY(s): %d\n", err);
> > +	}
> > =20
> >  	reset_control_assert(pcie->pcie_xrst);
> >  	reset_control_assert(pcie->afi_rst);
> >  	reset_control_assert(pcie->pex_rst);
> > =20
> > -	tegra_powergate_power_off(TEGRA_POWERGATE_PCIE);
> > +	if (!dev->pm_domain)
> > +		tegra_powergate_power_off(TEGRA_POWERGATE_PCIE);
>=20
> But this one isn't obvious because nothing in your patch obviously
> affects dev->pm_domain, so I can't tell whether this is safe.  It's
> worth a changelog comment to help justify this.

The last sentence in the commit message is what this is about. Maybe it
should be more verbose:

	Since the BPMP controls the powergates on Tegra186, there is no
	need to manually power on and off the PCIe power partition. The
	BPMP generic power domain driver takes care of it instead.

?

Thierry

--H1spWtNR+x+ondvy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlnmZ8QACgkQ3SOs138+
s6HYJxAAtb6cw7AK6M1SmCe/ROsp1SR10Nrc692TeU8XTmUm+Q2UrSemrLi8yWA8
vim+7gf1FkoaRtzd/5Kl+NdZMc1rlZE7OhgYFZQpisA9qsyasbqlK6slzbv8Uaic
m4Ti2euzRrzIs3582miHH3AthqgTh4Xh7Du0IhorKpYm4S3GEA+aXx8RbHQ1Mj6N
pelYjCy3nCcdNck5vYEeZ054jteEwX1vVPoJe6AJTrDjf4qTjgp5Ig1B/sRwU8Rs
P92Ux8GpQN6xz0asIj5Ff1gO7VypVcz9aySR2txjyPSUii2fla8PRoHlfVr83lYx
Cl2BtLQg4A5uhRr/iq8HD7fcNcTY9LAPXJXq/XfVZM7Y2NicxHrBQFG+eYhfHQJn
9veihonWi9NRnFan+8VV2ip8iEr87iNXFmOi3lByFtVroMJQ2HTs/L4kkymCTX48
OcJ3MZx6Kj5pfV+jIMhbMVB0P2M3ENFGsFOsza/SaigDzSCPrrZDmHaZnvX4D62M
Tida+w5yeD0BJsd8qDrx77rN7NPQfw8B6Xf3sTCoUG0uTpBkq+BGjqV4cMXIoWbM
SDzVNp9NVF4HY3hdvWeSziVt0PkzmNbthD4FfCGA9FDBeEtED5a3DekstAKxSKO7
CgFhf93/8i3zx2RVStb8Gre/rVp2giZmRzTuDCrlzfiEnOzKB9g=
=TaIQ
-----END PGP SIGNATURE-----

--H1spWtNR+x+ondvy--
