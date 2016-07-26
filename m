Return-Path: <thierry.reding@gmail.com>
Return-Path: <thierry.reding@gmail.com>
Date: Tue, 26 Jul 2016 11:54:15 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-tegra@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 3/3] PCI: tegra: Stop setting pcibios_min_mem
Message-ID: <20160726095415.GD2433@ulmo.ba.sec>
References: <20160630131430.32096-1-thierry.reding@gmail.com>
 <20160630131430.32096-3-thierry.reding@gmail.com>
 <20160725212850.GA24485@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MAH+hnPXVZWQ5cD/"
In-Reply-To: <20160725212850.GA24485@localhost>
List-ID: <linux-pci.vger.kernel.org>


--MAH+hnPXVZWQ5cD/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 25, 2016 at 04:28:50PM -0500, Bjorn Helgaas wrote:
> On Thu, Jun 30, 2016 at 03:14:30PM +0200, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > In practice this value will never be used and it hinders portability of
> > the driver, so remove it.
> >=20
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >  drivers/pci/host/pci-tegra.c | 2 --
> >  1 file changed, 2 deletions(-)
> >=20
> > diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> > index f04b062e8c67..bbf77a49517d 100644
> > --- a/drivers/pci/host/pci-tegra.c
> > +++ b/drivers/pci/host/pci-tegra.c
> > @@ -2249,8 +2249,6 @@ static int tegra_pcie_probe(struct platform_devic=
e *pdev)
> >  	if (err < 0)
> >  		return err;
> > =20
> > -	pcibios_min_mem =3D 0;
>=20
> unsigned long pcibios_min_mem =3D 0x01000000;   # arch/arm/mm/iomap.c
> #define PCIBIOS_MIN_MEM pcibios_min_mem       # arch/arm/include/asm/pci.h
>=20
> PCIBIOS_MIN_MEM is used in __pci_assign_resource().
>=20
> It looks to me like we still use pcibios_min_mem; am I missing something?

The problem is that pcibios_min_mem is only defined on 32-bit ARM, so
we'd need to conditionalize (with a preprocessor macro) the usage.
However it turns out that it's not necessary because PCIBIOS_MIN_MEM
only serves as a lower bound during resource assignment.

pci_bus_alloc_resource() will eventually end up assigning from one of
the regions defined in device tree and the lowest we'll ever start any
of the memory regions is 0x12000000 (Tegra124).

So instead of conditionalizing I've simply dropped the assignment
because the default works fine for Tegra.

Thierry

--MAH+hnPXVZWQ5cD/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXlzNFAAoJEN0jrNd/PrOhOmsP/22j+5nUhtMaSDqSMt5uxsCv
8IS09F9bNj6MZ93Ox+3TE46fZP+7uBY4miTvlG8gKVcM5R0slvgEm2Z+0cdHNz4P
6BBDXSlqX8qllbEzSl+yOcRyix2fuVDu9EIMmIAL5L5rsoSBzXDhbrS9CUS1KARF
tN+EqcO2pCIb4l+SEnSTPMTwK/ccPqGQpZvwjCGsbLgARBhI4xBivv5pwCtVo3zJ
kmqFejYPv1zw8NqMyN8MZOcP7YYN23+KhlLyenCOznROClGK4sSt7Zzv/IXJhi9K
4wgl3kT11Om9b3gY72Q1n4qzRLqlE1/HfvkmlPTZHyM4Juzly0t//Y9fY24ZAc6c
tLR6Q7csP4o2iBEuxhN/a/3eZORaz6509DTjn7r2uwT8qYbxGbptMmtuAfB5Oo00
iG7wO8CEiV+/TAgLwTSlN5emQeXJsmo7ZiZyCMLdKQbQx/dYQAFJsf8lP58RY0NY
gASUY+zDgYrqZZmJTz8U1cyisD/DsoSQ20mQ0nXkS76+peTXufZo8dLLuwRo0lSU
JRlmqr/o+4dJp9TpDPLUIM43BoYXY5SdjYGkevM1QFqa8SSJE27MutX5GxDC+h35
6FXIQTTeNKvcB6du1MAL3359cUOML+bn5uW+vudkO0yRJqUwfcbfIORn8Zwg5h4L
hbRGhtPXTPlynz4NCiPX
=c8pk
-----END PGP SIGNATURE-----

--MAH+hnPXVZWQ5cD/--
