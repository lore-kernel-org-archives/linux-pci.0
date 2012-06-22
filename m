Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:59703 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757820Ab2FVLA6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jun 2012 07:00:58 -0400
Date: Fri, 22 Jun 2012 13:00:38 +0200
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mitch Bradley <wmb@firmworks.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Russell King <linux@arm.linux.org.uk>,
	linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	Rob Herring <rob.herring@calxeda.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Colin Cross <ccross@android.com>, linux-tegra@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 07/10] ARM: tegra: pcie: Add device tree support
Message-ID: <20120622110038.GA15212@avionic-0098.mockup.avionic-design.de>
References: <4FD85127.8050301@firmworks.com>
 <20120614091905.GA9081@avionic-0098.mockup.avionic-design.de>
 <4FDA2DDA.1030704@wwwdotorg.org>
 <20120614192903.GA2212@avionic-0098.mockup.avionic-design.de>
 <4FDA40A0.4030206@wwwdotorg.org>
 <20120615061236.GA4081@avionic-0098.mockup.avionic-design.de>
 <20120619133001.GB24138@avionic-0098.mockup.avionic-design.de>
 <4FE0EFBB.6090206@firmworks.com>
 <20120621064722.GA1122@avionic-0098.mockup.avionic-design.de>
 <CAErSpo6Bpfqm-0yGiBOXEhF4kD3PTDYvWVr0babLZ4GkBLXJiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
In-Reply-To: <CAErSpo6Bpfqm-0yGiBOXEhF4kD3PTDYvWVr0babLZ4GkBLXJiA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 22, 2012 at 04:18:05AM -0600, Bjorn Helgaas wrote:
> On Thu, Jun 21, 2012 at 12:47 AM, Thierry Reding
> <thierry.reding@avionic-design.de> wrote:
> > On Tue, Jun 19, 2012 at 11:31:39AM -1000, Mitch Bradley wrote:
>=20
> >> Version A - 3 address cells: =C2=A0In this version, the intermediate
> >> address space has 3 cells: =C2=A0port#, address type, offset. =C2=A0Ad=
dress
> >> type is
> >> =C2=A0 0 : root port
> >> =C2=A0 1 : config space
> >> =C2=A0 2 : extended config space
> >> =C2=A0 3 : I/O
> >> =C2=A0 4 : non-prefetchable memory
> >> =C2=A0 5 : prefetchable memory.
> >>
> >> The third cell "offset" is necessary so that the size field has a
> >> number space that can include it.
> >>
> >> =C2=A0 =C2=A0 =C2=A0 pcie-controller {
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compatible =3D "nvidi=
a,tegra20-pcie";
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D <0x80003000 0=
x00000800 =C2=A0 /* PADS registers */
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A00x80003800 0x00000200>; /* extended configuration space */
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupts =3D <0 98 =
0x04 =C2=A0 /* controller interrupt */
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 0 99 0x04>; /* MSI interrupt */
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D "disabled";
> >>
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ranges =3D <0 0 0 =C2=
=A00x80000000 0x00001000 =C2=A0 /* Root port 0 */
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 0 1 0 =C2=A00x80004000 0x00080000 =C2=A0 /* Port 0 config spa=
ce */
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 0 2 0 =C2=A00x80104000 0x00080000 =C2=A0 /* Port 0 ext config=
 space *
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 0 3 0 =C2=A00x80400000 0x00008000 =C2=A0 /* Port 0 downstream=
 I/O */
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 0 4 0 =C2=A00x90000000 0x08000000 =C2=A0 /* Port 0 non-prefet=
chable memory */
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 0 5 0 =C2=A00xa0000000 0x08000000 =C2=A0 /* Port 0 prefetchab=
le memory */
> >>
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 1 0 0 =C2=A00x80001000 0x00001000 =C2=A0 /* Root port 1 */
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 1 1 0 =C2=A00x80004000 0x00080000 =C2=A0 /* Port 1 config spa=
ce */
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 1 2 0 =C2=A00x80184000 0x00080000 =C2=A0 /* Port 1 ext config=
 space */
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 1 3 0 =C2=A00x80408000 0x00010000 =C2=A0 /* Port 1 downstream=
 I/O */
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 1 4 0 =C2=A00x98000000 0x08000000 =C2=A0 /* Port 1 non-prefet=
chable memory */
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 1 5 0 =C2=A00xa0000000 0x08000000>; /* Port 1 prefetchable me=
mory */
> >>
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 #address-cells =3D <3=
>;
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 #size-cells =3D <1>;
> >>
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pci@0 {
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 reg =3D <0 0 0 0x1000>;
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 status =3D "disabled";
> >>
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 #address-cells =3D <3>;
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 #size-cells =3D <2>;
> >>
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ranges =3D <0x80000000 0 0 =C2=A00 1 0 =C2=A00 0x00080000 =C2=A0 /* =
config */
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x90000000 0 0 =C2=A00 2 0 =C2=A0=
0 0x00080000 =C2=A0 /* extended config */
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x81000000 0 0 =C2=A00 3 0 =C2=A0=
0 0x00008000 =C2=A0 /* I/O */
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x82000000 0 0 =C2=A00 4 0 =C2=A0=
0 0x08000000 =C2=A0 /* non-prefetchable memory */
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0xc2000000 0 0 =C2=A00 5 0 =C2=A0=
0 0x08000000>; /* prefetchable memory */
> >>
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 nvidia,ctrl-offset =3D <0x110>;
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 nvidia,num-lanes =3D <2>;
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 };
> >>
> >>
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pci@1 {
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 reg =3D <1 0 0 0x1000>;
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 status =3D "disabled";
> >>
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 #address-cells =3D <3>;
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 #size-cells =3D <2>;
> >>
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ranges =3D <0x80000000 0 0 =C2=A01 1 0 =C2=A00 0x00080000 =C2=A0 /* =
config */
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x90000000 0 0 =C2=A01 2 0 =C2=A0=
0 0x00080000 =C2=A0 /* extended config */
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x81000000 0 0 =C2=A01 3 0 =C2=A0=
0 0x00008000 =C2=A0 /* I/O */
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x82000000 0 0 =C2=A01 4 0 =C2=A0=
0 0x08000000 =C2=A0 /* non-prefetchable memory */
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0xc2000000 0 0 =C2=A01 5 0 =C2=A0=
0 0x08000000>; /* prefetchable memory */
> >>
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 nvidia,ctrl-offset =3D <0x118>;
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 nvidia,num-lanes =3D <2>;
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 };
>=20
> I'm not familiar with device tree, so pardon me if these are stupid
> questions.  These seem to be describing PCI host bridges.

Yes, correct.

> I assume some of these ranges describe MMIO, prefetchable MMIO, and
> I/O port apertures that the bridge forwards to the PCI bus.

Yes.

> Is there provision for any address offset applied by the bridge when
> it forwards downstream?  (Maybe these bridges don't apply any offset?)
>  "0xa0000000 0x08000000" appears for both ports 0 and 1 prefetchable
> memory; I don't know if that's an error, an indication that each
> bridge applies a different offset, or that both bridges forward the
> same aperture (I hope not the latter, because Linux can't really deal
> with that).

That seems to be a typo. It should have been 0xa8000000 in the second
case. The PCIe controller has registers that are programmed with the
aperture for the configuration and extended configuration spaces, as
well as the downstream I/O, prefetchable and non-prefetchable memory
regions.

The configuration spaces aren't actually forwarded by the bridges, but
are handled only by the controller. The other apertures are programmed
into the bridges using standard PCI registers.

> Is the bus number aperture included somewhere?  How do we know what
> bus numbers are available for allocation under each bridge?

Not yet. I don't think DT imposes a bus number allocation on PCI
bridges. However the matching of DT nodes to PCI bridges is done based
on the bus number. For that you provide a bus-ranges property which
defines the bus aperture of the given PCI bridge. The DT matching code
compares the first cell of this property with the primary bus number of
the bridge.

This is in fact somewhat counter-productive because it requires you to
hard-code the PCI hierarchy within the DT and you loose a lot of the
probing functionality. This is not much of an issue for typical PCI
endpoints (like network cards) but becomes a problem if you have a PCI
endpoint that implements an I2C bus and you want to match I2C slaves on
that bus to device nodes so that the kernel can parse and instantiate
them properly. I guess in the latter cases hard-coding the PCI tree in
DT is not actually a drawback, though.

> I see mention of config space.  Is some of that referring to the ECAM
> as in 7.2.2 of the PCIe spec v3.0 (what we refer to as MMCONFIG on
> x86)?

I only have access to the PCIe 2.0 specification, but it seems to
contain the same 7.2.2 section. In fact it looks as though this
particular controller indeed implements something similar to ECAM. The
address mapping is a little different, though:

	A[(16 + n - 1):16]: bus number
	A[15:11]: device number
	A[10:8]: function number
	A[7:2]: register number
	A[1:0]: unused

That information comes directly from the driver and I have no access to
the corresponding documentation. It seems like the extended
configuration space is accessed using the same mapping but starting at a
different base address.

But now that you mention it, maybe the driver code is buggy here, and
the controller indeed implements ECAM. Furthermore it also seems like
the current code doesn't work for the extended configuration space
because while the correct offset into the extended configuration space
is chosen, the access to registers is done using the same mapping as
above, so instead of the 12 (10) bits required for the register number
only 8 (6) are in fact used.

I wonder whether anyone's actually tested this.

Stephen: can you try to find out whether the Tegra PCIe controller
indeed implements ECAM, or if this scheme is actually just a proprietary
variant?

Thierry

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJP5FBWAAoJEN0jrNd/PrOhdccP/REYf8WP9pry4MnBCAUfMih6
1LZVVcZtpyGcwdkRaNS0ywyoizwaa+ZpxJP5BamEQWFgxt4F4KRreVjr7FTicgeT
hTSllZ05ZW9eideSJ2/0AbQOfVhFqN8axP3+P5uz7Ti3xJjscnWqIN1pDW3FLYkT
GcABTWY9GLj/HlJ6f0wURoNPxUUQOhLzMtSL+ectgozm8XdP2cUvU8S8lp1wVkgK
KfKlFVfkJ30OtDAegviLXUUKD0+YY+ywSn9EAEwMMFxJqLJ0EDW5Ns5Cm95Pf+IY
lPslfTYFefbvTargqXsolf/KItGIxrIhq/1Q2wSn5Wx1+B0XKE1Q4kc6x3dlq5JZ
/2y/MUZdZsQcGYJJJ/ZNcg3gVgez4rVenQv62W7mw94nBMu8ovnsUvvf0K4al9k6
BnB7/H05ijadSj2h2w6kGyuVi2L/+HffZrEcWIh6jPhFFsPsucEvKWZ2gul+PdLO
6kVUpn7Qq/tLTEg+f6AZpKstaGwA22zIQFkQY5Ii066GvGwOmvPlEQr3GS5+D97F
QY9twpdjRfjleVNXR2sBhg29dYgFCVDd/Vyn6fLndiPacfHkszTZL7TpWQJ7HJ+Q
NyoBFoZ5rsbZg7va2lKaVWe6o/voJTkZjwpmziAfFFKIwHBwTVV7SuL4prOG/6G8
VO2rqgropxnIYU+YKRYR
=EA83
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
