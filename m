Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:51187 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752150Ab2CIHyA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 9 Mar 2012 02:54:00 -0500
Date: Fri, 9 Mar 2012 08:53:47 +0100
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>,
	linux-tegra@vger.kernel.org, Liam Girdwood <lrg@ti.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-pci@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 05/11] tps6586x: Add device-tree support
Message-ID: <20120309075347.GA27270@avionic-0098.mockup.avionic-design.de>
References: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de>
 <1331218291-16119-6-git-send-email-thierry.reding@avionic-design.de>
 <20120308150607.GP3638@opensource.wolfsonmicro.com>
 <20120308151545.GA23934@avionic-0098.mockup.avionic-design.de>
 <20120309051506.761B63E090F@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
In-Reply-To: <20120309051506.761B63E090F@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Grant Likely wrote:
> On Thu, 8 Mar 2012 16:15:46 +0100, Thierry Reding <thierry.reding@avionic=
-design.de> wrote:
> > * Mark Brown wrote:
> > > ...they all seem to be explicitly named in the device tree so presuma=
bly
> > > there's enough information in there for the driver to pick any set of
> > > regulators in any order.  This would be much nicer to use.
> >=20
> > I don't like it much either. The only reason that requirement exists is
> > because it makes the assignment of the regulator ID (as defined in the
> > include/linux/mfd/tps6586x.h header) very trivial. Would it be better to
> > look up the ID based on the node name (sm0 --> TPS6586X_ID_SM_0, ...)?
> >=20
> > Then the only requirement would be that the names match.
>=20
> Yes, please look up id via name.  Alternately you can give each child node
> a 'reg' property and put #address-cells =3D <1>; #size-cells =3D <0>; in =
the
> parent (assuming the regulator number is a documented attribute of the
> hardware and not just a convenient linux construct).

I'll go with the lookup via name then because as far as I can tell the
datasheet doesn't list any specific ordering of the regulators.

Thierry

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk9ZtwsACgkQZ+BJyKLjJp/izwCfVM7Tst3EVFGbwVsUtkFh7OXm
vloAoLAdqyysfycOnJE3uK0rbfRIDUZ5
=NxOj
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
