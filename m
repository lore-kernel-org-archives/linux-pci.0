Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:61317 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756422Ab2CHPP4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 8 Mar 2012 10:15:56 -0500
Date: Thu, 8 Mar 2012 16:15:46 +0100
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-tegra@vger.kernel.org, Liam Girdwood <lrg@ti.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 05/11] tps6586x: Add device-tree support
Message-ID: <20120308151545.GA23934@avionic-0098.mockup.avionic-design.de>
References: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de>
 <1331218291-16119-6-git-send-email-thierry.reding@avionic-design.de>
 <20120308150607.GP3638@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
In-Reply-To: <20120308150607.GP3638@opensource.wolfsonmicro.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Mark Brown wrote:
> On Thu, Mar 08, 2012 at 03:51:25PM +0100, Thierry Reding wrote:
>=20
> > +- gpio-controller: mark the device as a GPIO controller
> > +- regulators: list of regulators provided by this controller, must be =
in the
> > +  following order:
> > +    SM0, SM1, SM2, LDO0, LDO1, LDO2, LDO3, LDO4, LDO5, LDO6, LDO7, LDO=
8, LDO9
>=20
> This ordering requirement is fairly sad, if there are unused regulators
> they still need to be listed even though...
>=20
> > +			sm0_reg: sm0 {
> > +				regulator-min-microvolt =3D < 725000>;
> > +				regulator-max-microvolt =3D <1500000>;
> > +				regulator-boot-on;
> > +				regulator-always-on;
> > +			};
> > +
> > +			sm1_reg: sm1 {
>=20
> ...they all seem to be explicitly named in the device tree so presumably
> there's enough information in there for the driver to pick any set of
> regulators in any order.  This would be much nicer to use.

I don't like it much either. The only reason that requirement exists is
because it makes the assignment of the regulator ID (as defined in the
include/linux/mfd/tps6586x.h header) very trivial. Would it be better to
look up the ID based on the node name (sm0 --> TPS6586X_ID_SM_0, ...)?

Then the only requirement would be that the names match.

Thierry

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk9YzSEACgkQZ+BJyKLjJp9GeQCcD3Z6QXhg+wzIrceicGsT9WQm
2goAn2GRlFv1JP3R4lJoVr93UIaXkvmX
=AneN
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
