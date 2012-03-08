Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:37966 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756680Ab2CHPR7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 8 Mar 2012 10:17:59 -0500
Date: Thu, 8 Mar 2012 15:17:56 +0000
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Thierry Reding <thierry.reding@avionic-design.de>
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
Message-ID: <20120308151756.GQ3638@opensource.wolfsonmicro.com>
References: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de>
 <1331218291-16119-6-git-send-email-thierry.reding@avionic-design.de>
 <20120308150607.GP3638@opensource.wolfsonmicro.com>
 <20120308151545.GA23934@avionic-0098.mockup.avionic-design.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9uazBBczf8QSjDPd"
In-Reply-To: <20120308151545.GA23934@avionic-0098.mockup.avionic-design.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--9uazBBczf8QSjDPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 08, 2012 at 04:15:46PM +0100, Thierry Reding wrote:
> * Mark Brown wrote:

> > ...they all seem to be explicitly named in the device tree so presumably
> > there's enough information in there for the driver to pick any set of
> > regulators in any order.  This would be much nicer to use.

> I don't like it much either. The only reason that requirement exists is
> because it makes the assignment of the regulator ID (as defined in the
> include/linux/mfd/tps6586x.h header) very trivial. Would it be better to
> look up the ID based on the node name (sm0 --> TPS6586X_ID_SM_0, ...)?

> Then the only requirement would be that the names match.

Yes, that's going to be more code but much nicer for users.

--9uazBBczf8QSjDPd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPWM1kAAoJEBus8iNuMP3dkAQP/j16XjeHv35gulMrsB3ONTWp
VY3yZBNVVvtMKdVrAvuiqGinegWy+nec+dkwXFHQXF6U5jbL4eAjdqjrvP1RJtTK
XldaiqlseOfM+LBUN8aVN/IMDJ1+/nhDwA1cJDkL4vys1/unpP2/whhOKehsoNcU
GtuTdsxYz7uqf92rOeXmPECgni6t3rU2CEl/6inFC3pjdx26ZST0bGtamFOjILlS
6hPgxFPfu3sMGg36++zZoP91fj8jn9gA0QejT0MC4/LmssQAubhQyXR+IOcwzL7Z
853uEMmpohJ0xdDUTNTboG0sSWrTP33thShR6JU/CXM4Poep8GmZOtysmnRJbuje
aJSq4SY9LeA3Mt23AvXqMY2qo4MeQHGGeAcIWR+02x+3mOCy8GkrSG2MIcB4b5K8
XCgUBG3y+sVj6u+gtYggDgcdSn7L3lkMN7XqZU+FYMXdJi2SP5pjshi908HTjLb7
KFKdVS9Rvg4+rU24ez+czIk5ylU1ek9NPXyne59QLe/aIyScNLZkyTCTSCQOSRyX
exCtTmVYCaeoppHxLv8xg8SAM/ZBHitHD8lngOCM8FNDhYvIcupLwCaf033axI84
+dpsP5XcfBeYKjL13jWXttBA6uTwafW1/2SEETaT28Laa2xp4c1gdMCvSJo1WoXk
ux2H6p/6pKifyfwEgIfr
=WOhL
-----END PGP SIGNATURE-----

--9uazBBczf8QSjDPd--
