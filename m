Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from oproxy4-pub.bluehost.com ([69.89.21.11]:58852 "HELO
	oproxy4-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756478Ab2BXW16 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 24 Feb 2012 17:27:58 -0500
Date: Fri, 24 Feb 2012 14:27:54 -0800
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: pci_probe_only and bus_to_resources patches rebased to pci
 linux-next branch
Message-ID: <20120224142754.2fc00f7a@jbarnes-desktop>
In-Reply-To: <CAErSpo67Y4xtctJ=a8LQLqopRyM9_3gYKwFSUw8kT6XEVsPZzA@mail.gmail.com>
References: <CAErSpo67Y4xtctJ=a8LQLqopRyM9_3gYKwFSUw8kT6XEVsPZzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_//5WwEcR_pTnIDB4toQqtZJx"; protocol="application/pgp-signature"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--Sig_//5WwEcR_pTnIDB4toQqtZJx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 23 Feb 2012 21:04:04 -0800
Bjorn Helgaas <bhelgaas@google.com> wrote:

> Hi Jesse,
>=20
> I rebased these series:
>=20
>     v2 generic pci_probe_only flag
>     (http://marc.info/?l=3Dlinux-pci&m=3D133002621016744&w=3D2)
>=20
>     v2 add PCI bus-to-resource offset support in core
>     (http://marc.info/?l=3Dlinux-pci&m=3D132884138928641&w=3D2)
>=20
> onto your current linux-next tree (based on commit 823806ff).  Minor
> conflict resolutions in include/linux/pci.h, and that's about it.
>=20
> You can examine the result here:
>=20
>     https://github.com/bjorn-helgaas/linux/tree/pci-next+probe_only+bus2r=
es-fb127cb
>=20
> or pull both series with:
>=20
>     git pull git://github.com/bjorn-helgaas/linux.git
> pci-next+probe_only+bus2res-fb127cb

Nice, I like all the deletions especially.

Pulled into linux-next.

--=20
Jesse Barnes, Intel Open Source Technology Center

--Sig_//5WwEcR_pTnIDB4toQqtZJx
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPSA7qAAoJEIEoDkX4Qk9hKjsQAK4nCrk27d6MC2NOOIo+TWQw
AbsRY3Ru2kx4jhUiJhJGIvwKb8an/4DAt+kq1qHmaaURVEJl/5CfJX3OdL+dsvp9
xMkIeN9DnecPbhBFB6VHv2jK0o/M9cshBBYlAUCu2GfJSi9YHpXk/dznLgNRaM0c
gpHN9ZOaXkvO/Q/lBQuDEftfgFru1GJU36wfbJyIuusbTnfKzOHb5dUNzUesGfyy
uIlDI9BRYv8mJ/Occw6YxGzfeKcA5lW4roEC4TuqO++lPOZeuo2rTegBNf+ul9Fy
iUB9tDcoSeXw3eIMpNoyAUQUNprVrSKRv4xFFXxkgcuasTr6agFuH0YQ91N+yIjm
2p3QGaMmVG6qo2hhyJJNa/KsQqKAiQLfJZZiisifUCxpSTEQhooHwkudP1TePgb3
Vok7mcWYdUgXWeCXquFQ9utoFL0Oc7dAGlOnWlIJG1dZc5Z1y3R5vhDtCs1Quyw/
yfB2SIz0s5eCvlQvQcdxB0JYt7IGSPGYIVD2qNjL4nKM4rDysuhY+7+wZGE/qPpp
6nXyVkp1W5siv1O0Fex0WR9yTR9lyfugdKP9Nw/7r1OBnZEbaABhI+fiDMeBe5Bz
uhX2zN7wOxoySNKPDFX4rsCRxR4dMVQ+ZRWxQJLI0tXDJohHNu8A5A2paasIkq4c
LSnfRp1Si0pSj1ro3EMv
=I2X1
-----END PGP SIGNATURE-----

--Sig_//5WwEcR_pTnIDB4toQqtZJx--
