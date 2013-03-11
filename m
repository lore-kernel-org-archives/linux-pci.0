Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:57611 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000Ab3CKHrF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 11 Mar 2013 03:47:05 -0400
Date: Mon, 11 Mar 2013 08:46:15 +0100
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
Message-ID: <20130311074615.GA6365@avionic-0098.mockup.avionic-design.de>
References: <20130308071443.GA5772@avionic-0098.mockup.avionic-design.de>
 <20130308165228.GB4094@obsidianresearch.com>
 <20130308191227.GA6551@avionic-0098.mockup.avionic-design.de>
 <513A3F4F.2090501@firmworks.com>
 <20130308200245.GC29435@obsidianresearch.com>
 <513A7845.6040304@firmworks.com>
 <20130309013152.GA3883@obsidianresearch.com>
 <513C117D.6080800@firmworks.com>
 <20130310065539.GA14704@obsidianresearch.com>
 <513D6F9C.9000100@firmworks.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
In-Reply-To: <513D6F9C.9000100@firmworks.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 10, 2013 at 07:46:04PM -1000, Mitch Bradley wrote:
> On 3/9/2013 8:55 PM, Jason Gunthorpe wrote:
> > On Sat, Mar 09, 2013 at 06:52:13PM -1000, Mitch Bradley wrote:
> >=20
> >> Okay, I think I finally get it.  The Marvell root port bridge setup
> >> registers look like standard config headers, even though they aren't
> >> really in config space (because you need a different access method for
> >> them, compared to real config accesses to downstream devices).
> >=20
> > Well, thats pretty close. On Marvell the MMIO space has a lot of
> > stuff, some of it is config related, lots of it isn't. In fact most of
> > it isn't. Tegra is different, the MMIO region is exactly the config
> > space of the root port bridge.
> >=20
> > Tegra could probably happily and sanely do as you've described (well,
> > see below), but it is wonky for Marvell. It looks like there are more
> > drivers coming that have this need - so I had hoped for a general
> > answer to the 'per-port MMIO space' problem that is unrelated to the
> > MMIO spaces role in config access.
> >=20
> >> So, in order for the common code that enumerates the PCI bus to work,
> >> you need to "spoof" the config accesses so that when you try to access
> >> those particular "pseudo config headers", it uses the MMIO method
> >> instead of the real config access method.
> >=20
> > There are rules for config access in both Tegra and Marvell that are
> > not trivial. Again, the driver takes are of this and all Linux sees is
> > a nice compliant config space.
>=20
> Thanks for explaining that.
>=20
> So it seems that we are faced with two requirements that are somewhat at
> odds with one another.
>=20
> 1) Some of the root port bridge registers have to be accessed via config
> space access functions so common PCI enumeration code will work.  To
> represent this with the usual DT structure, the top root-complex needs
> to define a 3/2 address space so its children
> can have standard PCI reg properties.  Presumably, if those registers
> are being programmed by common code, Marvell-specific code would
> restrict its role to setting up config-space access functions, leaving
> the actual touching of the registers to the common code.
>=20
> 2) Marvell chips have additional non-standard per-root-port registers
> that generic PCI code would not understand.  These registers would be
> touched only by Marvell-specific code.
>=20
> The two kinds of registers are adjacent in MMIO space.  However, unless
> I am misunderstanding this MV78230 manual, the highest "config header"
> register index is 0x134, well below the 0x1000 size limit of a PCIe
> config header.  Some of the extra registers are at 0x8xx, and others are
> above 0x1800.
>=20
> That suggests the following:
>=20
> For the "config header" registers that use generic PCI code, use a
> ranges entry to associate (pass through) MMIO addresses to the config
> header portion of the register block.  This parameterizes the code that
> sets up the special-case PCI config access.  That specification
> technique is general and could be used not only for the Marvell case,
> but also for any other chip that has some number of direct-mapped config
> headers.
>=20
> For requirement (2), the top node has a reg property listing the
> portions of the address space that are consumed by the driver at the top
> level instead of being passed through to the PCI addressing domain.  E.g.
>=20
>   reg =3D <0xd0040800 0x1800>, <0xd0080800 0x1800>;
>=20
> Thus we have accurately described the two aspects of the true situation.
>  The PCI-compliant "config header" registers are passed through to the
> child nodes where they can be dealt with in the normal PCI fashion.  The
> non-PCI-compliant register footprint lives within the Marvell-specific
> root-complex driver.
>=20
> The root-complex driver presumably needs associate non-compliant
> register blocks with specific child nodes.  That can be done by
> requiring that the reg entries are in the same order as the config-space
> ranges entries.
>=20
> Anticipating the possible objection that ARM's 0x1000-byte page size
> does not permit virtual-to-physical mapping at 0x800-byte granularity:
> The device tree does not guarantee that reg entries are page-aligned; it
> simply tries to describe the reality, even though it might be messy.
>=20
> >=20
> >> If that is indeed the case, them I would vote for a slight modification
> >> of the intermediate patch that I cited earlier - the one in which the
> >> ranges property includes translations from those special config
> >> addresses into CPU addresses.  The modification is to fix the sizes,
> >> changing 0x2000 to 0x800, so those ranges entries do not overlap in the
> >> child address domain.
>=20
> BTW I have completely changed my mind about the overlap thing.
>=20
> I said that it was bogus to use size=3D0x2000 for a config space header.
>  That was based on an interpretation - which I now dislike - of the
> meaning of 3-cell config addresses.  By that old interpretation,
> size=3D0x800 would also be bogus, because bits 10-8 of the config address
> are for the function number.
>=20
> Consider the following question, which I have never previously
> considered, at least not explicitly:
>=20
> Q: What would be the 3-cell representation of the Command/Status
> register address (offset 4) in device 1, function 1?
>=20
> One obvious - but weak - answer is  <0x00000904 0 0> .  It's obvious
> because the value 0x80000904 is what you put in the cf8 indirect access
> address register.  But it is weak because it unnecessarily restricts the
> config header size, and because it works differently than offsets
> applied to memory and I/O space addresses.  Furthermore, coupling the
> offset to the cf8 register is dodgy because of the funniness where you
> have to but the byte-selector bits 1..0 not in the address register cf8,
> but rather in the data register cfc.
>=20
> The better answer is  <0x00000900 0 4>, using the third cell for the
> offset, as with IO and memory space offsets.
>=20
> Under this better interpretation, config space sizes larger than 0x100
> are no problem.  The first cell is just a selector.  The size is "added"
> to the third cell, so it does not encroach into the first cell's
> device,function bits.
>=20
> This better interpretation easily handles PCIe's 0x1000-byte extended
> config headers, and trivially accomodates even larger sizes should a
> future PCI variant further increase the header size. as described way
> down below.

That makes a lot of sense. It also mirrors parts of a discussion we
previously had when we first discussed a DT binding for Tegra PCIe.

Thanks for taking the time to go over this in so much detail. I very
much appreciate it.

> >> 	#address-cells =3D <3>;
> >> 	#size-cells =3D <2>;
> >>
> >> 	bus-range =3D <0x00 0xff>;
> >>
> >> 	ranges =3D <0x00000800 0 0          0xd4004000 0 0x00000800   /* Root
> >> port config header */
> >> 	          0x00001000 0 0          0xd4008000 0 0x00000800   /* Root
> >> port config header */
> >> 		  0x82000000 0 0xe0000000 0xe0000000 0 0x08000000   /*
> >> non-prefetchable memory */
> >> 	          0x81000000 0 0          0xe8000000 0 0x00100000>; /*
> >> downstream I/O */
> >>
> >> 	pcie@1,0 {
> >> 		device_type =3D "pci";
> >> 		reg =3D <0x0800 0 0 0 0>;
> >=20
> > Okay, this was Thierry's original idea, and it was my note that this
> > didn't seem like a good choice. I'm not wedded to that, but I'll
> > explain my reasoning a bit.
> >=20
> > Two things bothered me
> >   - Describing a CPU MMIO mapping with a config address space seems
> >     wonky
>=20
> I agree that mapping config space is sort of a jarring concept, but I
> think that's because PCs have polluted the mindspace, not because there
> is anything inherently bad about it.  The original PCI spec
> fundamentally treated config space as just another (rather segmented)
> linear address space.  It specified the cf8/cfc indirect access
> mechanism not as a deep semantic feature, but rather as an
> implementation hack to work around addressing limitations of PC chipsets
> and the addressing-deficient popular OS of the time (Windows 3.1 which
> was a veneer over DOS).  The PCI spec defined configuration mechanism #2
> as a direct map into PC I/O space.  RISC chipsets of that era (e.g.
> Alpha, Power PC) often direct-mapped config space into some form of
> load/store space.
>=20
> But PCs soon encroached on the RISC market and RISC system vendors
> started to "leverage" PC I/O chipsets.  The indirect access "config
> mechanism #1" became part of the mindset.  Indirect access was hardcoded
> in enough software that chipset designers would provide indirect access
> even if direct-mapping was possible.
>=20
> Fundamentally, a config header is just a block of registers, addressable
> as an index relative to some base.  It might require some specific
> access path - but that is true with any block of registers.  Even
> direct-mapped MMIO registers often require specific semantics such as
> non-cached, non-write-buffered, or special address space ids.
>=20
> The PCI SIG expected PCIe extended config space to be direct-mapped -
> see slide 25 of
>=20
> http://www.pcisig.com/specifications/pciexpress/technical_library/dev_con=
_09_02/specifications/pciexpress/PCIExpress_SoftwareandConfigurationModel.p=
df
>=20
> So mappability of config space was intended from the get-go.  The real
> wonky thing is the "indirect access zombie that cannot die".
>=20
> >   - Linux's OF core doesn't parse a 'reg' property under
> >     'device_type =3D "pci"' as something CPU mappable, it only looks
> >     to assigned-addresses for that. So the OF core would need to learn
> >     how to handle this case, and it would have to be well defined..
>=20
> The way I envisioned it working is that the root-complex node defines
> its own config space access functions (the "ops" argument to
> pci_scan_root_bus).  For config addresses listed in ranges, the
> functions do MMIO.  For others, they use the chipset's indirect-access
> registers.  The OF core is not involved.
>=20
> >=20
> >     Thierry's original patch avoided this problem by not using
> >     device_type =3D "pci"..

I think the OF core still needs to be involved in order to translate the
reg =3D <0x0800 0 0 0 0>; entry into a resource that can be ioremap()'ed.
As Jason already said, the OF core only does that for assigned-addresses
when device_type =3D "pci".

Otherwise the pci_ops implementation still couldn't access the MMIO
registers. Aiming for a driver-specific solution doesn't seem like a
good idea but if the functionality is common enough to be required by
two or more drivers perhaps a new helper could be created for exactly
this purpose.

Perhaps another alternative would be to extend the OF core to translate
the entries in the reg property as well. Or maybe I misunderstood what
you said.

Thierry

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRPYvHAAoJEN0jrNd/PrOhwXgQAJZpZ7D1zSt0PdfOyR9ffwUN
zojsBQtAL07dA7052830uiSDLV/QY1t1XFdvs/K1I1DDj14JbK0x/A6erR1hl1rI
McdHJj9XEYjXlVsJyWj+uOo//lsxEHzGbzYt1aZjDkS/hC7w70TQ5NTeh91jldKY
8BKXjJXV3JeNfYpPn/ZyHzP9BJ6UfEpN1po/XXDyWCMafM7eVEcAFf37YB0eQT/0
VzMoJ33NYyPWgzArkcXNJS3Z33hVrIrX4+UoYts5uI7+S3hC8GdpV3cniAdSv931
BmEl29tbn259LdgdPkTgLSsT6M4G3rSJReX+yZIz0GVA63frj9emfZmerh1aKAEo
bbRmKLv2CC+XuEgn3oO6+pu4lZOCLSXhnwKDNJdNTRXSxYMxhxqrInpN8hg9tmOX
YWh+pCdqFOmGB9QD4JrFuxriz/xenx85ZVsoFsLx5D/g2bZe0L3qLeBJLEOl9FkC
lpdB/DAW3qVsZA0uEHkGH3d5XjKrdnX/zcc9xxwYtjDd/IKhdt1L9E1kyMpCL1Qq
iSSSkKEr6hazwwHAtTY0+4CA8pf/Qz1ZX32bSMWYIhAoZctuEtgdORpzTK06DI7F
eW00YbaMSYiR4IoLuV69c903HCKzRBPuUYhdYk3P8J0wrdbhVtPlt5WRMW2/PUBP
+icOa3iANfLWXSQK5OgI
=p+wR
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
