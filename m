Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.gw90.de ([188.40.100.199]:44209 "EHLO mail.gw90.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753856AbcEPUhj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 16 May 2016 16:37:39 -0400
Message-ID: <1463431052.1983.57.camel@users.sourceforge.net>
Subject: Re: `pcilib: sysfs_read_vpd: read failed: Input/output error` on
 ASRock E350M1
From: Paul Menzel <paulepanter@users.sourceforge.net>
To: Myron Stowe <myron.stowe@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Date: Mon, 16 May 2016 22:37:32 +0200
In-Reply-To: <CAL-B5D19esStG0=nbUa-mJggtRDX94t542Vzz1=u_avq9qRgYQ@mail.gmail.com>
References: <1463331375.6071.39.camel@users.sourceforge.net>
	 <CAL-B5D19esStG0=nbUa-mJggtRDX94t542Vzz1=u_avq9qRgYQ@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-/aOEU54DtYUAR1KdjAV8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--=-/aOEU54DtYUAR1KdjAV8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Myron,


thank you for your response.


Am Montag, den 16.05.2016, 12:02 -0600 schrieb Myron Stowe:
> On Sun, May 15, 2016 at 10:56 AM, Paul Menzel wrote:

[=E2=80=A6]

> > Is that related to [1]?
>
> There have been a number of recent kernel commits to work-around know
> buggy devices -
> =C2=A0 v4.6-rc5
> =C2=A0=C2=A0=C2=A0=C2=A067e6587=C2=A0=C2=A0cxgb4: Set VPD size so we can =
read both VPD structures
> =C2=A0=C2=A0=C2=A0=C2=A0cb92148=C2=A0=C2=A0PCI: Add pci_set_vpd_size() to=
 set VPD size
> =C2=A0 v4.6 -
> =C2=A0=C2=A0=C2=A0=C2=A07c20078=C2=A0=C2=A0PCI: Prevent VPD access for bu=
ggy devices
> =C2=A0=C2=A0=C2=A0=C2=A0c521b01=C2=A0=C2=A0PCI: Sleep rather than busy-wa=
it for VPD access completion
> =C2=A0=C2=A0=C2=A0=C2=A0408641e=C2=A0=C2=A0PCI: Fold struct pci_vpd_pci22=
 into struct pci_vpd
> =C2=A0=C2=A0=C2=A0=C2=A0f1cd93f=C2=A0=C2=A0PCI: Rename VPD symbols to rem=
ove unnecessary "pci22"
> =C2=A0=C2=A0=C2=A0=C2=A0da00684=C2=A0=C2=A0PCI: Remove struct pci_vpd_ops=
.release function pointer
> =C2=A0=C2=A0=C2=A0=C2=A06437907=C2=A0=C2=A0PCI: Move pci_vpd_release() fr=
om header file to pci/access.c
> =C2=A0=C2=A0=C2=A0=C2=A0fc0a407=C2=A0=C2=A0PCI: Move pci_read_vpd() and p=
ci_write_vpd() close to other code
> =C2=A0=C2=A0=C2=A0=C2=A0104daa7=C2=A0=C2=A0PCI: Determine actual VPD size=
 on first access
> =C2=A0=C2=A0=C2=A0=C2=A0c556388=C2=A0=C2=A0PCI: Use bitfield instead of b=
ool for struct pci_vpd_pci22.busy
> =C2=A0=C2=A0=C2=A0=C2=A0f52e562=C2=A0=C2=A0PCI: Allow access to VPD attri=
butes with size 0
> =C2=A0=C2=A0=C2=A0=C2=A09eb45d5=C2=A0=C2=A0PCI: Update VPD definitions
> =C2=A0 v4.3 -
> =C2=A0=C2=A0=C2=A0=C2=A0da2d03e=C2=A0=C2=A0PCI: Use function 0 VPD only f=
or identical functions
> =C2=A0=C2=A0=C2=A0=C2=A09d92407=C2=A0=C2=A0PCI: Fix devfn for VPD access =
through function 0
> =C2=A0=C2=A0=C2=A0=C2=A07aa6ca4=C2=A0=C2=A0PCI: Add VPD function 0 quirk =
for Intel Ethernet devices
> =C2=A0=C2=A0=C2=A0=C2=A0932c435=C2=A0=C2=A0PCI: Add dev_flags bit to acce=
ss VPD through function 0
>=20
> What were you getting/seeing before?

The error wasn=E2=80=99t shown. Sorry if that is not a helpful answer. If I
provide more information, please tell me how I can get them.

You can find a lot of lspci output for the ASRock E350M1 in coreboot=E2=80=
=99s
board status repository [2].


Thanks,

Paul


> > [1] https://lkml.org/lkml/2016/4/15/649
[2]=C2=A0http://review.coreboot.org/cgit/board-status.git/tree/asrock/e350m=
1
--=-/aOEU54DtYUAR1KdjAV8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlc6L4wACgkQPX1aK2wOHViJ5gCbB/Tz4fnw7me1t8G6NpT7GS4V
EugAnifgglH42SaZHqAy5hFkaF+qULFM
=qqgU
-----END PGP SIGNATURE-----

--=-/aOEU54DtYUAR1KdjAV8--

