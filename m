Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:33366 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752404AbcDKL06 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 11 Apr 2016 07:26:58 -0400
Date: Mon, 11 Apr 2016 13:26:54 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: pci: tegra: Update for per-lane PHYs
Message-ID: <20160411112654.GC17743@ulmo.ba.sec>
References: <1460131994-24493-1-git-send-email-thierry.reding@gmail.com>
 <20160408191142.GD15034@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xesSdrSSBC0PokLI"
In-Reply-To: <20160408191142.GD15034@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--xesSdrSSBC0PokLI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 08, 2016 at 02:11:42PM -0500, Bjorn Helgaas wrote:
> Hi Thierry,
>=20
> I have a couple more questions, probably just because I'm
> DT-illiterate.
>=20
> On Fri, Apr 08, 2016 at 06:13:13PM +0200, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > Changes to the pad controller device tree binding have required that
> > each lane be associated with a separate PHY. Update the PCI host bridge
> > device tree binding to allow each root port to define the list of PHYs
> > required to drive the lanes associated with it.
> >=20
> > Acked-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> > Changes in v4:
> > - add additional lanes subnode when dereferencing PHYs from the XUSB pad
> >   controller to reflect changes in its binding
> >=20
> >  .../devicetree/bindings/pci/nvidia,tegra20-pcie.txt    | 18 ++++++++++=
+++++++-
> >  1 file changed, 17 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.=
txt b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
> > index 75321ae23c08..f5364084b494 100644
> > --- a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
> > +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
> > @@ -60,11 +60,14 @@ Required properties:
> >    - afi
> >    - pcie_x
> > =20
> > -Required properties on Tegra124 and later:
> > +Required properties on Tegra124 and later (deprecated):
> >  - phys: Must contain an entry for each entry in phy-names.
> >  - phy-names: Must include the following entries:
> >    - pcie
> > =20
> > +These properties are deprecated in favour of per-lane PHYs define in e=
ach of
> > +the root ports (see below).
> > +
> >  Power supplies for Tegra20:
> >  - avdd-pex-supply: Power supply for analog PCIe logic. Must supply 1.0=
5 V.
> >  - vdd-pex-supply: Power supply for digital PCIe I/O. Must supply 1.05 =
V.
> > @@ -122,6 +125,13 @@ Required properties:
> >    - Root port 0 uses 4 lanes, root port 1 is unused.
> >    - Both root ports use 2 lanes.
> > =20
> > +Required properties for Tegra124 and later:
>=20
> I had a little trouble disambiguating this from the "Required
> properties on Tegra124 and later (deprecated)" line above.  It might
> help if they said:
>=20
>   Required PCIe controller properties on Tegra124 and later (deprecated):
>   Required PCIe Root Port properties for Tegra124 and later:

That's kind of implied by the structure of the binding. The first is in
the section dedicated to the description of the host bridge controller,
whereas the second in in the section for root port properties. Granted,
the format for device tree bindings isn't very rich, so this isn't very
easy to spot. Perhaps something like this could help:

	NVIDIA Tegra PCIe controller

	The top-level device tree node describes the host bridge
	controller and properties listed therein apply to the controller
	as a whole.

	Required properties:
	...

	Root Ports:
	-----------

	Root ports are defined as subnodes of the PCIe controller node.

	Required properties:
	...

Would that help clarify?

> I'm not sure how to interpret the "deprecated" part.  Assume I'm
> writing a DTS.  What am I supposed to include?
>=20
>   - "phys" and "phy-names" under the PCIe controller *and*
>     "phys" and "phy-names" under the Root Port?
>=20
>   - "phys" and "phy-names" under the PCIe controller only if I don't
>     supply "phys" and "phy-names" under the Root Port?
>=20
> My guess is that a board with more than one PHY for PCIe should omit
> "phys" and "phy-names" under the PCIe controller and include them
> under each Root Port.  And a board with only one PHY could conceivably
> supply these properties either under the controller or the Root Port
> or both.

Whatever is marked as deprecated should not be used in new bindings at
all. That is, new board files should move to per-lane PHYs, no matter
how many lanes they enable.

The XUSB pad controller that provides these PHYs can be driven by two
different drivers: a pinctrl driver that exposes a single PHY for all
PCI lanes (it uses per-lane nvidia,iddq properties to enable or disable
each of the lanes) or a PHY driver that exposes one PHY per lane. Each
PHY can separately be powered on.

Perhaps a better approach would be to simply remove the deprecated
properties to avoid any possible confusion. It does have the drawback
that old device trees won't have a documentation counterpart.

> > +- phys: Must contain an phandle to a PHY for each entry in phy-names.
> > +- phy-names: Must include an entry for each active lane. Note that the=
 number
> > +  of entries does not have to (though usually will) be equal to the sp=
ecified
> > +  number of lanes in the nvidia,num-lanes property. Entries are of the=
 form
> > +  "pcie-N": where N ranges from 0 to the value specified in nvidia,num=
-lanes.
> > +
> >  Example:
> > =20
> >  SoC DTSI:
> > @@ -169,6 +179,9 @@ SoC DTSI:
> >  			ranges;
> > =20
> >  			nvidia,num-lanes =3D <2>;
> > +
> > +			phys =3D <&{/padctl@0,7009f000/pads/pcie/lanes/pcie-4}>;
> > +			phy-names =3D "pcie-0";
>=20
> I'm also a little confused here because it looks like this root port
> supports two lanes, but there's only one entry in phy-names.  I
> thought you needed one entry for each lane.

Not necessarily. I'm not sure if the wording in the description makes it
clear, but there are a limited number of configurations that the root
ports support. However the ports may not want (or need) to drive all of
the lanes that they support. Consider for example one possible
configuration on Tegra124, which is to have one root port operate in x1
mode and the other in x2 mode. The x2 port may have a fixed card wired
to it (onboard) that is x1. Enabling the second lane would be wasting
power because it is never used.

Thierry

--xesSdrSSBC0PokLI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXC4n8AAoJEN0jrNd/PrOhXeAQAIe4gUVQYHGxjT3iqqfW11bk
1j4nxgPbW34aL48Ar7Yub4e3BcpMkvXhy0r3syBCRnDkRANrIxWdIQAZXeu8G6s5
uFksh2m0/VmfEbDfSf5lHWewYtW3Zb1wEjaGBCPqgXcC3XgYel/GMykxs4pCBU5p
eXLzigKPwUusx4mrgtYsafINBAtG5hyZVNtsAHjnW+0UUCn/UHYhFynN6aBxZzJH
E/BjUKdL91gcv2+ypeIyvDXG60Su1lU2sCaeK1hwBO5NAJpseyureKTvGOaZasr7
fOdSV344aZTzyc672QEMevDc+KnE3AJO4BHrMFQgVANavH3tCRm0BpBixo0mhEaH
DSKqElQSH17f+mRkPo7XNEkT2Cv1vIr+X1uKiPiPzEr/nAqJ0gG+LIRaTEIcS6x9
SkOzrhbnIIrYZYd9lJrU6wz6L1G9WBV5lanQRro6+VjTLYiej+w5O9vkkWk+aw1A
ubV93mpOZLcH2b9dAFHaCABqlpPIWrcwJnE8RNmu5osz2ctCl/8mY6vbBQwZeqsr
xOppeXj1qYdK7Pe/L55J12g+ni+ZLAq/4+xBHNAtVGWUxpXFBFyvUTA8ej3hqGCH
foyVpn2ois+8iK47p2Cn/3WRDyegl7BanZY4k3nn4q3eDh7EJ3TbQ1lHDBwEwcX8
0JLvRW0GlbxV7axkrc5w
=40DO
-----END PGP SIGNATURE-----

--xesSdrSSBC0PokLI--
