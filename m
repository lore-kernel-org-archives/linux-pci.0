Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:58202 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751662Ab2CLOXn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 12 Mar 2012 10:23:43 -0400
Date: Mon, 12 Mar 2012 14:23:40 +0000
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Thierry Reding <thierry.reding@avionic-design.de>
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
Message-ID: <20120312142340.GI3110@opensource.wolfsonmicro.com>
References: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de>
 <1331218291-16119-12-git-send-email-thierry.reding@avionic-design.de>
 <4F59253D.7070100@wwwdotorg.org>
 <20120312120610.GA14020@sirena.org.uk>
 <20120312141705.GA16395@avionic-0098.mockup.avionic-design.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TA4f0niHM6tHt3xR"
In-Reply-To: <20120312141705.GA16395@avionic-0098.mockup.avionic-design.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--TA4f0niHM6tHt3xR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 12, 2012 at 03:17:05PM +0100, Thierry Reding wrote:

> My understanding of the fixed regulator was that it was meant to be used for
> fixed voltage supplies that can still be enabled or disabled (for example as
> supplied by a GPIO) but not regulators that are fix in the sense that they
> cannot be enabled or disabled at all but are always on.

No, not at all.  It's for any random supply that doesn't have much
meaningful control - as you'll see from the code the GPIO is totally
optional if you look at the git history you'll see that the GPIO was
added some time after the driver was originally merged.

> Is that how it is supposed to work?

Yes.

--TA4f0niHM6tHt3xR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPXgYPAAoJEBus8iNuMP3d8E0P/jleMyX8Gqwn6J+hGrS3tFuh
7C6sGsNl/EQSogDYK08yhx222WPkZAhYUMqHjhGOHQjvhbzPFSz8TmjE9hVDnO0T
oxqG6PPNXbr4DEuVoEYbZIhVC4vdBUVkv/Vb1aoFWf0LjT6hc5SUhat1MvVuzky0
auhDGBqlV+IVCFRLxww7t2CGwOdSsvkSS7e/rjoA3XelX4O2xJmVcGJbZ6LjsW4y
U0xu43SpBZgSz5fMB4UiOhWitUcmLstqyUh7yXdQ3NcNXdJyFLEi5uRB/N17TM11
jN88O+iDCN2TrMMf1lFekklymtKkubB85JCGNwbCaH8DzKBW1NM6a8hgKHuJy5dJ
exrd1O7w+fUwgJe70Zl8hTIQFbAJWUDhJeIc87f+gHRk0ANUnQFqbC6hjMv+KiAW
T91y9lKjIMURmLU6Qii6P4ZGsqpSp81Kz7axfFhxBl2QIS8YnW8AHVvVTGZYxduh
5imnXHrYwRrQo2hR4/3gZZ1hlX0pawAB6m4wpD85FAhDONkvW21vshbfQATuWysL
UFCv4Eex8mz4Hs1wbO37pgfYm5oJNReTy8c9pefjqF0wITz3f9gPEcXjzaY2kLGt
6Mk0TKeK+9Ep3iwPuU1Mt8jOh0xbacJlHqyNZaCOq1/SHqts9E6ncs4X5+EAtppd
qb8Ff8kmExx0ly+vwhaC
=CTpH
-----END PGP SIGNATURE-----

--TA4f0niHM6tHt3xR--
