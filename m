Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:41536 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751879Ab2CKM6F (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 11 Mar 2012 08:58:05 -0400
Date: Sun, 11 Mar 2012 12:58:00 +0000
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
Subject: Re: [PATCH 03/11] regulator: fixed: Support driver probe deferral
Message-ID: <20120311125759.GH3233@opensource.wolfsonmicro.com>
References: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de>
 <1331218291-16119-4-git-send-email-thierry.reding@avionic-design.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Enx9fNJ0XV5HaWRu"
In-Reply-To: <1331218291-16119-4-git-send-email-thierry.reding@avionic-design.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--Enx9fNJ0XV5HaWRu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 08, 2012 at 03:51:23PM +0100, Thierry Reding wrote:
> If the specified GPIO is not found, return -EPROBE_DEFER. This will
> cause the driver to be probed again later when the required GPIO may
> have become available.

Might be worth pushing this into gpiolib?  It seems like wanting to
defer if a GPIO is not found will be the overwhelmingly common case
given that the GPIO numbers need to be explicitly specified.

--Enx9fNJ0XV5HaWRu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPXKFQAAoJEBus8iNuMP3dz7AP/3Dk+fPk0N59gRitOBUApI78
OjAmynj4JG0OeDs+5u0VsDOn7Xc8KlaXgTQ7T+q1PW98dM/frOoRdZ/g1/KoNCkE
c0hEIcAzDVE3LrLhgGPBTGxYK5lGW9E/wJw0b3ARzS1bd28fNHqn9Be2gTafEIlx
N7y4cR0Y0huUAw3UyJacism1L7jQsT1q5S7SfHmQpWP/Nf1DRWNWzvH54IHQFxKn
PiFf19lZLr38s1GXL0ucUSnYB8thX1aNn8/Xnj4K9lipzMMFDmmEhS7DQakPvh8P
DRYrh92THwczX+X9YSnAEr3Pmkr8hPbajK+vitnZUg+bosLYJdMaNOtOzBLZWoN8
Qt/8/hs9AevUhIoAH+4AHDO2UmVy5UVabWdVfaJTYG9eujhbkehNGMIVb+cJZ/nG
QPWNsUVXEyA8+BT3kUd4Rv7S5K5pmjqcwTE8M1NZEmeYVVHlNeBVpL/z7uNaYXhA
Fo07eo+/sooprGNwoQyZsbb3g0Rmz/zzqLir9OWnuD9VsgSeqHzcyKpSEg/sYZDN
oWbs6VshCZ6BLCRp3WkiHcDITabnhKityzyl9tpS65vnVSq5cRpKIuM6X3VSTl4R
zSTbtXf8siIV/08sNKjDcVVXVuS0MqUoOZrk1b7v6kewRp2yw2nuab8TplQ2eBrx
MYMuv8Siqqqdn55xx7Yf
=f9Aw
-----END PGP SIGNATURE-----

--Enx9fNJ0XV5HaWRu--
