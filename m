Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:52159 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876Ab3AaHK4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 31 Jan 2013 02:10:56 -0500
Date: Thu, 31 Jan 2013 08:10:14 +0100
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>, linux-pci@vger.kernel.org,
	Stephen Warren <swarren@wwwdotorg.org>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	linux-arm-kernel@lists.infradead.org,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP
 systems
Message-ID: <20130131071014.GA32104@avionic-0098.mockup.avionic-design.de>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130130113245.GH23505@n2100.arm.linux.org.uk>
 <20130130120344.GA29490@avionic-0098.mockup.avionic-design.de>
 <20130130150856.GJ23505@n2100.arm.linux.org.uk>
 <20130130151934.GK23505@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
In-Reply-To: <20130130151934.GK23505@n2100.arm.linux.org.uk>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 30, 2013 at 03:19:34PM +0000, Russell King - ARM Linux wrote:
> On Wed, Jan 30, 2013 at 03:08:56PM +0000, Russell King - ARM Linux wrote:
> > On Wed, Jan 30, 2013 at 01:03:44PM +0100, Thierry Reding wrote:
> > > On Wed, Jan 30, 2013 at 11:32:46AM +0000, Russell King - ARM Linux wr=
ote:
> > > > On Mon, Jan 28, 2013 at 07:56:28PM +0100, Thomas Petazzoni wrote:
> > > > > +static resource_size_t mvebu_pcie_align_resource(struct pci_dev =
*dev,
> > > > > +						 const struct resource *res,
> > > > > +						 resource_size_t start,
> > > > > +						 resource_size_t size,
> > > > > +						 resource_size_t align)
> > > > > +{
> > > > > +	if (!(res->flags & IORESOURCE_IO))
> > > > > +		return start;
> > > > > +
> > > > > +	/*
> > > > > +	 * The I/O regions must be 64K aligned, because the
> > > > > +	 * granularity of PCIe I/O address decoding windows is 64 K
> > > > > +	 */
> > > > > +	return round_up(start, SZ_64K);
> > > > > +}
> > > >=20
> > > > You do realise that this will result in all PCI I/O BARs being roun=
ded
> > > > up to 64K.
> > > >=20
> > > > I've just been digging through the PCI code and have come across a
> > > > function - pcibios_window_alignment() - which the PCI code allows t=
o be
> > > > overriden which allows you to increase the alignment requirement of
> > > > bridge windows.  It takes the PCI bus and window type as arguments.
> > > >=20
> > > > I'd suggest using that, and checking whether the bus which is passed
> > > > corresponds with a bus which gives you problems, so that you don't
> > > > impose the 64K requirement on downstream bridges.
> > >=20
> > > That approach isn't going to work very well with multi-platform, thou=
gh,
> > > since the function can only be overridden on a per-architecture basis.
> >=20
> > The same can be said of all the various other functions which the PCI
> > stuff expects the arch to provide, yet we seem to cope just fine...
>=20
> And this (untested) is how it's done:
>=20
>  arch/arm/include/asm/mach/pci.h |    1 +
>  arch/arm/kernel/bios32.c        |    8 ++++++++
>  2 files changed, 9 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/=
pci.h
> index db9fedb..bba0cf3 100644
> --- a/arch/arm/include/asm/mach/pci.h
> +++ b/arch/arm/include/asm/mach/pci.h
> @@ -29,6 +29,7 @@ struct hw_pci {
>  	void		(*postinit)(void);
>  	u8		(*swizzle)(struct pci_dev *dev, u8 *pin);
>  	int		(*map_irq)(const struct pci_dev *dev, u8 slot, u8 pin);
> +	resource_size_t	(*window_align)(struct pci_bus *, unsigned long);
>  };
> =20
>  /*
> diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
> index 379cf32..32c3bd9 100644
> --- a/arch/arm/kernel/bios32.c
> +++ b/arch/arm/kernel/bios32.c
> @@ -581,6 +581,14 @@ resource_size_t pcibios_align_resource(void *data, c=
onst struct resource *res,
>  	return start;
>  }
> =20
> +resource_size_t pcibios_window_alignment(struct pci_bus *bus,
> +					 unsigned long type)
> +{
> +	struct pci_sys_data *sys =3D bus->sysdata;
> +
> +	return sys->window_alignment ? sys->window_alignment(bus, type) : 1;
> +}
> +
>  /**
>   * pcibios_enable_device - Enable I/O and memory.
>   * @dev: PCI device to be enabled

Yes, something like that'll work. I had been under the impression that
what you proposed was overriding pcibios_window_alignment() for Marvell
only.

Thierry

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRChjWAAoJEN0jrNd/PrOhpaIQAJ0zbj/DikaxsSeUmmq2ar69
u4blH8zhGZcJ6aN5STNbB8+fyaoaXpRjIcPcLQGIcPvUIAbBGTdgSDTsuHpH0TIo
KW3kvXEuUE+ZFEZHGioxAKW8L5aV6UQxVdf5MWJdcyBLrTX5EK5iUUj9YP2+Kaf+
Vr6GD8QY+gXvDfalcoN7fWci/YoKAg3gUESxav7bmWahFQXu1Pu0IBwKbbnnUVqv
A52uPZfvqs9HOv3bxgRUgP2nq+44LRqpbOWpVau21rkleCIXmuuEc1rgkXDtJe5U
DH/B7X/rbCYXPewM3ghbmAuqcGgjkZhGpnM3hO/m5VSh3kFdxEbHKzhnf2iiLic1
Mccvs/+hjq7syZwNiZ8EJaHz0Y2BupBX+6JjMvCNZ5XxVeaXPLW9cK0hxraTDaE+
rWmGJsEYU5gy2DamOdNv17e+0kHy5oI1IDz5UVoVBKah3hJuUv+HanVyBNJBMsDJ
ds0sTSOKPMavZuhVRRj7C1GMKTz6vNNh4iFu9GFvGQJ4QAyllidF1cDzpP29nfI4
A3l7MZSEtt2u4IbiKIe9HLV281ecJS3THCRW1EvHPaJ4j51fEn3i5VsM8sdqZRWi
M4zLd9sR/2+mr4cZooawKQ69+aHEoWeN+sz06ZPVBw/fZPvCG3i2df9+Jk6Ooc2S
+8Voc2q5OA25tGCqT3He
=9jyc
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
