Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:49858 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758179Ab2FVLEW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jun 2012 07:04:22 -0400
Date: Fri, 22 Jun 2012 13:04:03 +0200
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Mitch Bradley <wmb@firmworks.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>,
	Russell King <linux@arm.linux.org.uk>,
	linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	Rob Herring <rob.herring@calxeda.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Colin Cross <ccross@android.com>, linux-tegra@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 07/10] ARM: tegra: pcie: Add device tree support
Message-ID: <20120622110403.GA15710@avionic-0098.mockup.avionic-design.de>
References: <4FD849CF.4030009@firmworks.com>
 <20120613081910.GB6528@avionic-0098.mockup.avionic-design.de>
 <4FD85127.8050301@firmworks.com>
 <20120614091905.GA9081@avionic-0098.mockup.avionic-design.de>
 <4FDA2DDA.1030704@wwwdotorg.org>
 <20120614192903.GA2212@avionic-0098.mockup.avionic-design.de>
 <4FDA40A0.4030206@wwwdotorg.org>
 <20120615061236.GA4081@avionic-0098.mockup.avionic-design.de>
 <20120619133001.GB24138@avionic-0098.mockup.avionic-design.de>
 <4FE0EFBB.6090206@firmworks.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
In-Reply-To: <4FE0EFBB.6090206@firmworks.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 19, 2012 at 11:31:39AM -1000, Mitch Bradley wrote:
> On 6/19/2012 3:30 AM, Thierry Reding wrote:
> >On Fri, Jun 15, 2012 at 08:12:36AM +0200, Thierry Reding wrote:
> >>On Thu, Jun 14, 2012 at 01:50:56PM -0600, Stephen Warren wrote:
> >>>On 06/14/2012 01:29 PM, Thierry Reding wrote:
> >>>>On Thu, Jun 14, 2012 at 12:30:50PM -0600, Stephen Warren wrote:
> >>>>>On 06/14/2012 03:19 AM, Thierry Reding wrote:
> >>>...
> >>>>>>#address-cells =3D <1>; #size-cells =3D <1>;
> >>>>>>
> >>>>>>pci@80000000 {
> >>>>>
> >>>>>I'm still not convinced that using the address of the port's
> >>>>>registers is the correct way to represent each port. The port
> >>>>>index seems much more useful.
> >>>>>
> >>>>>The main reason here is that there are a lot of registers that
> >>>>>contain fields for each port - far more than the combination of
> >>>>>this node's reg and ctrl-offset (which I assume is an address
> >>>>>offset for just one example of this issue) properties can
> >>>>>describe. The bit position and bit stride of these fields isn't
> >>>>>necessarily the same in each register. Do we want a property like
> >>>>>ctrl-offset for every single type of field in every single shared
> >>>>>register that describes the location of the relevant data, or
> >>>>>just a single "port ID" bit that can be applied to anything?
> >>>>>
> >>>>>(Perhaps this isn't so obvious looking at the TRM since it
> >>>>>doesn't document all registers, and I'm also looking at the
> >>>>>Tegra30 documentation too, which might be more exposed to this -
> >>>>>I haven't correlated all the documentation sources to be sure
> >>>>>though)
> >>>>
> >>>>I agree that maybe adding properties for each bit position or
> >>>>register offset may not work out too well. But I think it still
> >>>>makes sense to use the base address of the port's registers (see
> >>>>below). We could of course add some code to determine the index
> >>>>from the base address at initialization time and reuse the index
> >>>>where appropriate.
> >>>
> >>>To me, working back from address to ID then using the ID to calculate
> >>>some other addresses seems far more icky than just calculating all the
> >>>addresses based off of one ID. But, I suppose this doesn't make a huge
> >>>practical difference.
> >>
> >>This really depends on the device vs. no device decision below. If we c=
an
> >>make it work without needing an extra device for it, then using the ind=
ex
> >>is certainly better. However, if we instantiate devices from the DT, th=
en
> >>we have the address anyway and adding the index as a property would be
> >>redundant and error prone (what happens if somebody sets the index of t=
he
> >>port at address 0x80000000 to 2?).
> >
> >An additional problem with this is that we'd have to add the following
> >to the pcie-controller node:
> >
> >	#address-cells =3D <1>;
> >	#size-cells =3D <0>;
> >
> >This will conflict with the "ranges" property, because suddenly we can
> >no longer map the regions properly. Maybe Mitch can comment on whether
> >this is possible or not?
> >
> >To make it clearer what I'm talking about, here's the DT snippet again
> >(with the compatible property removed from the pci@ nodes because they
> >are no longer probed by a driver, the "simple-bus" removed from the
> >pcie-controller node's compatible property removed and its #address-
> >and #size-cells properties adjusted as described above).
> >
> >	pcie-controller {
> >		compatible =3D "nvidia,tegra20-pcie";
> >		reg =3D <0x80003000 0x00000800   /* PADS registers */
> >		       0x80003800 0x00000200   /* AFI registers */
> >		       0x80004000 0x00100000   /* configuration space */
> >		       0x80104000 0x00100000>; /* extended configuration space */
> >		interrupts =3D <0 98 0x04   /* controller interrupt */
> >			      0 99 0x04>; /* MSI interrupt */
> >		status =3D "disabled";
> >
> >		ranges =3D <0x80000000 0x80000000 0x00002000   /* 2 root ports */
> >			  0x80400000 0x80400000 0x00010000   /* downstream I/O */
> >			  0x90000000 0x90000000 0x10000000   /* non-prefetchable memory */
> >			  0xa0000000 0xa0000000 0x10000000>; /* prefetchable memory */
> >
> >		#address-cells =3D <1>;
> >		#size-cells =3D <0>;
> >
> >		pci@0 {
> >			reg =3D <2>;
> >			status =3D "disabled";
> >
> >			#address-cells =3D <3>;
> >			#size-cells =3D <2>;
> >
> >			ranges =3D <0x81000000 0 0 0x80400000 0 0x00008000   /* I/O */
> >				  0x82000000 0 0 0x90000000 0 0x08000000   /* non-prefetchable memor=
y */
> >				  0xc2000000 0 0 0xa0000000 0 0x08000000>; /* prefetchable memory */
> >
> >			nvidia,ctrl-offset =3D <0x110>;
> >			nvidia,num-lanes =3D <2>;
> >		};
> >
> >		pci@1 {
> >			reg =3D <1>;
> >			status =3D "disabled";
> >
> >			#address-cells =3D <3>;
> >			#size-cells =3D <2>;
> >
> >			ranges =3D <0x81000000 0 0 0x80408000 0 0x00008000   /* I/O */
> >				  0x82000000 0 0 0x98000000 0 0x08000000   /* non-prefetchable memor=
y */
> >				  0xc2000000 0 0 0xa8000000 0 0x08000000>; /* prefetchable memory */
> >
> >			nvidia,ctrl-offset =3D <0x118>;
> >			nvidia,num-lanes =3D <2>;
> >		};
> >	};
> >
> >AIUI none of the ranges properties are valid anymore, because the bus
> >represented by pcie-controller no longer reflects the truth, namely that
> >it translates the CPU address space to the PCI address space.
> >
>=20
> I think you can use a small-integer port number as an address by
> defining the intermediate address space properly, and using
> appropriate ranges above and below.  Here's a swag at how that would
> look.
>=20
> I present three versions, using different choices for the
> intermediate address space encoding.  The intermediate address space
> may seem somewhat artificial, in that it decouples the "linear pass
> through of ranges" between the lower PCI address space and the upper
> CPU address space.  But in another sense, it accurately reflects
> that fact that the bus bridge "slices and dices" that linear address
> space into non-contiguous pieces.
>=20
> Note that I'm also fixing a problem that I neglected to mention
> earlier - namely the fact that config space is part of the child PCI
> address space so it must be passed through.
>=20
> Version A - 3 address cells:  In this version, the intermediate
> address space has 3 cells:  port#, address type, offset.  Address
> type is
>   0 : root port
>   1 : config space
>   2 : extended config space
>   3 : I/O
>   4 : non-prefetchable memory
>   5 : prefetchable memory.
>=20
> The third cell "offset" is necessary so that the size field has a
> number space that can include it.
>=20
> 	pcie-controller {
> 		compatible =3D "nvidia,tegra20-pcie";
> 		reg =3D <0x80003000 0x00000800   /* PADS registers */
> 		       0x80003800 0x00000200>; /* extended configuration space */
> 		interrupts =3D <0 98 0x04   /* controller interrupt */
> 			      0 99 0x04>; /* MSI interrupt */
> 		status =3D "disabled";
>=20
> 		ranges =3D <0 0 0  0x80000000 0x00001000   /* Root port 0 */
> 			  0 1 0  0x80004000 0x00080000   /* Port 0 config space */
> 			  0 2 0  0x80104000 0x00080000   /* Port 0 ext config space *
> 			  0 3 0  0x80400000 0x00008000   /* Port 0 downstream I/O */
> 			  0 4 0  0x90000000 0x08000000   /* Port 0 non-prefetchable memory */
> 			  0 5 0  0xa0000000 0x08000000   /* Port 0 prefetchable memory */
>=20
> 			  1 0 0  0x80001000 0x00001000   /* Root port 1 */
> 			  1 1 0  0x80004000 0x00080000   /* Port 1 config space */
> 			  1 2 0  0x80184000 0x00080000   /* Port 1 ext config space */
> 			  1 3 0  0x80408000 0x00010000   /* Port 1 downstream I/O */
> 			  1 4 0  0x98000000 0x08000000   /* Port 1 non-prefetchable memory */
> 			  1 5 0  0xa0000000 0x08000000>; /* Port 1 prefetchable memory */
>=20
> 		#address-cells =3D <3>;
> 		#size-cells =3D <1>;
>=20
> 		pci@0 {
> 			reg =3D <0 0 0 0x1000>;
[...]
> 		};
>=20
> 		pci@1 {
> 			reg =3D <1 0 0 0x1000>;
[...]
> 		};

It seems like this isn't working properly. For some reason both the reg
property of pci@0 and pci@1 are translated to the same parent address
0x80000000. I'll have to investigate where exactly this goes wrong.

Thierry

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJP5FEjAAoJEN0jrNd/PrOhUYgP/36eNNJwJvm8Td2+kWQuK/wO
+V0nM6zWXuK6T2nf+pHxB5Z1SAST7HqpElnPO3YC2aiDOFG0s904sfwtcOJHgdgY
onBTud0uUAwfRxZNo6fuPxlDnQLuOtSSgAea2IjtuzuF7MM+ObRgNiBspS6u8XOD
6tvZAftZ1hC7jileYrXRtp5/qP+BATmd4GGSE7B7s2K5o411tLd+SUCQ5g3kC0bp
m/QJXLhmaKsrb/Z3F0CpKuoC1ZUbbJCHcYWRwq2sK2UfakITFMFMBSarUrA/JM/J
58BPf7ZSFTgoSOCJMNhD4PHQxPuKroTr/SesA1qr4KfrEC+fnZ47h4wzQx6tRZ3B
dxgv0EoaaaPLZengrxwlGjfyHLeJtcO1jLQf04KgWnjmMTZjOjEhsSQyKUFuaUJP
YF1HOBL+RZAsYNDydkkOm0oDEIChN2k1ynEd3uY6U0UK8O6HHi5ysMLaOWMhdota
SMDM6V5xms3Cnh/5+iPu0G0IN2mqavMpu01EiT7PynNvtGKukej0sZYiTx6K+58v
CL8wiA2uOCDMa7nTcYaMlc49LS8hKo4XrwwqvoKxXxE6pKgoB43hBdWUDywTU4JC
vWBZ5ZA002TG4C2SjnqPOSD5Ca1teFdiDqTVC+ldgv0DuGRoUxm1xEHCDqgwoiVs
0XGvPH7sEAfdOy/zbLk2
=HbqG
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
