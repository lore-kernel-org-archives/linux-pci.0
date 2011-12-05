Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from oproxy3-pub.bluehost.com ([69.89.21.8]:60297 "HELO
	oproxy3-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756550Ab1LESZz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 5 Dec 2011 13:25:55 -0500
Date: Mon, 5 Dec 2011 10:28:29 -0800
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Greg KH <greg@kroah.com>
Cc: linux-pci@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] PCI: Add helper macro for pci_register_driver
 boilerplate
Message-ID: <20111205102829.1a98d25d@jbarnes-desktop>
In-Reply-To: <20111118181249.GA29495@kroah.com>
References: <20111118181249.GA29495@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/DKiLbLJUlhk_/e8U=JMJaH_"; protocol="application/pgp-signature"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--Sig_/DKiLbLJUlhk_/e8U=JMJaH_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 18 Nov 2011 10:12:49 -0800
Greg KH <greg@kroah.com> wrote:

> From: Greg Kroah-Hartman <gregkh@suse.de>
>=20
> This patch introduces the module_pci_driver macro which is a convenience
> macro for PCI driver modules similar to module_platform_driver. It is
> intended to be used by drivers which init/exit section does nothing but
> register/unregister the PCI driver. By using this macro it is possible
> to eliminate a few lines of boilerplate code per PCI driver.
>=20
> Based on work done by Lars-Peter Clausen <lars@metafoo.de> for other
> busses (i2c and spi).
>=20
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
>=20
> ---
>=20
> Jesse, I've added the same type of macros for i2c, spi, and usb to my
> driver-core tree, and converted a number of drivers to these new macros.
> If you give me the ack, I can add this patch to my tree as well.
>=20
> I'll follow up this patch with an example showing how it works.
>=20
> Comments?
>=20

Yeah, I have no problem with it.  You can queue it up with the other
changes and add my acked-by to keep dependencies to a minimum.

Thanks,
--=20
Jesse Barnes, Intel Open Source Technology Center

--Sig_/DKiLbLJUlhk_/e8U=JMJaH_
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJO3Q1NAAoJEIEoDkX4Qk9hWDsP/3VgfXsNnz+Exz/XAcuVNYti
KeVyBgjgj+RUuxhZ9OPvpDOnmSujiD5CSB9mfAxA+JrzYGq2sO+zsL8ioKte5sW/
FccqE/zWs68pc7EXRW0NYnBg3p2p9gCkE+ZJsKZOOHy1nhwgRGQs8+VuOm/mWBC7
fvvBnS69j06N+0F54FQGRdrDgqpvHZNE24rR2EoE+tPKEN1Or5EENQDtPdXtH0lL
VhQcYuxnaesfK1VQwoNXy6rG7tRXzQT4AM2tzR/mzOPAuXbBOVCaqhr1tSXtOgDv
bNaW6DV/6ELiIKS66UaorrsjB6GNB90YjTEeDuXQzcoMZgBaEK3eZ4sONf1IozTs
+hnyuwryCcCD3ZjuSwv66tfFQWvcmDJNWf/sz27yIwq0CBlMrPS5Q8/igsfCkOZJ
OC3vdp9+JkcGV3Nv3mu2Bshdl0xU8grtVPU4IurwpHS+Se/20EcGtrqkH0Yi0Lys
/PZmCex9uyVtAZ630oTS7VaesfdMIZcr1qSh0xdu20Gwcc1G5bf3mbhYW1eseFqZ
ttInbDMHiBX/Tdo5X319JuvTQzL3qktuUyKipNdOekGfj13iSjks2BVGBU1RNzTK
x0bSf7Mp+ztgqihkHuwTt0ZFv9xT8annQ2WEt0y/RXp410s4kJm7RuRn4jg9OmRU
nB9ZwPWXPWPLfzgJQch9
=0/sJ
-----END PGP SIGNATURE-----

--Sig_/DKiLbLJUlhk_/e8U=JMJaH_--
