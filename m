Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:53647 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753839Ab2CHPpH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 8 Mar 2012 10:45:07 -0500
Date: Thu, 8 Mar 2012 16:45:03 +0100
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
Message-ID: <20120308154502.GA4617@avionic-0098.mockup.avionic-design.de>
References: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de>
 <1331218291-16119-6-git-send-email-thierry.reding@avionic-design.de>
 <20120308150607.GP3638@opensource.wolfsonmicro.com>
 <20120308151545.GA23934@avionic-0098.mockup.avionic-design.de>
 <20120308151756.GQ3638@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
In-Reply-To: <20120308151756.GQ3638@opensource.wolfsonmicro.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Mark Brown wrote:
> On Thu, Mar 08, 2012 at 04:15:46PM +0100, Thierry Reding wrote:
> > * Mark Brown wrote:
>=20
> > > ...they all seem to be explicitly named in the device tree so presuma=
bly
> > > there's enough information in there for the driver to pick any set of
> > > regulators in any order.  This would be much nicer to use.
>=20
> > I don't like it much either. The only reason that requirement exists is
> > because it makes the assignment of the regulator ID (as defined in the
> > include/linux/mfd/tps6586x.h header) very trivial. Would it be better to
> > look up the ID based on the node name (sm0 --> TPS6586X_ID_SM_0, ...)?
>=20
> > Then the only requirement would be that the names match.
>=20
> Yes, that's going to be more code but much nicer for users.

Okay, I'll add that for the next round.

Thierry

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk9Y0/4ACgkQZ+BJyKLjJp/XWACfSbtn+4tz2T6Ecd04OpaxGvGO
7KgAoIkY9l7mkfZBVXw9wM5y8bPWcz6l
=e97C
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
