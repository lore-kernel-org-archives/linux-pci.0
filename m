Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:57488 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754075Ab2CLO3Z (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 12 Mar 2012 10:29:25 -0400
Date: Mon, 12 Mar 2012 15:28:58 +0100
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
Message-ID: <20120312142857.GA6694@avionic-0098.mockup.avionic-design.de>
References: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de>
 <1331218291-16119-12-git-send-email-thierry.reding@avionic-design.de>
 <4F59253D.7070100@wwwdotorg.org>
 <20120312120610.GA14020@sirena.org.uk>
 <20120312141705.GA16395@avionic-0098.mockup.avionic-design.de>
 <20120312142340.GI3110@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
In-Reply-To: <20120312142340.GI3110@opensource.wolfsonmicro.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Mark Brown wrote:
> On Mon, Mar 12, 2012 at 03:17:05PM +0100, Thierry Reding wrote:
>=20
> > My understanding of the fixed regulator was that it was meant to be use=
d for
> > fixed voltage supplies that can still be enabled or disabled (for examp=
le as
> > supplied by a GPIO) but not regulators that are fix in the sense that t=
hey
> > cannot be enabled or disabled at all but are always on.
>=20
> No, not at all.  It's for any random supply that doesn't have much
> meaningful control - as you'll see from the code the GPIO is totally
> optional if you look at the git history you'll see that the GPIO was
> added some time after the driver was originally merged.
>=20
> > Is that how it is supposed to work?
>=20
> Yes.

In that case I'll mark the *-supply properties required. Would it be a good
idea to mention this (or even give an example with fixed regulators) in the
binding documentation or can I assume this to be common knowledge?

Thierry

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk9eCCkACgkQZ+BJyKLjJp9I1ACgiMzqgAdYjfb+BL10fzPhkzop
EqkAn3JIOG3z+7homikIN0PSCRHrOtnv
=J/oZ
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
