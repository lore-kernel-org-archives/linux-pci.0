Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from oproxy9.bluehost.com ([69.89.24.6]:44505 "HELO
	oproxy9.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932126Ab1LET1q (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 5 Dec 2011 14:27:46 -0500
Date: Mon, 5 Dec 2011 11:30:21 -0800
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pci@vger.kernel.org
Subject: Re: Xorg intel server not finding the graphics device
Message-ID: <20111205113021.7841a4b2@jbarnes-desktop>
In-Reply-To: <Pine.LNX.4.44L0.1111281639090.1405-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1111281639090.1405-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/hGfVq_SrrL/sYfAhvY=6dvM"; protocol="application/pgp-signature"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--Sig_/hGfVq_SrrL/sYfAhvY=6dvM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hm, afaik the 865G should still work, maybe Fedora blacklisted the
kernel support for it in newer bits?  If so, you'll need to use the
vesa driver instead of the intel driver...

Jesse

On Mon, 28 Nov 2011 17:15:37 -0500 (EST)
Alan Stern <stern@rowland.harvard.edu> wrote:

> Jesse:
>=20
> After an upgrade to Fedora-16, my Xorg server has a problem.  It no=20
> longer binds to the intel driver to the 865G graphics chip.
>=20
> Here's the relevant portion of the Xorg log:
>=20
> --------------------------------------------------------------------
> X.Org X Server 1.11.2
> Release Date: 2011-11-04
> ...
> [   672.192] (--) PCI:*(0:0:2:0) 8086:2572:14a4:2181 rev 2, Mem @ 0xf0000=
000/134217728, 0xfe780000/524288, I/O @ 0x0000ec00/8, BIOS @ 0x????????/131=
072
> ...
> [   672.331] (II) Loading /usr/lib/xorg/modules/drivers/intel_drv.so
> [   672.426] (II) Module intel: vendor=3D"X.Org Foundation"
> [   672.426] 	compiled for 1.11.2, module version =3D 2.17.0
> [   672.426] 	Module class: X.Org Video Driver
> [   672.426] 	ABI class: X.Org Video Driver, version 11.0
> [   672.426] (II) intel: Driver for Intel Integrated Graphics Chipsets: i=
810,
> 	i810-dc100, i810e, i815, i830M, 845G, 854, 852GM/855GM, 865G, 915G,
> 	E7221 (i915), 915GM, 945G, 945GM, 945GME, Pineview GM, Pineview G,
> 	965G, G35, 965Q, 946GZ, 965GM, 965GME/GLE, G33, Q35, Q33, GM45,
> 	4 Series, G45/G43, Q45/Q43, G41, B43, B43, Clarkdale, Arrandale,
> 	Sandybridge Desktop (GT1), Sandybridge Desktop (GT2),
> 	Sandybridge Desktop (GT2+), Sandybridge Mobile (GT1),
> 	Sandybridge Mobile (GT2), Sandybridge Mobile (GT2+),
> 	Sandybridge Server, Ivybridge Mobile (GT1), Ivybridge Mobile (GT2),
> 	Ivybridge Desktop (GT1), Ivybridge Desktop (GT2), Ivybridge Server
> [   672.426] (--) using VT number 7
>=20
> [   672.444] (EE) No devices detected.
> [   672.444]=20
> Fatal server error:
> [   672.444] no screens found
> --------------------------------------------------------------------
>=20
> Here's the equivalent part of the log from before I upgraded:
>=20
> --------------------------------------------------------------------
> X.Org X Server 1.9.5
> Release Date: 2011-03-17
> ...
> [    80.575] (--) PCI:*(0:0:2:0) 8086:2572:14a4:2181 rev 2, Mem @ 0xf0000=
000/134217728, 0xfe780000/524288, I/O @ 0x0000ec00/8, BIOS @ 0x????????/131=
072
> ...
> [    81.003] (II) intel: Driver for Intel Integrated Graphics Chipsets: i=
810,
> 	i810-dc100, i810e, i815, i830M, 845G, 852GM/855GM, 865G, 915G,
> 	E7221 (i915), 915GM, 945G, 945GM, 945GME, Pineview GM, Pineview G,
> 	965G, G35, 965Q, 946GZ, 965GM, 965GME/GLE, G33, Q35, Q33, GM45,
> 	4 Series, G45/G43, Q45/Q43, G41, B43, Clarkdale, Arrandale
> [    81.004] (--) using VT number 7
>=20
> [    81.014] drmOpenDevice: node name is /dev/dri/card0
> [    81.014] drmOpenDevice: open result is 9, (OK)
> [    81.014] drmOpenByBusid: Searching for BusID pci:0000:00:02.0
> [    81.014] drmOpenDevice: node name is /dev/dri/card0
> [    81.014] drmOpenDevice: open result is 9, (OK)
> [    81.014] drmOpenByBusid: drmOpenMinor returns 9
> [    81.014] drmOpenByBusid: Interface 1.4 failed, trying 1.1
> [    81.014] drmOpenByBusid: drmGetBusid reports pci:0000:00:02.0
> [    81.014] (=3D=3D) intel(0): Depth 24, (--) framebuffer bpp 32
> [    81.014] (=3D=3D) intel(0): RGB weight 888
> [    81.014] (=3D=3D) intel(0): Default visual is TrueColor
> [    81.050] (II) intel(0): Integrated Graphics Chipset: Intel(R) 865G
> [    81.050] (--) intel(0): Chipset: "865G"
> --------------------------------------------------------------------
>=20
> In both cases, the dri and dri2 extensions were loaded correctly.
>=20
> Here's the part of the boot-up log showing the graphics detection:
>=20
> [    1.304112] Linux agpgart interface v0.103
> [    1.304405] agpgart-intel 0000:00:00.0: Intel 865 Chipset
> [    1.304581] agpgart-intel 0000:00:00.0: detected gtt size: 131072K tot=
al, 131072K mappable
> [    1.304960] agpgart-intel 0000:00:00.0: detected 8192K stolen memory
> [    1.305364] agpgart-intel 0000:00:00.0: AGP aperture is 128M @ 0xf0000=
000
>=20
> The /dev/dri directory does exist:
>=20
> $ ls -l /dev/dri
> total 0
> crw-rw----+ 1 root video 226, 0 Nov 28 16:12 card0
>=20
> There is no controlD64 file; I noticed that it is present in the Fedora
> graphical installation environment (which _does_ work).  Is it
> important?  If it is, what driver creates that file?  Or is some udev
> rule messed up?
>=20
> The Xorg configuration is slightly different from what it was before,=20
> but not much.  Here is the relevant section (which hasn't changed):
>=20
> Section "Device"
> 	Identifier  "card0"
> 	Driver      "intel"
> 	VendorName  "Intel Corporation"
> 	BusID       "PCI:0:2:0"
> 	Option      "NoAccel" "yes"
> 	Option      "BackingStore"      "on"
> EndSection
>=20
> Do you have any idea what's going wrong and how I can fix it?  Life=20
> without a GUI is rather inconvenient.  :-(
>=20
> Thanks,
>=20
> Alan Stern
>=20
>=20

--Sig_/hGfVq_SrrL/sYfAhvY=6dvM
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJO3RvNAAoJEIEoDkX4Qk9hM1sP/RHQ1Em1hVbgLxU/PyY3DK9a
UpuntPPgeaRK+T+MIAL1sTs4gfzSMbdjbiV9etvGXY5cESt4vfuoPassUGxBMf/E
6oMgUKdZ2N2TdUUEgSIAxS/v2fdKe/NJXxoJ7qavdGJzaqrvanbNP3bF/9jJzncu
ZcVyQJcMFifPQFMU3Cv/feAzY1vTCKq1xeVFd+Thfh38SvKY/TNcxKATdq8/i9Ww
HaEX0WGmcxJDw02FMB8saLBSQOI3Lqa4PTV+7iwI/lqa6Ib2uoHIT14lYrZXyGwF
I8TtO71Z3VLwWgJ4QzqKz7Ur35eHpeahvCKkhvGsIYZAWnmYBgh4mkfjiByPo4wY
uPdYL3iyY47bn4DRGKf4Ft2dKoJ3DSXgfHOpdVdNHhPgoKx2XYteqXDTRwWJL33H
NKowhQfF2omp5kBDL95XIrHz5GV36WQ3YAkfvkaGIJR9SowG7ancB5XnWYbHAb/3
KCW7wv5ZOfLXqkFe+PQQneS682J/pKwwQzEJK6BUnfTZGHdbRrYlDcQonIw03xnu
DmdgMCRIV/VMaLaz43MrCHXW/AMfVF6LJMPmWge31iTAFzk+7tssTvt0SsfGztLl
dBXkx15aMM8d0HIn7mohu/u02Wn/dhK3UDIAhLyrax5Gu1ClILM54nEmGc1QZ/Uo
3wZY3mI8EYQS8JjPx0bg
=VJIv
-----END PGP SIGNATURE-----

--Sig_/hGfVq_SrrL/sYfAhvY=6dvM--
