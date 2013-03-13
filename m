Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:49738 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933309Ab3CMVdz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 Mar 2013 17:33:55 -0400
Date: Wed, 13 Mar 2013 22:33:44 +0100
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
Message-ID: <20130313213344.GA29402@avionic-0098.mockup.avionic-design.de>
References: <20130312070852.GA6727@avionic-0098.mockup.avionic-design.de>
 <20130312155749.GA1820@obsidianresearch.com>
 <20130312203819.GA23221@avionic-0098.mockup.avionic-design.de>
 <20130312210328.GA22702@obsidianresearch.com>
 <20130312213006.GA23717@avionic-0098.mockup.avionic-design.de>
 <20130312220854.GA23112@obsidianresearch.com>
 <20130313081815.GD25940@avionic-0098.mockup.avionic-design.de>
 <20130313170205.GB24042@obsidianresearch.com>
 <20130313192628.GA28714@avionic-0098.mockup.avionic-design.de>
 <5140E85A.3040900@firmworks.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
In-Reply-To: <5140E85A.3040900@firmworks.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2013 at 10:58:02AM -1000, Mitch Bradley wrote:
[...]
> In this case, the answer to "what does pcie_controller do?" is "it
> implements a PCI bus" below.  So 'device_type =3D "pci"' is appropriate.

Alright, that's 2 against 1. I don't have much of a choice but to yield.

> Having just re-read the code in drivers/of/address.c, I think I have a
> deeper understanding of a few practical issues:
>=20
> In order to translate a 3/2 PCI address via of_get_pci_address(), the
> parent device (i.e. root complex / pcie-controller) must have both
> 'device_type =3D "pci"' (else of_match_bus() won't find the pci version of
> "struct of_bus") and also 'name =3D "pci"' (else strcmp(bus->name, "pci")
> will fail).
>=20
> So it would seem that, if you want to use address.c verbatim (for the
> interface between pcie-controller and its direct children), not only do
> you need device_type =3D pci, but you also need to rename
> "pcie-controller" to "pci".

bus->name refers to that of the of_bus structure, not the node name of
the controller.

> But then you run into the problem that the pci variant of struct of_bus
> uses "assigned-addresses" instead of "reg".  So it still doesn't work
> as-is.  To make it work, you would need to add an "assigned-addresses"
> property to each root port node.  That property value could be in
> non-relocatable memory space, translatable via normal rules, in which
> case the "map config space to MMIO via ranges" discussion is moot for
> Marvell.

At the risk of quoting the spec: it says (4.1.2) that the entries in the
"assigned-addresses" property correspond to the function's configuration
space BARs. In this case however that's no longer true. But if everybody
thinks that repurposing the "assigned-addresses" property is more
acceptable than leaving out the device_type =3D "pci" property from the
pcie-controller node, then so be it.

> Which re-raises a question for which I have not yet heard a compelling
> answer:  Why use 3/2 PCI addressing between Marvell pcie-controller and
> its root ports (with their unusual programming model)?  The Marvell
> hardware address structure between controller and root ports is
> definitely not 3/2.  Certainly you need 3/2 addressing below
> (implemented by) the root ports, but I just don't see the utility of
> pretending 3/2 addressing at the complex-to-port interface.  If the root
> port hardware used the common programming model, with real config
> headers and stuff, 3/2 would be good because you could use existing
> drivers.  But since you need a special root-port driver anyway, why go
> to the trouble of emulating non-existent addressing?

I think the reason is that reg needs to be in the standard format for
the device node matching code to work. There are various checks to make
sure the reg property has entries which are 3/2 each.

There's also the issue that the pcie-controller's ranges property
contains the mapping of the I/O and memory windows and therefore needs
the 3/2 addressing to encode the type.

Thierry

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRQPC4AAoJEN0jrNd/PrOh4hwQAIfCrinqyssPFH1YZChi0EbK
jJimmstP3MLxc7CYNWkdsF+fCkiSasGY0m5tl4L9gy7FVhkDPbAe6rGDO3aqQN4n
T0eBJN/k93H8oKkzPr3Sw3NRoDMpQ18YyG6o6MUN84otJQG8/ThJHDrZQzzTL88q
Y3bZU1XB5dn5ijgu0x3vZgOF3h26C/JNnLURq6P6/WClFhsgNnYHVyDy1GOR1pVC
zjM1dl26MD4onkR/AbgGRI7m8vEr8+6862qmsO7cvgvl8UaxXFh6vdU/+sd/a82Z
cUjSkTq/PyWtaVRkzXYxa2cazPtDZ9byNo/5gjRXZvrSHUl+ynWB3eh0TGMIuIGo
bFPkZUaXVB6kFHgqaB9SvEjv06nHL8zbpb7OeUQeAhcf9JeawDSCWTDoZhxNLrIy
Ap4GItc8simq7dacuLMxWmF9szUwHi4FhtP97ckCDab9WVhjytze2nwydGAivfPW
ZwojwaRczlvW/+rF4Uu2mldi3hQ1fA082NMVEVzl/noDzK891YrAwprQLXPNX96j
pLaURarxeZU/eR5x1STYPgpWwElvea7u7rhjBfwwk3KKoq0wgXcla/d2YNMN+ezB
ACMG5PQ6LMIMj+YQ9bjKAmircvow/kiQZetsgtwyyFVcR0kD01l701TdjimlDcvr
zXf5E9ES4rx8r0g7Ylrv
=AjXo
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
