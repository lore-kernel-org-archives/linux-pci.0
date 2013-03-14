Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:54751 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752294Ab3CNJCv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 14 Mar 2013 05:02:51 -0400
Date: Thu, 14 Mar 2013 10:01:20 +0100
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
Message-ID: <20130314090120.GA2224@avionic-0098.mockup.avionic-design.de>
References: <20130312203819.GA23221@avionic-0098.mockup.avionic-design.de>
 <20130312210328.GA22702@obsidianresearch.com>
 <20130312213006.GA23717@avionic-0098.mockup.avionic-design.de>
 <20130312220854.GA23112@obsidianresearch.com>
 <20130313081815.GD25940@avionic-0098.mockup.avionic-design.de>
 <20130313170205.GB24042@obsidianresearch.com>
 <20130313192628.GA28714@avionic-0098.mockup.avionic-design.de>
 <5140E85A.3040900@firmworks.com>
 <20130313220235.GA29895@avionic-0098.mockup.avionic-design.de>
 <20130313222102.GA28336@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
In-Reply-To: <20130313222102.GA28336@obsidianresearch.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2013 at 04:21:02PM -0600, Jason Gunthorpe wrote:
> On Wed, Mar 13, 2013 at 11:02:35PM +0100, Thierry Reding wrote:
> =20
> > Does that look about correct?
>=20
> By my reading of the spec the entries in ranges should not
> have the b,d,f bits set..
>=20
> Although it is not a big stretch to include them..
>=20
> > Now the code will actually match the first entry and assume that it
> > represents the non-prefetchable 32-bit memory space and program the
> > controller to forward accesses to the 0x80000000-0x80000fff region
> > as PCI memory write transactions.
>=20
> Yah, it makes a mess of determining the host bridge aperture. Require
> the aperture to be first/last?
>=20
> Make use of the 2nd dword?
>=20
> Go back to the idea of the top level reg?

It turns out that this works with the Tegra driver because it uses the
new of_pci_process_ranges() function and simply overwrites earlier
matches by subsequent ones.

	ranges =3D <0x82000000 0 0 0x80000000 0 0x00001000   /* port 0 registers */
		  0x82000000 0 0 0x80001000 0 0x00001000   /* port 1 registers */
		  0x81000000 0 0 0x82000000 0 0x00010000   /* downstream I/O */
		  0x82000000 0 0 0xa0000000 0 0x10000000   /* non-prefetchable memory */
		  0xc2000000 0 0 0xb0000000 0 0x10000000>; /* prefetchable memory */

So the second entry would overwrite the non-prefetchable memory region
as established by the first entry. Finally that will also be overwritten
by the fourth entry.

So the above will actually work along with the corresponding root-port
"assigned-addresses" properties. I still don't like it much because I
don't think it accurately reflects the hardware. Furthermore it has the
same kludgy, non-spec conformant smack that my original proposal had
because it uses assigned-addresses for something it wasn't intended to.
Also the mapping is actually not correct, because the first two entries
don't refer to 32-bit memory space. They really map configuration space
and therefore the ss field is wrong IMO (it should be 00, but that won't
work with the OF core). One of the very early versions of my Tegra PCIe
patch series actually introduced an IORESOURCE_CS type to account for
this but it didn't go anywhere and became obsolete when I switched to
the new binding which side-steps this issue by not using the PCI bus'
translation mechanism.

Thierry

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRQZHgAAoJEN0jrNd/PrOhJ+cP+wYhgW6TV6RRi1LeCwj8aSG2
ko3qcYg3qm/HmzygMyRMwhEfWx8oizT6TdbmlkrSTpbEBXxd5lS8ZydmX2p7uRLe
3jOcQXW+cy21fmSLfMbhbWrkAXsCcTRO4mchJYRJzzfJTgf3Fxo5RvLXZBFMw4Jn
5TjUEShQX3M/6DomvEDyMbQV4SDh97AcRnbJQjfGfdRVCzcM0wy5L6hr35dW1Jb+
Iemn9fIiyJcNaPpbkIClHX03TfQBkUJ9N2oQ6M1rg7M1GbSypbFPmFFSc6H6Kond
Z7qWC726VBRXAoIk0l1K/J1Afq8easpwX/xV7+XZlkzd7hXbuF7LHbFkL0qqGgoJ
Gq7GVBZy/DkOir4qSMVXFCpHJYqk2gtrrjBUSiJBFG59dECyf6kwLEROuNaxFNMo
xA9W46roZJFwE61EcQfPRYjkctaHL65a0kShx1fEhqd1kQYcvn82g2WkuzSoVQ4N
xWMTHQhP6JOc24xqPb0X+a3/Yt94mY7DpOWmhg5kfVmH24gGsnIPjOSbg/EtvrW/
IZzOLerGelU8xOVwebCjh2v+HarklCstlAzaGHeu848u8ts4HjA6rJPwUSK91KVx
ILO/AKquEGTfNHy8MlfeXoAY7RJe7I1MiDtxWxT4gla57/4+Z8kwjwXHpywWZr19
F9Nv/aqbVzFbrQ8HiXHM
=FBlS
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
