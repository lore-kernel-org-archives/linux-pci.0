Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:64987 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750849Ab2FLGld (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jun 2012 02:41:33 -0400
Date: Tue, 12 Jun 2012 08:41:24 +0200
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: linux-tegra@vger.kernel.org,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v2 05/10] ARM: tegra: Rewrite PCIe support as a driver
Message-ID: <20120612064124.GF4040@avionic-0098.adnet.avionic-design.de>
References: <1339427118-32263-1-git-send-email-thierry.reding@avionic-design.de>
 <1339427118-32263-6-git-send-email-thierry.reding@avionic-design.de>
 <4FD65E98.4070200@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aPdhxNJGSeOG9wFI"
In-Reply-To: <4FD65E98.4070200@wwwdotorg.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--aPdhxNJGSeOG9wFI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Stephen Warren wrote:
> On 06/11/2012 09:05 AM, Thierry Reding wrote:
> > This commit adds a platform device driver for the PCIe controller on
> > Tegra SOCs. Current users of the old code (TrimSlice and Harmony) are
> > converted and now initialize and register a corresponding platform
> > device.
>=20
> > diff --git a/arch/arm/mach-tegra/devices.c b/arch/arm/mach-tegra/device=
s.c
>=20
> > +static struct resource tegra_pcie_resources[] =3D {
> > +	[0] =3D {
> > +		.start =3D TEGRA_PCIE_BASE,
> > +		.end =3D TEGRA_PCIE_BASE + TEGRA_PCIE_SIZE - 1,
> > +		.flags =3D IORESOURCE_MEM,
> > +	},
> > +	[1] =3D {
> > +		.start =3D TEGRA_PCIE_MMIO_BASE,
> > +		.end =3D TEGRA_PCIE_MMIO_BASE + TEGRA_PCIE_MMIO_SIZE - 1,
> > +		.flags =3D IORESOURCE_MEM,
> > +	},
> > +	[2] =3D {
> > +		.start =3D INT_PCIE_INTR,
> > +		.end =3D INT_PCIE_INTR,
> > +		.flags =3D IORESOURCE_IRQ,
> > +	},
> > +};
>=20
> I'm not sure those resources either cover all the necessary regions, nor
> are as fine-grained as they should be ...
>=20
> In particular, in pcie.c, I see separate afi_writel() and pads_writel()
> implying those are separate regions.
>=20
> Also, I see the following hard-code specific addresses, and are still
> used by the driver after conversion:
>=20
> > #define MEM_BASE_0              (TEGRA_PCIE_BASE + SZ_256M)
> > #define MEM_SIZE_0              SZ_128M
> > #define MEM_BASE_1              (MEM_BASE_0 + MEM_SIZE_0)
> > #define MEM_SIZE_1              SZ_128M
> > #define PREFETCH_MEM_BASE_0     (MEM_BASE_1 + MEM_SIZE_1)
> > #define PREFETCH_MEM_SIZE_0     SZ_128M
> > #define PREFETCH_MEM_BASE_1     (PREFETCH_MEM_BASE_0 + PREFETCH_MEM_SIZ=
E_0)
> > #define PREFETCH_MEM_SIZE_1     SZ_128M
>=20
> Also, there's a comment describing the register layout in terms of a
> number of separate regions:
>=20
> > /*
> >  * Tegra2 defines 1GB in the AXI address map for PCIe.
> >  *
> >  * That address space is split into different regions, with sizes and
> >  * offsets as follows:
> >  *
> >  * 0x80000000 - 0x80003fff - PCI controller registers
> >  * 0x80004000 - 0x80103fff - PCI configuration space
> >  * 0x80104000 - 0x80203fff - PCI extended configuration space
> >  * 0x80203fff - 0x803fffff - unused
> >  * 0x80400000 - 0x8040ffff - downstream IO
> >  * 0x80410000 - 0x8fffffff - unused
> >  * 0x90000000 - 0x9fffffff - non-prefetchable memory
> >  * 0xa0000000 - 0xbfffffff - prefetchable memory
> >  */
>=20
> (the latter 2 regions at least being also split in half for each of the
> 2 host ports)

I was thinking that maybe each port should be represented as a child node,
but I'm not sure that's going to work too well because the children of the
pci node are supposed to be PCI busses/devices. I'll have to check whether
they could just as well be children of the PCIe port nodes.

That way each port could get an own set of register ranges to better descri=
be
the actual layout. AFAICT the even partitioning of the non-prefetchable and
prefetchable memory regions is arbitrary and it could potentially be useful
to make it configurable via the DT.

> Shouldn't each of these regions be a separate entry in the platform
> device resources.
>=20
> This perhaps isn't that relevant for Tegra20 alone, but Tegra30 supports
> 3 host ports instead of 2 (hence I presume alters the internal layout of
> the 1G chunk of physical memory space allocated to PCIe), and moves the
> PCIe area from 2G..3G to 0G..1G (so invalidates the hard-coded
> *_MEM_BASE_* above).

> That said, I'm not sure whether Tegra20's and Tegra30's PCIe controllers
> are similar enough to make a shared driver worthwhile/possible.
> (Although our downstream Android driver appears to handle both with a
> very small number of ifdefs).

> If they are similar, then I think my comments above should be addressed.
> If they are not similar, then I think you can just have a single 1G
> memory region in the resources, and split it up internally, rather than
> needing separate resources for different parts of the address space.

Unfortunately the PCIe controller is very badly documented in the TRM, so
this information is hard to locate (I guess the best source is one of the
downstream drivers).

Last time I looked they seemed to be simple enough to handle the differences
using OF compatible matches. I believe apart from the PCIe area changes the=
re
were some differences in how the MSI were setup.

> While we can easily fix this kind of driver internals so this doesn't
> seem like a big deal, this kind of change would impact the device tree
> binding, so it seems that we need to sort it out before DT conversion.

Yes, we should at least try to get it right from the start.

Thierry

--aPdhxNJGSeOG9wFI
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk/W5JQACgkQZ+BJyKLjJp9V8gCfZhamwbl7UIoVzjYbQYb0uxHr
le4An12nMqcLyH2E+dqSb54JkR8yIqgU
=rlDf
-----END PGP SIGNATURE-----

--aPdhxNJGSeOG9wFI--
