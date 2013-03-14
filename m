Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:61660 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753028Ab3CNVh6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 14 Mar 2013 17:37:58 -0400
Date: Thu, 14 Mar 2013 22:37:41 +0100
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Mitch Bradley <wmb@firmworks.com>, linux-pci@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
Message-ID: <20130314213741.GA17186@avionic-0098.mockup.avionic-design.de>
References: <20130313081815.GD25940@avionic-0098.mockup.avionic-design.de>
 <20130313170205.GB24042@obsidianresearch.com>
 <20130313192628.GA28714@avionic-0098.mockup.avionic-design.de>
 <5140E85A.3040900@firmworks.com>
 <20130313220235.GA29895@avionic-0098.mockup.avionic-design.de>
 <20130313222102.GA28336@obsidianresearch.com>
 <20130314090120.GA2224@avionic-0098.mockup.avionic-design.de>
 <20130314172555.GA14048@obsidianresearch.com>
 <20130314210926.GA9098@avionic-0098.mockup.avionic-design.de>
 <20130314212921.GB18505@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
In-Reply-To: <20130314212921.GB18505@obsidianresearch.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2013 at 03:29:21PM -0600, Jason Gunthorpe wrote:
> On Thu, Mar 14, 2013 at 10:09:26PM +0100, Thierry Reding wrote:
>=20
> > > ranges =3D <0x82000000 0 0x80000000  0x80000000  0 0x00001000   /* po=
rt 0 registers */
> > > 	  0x82000000 0 0x80001000  0x80001000  0 0x00001000   /* port 1 regi=
sters */
> > > 	  0x81000000 0          0  0x82000000  0 0x00010000   /* downstream =
I/O */
> > > 	  0x82000000 0 0xa0000000  0xa0000000  0 0x10000000   /* non-prefetc=
hable memory */
> > > 	  0xc2000000 0 0xb0000000  0xb0000000  0 0x10000000>; /* prefetchabl=
e memory */
> > >=20
> > > Which says 'access to CPU address 0xa0000000 produces a PCI-E memory =
TLP with
> > > address 0xa0000000' - this is the 'normal' case, I assume that is what
> > > happens on tegra?
> > >=20
> > > It also says 'access to CPU address 0x82000000 produces a PCI-E IO TLP
> > > with address 0' - this translation is something Linux typically
> > > expects..
> >=20
> > Both of the above paragraphs are true. However accesses to the windows
> > at 0x80000000 and 0x80001000 don't generate memory TLPs but type 0
> > configuration space TLPs.
>=20
> By my understanding access to 0x80000000/0x80001000 doesn't generate
> any externally visible TLPs?

Now that you mention it, that's probably correct, yes.

> IHMO modeling this register space as a controller-internal MMIO region
> associated with the bridge is reasonable... After all, you are
> iomapping it and accessing it with readl/writel - those are MMIO
> functions..

Yes, I think that'd be okay.

Thierry

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRQkMlAAoJEN0jrNd/PrOh7DIP/i6GYJv4Kt+ubdF6DYCvWzIj
6TJ9XCcrrVD6uU4MJRNuFnve/CRduMzH9J1M9hgBDDIxA2QB7SrSMV+6cYOg4fz0
4g689oTDv4SgoZWiQ9BsA/aluzlR1nfWcd0IGOz0VppcWZ9t0o8EJ6UH4y7d0VEw
1qPDdvdxDZgKMLPUfKdZziI+EAwTQrdj5cvujNXSw7MLZAxtRhRCQxc/9CbuB4xa
cNd8w867fkzVuWBEQs/zc2ATUBIJZKmCKwCjpNzDnQV4bc2GNSRojrc/gKeHpwfH
/bmtjuoy5aTxN8F3VWJ/Id33jYZH2U9k+Zq5YZ2L1RKSOYBjdFWxe7iHkb8VVLFW
pShQcMV2izYEpdTxpHMwueda1g4QRz4rN6tel97B1Xpc5VeRUFlrP4GdSIDE4Nii
jt3ndeV49xEouiE/urjH2jp45HpljpwiRwIu2bIoKY74sZtRwkFNuVDV8W2ZfDdh
7MnaMLIMkBUAOuLS+0k7mhaEfQyRQzrTP0NbINUgMxXV5DbGxZXlYBa+Jnn8TdRl
sDQlTCqGOlEjtgpKT0XywWNbYwXwV5UyKVCleiEiInDnaPR+NtDsAJRpc2Ym9Xr8
fHqgE+pfqasX/bXMyAaTp6t+Mau8+Nd6Yzbue8Cl/58dA+3us09KEgVvqNx9a5+r
zBnOCiE+Xi5MYJBDly/p
=ZtWA
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
