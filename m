Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33075 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753649AbcDMQBR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 Apr 2016 12:01:17 -0400
Date: Wed, 13 Apr 2016 18:01:12 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 2/2] PCI: tegra: Support per-lane PHYs
Message-ID: <20160413160112.GA30129@ulmo.ba.sec>
References: <1457452094-5409-1-git-send-email-thierry.reding@gmail.com>
 <1457452094-5409-2-git-send-email-thierry.reding@gmail.com>
 <56E9915F.9040608@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
In-Reply-To: <56E9915F.9040608@wwwdotorg.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 16, 2016 at 11:01:19AM -0600, Stephen Warren wrote:
> On 03/08/2016 08:48 AM, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > The current XUSB pad controller bindings are insufficient to describe
> > PHY devices attached to USB controllers. New bindings have been created
> > to overcome these restrictions. As a side-effect each root port now is
> > assigned a set of PHY devices, one for each lane associated with the
> > root port. This has the benefit of allowing fine-grained control of the
> > power management for each lane.
>=20
> > diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
>=20
> > +static int tegra_pcie_port_phy_power_on(struct tegra_pcie_port *port)
> > +{
> > +	struct device *dev =3D port->pcie->dev;
> > +	unsigned int i;
> > +	int err;
> > +
> > +	for (i =3D 0; i < port->lanes; i++) {
> > +		err =3D phy_power_on(port->phys[i]);
>=20
> This assume the number of array entries is precisely the number of lanes.
> That seems to contradict the binding update which said the number might n=
ot
> match. Perhaps there's an expectation that phy_power_on() is a no-op for
> some "invalid" values like NULL or an error-pointer value? But...
>=20
> > +static struct phy *devm_of_phy_optional_get_index(struct device *dev,
> > +						  struct device_node *np,
> > +						  const char *consumer,
> > +						  unsigned int index)
> > +{
> > +	struct phy *phy;
> > +	char *name;
> > +
> > +	name =3D kasprintf(GFP_KERNEL, "%s-%u", consumer, index);
> > +	if (!name)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	phy =3D devm_of_phy_get(dev, np, name);
> > +	kfree(name);
> > +
> > +	if (IS_ERR(phy) && PTR_ERR(phy) =3D=3D -ENODEV)
> > +		phy =3D NULL;
> > +
> > +	return phy;
> > +}
>=20
> The error-handling there looks wrong. The function generally returns eith=
er
> a valid PHY or an error pointer. However, in the case of -ENODEV, NULL is
> returned. Subsystems are supposed to encode their handles as, and functio=
ns
> are supposed to return, either NULL or an error pointer for error cases, =
not
> both/either. Is the PHY API broken in this regard? If so, then this code =
is
> fine, but if not it might need a fix.

This function mimics phy_optional_get() which similarily returns NULL
for -ENODEV. The remainder of the PHY API treats NULL pointers as
"dummy" PHYs and returns early. I think that's a sensible approach to
handling optional resources.

It might have been more obvious had I implemented this function within
phy-core.c, but I didn't think it universally useful because it uses a
rather uncommon lookup pattern. I did keep a generic name in case it's
ever deemed useful outside of this driver, at which point it could
simply be moved into phy-core.c without requiring this driver to
change.

Thierry

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXDm1GAAoJEN0jrNd/PrOhsx8P/RdwUR2RReTGjrJTcVD3SbtX
88/lQrxjc2PIuORz1olJrGsofkkvCxQjVnC2EzclviCsCjqg8A1GCJ8nUdC3LNz7
narULEukh2hhLdtL1t6GhO6XZmmy2hZSOi1XTGAi8E34y4Qs9EcsYVG3dsDT+d6l
O/egs1AwwbcS1IJNzTXl/j6159E61nKk7MwBUCMIIueiPLKX5W/EwUtUBnfk7utT
NPyfisAP2LoCnUo3vsgV1FSfb/84KUofpnCsKv5+/kk9iOsCrbUoJQZ4VKSQ3Vg4
EOYX4AbUhHjkwdfB47lhLvxdujajVU8yA85+MTXoNlRRe7ltM6txArvcryG9HGE3
cxl897ztfepVLdPo/e+NUP9tUmsYhNo8JlZUMaoXFCRGx3XspHiLohc98HYGFeZb
SKwbcbSl99f6VJzDpK4/ftdhjlsDCHjbXlZOcnGoCxJ8o2WtQuxxbach1xeOmkQ3
dGFiN0Hfume2yuio3Zci3JxbgBtGSM/7zVGk6KS1bTCvDos7QolnWx3CeGqgnpz6
pYfu/yN8iWTRJNl/4eBh1kgblrrhcRjuv4VpQeMMYmyG5KQmSCoVVj9SWhLTC2Cx
pOitZ48pT2s+4i0aQ6IO4T1Nd+Vkuyl3MHUWzQDLGyoz/V+A1E1wItMD9QYSoE66
08cjr1ZxWItFdHxe/DO0
=kY+V
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
