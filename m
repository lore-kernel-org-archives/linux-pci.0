Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:59421 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751380Ab3A2JUO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Jan 2013 04:20:14 -0500
Date: Tue, 29 Jan 2013 10:20:06 +0100
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>, linux-pci@vger.kernel.org,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	linux-arm-kernel@lists.infradead.org,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP
 systems
Message-ID: <20130129092006.GA16377@avionic-0098.mockup.avionic-design.de>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com>
 <5106F9F9.3010905@wwwdotorg.org>
 <20130129094143.1aad9377@skate>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
In-Reply-To: <20130129094143.1aad9377@skate>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 29, 2013 at 09:41:43AM +0100, Thomas Petazzoni wrote:
> On Mon, 28 Jan 2013 15:21:45 -0700, Stephen Warren wrote:
[...]
> > > +static int mvebu_pcie_init(void)
> > > +{
> > > +	return platform_driver_probe(&mvebu_pcie_driver,
> > > +				     mvebu_pcie_probe);
> > > +}
> > > +
> > > +subsys_initcall(mvebu_pcie_init);
> >=20
> > Why isn't that just platform_driver_register()?
>=20
> I didn't test recently, but with my first version of the patch set,
> having an initialization as late as module_init() was too late. Some
> PCI fixup code was being executed *before* we get the opportunity of
> initializing the PCI driver, and it was crashing the kernel. I can
> provide more details if you want.

Does this patch perhaps fix this crash?

	http://patchwork.ozlabs.org/patch/210870/

Thierry

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRB5RGAAoJEN0jrNd/PrOhZ1wP/iAzonUlnV0f0QurbERD+i+s
iPJxxp2Bd+3ICYuj6Orpi2UL9zYsobLs1hPiVxvl42nqgzoPyw/ay4MWgiGtup+H
O32gASOv0AZDya6XnYC/4Ab31MQLW25oc6Zy1XHbikl9hpRdYB70j8Qzow2VMl1l
zMm44tZ20ujPpPPt7u+AyaGj6+wVbI9pfd+h7CUAYLH57Cw77pB1W3NbNi9jNSvM
njRxy2kMTKejZfVXCx5pSADBkYtpl7ICqQlXkl/ieEA/cP4tpP0szUWkUy+xVY9t
ggcwedlBQN1N18IqW1dbLQkEPjlx6ppS74NtCVC4vSwm+UsVXdRqAmD3mmU6ZgMG
1S0LyQlXxBJOCMi99v1IT0zEO0HyXgXKjPFIFKQ7akY1haNy7oWIjxs3XbxjGGAD
dxeuddp2jKh5532cf4XJwCHq4GIcgMxxVdH2vhQpX4J81RLkEalCrl4FYotimaRB
uEWClmC8nLRWDMQsna1+qx27BCbv+LqOP2GEfHcuBq1gSVuM0iYu25YBXAQ9MXCs
EYGvty1/r35vbNx/FP1sUWcsvJkFv0SFg8EOdhOhPtQOGNyZh9WzzzXoB3Mv2FBZ
kTIceMWHDYXdm+/BUnOECRn5X7vYw46/ZE+UfU50PgRyAqowUgRt+Et4w6d6n851
VSdImx2fJ6UEGr1MvEck
=B8ux
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
