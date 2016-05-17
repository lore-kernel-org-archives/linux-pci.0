Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.gw90.de ([188.40.100.199]:44565 "EHLO mail.gw90.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751120AbcEQVVw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 17 May 2016 17:21:52 -0400
Message-ID: <1463520103.2290.101.camel@users.sourceforge.net>
Subject: Re: `pcilib: sysfs_read_vpd: read failed: Input/output error` on
 ASRock E350M1
From: Paul Menzel <paulepanter@users.sourceforge.net>
To: Myron Stowe <myron.stowe@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci <linux-pci@vger.kernel.org>
Date: Tue, 17 May 2016 23:21:43 +0200
In-Reply-To: <CAL-B5D3xNYe_roUDXLTYeYP+UijwQDxQ4j7Vr0-ETUyC4hE44Q@mail.gmail.com>
References: <1463331375.6071.39.camel@users.sourceforge.net>
	 <CAL-B5D19esStG0=nbUa-mJggtRDX94t542Vzz1=u_avq9qRgYQ@mail.gmail.com>
	 <1463431052.1983.57.camel@users.sourceforge.net>
	 <CAL-B5D3xNYe_roUDXLTYeYP+UijwQDxQ4j7Vr0-ETUyC4hE44Q@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-5cNA8yc5qwL3F4sznOwp"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--=-5cNA8yc5qwL3F4sznOwp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Myron,


Am Montag, den 16.05.2016, 19:42 -0600 schrieb Myron Stowe:
> On Mon, May 16, 2016 at 2:37 PM, Paul Menzel wrote:

> > Am Montag, den 16.05.2016, 12:02 -0600 schrieb Myron Stowe:
> > >=20
> > > On Sun, May 15, 2016 at 10:56 AM, Paul Menzel wrote:
> > [=E2=80=A6]
> > > >=20
> > > > Is that related to [1]?
> > > There have been a number of recent kernel commits to work-around know
> > > buggy devices -
> > > =C2=A0 v4.6-rc5
> > > =C2=A0=C2=A0=C2=A0=C2=A067e6587=C2=A0=C2=A0cxgb4: Set VPD size so we =
can read both VPD structures
> > > =C2=A0=C2=A0=C2=A0=C2=A0cb92148=C2=A0=C2=A0PCI: Add pci_set_vpd_size(=
) to set VPD size
> > > =C2=A0 v4.6 -
> > > =C2=A0=C2=A0=C2=A0=C2=A07c20078=C2=A0=C2=A0PCI: Prevent VPD access fo=
r buggy devices
> > > =C2=A0=C2=A0=C2=A0=C2=A0c521b01=C2=A0=C2=A0PCI: Sleep rather than bus=
y-wait for VPD access completion
> > > =C2=A0=C2=A0=C2=A0=C2=A0408641e=C2=A0=C2=A0PCI: Fold struct pci_vpd_p=
ci22 into struct pci_vpd
> > > =C2=A0=C2=A0=C2=A0=C2=A0f1cd93f=C2=A0=C2=A0PCI: Rename VPD symbols to=
 remove unnecessary "pci22"
> > > =C2=A0=C2=A0=C2=A0=C2=A0da00684=C2=A0=C2=A0PCI: Remove struct pci_vpd=
_ops.release function pointer
> > > =C2=A0=C2=A0=C2=A0=C2=A06437907=C2=A0=C2=A0PCI: Move pci_vpd_release(=
) from header file to pci/access.c
> > > =C2=A0=C2=A0=C2=A0=C2=A0fc0a407=C2=A0=C2=A0PCI: Move pci_read_vpd() a=
nd pci_write_vpd() close to other code
> > > =C2=A0=C2=A0=C2=A0=C2=A0104daa7=C2=A0=C2=A0PCI: Determine actual VPD =
size on first access
> > > =C2=A0=C2=A0=C2=A0=C2=A0c556388=C2=A0=C2=A0PCI: Use bitfield instead =
of bool for struct pci_vpd_pci22.busy
> > > =C2=A0=C2=A0=C2=A0=C2=A0f52e562=C2=A0=C2=A0PCI: Allow access to VPD a=
ttributes with size 0
> > > =C2=A0=C2=A0=C2=A0=C2=A09eb45d5=C2=A0=C2=A0PCI: Update VPD definition=
s
> > > =C2=A0 v4.3 -
> > > =C2=A0=C2=A0=C2=A0=C2=A0da2d03e=C2=A0=C2=A0PCI: Use function 0 VPD on=
ly for identical functions
> > > =C2=A0=C2=A0=C2=A0=C2=A09d92407=C2=A0=C2=A0PCI: Fix devfn for VPD acc=
ess through function 0
> > > =C2=A0=C2=A0=C2=A0=C2=A07aa6ca4=C2=A0=C2=A0PCI: Add VPD function 0 qu=
irk for Intel Ethernet devices
> > > =C2=A0=C2=A0=C2=A0=C2=A0932c435=C2=A0=C2=A0PCI: Add dev_flags bit to =
access VPD through function 0
> > >=20
> > > What were you getting/seeing before?
> > The error wasn=E2=80=99t shown. Sorry if that is not a helpful answer. =
If I
> > provide more information, please tell me how I can get them.
> I expect that prior to the kernel updates you were seeing:
>=20
> lspci -s 3:0 -vv
> ...
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Capabilities: [d0] Vital =
Product Data
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0Unknown small resource type 00, will not decode mor=
e.
> ...

=46rom logs stored in coreboot=E2=80=99s board status repository [2].

```
$ more asrock/e350m1/4.3-817-g477a0d6/2016-04-22T18_41_34Z/lspci-vvxxx.txt
[=E2=80=A6]
=C2=A0 =C2=A0 =C2=A0 =C2=A0Capabilities: [d0] Vital Product Data
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0No end tag found
[=E2=80=A6]
```

> and with 'xxd', looking at the VPD area you likely would have seen:
>=20
> # xxd /sys/bus/pci/devices/0000\:03\:00.0/vpd
> 0000000: 0000 0000 0000 0000 0000 0000 0000 0000=C2=A0=C2=A0.............=
...
> 0000010: 0000 0000 0000 0000 0000 0000 0000 0000=C2=A0=C2=A0.............=
...
> 0000020: 0000 0000 0000 0000 0000 0000 0000 0000=C2=A0=C2=A0.............=
...
> ...
>=20
> and nothing in the 'dmesg' logs.

```
$ more asrock/e350m1/4.3-817-g477a0d6/2016-04-22T18_41_34Z/lspci-vvxxx.txt
[=E2=80=A6]
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 10 00 01 01 01 12 63 80 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 80 80 00 00 00 00 00 00 00 00 00
[=E2=80=A6]
```

There is nothing in the Linux 3.16 messages.

> With the recent kernel updates you see the new output from the kernel
> and 'lspci -vv' that started this thread.=C2=A0=C2=A0I expect that you al=
so get
> something close to the following from 'xxd':
>=20
> # xxd /sys/bus/pci/devices/0000\:03\:00.0/vpd
> xxd: Input/output error

Correct.

> and also see the following in the 'dmesg' logs.
>=20
> # dmesg | grep VPD
> r8169 0000:03:00.0: invalid short VPD tag 00 at offset 1

Indeed similar:

```
$ dmesg | grep VPD
[15841.258561] r8169 0000:03:00.0: invalid large VPD tag 7f at offset 0
```

> The new kernel behavior is correct in its complaint as the device is
> advertising that it has VPD via a 'capability' yet its VPD data area
> is likely all 0's.=C2=A0=C2=A0This is a device error - specifically an er=
ror
> with the device's firmware: either it should _not_ advertise via the
> 'capability' that it has VPD or, it s VPD area needs to conform to the
> VPD data format as expressed in the "PCI Local Bus Specification, Rev.
> 3.0" appendix I - "Vital Product Data".
>=20
> With the new kernel behavior, effectively circumventing reading of an
> invalid VPD area, you can't get to the data via "# xxd" (as shown
> above).=C2=A0=C2=A0You could run a kernel prior to the changes and run th=
e "xxd"
> command and likely see that the VPD area is all 0's.=C2=A0=C2=A0I would b=
e
> interested in confirming such if you could do so please.

Please see the paste above. Please tell me if I missed something.

So what to do about this? Contact Realtek? Add a workaround?


Thanks,

Paul


> > > > [1] https://lkml.org/lkml/2016/4/15/649
> > [2] http://review.coreboot.org/cgit/board-status.git/tree/asrock/e350m1
--=-5cNA8yc5qwL3F4sznOwp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlc7i2oACgkQPX1aK2wOHVgYqgCeL8j/SE3xioTCaLfZ6rpd3j9m
wS0AnR8SeIisBxbM/XSt963OjVVde33B
=YU7A
-----END PGP SIGNATURE-----

--=-5cNA8yc5qwL3F4sznOwp--

