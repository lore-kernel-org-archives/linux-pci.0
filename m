Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:52977 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757031Ab3A2PDV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Jan 2013 10:03:21 -0500
Date: Tue, 29 Jan 2013 16:02:01 +0100
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Andrew Murray <andrew.murray@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP
 systems
Message-ID: <20130129150201.GA24101@avionic-0098.mockup.avionic-design.de>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130129132204.GA23886@arm.com>
 <20130129144522.44ed7373@skate>
 <20130129140522.GA24310@arm.com>
 <20130129142015.GA23640@avionic-0098.mockup.avionic-design.de>
 <20130129152937.53ec9a9b@skate>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
In-Reply-To: <20130129152937.53ec9a9b@skate>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 29, 2013 at 03:29:37PM +0100, Thomas Petazzoni wrote:
> Dear Thierry Reding,
>=20
> On Tue, 29 Jan 2013 15:20:15 +0100, Thierry Reding wrote:
>=20
> > If at all possible I think the right thing to do is reuse the generic
> > pcibios_get_phb_of_node() implementation. On Tegra this turned out to
> > require a minimal change to the DT bindings of the root port nodes to
> > make sure they provide the correct address in the reg property.
>=20
> Could you detail the change that was needed? The DT bindings I use for
> the Marvell PCIe driver are very, very similar to the ones you use for
> Tegra, since I basically inspired my entire DT binding on your work.
> And still, I think of_irq_map_pci() wasn't working for me.

Now that I think about it, there were a few more changes needed.
For one, the reg property of the root port nodes need to be in the
format specified by the PCI DT binding. That is, 3 cells for the
address and 2 cells for the size.

So I end up with something like this:

	pcie-controller {
		...

		ranges =3D <0x00000800 0 0x80000000 0x80000000 0 0x00001000 /* port 0 reg=
isters */
			  0x00001000 0 0x80001000 0x80001000 0 0x00001000 /* port 1 registers */
			  ...>;

		pci@1,0 {
			reg =3D <0x000800 0 0x80000000 0 0x1000>;
			...
		};

		pci@2,0 {
			reg =3D <0x001000 0 0x80001000 0 0x1000>;
			...
		};
	};

So what happens here is that for each root port (pci@1,0 and pci@2,0),
the reg property is translated into the parent address space via the
pcie-controller's ranges property. pci@1,0 gets the memory region
0x80000000-0x80000fff and pci@2,0 gets 0x80001000-0x80001fff. (These are
actually windows through which the configuration space of the root ports
is accessed.)

At the same time this reg property maps both devices into the PCI
address space at addresses 0:01.0 and 0:02.0 respectively.

The second change is that you can't rely on ARM's default implementation
of the bus scan operation, which calls pci_scan_root_bus(), passing in a
NULL as the struct device which acts as the bus' parent. So on Tegra I
added a custom implementation which calls pci_create_root_bus(), passing
in the struct device of the PCI host bridge, whose .of_node field will
be set to the pcie-controller node above. Incidentally this also fixed
another issue where the PCI core and ARM's pci_common_init() both
eventually end up calling pci_bus_add_devices(). I don't remember the
exact symptoms but I think this was causing resource conflicts during
the second enumeration or so.

Because a proper struct device with the correct .of_node field is passed
into pci_create_root_bus(), the generic pcibios_get_phb_of_node() will
know how to find it by looking at bus->bridge->parent->of_node. After
that the generic matching code will search the bridge (pcie-controller)
node's children and relate them to the struct pci_dev by devfn. This is
done in pci_set_of_node() defined in drivers/pci/of.c, which calls
of_pci_find_child_device() from drivers/of/of_pci.c.

This is quite convoluted, but I hope it helps.

Thierry

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRB+RpAAoJEN0jrNd/PrOh+JgQAJMtMvaXgowcLrNghdQA8QZQ
JS/jDrhKiQxtRTLquNCH9kVsmlcjsImFKuIwbJUBncreOXP1tye5IkzB3zEbYX7m
PkSSzbqMPvOYkln/IrdN4LQuYmwU1PX02XwKpKTKEdaSqHA1PpLa/1Ap10cPVvJr
dkYgz9FdGcwn0lj/z9j99qy0iheUr2uflyd3PhgAlERaw7CNki8V98SuMXM+uEBO
yrYbXpYx8ktB6LOZ9E1M/NhhIzMn8WcsqtYAh5zzphGZ6qPWq2hmbEShd6Lfsvtf
AO9NO21yzhG0TS4fYQ5lrcG1mU0X3j5Io5sJBmBSLhg4k8x4OsHY/7jiwJ4NgOlw
Dh0R/kT3lhCpLDsxxgYfHcRY95euZtDnfkqccEaYCliIq1hKQtSbSGmGH00jEq+S
F5fFuC9BACMtwv0n1BK7iezW4kO/L0Wh57LMAf0KrmBSdSdLB8mKrVTHq0sBUQjB
FgosnYLTF/fCGMjG3wc7vMc9KdejI42jbsBS939KkprAx203vUrj+dyY4f2+RwT9
cO5ZefJuh1WcvxnK3mMV3AwAr7Z6dqwkw88pBPWzZhCKhbpTp+q2eBvuA9Ws4MvF
Gs2AVzCVkkttzqi2tJpqtHCmFToo88O7vbmSCnCP2Q0CMgepPJYXnI1ZdSB3Qcji
tqls07PaFeUSfZtH6/1T
=yn4T
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
