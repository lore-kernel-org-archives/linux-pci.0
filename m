Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:55525 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751523Ab3C0GhD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 Mar 2013 02:37:03 -0400
Date: Wed, 27 Mar 2013 07:36:36 +0100
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Russell King <linux@arm.linux.org.uk>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree-discuss@lists.ozlabs.org,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Olof Johansson <olof@lixom.net>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Mitch Bradley <wmb@firmworks.com>,
	Andrew Murray <andrew.murray@arm.com>
Subject: Re: [PATCHv6 10/17] arm: mvebu: add PCIe Device Tree informations
 for Armada 370
Message-ID: <20130327063636.GA17821@avionic-0098.mockup.avionic-design.de>
References: <1364314719-1049-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1364314719-1049-11-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130326163421.GA30255@obsidianresearch.com>
 <20130326201654.GA7109@avionic-0098.mockup.avionic-design.de>
 <20130326222744.54e9fc82@skate>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
In-Reply-To: <20130326222744.54e9fc82@skate>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2013 at 10:27:44PM +0100, Thomas Petazzoni wrote:
[...]
> and so now the suggestions is to do:
>=20
>                 pcie-controller {
>                         compatible =3D "marvell,armada-xp-pcie";
>                         status =3D "disabled";
>                         device_type =3D "pci";
>=20
>                         #address-cells =3D <3>;
>                         #size-cells =3D <2>;
>=20
>                         msi-parent =3D <&msi>;
>                         bus-range =3D <0x00 0xff>;
>=20
> 			ranges =3D <0x82000000 0 0xd0040000 0xd0040000 0 0x00002000 /* Port 0.=
0 registers */
> 				  0x82000000 0 0xd0042000 0xd0042000 0 0x00002000 /* Port 2.0 registe=
rs */
> 				  0x82000000 0 0xd0044000 0xd0044000 0 0x00002000 /* Port 0.1 registe=
rs */
> 				  0x82000000 0 0xd0048000 0xd0048000 0 0x00002000 /* Port 0.2 registe=
rs */
> 				  0x82000000 0 0xd004c000 0xd004c000 0 0x00002000 /* Port 0.3 registe=
rs */
> 				  0x82000000 0 0xd0080000 0xd0080000 0 0x00002000 /* Port 1.0 registe=
rs */
> 				  0x82000000 0 0xd0082000 0xd0082000 0 0x00002000 /* Port 3.0 registe=
rs */
> 				  0x82000000 0 0xd0084000 0xd0084000 0 0x00002000 /* Port 1.1 registe=
rs */
> 				  0x82000000 0 0xd0088000 0xd0088000 0 0x00002000 /* Port 1.2 registe=
rs */
> 				  0x82000000 0 0xd008c000 0xd008c000 0 0x00002000 /* Port 1.3 registe=
rs */
> 				  0x82000000 0 0xe0000000 0xe0000000 0 0x08000000   /* non-prefetchab=
le memory */
>                                   0x81000000 0 0          0xe8000000 0 0x=
00100000>; /* downstream I/O */
>=20
>                         pcie@1,0 {
>                                 device_type =3D "pci";
> 				assigned-addresses =3D <0x82000800 0 0xd0040000 0 0x2000>;
>                                 reg =3D <0x0800 0 0 0 0>;
>                                 #address-cells =3D <3>;
>                                 #size-cells =3D <2>;
>                                 #interrupt-cells =3D <1>;
>                                 interrupt-map-mask =3D <0 0 0 0>;
>                                 interrupt-map =3D <0 0 0 0 &mpic 58>;
>                                 marvell,pcie-port =3D <0>;
>                                 marvell,pcie-lane =3D <0>;
>                                 clocks =3D <&gateclk 5>;
>                                 status =3D "disabled";
>                         };
>=20
>                         pcie@2,0 {
>                                 device_type =3D "pci";
> 				assigned-addresses =3D <0x82001000 0 0xd0042000 0 0x2000>;
>                                 reg =3D <0x1000 0 0 0 0>;
>                                 #address-cells =3D <3>;
>                                 #size-cells =3D <2>;
>                                 #interrupt-cells =3D <1>;
>                                 interrupt-map-mask =3D <0 0 0 0>;
>                                 interrupt-map =3D <0 0 0 0 &mpic 59>;
>                                 marvell,pcie-port =3D <0>;
>                                 marvell,pcie-lane =3D <1>;
>                                 clocks =3D <&gateclk 6>;
>                                 status =3D "disabled";
>                         };
>=20
> 			[...]
>=20
> 		};
>=20
> Is this correct? Thierry, Jason, if you could confirm my understanding,
> that would be great. I could then rework and resend the patch set.

Yes, that looks correct. And as Arnd mentioned the pci@x,y nodes should
probably have an empty ranges property.

Thierry

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRUpN0AAoJEN0jrNd/PrOhklQP/1ee9x+45Mgui1HByWL/M86F
KQGDL/W93wnVIR68pADYP9iEMAfNhgDU7vjI+sz3xkR8JX/Eg5bIcdO8z5Qwxlac
+VS/iGhzYyUj6MPulGtVQUrctefSwI41cyCMmo11iGuiqjRJQV/CHjDsuj2SMgFq
lscpn0kEzXp3C/hbj76lfIflHzZIypR4jBS7Z1uNciEC4bLqm2zteBZQuM8EbbhW
7xBxP/YTEShy3AZ6aTGiQuTyqpLYhpRzkNK/9wadsqwHDsh6ybJV6eBWWbYeLm0t
ZiU21NQvRWta+XDK0ObiAnv4Gqm02f2yQL+QMNoTPfq49UBPDR4lKvgT5Kz0HEEl
cPbbz/qymtv869q02wRAPhzl70vfusHFxcds3xPkbeZST8CL05GAydRez15I7Uyx
bYlCZ3IgzKaT1s2gYPBigpHqCc2mhi6IDtV1eJq2xkjH6DnTc5IIXqfBWk2BLn3b
KuVOa5s8lpstdds8DOaAK+r32+klcFqZTsQV4YODNhcD67IvgSxjraRz5vqluM2E
U3QzdFfdTuzLPg3gD3iUSjI3zeQVCTTq1AcmEe91WETNdUsSsI2BQ6hwRYtjuOqB
8pDRwWsLOMTAhLmepamig/XrAlgeJklMoKy6g3w884HNd5+E22H+AKDtesUJ+sKM
pA9IBblNxKPSa1PD2vBH
=H1gQ
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
