Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:63897 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932707Ab3CLVa4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Mar 2013 17:30:56 -0400
Date: Tue, 12 Mar 2013 22:30:06 +0100
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
Message-ID: <20130312213006.GA23717@avionic-0098.mockup.avionic-design.de>
References: <20130310065539.GA14704@obsidianresearch.com>
 <513D6F9C.9000100@firmworks.com>
 <20130311181554.GA10992@obsidianresearch.com>
 <513E519B.6010503@firmworks.com>
 <20130311232516.GA13873@obsidianresearch.com>
 <513E6AFE.3090304@firmworks.com>
 <20130312070852.GA6727@avionic-0098.mockup.avionic-design.de>
 <20130312155749.GA1820@obsidianresearch.com>
 <20130312203819.GA23221@avionic-0098.mockup.avionic-design.de>
 <20130312210328.GA22702@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
In-Reply-To: <20130312210328.GA22702@obsidianresearch.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2013 at 03:03:28PM -0600, Jason Gunthorpe wrote:
> On Tue, Mar 12, 2013 at 09:38:19PM +0100, Thierry Reding wrote:
>=20
> > I've also verified that things actually do work with the binding that I
> > proposed for Tegra, even if I add device_type =3D "pci" to the root port
> > nodes. The reason is that the OF core looks up the type of the *parent*
> > node to find a matching bus. This happens to be the pcie-controller node
> > which is not a PCI device and therefore the address translation works
> > properly.
>=20
> Mitch pointed out early on that the parent node needs a 'device_type =3D
> "pci"' as well.
>=20
> The pcie-controller node would be classified as a 'bus node' according
> to the spec.
>=20
> Not going down the of_pci_* code paths for address translation at the
> root port bridge nodes is certainly not right.

I'm not so sure. Why should the pcie-controller be a PCI device? It
really isn't. Instead it is a device on the processor/SoC/platform bus
that bridges to the PCI bus. As such its children should be PCI devices
to reflect that the translation happens within the pcie-controller node.

In the above it is logical to not set the pcie-controller's device_type
property to "pci".

> > ranges =3D <0x00000800 0 0 0x80000000 0 0x00001000   /* port 0 configur=
ation space */
> >           0x00001000 0 0 0x80001000 0 0x00001000   /* port 1 configurat=
ion space */
>=20
> Section 12 says that the 'b,d,f' bits are 0 in ranges, so the above is
> in conflict with that language:
>=20
>  In particular, the phys.hi fields of the child address spaces in the
>  "ranges" property for PCI does not contain the same information as
>  "reg" property entries within PCI nodes. The only information that is
>  present in "ranges" phys.hi entries are the non-relocatable,
>  prefetchable and the PCI address space bits for which the entry
>  applies. I.e., only the n, p and ss bits are present; the bbbbbbbb,
>  ddddd, fff and rrrrrrrr fields are 0.
>=20
> And the further requirement:
>=20
>  When an address is to be mapped through a PCI bus bridge node, the
>  phys.hi value of the address to be mapped and the child field of a
>  "ranges" entry should be masked so that only the ss bits are compared.
>=20
> Which is embodied by the code in of_bus_pci_map, meaning the OF core
> won't even look at the bits in the high DW when searching ranges.

Okay, so the problem with that is that we won't be able to include more
entries for configuration space within a ranges property because we
can't uniquely map them (they both have the same ss field values). One
possibility would be to differentiate using the phys.mid and phys.low
cells but they need to be 0 according to the spec.

The other alternative would be to amend the specification. Besides the
fact that the specification says so I don't see any reason why this
shouldn't be allowed.

Thierry

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRP55eAAoJEN0jrNd/PrOhdkwP/3iEgAq6TDL+G26l2fuQwa2T
ALTxZT3wIZAYma0etWQ11q4OPwCSRWzNmefJaV9vEmwxIN1RV//It09htVLfxjK7
ujMfP1Fxpcta1N0W0l71yeZlo61DHABR56SrwgsHGCUALSUQpoA+df0/P+T77Zqk
fC8uI1/t0vbUF/0EiVYtz6+Ne8T3CyeHwbEaZufQL58YaTYGG4h9Egkjymzz2Mpu
a6NdU+RMumvkZG/3qL2wZg8BKuY18Yq0AFMAOuqTvWiDTsGYMvBfmzH/zujtdOSw
WDjTmuC71mFREx1RnXQUK6BDaFRjnltj9XPN23iuNAfgM7gZkrxHcFiDE2hP2EF4
+21i8VSJ6BiOvAosWw+nJE57fkFPtmq/y3u+rhiPoFdPgWCLBFdBlaihRsE7bFhD
kpe4d9zx4HtzRUXyGFXl4SWQj8sNkwiPSOEpG87soG2jY/6uMwXvOwgSCsG5upO0
hunUuUcfkwQMCFiR+tgvds/Eug+gcvddkhCOLlQ2jqwOglkFAs5+vfU8xpqc8BCz
2HpGPr5LpaNEOBLj6OHFSBcQu1uX7FYrJDAf0tQQRS3jp3vIn03JzKOAUkuCeWLG
NEAZ1qBndvhkAUluSlc7JzHH1LgdBZ4ZIY1A2bNgffzjFncRXNKPqIbfNOjMd0m7
iv1hJ50jhaoyGs6XJvfL
=91eu
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
