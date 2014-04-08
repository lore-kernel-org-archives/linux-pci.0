Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:13150 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757629AbaDHT4c (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 Apr 2014 15:56:32 -0400
Date: Tue, 8 Apr 2014 21:55:37 +0200
From: Thierry Reding <treding@nvidia.com>
To: Stephen Warren <swarren@wwwdotorg.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC 3/5] PCI: tegra: Implement accurate power supply scheme
Message-ID: <20140408195537.GC21978@ulmo.nvidia.com>
References: <1396622969-17837-1-git-send-email-treding@nvidia.com>
 <1396622969-17837-4-git-send-email-treding@nvidia.com>
 <53444C19.2080904@wwwdotorg.org>
MIME-Version: 1.0
In-Reply-To: <53444C19.2080904@wwwdotorg.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="32u276st3Jlj2kUU"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--32u276st3Jlj2kUU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 08, 2014 at 09:20:57PM +0200, Stephen Warren wrote:
> On 04/04/2014 08:49 AM, Thierry Reding wrote:
> > The current description of power supplies doesn't match the hardware.
> > Instead it's designed to support the needs of current designs, which
> > will break as soon as a new design appears that cannot be described
> > using the current assumptions.
> >=20
> > In order to fully support all possible future designs, all power supply
> > inputs to the PCIe block need to be accurately described and separately
> > configurable.
>=20
> > diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
>=20
> > @@ -930,23 +927,9 @@ static void tegra_pcie_power_off(struct tegra_pcie=
 *pcie)
>=20
> > -	err =3D regulator_disable(pcie->pex_clk_supply);
> > +	err =3D regulator_bulk_disable(pcie->num_supplies, pcie->supplies);
> >  	if (err < 0)
> > -		dev_warn(pcie->dev, "failed to disable pex-clk regulator: %d\n",
> > -			 err);
> > -
> > -	err =3D regulator_disable(pcie->vdd_supply);
> > -	if (err < 0)
> > -		dev_warn(pcie->dev, "failed to disable VDD regulator: %d\n",
> > -			 err);
> > +		dev_warn(pcie->dev, "failed to enable regulators: %d\n", err);
>=20
> s/enable/disable/

Good catch. Fixed, thanks,

Thierry

--32u276st3Jlj2kUU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTRFQ5AAoJEN0jrNd/PrOhq4YP+gOJ1njoXiHxeRfcapNvy8zz
NafqHrO3jPZbCSQ6H54LsYl7hDxZ6AnoGaBA4XL+MvqOC22pPJVE2THZ9NJpEg3c
sNkT3QK4qTygtG6jZ0HkusVkbplV1X9sPo6HkMNpX+XVH+gC3JIC0NcZk8IqWXrV
FPcvzPJYEWmulVirTdpBO7DOZQ6fhOmARzX4p7Ssj7xP2BZ7pNnRFyraOCOtyNQR
/hK58lekkviXGf00bk+1WNYWH5Sz8IpvwBVWmFUaP780dm2s5T0VOPyeHJPGnJfd
zZeQ7rz3hdZruJxzHW/HmKfvwP1XEh3QkTnks1tPb6TukJyAMI2AUMj2KXBAJzgQ
ZzTnu2hJ7qL32GgaHGTT28+YJVpUrCwnIRSSGAMg4tZBOAmmGf7Y3xmd3hh4Er52
QzNPez384+kTGarGqGpr+7tXlOH+oKF25+l5ahPcTXlzSn9WcbxmX3x8QS5Q4h/e
694yrVxXf+hdWAJ8Kr4uE+GJ4xVBNE6xODoj8yRlRrcB924GBM2YiMTpRmeOk2YE
izh3ihpmgiH5XdZllAjZhnDLwCAmCCAwSGclCXdPyXr6B1gEo4f+uIwgAp6RjXIx
TGWvrNYAbFGCjaG8OqAG12XqE8KfS5wbQTi7uun2zDqim9yxJAOBMr8BfSrMRbCp
/oaeIGZSkoiHRabzJIxZ
=FcyA
-----END PGP SIGNATURE-----

--32u276st3Jlj2kUU--
