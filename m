Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Knuth Posern <knuth@posern.org>
Subject: [PATCH] thunderbolt: Allow loading of module on recent Apple MacBooks
 with thunderbolt 2 controller
To: linux-kernel@vger.kernel.org
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Greg KH <greg@kroah.com>, linux-pci@vger.kernel.org
Message-ID: <55FEF7EB.7030705@posern.org>
Date: Sun, 20 Sep 2015 20:16:11 +0200
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="O2kXoRwi4lLQ2tUFkRWBxqFpkk0d2dooJ"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--O2kXoRwi4lLQ2tUFkRWBxqFpkk0d2dooJ
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

This patch is submitted for upstream inclusion.

Thanks to Greg and Andreas helping coming up with the patch fixing the
bug:
https://bugzilla.kernel.org/show_bug.cgi?id=3D100191

This is a second trial for me, so I hope the format of this mail is
convenient.
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

--- linux/drivers/thunderbolt/nhi.c.orig 2015-09-20 17:36:14.014964300 +0=
200
+++ linux/drivers/thunderbolt/nhi.c 2015-09-13 09:58:18.000000000 +0200
@@ -643,7 +643,7 @@ static struct pci_device_id nhi_ids[] =3D
{
=2Eclass =3D PCI_CLASS_SYSTEM_OTHER << 8, .class_mask =3D ~0,
=2Evendor =3D PCI_VENDOR_ID_INTEL, .device =3D 0x156c,
- .subvendor =3D 0x2222, .subdevice =3D 0x1111,
+ .subvendor =3D PCI_ANY_ID, .subdevice =3D PCI_ANY_ID,
},
{ 0,}
};


--O2kXoRwi4lLQ2tUFkRWBxqFpkk0d2dooJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJV/vgEAAoJEMkMg1OiIJvy8JsP/3PGvvznBxcjVZVSvDgVudMQ
M9hTimIdSjZbUmBFdIPxiACWfHkU/XJV/Vx1qlWrl7aqD6rv33vW+QEqndei8khV
ZobMI2bDOAlhK4O7C98zin88fuGVb5ZBi+Ci665auNQXyjlbggKMwqexVo3VrhjG
1LcIa3+8doWPpwylrMUDyIcTqQkphQ7lEAE/KGnlAI3/tPW/LT6BUpqiKh2vCk/P
HPbnfNNQmj1vSjNBdJBwX0TVfa3LGtuDCph668SDXLlkCFMgDj/+GTYCsmma5J53
wXevduohC+NosK5ROMRzm2VFflNc33ujXs0qMzlc/xFndfleV042NM/xpV/J41Nq
tcjBWpgT74N96LztZ4ypIsebrf7R9fH8Av8+r4J867NeJDUGV/YaxVckOg3M2AVA
A20RhfzfxxjdJl61TslcqCZz0EumSacsTd90fMordrF/7qdT9r2Vd7l5/WQfE8xB
dEezDETB0S6Nvlc9a52lxEHkP0XkRgevFH+yJrxjJZVjmUHK+lwa1HmBbOgWWKif
BxLbSkxbUeqzg+WQ0l/ueL2ODW3f7bPPE3xBPgmxcn5zhpOM/j3WgOWIjArkYPK3
/10Q5VLHHFxQY4XR/fN1jCfN2wHTZH+KTa7uNDXpisOBHRYxfS1v0AErtyemUAa6
z+ORe7xmQ9/U2mS4hjOL
=BZzB
-----END PGP SIGNATURE-----

--O2kXoRwi4lLQ2tUFkRWBxqFpkk0d2dooJ--
