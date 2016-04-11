Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38124 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753757AbcDKLLY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 11 Apr 2016 07:11:24 -0400
Date: Mon, 11 Apr 2016 13:11:19 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/2] PCI: tegra: Support per-lane PHYs
Message-ID: <20160411111119.GB17743@ulmo.ba.sec>
References: <1460131994-24493-1-git-send-email-thierry.reding@gmail.com>
 <1460131994-24493-2-git-send-email-thierry.reding@gmail.com>
 <20160408180528.GC15034@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5/uDoXvLw7AC5HRs"
In-Reply-To: <20160408180528.GC15034@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--5/uDoXvLw7AC5HRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 08, 2016 at 01:05:28PM -0500, Bjorn Helgaas wrote:
> Hi Thierry,
>=20
> I think there are a couple typos (one in a message and one that
> actually looks important), and one question below.
>=20
> On Fri, Apr 08, 2016 at 06:13:14PM +0200, Thierry Reding wrote:
[...]
> > +static int tegra_pcie_phy_power_off(struct tegra_pcie *pcie)
> > +{
> > +	struct tegra_pcie_port *port;
> > +	int err;
> > +
> > +	if (pcie->legacy_phy) {
> > +		if (pcie->phy)
> > +			err =3D phy_power_on(pcie->phy);
>=20
> s/phy_power_on/phy_power_off/

Good catch. Fixed.

> > @@ -899,13 +1025,9 @@ static int tegra_pcie_enable_controller(struct te=
gra_pcie *pcie)
> >  		afi_writel(pcie, value, AFI_FUSE);
> >  	}
> > =20
> > -	if (!pcie->phy)
> > -		err =3D tegra_pcie_phy_enable(pcie);
> > -	else
> > -		err =3D phy_power_on(pcie->phy);
> > -
> > +	err =3D tegra_pcie_phy_power_on(pcie);
> >  	if (err < 0) {
> > -		dev_err(pcie->dev, "failed to power on PHY: %d\n", err);
> > +		dev_err(pcie->dev, "failed to power off PHY(s): %d\n", err);
>=20
> s/off/on/

Fixed.

> > +static int tegra_pcie_phys_get(struct tegra_pcie *pcie)
> > +{
> > +	struct tegra_pcie_port *port;
> > +	int err;
> > +
> > +	if (of_get_property(pcie->dev->of_node, "phys", NULL) !=3D NULL)
> > +		return tegra_pcie_phys_get_legacy(pcie);
> > +
> > +	list_for_each_entry(port, &pcie->ports, list) {
> > +		err =3D tegra_pcie_port_get_phys(port);
> > +		if (err < 0) {
> > +			return err;
> > +		}
> > +	}
>=20
> This seems backwards: if I'm reading this right, you first check for
> the legacy property ("phys") and use it if you find it.  If there is
> no legacy property, you look for the new per-lane PHYs.
>=20
> The usual pattern would be "look for the new stuff, and if you don't
> find it, fall back to the old stuff." Is there a configuration that
> could be described either way, e.g., something with only one lane and
> only one PHY?
>=20
> I'm not sure whether it matters, but if it *could* use the "new, fall
> back to old" pattern, that would be nice and would keep people from
> wondering whether it's safe to do it backwards.

The reason why I wrote it this way is to special case the legacy code.
The alternative would be to do:

	if (of_get_property(...) =3D=3D NULL) {
		list_for_each_entry(port, &pcie->ports, list) {
			err =3D tegra_pcie_port_get_phys(port);
			if (err < 0)
				return err;
		}
	}

	return tegra_pcie_phys_get_legacy(pcie);

Which is better in the way you describe (fall back to legacy if new
binding is not found). But like I said, it makes, from the code flow,
the new binding the exception, which looks odd to me as well.

Perhaps this could be somewhat mitigated by wrapping the new code into
a separate function:

	if (of_get_property(...) =3D=3D NULL)
		return tegra_pcie_phys_get_per_lane(pcie);

	return tegra_pcie_phys_get_legacy(pcie);

I don't feel very strongly in either direction. Do you have a
preference?

Thierry

--5/uDoXvLw7AC5HRs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXC4ZVAAoJEN0jrNd/PrOhtfMP/2K8QEyHd4IkJO3Fd5nCYcA1
DdZAgJBo2ZpJMHiWClcQ/GgpF4sTcvuD1YBav1mQBDxvr3qkkpHsT9Y2z/vgbKB9
hzk6p7fjwhuOw3qAQ5yBEYPG7MO8+LvImNXFzB57An2mRruvkoLeOcxNj21kAQw6
Kwmt1dLi0bW33J/emAnUi6JqZYd+/HLew4lsS1u/H5xMz3jqDW9xpP74Z3l1s8fy
RQhtIpOZ4x7LciTg8nVEdXaAXfBAqxtvRvd4VbJe6l5msEzgmZVNZK+6LHmtYHrW
BIYZriC3uT2rjbdFTLksFIKE6qWEfTGc8PTJ+QIDdlZG7wF1xnNmZlyXtmCi/P2+
b1qzj33jPq7KtypzSxxe0zaaXWEVqxX5q2TwwUF5eSCePtebgBbOMN0WJyDvbBzd
3PEGrPng+LhFlyLBveCAJbWzpxjTaMFlcX8Gk98DxwmiplT8BGQYJQ3yvU9Huh4b
YNT3ztjgu4LbzON/LHE1oLDimpVqT6cEoKy4kreS8b1O0rAnV258wSqRWdN9Jbwg
OfY+tbtxeODI5ibwYV2L74/17iq80TuHzYXDa6roaZH4vcJvHnsVQjqfW8mfQD9k
jExVH1s9E6zOjeGvaUn5nxXxZCP0TTF3V8ZM3p6pkE7iAOGSo18/LLUEpFAMHqNE
t5AxGktQnmQjmwSbGFNS
=IsIL
-----END PGP SIGNATURE-----

--5/uDoXvLw7AC5HRs--
