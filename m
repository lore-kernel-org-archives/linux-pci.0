Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:37367 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754215AbbILBLi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 11 Sep 2015 21:11:38 -0400
From: "Rustad, Mark D" <mark.d.rustad@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"alexander.h.duyck@redhat.com" <alexander.h.duyck@redhat.com>,
	"myron.stowe@redhat.com" <myron.stowe@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] vfio/pci: Use kernel VPD access functions
Date: Sat, 12 Sep 2015 01:11:37 +0000
Message-ID: <80CE59CA-1B93-42FF-96D1-6276B724203F@intel.com>
References: <20150911181332.32399.74472.stgit@gimli.home>
In-Reply-To: <20150911181332.32399.74472.stgit@gimli.home>
Content-Type: multipart/signed;
	boundary="Apple-Mail=_CACFEE63-A8F3-4076-9CE5-54C2EB6428EA";
	protocol="application/pgp-signature"; micalg=pgp-sha256
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--Apple-Mail=_CACFEE63-A8F3-4076-9CE5-54C2EB6428EA
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Alex,

> On Sep 11, 2015, at 11:16 AM, Alex Williamson =
<alex.williamson@redhat.com> wrote:
>=20
> RFC - Is this something we should do?

Superficially this looks pretty good. I need to think harder to be sure =
of the details.

> Should we consider providing
> similar emulation through PCI sysfs to allow lspci to also make use
> of the vpd interfaces?

It looks to me like lspci already uses the vpd attribute in sysfs to =
access VPD, so maybe nothing more than this is needed. No doubt lspci =
can be coerced into accessing VPD directly, but is that really worth =
going after? I'm not so sure.

An strace of lspci accessing a device with VPD shows me:

write(1, "\tCapabilities: [e0] Vital Produc"..., 39	Capabilities: =
[e0] Vital Product Data
) =3D 39
open("/sys/bus/pci/devices/0000:02:00.0/vpd", O_RDONLY) =3D 4
----------------------------------------^^^ accesses to this should be =
safe, I think

pread(4, "\202", 1, 0)                  =3D 1
pread(4, "\10\0", 2, 1)                 =3D 2
pread(4, "PVL Dell", 8, 3)              =3D 8
write(1, "\t\tProduct Name: PVL Dell\n", 25		Product Name: =
PVL Dell
) =3D 25

and so forth.

--
Mark Rustad, Networking Division, Intel Corporation


--Apple-Mail=_CACFEE63-A8F3-4076-9CE5-54C2EB6428EA
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIcBAEBCAAGBQJV83vIAAoJEDwO/+eO4+5u9BcQAI0MJoFkLlapvWMj/6+ZwBS0
T7EKJD/37QXMzwv31P7WtBpJIdk4F1HsPQe9bIbEHrFMTJ1sbITMdLf0iYOmmIK9
3RIDH3snndI8NGBuV50qRz0hq/FqyDxoStSs/poe3pkNUNWfA1MzEO2d2u54qkta
kPSxbNZSg9QP99oRH3x44Qp9Kc/7P465buPUzWTznwJFn8TkWVNf6cB7WLh62/OE
FxaePrZfnPcWvUf0UFvLbBrk2hUHyIHihYILZridw0TZh0ju1wGdY9SsjYLpupyI
1K5UzlogZEH8WApHIjtbjgCuM7Ptu/aGWHmGoIGYNGsO2Ib4jeaI2/UnOXES1hir
7j0qzMgjjpFaIJs78A5xgp2IR89col7xf/EtVpI/o3Rvdo4a3j67pj/uZsof88n5
MQcAO5sFfy9kJuMw3RlXZUtFY2x7GePmnJQb2R+pZi03YaOn9Llr+34ycYAabxxk
+riW2irO8KJAe+4TkkmOVrcJGAajq4F1AwyrHep/QaTUxMk92pC7uZ9DjPCrU8EF
xPV7Taib72C1SuJOjxw7rcOXhjyihQKdr0qlymXmtt2YZvR/GEtOZC/b+jt5Fa+D
MsYOY03afnM6h2Endm6HrJeBXeQt4qLtlod6Mc7NnF/pESViqFlywTqlcPS83GLY
HwMztEEhL060LrOgld3I
=4gXz
-----END PGP SIGNATURE-----

--Apple-Mail=_CACFEE63-A8F3-4076-9CE5-54C2EB6428EA--
