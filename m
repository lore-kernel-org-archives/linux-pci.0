Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx01.mykolab.com ([95.128.36.1]:18467 "EHLO
	mx-out01.mykolab.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755306AbbITTZu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 20 Sep 2015 15:25:50 -0400
From: Knuth Posern <knuth@posern.org>
Subject: [PATCH] thunderbolt: Allow loading of module on recent Apple MacBooks
 with thunderbolt 2 controller
To: linux-kernel@vger.kernel.org
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Greg KH <greg@kroah.com>, linux-pci@vger.kernel.org
Message-ID: <55FF0822.90901@posern.org>
Date: Sun, 20 Sep 2015 21:25:22 +0200
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="fTqi1bhE7EwrRxa9AAtsga1ESSwo9lCMH"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fTqi1bhE7EwrRxa9AAtsga1ESSwo9lCMH
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The pci device ids listed in the thunderbolt driver are to restrictive,
which prevents the driver from being loaded on recent Apple MacBooks
using a thunderbolt 2 controller. In particular this prevented any
hot-plugging functionality for thunderbolt based ethernet dongles
(i.e. Apples thunderbolt gigabit ethernet broadcom tg3 based dongle
Model A1433 EMC 2590).

Changing the subvendor and subdevice to PCI_ANY_ID the thunderbolt driver=

loads and binds to the pci device 07:00.0 System peripheral:
Intel Corporation Device 156c which is the thunderbolt 2 controller on
the MacBookPro12,1.

Successfully tested on MacBookPro12,1. With the patch the thunderbolt
module gets now loaded on boot. And it provides hot-plugging support both=

for a cold-plugged and a warm-plugged ethernet dongle.

Signed-off-by: Andreas Noever <andreas.noever@gmail.com>
Acked-by: Knuth Posern <knuth@posern.org>
---

=2E.. never 2 without 3 ;)

This patch is submitted for upstream inclusion.

Thanks to Greg and Andreas helping coming up with the patch fixing the
bug:
https://bugzilla.kernel.org/show_bug.cgi?id=3D100191

This is a first for me, so I hope the format of this mail is
convenient :)
For the changelog/comment, I tried to follow Andrew Mortons guide
https://www.ozlabs.org/~akpm/stuff/tpp.txt

- why the kernel needed patching
1st paragraph.

- the overall design approach in the patch
- implementation details
2nd paragraph

- testing results
3rd paragraph

Cheers,

Knuth.

--- linux/drivers/thunderbolt/nhi.c.orig	2015-09-20 17:36:14.014964300 +0=
200
+++ linux/drivers/thunderbolt/nhi.c	2015-09-13 09:58:18.000000000 +0200
@@ -643,7 +643,7 @@ static struct pci_device_id nhi_ids[] =3D
 	{
 		.class =3D PCI_CLASS_SYSTEM_OTHER << 8, .class_mask =3D ~0,
 		.vendor =3D PCI_VENDOR_ID_INTEL, .device =3D 0x156c,
-		.subvendor =3D 0x2222, .subdevice =3D 0x1111,
+		.subvendor =3D PCI_ANY_ID, .subdevice =3D PCI_ANY_ID,
 	},
 	{ 0,}
 };


--fTqi1bhE7EwrRxa9AAtsga1ESSwo9lCMH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJV/wg4AAoJEMkMg1OiIJvy4ukP/09cWw/+whs42K/kG7E1U2hw
0i8bVSiVa398jwN/2IB98phkHn2h6XDykZkUr7eTF0/ZH1zTvCHstEAFVo5LN8hk
5u3WbiqHaab4lpGvVS+JmR1xSdJ3wLzK3H+9eOPAZ+ioSbmCLmtg9ZVMDrSdTMCv
fTBGhRJ+PMj8o3ANAXcegKjGnkFjwHCqHWTrcCM8WcUNhnKtpiLbABI0sjp++BnH
8PZHPBZEGJ/2z31QsKMcqq+pM3ej/5S8ZYbMPMEl6yhOkh5JIMe4kwA7V7qIlNi3
MRcNLPfADtc/TCo8cNk9ciCSb3dTyHEPQujMFt7tJsbujud8MKWEBLGjzQtktVKM
g3RY2m5lo8hPV9grAWoQBh3XIPGJ9FXmH8QIfeqbxkrFnueN8J3pA8QtcK0Opns7
sh1DYTa2vHFVEsvoYL4rpKJEx/1KAQWESuN9rPAR4erRi+vNpbX/jL8YK2vHzNeA
jAckCtbur7DBNvtUe8MqT8iV9kqikx8/I/eBjAEJztcc+PDgRxa2G1MuGZyB+Cju
0+68GPmfRgMTJGDmhDOhENr7e8RcnPF+3QKYNQoihpJMk7XZLevZTkRDIE4tZKOf
PomjyHnABjFHn2h2YbroqUr758j0v+WzFWYIXkwsuUgX5g8zXR/8fWzM09ccKVwA
UdTVcMI+TsJh8CzJulE3
=i9uG
-----END PGP SIGNATURE-----

--fTqi1bhE7EwrRxa9AAtsga1ESSwo9lCMH--
