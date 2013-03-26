Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:54881 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751659Ab3CZVNd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Mar 2013 17:13:33 -0400
Date: Tue, 26 Mar 2013 22:12:34 +0100
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Russell King <linux@arm.linux.org.uk>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree-discuss@lists.ozlabs.org,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Maen Suleiman <maen@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Olof Johansson <olof@lixom.net>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Mitch Bradley <wmb@firmworks.com>,
	Andrew Murray <andrew.murray@arm.com>
Subject: Re: [PATCHv6 10/17] arm: mvebu: add PCIe Device Tree informations
 for Armada 370
Message-ID: <20130326211234.GA1295@avionic-0098.mockup.avionic-design.de>
References: <1364314719-1049-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130326163421.GA30255@obsidianresearch.com>
 <20130326201654.GA7109@avionic-0098.mockup.avionic-design.de>
 <201303262050.12847.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
In-Reply-To: <201303262050.12847.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2013 at 08:50:12PM +0000, Arnd Bergmann wrote:
> On Tuesday 26 March 2013, Thierry Reding wrote:
> >                 pci@1,0 {
> >                         device_type =3D "pci";
> >                         assigned-addresses =3D <0x82000800 0 0x80000000=
 0 0x1000>;
> >                         reg =3D <0x000800 0 0 0 0>;
> >                         status =3D "disabled";
> >=20
> >                         #address-cells =3D <3>;
> >                         #size-cells =3D <2>;
> >=20
> >                         nvidia,num-lanes =3D <2>;
> >                 };
>=20
> Shouldn't there be an empty ranges property in there as well?

Technically yes, I think. Though it doesn't make a bit of a difference
on Linux.

Thierry

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRUg9CAAoJEN0jrNd/PrOhcpcP/07knZ3ngXHD+sTb++WAbC82
pWNjjuk9l0bRGSA27JzQQ8ezDmRWqUXH/Xi1FYLEe+yuYTsxf5ETkYdaMJWy8eG7
iJIv0gNqPfxAynHzIZDUEgd0g548xO/+IXNrZjgFtu7Qnchup/9GOdf34MY98V7y
LlTg2hRaMenCg1rmUz8BQogAfWxgPWkzEArl7MiXTnBHgXmVHDpYQtS/2mj3qln/
Yc1GrmmSmUHCi7WCVs73NC1mPOJMkF5gqaFNuXtxIYvHpAYDRIrKyHKtChAgfwOa
GWvx5Tt13Hb7lxVCKcX/VHmcYRJBJWeRD9mVZVp26BnlaM8nm6DhTUmBT7GFAaPl
Bq53OWfGhNff8pgpXrnFS/99nW27vdVP34BYTVrmDBk4tDJVKnaSBfN9AkFc3hCY
AS0hZOxzVbLUgxtX80UcR1ZxjS0Jbfltm7AXp0urrF8d6xJMmAfIuDvgGq9Q/QQG
yWXRJ0GLpy0FkJzrqFF/alrQVj8BRhy3Unk/r2d75A5LBbIaxGEetvFCQ4kp5gyt
zA8sBQJYwtXY1UuRFxkP1FksLGm/mm59+/vuVNdjXOdORU//NG5qts+lr6CXu/m+
8UT2GQ6eEkdkEvO6i0H6o/rpqRegEJweyKhrYjupomuv4+24RKXDehjgdLb7zT3e
0Zp/EOw0/0w98DO0AdU/
=Jwhw
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
