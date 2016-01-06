Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:44753 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752031AbcAFIjS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 6 Jan 2016 03:39:18 -0500
Date: Wed, 6 Jan 2016 09:39:11 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Simon Horman <horms@verge.net.au>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-sh@vger.kernel.org
Subject: Re: [PATCH v2 4/4] PCI: rcar: Add Gen2 PHY setup to pcie-rcar
Message-ID: <20160106083911.GD1525@katana>
References: <1451998831-27705-1-git-send-email-phil.edworthy@renesas.com>
 <1451998831-27705-5-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AkbCVLjbJ9qUtAXD"
In-Reply-To: <1451998831-27705-5-git-send-email-phil.edworthy@renesas.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--AkbCVLjbJ9qUtAXD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 05, 2016 at 01:00:31PM +0000, Phil Edworthy wrote:
> For PCIe compliance, the PHY registers need setting as per the
> manual.
>=20
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--AkbCVLjbJ9qUtAXD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWjNKuAAoJEBQN5MwUoCm2NwAP/R1vbh3RUN7ywFs0K0Hb7i9V
dxCfcPdabei2joIwlGO8ZP5MutVh8yRI3i6cJpJVLmsAw2ZeAxZzQlWhiqKWSZ0d
0KwZGFNas4dtzJINlGXGx89kpKKCDhiadKbZHQbd+brsEGyxcTTIpuTzms3fhgql
qI+Rl4bR/l+jxM83H9yPtsieAQLcP2C7oufGmUnbuauf/2Wbi65SNml0ns4sEuz/
J7VKXXZFTVic/qwafGB5NaJ6SO0dBPHi6ySmAnuvO5vDgQz0AztKeg6E3CS3Okco
Ll/pDh8UJaitvaM+ujpMyPeyuP1gp5oPbL5mCt3QCGe3L/kyN7bBcQmYYalOkfq8
mJpCG5EiyUHuiz+nOVJKtptH7XzER3R3nhkBJ2BchxEmHvXDWGm8MxG+bcNdftJI
Y/XfuBOj4XXeFpLi5E3TMWj/jAm72Z4ZZEz60ZIYQd+bDapsmF4TF+xanwXaP8PK
X/owHexW+/HWUJnOjKj2rrrXxOGQZCGhY8hjGmyNmh5+1DQO5pO6UjkiacQLDmVs
iuCkTlkluKPAXih0kuyi/9PRhLqRBX6ndtC76mWpT4UdIrzKPJvZk8Htaj2+QBKo
Gr/NDy1OsrrITsTlpki/MuZw9VdBXL33bzdEF5FCDzSU2i4Q4cEDIoC/Ewq+zVOe
HoW4kt6TcRzqj5I6cpXh
=N1yC
-----END PGP SIGNATURE-----

--AkbCVLjbJ9qUtAXD--
