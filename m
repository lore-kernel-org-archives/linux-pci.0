Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:36456 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754391AbcDMQWI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 Apr 2016 12:22:08 -0400
Date: Wed, 13 Apr 2016 18:22:03 +0200
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
Subject: Re: [PATCH 1/2] dt-bindings: pci: tegra: Update for per-lane PHYs
Message-ID: <20160413162203.GB30129@ulmo.ba.sec>
References: <1457452094-5409-1-git-send-email-thierry.reding@gmail.com>
 <56E98F2E.5010307@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uQr8t48UFsdbeI+V"
In-Reply-To: <56E98F2E.5010307@wwwdotorg.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 16, 2016 at 10:51:58AM -0600, Stephen Warren wrote:
> On 03/08/2016 08:48 AM, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > Changes to the pad controller device tree binding have required that
> > each lane be associated with a separate PHY.
>=20
> I still don't think this has anything to do with DT bindings. Rather, the
> definition of a PHY (in HW and the Linux PHY subsystem) is a single lane.
> That fact then requires drivers to support a PHY per lane rather than a
> single multi-lane PHY, and equally means the DT bindings must be written
> according to the correct definition of a PHY.
>=20
> Still, I suppose the commit description is fine as is.

I've reworded the commit message to give a more accurate rationale for
the change. I'll be posting a v5 soon.

> > Update the PCI host bridge
> > device tree binding to allow each root port to define the list of PHYs
> > required to drive the lanes associated with it.
>=20
> > diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.=
txt b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
>=20
> > +Required properties for Tegra124 and later:
> > +- phys: Must contain an phandle to a PHY for each entry in phy-names.
> > +- phy-names: Must include an entry for each active lane. Note that the=
 number
> > +  of entries does not have to (though usually will) be equal to the sp=
ecified
> > +  number of lanes in the nvidia,num-lanes property. Entries are of the=
 form
> > +  "pcie-N": where N ranges from 0 to the value specified in nvidia,num=
-lanes.
>=20
> When would the number of PHYs not equal the number of lanes? I thought the
> whole point of this patch was to switch to per-lane PHYs? Perhaps I'm just
> misremembering some exception, so there may be no need to change this.

This is useful to support the case where we want to connect a x1 or x2
device to a root port that is configured to drive more lanes. It's a
rather unusual configuration, but it would be possible for example to
have an onboard x1 ethernet card, but the board layout is such that it
runs in x1/x2 mode, with the ethernet card connected to the x2 port.

> >   Example:
> >=20
> >   SoC DTSI:
> > @@ -169,6 +179,9 @@ SoC DTSI:
> >   			ranges;
> >=20
> >   			nvidia,num-lanes =3D <2>;
> > +
> > +			phys =3D <&{/padctl@0,7009f000/pads/pcie/pcie-4}>;
> > +			phy-names =3D "pcie-0";
> >   		};
>=20
> The example shows a Tegra20 PCIe controller, yet includes
> Tegra124-or-greater properties. That seems a bit odd. Should the changes =
to
> the example be dropped, or does "Required properties for Tegra124 and lat=
er"
> mean "Required for T124+, optional for earlier chips"?

I've annotated these properties with "for Tegra124 and later", hopefully
that clarifies that these properties are only valid on Tegra124 and
later chips. The reason is that earlier (Tegra114 didn't support PCIe,
Tegra30 and Tegra20 did but had PHY registers within the PCI host bridge
I/O memory).

Thierry

--uQr8t48UFsdbeI+V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXDnIpAAoJEN0jrNd/PrOh3DkP/0FrpZYpnWHkE13hyrqEdfsr
HXbORfUCZVDdVjwgco3bhCzdW6lbJCk+mWECYtkqXG2mB1jvvQzSU/cpLVu75yyl
n2sCLEI2a+8SM6NpAOfzbDArvJU/BKUj+g7oPpFuzgkBti7vrRvYX0cf7Nj5ew3j
egFCZ96dyB56IZ7Xov+ztSBU00+rFsyvKydUvPpEQqebzXDJzTI68xEs3EcQe5iw
+vx3CHBGKPAN0Erz20lBlR2RuWqZFaDZpxVmrMU/3dA0Ef9V1vLtKAcdH+FOEfbU
EPkykV6fI3WcjShkZaQtRj+i/jpU3+Sgx4GShAaz+cadEavagVeBXeiZ80l5KkHz
t5rSaWZvofvB9Lnb9V5sM+AnOWWSiA48qyTm68MJzQ6w+EoXETLZtAw8CiF/3UhS
Fl1jptCOE5lqxJy1EKoVeHn+5LQ5LgKD84bSaBb9mm7gCs66FZzzHMTJprNkMhO6
ZZ62FImCzJdj2O2tuXqUc1qdUd6rXJ3C4GRFIRrX5svhrddBB8CAAV4a8cHoBUK4
XIfwKjZJwNm7uuCdlJOJ/zN4S2+7O9gBY4vPzJ/fza8bVHZ8QGYYgGlTqfcK0/IS
WbuTBdDw5b3xLQ1o1D19fMmySvUDjbsPd1r372MoXIuiPW8qM8Xwkp77DNkTpqKo
LPu3z6ajLousVnVNw4m2
=X1Xj
-----END PGP SIGNATURE-----

--uQr8t48UFsdbeI+V--
