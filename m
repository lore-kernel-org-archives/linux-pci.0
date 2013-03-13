Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:56314 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933178Ab3CMUyW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 Mar 2013 16:54:22 -0400
Date: Wed, 13 Mar 2013 21:54:07 +0100
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Mitch Bradley <wmb@firmworks.com>,
	Lior Amsalem <alior@marvell.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>, linux-pci@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
Message-ID: <20130313205407.GA29025@avionic-0098.mockup.avionic-design.de>
References: <20130312070852.GA6727@avionic-0098.mockup.avionic-design.de>
 <20130312155749.GA1820@obsidianresearch.com>
 <20130312203819.GA23221@avionic-0098.mockup.avionic-design.de>
 <20130312210328.GA22702@obsidianresearch.com>
 <20130312213006.GA23717@avionic-0098.mockup.avionic-design.de>
 <20130312220854.GA23112@obsidianresearch.com>
 <20130313081815.GD25940@avionic-0098.mockup.avionic-design.de>
 <20130313170205.GB24042@obsidianresearch.com>
 <20130313192628.GA28714@avionic-0098.mockup.avionic-design.de>
 <20130313195901.GA26550@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
In-Reply-To: <20130313195901.GA26550@obsidianresearch.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2013 at 01:59:01PM -0600, Jason Gunthorpe wrote:
> On Wed, Mar 13, 2013 at 08:26:28PM +0100, Thierry Reding wrote:
>=20
> > As Mitch already said there's very little chance that the specification
> > update will be ratified through IEEE, so I think that we might just as
> > well put a corresponding text somewhere below Documentation/devicetree.
>=20
> Sure, I'm fine with that.
> =20
> > Also note that this has absolutely nothing to do with ECAM. All I'm
> > proposing is to allow the reg property of a root port to be translated
> > into a CPU addressable memory region through the ranges property. This
> > turns out to actually work properly with the current OF core in Linux.
>=20
> ECAM is the only standard based mechanism that could possibly use this
> new config space ranges concept. Whatever you do for tegra shouldn't
> stomp on the possibility of making that work in the future. So at
> least think about how ECAM could be modeled for a few mins before
> going ahead.
>=20
> Tegra is the non-standard unusual case here, an update to the PCI OF
> binding should be of general use.

But I'm not trying to encode ECAM in the DT. ECAM isn't the problem at
all. The only problem is that each root port has a separate window in
the CPU address space that is used to access that port's configuration
space.

ECAM only comes into play when accessing the configuration space of
subordinate devices (via type 1 transactions). But at that point the
device tree doesn't need to know about it. The only thing that needs to
be in DT is the memory region that the controller should write to in
order to generate type 1 transactions. And that's a problem that has
long been solved.

> > > Anyhow, I think this has been hashed to death, as long as your final
> > > binding has the 'device_type =3D pci' on the pcie-controller node I
> > > think it will be fine.
> >=20
> > No. The pcie-controller is *not* a PCI device. It is a PCI host bridge.
> > It is the instance that translates from the platform to the PCI bus. Why
> > should it be device_type =3D "pci"?=20
>=20
> Spec says so, Mitch said so, other PCI host bridge bindings in the
> tree work like this. Do a grep in the powerpc tree, for instance.
>=20
> arch/x86/platform/ce4100/falconfalls.dts is a pretty comprehensive
> example.

Yes, yes. We all know by now what the spec says. The whole point is
that maybe the spec needs to be updated and this requirement lifted.
What I keep trying to say is that in case of Tegra the PCIe controller
does not provide the PCI bus. It doesn't appear as a device on the PCI
bus and it doesn't have configuration space itself.

Only the PCI root ports provide access to the subordinate busses. And
only they appear on the PCI bus.

> > And we've also been over this before, making that change stops the
> > proposed binding from working properly because the entry in the reg
> > property can't be translated into a CPU addressable memory region.
>=20
> Sigh, that's because the change makes things follow the OF PCI
> spec. The Linux OF core follows the spec. Config space ranges binding
> is specifically *defined to not work* in the spec. Why should it work
> today?

Okay. I keep understanding what you're saying. But the whole point of
this discussion is that maybe the spec should be amended to allow this
to work. In fact it does work with the current implementation in the
Linux kernel. And what I've been trying to explain is that I think this
to be the most accurate description of the Tegra hardware.

> You have to deal with this problem somehow, and omitting the top level
> device_type is not a solution.

So we've already agreed that the specification might be too restrictive,
and I'm trying to solve this problem by finding an accurate description
in DT to represent the hardware without following the spec to the letter
because it wasn't written with this kind of hardware in mind.

Tegra's PCIe controller doesn't actually implement the bus. In fact we
have to jump through hoops to make both root ports appear on the root
bus specifically because there's no common access to the configuration
space that includes the host bridge or the root ports.

Thierry

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRQOdvAAoJEN0jrNd/PrOhbgkQAKABOXGwCZmTDV3S1SEiwy4E
2nKad45Qv3Oy9iCLvBL+1Fjt6J3yER5fIWrJGeR4ztEOLnSZmNkCS3GKlFeM0j0g
01v94AGbxaL5BzyO3iK/QKz9USgUy9KFZ4RUCuG+FDl7aw0PjgbGmu0PxX3X1xPZ
OUNhqNKHrAhXL2PY+sJegSJqvpAf++ab/Uzg3JXVvQytCOUPU6/5yNuiTuZhrT31
L22mL24Ov3vk38RPqs6QZ2BbElOqtAR7HOPVj7mxreM+lqiXKsbeE5aOvWn4KSAB
kS+dVY7tYhTLYFkCANjaDW+y46t18FC3i8Z3+iruaESgAzqcIq+ThsWuexq7vrCJ
vNCpyeytoIM3+CoJ1jgyXVtH1wghIuCn4OkHCAJtVxH3/knSfihdUHAGfJPjfTxO
5w8PJoSOK5wfoAC6M4dlEq2Xa99SupLrOx+lyI5DxUiwC7uW34zx/zGRrgmCAwIR
x2V4RwVs1EhuX0YyT8arrfD8voYfKRoJqDOcbfXFLJPKxTwhOaEg2l/PNAPb5T5v
2oVTE09VR0FB9JHQb9Ep4qL6cAjvFmAJLmtXnPMEOZIIyWaTBIM2OpekIkr8pzHi
l40oCia25NIL4W7sUvU1o7GCEhlIs7MBavZbpyzlmzxKgZqQm/N3NJMWPV2J77kI
SLaCogVy8F3Ht+rpAK52
=1wot
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
