Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:63221 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338Ab2FLFsS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jun 2012 01:48:18 -0400
Date: Tue, 12 Jun 2012 07:48:11 +0200
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
Subject: Re: [PATCH v2 09/10] ARM: tegra: harmony: Initialize PCIe from DT
Message-ID: <20120612054811.GB4040@avionic-0098.adnet.avionic-design.de>
References: <1339427118-32263-1-git-send-email-thierry.reding@avionic-design.de>
 <1339427118-32263-10-git-send-email-thierry.reding@avionic-design.de>
 <4FD6661A.1060407@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QKdGvSO+nmPlgiQ/"
In-Reply-To: <4FD6661A.1060407@wwwdotorg.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--QKdGvSO+nmPlgiQ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Stephen Warren wrote:
> On 06/11/2012 09:05 AM, Thierry Reding wrote:
> > With the device tree support in place, probe the PCIe controller from
> > the device tree and remove the corresponding workaround in the board
> > file.
>=20
> > diff --git a/arch/arm/boot/dts/tegra-harmony.dts b/arch/arm/boot/dts/te=
gra-harmony.dts
>=20
> > +	pci_vdd_reg: fixedregulator@0 {
>=20
> I think that'd usually just be "regulator@0".
>=20
> If you need the "@0" part to differentiate between multiple regulators,
> the node needs a reg property too:
>=20
> 	reg =3D <0 0>;
>=20
> although then I wonder about putting the regulator under the root node,
> since the address wouldn't really make sense...

Perhaps we should add a new "regulators" node under the root node to collect
this kind of regulators that don't fit anywhere else. Looking at the code,
something like this should work:

	/ {
		...

		regulators {
			compatible =3D "simple-bus";
			#address-cells =3D <1>;
			#size-cells =3D <0>;

			pci_vdd_reg: regulator@0 {
				reg =3D <0>;
			};
		};
	};

Thierry

--QKdGvSO+nmPlgiQ/
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk/W2BsACgkQZ+BJyKLjJp86AgCgsn2q8bEqIs31iBgl+n/BtA6C
Yw4AnRO5T0MrQ5q5xZyWCjnDgfZGsuyb
=JgXL
-----END PGP SIGNATURE-----

--QKdGvSO+nmPlgiQ/--
