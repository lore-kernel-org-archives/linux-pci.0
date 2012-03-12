Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:54999 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751885Ab2CLORK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 12 Mar 2012 10:17:10 -0400
Date: Mon, 12 Mar 2012 15:17:05 +0100
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Liam Girdwood <lrg@ti.com>,
	Russell King <linux@arm.linux.org.uk>,
	linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	Rob Herring <rob.herring@calxeda.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Olof Johansson <olof@lixom.net>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Colin Cross <ccross@android.com>, linux-tegra@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 11/11] ARM: tegra: pcie: Add device tree support
Message-ID: <20120312141705.GA16395@avionic-0098.mockup.avionic-design.de>
References: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de>
 <1331218291-16119-12-git-send-email-thierry.reding@avionic-design.de>
 <4F59253D.7070100@wwwdotorg.org>
 <20120312120610.GA14020@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
In-Reply-To: <20120312120610.GA14020@sirena.org.uk>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Mark Brown wrote:
> On Thu, Mar 08, 2012 at 02:31:41PM -0700, Stephen Warren wrote:
> > On 03/08/2012 07:51 AM, Thierry Reding wrote:
>=20
> > > +- vdd-supply: power supply for controller (1.05V)
>=20
> > Should those *-supply properties really be optional? I got the
> > impression talking to Mark in a different thread that all regulators
> > should exist, although their implementation may be via a fixed
> > regulator, with no GPIO, as determined by the board design.
>=20
> Depends on the electronics, if the device can function without a supply
> then it is OK for it to be optional.  This is moderately unusual but not
> unknown.  It's obviously also OK to omit the supply if the system
> doesn't use software regulators at all, though a kernel with regulator
> support enabled would need to use dummy regulators to stub things out.

The PCIe controller actually needs those supplies and won't work without
them. However on TrimSlice both of these supplies seem to be hardwired and
always on. At least that's what I deduce from the code because there is no
code that enables either the 1.05V or the pex-clk supplies.

My understanding of the fixed regulator was that it was meant to be used for
fixed voltage supplies that can still be enabled or disabled (for example as
supplied by a GPIO) but not regulators that are fix in the sense that they
cannot be enabled or disabled at all but are always on.

Then again, the fixed regulator binding says that the gpio property is
optional, so perhaps doing something like the following will work:

	pex_clk_reg: fixedregulator@0 {
		compatible =3D "regulator-fixed";
		regulator-name =3D "PCIE CLK";
		regulator-min-microvolt =3D <3300000>;
		regulator-max-microvolt =3D <3300000>;
		regulator-always-on;
	};

	pcie_reg: fixedregulator@1 {
		compatible =3D "regulator-fixed";
		regulator-name =3D "PCIE VDD";
		regulator-min-microvolt =3D <1050000>;
		regulator-max-microvolt =3D <1050000>;
		regulator-always-on;
	};

Is that how it is supposed to work?

Thierry

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk9eBWEACgkQZ+BJyKLjJp+X5ACbBB/dOq1D5GnTAN4XS7SXKpvA
1ikAn05C46XDZYeV0tCQtPuhHMdnwz6x
=LV1A
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
