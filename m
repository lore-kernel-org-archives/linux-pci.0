Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.gw90.de ([188.40.100.199]:52724 "EHLO mail.gw90.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751173AbcFKMMJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sat, 11 Jun 2016 08:12:09 -0400
Message-ID: <1465647122.2279.18.camel@users.sourceforge.net>
Subject: Re: `pcilib: sysfs_read_vpd: read failed: Input/output error` on
 ASRock E350M1
From: Paul Menzel <paulepanter@users.sourceforge.net>
To: Myron Stowe <myron.stowe@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Date: Sat, 11 Jun 2016 14:12:02 +0200
In-Reply-To: <1463861932.2810.8.camel@users.sourceforge.net>
References: <1463331375.6071.39.camel@users.sourceforge.net>
	<CAL-B5D19esStG0=nbUa-mJggtRDX94t542Vzz1=u_avq9qRgYQ@mail.gmail.com>
	<1463431052.1983.57.camel@users.sourceforge.net>
	<CAL-B5D3xNYe_roUDXLTYeYP+UijwQDxQ4j7Vr0-ETUyC4hE44Q@mail.gmail.com>
	<1463520103.2290.101.camel@users.sourceforge.net>
	 <CAL-B5D1Ao6Soj+T6qEH5pYO9vWY4A3+G0r2bdBHxvuNbK3FkUg@mail.gmail.com>
	 <1463861932.2810.8.camel@users.sourceforge.net>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-vhRYtEGdeEVxNKw8cRVM"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--=-vhRYtEGdeEVxNKw8cRVM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Myron, dear Linux folks,


Am Samstag, den 21.05.2016, 22:18 +0200 schrieb Paul Menzel:

> Am Dienstag, den 17.05.2016, 19:52 -0600 schrieb Myron Stowe:
> > On Tue, May 17, 2016 at 3:21 PM, Paul Menzel wrote:
>=20
> > > Am Montag, den 16.05.2016, 19:42 -0600 schrieb Myron Stowe:
> > > > On Mon, May 16, 2016 at 2:37 PM, Paul Menzel wrote:
> > >=20
> > > > > Am Montag, den 16.05.2016, 12:02 -0600 schrieb Myron Stowe:
> > > > > >=20
> > > > > > On Sun, May 15, 2016 at 10:56 AM, Paul Menzel wrote:
> > > > > [=E2=80=A6]
> > > > > > >=20
> > > > > > > Is that related to [1]?
> > > > > > There have been a number of recent kernel commits to work-aroun=
d know
> > > > > > buggy devices -
> > > > > > =C2=A0 v4.6-rc5
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A067e6587=C2=A0=C2=A0cxgb4: Set VPD size =
so we can read both VPD structures
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0cb92148=C2=A0=C2=A0PCI: Add pci_set_vpd=
_size() to set VPD size
> > > > > > =C2=A0 v4.6 -
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A07c20078=C2=A0=C2=A0PCI: Prevent VPD acc=
ess for buggy devices
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0c521b01=C2=A0=C2=A0PCI: Sleep rather th=
an busy-wait for VPD access completion
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0408641e=C2=A0=C2=A0PCI: Fold struct pci=
_vpd_pci22 into struct pci_vpd
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0f1cd93f=C2=A0=C2=A0PCI: Rename VPD symb=
ols to remove unnecessary "pci22"
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0da00684=C2=A0=C2=A0PCI: Remove struct p=
ci_vpd_ops.release function pointer
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A06437907=C2=A0=C2=A0PCI: Move pci_vpd_re=
lease() from header file to pci/access.c
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0fc0a407=C2=A0=C2=A0PCI: Move pci_read_v=
pd() and pci_write_vpd() close to other code
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0104daa7=C2=A0=C2=A0PCI: Determine actua=
l VPD size on first access
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0c556388=C2=A0=C2=A0PCI: Use bitfield in=
stead of bool for struct pci_vpd_pci22.busy
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0f52e562=C2=A0=C2=A0PCI: Allow access to=
 VPD attributes with size 0
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A09eb45d5=C2=A0=C2=A0PCI: Update VPD defi=
nitions
> > > > > > =C2=A0 v4.3 -
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0da2d03e=C2=A0=C2=A0PCI: Use function 0 =
VPD only for identical functions
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A09d92407=C2=A0=C2=A0PCI: Fix devfn for V=
PD access through function 0
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A07aa6ca4=C2=A0=C2=A0PCI: Add VPD functio=
n 0 quirk for Intel Ethernet devices
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0932c435=C2=A0=C2=A0PCI: Add dev_flags b=
it to access VPD through function 0
> > > > > >=20
> > > > > > What were you getting/seeing before?
> > > > > The error wasn=E2=80=99t shown. Sorry if that is not a helpful an=
swer. If I
> > > > > provide more information, please tell me how I can get them.
> > > > I expect that prior to the kernel updates you were seeing:
> > > >=20
> > > > lspci -s 3:0 -vv
> > > > ...
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Capabilities: [d0] =
Vital Product Data
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Unknown small resource type 00, will not deco=
de more.
> > > > ...
> > >=20
> > > From logs stored in coreboot=E2=80=99s board status repository [2].
> > >=20
> > > ```
> > > $ more asrock/e350m1/4.3-817-g477a0d6/2016-04-22T18_41_34Z/lspci-vvxx=
x.txt
> > > [=E2=80=A6]
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Capabilities: [d0] Vital Pr=
oduct Data
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0No end tag found
> > > [=E2=80=A6]
> > > ```
> >=20
> > The above - "No end tag found" - is from 'lspci' reading the VPD area
> > and parsing it looking for an small resource data type "End Tag"
> > (0x0f) and never finding one.=C2=A0=C2=A0Thus it seems like the VPD are=
a is
> > malformed at best.
> >=20
> > > > and with 'xxd', looking at the VPD area you likely would have seen:
> > > >=20
> > > > # xxd /sys/bus/pci/devices/0000\:03\:00.0/vpd
> > > > 0000000: 0000 0000 0000 0000 0000 0000 0000 0000=C2=A0=C2=A0.......=
.........
> > > > 0000010: 0000 0000 0000 0000 0000 0000 0000 0000=C2=A0=C2=A0.......=
.........
> > > > 0000020: 0000 0000 0000 0000 0000 0000 0000 0000=C2=A0=C2=A0.......=
.........
> > > > ...
> > > >=20
> > > > and nothing in the 'dmesg' logs.
> > >=20
> > > ```
> > > $ more asrock/e350m1/4.3-817-g477a0d6/2016-04-22T18_41_34Z/lspci-vvxx=
x.txt
> > > [=E2=80=A6]
> > > c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > e0: 10 00 01 01 01 12 63 80 00 00 00 00 00 00 00 00
> > > f0: 00 00 00 00 00 80 80 00 00 00 00 00 00 00 00 00
> > > [=E2=80=A6]
> > > ```
> >=20
> > Careful here, the above is _not_ the VPD area.=C2=A0=C2=A0The above is =
the
> > device's standard PCI (type 0) configuration header registers [I'm
> > thinking you mistook the 0xd0 from "Capabilities: [d0] Vital Product
> > Data" and thought that was the offset for the VPD area - it is not.
> > To get to the VPD area one has to manipulate a couple of VPD registers
> > which is basically obtaining the VPD bytes from within the device
> > itself (i.e. from within the device's firmware)].
> >=20
> > To get the VPD area you will need to run a kernel prior to the commits
> > I pointed out and then use 'xxd' as shown above to gain insight into
> > what, if anything, is really there.
> >=20
> > > There is nothing in the Linux 3.16 messages.
> > >=20
> > > > With the recent kernel updates you see the new output from the kern=
el
> > > > and 'lspci -vv' that started this thread.=C2=A0=C2=A0I expect that =
you also get
> > > > something close to the following from 'xxd':
> > > >=20
> > > > # xxd /sys/bus/pci/devices/0000\:03\:00.0/vpd
> > > > xxd: Input/output error
> > >=20
> > > Correct.
> > >=20
> > > > and also see the following in the 'dmesg' logs.
> > > >=20
> > > > # dmesg | grep VPD
> > > > r8169 0000:03:00.0: invalid short VPD tag 00 at offset 1
> > >=20
> > > Indeed similar:
> > >=20
> > > ```
> > > $ dmesg | grep VPD
> > > [15841.258561] r8169 0000:03:00.0: invalid large VPD tag 7f at offset=
 0
> > > ```
> >=20
> > Humm, the above is interesting to me in that it implies that the VPD
> > area is not necessarily all 0's as I was expecting.=C2=A0=C2=A0A "Large=
 VPD tag"
> > is denoted by the most significant bit of the first byte being set.
> > However, the value denoted - 0x7f - does not have the MSB set so now
> > I'm a bit confused (perhaps the MSB is stripped off - I'll need to
> > look at the related code).=C2=A0=C2=A0Either way, its looking like perh=
aps the
> > VPD area is not all 0's so I'd really be interested in knowing what is
> > there.
> >=20
> > Ok, looking at the code - ./drivers/pci/access.c::pci_vpd_size() - the
> > tag value output - 7f - had its MSB stripped off via
> > 'pci_vpd_lrdt_tag()'.=C2=A0=C2=A0So what must have been read for the fi=
rst byte
> > was 0xff.
> >=20
> > > > The new kernel behavior is correct in its complaint as the device i=
s
> > > > advertising that it has VPD via a 'capability' yet its VPD data are=
a
> > > > is likely all 0's.=C2=A0=C2=A0This is a device error - specifically=
 an error
> > > > with the device's firmware: either it should _not_ advertise via th=
e
> > > > 'capability' that it has VPD or, it s VPD area needs to conform to =
the
> > > > VPD data format as expressed in the "PCI Local Bus Specification, R=
ev.
> > > > 3.0" appendix I - "Vital Product Data".
> > > >=20
> > > > With the new kernel behavior, effectively circumventing reading of =
an
> > > > invalid VPD area, you can't get to the data via "# xxd" (as shown
> > > > above).=C2=A0=C2=A0You could run a kernel prior to the changes and =
run the "xxd"
> > > > command and likely see that the VPD area is all 0's.=C2=A0=C2=A0I w=
ould be
> > > > interested in confirming such if you could do so please.
> > >=20
> > > Please see the paste above. Please tell me if I missed something.
> >=20
> > I have to admit I'm a bit surprised at this point (that the VPD area
> > is not all 0's as I was expecting).=C2=A0=C2=A0The only way we'll know =
is to
> > obtain the VPD area - if you can get that via 'xxd' it would be
> > interesting to see what is there exactly.
>=20
> Checking with xxd under Linux 3.19, the VPD area is all 0xff. Please
> find the file obtained by the command below attached.
>=20
> ```
> $ sudo cp /sys/devices/pci0000:00/0000:00:15.1/0000:03:00.0/vpd /tmp/2016=
0521--realtek-vpd.bin
> $ ls -l /tmp/20160521--realtek-vpd.bin
> -rw------- 1 root root 32768 Mai 21 20:49 /tmp/20160521--realtek-vpd.bin
> ```
>=20
> > > So what to do about this? Contact Realtek? Add a workaround?
> >=20
> > The VPD area is almost certainly malformed (or doesn't exist at all).
> > As a colleague of mine noted today, LSI devices seem to be especially
> > negligent in this manner (see commit 7c20078 ("PCI: Prevent VPD access
> > for buggy devices")).=C2=A0=C2=A0Assuming the VPD area of this device i=
s at best
> > invalid then the kernel is correct in its current behavior - not much
> > more it can do.=C2=A0=C2=A0While it would be good for the device's firm=
ware to
> > be upgraded to either not advertise it has VPD or to put in valid VPD,
> > I very much doubt you'd get any traction there.=C2=A0=C2=A0You could tr=
y adding
> > this device's signature (device and vendor id) to the 7c20078 quirk
> > and see if there is any subtle difference.=C2=A0=C2=A0If there was, it'=
d be very
> > subtle at best.
> >=20
> > All that aside, you are just questioning the error output - correct
> > (i.e. you are not expecting, nor needing, valid VPD content for some
> > reason and questioning that I assume)?
>=20
> Correct. I was just surprised by the error by lspci, as I hadn=E2=80=99t =
seen
> it before.

Were you able to look at the VPD data I sent? If it=E2=80=99s not following=
 the
standard, could you please confirm that, and tell me, what I could
report to the manufacturer?


Thanks,

Paul


> > > > > > > [1] https://lkml.org/lkml/2016/4/15/649
> > > > > [2] http://review.coreboot.org/cgit/board-status.git/tree/asrock/=
e350m1
--=-vhRYtEGdeEVxNKw8cRVM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAldcABIACgkQPX1aK2wOHVhrdQCfQt+uZ7oz+KpcWYJPRCVrYzWt
Vu0AoIyriTVTF2TH98LuB7MGSvrDwPZv
=9rxb
-----END PGP SIGNATURE-----

--=-vhRYtEGdeEVxNKw8cRVM--

