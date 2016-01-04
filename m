Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:46200 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752912AbcADNWA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 4 Jan 2016 08:22:00 -0500
Date: Mon, 4 Jan 2016 14:21:42 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Simon Horman <horms+renesas@verge.net.au>,
	linux-pci@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: provide of_pci_get_host_bridge_resources helper
Message-ID: <20160104132142.GA11689@katana>
References: <8759253.sZisGJ6Km3@wuerfel>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
In-Reply-To: <8759253.sZisGJ6Km3@wuerfel>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 18, 2015 at 04:02:41PM +0100, Arnd Bergmann wrote:
> The pcie-rcar driver can be built for any ARM platform (for COMPILE_TEST)
> including those without CONFIG_OF enabled, and that results in a compile-=
time
> error:
>=20
> drivers/pci/host/pcie-rcar.c: In function 'rcar_pcie_parse_request_of_pci=
_ranges':
> drivers/pci/host/pcie-rcar.c:939:8: error: implicit declaration of functi=
on 'of_pci_get_host_bridge_resources' [-Werror=3Dimplicit-function-declarat=
ion]
>   err =3D of_pci_get_host_bridge_resources(np, 0, 0xff, &pci->resources, =
&iobase);
>=20
> In order to allow compile-testing on all platforms, this adds a
> of_pci_get_host_bridge_resources() helper stub function that gets
> used when CONFIG_OF_ADDRESS is disabled. This mirrors what we do for
> other OF-specific functions.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 5d2917d469fa ("PCI: rcar: Convert to DT resource parsing API")

Makes sense :)

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWinHmAAoJEBQN5MwUoCm2az4P/0/aIpq6QV1J6vlmCBRiDCAh
deAfQgA9skEiuMjrlnptk5JK9P4Og8EVWcCsbN/EtHcTfl2R1J0NGzpyQw0O5r1k
8AarULVabkNT4w2ZmlAeiRX8kGykumSX1OQk22fjou15eDDQo5OcNu0tpSTISBpN
a0/5FW4oTAeF99uOASKBo//rTWlevGWYm5Byf5k9cAvoGhZAQd3uB4NC81891Pqm
GSIHX6nwbIOY5PglYx+1g2cZOtq6KZB0APUiztQMIlift6H6g7dZH/QzvaYxftB+
BKJJ+w26mEiDYcHoceEQOmFmfo0YsKz1ZBBnPLD2kIJue2CQvrqaxsmEM1gFC01F
+eL3zeq4s/qFJCfmuK+rhzewL3nOFqHuLn++z/yJ4+gKOvhdyLlcfOiRGeSC2Zn/
RqsHfQeKeBNXJJsqo2BjPxtiqnY8gbp+a5p7WbPZlMjiyDRj60+6/X4/re1ujpkw
W6WOb2j12SMBMBX/6QeZBQoG0iXwYgjaj9jM3w5z7W/4dt0DgjeVWvGHx8UziR0c
8sbodkhalm5XrHFNoPaU8TMY8hvSq2YeQh5bqwCP81r8TE2UbNdNcuDSDQ7QSuPA
OY+1RWivTHD6hzAmYV8tZk73vtozw5NymoYKkyVo0I0K8sV4AtZXhyLSyP634s2c
Z1k7Ou6pmoQt5lmTTB1N
=o8SD
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
