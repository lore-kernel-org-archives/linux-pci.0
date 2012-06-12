Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:65485 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954Ab2FLGNg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jun 2012 02:13:36 -0400
Date: Tue, 12 Jun 2012 08:13:31 +0200
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: linux-tegra@vger.kernel.org,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v2 08/10] ARM: tegra: harmony: Initialize regulators from
 DT
Message-ID: <20120612061330.GD4040@avionic-0098.adnet.avionic-design.de>
References: <1339427118-32263-1-git-send-email-thierry.reding@avionic-design.de>
 <1339427118-32263-9-git-send-email-thierry.reding@avionic-design.de>
 <4FD664F8.4030800@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="osDK9TLjxFScVI/L"
In-Reply-To: <4FD664F8.4030800@wwwdotorg.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--osDK9TLjxFScVI/L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Stephen Warren wrote:
> On 06/11/2012 09:05 AM, Thierry Reding wrote:
> > Device tree support for the TPS6586x PMU used on Harmony has recently
> > been added. This commit adds the required device tree nodes to probe the
> > PMU from the device tree.
>=20
> > diff --git a/arch/arm/boot/dts/tegra-harmony.dts b/arch/arm/boot/dts/te=
gra-harmony.dts
>=20
> > +		tps6586x@34 {
> > +			compatible =3D "ti,tps6586x";
> > +			reg =3D <0x34>;
> > +			interrupts =3D <0 88 0x4>;
> > +
> > +			#gpio-cells =3D <2>;
> > +			gpio-controller;
> > +
> > +			regulators {
>=20
> Per the TPS65911 discussion on regulator bindings, this node should have:
>=20
> 	#address-cells =3D <1>;
> 	#size-cells =3D <0>;
>=20
> > +				sm0 {
>=20
> Each of these nodes should be named regulator@0, regulator@1, etc.
>=20
> Within each of these nodes, you need a matching reg property.
>=20
> 	reg =3D <0>;
>=20
> and something to identify which regulator within the chip this node
> configurations, although I don't think we've reached a final decision on
> the property name.
>=20
> See the the following for details:
>=20
> http://www.spinics.net/lists/linux-tegra/msg05577.html

Okay, I'll monitor that discussion and see what you end up with. I guess I'=
ll
have to update the tps6586x binding when that decision has been reached and
add a patch to this series.

Thierry

--osDK9TLjxFScVI/L
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk/W3goACgkQZ+BJyKLjJp/HvwCbBUNIsXdbmLGFH7H2zuK4qkzG
dIsAnjD0wUQ+UFgasmRNUJIzYEDVdNRt
=EmeK
-----END PGP SIGNATURE-----

--osDK9TLjxFScVI/L--
