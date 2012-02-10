Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from oproxy5-pub.bluehost.com ([67.222.38.55]:56029 "HELO
	oproxy5-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755209Ab2BJTfL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2012 14:35:11 -0500
Date: Fri, 10 Feb 2012 11:35:07 -0800
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Thomas Renninger <trenn@suse.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Yinghai Lu <yinghai.lu@oracle.com>
Subject: Re: [PATCH] PCI: workaround hard-wired bus number V2
Message-ID: <20120210113507.5968216f@jbarnes-desktop>
In-Reply-To: <201201301225.24312.trenn@suse.de>
References: <1327655507-33999-1-git-send-email-trenn@suse.de>
	<CAErSpo54EuF3ZmiHZmCvTK5vd0oHws7W+82WPYwLQ9PeL1MG6g@mail.gmail.com>
	<20120127093835.1d2737db@jbarnes-desktop>
	<201201301225.24312.trenn@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_//u6U.5=GM5q8mWjP=ajaxz3"; protocol="application/pgp-signature"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--Sig_//u6U.5=GM5q8mWjP=ajaxz3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 30 Jan 2012 12:25:24 +0100
Thomas Renninger <trenn@suse.de> wrote:

> From: Yinghai Lu <yinghai.lu@oracle.com>
>=20
> Fixes PCI device detection on IBM xSeries IBM 3850 M2 / x3950 M2
> when using ACPI resources (_CRS).
> This is default, a manual workaround (without this patch)
> would be pci=3Dnocrs boot param.
>=20
> V2: Add dev_warn if the workaround is hit. This should reveal
> how common such setups are (via google) and point to possible
> problems if things are still not working as expected.
> -> Suggested by Jan Beulich.
>=20
> Tested-by: garyhade@us.ibm.com
> CC: stable@vger.kernel.org
> CC: trenn@suse.de
>=20
> ---
>  drivers/pci/probe.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 7cc9e2f..71eac9c 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -651,6 +651,11 @@ int __devinit pci_scan_bridge(struct pci_bus *bus, s=
truct pci_dev *dev, int max,
>  	dev_dbg(&dev->dev, "scanning [bus %02x-%02x] behind bridge, pass %d\n",
>  		secondary, subordinate, pass);
> =20
> +	if (!primary && (primary !=3D bus->number) && secondary && subordinate)=
 {
> +		dev_warn(&dev->dev, "Primary bus is hard wired to 0\n");
> +		primary =3D bus->number;
> +	}
> +
>  	/* Check if setup is sensible at all */
>  	if (!pass &&
>  	    (primary !=3D bus->number || secondary <=3D bus->number)) {
>=20

Applied, thanks Thomas.  I'll send this over to Linus next week
assuming it doesn't blow up before then.

Thanks,
--=20
Jesse Barnes, Intel Open Source Technology Center

--Sig_//u6U.5=GM5q8mWjP=ajaxz3
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJPNXFrAAoJEIEoDkX4Qk9h54gP/2MNiQ9uzhf4NWxmphU4tD5r
1YBcevgHF4erfchT8Ia5kEaxaDu3Ja3XryFTyfgY294OPdiP97Xdmu7t5ia6F+3n
lV1lgUUjntLYgHaH2vDKLuPHQcJCZCJTBf/RxVQ45uJQJOPWiVTVal+WlWFrdxKF
hjEBtU5eLZ+onyZ2skfddJdCynPKxwyFeZc5p43ucnpwzE7WRuqZJ5yV0kwrp1+v
EppAaAiACj99OTw0yYUZyklEotga6lsqgB5IT9+X2e/dPpZst7LN0kJrCWgLpYbh
+9Ir5qvGmTR0CsPXfxbKN4hwOCljcHPDI4caWDqDr/Ky7s/umjxrScYj37UWc0th
firUHWBhujJ8LictYpGqR9bsyBqeuJQTBqcZrRc3JXwRy3PhIF9aQ2x6Pme2opzz
euikpFXw+wG3bFdyPpDcWk+gZ4gPm6Ar15IL+G9e3Z9013jDINTGyoqSrMWCXvEr
U2QiWe97lWuWMipptkX8/vKprFeVeA/y4VU2SZVAzAuoSiSOWFBBK0XJYkI9UdWZ
VioZE7deKROX1gPQBReIuTdcnJG4JZe3iuBSfSyKvSecMPoSU/WNvs6kmXkRvx+k
VjDO8VyA7NkiFz4mukfvLpuhi9RW8p6y6MKJCcDc39pqY5LEYg0dWQiVJRTqVzs8
0Z+1YCGdYjTtok++EBMg
=JceE
-----END PGP SIGNATURE-----

--Sig_//u6U.5=GM5q8mWjP=ajaxz3--
