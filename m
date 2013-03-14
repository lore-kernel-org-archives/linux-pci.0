Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:59122 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753515Ab3CNHLd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 14 Mar 2013 03:11:33 -0400
Date: Thu, 14 Mar 2013 08:11:25 +0100
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Mitch Bradley <wmb@firmworks.com>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
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
Message-ID: <20130314071124.GA31664@avionic-0098.mockup.avionic-design.de>
References: <20130312203819.GA23221@avionic-0098.mockup.avionic-design.de>
 <20130312210328.GA22702@obsidianresearch.com>
 <20130312213006.GA23717@avionic-0098.mockup.avionic-design.de>
 <20130312220854.GA23112@obsidianresearch.com>
 <20130313081815.GD25940@avionic-0098.mockup.avionic-design.de>
 <20130313170205.GB24042@obsidianresearch.com>
 <20130313192628.GA28714@avionic-0098.mockup.avionic-design.de>
 <5140E85A.3040900@firmworks.com>
 <20130313213344.GA29402@avionic-0098.mockup.avionic-design.de>
 <5141023C.3010200@firmworks.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
In-Reply-To: <5141023C.3010200@firmworks.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2013 at 12:48:28PM -1000, Mitch Bradley wrote:
> On 3/13/2013 11:33 AM, Thierry Reding wrote:
> > On Wed, Mar 13, 2013 at 10:58:02AM -1000, Mitch Bradley wrote:
> > [...]
> >> In this case, the answer to "what does pcie_controller do?" is "it
> >> implements a PCI bus" below.  So 'device_type =3D "pci"' is appropriat=
e.
> >=20
> > Alright, that's 2 against 1. I don't have much of a choice but to yield.
>=20
> All issues of "voting" aside, 'device_type =3D pci' is what tells
> of_get_pci_address() to use the 3/2 interpretation.  So if you want a
> node to implement 3/2 addresses, it must say device_type =3D pci, unless
> you do address translation some other way.

of_bus_default_map() can also handle #address-cells > 2. We explicitly
added that special case back when the bindings still looked very
different and we needed to match the exact entry.

This is the reason why it actually works to not use device_type =3D "pci"
for the pcie-controller. For subordinate device address translation the
code will look at the parent bus, see that it isn't a PCI device and use
the default bus, which in turn will simply memcmp() the first 3 cells of
the "reg" property entry against those in the "ranges" property.

> >> But then you run into the problem that the pci variant of struct of_bus
> >> uses "assigned-addresses" instead of "reg".  So it still doesn't work
> >> as-is.  To make it work, you would need to add an "assigned-addresses"
> >> property to each root port node.  That property value could be in
> >> non-relocatable memory space, translatable via normal rules, in which
> >> case the "map config space to MMIO via ranges" discussion is moot for
> >> Marvell.
> >=20
> > At the risk of quoting the spec: it says (4.1.2) that the entries in the
> > "assigned-addresses" property correspond to the function's configuration
> > space BARs. In this case however that's no longer true.
>=20
> Right, but we got into this mess by pretending that a PCI domain exists
> despite the fact that the hardware is not PCI at that level, in order to
> accommodate some existing Linux code.

Actually at that level the hardware is indeed PCI. These entries are for
the root port nodes, which are in fact the bridges to the PCI bus. This
is what I've been trying to say all along. The PCIe controller is just a
collection of registers that allow CPU address space to be bridged to
an internal bus (FPCI, which is in fact a relic from the HyperTransport
roots of the controller IIUC) and setup/handle MSI.

The transition to the PCI fabric happens in the root ports. There is no
PCI host bridge.

> Since we are already "faking it to deal with existing code", it doesn't
> seem particularly strange to take advantage of how existing code works,
> in order to accomplish the forgery.

So we're back to square one. How is this kind of faking (repurposing the
"assigned-addresses" property) any better than translating the "reg"
property through an "ss =3D 00" entry in the "ranges" property?

> > But if everybody
> > thinks that repurposing the "assigned-addresses" property is more
> > acceptable than leaving out the device_type =3D "pci" property from the
> > pcie-controller node, then so be it.
>=20
> I'm confused again.  Why does leaving out device_type =3D pci make it wor=
k?

I've already said this above. The default bus implementation handles the
case where #address-cells > 2 by comparing the first three cells, but
not go through the additional range matching that would otherwise need
to take place. Instead it treats the address cells as some kind of
identifier to match between the "reg" and "ranges" entries. That's very
much the way that the PCI bus implementation works, except for some
extra PCI-specific checks.

> >> Which re-raises a question for which I have not yet heard a compelling
> >> answer:  Why use 3/2 PCI addressing between Marvell pcie-controller and
> >> its root ports (with their unusual programming model)?  The Marvell
> >> hardware address structure between controller and root ports is
> >> definitely not 3/2.  Certainly you need 3/2 addressing below
> >> (implemented by) the root ports, but I just don't see the utility of
> >> pretending 3/2 addressing at the complex-to-port interface.  If the ro=
ot
> >> port hardware used the common programming model, with real config
> >> headers and stuff, 3/2 would be good because you could use existing
> >> drivers.  But since you need a special root-port driver anyway, why go
> >> to the trouble of emulating non-existent addressing?
> >=20
> > I think the reason is that reg needs to be in the standard format for
> > the device node matching code to work. There are various checks to make
> > sure the reg property has entries which are 3/2 each.
>=20
> Could you point me to some of those checks so I can understand this bette=
r?

The code for that is in drivers/of/of_pci.c. The __of_pci_pci_compare()
function looks like this:

	static inline int __of_pci_pci_compare(struct device_node *node,
					       unsigned int devfn)
	{
		unsigned int size;
		const __be32 *reg =3D of_get_property(node, "reg", &size);

		if (!reg || size < 5 * sizeof(__be32))
			return 0;
		return ((be32_to_cpup(&reg[0]) >> 8) & 0xff) =3D=3D devfn;
	}

This is the function that's called for each node to check whether it
corresponds to a given PCI device by matching the devfn to the value
found in the first cell of a device node's "reg" property.

> > There's also the issue that the pcie-controller's ranges property
> > contains the mapping of the I/O and memory windows and therefore needs
> > the 3/2 addressing to encode the type.
>=20
> Why can't that be done in each of the root port nodes?

It could possibly be done, but we'd be lying. The way the hardware works
is that we configure a single window to map to each of the FPCI regions
for I/O and (non-)prefetchable memory spaces. So the pcie-controller
node's "ranges" property contains three entries, one for each of those
spaces which the driver uses to program the corresponding registers. The
same information is passed to the resource assignment code of the PCI
core so that it can partition these windows as appropriate and allocate
sub-windows that are assigned to the BARs of the root-ports.

Note that the programming of the root-port BARs is vital here. If memory
within one of the FPCI-mapped windows is accessed, the hardware will
look for a matching address in the root port BARs in order to determine
the port through which the transactions should be sent.

Thierry

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRQXgcAAoJEN0jrNd/PrOhS/UP/1qB9goxvnms5eoKOYESJSbY
CLV0HiTuRN0TD2ZIeev2YDIgIyR9dblDx/EiZ357XOgWYcyW6zYxVddq+PEc6pJ6
ATFcORMvSn1eD/D1K0MY1ZDgVQTq7FMLFscRnrHKwj1Hiys/ZnzseQW6gYkiivxK
blrZMmDqS/dA1qDq2KsgmWrMQX/za0q1WYwvEoemyZMXA2fu/rGCQMx3N9sqoakv
QUsYWOKW5VeBUvPgqYE2kZSmDtfmp/N3wQjEMKWsv9cdNb6+EjILkD+beNQQM2+S
/pwcwgvUtp2uG7ihno56V3uhwf+swFbmKYk4AhLoLSbfKU4uLphhyst8G7QftN8H
r0rYfP3lNL/xY9bYxrFfatMJ0SI1Dv6I1+Zqor0r+Iov0phiAO+VnQ9EQUl5dKkJ
AzfXlD92xphyUKkPBDS0odxccqVcpR8NN0yp9gk67uNol2B5I7SKPlpsegEDlKkZ
j4k3At5F8VhklgREEN5sQUyyVYATrl7hxrM1GCepfYUYJWQxBfbbqWBVJBocB21T
CuKeHxIgxzRFGJB7AAXRWNP7KzkpW4+SCEONJfz10Vx5cnLEJGrJ25KB59hdm3C2
2kRJUeizQv+ZDkakdBimowNRWwHboCR3UD3yB8IBo5r2pDAwkjuaUH/v65TVeJcC
HczDASEqvOjvCtWXhQBx
=M+6l
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
