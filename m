Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:36178 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932196AbcDNP05 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 14 Apr 2016 11:26:57 -0400
Date: Thu, 14 Apr 2016 17:26:52 +0200
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
Message-ID: <20160414152652.GA3366@ulmo.ba.sec>
References: <1457452094-5409-1-git-send-email-thierry.reding@gmail.com>
 <1457452094-5409-2-git-send-email-thierry.reding@gmail.com>
 <56E9915F.9040608@wwwdotorg.org>
 <20160413160112.GA30129@ulmo.ba.sec>
 <570E7B86.1040909@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
In-Reply-To: <570E7B86.1040909@wwwdotorg.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 13, 2016 at 11:01:58AM -0600, Stephen Warren wrote:
> On 04/13/2016 10:01 AM, Thierry Reding wrote:
> > On Wed, Mar 16, 2016 at 11:01:19AM -0600, Stephen Warren wrote:
> > > On 03/08/2016 08:48 AM, Thierry Reding wrote:
> > > > From: Thierry Reding <treding@nvidia.com>
> > > >=20
> > > > The current XUSB pad controller bindings are insufficient to descri=
be
> > > > PHY devices attached to USB controllers. New bindings have been cre=
ated
> > > > to overcome these restrictions. As a side-effect each root port now=
 is
> > > > assigned a set of PHY devices, one for each lane associated with the
> > > > root port. This has the benefit of allowing fine-grained control of=
 the
> > > > power management for each lane.
> > >=20
> > > > diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-te=
gra.c
> > >=20
> > > > +static int tegra_pcie_port_phy_power_on(struct tegra_pcie_port *po=
rt)
> > > > +{
> > > > +	struct device *dev =3D port->pcie->dev;
> > > > +	unsigned int i;
> > > > +	int err;
> > > > +
> > > > +	for (i =3D 0; i < port->lanes; i++) {
> > > > +		err =3D phy_power_on(port->phys[i]);
> > >=20
> > > This assume the number of array entries is precisely the number of la=
nes.
> > > That seems to contradict the binding update which said the number mig=
ht not
> > > match. Perhaps there's an expectation that phy_power_on() is a no-op =
for
> > > some "invalid" values like NULL or an error-pointer value? But...
> > >=20
> > > > +static struct phy *devm_of_phy_optional_get_index(struct device *d=
ev,
> > > > +						  struct device_node *np,
> > > > +						  const char *consumer,
> > > > +						  unsigned int index)
> > > > +{
> > > > +	struct phy *phy;
> > > > +	char *name;
> > > > +
> > > > +	name =3D kasprintf(GFP_KERNEL, "%s-%u", consumer, index);
> > > > +	if (!name)
> > > > +		return ERR_PTR(-ENOMEM);
> > > > +
> > > > +	phy =3D devm_of_phy_get(dev, np, name);
> > > > +	kfree(name);
> > > > +
> > > > +	if (IS_ERR(phy) && PTR_ERR(phy) =3D=3D -ENODEV)
> > > > +		phy =3D NULL;
> > > > +
> > > > +	return phy;
> > > > +}
> > >=20
> > > The error-handling there looks wrong. The function generally returns =
either
> > > a valid PHY or an error pointer. However, in the case of -ENODEV, NUL=
L is
> > > returned. Subsystems are supposed to encode their handles as, and fun=
ctions
> > > are supposed to return, either NULL or an error pointer for error cas=
es, not
> > > both/either. Is the PHY API broken in this regard? If so, then this c=
ode is
> > > fine, but if not it might need a fix.
> >=20
> > This function mimics phy_optional_get() which similarily returns NULL
> > for -ENODEV. The remainder of the PHY API treats NULL pointers as
> > "dummy" PHYs and returns early. I think that's a sensible approach to
> > handling optional resources.
> >=20
> > It might have been more obvious had I implemented this function within
> > phy-core.c, but I didn't think it universally useful because it uses a
> > rather uncommon lookup pattern. I did keep a generic name in case it's
> > ever deemed useful outside of this driver, at which point it could
> > simply be moved into phy-core.c without requiring this driver to
> > change.
>=20
> Ah OK, so if a caller of this function is expected to only use IS_ERR(), =
and
> hence treat NULL as a perfectly valid PHY value, and all the PHY APIs deal
> with NULL correctly, then this is probably OK.

I think it's not completely consistently used, but at least the public
API that we do use has the necessary guards, so we should be fine.

Thierry

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXD7a4AAoJEN0jrNd/PrOhGrwP/A9qDrlbO+2Bll2adS3SGlsa
w1AXkVIMZ/ei9Rzdol2m8nsQza4Hd3ez6InBbU+G49HrjrmDhz+4E9hAQWaPykgv
yzHr9g1p6FmMtbWf45eTAvAurkIcOSIEm7KgV2tgUpzfxzsbwVEOx+y2kvzcpKqy
1ML3H0COa4NbbuH031UB1TLIGXG+GacrxPpgG0uiU6Mo4ioz+1BNv6PYjtzPiLSc
X6nk8julCUcwHMXHKEWFytsA6zaLVJyYd5TbtGUEZxV+tJSHfobXnTyyjqcJpSKK
Q66WFhDVXktyM+WD59gEeUqHgCfgMmBaHySPXecEcKOTr3VbEninazjzDXiEAKaw
JfleVggQXaX0LMP+uD8AK3iF9Eh2RNvRYd+CjenPxW/IXuQdPWR3w/Rwpj/XDTyu
xFD61wxzsqj7XeQ3MIcR8ix2vFaaXfyy6pXdB0AAz/AWl1bYv0txSo2CW0Y0NAMC
llPgpeHxsu5wUCjldb6NRBVGviTrtboaA2/+YjzR7+65tTNWy7td/R5JBqGbwAQr
+TpT5HBp7LR4uhklW5GRccdK35KlUjZ3AdOee6pjeFlPP/43eMRm8d+fTAUStiJ0
W6ePZjnHE73vTn00fCnPIUS+ogJAK2coMc/AyTIBUouXywewPvVw4YdAZRZlKEZ8
Y45LBdN4t/Z6vnfKDJhX
=43Ah
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
