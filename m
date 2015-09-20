Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx01.mykolab.com ([95.128.36.1]:14994 "EHLO
	mx-out02.mykolab.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753410AbbITQUZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 20 Sep 2015 12:20:25 -0400
From: Knuth Posern <knuth@posern.org>
Subject: [PATCH] Thunderbolt 2 driver for recent Apple MacBooks
To: linux-kernel@vger.kernel.org
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Greg KH <greg@kroah.com>, linux-pci@vger.kernel.org
Message-ID: <55FEDAAD.6000804@posern.org>
Date: Sun, 20 Sep 2015 18:11:25 +0200
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Mw70qcMF0sP9P7hcX9DnsSfLuIDMTVEJd"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Mw70qcMF0sP9P7hcX9DnsSfLuIDMTVEJd
Content-Type: multipart/mixed;
 boundary="------------000807020708070808080605"

This is a multi-part message in MIME format.
--------------000807020708070808080605
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

This patch is submitted for upstream inclusion.
This is a first for me, so I hope the format of this mail is convenient.

Thanks to Greg and Andreas the attached patch (diff -up) fixes the bug:
https://bugzilla.kernel.org/show_bug.cgi?id=3D100191

The pci device ids listed in the tb driver are to restrictive, which
prevents the driver from being loaded. We have had a similar issue
with the new Mac mini.

Changing the subvendor and subdevice to PCI_ANY_ID in
	drivers/thunderbolt/nhi.c
the thunderbolt driver loads and binds to the pci device
07:00.0 System peripheral: Intel Corporation Device 156c
which is the thunderbolt 2 controller.


Cheers,

Knuth.


--------------000807020708070808080605
Content-Type: text/x-patch;
 name="diff.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="diff.patch"

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



--------------000807020708070808080605--

--Mw70qcMF0sP9P7hcX9DnsSfLuIDMTVEJd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJV/tq2AAoJEMkMg1OiIJvy3wwP/0W9v8NPEVPhwpaFiOPAscbI
+/AZoz0E8R2Mcw+sQYtfUD4SLjpusp5vMm4c1js9GeMTTXbJN4cTUTl2PBh/UVOY
oJ1C2g+OeJ/7qcqV8lVkdPEUwVkI7uakJtUntn+3VQ5wIRBZO4b5pmi6Fqlb7440
+WtFep70rnMcrRpDEM1kR4znwfU8eVzyiEofMDmxvgWJECfedSoCro14rDuuSMQd
xx4tVBBLXZuXqTt4y+FYws8wB7ZAPpLT5yUhe+xS0+KwwllpNp6YsfQ8KORW/P2j
xTQdscgmvRExhdkH2W5iVuBeWjDkCKKACCiQToomzdlSdcBra+zTasi1M8CBtsX6
k9gGS0KyNYbXViibHhwuSuLSmXnEC5f7+kFZj1h6TOeHTGvl5P4Zdt+zHceD0MH6
DSaS08S8XeAmtyLJxcTr2prhf9kFhSIpKQr/H8juqhNW4Y59DhmEmXHxKs37WDaC
t8JCJl8+tp+c0a5uurM+MAulTKWRGNKxEsI6pkQQBeIxIiaozQ8sBaYVFqkTR3Y8
9BviWSrS7XVZWuOgdW2CURgRMvvHsRNMJ8o9cOoCJo2DhnfJWzGy2sUcZvp86j3t
dwnFeEFBW175O7jMHJQ5ygK6T2ircsBnQ6ZcgnbmqKecQ+nCHp8JMHfM1okmUXEv
daG5m3fA0nKgdR8i4qVu
=OVuM
-----END PGP SIGNATURE-----

--Mw70qcMF0sP9P7hcX9DnsSfLuIDMTVEJd--
