Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:52623 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751760Ab3A3MEg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 30 Jan 2013 07:04:36 -0500
Date: Wed, 30 Jan 2013 13:03:44 +0100
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
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
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP
 systems
Message-ID: <20130130120344.GA29490@avionic-0098.mockup.avionic-design.de>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130130113245.GH23505@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
In-Reply-To: <20130130113245.GH23505@n2100.arm.linux.org.uk>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 30, 2013 at 11:32:46AM +0000, Russell King - ARM Linux wrote:
> On Mon, Jan 28, 2013 at 07:56:28PM +0100, Thomas Petazzoni wrote:
> > +static resource_size_t mvebu_pcie_align_resource(struct pci_dev *dev,
> > +						 const struct resource *res,
> > +						 resource_size_t start,
> > +						 resource_size_t size,
> > +						 resource_size_t align)
> > +{
> > +	if (!(res->flags & IORESOURCE_IO))
> > +		return start;
> > +
> > +	/*
> > +	 * The I/O regions must be 64K aligned, because the
> > +	 * granularity of PCIe I/O address decoding windows is 64 K
> > +	 */
> > +	return round_up(start, SZ_64K);
> > +}
>=20
> You do realise that this will result in all PCI I/O BARs being rounded
> up to 64K.
>=20
> I've just been digging through the PCI code and have come across a
> function - pcibios_window_alignment() - which the PCI code allows to be
> overriden which allows you to increase the alignment requirement of
> bridge windows.  It takes the PCI bus and window type as arguments.
>=20
> I'd suggest using that, and checking whether the bus which is passed
> corresponds with a bus which gives you problems, so that you don't
> impose the 64K requirement on downstream bridges.

That approach isn't going to work very well with multi-platform, though,
since the function can only be overridden on a per-architecture basis.

Thierry

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRCQwgAAoJEN0jrNd/PrOhoWsP/i4M5pFfcp03m/r4o92cIaoZ
qIHBb+X2NFvZo9VQKcxZIc3XYJjVnD1LFoIYPBatQHsjVanop9xgqNDTIfy2idmh
POW7yH2Jqj4kMWyzDYHW012AlxXhc4z5biViLA+qbYBvitMgXyIPg5XR597xr8MH
WzsHzEP2sNY5VD6OnWJZKjYPwh99DInU1QxDhwhDxhDCt0iPPu1Z0qoRtcmZ76O5
NcKIfp95uakXcQbzRMayGHv7GuMWCNvKL81AMOSfKMDqKS5eQxXsVSeiBJnTvuv5
I8AJMYBtpgIKscPyBdjeeVVAMGZsfn8tFMvSLi8O7Zyhbe0tgnH922ItczA04irp
7NmUFA5QF3D5Bf911fa4Eh6mEVoq0V3ArkpDac1hNXN7BCBtgDYXKk1XOU8uQR6e
+Yz4Ig36s3Om0hFkMjwPjAN8KXuw54Wqz4fQ/WkhIrmaMCUOqX/JGCYzjcNJOiqV
3KfaX0ovpOF/xxoLMtV6LSJlwyMfvkyTwCfuG/P1AxOIcxqzvfdqy03YxDPWMMXV
u8B8ZeMFSSIvF/TTYZsg99HLEM7ZQLYMgth1rRMlxjKdUiKyE7XoHNEO5RKZ8Vv4
669UjcFJgAAsaB7UoWLoXbJnSb///SwFS5UOxuXDnQYEWLuedkbscpIihI74LxwN
QgJTwjuMp8OOzx6UOc0B
=uoDD
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
