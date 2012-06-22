Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:50282 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760258Ab2FVMne (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jun 2012 08:43:34 -0400
Date: Fri, 22 Jun 2012 14:43:11 +0200
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
Message-ID: <20120622124311.GA21606@avionic-0098.mockup.avionic-design.de>
References: <4FDA2DDA.1030704@wwwdotorg.org>
 <20120614192903.GA2212@avionic-0098.mockup.avionic-design.de>
 <4FDA40A0.4030206@wwwdotorg.org>
 <20120615061236.GA4081@avionic-0098.mockup.avionic-design.de>
 <20120619133001.GB24138@avionic-0098.mockup.avionic-design.de>
 <4FE0EFBB.6090206@firmworks.com>
 <20120621064722.GA1122@avionic-0098.mockup.avionic-design.de>
 <CAErSpo6Bpfqm-0yGiBOXEhF4kD3PTDYvWVr0babLZ4GkBLXJiA@mail.gmail.com>
 <20120622110038.GA15212@avionic-0098.mockup.avionic-design.de>
 <CAErSpo6vHn3p96o7DSdL28cjapk2UnQ4ZVJ1oH6ksxbqD=Hh-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
In-Reply-To: <CAErSpo6vHn3p96o7DSdL28cjapk2UnQ4ZVJ1oH6ksxbqD=Hh-g@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 22, 2012 at 05:46:52AM -0600, Bjorn Helgaas wrote:
> On Fri, Jun 22, 2012 at 5:00 AM, Thierry Reding
> <thierry.reding@avionic-design.de> wrote:
> > On Fri, Jun 22, 2012 at 04:18:05AM -0600, Bjorn Helgaas wrote:
> >> On Thu, Jun 21, 2012 at 12:47 AM, Thierry Reding
> >> <thierry.reding@avionic-design.de> wrote:
> >> > On Tue, Jun 19, 2012 at 11:31:39AM -1000, Mitch Bradley wrote:
> >>
> >> >> Version A - 3 address cells: =C2=A0In this version, the intermediate
> >> >> address space has 3 cells: =C2=A0port#, address type, offset. =C2=
=A0Address
> >> >> type is
> >> >> =C2=A0 0 : root port
> >> >> =C2=A0 1 : config space
> >> >> =C2=A0 2 : extended config space
> >> >> =C2=A0 3 : I/O
> >> >> =C2=A0 4 : non-prefetchable memory
> >> >> =C2=A0 5 : prefetchable memory.
> >> >>
> >> >> The third cell "offset" is necessary so that the size field has a
> >> >> number space that can include it.
> >> >>
> >> >> =C2=A0 =C2=A0 =C2=A0 pcie-controller {
> >> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compatible =3D "nv=
idia,tegra20-pcie";
> >> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D <0x8000300=
0 0x00000800 =C2=A0 /* PADS registers */
> >> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A00x80003800 0x00000200>; /* extended configuration space */
> >> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interrupts =3D <0 =
98 0x04 =C2=A0 /* controller interrupt */
> >> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0 99 0x04>; /* MSI interrupt */
> >> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D "disabl=
ed";
> >> >>
> >> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ranges =3D <0 0 0 =
=C2=A00x80000000 0x00001000 =C2=A0 /* Root port 0 */
> >> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 0 1 0 =C2=A00x80004000 0x00080000 =C2=A0 /* Port 0 config=
 space */
> >> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 0 2 0 =C2=A00x80104000 0x00080000 =C2=A0 /* Port 0 ext co=
nfig space *
> >> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 0 3 0 =C2=A00x80400000 0x00008000 =C2=A0 /* Port 0 downst=
ream I/O */
> >> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 0 4 0 =C2=A00x90000000 0x08000000 =C2=A0 /* Port 0 non-pr=
efetchable memory */
> >> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 0 5 0 =C2=A00xa0000000 0x08000000 =C2=A0 /* Port 0 prefet=
chable memory */
> >> >>
> >> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 1 0 0 =C2=A00x80001000 0x00001000 =C2=A0 /* Root port 1 */
> >> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 1 1 0 =C2=A00x80004000 0x00080000 =C2=A0 /* Port 1 config=
 space */
> >> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 1 2 0 =C2=A00x80184000 0x00080000 =C2=A0 /* Port 1 ext co=
nfig space */
> >> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 1 3 0 =C2=A00x80408000 0x00010000 =C2=A0 /* Port 1 downst=
ream I/O */
> >> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 1 4 0 =C2=A00x98000000 0x08000000 =C2=A0 /* Port 1 non-pr=
efetchable memory */
> >> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 1 5 0 =C2=A00xa0000000 0x08000000>; /* Port 1 prefetchabl=
e memory */
> >> >>
> >> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 #address-cells =3D=
 <3>;
> >> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 #size-cells =3D <1=
>;
> >> >>
> >> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pci@0 {
> >> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 reg =3D <0 0 0 0x1000>;
> >> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 status =3D "disabled";
> >> >>
> >> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 #address-cells =3D <3>;
> >> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 #size-cells =3D <2>;
> >> >>
> >> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ranges =3D <0x80000000 0 0 =C2=A00 1 0 =C2=A00 0x00080000 =C2=A0=
 /* config */
> >> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x90000000 0 0 =C2=A00 2 0 =
=C2=A00 0x00080000 =C2=A0 /* extended config */
> >> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x81000000 0 0 =C2=A00 3 0 =
=C2=A00 0x00008000 =C2=A0 /* I/O */
> >> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x82000000 0 0 =C2=A00 4 0 =
=C2=A00 0x08000000 =C2=A0 /* non-prefetchable memory */
> >> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0xc2000000 0 0 =C2=A00 5 0 =
=C2=A00 0x08000000>; /* prefetchable memory */
> >> >>
> >> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 nvidia,ctrl-offset =3D <0x110>;
> >> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 nvidia,num-lanes =3D <2>;
> >> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 };
> >> >>
> >> >>
> >> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pci@1 {
> >> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 reg =3D <1 0 0 0x1000>;
> >> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 status =3D "disabled";
> >> >>
> >> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 #address-cells =3D <3>;
> >> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 #size-cells =3D <2>;
> >> >>
> >> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ranges =3D <0x80000000 0 0 =C2=A01 1 0 =C2=A00 0x00080000 =C2=A0=
 /* config */
> >> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x90000000 0 0 =C2=A01 2 0 =
=C2=A00 0x00080000 =C2=A0 /* extended config */
> >> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x81000000 0 0 =C2=A01 3 0 =
=C2=A00 0x00008000 =C2=A0 /* I/O */
> >> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x82000000 0 0 =C2=A01 4 0 =
=C2=A00 0x08000000 =C2=A0 /* non-prefetchable memory */
> >> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0xc2000000 0 0 =C2=A01 5 0 =
=C2=A00 0x08000000>; /* prefetchable memory */
> >> >>
> >> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 nvidia,ctrl-offset =3D <0x118>;
> >> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 nvidia,num-lanes =3D <2>;
> >> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 };
> >>
> >> I'm not familiar with device tree, so pardon me if these are stupid
> >> questions. =C2=A0These seem to be describing PCI host bridges.
> >
> > Yes, correct.
> >
> >> I assume some of these ranges describe MMIO, prefetchable MMIO, and
> >> I/O port apertures that the bridge forwards to the PCI bus.
> >
> > Yes.
> >
> >> Is there provision for any address offset applied by the bridge when
> >> it forwards downstream? =C2=A0(Maybe these bridges don't apply any off=
set?)
> >> =C2=A0"0xa0000000 0x08000000" appears for both ports 0 and 1 prefetcha=
ble
> >> memory; I don't know if that's an error, an indication that each
> >> bridge applies a different offset, or that both bridges forward the
> >> same aperture (I hope not the latter, because Linux can't really deal
> >> with that).
> >
> > That seems to be a typo. It should have been 0xa8000000 in the second
> > case. The PCIe controller has registers that are programmed with the
> > aperture for the configuration and extended configuration spaces, as
> > well as the downstream I/O, prefetchable and non-prefetchable memory
> > regions.
> >
> > The configuration spaces aren't actually forwarded by the bridges, but
> > are handled only by the controller.
>=20
> Right.  The host bridge (controller) would convert memory accesses on
> the upstream side into PCI config accesses on its downstream PCI
> interface.
>=20
> > The other apertures are programmed
> > into the bridges using standard PCI registers.
>=20
> If you're talking about programming host bridge apertures, there are
> no "standard PCI registers" to do that.  The programming model of the
> host bridge itself is not part of the PCI spec.  PCI-to-PCI bridge
> apertures *are* specified by the PCI Bridge spec, so those are
> standard.

Each of the root ports has a PCI-compatible set of configuration
registers, so I guess what is meant is that the apertures a programmed
according to the PCI bridge specification.

> >> Is the bus number aperture included somewhere? =C2=A0How do we know wh=
at
> >> bus numbers are available for allocation under each bridge?
> >
> > Not yet. I don't think DT imposes a bus number allocation on PCI
> > bridges. However the matching of DT nodes to PCI bridges is done based
> > on the bus number. For that you provide a bus-ranges property which
> > defines the bus aperture of the given PCI bridge. The DT matching code
> > compares the first cell of this property with the primary bus number of
> > the bridge.
>=20
> I don't fully understand this, but I can tell you that things don't
> work very well if we don't know the aperture.  We can make
> assumptions, like the root bus is 00, and then enumerate everything
> reachable from there.  But then all we know is the largest bus number
> actually reachable from bus 00, which is usually smaller then the end
> of the aperture.  We don't know how many unused bus numbers there are
> in the aperture, so we can't safely allocate any for hot-added
> devices.

I think DT support for PCI is lacking in a lot of areas. PowerPC seems
to be the only architecture actively setting up busses according to the
bus-range property specified in the DT. All other architectures seem to
not pre-allocate bus apertures and go with the default instead. From
what you say that means hot-plugging is out. Although I don't think the
Tegra PCIe controller even supports hot-plugging.

> > This is in fact somewhat counter-productive because it requires you to
> > hard-code the PCI hierarchy within the DT and you loose a lot of the
> > probing functionality. This is not much of an issue for typical PCI
> > endpoints (like network cards) but becomes a problem if you have a PCI
> > endpoint that implements an I2C bus and you want to match I2C slaves on
> > that bus to device nodes so that the kernel can parse and instantiate
> > them properly. I guess in the latter cases hard-coding the PCI tree in
> > DT is not actually a drawback, though.
> >
> >> I see mention of config space. =C2=A0Is some of that referring to the =
ECAM
> >> as in 7.2.2 of the PCIe spec v3.0 (what we refer to as MMCONFIG on
> >> x86)?
> >
> > I only have access to the PCIe 2.0 specification, but it seems to
> > contain the same 7.2.2 section. In fact it looks as though this
> > particular controller indeed implements something similar to ECAM. The
> > address mapping is a little different, though:
> >
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0A[(16 + n - 1):16]: bus number
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0A[15:11]: device number
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0A[10:8]: function number
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0A[7:2]: register number
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0A[1:0]: unused
> >
> > That information comes directly from the driver and I have no access to
> > the corresponding documentation. It seems like the extended
> > configuration space is accessed using the same mapping but starting at a
> > different base address.
> >
> > But now that you mention it, maybe the driver code is buggy here, and
> > the controller indeed implements ECAM. Furthermore it also seems like
> > the current code doesn't work for the extended configuration space
> > because while the correct offset into the extended configuration space
> > is chosen, the access to registers is done using the same mapping as
> > above, so instead of the 12 (10) bits required for the register number
> > only 8 (6) are in fact used.
> >
> > I wonder whether anyone's actually tested this.
> >
> > Stephen: can you try to find out whether the Tegra PCIe controller
> > indeed implements ECAM, or if this scheme is actually just a proprietary
> > variant?
>=20
> It'd be a real shame if they made up a proprietary scheme when ECAM
> seems to be required by the spec.  I'm interested because the current
> MMCONFIG code seems unnecessarily x86-specific, and I expect every
> arch with PCIe would want to use ECAM, so maybe there's some chance
> for a generic implementation.

Since this is pretty well specified by PCIe, a generic implementation
should be possible. We'll have to wait for some better documentation on
Tegra to know whether this is actually ECAM or not.

Thierry

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJP5GhfAAoJEN0jrNd/PrOhzwMP/AmqhwVHGOsIbGKxBcDUdcR3
IB+pAoNFHscTVm0zRX6mnxF5arOX59jwQgnpV9F1NqqRW/gQkHSvSjxrmqGuQ3oe
FcQty4SNOoQFf3n4nNhzUdILHkXojiK9QAodl6tCsshjXnyHUqhUd4PMTQOwzr+t
EaxbM12aE2siikKGxD/mvbzTfDsa45eWCKY6cs2u0QLgxcQQQJ3+RCoh/4zHRg1K
N/7lW8Dd00fazlxKs4x9/1nSAS4hQwHfVl04QRmJFQFvBcCHFhgg3cH5352WUMcA
vBKcs0lcIWo5KZeR54wuVwXgEsluFnJqyq413bDBgTe2crRkEA4Pu17zseH4oGC/
mIg+Lg61kbwIjnGtibNYnYId74wt9uQazd0N88Brc7k2SxQtAmBkFVSQ6C/u772E
hsjRcOFCeu4yRQ3hbSOX5mriQoQBw1cDqCbzJRHuoOubr+MXoP0NCEBM72GF9dEa
Uhd1/2ryJ7J5CDUPJuRzNmj8sKo8JnEyCOoKhY+9WxopXO06omitXEhHncrzmsWa
5pv2KSZ704q+eFCVZbgSzEjjq3I6E2ao5IKm/Ss/K72jc4nB9mIa+FKmCMdP3BNx
u0ekENdRKdmBxrT7hZlVdN9V8vRI7ZUL0fN2StAHCdr2qbX3y5HaQ3Trr86jXKiX
85Kt9LPmzbCmxS286LeU
=aNPi
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
