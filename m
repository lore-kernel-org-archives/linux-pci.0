Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:41165 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751000AbaIFKzV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sat, 6 Sep 2014 06:55:21 -0400
Message-ID: <1410000919.2460.50.camel@jtkirshe-mobl>
Subject: Re: [PATCH] pci: Parenthesize parameters in PCI_DEVID and
 PCI_VPD_LRDT_ID macros
From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
To: bhelgaas@google.com
Cc: Megan Kamiya <megan.a.kamiya@intel.com>, linux-pci@vger.kernel.org
Date: Sat, 06 Sep 2014 03:55:19 -0700
In-Reply-To: <1410000596-24190-1-git-send-email-jeffrey.t.kirsher@intel.com>
References: <1410000596-24190-1-git-send-email-jeffrey.t.kirsher@intel.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-L+VAKdwo7L9V1SkruJcC"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--=-L+VAKdwo7L9V1SkruJcC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2014-09-06 at 03:49 -0700, Jeff Kirsher wrote:
> From: Megan Kamiya <megan.a.kamiya@intel.com>
>=20
> Add parentheses around parameters in PCI_DEVID and PCI_VPD_LRDT_ID
> macros to prevent possible expansion errors as described by the CERT
> Secure Coding Standard: PRE01-C: Use parentheses within macros around
> parameter names
>=20
> Signed-off-by: Megan Kamiya <megan.a.kamiya@intel.com>
> Tested-by: Aaron Brown <aaron.f.brown@intel.com>
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> ---
>  include/linux/pci.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Sorry for the duplicate, I did not mean to send this out a second time.

--=-L+VAKdwo7L9V1SkruJcC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJUCugXAAoJEOVv75VaS+3OCrEP/3kg9UwU8qC9blDiwPgkzyJs
Za+GR1Lf2pEaPEYT0NJA6RT35BciA9wV11Xsj302yIyNKnquLGAqzpuPeB1Ny/7k
tBT7mxGfdK9LWY1MrkdsQjc/IoTYmDEodH5AYFvDd5du6+Yj/jkB4D5lDEJT5Xtn
j8KdBHcFvG6eFJr/8PHt2XtrVy8MNSMcc3vRYxp+MyxV6sXoMIwhuUbTkXo8tL8C
NUuh6F4hbBYh+y2ILf4du4dGAhy86GSIE30TaP8Qg/Cm+41x/pryX66P+NH+p6Vf
qSpo9X8z4kheyNvuUXdjQVuPPobdnfVXdE1KXy46K3qh4BrL7wc2l6WQH8vaz+Yy
rk/cgFdAHoDq/1wvQwlRoyJq5dIp87P85pTCAf/F/EG0PzCi1VoiEjRBrkWgot0s
VIlUJR2IYtQR35CMo+S7Tcy7IS0+cxMJXCaDR4lx3RpB1vDiAgjH3pBijTOTWDBK
zMe7AS6/arOesrIS9SdAk/+kzI4MjK24uXgO2W9utcyAACIzdspD3MQr0UxobBkX
TRJX4OYt0jDEJAJbpE5+usLH9U9nt4k6Ke7+/MYkAQEVZZ61xnFX0ovCbN6OwHjA
33Y2kLNDnHvq43J7+D0PbYB+djvkIUq4nAVxFEXzbdSlGsobZObHMj3KDJM8cslx
SsVWMPPgq1uQDwf1tuRu
=BPSh
-----END PGP SIGNATURE-----

--=-L+VAKdwo7L9V1SkruJcC--

